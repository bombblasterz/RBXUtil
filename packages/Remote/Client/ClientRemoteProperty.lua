-- finobinos
-- ClientRemoteProperty.lua
-- 17 October 2021

--[[
	-- Static methods:

    ClientRemoteProperty.IsA(self : any) --> boolean 
	ClientRemoteProperty.new(value : any) --> ClientRemoteProperty

	-- Instance members:
	 
    ClientRemoteProperty.OnValueUpdate : Signal <newValue : any>

	-- Instance methods:
    
    ClientRemoteProperty:Destroy() --> () 
    ClientRemoteProperty:SetValue(value : any) --> () 
    ClientRemoteProperty:GetValue() --> any 
	ClientRemoteProperty:IsBoundToServer() --> boolean
]]

--[=[
	@class ClientRemoteProperty
	@client

	A client remote property works similar to a remote property and can either be
	bound to a remote property by a communication signal for server-client relationship 
	or just work on the client.

	```lua
	local clientRemoteProperty = ClientRemoteProperty.new(50)

	print(clientRemoteProperty:GetValue()) --> 50
	clientRemoteProperty:SetValue(100)
	print(clientRemoteProperty:GetValue()) --> 100
	```

	:::note
	Remote function limitations and behavior edge cases apply. For more information, see [Remote Functions and Events](https://developer.roblox.com/en-us/articles/Remote-Functions-and-Events).
	:::
]=]

--[=[
	@within ClientRemoteProperty
	@tag ClientRemoteProperty
	@prop OnValueUpdate Signal <newValue: any>
	@readonly
	 
	A signal which is fired whenever the value of the client remote property is updated, either on the client
	or on the server for the client, if the client remote property is bound to the server.
]=]

local ClientRemoteProperty = {}
ClientRemoteProperty.__index = ClientRemoteProperty

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

local remoteFolder = script.Parent.Parent
local dependencies = remoteFolder.Parent
local SharedConstants = require(remoteFolder.SharedConstants)
local Maid = require(dependencies.Maid)
local Signal = require(dependencies.Signal)
local TableUtil = require(dependencies.TableUtil)

--[=[
	@param self any
	@return boolean

	A method which returns a boolean indicating if `self` is a client remote property or not.
]=]

function ClientRemoteProperty.IsA(self)
	return getmetatable(self) == ClientRemoteProperty
end

--[=[
	@param initialValue any
	@return ClientRemoteProperty

	Creates and returns a new client remote property.
]=]

function ClientRemoteProperty.new(initialValue)
	assert(RunService:IsClient(), "ClientRemoteProperty can only be created on the client")

	local self = setmetatable({
		OnValueUpdate = Signal.new(),
		_maid = Maid.new(),
		_currentValue = initialValue,
	}, ClientRemoteProperty)

	self:_init()

	return self
end

--[=[
	@return boolean
	@tag ClientRemoteProperty

	Returns a boolean indicating if the client remote property is bound to a remote property.
]=]

function ClientRemoteProperty:IsBoundToServer()
	return self._remote ~= nil
end

--[=[
	@ignore
]=]

function ClientRemoteProperty:BindToServer(remote)
	function remote.OnClientInvoke(newValue)
		self.OnValueUpdate:Fire(newValue)
	end

	self._remote = remote

	self._maid:AddTask(function()
		remote.OnClientInvoke = nil
	end)
end

--[=[
	@tag ClientRemoteProperty

	Destroys the client remote property, renders it unusable and cleans up everything.

	:::note
	You should only ever destroy the client remote property once you're completely done working with it to avoid
	unexpected behavior.
	:::
]=]

function ClientRemoteProperty:Destroy()
	self._maid:Destroy()
end

--[=[
	@tag ClientRemoteProperty
	@param newValue any
	@yields

	Sets the value of the client remote property to `newValue`. If the client remote property is bound 
	to a remote property, then it will ask that remote property to set the value for the client
	to `newValue`.
]=]

function ClientRemoteProperty:SetValue(newValue)
	if self:IsBoundToServer() then
		local remote = self._remote
		remote:InvokeServer(newValue)
	else
		if self._currentValue ~= newValue then
			self._currentValue = newValue
			self.OnValueUpdate:Fire(newValue)
		end
	end
end

--[=[
	@tag ClientRemoteProperty
	@return any
	@yields 

	Returns the current value of the client remote property. If bound to a remote property, 
	then it will retrieve the value of the client from the remote property that this client remote
	property is bound to and if there is no value set specifically for the client, 
	then it will return the current value of that remote property.
]=]

function ClientRemoteProperty:GetValue()
	if self:IsBoundToServer() then
		return self._remote:InvokeServer(SharedConstants.RemotePropertyGetClientValue:format(Players.LocalPlayer.Name))
	else
		return self._currentValue
	end
end

function ClientRemoteProperty:_init()
	self._maid:AddTask(self.OnValueUpdate)

	self._maid:AddTask(function()
		TableUtil.Empty(self)
		setmetatable(self, nil)
	end)
end

return ClientRemoteProperty
