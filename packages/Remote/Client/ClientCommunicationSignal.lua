-- finobinos
-- ClientCommunicationSignal.lua
-- 17 October 2021

--[[
    -- Static methods:

    ClientCommunicationSignal.GetDispatchedCommunicationSignal(identifier : string) --> Promise
    ClientCommunicationSignal.IsA(self : any) --> boolean 

	-- Instance members:

	ClientCommunicationSignal.Members : table
	ClientCommunicationSignal.RemoteProperties : table
	ClientCommunicationSignal.RemoteSignals : table

	-- Instance methods:

	ClientCommunicationSignal:Build() --> table 
]]

--[=[
	@class ClientCommunicationSignal
	@client

	A client communication signal contains all the members, remote signals and remote properties binded to it's server
	counter part (a communication signal).

	```lua
	-- On the server:
	local signal = CommunicationSignal.new("Bobo")
	signal:Bind("Test", 123)
	signal:Bind("T", {1, 2, 3})
	signal:DispatchToClient()

	-- On the client:
	local clientSignal = ClientCommunicationSignal.GetDispatchedCommunicationSignal("Bobo"):expect()

	print(
		clientSignal.Members.Test,  --> 123
		clientSignal.Members.T, --> {1, 2, 3}
	)
	```

	:::note
	A Remote signal and a remote property exposed to the client are represented as client remote signal 
	and client remote property, binded to their serverside counter parts (remote property and remote signal) 
	respectively. 

	For e.g:

	```lua
	-- On the server:
	local signal = CommunicationSignal.new("ServersideService")
	signal:Bind("Bo", RemoteSignal.new())
	signal:DispatchToClient()

	-- On the client:
	local clientSignal = ClientCommunicationSignal.GetDispatchedCommunicationSignal("ServersideService"):expect() 
	print(ClientRemoteSignal.IsA(clientSignal.RemoteSignals.Bo)) --> true
	```
	:::
]=]

--[=[
	@prop Members table
	@within ClientCommunicationSignal
	@tag ClientCommunicationSignal
	@readonly

	A dictionary of all members binded to the client communication signal.
]=]

--[=[
	@prop RemoteSignals table
	@within ClientCommunicationSignal
	@tag ClientCommunicationSignal
	@readonly

	A dictionary of all remote signals binded to the client communication signal.
]=]

--[=[
	@prop RemoteProperties table
	@within ClientCommunicationSignal
	@tag ClientCommunicationSignal
	@readonly

	A dictionary of all remote properties binded to the client communication signal.
]=]

local ClientCommunicationSignal = { _dispatchedCommunicationSignals = {} }
ClientCommunicationSignal.__index = ClientCommunicationSignal

local remoteFolder = script.Parent.Parent
local dependencies = remoteFolder.Parent

local SharedConstants = require(remoteFolder.SharedConstants)
local ClientRemoteSignal = require(script.Parent.ClientRemoteSignal)
local ClientRemoteProperty = require(script.Parent.ClientRemoteProperty)
local Promise = require(dependencies.Promise)
local TableUtil = require(dependencies.TableUtil)
local Maid = require(dependencies.Maid)
local Signal = require(dependencies.Signal)

local LocalConstants = {
	DefaultDispatchedCommunicationSignalRetrievalTimeout = 5,
}

--[=[
	@return Promise
	@within ClientCommunicationSignal
	@param identifier string
	@param timeout number ?
	
	Returns a promise which is resolved with the serverside dispatched signal represented in a client communication signal.
	`timeout` will default to `3` if not specified and the method will wait for `timeout` seconds 
	for the serverside dispatched signal to exist before assuming that it doesn't and rejecting with a `nil` value.

	```lua
	-- On the server:
	local signal = CommunicationSignal.new("Signal")
	signal:Bind("bo", true)
	signal:DispatchToClient()

	-- On the client:
	ClientCommunicationSignal.GetDispatchedCommunicationSignal("Signal"):andThen(function(signal)
		print(signal.Members.bo) --> true
	end)
	```
	:::tip
	This method returns cached results when retrieving the same dispatched communication signal, _if it was successfully
	retrieved in the first place_.

	For e.g:

	```lua
	-- On the server:
	local signal = CommunicationSignal.new("Signal")
	signal:DispatchToClient()

	-- On the client:
	local clientSignal1 = ClientCommunicationSignal.GetDispatchedCommunicationSignal("Signal"):expect()
	local clientSignal2 = ClientCommunicationSignal.GetDispatchedCommunicationSignal("Signal"):expect()
	print(clientSignal1 == clientSignal2) --> true
	```
	:::
]=]

