"use strict";(self.webpackChunkdocs=self.webpackChunkdocs||[]).push([[101],{98217:function(n){n.exports=JSON.parse('{"functions":[{"name":"IsA","desc":"A method which returns a boolean indicating if `self` is a signal or not.","params":[{"name":"self","desc":"","lua_type":"any"}],"returns":[{"desc":"","lua_type":"boolean"}],"function_type":"static","source":{"line":69,"path":"packages/Signal/init.lua"}},{"name":"new","desc":"Creates and returns a new signal.","params":[],"returns":[{"desc":"","lua_type":"Signal"}],"function_type":"static","source":{"line":79,"path":"packages/Signal/init.lua"}},{"name":"Connect","desc":"Connects `callback` to the signal so that it will be called when `Signal:Fire` or `Signal:DeferredFire` are called, and the arguments\\npassed to them will be passed to `callback`. This method returns a connection which contains the following methods:\\n\\n| Methods      | Description                          |\\n| ----------- | ------------------------------------ |\\n| `Disconnect`  | The connection will be disconnected. |\\n| `IsConnected` | Returns a boolean indicating if the connection is connected or not. |","params":[{"name":"callback","desc":"","lua_type":"function"}],"returns":[{"desc":"","lua_type":"Connection"}],"function_type":"method","tags":["Signal"],"source":{"line":147,"path":"packages/Signal/init.lua"}},{"name":"CleanupConnections","desc":"Disconnects all connections created through `Signal:Connect`.\\n\\n:::note\\nThreads yielded under `signal:Wait` will be disregarded if this method is called and thus will not be resumed\\nwhen `signal:Fire` is called. \\n\\nFor e.g:\\n\\n```lua\\nlocal signal = Signal.new()\\n\\ntask.spawn(function()\\n\\tprint(signal:Wait()) -- infinite yield\\nend)\\n\\nsignal:CleanupConnections()\\nsignal:Fire() \\n```\\n:::","params":[],"returns":[],"function_type":"method","tags":["Signal"],"source":{"line":190,"path":"packages/Signal/init.lua"}},{"name":"Destroy","desc":"Destroys the signal and renders it unusuable.","params":[],"returns":[],"function_type":"method","tags":["Signal"],"source":{"line":206,"path":"packages/Signal/init.lua"}},{"name":"Wait","desc":"Yields the current Luau thread until the signal is fired through `Signal:Fire` or `Signal:DeferredFire`. All \\narguments passed to those methods (which were called) will be returned by this method.","params":[],"returns":[{"desc":"","lua_type":"..."}],"function_type":"method","tags":["Signal"],"yields":true,"source":{"line":224,"path":"packages/Signal/init.lua"}},{"name":"Fire","desc":"Resumes any yielded threads and calls every connected connection\'s callback passing in `...` as the argument.","params":[{"name":"...","desc":"","lua_type":"any"}],"returns":[],"function_type":"method","tags":["Signal"],"source":{"line":243,"path":"packages/Signal/init.lua"}},{"name":"DeferredFire","desc":"Works the same as `Signal:Fire`, but calls every connected connection\'s callback in the _next engine execution step_, \\npassing in `...` as the argument.","params":[{"name":"...","desc":"","lua_type":"any"}],"returns":[],"function_type":"method","tags":["Signal"],"source":{"line":255,"path":"packages/Signal/init.lua"}}],"properties":[{"name":"ConnectionCount","desc":"The number of active connections.","lua_type":"number","tags":["Signal"],"readonly":true,"source":{"line":53,"path":"packages/Signal/init.lua"}}],"types":[],"name":"Signal","desc":"In layman\'s terms, signals dispatch events with necessary information.\\n\\nHere\'s an example use case for them:\\n\\n```lua\\nlocal signal = Signal.new()\\n\\nsignal:Connect(function(data)\\n\\tprint(data) --\x3e \\"Signals dispatch information like this one!\\"\\nend\\n\\nsignal:Fire(\\"Signals dispatch information like this one!\\")\\n```","source":{"line":44,"path":"packages/Signal/init.lua"}}')}}]);