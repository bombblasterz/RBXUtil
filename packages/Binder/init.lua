-- finobinos
-- init.lua
-- 27 November 2021

--[[
	-- Static methods:

	Binder.new(binderName : string, class : table) --> Binder
	Binder.IsA(self : any) --> boolean
	Binder.GetBinder(binderName : string) --> Binder

	-- Static members:

	Binder.OnBinderCreated : Signal <binder : Binder>
	Binder.OnBinderDestroyed : Signal <binderName : string>

	-- Instance members:

	Binder.OnObjectCreated : Signal <object : table>
	Binder.OnObjectDestroyed : Signal <>
	Binder.Objects : table
]]

local Binder = { _binders = {} }
Binder.__index = Binder

local RunService = game:GetService("RunService")
local CollectionService = game:GetService("CollectionService")

local Signal = require(script.Parent.Signal)
local Maid = require(script.Parent.Maid)
local Promise = require(script.Parent.Promise)
local Remote = require(script.Parent.Remote)
local CommunicationSignal = Remote.Server.CommunicationSignal
local ClientCommunicationSignal = Remote.Client.ClientCommunicationSignal

local LocalConstants = {
	ErrorMessages = {
		InvalidArgument = "Invalid argument#%d to %s: expected %s, got %s",
	},

	ClassTemplate = {
		new = "function",
		Destroy = "function",
		Tag = "string",
	},

	LifecycleMethods = {
		PostSimulationUpdate = RunService.Heartbeat,
		PreSimulationUpdate = RunService.Stepped,
		PreRenderUpdate = RunService.BindToRenderStep,
	},

	BinderRetrievalTimeout = 5,
}

Binder.OnBinderCreated = Signal.new()
Binder.OnBinderDestroyed = Signal.new()

function Binder.new(binderName, class)
	assert(
		typeof(binderName) == "string",
		LocalConstants.ErrorMessages.InvalidArgument:format(1, "Binder.new", "string", typeof(binderName))
	)

	assert(
		typeof(class) == "table",
		LocalConstants.ErrorMessages.InvalidArgument:format(2, "Binder.new", "table", typeof(class))
	)

	for key, valueType in pairs(LocalConstants.ClassTemplate) do
		assert(
			typeof(class[key]) == valueType,
			('Class "%s" must have member "%s" of type: %s'):format(binderName, key, valueType)
		)
	end

	local self = setmetatable({
		Name = binderName,
		Tag = class.Tag,
		Objects = {},
		OnObjectCreated = Signal.new(),
		OnObjectDestroyed = Signal.new(),
		_class = class,
		_maid = Maid.new(),
		_lifecycleMaid = Maid.new(),
		_isLifecycleStarted = false,
	}, Binder)

	task.spawn(self._init, self)

	return self
end

function Binder.IsA(self)
	return getmetatable(self) == Binder
end

function Binder.RegisterBindersIn(folder)
	assert(
		typeof(folder) == "Instance" and folder:IsA("Folder"),
		LocalConstants.ErrorMessages.InvalidArgument:format(1, "Binder.RegisterBindersIn", "Folder", typeof(folder))
	)

	for _, binder in ipairs(folder:GetChildren()) do
		if not binder:IsA("ModuleScript") then
			if binder:IsA("Folder") then
				Binder.RegisterBindersIn(binder)
			end

			continue
		end

		Binder.new(binder.Name, require(binder))
	end
end

function Binder.GetBinder(binderName)
	assert(
		typeof(binderName) == "string",
		LocalConstants.ErrorMessages.InvalidArgument:format(1, "Binder.GetBinder", "string", typeof(binderName))
	)

	local binder = Binder._binders[binderName]
	assert(binder, ('Binder "%s" was not found'):format(binderName))

	return binder
end

function Binder._getBinder(binderName)
	return Promise.new(function(resolve, reject)
		local binder = Binder._binders[binderName]

		if binder then
			resolve(binder)
			return
		end

		local onBinderAddedConnection
		onBinderAddedConnection = Binder.OnBinderCreated:Connect(function(newBinder)
			if newBinder.Name == binderName then
				resolve(newBinder)
				onBinderAddedConnection:Disconnect()
			end
		end)

		task.delay(LocalConstants.BinderRetrievalTimeout, function()
			if not onBinderAddedConnection:IsConnected() then
				return
			end

			reject(('Required binder "%s" was not found'):format(binderName))
		end)
	end)
end

function Binder:Destroy()
	self._maid:Destroy()
end

