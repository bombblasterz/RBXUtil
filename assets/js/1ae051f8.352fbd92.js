"use strict";(self.webpackChunkdocs=self.webpackChunkdocs||[]).push([[2053],{17461:function(e){e.exports=JSON.parse('{"functions":[{"name":"IsA","desc":"A method which returns a boolean indicating if `self` is a remote signal or not.","params":[{"name":"self","desc":"","lua_type":"any"}],"returns":[{"desc":"","lua_type":"boolean"}],"function_type":"static","source":{"line":47,"path":"packages/Remote/Server/RemoteSignal.lua"}},{"name":"new","desc":"Creates and returns a new remote signal.","params":[],"returns":[{"desc":"","lua_type":"RemoteSignal"}],"function_type":"static","source":{"line":57,"path":"packages/Remote/Server/RemoteSignal.lua"}},{"name":"IsBoundToClient","desc":"Returns a boolean indicating if the remote signal is bound to the client.","params":[],"returns":[{"desc":"","lua_type":"boolean"}],"function_type":"method","tags":["RemoteSignal"],"source":{"line":76,"path":"packages/Remote/Server/RemoteSignal.lua"}},{"name":"Destroy","desc":"Destroys the remote signal and renders it unusuable, also destroys the client remote signal binded to it.","params":[],"returns":[],"function_type":"method","tags":["RemoteSignal"],"source":{"line":96,"path":"packages/Remote/Server/RemoteSignal.lua"}},{"name":"Connect","desc":"Works the same as `self._remote:Connect(callback)`.  ","params":[],"returns":[{"desc":"","lua_type":"RBXScriptConnection"}],"function_type":"method","tags":["RemoteSignal"],"source":{"line":107,"path":"packages/Remote/Server/RemoteSignal.lua"}},{"name":"FireClient","desc":"Works the same as `self._remote:FireClient(client, ...)`.  ","params":[{"name":"client","desc":"","lua_type":"Player"},{"name":"...","desc":"","lua_type":"any"}],"returns":[],"function_type":"method","tags":["RemoteSignal"],"source":{"line":134,"path":"packages/Remote/Server/RemoteSignal.lua"}},{"name":"FireAllClients","desc":"Works the same as `self._remote:FireAllClients(player, ...`).","params":[{"name":"...","desc":"","lua_type":"any"}],"returns":[],"function_type":"method","tags":["RemoteSignal"],"source":{"line":150,"path":"packages/Remote/Server/RemoteSignal.lua"}},{"name":"FireSpecificClients","desc":"Works the same as `self._remote:FireClient(player, ...`), but for all players in the `clients` table.","params":[{"name":"clients","desc":"","lua_type":"table"},{"name":"...","desc":"","lua_type":"any"}],"returns":[],"function_type":"method","tags":["RemoteSignal"],"source":{"line":162,"path":"packages/Remote/Server/RemoteSignal.lua"}}],"properties":[],"types":[],"name":"RemoteSignal","desc":"Remote signals are an abstraction of remote events i.e they can be created on the server and exposed to the client\\nthrough communication signals.","realm":["Server"],"source":{"line":28,"path":"packages/Remote/Server/RemoteSignal.lua"}}')}}]);