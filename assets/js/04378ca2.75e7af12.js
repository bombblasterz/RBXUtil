"use strict";(self.webpackChunkdocs=self.webpackChunkdocs||[]).push([[940],{98217:function(e){e.exports=JSON.parse('{"functions":[{"name":"IsSignal","desc":"Returns a boolean indicating if the provided argument is a signal or not.","params":[{"name":"self","desc":"","lua_type":"any"}],"returns":[{"desc":"","lua_type":"boolean"}],"function_type":"static","source":{"line":70,"path":"packages/Signal/init.lua"}},{"name":"new","desc":"Creates and returns a new signal.","params":[],"returns":[{"desc":"","lua_type":"Signal"}],"function_type":"static","source":{"line":80,"path":"packages/Signal/init.lua"}},{"name":"Connect","desc":"Connects `callback` to the signal so that it will be called when `Signal:Fire` or `Signal:DeferredFire` are called, and the arguments\\npassed to them will be passed to `callback`. This method returns a connection which contains the following methods:\\n\\n| Methods      | Description                          |\\n| ----------- | ------------------------------------ |\\n| `Disconnect`  | The connection will be disconnected and `callback` will be disregarded. |\\n| `IsConnected` | Returns a boolean indicating if the connection has been disconnected. |","params":[{"name":"callback","desc":"","lua_type":"function"}],"returns":[{"desc":"","lua_type":"Connection"}],"function_type":"method","tags":["Signal"],"source":{"line":146,"path":"packages/Signal/init.lua"}},{"name":"CleanupConnections","desc":"Disconnects all active connections.","params":[],"returns":[],"function_type":"method","tags":["Signal"],"source":{"line":169,"path":"packages/Signal/init.lua"}},{"name":"Destroy","desc":"Disconnects all active connections, sets all the keys in the signal to `nil` and sets the metatable of the signal\\nto `nil` as well.\\n\\n:::warning\\nTrivial errors will occur if your code unintentionally works on a destroyed signal, only call this method when you\'re done working with the signal.\\n:::","params":[],"returns":[],"function_type":"method","tags":["Signal"],"source":{"line":192,"path":"packages/Signal/init.lua"}},{"name":"Wait","desc":"Yields the current Luau thread that called it until the signal is fired through `Signal:Fire` or `Signal:DeferredFire`. All\\narguments passed to them will be returned.","params":[],"returns":[],"function_type":"method","tags":["Signal"],"source":{"line":209,"path":"packages/Signal/init.lua"}},{"name":"WaitUntilArgumentsPassed","desc":"Works the same as `Signal:Wait`, but will only resume the Luau thread when `...` have been passed as arguments\\nto `Signal:Fire` or `Signal:DeferredFire`.","params":[{"name":"...","desc":"","lua_type":"any"}],"returns":[{"desc":"","lua_type":"... any"}],"function_type":"method","tags":["Signal"],"source":{"line":232,"path":"packages/Signal/init.lua"}},{"name":"Fire","desc":"Resumes any yielded threads and calls every connection\'s callback passing in `...` as the argument.","params":[{"name":"...","desc":"","lua_type":"any"}],"returns":[],"function_type":"method","tags":["Signal"],"source":{"line":270,"path":"packages/Signal/init.lua"}},{"name":"DeferredFire","desc":"Works the same as `Signal:Fire`, but calls every connection\'s callback **in the next engine execution step**, passing in `...` as the argument.","params":[{"name":"...","desc":"","lua_type":"any"}],"returns":[],"function_type":"method","tags":["Signal"],"source":{"line":294,"path":"packages/Signal/init.lua"}}],"properties":[{"name":"ActiveConnectionCount","desc":"The number of active connections.","lua_type":"number","tags":["Signal"],"source":{"line":53,"path":"packages/Signal/init.lua"}}],"types":[],"name":"Signal","desc":"In layman\'s terms, signals dispatch events with necessary information.\\n\\nHere\'s an example use case for them:\\n\\n```lua\\nlocal signal = Signal.new()\\n\\nsignal:Connect(function(data)\\n\\tprint(data) --\x3e Signals dispatch information like this one!\\nend\\n\\nsignal:Fire(\\"Signals dispatch information like this one!\\")\\n```","source":{"line":45,"path":"packages/Signal/init.lua"}}')}}]);