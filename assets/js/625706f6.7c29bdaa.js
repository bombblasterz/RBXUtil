"use strict";(self.webpackChunkdocs=self.webpackChunkdocs||[]).push([[7967],{20441:function(e){e.exports=JSON.parse('{"functions":[{"name":"GetLastInputType","desc":"Returns the last input type of the client.","params":[],"returns":[{"desc":"","lua_type":"string ?"}],"function_type":"static","source":{"line":104,"path":"packages/UserInput/init.lua"}},{"name":"Get","desc":"Requires the module `moduleName` (if retrievable) and returns it.\\n\\n| Retrievable modules   |\\n| ----------- | \\n| `Mouse`     | \\n| `Keyboard`  | \\n\\n```lua\\nlocal keyboard = UserInput.Get(\\"Keyboard\\")\\n\\nkeyboard.OnKeyDown:Connect(function(key, processed)\\n\\tprint(key)\\nend)\\n```","params":[{"name":"moduleName","desc":"","lua_type":"string"}],"returns":[{"desc":"","lua_type":"table"}],"function_type":"static","source":{"line":152,"path":"packages/UserInput/init.lua"}}],"properties":[{"name":"OnInputTypeChange","desc":"A signal which is fired whenever the input type of the client changes. ","lua_type":"Signal <newInputType: string ?>","readonly":true,"source":{"line":27,"path":"packages/UserInput/init.lua"}},{"name":"InputType","desc":"A dictionary of input types.\\n\\n| InputType   |\\n| ----------- | \\n| `Mouse`     | \\n| `Keyboard`  | \\n| `Gamepad`  |\\n| `Touch`  |\\n| `Accelerometer`  |\\n| `Gyro`  |\\n| `Focus`  |\\n| `TextInput`  |\\n| `InputMethod`  |","lua_type":"table","readonly":true,"source":{"line":47,"path":"packages/UserInput/init.lua"}}],"types":[],"name":"UserInput","desc":"UserInput is a module which provides access to other utility input controllers like `Mouse`, `Device` and `Keyboard`, but also\\nhas few of it\'s own methods and signals.","source":{"line":19,"path":"packages/UserInput/init.lua"}}')}}]);