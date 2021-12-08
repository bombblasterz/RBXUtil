-- finobinos
-- init.lua
-- 16 October 2021

--[[
	-- Static methods:

	Maid.new() --> Maid 
	Maid.IsA(self : any) --> boolean 

	-- Instance methods:
	
	Maid:AddTask(task : table | function | RBXScriptConnection | Instance, alias : string ?) --> task 
	Maid:RemoveTask(task : task | string) --> () 
	Maid:LinkToInstance(instance : Instance, callback : function ?) --> (instance, ManualConnection) 
		ManualConnection:Disconnect() --> ()
		ManualConnection:IsConnected() --> boolean

	Maid:GetTask(taskAlias : string) --> task ?
	Maid:Cleanup() --> ()
	Maid:Destroy() --> () 
]]

--[=[
	@class Maid
	Maids track tasks and clean them when needed. They are used to manage
	state easier and encapsulate clean ups.

	For e.g:

	```lua
	local maid = Maid.new()
	local connection = workspace.ChildAdded:Connect(function()

	end)
	maid:AddTask(connection)
	maid:Cleanup()
	print(connection.Connected) --> false
	```
]=]

local Maid = {}
Maid.__index = Maid

local LocalConstants = {
	ErrorMessages = {
		InvalidArgument = "Invalid argument#%d to %s: expected %s, got %s",
	},
}

local Connection = {}
Connection.__index = Connection

do
	function Connection.new(maid)
		return setmetatable({
			_maid = maid,
			_isConnected = true,
		}, Connection)
	end

	function Connection:Disconnect()
		assert(self:IsConnected(), "Cannot disconnect an already disconnected connection")

		self._isConnected = false
		self._connection:Disconnect()

		self._maid._connections[self] = nil
		self._connection = nil
		self._maid = nil
	end

	function Connection:GiveConnection(connection)
		self._maid._connections[self] = self
		self._connection = connection

		return connection
	end

	function Connection:IsConnected()
		return self._isConnected
	end
end

--[=[
	Creates and returns a new maid.

	@return Maid 
]=]

function Maid.new()
	return setmetatable({
		_tasks = {},
		_connections = {},
	}, Maid)
end

function Maid:__index(key)
	return Maid[key] or self._tasks[key]
end

--[=[
	A method which is used to check if the given argument is a maid or not.

	@param self any 
	@return boolean 
]=]

function Maid.IsA(self)
	return getmetatable(self) == Maid
end

--[=[
	Adds a task for the maid to cleanup. `alias` can be specified for removing the added task easily
	through `maid:RemoveTask(alias)`, this is useful when you want to remove a task but don't have a direct
	reference to it.

	:::note
	If `table` is passed as a task, it must implement a `Destroy` or `Disconnect` method so that it can be cleaned up.
	:::

	@tag Maid
	@param task table | RBXScriptConnection | function | Instance
	@param alias string ?
	@return task 
]=]

function Maid:AddTask(task, alias)
	assert(
		typeof(task) == "table"
			or typeof(task) == "RBXScriptConnection"
			or typeof(task) == "function"
			or typeof(task) == "Instance",

		LocalConstants.ErrorMessages.InvalidArgument:format(
			1,
			"Maid:AddTask",
			"RBXScriptConnection or function or Instance or table",
			typeof(task)
		)
	)

	if typeof(task) == "table" then
		assert(
			typeof(task.Destroy) == "function" or typeof(task.Disconnect) == "function",
			"Given table must implement a Destroy or Disconnect method"
		)
	end

	if alias then
		assert(
			typeof(alias) == "string",
			LocalConstants.ErrorMessages.InvalidArgument:format(2, "Maid:AddTask", "string or nil", typeof(alias))
		)
	end

	self._tasks[alias or task] = task
	return task
end

--[=[
	@param taskAlias string
	@tag Maid

	Returns an added task of `alias`, if found.
]=]

function Maid:GetTask(taskAlias)
	assert(
		typeof(taskAlias) == "string",
		LocalConstants.ErrorMessages.InvalidArgument:format(1, "Maid:GetTask", "string", typeof(taskAlias))
	)

	return self._tasks[taskAlias]
end

--[=[
	@tag Maid
	@param task task | string -- Can also be an alias of some task for easy removal

	Removes the task from the maid and cleans it up the final time. 

	For e.g:

	```lua
	local task = function() print("Cleaned up") end
	maid:AddTask(task)
	maid:RemoveTask(task)
	--> "Cleaned up"
	```
]=]

function Maid:RemoveTask(task)
	assert(self._tasks[task], "Given task cannot be removed as it was not added")

	self._tasks[task] = nil
end

