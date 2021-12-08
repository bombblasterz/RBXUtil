-- finobinos
-- RemoteProperty.lua
-- 17 October 2021

--[[
	-- Static methods:

    RemoteProperty.IsA(self : any) --> boolean
    RemoteProperty.new(value : any, clientValueSetValidatorCallback : function ?) --> RemoteProperty 

    -- Instance members:

    RemoteProperty.OnValueUpdate : Signal <newValue : any>
	RemoteProperty.OnClientValueUpdate : Signal <client : Player, newValue : any>

	-- Instance methods:

	RemoteProperty:IsBoundToClient() --> boolean
    RemoteProperty:GetValue(client : Player ?) --> any 
	RemoteProperty:SetValue(value : any, specificClients : table ?) --> () 
	RemoteProperty:Destroy() --> () 
]]

--[=[
	@class RemoteProperty
	@server

	Remote properties are powerful serverside objects  which contain getter and setter methods and
	store a value which can be retrieved by those methods, and are also an abstraction of remote functions which
	can also be exposed to the client through communication signals. 

	For e.g:

	```lua
	-- On the server
	local remoteProperty = RemoteProperty.new(50)

	-- On the client:
	local remoteProperty = ...
	print(remoteProperty:GetValue()) --> 50
	```
	:::note
	Remote function limitations and behavior edge cases apply. For more information, see [Remote Functions and Events](https://developer.roblox.com/en-us/articles/Remote-Functions-and-Events).
	:::
]=]

--[=[
	@prop OnValueUpdate Signal <newValue: any>
	@within RemoteProperty
	@tag RemoteProperty
	@readonly

	A signal which is fired whenever the value stored in the remote property is updated to a new one.

	```lua
	remoteProperty.OnValueUpdate:Connect(function(newValue)
		print(("Value was updated to %s"):format(tostring(newValue)))
	end)
	```
]=]

--[=[
	@prop OnClientValueUpdate Signal <client: Player, newValue: any>
	@within RemoteProperty
	@tag RemoteProperty
	@readonly

	A signal which is fired whenever the value of a client is updated to a new one. This signal should not be used
	if the remote property is not bound to the client.

	```lua
	remoteProperty.OnClientValueUpdate:Connect(function(client, newValue)
		print(("%s's value was updated to %s"):format(client.Name, tostring(newValue)))
	end)
	```
]=]

local RemoteProperty = {}
RemoteProperty.__index = RemoteProperty

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

local remoteFolder = script.Parent.Parent
local dependencies = remoteFolder.Parent

local Signal = require(dependencies.Signal)
local Maid = require(dependencies.Maid)
local TableUtil = require(dependencies.TableUtil)
local SharedConstants = require(remoteFolder.SharedConstants)

--[=[
	@param self any
	@return boolean

	A method which returns a boolean indicating if `self` is a remote property or not.
]=]

function RemoteProperty.IsA(self)
	return getmetatable(self) == RemoteProperty
end

--[=[
	@param initialValue any
	@param clientValueSetValidatorCallback function ?
	@return RemoteProperty

	Creates and returns a new remote property, with the initial value of the remote property being `initialValue`.
	
	`clientValueSetValidatorCallback` can be a function which will be called when a client requests 
	to set their value to something they desire, _if this remote property is bound to the client_. For e.g:

	```lua
	-- On the server
	local remoteProperty = RemoteProperty.new(50, function(client, valueTheyWantToSet)
		if IsValueValid(valueTheyWantToSet) then
			return true
		end
	end)

	-- On the client:
	local clientRemoteProperty = ...

	-- This will request the remote property to set the value for the client to 150 by first
	-- calling the onServerInvokeCallback and if it returns true, then the remote property will set
	-- the value for the client to 150. If onServerInvokeCallback is not specified, then this won't work
	-- and the client's request will be disregarded.
	clientRemoteProperty:SetValue(150) 
	```
]=]

function RemoteProperty.new(initialValue, clientValueSetValidatorCallback)
	assert(RunService:IsServer(), "RemoteProperty can only be created on the server")

	if clientValueSetValidatorCallback then
		assert(
			typeof(clientValueSetValidatorCallback) == "function",
			SharedConstants.ErrorMessages.InvalidArgument:format(
				2,
				"RemoteProperty.new",
				"function or nil",
				typeof(clientValueSetValidatorCallback)
			)
		)
	end

	local self = setmetatable({
		OnValueUpdate = Signal.new(),
		OnClientValueUpdate = Signal.new(),
		_maid = Maid.new(),
		_clientValueSetValidatorCallback = clientValueSetValidatorCallback,
		_currentValue = initialValue,
		_clientValues = {},
	}, RemoteProperty)

	self:_init()

	return self
end

--[=[
	@return boolean
	@tag RemoteProperty

	Returns a boolean indicating if the remote property is bound to the client or not.
]=]

function RemoteProperty:IsBoundToClient()
	return self._remote ~= nil
end

--[=[
	@ignore
]=]

function RemoteProperty:BindToClient(remote)
	function remote.OnServerInvoke(client, value)
		local shouldGetClientValue = value == SharedConstants.RemotePropertyGetClientValue:format(client.Name)

		if shouldGetClientValue then
			-- Return the specific value set for the client, else return the current value:
			local clientValueData = self._clientValues[client.UserId]
			return if clientValueData then clientValueData.Value else self._currentValue
		else
			if self._clientValueSetValidatorCallback and self._clientValueSetValidatorCallback(client, value) then
				self:SetValue(value, { client })
			end
		end
	end

	self:_flushClientValueDataOnLeave()
	self._remote = self._maid:AddTask(remote)
end

--[=[
	@tag RemoteProperty

	Destroys the remote property, renders it unusable and cleans up everything.

	:::note
	You should only ever destroy the remote property once you're completely done working with it (both serverside
	and clientside if bound to the client) to avoid unexpected behavior.
	:::
]=]

