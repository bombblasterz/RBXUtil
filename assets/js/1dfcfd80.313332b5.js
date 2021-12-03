"use strict";(self.webpackChunkdocs=self.webpackChunkdocs||[]).push([[832],{25825:function(e){e.exports=JSON.parse('{"functions":[{"name":"IsA","desc":"A method which returns a boolean indicating if `self` is a client remote property or not.","params":[{"name":"self","desc":"","lua_type":"any"}],"returns":[{"desc":"","lua_type":"boolean"}],"function_type":"static","source":{"line":74,"path":"packages/Remote/Client/ClientRemoteProperty.lua"}},{"name":"new","desc":"Creates and returns a new client remote property.","params":[{"name":"currentValue","desc":"","lua_type":"any"}],"returns":[{"desc":"","lua_type":"ClientRemoteProperty"}],"function_type":"static","source":{"line":85,"path":"packages/Remote/Client/ClientRemoteProperty.lua"}},{"name":"IsBoundToServer","desc":"Returns a boolean indicating if the client remote property is bound to a server remote property.","params":[],"returns":[{"desc":"","lua_type":"boolean"}],"function_type":"method","tags":["ClientRemoteProperty"],"source":{"line":106,"path":"packages/Remote/Client/ClientRemoteProperty.lua"}},{"name":"BindToServer","desc":"","params":[],"returns":[],"function_type":"method","ignore":true,"source":{"line":114,"path":"packages/Remote/Client/ClientRemoteProperty.lua"}},{"name":"Destroy","desc":"Destroys the client remote property, renders it unusable and cleans up everything.\\n\\n:::note\\nYou should only ever destroy the client remote property once you\'re completely done working with it to avoid\\nunexpected behavior.\\n:::","params":[],"returns":[],"function_type":"method","tags":["ClientRemoteProperty"],"source":{"line":133,"path":"packages/Remote/Client/ClientRemoteProperty.lua"}},{"name":"SetValue","desc":"Sets the value of the client remote property to `newValue`. If the client remote property is bound \\nto a serverside remote property, then it will ask that remote property to set the value for the client\\nto `newValue`.","params":[{"name":"newValue","desc":"","lua_type":"any"}],"returns":[],"function_type":"method","tags":["ClientRemoteProperty"],"yields":true,"source":{"line":147,"path":"packages/Remote/Client/ClientRemoteProperty.lua"}},{"name":"GetValue","desc":"Returns the value of the client remote property. If bound to the server (a serverside remote property), \\nthen it will retrieve the value of the client from that serverside remote property and if there is no value \\nset specifically for the client, then it will return the current value of that serverside remote property.","params":[],"returns":[{"desc":"","lua_type":"any"}],"function_type":"method","tags":["ClientRemoteProperty"],"yields":true,"source":{"line":169,"path":"packages/Remote/Client/ClientRemoteProperty.lua"}},{"name":"GetSpecificValue","desc":"This method is slighly different from `ClientRemoteProperty:GetValue`. It returns the specific value (**only**) set \\nfor the client in the serverside remote property that this remote property is bound to.\\n\\n:::warning\\nThis method is illegal to call if the client remote property is not bound to the server (a serverside remote property).\\n:::","params":[],"returns":[{"desc":"","lua_type":"any"}],"function_type":"method","tags":["ClientRemoteProperty"],"yields":true,"source":{"line":190,"path":"packages/Remote/Client/ClientRemoteProperty.lua"}}],"properties":[{"name":"OnValueUpdate","desc":" \\nA signal which is fired whenever the value of the client remote property is updated, either on the client\\nor on the server for the client, if the client remote property is bound to the server (a serverside remote property).","lua_type":"Signal <newValue: any>","tags":["ClientRemoteProperty"],"readonly":true,"source":{"line":54,"path":"packages/Remote/Client/ClientRemoteProperty.lua"}}],"types":[],"name":"ClientRemoteProperty","desc":"A client remote property works similar to a serverside remote property and can either be\\nbound to serverside remote property through communication signals for server-client relationship \\nor just work on the client.\\n\\n```lua\\nlocal clientRemoteProperty = ClientRemoteProperty.new(50)\\n\\nprint(clientRemoteProperty:GetValue()) --\x3e 50\\nclientRemoteProperty:SetValue(100)\\nprint(clientRemoteProperty:GetValue()) --\x3e 100\\n```\\n\\n:::note\\nRemote function limitations and behavior edge cases apply. For more information, see [Remote Functions and Events](https://developer.roblox.com/en-us/articles/Remote-Functions-and-Events).\\n:::","realm":["Client"],"source":{"line":44,"path":"packages/Remote/Client/ClientRemoteProperty.lua"}}')}}]);