function ClientCommunicationSignal.GetDispatchedCommunicationSignal(identifier, timeout)
	assert(
		typeof(identifier) == "string",
		SharedConstants.ErrorMessages.InvalidArgument:format(
			1,
			"CommunicationSignal.GetDispatchedCommunicationSignal",
			"string",
			typeof(identifier)
		)
	)

	if timeout then
		assert(
			typeof(timeout) == "number",
			SharedConstants.ErrorMessages.InvalidArgument:format(
				2,
				"CommunicationSignal.GetDispatchedCommunicationSignal",
				"number or nil",
				typeof(timeout)
			)
		)
	end

	return Promise.new(function(resolve, reject)
		local dispatchedSignal = ClientCommunicationSignal._dispatchedCommunicationSignals[identifier]

		if Signal.IsA(dispatchedSignal) then
			-- Case 1: Dispatched signal is being created, wait for it to be
			-- created and reuse it.
			dispatchedSignal = dispatchedSignal:Wait()
		elseif not dispatchedSignal then
			-- Case 2: Default case, create dispatched signal:
			local onDispatchedSignalCreated = Signal.new()
			ClientCommunicationSignal._dispatchedCommunicationSignals[identifier] = onDispatchedSignalCreated

			local serversideDispatchedSignal = SharedConstants.CommunicationSignalsFolder:WaitForChild(
				identifier,
				timeout or LocalConstants.DefaultDispatchedCommunicationSignalRetrievalTimeout
			)

			if serversideDispatchedSignal then
				dispatchedSignal = setmetatable({
					Members = {},
					RemoteProperties = {},
					RemoteSignals = {},
					_serversideSignal = serversideDispatchedSignal,
					_maid = Maid.new(),
					_identifier = identifier,
				}, ClientCommunicationSignal)

				dispatchedSignal:_init()
			else
				ClientCommunicationSignal._dispatchedCommunicationSignals[identifier] = nil
			end

			-- Cleanup:
			onDispatchedSignalCreated:Fire(dispatchedSignal)
			onDispatchedSignalCreated:Destroy()
		end

		if dispatchedSignal then
			resolve(dispatchedSignal)
		else
			reject(('Communication signal "%s" was not dispatched in time'):format(identifier))
		end
	end)
end

--[=[
	@param self any
	@return boolean
	@within ClientCommunicationSignal

	A method which returns a boolean indicating if `self` is a client communication signal or not.
]=]

function ClientCommunicationSignal.IsA(self)
	return getmetatable(self) == ClientCommunicationSignal
end

--[=[
	@return table
	@within ClientCommunicationSignal
	@tag ClientCommunicationSignal

	A method which builds the communication signal for client-side use.

	For e.g:

	```lua
	local builtSignal = clientCommunicationSignal:Build()

	-- Normally to access members you would do:
	print(clientSignal.Members.Table) --> {1, 2, 3}

	-- Via dispatched signal:
	print(builtSignal.Table) -->  {1, 2, 3} 
	```

	:::tip
	This method returns cached results if the client communication signal was already previously built.

	For e.g:

	```lua
	local s = clientCommunicationSignal:Build()
	local o = clientCommunicationSignal:Build()
	print(s == o) --> true
	```
	:::
]=]

function ClientCommunicationSignal:Build()
	if self._builtDispatchedSignal then
		return self._builtDispatchedSignal
	end

	local builtDispatchedSignal = {}

	for key, value in pairs(TableUtil.Combine(self.Members, self.RemoteSignals, self.RemoteProperties)) do
		builtDispatchedSignal[key] = value
	end

	self._builtDispatchedSignal = builtDispatchedSignal
	return builtDispatchedSignal
end

function ClientCommunicationSignal:_init()
	local serversideSignal = self._serversideSignal
	local identifier = self._identifier

	for _, remote in pairs(
		TableUtil.Combine(
			serversideSignal.Members:GetChildren(),
			serversideSignal.RemoteProperties:GetChildren(),
			serversideSignal.RemoteSignals:GetChildren()
		)
	) do
		if remote.Parent == serversideSignal.Members then
			self:_initMember(remote)
		elseif remote.Parent == serversideSignal.RemoteProperties then
			self:_initRemoteProperty(remote)
		elseif remote.Parent == serversideSignal.RemoteSignals then
			self:_initRemoteSignal(remote)
		end
	end

	ClientCommunicationSignal._dispatchedCommunicationSignals[identifier] = self

	self._maid:AddTask(function()
		ClientCommunicationSignal._dispatchedCommunicationSignals[identifier] = nil
		TableUtil.Empty(self)
		setmetatable(self, nil)
	end)
end

function ClientCommunicationSignal:_initRemoteProperty(remote)
	local clientRemoteProperty = ClientRemoteProperty.new()
	clientRemoteProperty:BindToServer(remote)

	self.RemoteProperties[remote.Name] = clientRemoteProperty
end

function ClientCommunicationSignal:_initRemoteSignal(remote)
	local clientRemoteSignal = ClientRemoteSignal.new()
	clientRemoteSignal:BindToServer(remote)

	self.RemoteSignals[remote.Name] = clientRemoteSignal
end

function ClientCommunicationSignal:_initMember(remote)
	local value = if remote:GetAttribute("IsBindedToFunction") then function(...)
		return remote:InvokeServer(...)
	end else remote:InvokeServer()

	self.Members[remote.Name] = value
end

return ClientCommunicationSignal