function RemoteProperty:Destroy()
	self._maid:Destroy()
end

--[=[
	@tag RemoteProperty
	@param newValue any
	@param clients ?

	Sets the value of the remote property to `newValue`. If the remote property is bound 
	to the client, then it will update the value for every player to `newValue` and their 
	client remote property (the one that is bound to this remote property) to `newValue` as well and also
	update the current value of the remote property to `newValue`. 
	
	If `clients` is specified, then the value will only be updated for each 
	player in the `clients` table only.

	:::note
	- Each client's value set in the remote property will be flushed (cleared out) when they leave. 
	- It is illegal to set the value for specific clients only if the remote property isn't bound to the client.
	:::
]=]

function RemoteProperty:SetValue(newValue, specificClients)
	if specificClients then
		assert(
			typeof(specificClients) == "table",
			SharedConstants.ErrorMessages.InvalidArgument:format(
				2,
				"RemoteProperty:SetValue",
				"table or nil",
				typeof(specificClients)
			)
		)
	end

	if self:IsBoundToClient() then
		-- Set the current value to new value if we're setting the value for everyone
		-- and not just for specific clients:
		self._currentValue = if not specificClients then newValue else self._currentValue
		self:_setClientsValue(specificClients or Players:GetPlayers(), newValue)
	else
		assert(
			not specificClients,
			"Cannot set value for specific clients only as the remote property isn't bound to the client"
		)

		if self._currentValue ~= newValue then
			self._currentValue = newValue
			self.OnValueUpdate:Fire(newValue)
		end
	end
end

--[=[
	@tag RemoteProperty
	@param client Player ?
	@return any

	Returns the current value of the remote property. If `client` is specified, then it will return the **specific** 
	value set for `client` in the remote property.
]=]

function RemoteProperty:GetValue(client)
	if client then
		assert(
			typeof(client) == "Instance" and client:IsA("Player"),
			SharedConstants.ErrorMessages.InvalidArgument:format(
				1,
				"RemoteProperty:GetValue",
				"Player or nil",
				typeof(client)
			)
		)
	end

	if client then
		local clientValueData = self._clientValues[client.UserId]
		return if clientValueData then clientValueData.Value else nil
	else
		return self._currentValue
	end
end

function RemoteProperty:_flushClientValueDataOnLeave()
	self._maid:AddTask(Players.PlayerRemoving:Connect(function(client)
		-- Flush out the client's value:
		self._clientValues[client.UserId] = nil
	end))
end

function RemoteProperty:_setClientsValue(clients, newValue)
	local clientValues = self._clientValues

	for _, client in ipairs(clients) do
		if not clientValues[client.UserId] then
			clientValues[client.UserId] = {}
		end

		local currentClientValueData = clientValues[client.UserId]

		if currentClientValueData.Value ~= newValue then
			currentClientValueData.Value = newValue
			self.OnClientValueUpdate:Fire(client, newValue)
			task.spawn(self._remote.InvokeClient, self._remote, client, newValue)
		end
	end
end

function RemoteProperty:_init()
	self._maid:AddTask(self.OnClientValueUpdate)
	self._maid:AddTask(self.OnValueUpdate)
	self._maid:AddTask(function()
		TableUtil.Empty(self)
		setmetatable(self, nil)
	end)
end

return RemoteProperty
