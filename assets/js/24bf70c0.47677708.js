"use strict";(self.webpackChunkdocs=self.webpackChunkdocs||[]).push([[6758],{60244:function(e){e.exports=JSON.parse('{"functions":[{"name":"IsA","desc":"A method which returns a boolean indicating if `self` is a remote property or not.","params":[{"name":"self","desc":"","lua_type":"any"}],"returns":[{"desc":"","lua_type":"boolean"}],"function_type":"static","source":{"line":119,"path":"packages/Remote/Server/RemoteProperty.lua"}},{"name":"new","desc":"Creates and returns a new remote property.","params":[{"name":"initialValue","desc":"","lua_type":"any"}],"returns":[{"desc":"","lua_type":"RemoteProperty"}],"function_type":"static","source":{"line":130,"path":"packages/Remote/Server/RemoteProperty.lua"}},{"name":"IsBoundToClient","desc":"Returns a boolean indicating if the remote property is bound to the client (client remote property).","params":[],"returns":[{"desc":"","lua_type":"boolean"}],"function_type":"method","tags":["RemoteProperty"],"source":{"line":154,"path":"packages/Remote/Server/RemoteProperty.lua"}},{"name":"BindToRemote","desc":"","params":[],"returns":[],"function_type":"method","ignore":true,"source":{"line":162,"path":"packages/Remote/Server/RemoteProperty.lua"}},{"name":"Destroy","desc":"Destroys the remote property and renders it unusable, also destroys the client remote property binded to it.","params":[],"returns":[],"function_type":"method","tags":["RemoteProperty"],"source":{"line":183,"path":"packages/Remote/Server/RemoteProperty.lua"}},{"name":"GetPlayerValue","desc":"Returns the specific value of `player` stored in the remote property, or the current value of the remote property.","params":[{"name":"player","desc":"","lua_type":"Player"}],"returns":[{"desc":"","lua_type":"any"}],"function_type":"method","tags":["RemoteProperty"],"source":{"line":195,"path":"packages/Remote/Server/RemoteProperty.lua"}},{"name":"GetInitialValue","desc":"Returns the initial value of the remote property.\\n\\nFor e.g:\\n\\n```lua\\nlocal remoteProperty = RemoteProperty.new(50) -- 50 is the initial value\\nremoteProperty:SetValue(100)\\nprint(remoteProperty:GetInitialValue()) --\x3e 50\\n```","params":[],"returns":[{"desc":"","lua_type":"any"}],"function_type":"method","tags":["RemoteProperty"],"source":{"line":233,"path":"packages/Remote/Server/RemoteProperty.lua"}},{"name":"SetSpecificPlayerValues","desc":"Sets the value of each player (stored in the remote property) in `players` to `newValue`, and updates \\nthe client remote property of each player (bound to this remote property) to the new value.\\n\\n:::warning\\nThis method is illegal to call if the remote property isn\'t bound to the client!\\n:::","params":[{"name":"players","desc":"","lua_type":"table"},{"name":"newValue","desc":"","lua_type":"any"}],"returns":[],"function_type":"method","tags":["RemoteProperty"],"yields":true,"source":{"line":251,"path":"packages/Remote/Server/RemoteProperty.lua"}},{"name":"SetAllPlayerValues","desc":"Sets the value of each player (stored in the remote property) to `newValue` and updates each client remote property bound\\nto this remote property to the new value. New players will have their client remote property (bound to this remote property) to be\\nupdated this new value automatically. \\n\\n:::warning\\nThis method is illegal to call if the remote property isn\'t bound to the client.\\n:::","params":[{"name":"newValue","desc":"","lua_type":"any"}],"returns":[],"function_type":"method","tags":["RemoteProperty"],"yields":true,"source":{"line":281,"path":"packages/Remote/Server/RemoteProperty.lua"}},{"name":"GetValue","desc":"Returns the current value of the remote property.","params":[],"returns":[{"desc":"","lua_type":"any"}],"function_type":"method","tags":["RemoteProperty"],"source":{"line":304,"path":"packages/Remote/Server/RemoteProperty.lua"}}],"properties":[{"name":"OnValueUpdate","desc":"A signal which is fired whenever the value stored in the remote property is updated to a new one.\\n\\n```lua\\nremoteProperty.ValueUpdate:Connect(function(newValue)\\n\\tprint((\\"Value was updated to %s\\"):format(tostring(newValue)))\\nend)\\n```","lua_type":"Signal <newValue: any>","tags":["RemoteProperty"],"readonly":true,"source":{"line":82,"path":"packages/Remote/Server/RemoteProperty.lua"}},{"name":"OnPlayerValueUpdate","desc":"A signal which is fired whenever the value of a player is updated to a new one.\\n\\n```lua\\nremoteProperty.OnPlayerValueUpdate:Connect(function(player, newValue)\\n\\tprint((\\"%s\'s value was updated to %s\\"):format(tostring(newValue)))\\nend)\\n```","lua_type":"Signal <player: Player, newValue: any>","tags":["RemoteProperty"],"readonly":true,"source":{"line":97,"path":"packages/Remote/Server/RemoteProperty.lua"}}],"types":[],"name":"RemoteProperty","desc":"Remote properties are serverside properties which contain getter and setter methods and\\nstore a value which can be retrieved by those methods, and are also an abstraction of remote functions. They can \\nalso be exposed to the client through communication signals.\\n\\nFor e.g:\\n\\n```lua\\n-- On the server:\\nlocal communicationSignal = CommunicationSignal.new(\\"Signal\\")\\n\\nlocal remoteProperty = RemoteProperty.new(50)\\n\\n-- Expose the remote to the client\\ncommunicationSignal:Bind(\\"P\\", remoteProperty)\\ncommunicationSignal:DispatchToClient()\\n\\n-- On the client:\\nlocal communicationSignal = CommunicationSignal.GetDispatchedCommunicationSignal(\\"Signal\\"):expect()\\nprint(communicationSignal.RemoteProperties.P:GetValue()) --\x3e 50\\n```\\n\\n:::tip\\nRemote properties can also store in player specific values. Making them great for replicating and storing\\nvalues separate to each player!\\n\\n```lua\\n-- Set value 50, but only game.Players.finobinos should see this new value.\\nremoteProperty:SetValue(50, {game.Players.finobinos})\\n```\\n:::\\n\\n:::note\\nRemote function limitations apply. For more information, see [Remote Functions and Events](https://developer.roblox.com/en-us/articles/Remote-Functions-and-Events).\\n:::","realm":["Server"],"source":{"line":67,"path":"packages/Remote/Server/RemoteProperty.lua"}}')}}]);