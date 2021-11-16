"use strict";(self.webpackChunkdocs=self.webpackChunkdocs||[]).push([[7680],{98147:function(e){e.exports=JSON.parse('{"functions":[{"name":"IsA","desc":"A method which returns a boolean indicating if `self` is a timer or not.","params":[{"name":"self","desc":"","lua_type":"any"}],"returns":[{"desc":"","lua_type":"boolean"}],"function_type":"static","source":{"line":99,"path":"packages/Timer/init.lua"}},{"name":"new","desc":"Creates and returns a new timer. If `updateSignal` is specified, it will be used instead to update the timer or [RunService.Heartbeat](https://developer.roblox.com/en-us/api-reference/event/RunService/Heartbeat) if not specified.\\n\\n:::note\\nIf `updateSignal` is specified, it must be fired with a number as the first argument so that the timer is updated based on the number.\\n:::","params":[{"name":"timer","desc":"","lua_type":"number"},{"name":"updateSignal","desc":"","lua_type":"RBXScriptSignal ?"}],"returns":[{"desc":"","lua_type":"Timer"}],"function_type":"static","source":{"line":115,"path":"packages/Timer/init.lua"}},{"name":"Reset","desc":"Resets the timer.","params":[],"returns":[],"function_type":"method","tags":["Timer"],"source":{"line":149,"path":"packages/Timer/init.lua"}},{"name":"Start","desc":"Starts the timer.","params":[],"returns":[],"function_type":"method","tags":["Timer"],"source":{"line":158,"path":"packages/Timer/init.lua"}},{"name":"IsStopped","desc":"Returns a boolean indicating if the timer has stopped.","params":[],"returns":[{"desc":"","lua_type":"boolean"}],"function_type":"method","tags":["Timer"],"source":{"line":183,"path":"packages/Timer/init.lua"}},{"name":"Pause","desc":"Pauses the timer.","params":[],"returns":[],"function_type":"method","tags":["Timer"],"source":{"line":192,"path":"packages/Timer/init.lua"}},{"name":"Unpause","desc":"Unpauses the timer.","params":[],"returns":[],"function_type":"method","tags":["Timer"],"source":{"line":201,"path":"packages/Timer/init.lua"}},{"name":"IsPaused","desc":"Returns a boolean indicating if the timer has being paused.","params":[],"returns":[{"desc":"","lua_type":"boolean"}],"function_type":"method","tags":["Timer"],"source":{"line":211,"path":"packages/Timer/init.lua"}},{"name":"Destroy","desc":"Destroys the timer and makes it unusuable.\\n\\n:::warning\\nTrivial errors will occur if your code unintentionally works on a destroyed timer, only call this method when you\'re done working with the timer.\\n:::","params":[],"returns":[],"function_type":"method","tags":["Timer"],"source":{"line":225,"path":"packages/Timer/init.lua"}},{"name":"Stop","desc":"Stops the timer.","params":[],"returns":[],"function_type":"method","tags":["Timer"],"source":{"line":241,"path":"packages/Timer/init.lua"}}],"properties":[{"name":"Boost","desc":"A value which by default is 0. This value is added to the delta time of every approximate frame the timer is updated (or if an update signal was specified, which in case \\nthe numebr fired to the update signal). Increasing it will lead to faster timer updates.\\n\\n```lua\\nlocal timer = Timer.new(5)\\ntimer.Boost = 4\\n\\ntimer:Start()\\n\\ntimer.OnTick:Connect(function(deltaTime)\\n\\tprint(deltaTime) --\x3e 8 (approx) \\nend)\\n```","lua_type":"number","tags":["Timer"],"readonly":true,"source":{"line":61,"path":"packages/Timer/init.lua"}},{"name":"OnTick","desc":"A signal which is fired whenever the timer \\"ticks\\" (when started). \\n\\n```lua\\ntimer.OnTick:Connect(function(deltaTime)\\n\\twarn((\\"After %d seconds, tick!\\"):format(deltaTime))\\nend)\\n\\ntimer:Start()\\n```","lua_type":"Signal <deltaTime: number>","tags":["Timer"],"readonly":true,"source":{"line":78,"path":"packages/Timer/init.lua"}}],"types":[],"name":"Timer","desc":"Timers are objects designed to work like alarms and are used to run code\\nat a specific later time.\\n\\nFor e.g:\\n```lua\\nlocal timer = Timer.new()\\ntimer.OnTick:Connect(function(deltaTime)\\n\\twarn((\\"Approximately %d seconds have passed\\"):format(deltaTime))\\nend)\\n\\ntimer:Start()\\n```","source":{"line":40,"path":"packages/Timer/init.lua"}}')}}]);