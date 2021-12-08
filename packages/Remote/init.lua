-- finobinos
-- init.lua
-- 17 October 2021

--[[
	-- Client only:

    - ClientRemoteSignal
    - ClientRemoteProperty
    - ClientCommunicationSignal

	-- Server only:
	
    - RemoteSignal
    - RemoteProperty
    - CommunicationSignal
]]

return {
	Client = {
		ClientRemoteSignal = require(script.Client.ClientRemoteSignal),
		ClientRemoteProperty = require(script.Client.ClientRemoteProperty),
		ClientCommunicationSignal = require(script.Client.ClientCommunicationSignal),
	},

	Server = {
		RemoteSignal = require(script.Server.RemoteSignal),
		RemoteProperty = require(script.Server.RemoteProperty),
		CommunicationSignal = require(script.Server.CommunicationSignal),
	},
}