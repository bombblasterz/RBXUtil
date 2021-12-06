"use strict";(self.webpackChunkdocs=self.webpackChunkdocs||[]).push([[877],{13330:function(e){e.exports=JSON.parse('{"functions":[{"name":"new","desc":"Creates and returns a new communication signal with the identifier of `identifier`.","params":[{"name":"identifier","desc":"","lua_type":"string"}],"returns":[{"desc":"","lua_type":"CommunicationSignal"}],"function_type":"static","source":{"line":102,"path":"packages/Remote/Server/CommunicationSignal/init.lua"}},{"name":"GetCommunicationSignal","desc":"Returns the communication signal of identifier `identifier`.","params":[{"name":"identifier","desc":"","lua_type":"string"}],"returns":[{"desc":"","lua_type":"CommunicationSignal"}],"function_type":"static","source":{"line":135,"path":"packages/Remote/Server/CommunicationSignal/init.lua"}},{"name":"IsA","desc":"A method which returns a boolean indicating if `self` is a communication signal or not.","params":[{"name":"self","desc":"","lua_type":"any"}],"returns":[{"desc":"","lua_type":"boolean"}],"function_type":"static","source":{"line":160,"path":"packages/Remote/Server/CommunicationSignal/init.lua"}},{"name":"Bind","desc":"Binds a new key `key` of value `value` to the client. \\n\\n:::note\\n- It is illegal to call this method if the communication signal is already dispatched to the client.\\n- Remote function limitations apply, see [Remote Functions and Events](https://developer.roblox.com/en-us/articles/Remote-Functions-and-Events).\\n:::","params":[{"name":"key","desc":"","lua_type":"string"},{"name":"value","desc":"","lua_type":"any"}],"returns":[],"function_type":"method","tags":["CommunicationSignal"],"source":{"line":178,"path":"packages/Remote/Server/CommunicationSignal/init.lua"}},{"name":"DispatchToClient","desc":"Dispatches the communication signal to the client. Only call this method when the communication signal is ready\\nto be exposed to the client.","params":[],"returns":[],"function_type":"method","tags":["CommunicationSignal"],"source":{"line":209,"path":"packages/Remote/Server/CommunicationSignal/init.lua"}},{"name":"IsDispatchedToClient","desc":"Returns a boolean indicating if the communication signal has been dispatched\\nto the client.","params":[],"returns":[{"desc":"","lua_type":"boolean"}],"function_type":"method","tags":["CommunicationSignal"],"source":{"line":222,"path":"packages/Remote/Server/CommunicationSignal/init.lua"}},{"name":"Destroy","desc":"Destroys the communication signal, renders it unusable and cleans up everything including bound remote signals\\nand remote properties (if they weren\'t destroyed yet).","params":[],"returns":[],"function_type":"method","tags":["CommunicationSignal"],"source":{"line":234,"path":"packages/Remote/Server/CommunicationSignal/init.lua"}}],"properties":[{"name":"Members","desc":"A dictionary of all members binded to the communication signal.","lua_type":"table","tags":["CommunicationSignal"],"readonly":true,"source":{"line":64,"path":"packages/Remote/Server/CommunicationSignal/init.lua"}},{"name":"RemoteSignals","desc":"A dictionary of all remote signals binded to the communication signal.","lua_type":"table","tags":["CommunicationSignal"],"readonly":true,"source":{"line":73,"path":"packages/Remote/Server/CommunicationSignal/init.lua"}},{"name":"RemoteProperties","desc":"A dictionary of all remote properties binded to the communication signal.","lua_type":"table","tags":["CommunicationSignal"],"readonly":true,"source":{"line":82,"path":"packages/Remote/Server/CommunicationSignal/init.lua"}}],"types":[],"name":"CommunicationSignal","desc":"Communication signals are used to expose members, methods, remote signals and remote properties\\nto the client in a much easier and abstracted fashion.\\n\\n```lua\\n-- On the server\\nlocal communicationSignal = CommunicationSignal.new(\\"SomeSignal\\")\\n\\n-- Bind method \\"Test\\" to the client:\\ncommunicationSignal:Bind(\\"Test\\", function(player)\\n\\treturn \\"Hey!\\"\\nend))\\n\\n-- Bind member \\"Bo\\" to the client:\\ncommunicationSignal:Bind(\\"Bo\\", {1, 2, 3})\\ncommunicationSignal:DispatchToClient()\\n\\n-- On the client\\nlocal clientSignal = CommunicationSignal.GetDispatchedCommunicationSignal(\\"SomeSignal\\"):expect()\\n\\nprint(clientSignal.Members.Test(\\"Hi\\")) --\x3e \\"Hey!\\"\\nprint( clientSignal.Members.Bo) --\x3e {1, 2, 3}\\n```","realm":["Server"],"source":{"line":55,"path":"packages/Remote/Server/CommunicationSignal/init.lua"}}')}}]);