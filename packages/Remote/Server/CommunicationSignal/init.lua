-- finobinos
-- Server.lua
-- 17 October 2021

--[[
    -- Static methods:

    CommunicationSignal.new(identifier : string) --> CommunicationSignal
    CommunicationSignal.IsA(self : any) --> boolean 

	-- Instance members:
	
	CommunicationSignal.RemoteProperties : table
	CommunicationSignal.RemoteSignals : table
	CommunicationSignal.Members : table

    -- Instance methods:

	CommunicationSignal:DispatchToClient() --> ()
	CommunicationSignal:Bind(
		key : string, 
		value : any
	) --> () 
	CommunicationSignal:IsDispatchedToClient() --> boolean
	CommunicationSignal:Destroy() --> ()
]]

--[=[
	@class CommunicationSignal
	@server

	Communication signals are used to expose members, methods, remote signals and remote properties
	to the client in a much easier and abstracted fashion.

	```lua
	-- On the server
	local communicationSignal = CommunicationSignal.new("SomeSignal")

	-- Bind method "Test" to the client:
	communicationSignal:Bind("Test", function(player)
		return "Hey!"
	end))

	-- Bind member "Bo" to the client:
	communicationSignal:Bind("Bo", {1, 2, 3})
	communicationSignal:DispatchToClient()

	-- On the client
	local clientSignal = CommunicationSignal.GetDispatchedCommunicationSignal("SomeSignal"):expect()

	print(clientSignal.Members.Test("Hi")) --> "Hey!"
	print( clientSignal.Members.Bo) --> {1, 2, 3}
	```
]=]

--[=[
	@prop Members table
	@within CommunicationSignal
	@tag CommunicationSignal
	@readonly

	A dictionary of all members binded to the communication signal.
]=]

--[=[
	@prop RemoteSignals table
	@within CommunicationSignal
	@tag CommunicationSignal
	@readonly

	A dictionary of all remote signals binded to the communication signal.
]=]

--[=[
	@prop RemoteProperties table
	@within CommunicationSignal
	@tag CommunicationSignal
	@readonly

	A dictionary of all remote properties binded to the communication signal.
]=]

local Server = { _communicationSignals = {} }
Server.__index = Server

local remoteFolder = script.Parent.Parent
local dependencies = remoteFolder.Parent

local SharedConstants = require(remoteFolder.SharedConstants)
local RemoteSignal = require(remoteFolder.Server.RemoteSignal)
local RemoteProperty = require(remoteFolder.Server.RemoteProperty)
local Maid = require(dependencies.Maid)
local TableUtil = require(dependencies.TableUtil)

--[=[
	@return CommunicationSignal
	@within CommunicationSignal
	@param identifier string

	Creates and returns a new communication signal.
]=]

function Server.new(identifier)
	assert(
		typeof(identifier) == "string",
		SharedConstants.ErrorMessages.InvalidArgument:format(1, "CommunicationSignal.new", "string", typeof(identifier))
	)

	assert(
		not Server._communicationSignals[identifier],
		('Communication signal "%s" already exists'):format(identifier)
	)

	local self = setmetatable({
		Members = {},
		RemoteProperties = {},
		RemoteSignals = {},
		_instance = Instance.new("Folder"),
		_identifier = identifier,
		_maid = Maid.new(),
	}, Server)

	self:_init()

	return self
end

--[=[
	@param identifier string
	@return CommunicationSignal 
	@within CommunicationSignal

	Returns a communication signal of `identifier`.
]=]

function Server.GetCommunicationSignal(identifier)
	assert(
		typeof(identifier) == "string",
		SharedConstants.ErrorMessages.InvalidArgument:format(
			1,
			"CommunicationSignal.GetCommunicationSignal",
			"string",
			typeof(identifier)
		)
	)

	local communicationSignal = Server._communicationSignals[identifier]
	assert(communicationSignal, ("Communication signal %s not found"):format(identifier))

	return communicationSignal
end

--[=[
	@param self any
	@return boolean
	@within CommunicationSignal

	A method which returns a boolean indicating if `self` is a communication signal or not.
]=]

function Server.IsA(self)
	return getmetatable(self) == Server
end

--[=[
	@within CommunicationSignal
	@param key string 
	@param value any
	@tag CommunicationSignal

	Binds `key` with `value` to the client. 

	:::note
	It is illegal to call this method if the communication signal is already dispatched to the client.
	:::
]=]

