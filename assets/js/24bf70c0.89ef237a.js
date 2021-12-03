"use strict";(self.webpackChunkdocs=self.webpackChunkdocs||[]).push([[758],{60244:function(e){e.exports=JSON.parse('{"functions":[{"name":"IsA","desc":"A method which returns a boolean indicating if `self` is a remote property or not.","params":[{"name":"self","desc":"","lua_type":"any"}],"returns":[{"desc":"","lua_type":"boolean"}],"function_type":"static","source":{"line":97,"path":"packages/Remote/Server/RemoteProperty.lua"}},{"name":"new","desc":"Creates and returns a new remote property, with the initial value of the remote property being `initialValue`.\\n\\n`clientValueSetValidatorCallback` can be a function which will be run when a client requests to set their value to something\\nthey desire, _if this remote property is binded to the client through a communication signal_. For e.g:\\n\\n```lua\\n-- On the server\\nlocal remoteProperty = RemoteProperty.new(3, function(client, valueTheyWantToSet)\\n\\tif IsValueValid(valueTheyWantToSet) then\\n\\t\\treturn true\\n\\tend\\nend)\\n\\n-- On the client:\\nlocal clientRemoteProperty = ...\\n\\n-- This will tell the serverside remote property to set the value of the client to 50 by first\\n-- calling the onServerInvokeCallback and if it returns true, then the remote property sets the value \\n-- of the client to 50. If onServerInvokeCallback is not specified, then this won\'t work.\\nclientRemoteProperty:SetValue(50) \\n```","params":[{"name":"initialValue","desc":"","lua_type":"any"},{"name":"clientValueSetValidatorCallback","desc":"","lua_type":"function ?"}],"returns":[{"desc":"","lua_type":"RemoteProperty"}],"function_type":"static","source":{"line":129,"path":"packages/Remote/Server/RemoteProperty.lua"}},{"name":"IsBoundToClient","desc":"Returns a boolean indicating if the remote property is bound to the client.","params":[],"returns":[{"desc":"","lua_type":"boolean"}],"function_type":"method","tags":["RemoteProperty"],"source":{"line":166,"path":"packages/Remote/Server/RemoteProperty.lua"}},{"name":"BindToClient","desc":"","params":[],"returns":[],"function_type":"method","ignore":true,"source":{"line":174,"path":"packages/Remote/Server/RemoteProperty.lua"}},{"name":"Destroy","desc":"Destroys the remote property, renders it unusable and cleans up everything.\\n\\n:::note\\nYou should only ever destroy the remote property once you\'re completely done working with it to avoid\\nunexpected behavior.\\n:::","params":[],"returns":[],"function_type":"method","tags":["RemoteProperty"],"source":{"line":208,"path":"packages/Remote/Server/RemoteProperty.lua"}},{"name":"SetValue","desc":"Sets the value of the remote property to `newValue`. If the remote property is bound \\nto the client, then it will update the value for every player to `newValue` and their \\nclient remote property (the one that is bound to this remote property) to `newValue` as well and also\\nupdates the current value of the remote property to `newValue`. \\n\\nIf `clients` is specified, then the value will only be updated for each \\nplayer in the `clients` table.\\n\\n:::note\\nEach client\'s specific value set in the remote property will be flushed (cleared out) when they leave. \\n:::\\n\\n:::warning\\nIt is illegal to set the value for clients only if the remote property isn\'t bound to the client.\\n:::","params":[{"name":"newValue","desc":"","lua_type":"any"},{"name":"clients","desc":"","lua_type":"?"}],"returns":[],"function_type":"method","tags":["RemoteProperty"],"source":{"line":234,"path":"packages/Remote/Server/RemoteProperty.lua"}},{"name":"GetValue","desc":"Returns the current value of the remote property. If `client` is specified, then it will return the **specific** \\nvalue set for `client` in the remote property.","params":[{"name":"client","desc":"","lua_type":"Player ?"}],"returns":[{"desc":"","lua_type":"any"}],"function_type":"method","tags":["RemoteProperty"],"source":{"line":274,"path":"packages/Remote/Server/RemoteProperty.lua"}}],"properties":[{"name":"OnValueUpdate","desc":"A signal which is fired whenever the value stored in the remote property is updated to a new one.\\n\\n```lua\\nremoteProperty.OnValueUpdate:Connect(function(newValue)\\n\\tprint((\\"Value was updated to %s\\"):format(tostring(newValue)))\\nend)\\n```","lua_type":"Signal <newValue: any>","tags":["RemoteProperty"],"readonly":true,"source":{"line":61,"path":"packages/Remote/Server/RemoteProperty.lua"}},{"name":"OnClientValueUpdate","desc":"A signal which is fired whenever the value of a client is updated to a new one.\\n\\n```lua\\nremoteProperty.OnClientValueUpdate:Connect(function(client, newValue)\\n\\tprint((\\"%s\'s value was updated to %s\\"):format(client.Name, tostring(newValue)))\\nend)\\n```","lua_type":"Signal <client: Player, newValue: any>","tags":["RemoteProperty"],"readonly":true,"source":{"line":76,"path":"packages/Remote/Server/RemoteProperty.lua"}}],"types":[],"name":"RemoteProperty","desc":"Remote properties are powerful serverside objects  which contain getter and setter methods and\\nstore a value which can be retrieved by those methods, and are also an abstraction of remote functions which\\ncan also be exposed to the client through communication signals. \\n\\nFor e.g:\\n\\n```lua\\n-- On the server\\nlocal remoteProperty = RemoteProperty.new(50)\\n\\n-- On the client:\\nlocal remoteProperty = ...\\nprint(remoteProperty:GetValue()) --\x3e 50\\n```\\n:::note\\nRemote function limitations and behavior edge cases apply. For more information, see [Remote Functions and Events](https://developer.roblox.com/en-us/articles/Remote-Functions-and-Events).\\n:::","realm":["Server"],"source":{"line":46,"path":"packages/Remote/Server/RemoteProperty.lua"}}')}}]);