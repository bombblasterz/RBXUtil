"use strict";(self.webpackChunkdocs=self.webpackChunkdocs||[]).push([[417],{29498:function(e){e.exports=JSON.parse('{"functions":[{"name":"new","desc":"A constructor method which creates a new maid.","params":[],"returns":[{"desc":"","lua_type":"Maid"}],"function_type":"static","source":{"line":70,"path":"packages/Maid/init.lua"}},{"name":"IsMaid","desc":"A method which is used to check if the given argument is a maid or not.","params":[{"name":"self","desc":"","lua_type":"any"}],"returns":[{"desc":"","lua_type":"boolean"}],"function_type":"static","source":{"line":83,"path":"packages/Maid/init.lua"}},{"name":"AddTask","desc":"Adds a task for the maid to cleanup. \\n\\n:::note\\nIf `table` is passed as a task, it must have a `Destroy` or `Disconnect` method!\\n:::","params":[{"name":"task","desc":"","lua_type":"function | RBXScriptConnection | table | Instance"}],"returns":[{"desc":"","lua_type":"task"}],"function_type":"method","tags":["Maid"],"source":{"line":99,"path":"packages/Maid/init.lua"}},{"name":"RemoveTask","desc":"Removes the task so that it will not be cleaned up. ","params":[{"name":"task","desc":"","lua_type":"function | RBXScriptConnection | table | Instance"}],"returns":[],"function_type":"method","tags":["Maid"],"source":{"line":126,"path":"packages/Maid/init.lua"}},{"name":"Cleanup","desc":"Cleans up all the added tasks.\\n\\n| Task      | Type                          |\\n| ----------- | ------------------------------------ |\\n| `function`  | The function will be called.  |\\n| `table`     | Any `Destroy` or `Disconnect` method in the table will be called. |\\n| `Instance`    | The instance will be destroyed. |\\n| `RBXScriptConnection`    | The connection will be disconnected. |","params":[],"returns":[],"function_type":"method","tags":["Maid"],"source":{"line":142,"path":"packages/Maid/init.lua"}},{"name":"Destroy","desc":"Destroys the maid by first cleaning up all tasks, and then setting all the keys in it to `nil` \\nand lastly, sets the metatable of the maid to `nil`. \\n\\n:::warning\\nTrivial errors will occur if your code unintentionally works on a destroyed maid, only call this method when you\'re done working with the maid.\\n:::","params":[],"returns":[],"function_type":"method","tags":["Maid"],"source":{"line":180,"path":"packages/Maid/init.lua"}},{"name":"LinkToInstance","desc":"Links the given instance to the maid so that the maid will clean up all the tasks once the instance has been destroyed\\nvia `Instance:Destroy`. The connection returned by this maid contains the following methods:\\n\\n| Methods      | Description                          |\\n| ----------- | ------------------------------------ |\\n| `Disconnect`  | The connection will be disconnected and the maid will unlink to the instance it was linked to.  |\\n| `IsConnected` | Returns a boolean indicating if the connection has been disconnected. |\\n\\nNote that the maid will still unlink to the given instance if it has been cleaned up!","params":[{"name":"instance","desc":"","lua_type":"Instance"}],"returns":[{"desc":"","lua_type":"Connection"}],"function_type":"method","source":{"line":222,"path":"packages/Maid/init.lua"}}],"properties":[],"types":[],"name":"Maid","desc":"Maids track tasks and clean them when needed.\\n\\nFor e.g:\\n```lua\\nlocal maid = Maid.new()\\nlocal connection = workspace.ChildAdded:Connect(function()\\n\\nend)\\nmaid:AddTask(connection)\\nmaid:Cleanup()\\n\\n-- Connections aren\'t necessarily immediately disconnected when `Disconnect` is called on the.\\n-- Much reliable to check in the next engine execution step:\\ntask.defer(function()\\n\\tprint(connection.Connected) --\x3e false\\nend)\\n```","source":{"line":42,"path":"packages/Maid/init.lua"}}')}}]);