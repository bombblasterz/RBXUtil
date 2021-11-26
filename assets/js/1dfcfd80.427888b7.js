"use strict";(self.webpackChunkdocs=self.webpackChunkdocs||[]).push([[4832],{25825:function(e){e.exports=JSON.parse('{"functions":[{"name":"IsA","desc":"A method which returns a boolean indicating if `self` is a client remote property or not.","params":[{"name":"self","desc":"","lua_type":"any"}],"returns":[{"desc":"","lua_type":"boolean"}],"function_type":"static","source":{"line":62,"path":"packages/Remote/Client/ClientRemoteProperty.lua"}},{"name":"new","desc":"Creates and returns a new client remote property.","params":[{"name":"currentValue","desc":"","lua_type":"any"}],"returns":[{"desc":"","lua_type":"ClientRemoteProperty"}],"function_type":"static","source":{"line":73,"path":"packages/Remote/Client/ClientRemoteProperty.lua"}},{"name":"IsBoundToServer","desc":"Returns a boolean indicating if the client remote property is bound to the server (remote property).","params":[],"returns":[{"desc":"","lua_type":"boolean"}],"function_type":"method","tags":["ClientRemoteProperty"],"source":{"line":94,"path":"packages/Remote/Client/ClientRemoteProperty.lua"}},{"name":"Destroy","desc":"Destroys the client remote property and renders it unusable.\\n\\n:::note\\n- The client remote property will also be destroyed if the remote property it was bound to is destroyed.\\n- It is undefined behavior to destroy a client remote property if it is bound to the server.\\n:::","params":[],"returns":[],"function_type":"method","tags":["ClientRemoteProperty"],"source":{"line":128,"path":"packages/Remote/Client/ClientRemoteProperty.lua"}},{"name":"SetValue","desc":"Sets the value of the client remote property to `newValue`.\\n\\n:::warning \\nThis method is illegal to call if the client remote property is bound to the server.\\n:::","params":[{"name":"newValue","desc":"","lua_type":"any"}],"returns":[],"function_type":"method","tags":["ClientRemoteProperty"],"source":{"line":143,"path":"packages/Remote/Client/ClientRemoteProperty.lua"}},{"name":"GetValue","desc":"Returns the value of the client remote property. If bound by the server, then it will retrieve the value\\nof the client from it\'s serverside counter part and if there is no value set specifically for the client, \\nthen the value retured will be the current value of the serverside counter part.\\n\\n:::note\\nThis method may temporarily yield the thread.\\n:::","params":[],"returns":[{"desc":"","lua_type":"any"}],"function_type":"method","tags":["ClientRemoteProperty"],"yields":true,"source":{"line":166,"path":"packages/Remote/Client/ClientRemoteProperty.lua"}}],"properties":[{"name":"OnValueUpdate","desc":" \\nA signal which is fired whenever the value of the client remote property is updated.","lua_type":"Signal <newValue: any>","readonly":true,"source":{"line":45,"path":"packages/Remote/Client/ClientRemoteProperty.lua"}}],"types":[],"name":"ClientRemoteProperty","desc":"Client remote properties are clientside objects which work like remote properties in general and can either be\\nbinded to their server counterparts (for server-client relationship) or just work between the client only.\\n\\n```lua\\nlocal clientRemoteProperty = ClientRemoteProperty.new(50)\\nprint(clientRemoteProperty:GetValue()) --\x3e 50\\nclientRemoteProperty:SetValue(clientRemoteProperty:GetValue() + 100)\\nprint(clientRemoteProperty:GetValue()) --\x3e 150\\n```","realm":["Client"],"source":{"line":37,"path":"packages/Remote/Client/ClientRemoteProperty.lua"}}')}}]);