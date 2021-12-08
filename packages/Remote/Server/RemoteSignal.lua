-- finobinos
-- RemoteSignal.lua
-- 17 October 2021

--[[
	-- Static methods:
	
    RemoteSignal.IsA(self : any) --> boolean 
    RemoteSignal.new() --> RemoteSignal

    -- Instance methods:
    
	RemoteSignal:IsBoundToClient() --> boolean
	RemoteSignal:Connect(callback : function) --> RBXScriptConnection 
	RemoteSignal:CleanupConnections() --> ()
    RemoteSignal:Destroy() --> () 
    RemoteSignal:FireClients(clients : table, ... : any) --> () 
]]

--[=[
	@class RemoteSignal
	@server

	Remote signals are an abstraction of remote events i.e they can be created on the server and exposed to the client
	through communication signals.

	:::note
	Remote event limitations and behavior edge cases apply. For more information, see [Remote Functions and Events](https://developer.roblox.com/en-us/articles/Remote-Functions-and-Events).
	:::
]=]

local RemoteSignal = {}
RemoteSignal.__index = RemoteSignal

local RunService = game:GetService("RunService")

local remoteFolder = script.Parent.Parent
local dependencies = remoteFolder.Parent

local Maid = require(dependencies.Maid)
local TableUtil = require(dependencies.TableUtil)
local SharedConstants = require(remoteFolder.SharedConstants)

--[=[
	@param self any
	@return boolean

	A method which returns a boolean indicating if `self` is a remote signal or not.
]=]

function RemoteSignal.IsA(self)
	return getmetatable(self) == RemoteSignal
end

--[=[
	@return RemoteSignal

	Creates and returns a new remote signal.
]=]

function RemoteSignal.new()
	assert(RunService:IsServer(), "RemoteSignal can only be created on the server")

	local self = setmetatable({
		_maid = Maid.new(),
		_connections = {},
	}, RemoteSignal)

	self:_init()

	return self
end

--[=[
	@return boolean
	@tag RemoteSignal

	Returns a boolean indicating if the remote signal is bound to the client.
]=]

function RemoteSignal:IsBoundToClient()
	return self._remote ~= nil
end

--[=[
	@ignore
]=]

function RemoteSignal:BindToClient(remote)
	self._remote = self._maid:AddTask(remote)
end

--[=[
	@tag RemoteSignal

	Destroys the remote signal, renders it unusuable and cleans up everything.

	:::note
	You should only ever destroy the remote signal once you're completely done working with it(both serverside
	and clientside if bound to the client) to avoid unexpected behavior.
	:::
]=]

function RemoteSignal:Destroy()
	self._maid:Destroy()
end

--[=[
	@tag RemoteSignal
	@return RBXScriptConnection

	Works the same as `self._remote:Connect(callback)`.  
]=]

function RemoteSignal:Connect(callback)
	assert(
		typeof(callback) == "function",
		SharedConstants.ErrorMessages.InvalidArgument:format(1, "RemoteSignal:Connect", "function", typeof(callback))
	)

	local connection
	connection = self._remote.OnServerEvent:Connect(function(...)
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
	@tag ClientRemoteSignal

	Disconnects all connections created through `RemoteSignal:Connect`.
]=]

function RemoteSignal:CleanupConnections()
	for _, connection in ipairs(self._connections) do
		connection:Disconnect()
	end

	table.clear(self._connections)
end

--[=[
	@tag RemoteSignal
	@param clients table
	@param ... any

	Works the same as `self._remote:FireClient(player, ...`), but for every player in the `clients` table.
]=]

function RemoteSignal:FireClients(clients, ...)
	assert(
		typeof(clients) == "table",
		SharedConstants.ErrorMessages.InvalidArgument:format(1, "RemoteSignal:FireClients", "table", typeof(clients))
	)

	for _, client in ipairs(clients) do
		self._remote:FireClient(client, ...)
	end
end

function RemoteSignal:_init()
	self._maid:AddTask(function()
		TableUtil.Empty(self)
		setmetatable(self, nil)
	end)
end

return RemoteSignal
