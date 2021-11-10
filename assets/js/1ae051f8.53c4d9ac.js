"use strict";(self.webpackChunkdocs=self.webpackChunkdocs||[]).push([[53],{17461:function(e){e.exports=JSON.parse('{"functions":[{"name":"IsA","desc":"A method which returns a boolean indicating if `self` is a remote signal or not.","params":[{"name":"self","desc":"","lua_type":"any"}],"returns":[{"desc":"","lua_type":"boolean"}],"function_type":"static","source":{"line":45,"path":"packages/Remote/RemoteSignal.lua"}},{"name":"new","desc":"Creates and returns a new remote signal.","params":[],"returns":[{"desc":"","lua_type":"RemoteSignal"}],"function_type":"static","source":{"line":55,"path":"packages/Remote/RemoteSignal.lua"}},{"name":"IsBoundToClient","desc":"Returns a boolean indicating if the remote signal is bound to the client.","params":[],"returns":[{"desc":"","lua_type":"boolean"}],"function_type":"method","tags":["RemoteSignal"],"source":{"line":77,"path":"packages/Remote/RemoteSignal.lua"}},{"name":"Destroy","desc":"Destroys the remote signal and makes it unusuable, also destroys the client remote signal binded to it.\\n\\n:::warning \\nTrivial errors will occur if your code unintentionally works on a destroyed remote signal, only call this method when you\'re done working with it!\\n:::","params":[],"returns":[],"function_type":"method","tags":["RemoteSignal"],"source":{"line":97,"path":"packages/Remote/RemoteSignal.lua"}},{"name":"Connect","desc":"Works the same as `self._remote:Connect(callback)`.  ","params":[],"returns":[{"desc":"","lua_type":"RBXScriptConnection"}],"function_type":"method","tags":["RemoteSignal"],"source":{"line":108,"path":"packages/Remote/RemoteSignal.lua"}},{"name":"FireClient","desc":"Works the same as `self._remote:FireClient(client, ...)`.  ","params":[{"name":"client","desc":"","lua_type":"Player"},{"name":"...","desc":"","lua_type":"any"}],"returns":[],"function_type":"method","tags":["RemoteSignal"],"source":{"line":130,"path":"packages/Remote/RemoteSignal.lua"}},{"name":"FireAllClients","desc":"Works the same as `self._remote:FireAllClients(player, ...`).","params":[{"name":"...","desc":"","lua_type":"any"}],"returns":[],"function_type":"method","tags":["RemoteSignal"],"source":{"line":151,"path":"packages/Remote/RemoteSignal.lua"}},{"name":"FireSpecificClients","desc":"Works the same as `self._remote:FireClient(player, ...`), but for all players in the `clients` table.","params":[{"name":"clients","desc":"","lua_type":"table"},{"name":"...","desc":"","lua_type":"any"}],"returns":[],"function_type":"method","tags":["RemoteSignal"],"source":{"line":163,"path":"packages/Remote/RemoteSignal.lua"}}],"properties":[],"types":[],"name":"RemoteSignal","desc":"Remote signals are an abstraction of remote events i.e they can be created on the server and exposed to the client\\nthrough communication signals.","realm":["Server"],"source":{"line":28,"path":"packages/Remote/RemoteSignal.lua"}}')}}]);