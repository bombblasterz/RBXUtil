"use strict";(self.webpackChunkdocs=self.webpackChunkdocs||[]).push([[8797],{66827:function(e){e.exports=JSON.parse('{"functions":[{"name":"IsA","desc":"A method which returns a boolean indicating if `self` is a client remote signal or not.","params":[{"name":"self","desc":"","lua_type":"any"}],"returns":[{"desc":"","lua_type":"boolean"}],"function_type":"static","source":{"line":53,"path":"packages/Remote/Client/ClientRemoteSignal.lua"}},{"name":"new","desc":"Creates and returns a new client remote signal.","params":[],"returns":[{"desc":"","lua_type":"ClientRemoteSignal"}],"function_type":"static","source":{"line":63,"path":"packages/Remote/Client/ClientRemoteSignal.lua"}},{"name":"IsBoundToServer","desc":"Returns a boolean indicating if the client remote signal is bound to the server (remote signal).","params":[],"returns":[{"desc":"","lua_type":"boolean"}],"function_type":"method","tags":["ClientRemoteSignal"],"source":{"line":81,"path":"packages/Remote/Client/ClientRemoteSignal.lua"}},{"name":"BindToRemote","desc":"","params":[],"returns":[],"function_type":"method","ignore":true,"source":{"line":89,"path":"packages/Remote/Client/ClientRemoteSignal.lua"}},{"name":"Connect","desc":"Same as `self._remote:Connect(callback)`.","params":[{"name":"callback","desc":"","lua_type":"function"}],"returns":[{"desc":"","lua_type":"RBXScriptConnection"}],"function_type":"method","tags":["ClientRemoteSignal"],"source":{"line":116,"path":"packages/Remote/Client/ClientRemoteSignal.lua"}},{"name":"FireServer","desc":"Same as `self._remote:FireServer(...)`.","params":[{"name":"...","desc":"","lua_type":"any"}],"returns":[],"function_type":"method","tags":["ClientRemoteSignal"],"source":{"line":147,"path":"packages/Remote/Client/ClientRemoteSignal.lua"}},{"name":"Destroy","desc":"Destroys the client remote signal and makes it unusuable.\\n\\n:::tip Memory leak edge case handling\\nThis method also resumes any threads yielded through `ClientRemoteSignal:Wait` which aren\'t resumed yet, with a `nil` value.\\n\\nFor e.g:\\n\\n```lua\\ntask.spawn(function()\\n\\tprint(clientRemoteSignal:Wait()) --\x3e nil\\nend)\\n\\nclientRemoteSignal:Destroy()\\n```\\n:::\\n\\n:::note\\nThe client remote signal will also be destroyed if the remote signal it was bound to was destroyed.\\n:::","params":[{"name":"...","desc":"","lua_type":"any"}],"returns":[],"function_type":"method","tags":["ClientRemoteSignal"],"source":{"line":176,"path":"packages/Remote/Client/ClientRemoteSignal.lua"}},{"name":"Wait","desc":"A method which yields until the internal signal is fired, i.e when the remote signal is fired\\non the server.","params":[],"returns":[{"desc":"","lua_type":"..."}],"function_type":"method","yields":true,"source":{"line":188,"path":"packages/Remote/Client/ClientRemoteSignal.lua"}}],"properties":[],"types":[],"name":"ClientRemoteSignal","desc":"Client remote signals are used internally by CommunicationSignals to expose serverside remote signals to the client. For e.g,\\na remote signal on the server can only be representable on the client through a client remote signal binded to it through a communication signal.\\n\\n\\n```lua\\ntask.spawn(function()\\n\\tprint(clientRemoteSignal:Wait()) --\x3e \\"yo\\"\\nend)\\n\\nclientRemoteSignal:Fire(\\"yo\\")\\n```","realm":["Client"],"source":{"line":35,"path":"packages/Remote/Client/ClientRemoteSignal.lua"}}')}}]);