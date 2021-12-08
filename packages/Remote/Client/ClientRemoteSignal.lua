-- angrybino
-- ClientRemoteSignal
-- September 26, 2021

--[[
	-- Static methods:

	ClientRemoteSignal.IsA(self : any) --> boolean 

	-- Instance methods:
	
	ClientRemoteSignal:Connect(callback : function) --> RBXScriptConnection 
	ClientRemoteSignal:Wait() --> any 
	ClientRemoteSignal:Fire(... : any) --> () 
	ClientRemoteSignal:CleanupConnections() --> ()
	ClientRemoteSignal:Destroy() --> () 
	ClientRemoteSignal:IsBoundToServer() --> boolean
]]

--[=[
	@class ClientRemoteSignal
	@client

	Client remote signals are used internally by communication signals to expose remote signals to the client. For e.g,
	a remote signal can be representable on the client through a client remote signal bound to that
	remote signal by a communication signal.

	```lua
	local clientRemoteSignal = ...
	clientRemoteSignal:Fire("Hey server")
	```

	:::note
	Remote event limitations and behavior edge cases apply. For more information, see [Remote Functions and Events](https://developer.roblox.com/en-us/articles/Remote-Functions-and-Events).
	:::
]=]

local ClientRemoteSignal = {}
ClientRemoteSignal.__index = ClientRemoteSignal

local remoteFolder = script.Parent.Parent
local dependencies = remoteFolder.Parent

local Maid = require(dependencies.Maid)
local TableUtil = require(dependencies.TableUtil)
local SharedConstants = require(remoteFolder.SharedConstants)

--[=[
	@param self any
	@return boolean

	A method which returns a boolean indicating if `self` is a client remote signal or not.
]=]

function ClientRemoteSignal.IsA(self)
	return getmetatable(self) == ClientRemoteSignal
end

--[=[
	@return ClientRemoteSignal

	Creates and returns a new client remote signal.
]=]

function ClientRemoteSignal.new()
	local self = setmetatable({
		_maid = Maid.new(),
		_connections = {},
	}, ClientRemoteSignal)

	self:_init()

	return self
end

--[=[
	@return boolean
	@tag ClientRemoteSignal

	Returns a boolean indicating if the client remote signal is bound to a remote signal.
]=]

function ClientRemoteSignal:IsBoundToServer()
	return self._remote ~= nil
end

--[=[
	@ignore
]=]

function ClientRemoteSignal:BindToServer(remote)
	self._remote = remote
end

--[=[
	@param callback function
	@return RBXScriptConnection
	@tag ClientRemoteSignal

	Same as `self._remote:Connect(callback)`.
]=]

function ClientRemoteSignal:Connect(callback)
	assert(
		typeof(callback) == "function",
		SharedConstants.ErrorMessages.InvalidArgument:format(
			1,
			"ClientRemoteSignal:Connect",
			"function",
			typeof(callback)
		)
	)

	local connection
	connection = self._remote.OnClientEvent:Connect(function(...)
		-- Support the behavior of deferred signal behavior:
		if not connection.Connected then
			return
		end

		callback(...)
	end)

	table.insert(self._connections, connection)

	return connection
end

--[=[
	@param ... any
	@tag ClientRemoteSignal

	Same as `self._remote:FireServer(...)`.
]=]

function ClientRemoteSignal:Fire(...)
	self._remote:FireServer(...)
end

--[=[
	@param ... any
	@tag ClientRemoteSignal

	Destroys the client remote signal, renders it unusuable and cleans up everything.

	:::note
	You should only ever destroy the client remote signal once you're completely done working with it to avoid
	unexpected behavior.
	:::
]=]

function ClientRemoteSignal:Destroy()
	self._maid:Destroy()
end

--[=[
	@tag ClientRemoteSignal

	Disconnects all connections created through `ClientRemoteSignal:Connect`.
]=]

function ClientRemoteSignal:CleanupConnections()
	for _, connection in ipairs(self._connections) do
		connection:Disconnect()
	end

	table.clear(self._connections)
end

--[=[
	@return ... 
	@yields

	A method which yields the thread until the remote signal (that this client remote signal is bound to) is fired to the client.
]=]

function ClientRemoteSignal:Wait()
	return self._remote.OnClientEvent:Wait()
end

function ClientRemoteSignal:_init()
	self._maid:AddTask(function()
		self:CleanupConnections()
		TableUtil.Empty(self)
		setmetatable(self, nil)
	end)
end

return ClientRemoteSignal
