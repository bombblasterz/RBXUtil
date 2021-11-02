"use strict";(self.webpackChunkdocs=self.webpackChunkdocs||[]).push([[38],{95972:function(n){n.exports=JSON.parse('{"functions":[{"name":"GetSignal","desc":"Creates a new client communication signal and binds it with it\'s server counterpart. Returns a promise which is resolved\\nonce the signal is successfully created.\\n\\nFor e.g:\\n\\n```lua\\n-- On the server:\\nlocal signal = CommunicationSignal.new(\\"Signal\\")\\nsignal:BindKeyValuePair(\\"bo\\", true)\\n\\n-- On the client:\\nCommunicationSignal.GetSignal(\\"Signal\\"):andThen(function(signal)\\n\\tprint(signal.Members.bo) --\x3e true\\nend):catch(function(errorMessage)\\n\\twarn(errorMessage)\\nend)\\n```\\n\\n:::warning\\nThe returned signal will be unsuable once the signal\'s serverside counterpart is destroyed, for e.g:\\n\\n```lua\\n-- On the server:\\nlocal signal = CommunicationSignal.new(\\"Signal\\")\\nsignal:BindKeyValuePair(\\"test\\", 1)\\ntask.delay(5, function() signal:Destroy() end))\\n\\n-- On the client\\nlocal sig = CommunicationSignal.GetSignal(\\"Signal\\"):expect()\\nprint(CommunicationSignal.Members.test) --\x3e 1\\ntask.wait(6) -- wait for it to be destroyed on the server\\nprint(CommunicationSignal.Members) --\x3e nil\\n```\\n:::","params":[{"name":"identifier","desc":"","lua_type":"string"}],"returns":[{"desc":"","lua_type":"Promsie"}],"function_type":"static","source":{"line":135,"path":"packages/Remote/CommunicationSignal/Client.lua"}},{"name":"IsA","desc":"A method which is used to check if `self` is a client communication signal or not.","params":[{"name":"self","desc":"","lua_type":"any"}],"returns":[{"desc":"","lua_type":"boolean"}],"function_type":"static","source":{"line":182,"path":"packages/Remote/CommunicationSignal/Client.lua"}},{"name":"Dispatch","desc":"A method which dispatches the client communication signal for client-side use.\\n\\nFor e.g:\\n\\n```lua\\n-- On the server:\\nlocal signal = CommunicationSignal.new(\\"Signal\\")\\nsignal:BindKeyValuePair(\\"Table\\", {1,2,3})\\n\\n-- On the client:\\nlocal clientCommunicationSignal = CommunicationSignal.GetSignal(\\"Signal\\")\\nlocal dispatchedSignal = clientCommunicationSignal:Dispatch()\\n\\n-- Normally to access members you would do:\\nprint(clientCommunicationSignal.Members.Table) --\x3e {1, 2, 3}\\n\\n-- Dispatched signal:\\nprint(dispatchedSignal.Table) --\x3e  {1, 2, 3} \\n```\\n\\n:::tip\\nThe dispatched signal will be updated as new members, remote signals or remote properties are binded. \\n:::\\n\\n:::note\\nThe dispatched signal will be unsuable once the signal\'s serverside counterpart is destroyed, i.e it\'s contents\\nwill be emptied out.\\n\\nFor e.g:\\n\\n```lua\\n-- On the server:\\nlocal signal = CommunicationSignal.new(\\"Signal\\")\\nsignal:BindKeyValuePair(\\"Table\\", {1,2,3})\\ntask.delay(5, function() signal:Destroy() end)\\n\\n-- On the client:\\nlocal clientCommunicationSignal = CommunicationSignal.GetSignal(\\"Signal\\"):expect()\\nlocal dispatchedSignal = clientCommunicationSignal:Dispatch()\\n\\nprint(dispatchedSignal.Table) --\x3e {1, 2, 3}\\ntask.wait(6) -- wait for clientCommunicationSignal to be destroyed on the server\\nprint(dispatchedSignal.Table) --\x3e nil\\n```\\n:::","params":[],"returns":[{"desc":"","lua_type":"table"}],"function_type":"method","source":{"line":237,"path":"packages/Remote/CommunicationSignal/Client.lua"}}],"properties":[{"name":"Members","desc":"A dictionary of all members binded to the signal.","lua_type":"table","tags":["ClientCommunicationSignal"],"source":{"line":64,"path":"packages/Remote/CommunicationSignal/Client.lua"}},{"name":"RemoteSignals","desc":"A dictionary of all remote signals binded to the signal.","lua_type":"table","tags":["ClientCommunicationSignal"],"source":{"line":72,"path":"packages/Remote/CommunicationSignal/Client.lua"}},{"name":"RemoteProperties","desc":"A dictionary of all remote properties binded to the signal.","lua_type":"table","tags":["ClientCommunicationSignal"],"source":{"line":80,"path":"packages/Remote/CommunicationSignal/Client.lua"}},{"name":"Members","desc":"A dictionary of all members binded to the signal.","lua_type":"table","tags":["ClientCommunicationSignal"],"source":{"line":59,"path":"packages/Remote/CommunicationSignal/Server.lua"}},{"name":"RemoteSignals","desc":"A dictionary of all remote signals binded to the signal.","lua_type":"table","tags":["ClientCommunicationSignal"],"source":{"line":67,"path":"packages/Remote/CommunicationSignal/Server.lua"}},{"name":"RemoteProperties","desc":"A dictionary of all remote properties binded to the signal.","lua_type":"table","tags":["ClientCommunicationSignal"],"source":{"line":75,"path":"packages/Remote/CommunicationSignal/Server.lua"}}],"types":[],"name":"ClientCommunicationSignal","desc":"A client communication signal contains all the members, remote signals and remote properties binded to it\'s server\\ncounter part.\\n\\n```lua\\n-- On the server:\\nlocal communicationSignal = CommunicationSignal.new(\\"ServersideService\\")\\ncommunicationSignal:Bind(\\"Test\\", 123)\\ncommunicationSignal:Bind(\\"T\\", {1, 2, 3})\\ncommunicationSignal:Bind(\\"Signal\\", RemoteSignal.new())\\n\\n-- On the client:\\nlocal communicationSignal = CommunicationSignal.GetSignal(\\"ServersideService\\")\\n\\nprint(\\n\\tcommunicationSignal.Members.Test,  --\x3e 123\\n\\tcommunicationSignal.Members.T, --\x3e {1, 2, 3}\\n\\tcommunicationRemote.RemoteSignals.Signal \\n)\\n```\\n:::note\\nRemote signals and remote properties (binded to a signal) are represented differently on the client. They are represented\\nas client remote properties and signals, except they are binded to their serverside counter parts. \\n\\nFor e.g:\\n\\n```lua\\n-- On the server\\nlocal communicationSignal = CommunicationSignal.new(\\"ServersideService\\")\\ncommunicationSignal:BindKeyValuePair(\\"Bo\\", RemoteSignal.new())\\n\\n-- On the client\\nlocal communicationSignal = CommunicationSignal.GetSignal(\\"ServersideService\\"):expect() -- as GetSignal returns a promise\\nprint(ClientRemoteProperty.IsA(communicationSignal.RemoteSignals.Bo)) --\x3e true\\n```\\n:::","realm":["Client"],"source":{"line":56,"path":"packages/Remote/CommunicationSignal/Client.lua"}}')}}]);