--[=[
	Cleans up all the added tasks.
	@tag Maid

	| Task      | Cleanup procedure                          |
	| ----------- | ------------------------------------ |
	| `function`  | The function will be called.  |
	| `table`     | A `Destroy` or `Disconnect` method in the table will be called. |
	| `Instance`    | The instance will be destroyed. |
	| `RBXScriptConnection`    | The connection will be disconnected. |
]=]

function Maid:Cleanup()
	self:_cleanup(self._tasks)
end

--[=[
	@tag Maid

	Destroys the maid and renders it unusuable and cleans up all added tasks. Also unlinks the maid from all instances
	it was linked to.

	For e.g:

	```lua
	local _, connection = maid:LinkToInstance(instance)
	print(connection:IsConnected()) --> true
	maid:Destroy()
	print(connection:IsConnected()) --> false
	```
]=]

function Maid:Destroy()
	self:_cleanup(self._connections)
	self:Cleanup()

	for key, _ in pairs(self) do
		self[key] = nil
	end

	setmetatable(self, nil)
end

--[=[
	@param instance Instance
	@param callback function ?
		
	@return Instance
	@return Connection

	Links the given instance to the maid so that the maid will be destroyed once the instance has been parented to `nil`.
	If `callback` is specified, it will be called before destroying the maid (when the instance is parented to `nil`) and 
	if the function upon being called doesn't return a truthy value, the maid will not be destroyed.

	For e.g:

	```lua
	local instance = ... -- some instance parented to workspace
	local maid = Maid.new()

	maid:AddTask(function()
		warn("cleaned up")
	end)

	maid:LinkToInstance(instance)
	instance.Parent = nil
	-- Now the maid will cleanup as the instance is parented to nil.
	```

	Here's an alternate case:

	```lua
	local instance = ... -- some instance parented to workspace
	local maid = Maid.new()

	maid:AddTask(function()
		warn("cleaned up")
	end)

	maid:LinkToInstance(instance, function()
		return not instance:GetAttribute("DontHaveTheMaidCleanedupYetPlease") 
	end))

	instance:SetAttribute("DontHaveTheMaidCleanedupYetPlease", true)
	instance.Parent = nil
	-- The instance is parented to nil, but the maid hasn't cleaned up!
	```

	A connection is returned which contains the following methods:

	| Methods      | Description                          |
	| ----------- | ------------------------------------ |
	| `Disconnect`  | The connection will be disconnected and the maid will unlink to the instance it was linked to.  |
	| `IsConnected` | Returns a boolean indicating if the connection has been disconnected. |

	Once the connection is disconnected, the maid will be unlinked from the instance.
	
	:::note
	The behavior of this method is bound to change once the [Destroying](https://developer.roblox.com/en-us/api-reference/event/Instance/Destroying)
	event is officially enabled. When that happens, the maid will check if the instance is destroyed rather than just
	parented to `nil`.
	:::
]=]

function Maid:LinkToInstance(instance, callback)
	assert(
		typeof(instance) == "Instance",
		LocalConstants.ErrorMessages.InvalidArgument:format(1, "Maid:LinkToInstance", "Instance", typeof(instance))
	)

	if callback then
		assert(
			typeof(callback) == "function",
			LocalConstants.ErrorMessages.InvalidArgument:format(
				2,
				"Maid:LinkToInstance",
				"function or nil",
				typeof(callback)
			)
		)
	end

	local connection = Connection.new(self)

	local function Cleanup()
		local shouldCleanup = if callback then callback() else true

		-- Recheck again as after calling the callback (it may have yielded), and it's possible that by
		-- time, the connection was disconnected either due to the maid being destroyed or manually
		-- disconnected:
		if not connection:IsConnected() or not shouldCleanup then
			return
		end

		self:Destroy()
	end

	local instanceAncestryChangedConnection
	instanceAncestryChangedConnection = connection:GiveConnection(instance.AncestryChanged:Connect(function(_, parent)
		-- Support the behavior of deferred signal behavior:
		if not instanceAncestryChangedConnection.Connected then
			return
		end

		if not parent then
			Cleanup()
		end
	end))

	if not instance.Parent then
		Cleanup()
	end

	return instance, connection
end

function Maid:_cleanup(tasks)
	-- next() allows us to easily traverse the table accounting for more values being added and this allows us to clean
	-- up tasks spawned by the cleaning up of previous tasks.
	local key, task = next(tasks)

	while task do
		tasks[key] = nil
		self:_cleanupTask(task)
		key, task = next(tasks)
	end
end

function Maid:_cleanupTask(task)
	if typeof(task) == "function" then
		task()
	elseif typeof(task) == "RBXScriptConnection" then
		task:Disconnect()
	elseif typeof(task) == "Instance" then
		task:Destroy()
	else
		if typeof(task.Destroy) == "function" then
			task:Destroy()
		else
			task:Disconnect()
		end
	end
end

return Maid
