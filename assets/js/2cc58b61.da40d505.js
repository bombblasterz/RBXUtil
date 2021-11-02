"use strict";(self.webpackChunkdocs=self.webpackChunkdocs||[]).push([[301],{66827:function(e){e.exports=JSON.parse('{"functions":[{"name":"IsA","desc":"A method which is used to check if `self` is a client remote signal or not.","params":[{"name":"self","desc":"","lua_type":"any"}],"returns":[{"desc":"","lua_type":"boolean"}],"function_type":"static","source":{"line":49,"path":"packages/Remote/ClientRemoteSignal.lua"}},{"name":"new","desc":"Creates and returns a new client remote signal.","params":[],"returns":[{"desc":"","lua_type":"ClientRemoteSignal"}],"function_type":"static","source":{"line":59,"path":"packages/Remote/ClientRemoteSignal.lua"}},{"name":"IsBoundToServer","desc":"Returns a boolean indicating if the client remote signal is bound to the server.","params":[],"returns":[{"desc":"","lua_type":"boolean"}],"function_type":"method","tags":["ClientRemoteSignal"],"source":{"line":79,"path":"packages/Remote/ClientRemoteSignal.lua"}},{"name":"Connect","desc":"Same as `self._remote:Connect(callback)`.","params":[{"name":"callback","desc":"","lua_type":"function"}],"returns":[{"desc":"","lua_type":"RBXScriptConnection"}],"function_type":"method","tags":["ClientRemoteSignal"],"source":{"line":96,"path":"packages/Remote/ClientRemoteSignal.lua"}},{"name":"FireServer","desc":"Same as `self._remote:FireServer(...)`.","params":[{"name":"...","desc":"","lua_type":"any"}],"returns":[],"function_type":"method","tags":["ClientRemoteSignal"],"source":{"line":117,"path":"packages/Remote/ClientRemoteSignal.lua"}},{"name":"Destroy","desc":"Destroys the client remote signal and makes it unusuable.\\n\\n:::warning \\nTrivial errors will occur if your code unintentionally works on a destroyed client remote signal, only call this method when you\'re done working with it!\\n:::","params":[{"name":"...","desc":"","lua_type":"any"}],"returns":[],"function_type":"method","tags":["ClientRemoteSignal"],"source":{"line":132,"path":"packages/Remote/ClientRemoteSignal.lua"}},{"name":"Wait","desc":"Same as `self._remote.OnClientEvent:Wait()`.","params":[],"returns":[{"desc":"","lua_type":"... any"}],"function_type":"method","source":{"line":142,"path":"packages/Remote/ClientRemoteSignal.lua"}}],"properties":[],"types":[],"name":"ClientRemoteSignal","desc":"Client remote signals are used internally by CommunicationSignals to expose serverside remote signals to the client. For e.g,\\na remote signal on the server can only be representable on the client through a client remote signal binded to it.\\n\\n```lua\\ntask.spawn(function()\\n\\tprint(clientRemoteSignal:Wait()) --\x3e \\"yo\\"\\nend)\\n\\nclientRemoteSignal:Fire(\\"yo\\")\\n```","realm":["Client"],"source":{"line":34,"path":"packages/Remote/ClientRemoteSignal.lua"}}')}}]);