function Binder:_init()
	local class = self._class
	class.Binder = self

	if RunService:IsClient() then
		if typeof(class.RequiredServersideBinders) == "table" then
			self:_injectRequiredServersideBinders()
		end
	else
		if typeof(class.Client) == "table" then
			self:_dispatchToClient()
		end
	end

	if typeof(class.RequiredBinders) == "table" then
		self:_injectRequiredBinders()
	end

	self.OnObjectCreated:Connect(function()
		if self._isLifecycleStarted then
			return
		end

		self:_startLifecycle()
	end)

	self.OnObjectDestroyed:Connect(function()
		if not self._isLifecycleStarted then
			return
		end

		self._isLifecycleStarted = false
		self._lifecycleMaid:Cleanup()
	end)

	for _, instance in ipairs(CollectionService:GetTagged(self.Tag)) do
		self:_instanceAdded(instance)
	end

	self._maid:AddTask(CollectionService:GetInstanceAddedSignal(self.Tag):Connect(function(instance)
		self:_instanceAdded(instance)
	end))

	self._maid:AddTask(CollectionService:GetInstanceRemovedSignal(self.Tag):Connect(function(instance)
		self:_instanceRemoved(instance)
	end))

	Binder._binders[self.Name] = self
	Binder.OnBinderCreated:Fire(self)

	self._maid:AddTask(function()
		-- Clear out all references:
		class.Server = nil
		class.Binders = nil
		class.Binder = nil
		Binder._binders[self.Name] = nil

		for key, _ in pairs(self) do
			self[key] = nil
		end

		setmetatable(self, nil)
	end)
	self._maid:AddTask(self.OnObjectCreated)
	self._maid:AddTask(self.OnBinderDestroyed)
	self._maid:AddTask(self._lifecycleMaid)
end

function Binder:_instanceAdded(instance)
	local class = self._class
	local object = class.new(instance)

	-- If the constructor method didn't return a table, then don't do any more work as
	-- this is an indication that the creation of the object should be cancelled:
	if typeof(object) ~= "table" then
		return
	end

	object.Instance = instance

	if typeof(object.Start) == "function" then
		object:Start()
	end

	self.Objects[instance] = object
	self.OnObjectCreated:Fire(object)
end

function Binder:_instanceRemoved(instance)
	local object = self.Objects[instance]

	if not object then
		return
	end

	if typeof(object.Stop) == "function" then
		object:Stop()
	end

	object:Destroy()
	object.Instance = nil
	self.Objects[instance] = nil
	self.OnObjectDestroyed:Fire()
end

function Binder:_startLifecycle()
	local class = self._class

	local function UpdateObjects(methodName, ...)
		for _, object in pairs(self.Objects) do
			object[methodName](object, ...)
		end
	end

	local function StartUpdate(methodName, updateSignal)
		if updateSignal == RunService.BindToRenderStep then
			local name = tostring(self)
			local renderPriority = class.RenderPriority or Enum.RenderPriority.Last.Value

			RunService:BindToRenderStep(name, renderPriority, function(...)
				UpdateObjects(methodName, ...)
			end)

			self._lifecycleMaid:AddTask(function()
				RunService:UnbindFromRenderStep(name)
			end)
		else
			self._lifecycleMaid:AddTask(updateSignal:Connect(function(...)
				UpdateObjects(methodName, ...)
			end))
		end
	end

	for methodName, updateSignal in pairs(LocalConstants.LifecycleMethods) do
		if typeof(class[methodName]) == "function" then
			StartUpdate(methodName, updateSignal)
		end
	end

	self._isLifecycleStarted = true
end

function Binder:_injectRequiredBinders()
	local class = self._class
	class.Binders = {}

	for _, binderName in ipairs(class.RequiredBinders) do
		local wasSuccessfull, response = Binder._getBinder(binderName):await()
		assert(wasSuccessfull, response)

		class.InjectedBinders[binderName] = response
	end
end

function Binder:_dispatchToClient()
	local communicationSignal = CommunicationSignal.new(self.Name)

	for key, value in pairs(self._class.Client) do
		-- Pass in the stringified key in order to successfully bind it with its value to the communication signal:
		communicationSignal:Bind(tostring(key), value)
	end

	communicationSignal:DispatchToClient()
end

function Binder:_injectRequiredServersideBinders()
	local class = self._class
	class.Server = {}

	-- Inject all serverside binders:
	for _, serversideBinderName in ipairs(class.RequiredServersideBinders) do
		local wasSuccessfull, dispatchedCommunicationSignal =
			ClientCommunicationSignal.GetDispatchedCommunicationSignal(
				serversideBinderName
			):await()

		assert(wasSuccessfull, ('Required serverside binder "%s" was not found'):format(serversideBinderName))
		class.Server[serversideBinderName] = dispatchedCommunicationSignal:Build()
	end
end

return Binder
