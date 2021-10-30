"use strict";(self.webpackChunkdocs=self.webpackChunkdocs||[]).push([[38],{95972:function(e){e.exports=JSON.parse('{"functions":[{"name":"GetSignal","desc":"Gets a new serverside communication signal with the identifier of `identifier`.","params":[{"name":"identifier","desc":"","lua_type":"string"}],"returns":[{"desc":"","lua_type":"ClientCommunicationSignal"}],"function_type":"static","source":{"line":167,"path":"packages/Remote/CommunicationSignal/Client.lua"}}],"properties":[{"name":"Members","desc":"A table of all members exposed to the communication signal.\\n\\n:::tip\\nThis table is updated whenever a server exposes a member to the communication signal.\\n:::","lua_type":"table","tags":["ClientCommunicationSignal"],"source":{"line":55,"path":"packages/Remote/CommunicationSignal/Client.lua"}},{"name":"Methods","desc":"A table of all methods exposed to the communication signal.\\n\\n:::tip\\nThis table is updated whenever a server exposes a new method to the communication signal.\\n:::","lua_type":"table","tags":["ClientCommunicationSignal"],"source":{"line":67,"path":"packages/Remote/CommunicationSignal/Client.lua"}},{"name":"RemoteSignals","desc":"A table of all remote signals exposed to the communication signal.\\n\\n:::tip\\nThis table is updated whenever a server exposes a new remote signal to the communication signal.\\n:::","lua_type":"table","tags":["ClientCommunicationSignal"],"source":{"line":79,"path":"packages/Remote/CommunicationSignal/Client.lua"}},{"name":"RemoteProperties","desc":"A table of all remote properties exposed to the communication signal.\\n\\n:::tip\\nThis table is updated whenever a server exposes a new remote property to the communication signal.\\n:::","lua_type":"table","tags":["ClientCommunicationSignal"],"source":{"line":91,"path":"packages/Remote/CommunicationSignal/Client.lua"}},{"name":"OnMethodBinded","desc":"A signal which is fired whenever a new method is binded to the communication signal.\\n\\n```lua\\ncommunicationSignal.OnMethodBinded:Connect(function(name, method)\\n\\nend)\\n```","lua_type":"Signal <methodName : string, method : function>","tags":["ClientCommunicationSignal"],"source":{"line":105,"path":"packages/Remote/CommunicationSignal/Client.lua"}},{"name":"OnMemberBinded","desc":"A signal which is fired whenever a new member is binded to the communication signal. \\n\\n```lua\\ncommunicationSignal.OnMemberBinded:Connect(function(name, value)\\n\\nend)\\n```","lua_type":"Signal <member : any, value : any>","tags":["ClientCommunicationSignal"],"source":{"line":119,"path":"packages/Remote/CommunicationSignal/Client.lua"}},{"name":"OnRemoteSignalBinded","desc":"A signal which is fired whenever a new remote signal is binded to the communication signal. \\n\\n```lua\\ncommunicationSignal.OnRemoteSignalBinded:Connect(function(name, remoteSignal)\\n\\nend)\\n```","lua_type":"Signal <remoteSignalName : string, remoteSignal : ClientRemoteSignal>","tags":["ClientCommunicationSignal"],"source":{"line":133,"path":"packages/Remote/CommunicationSignal/Client.lua"}},{"name":"OnRemotePropertyBinded","desc":"A signal which is fired whenever a new remote property is binded to the communication signal. The name of the remote property\\nand it\'s object are passed as 2 arguments.\\n\\n```lua\\ncommunicationSignal.OnRemotePropertyBinded:Connect(function(name, remoteProperty)\\n\\nend)\\n```","lua_type":"Signal <remotePropertyName : string, remoteProperty : ClientRemoteProperty>","tags":["ClientCommunicationSignal"],"source":{"line":148,"path":"packages/Remote/CommunicationSignal/Client.lua"}}],"types":[],"name":"ClientCommunicationSignal","desc":"A communication signal on the client contains all the methods, members,\\nremote signals and remote properties the server has exposed to it.\\n\\n```lua\\nlocal communicationSignal = CommunicationSignal.GetSignal(\\"ServersideService\\")\\n\\n-- Invoke the method \\"Test\\" (exposed to the signal):\\nlocal method = communicationSignal.Methods.Test\\nmethod(\\"Hi\\")\\n```\\n:::note\\nRemote signals and remote properties exposed are created through client remote signals and client remote properties and binded\\nto their server counterparts.\\n:::","realm":["Client"],"source":{"line":43,"path":"packages/Remote/CommunicationSignal/Client.lua"}}')}}]);