function Server:Bind(key, value)
	assert(
		not self:IsDispatchedToClient(),
		"Cannot bind key with value as communication signal is already dispatched to the client"
	)

	assert(
		typeof(key) == "string",
		SharedConstants.ErrorMessages.InvalidArgument:format(1, "CommunicationSignal:Bind", "string", typeof(key))
	)

	if RemoteProperty.IsA(value) then
		assert(not self.RemoteProperties[key], ('Remote property "%s" is already binded'):format(key))
		self:_bindRemoteProperty(key, value)
	elseif RemoteSignal.IsA(value) then
		assert(not self.RemoteSignals[key], ('Remote property "%s" is already binded'):format(key))
		self:_bindRemoteSignal(key, value)
	else
		assert(not self.Members[key], ('Member "%s" is already binded'):format(key))
		self:_bindMember(key, value)
	end
end

--[=[
	@within CommunicationSignal
	@tag CommunicationSignal

	Dispatches the communication signal to the client. Only call this method when the communication signal is ready
	to be exposed to the client.
]=]

function Server:DispatchToClient()
	assert(
		self._instance.Parent ~= SharedConstants.CommunicationSignalsFolder,
		"Communication signal is already dispatched to client"
	)

	self._instance.Parent = SharedConstants.CommunicationSignalsFolder
end

--[=[
	@within CommunicationSignal
	@tag CommunicationSignal
	@return boolean

	Returns a boolean indicating if the communication signal is dispatched to the client or not.
]=]

function Server:IsDispatchedToClient()
	return self._instance.Parent == SharedConstants.CommunicationSignalsFolder
end

--[=[
	@within CommunicationSignal
	@tag CommunicationSignal

	Destroys the communication signal, renders it unusable and cleans up everything including bound remote signals
	and remote properties (if they weren't destroyed yet).
]=]

function Server:Destroy()
	self._maid:Destroy()
end

function Server:_init()
	local identifier = self._identifier
	local instance = self._instance

	instance.Name = identifier

	local membersFolder = Instance.new("Folder")
	membersFolder.Name = "Members"
	membersFolder.Parent = instance
	local remoteSignalsFolder = Instance.new("Folder")
	remoteSignalsFolder.Name = "RemoteSignals"
	remoteSignalsFolder.Parent = instance
	local remotePropertiesFolder = Instance.new("Folder")
	remotePropertiesFolder.Name = "RemoteProperties"
	remotePropertiesFolder.Parent = instance

	Server._communicationSignals[identifier] = self

	self._maid:AddTask(instance)
	self._maid:AddTask(function()
		Server._communicationSignals[identifier] = nil
		TableUtil.Empty(self)
		setmetatable(self, nil)
	end)
end

function Server:_bindMember(member, value)
	local remote = self._maid:AddTask(Instance.new("RemoteFunction"))
	remote:SetAttribute("IsBindedToFunction", typeof(value) == "function")
	remote.Name = member
	remote.OnServerInvoke = function(...)
		if typeof(value) == "function" then
			return value(...)
		else
			return value
		end
	end

	remote.Parent = self._instance.Members
	self.Members[member] = value
end

function Server:_bindRemoteSignal(remoteSignalName, remoteSignal)
	local remote = Instance.new("RemoteEvent")
	remote.Name = remoteSignalName
	remote.Parent = self._instance.RemoteSignals
	remoteSignal:BindToClient(remote)
	self.RemoteSignals[remoteSignalName] = remoteSignal

	self._maid:AddTask(function()
		-- Make sure the remote signal isn't already destroyed before destroying it:
		if RemoteSignal.IsA(remoteSignal) then
			remoteSignal:Destroy()
		end
	end)
end

function Server:_bindRemoteProperty(remotePropertyName, remoteProperty)
	local remote = Instance.new("RemoteFunction")
	remote.Name = remotePropertyName
	remote.Parent = self._instance.RemoteProperties
	remoteProperty:BindToClient(remote)
	self.RemoteProperties[remotePropertyName] = remoteProperty

	self._maid:AddTask(function()
		-- Make sure the remote property isn't already destroyed before destroying it:
		if RemoteProperty.IsA(remoteProperty) then
			remoteProperty:Destroy()
		end
	end)
end

return Server
