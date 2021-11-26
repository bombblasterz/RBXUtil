"use strict";(self.webpackChunkdocs=self.webpackChunkdocs||[]).push([[5377],{42202:function(e){e.exports=JSON.parse('{"functions":[{"name":"GetDeltaPosition","desc":"Returns the position of the mouse from the last frame to the current.","params":[],"returns":[{"desc":"","lua_type":"Vector3"}],"function_type":"static","source":{"line":168,"path":"packages/UserInput/Mouse.lua"}},{"name":"CastRay","desc":"Casts a ray from the mouse\'s current position to it\'s position extended `distance` studs, respecting `raycastParams` if provided.","params":[{"name":"raycastParams","desc":"","lua_type":"RaycastParams ?"},{"name":"distance","desc":"","lua_type":"number"}],"returns":[{"desc":"","lua_type":"RaycastResult ?"}],"function_type":"static","source":{"line":180,"path":"packages/UserInput/Mouse.lua"}},{"name":"LockCurrentPosition","desc":"Locks the mouse to it\'s current position, same as `UserInputService.MouseBehavior = Enum.MouseBehavior.LockCurrentPosition`.","params":[],"returns":[],"function_type":"static","source":{"line":206,"path":"packages/UserInput/Mouse.lua"}},{"name":"Unlock","desc":"Unlocks the mouse, same as `UserInputService.MouseBehavior = Enum.MouseBehavior.Default`.","params":[],"returns":[],"function_type":"static","source":{"line":214,"path":"packages/UserInput/Mouse.lua"}},{"name":"SetLockOnCenter","desc":"Locks the mouse to the center, same as `UserInputService.MouseBehavior = Enum.MouseBehavior.LockCenter`.","params":[],"returns":[],"function_type":"static","source":{"line":222,"path":"packages/UserInput/Mouse.lua"}},{"name":"AddTargetFilter","desc":"Adds all instances in `targetFilter` so that they will be filtered out when calculating `Mouse.Hit` and `Mouse.Target`.","params":[{"name":"targetFilters","desc":"","lua_type":"table"}],"returns":[],"function_type":"static","source":{"line":232,"path":"packages/UserInput/Mouse.lua"}},{"name":"SetTargetFilterType","desc":"Sets the filter type to `targetFilterType` which is used internally in filtering \\ninstances added through `Mouse.AddTargetFilter` when calculating `Mouse.Hit` and `Mouse.Target`.\\n\\n| EnumItem      | Description                          |\\n| ----------- | ------------------------------------ |\\n| `Enum.RaycastFilterType.Whitelist`       | Only the instances added through `Mouse.AddTargetFilter` will be respected.  |\\n| `Enum.RaycastFilterType.Blacklist`       | The instances added through `Mouse.AddTargetFilter` will be ignored.  |\\n\\nBy default, the filter type is `Enum.RaycastFilterType.Blacklist`.\\n\\n:::note\\n`targetFilterType` must be `Enum.RaycastFilterType.Whitelist` or `Enum.RaycastFilterType.Blacklist`.\\n:::","params":[{"name":"targetFilterType","desc":"","lua_type":"EnumItem"}],"returns":[],"function_type":"static","source":{"line":270,"path":"packages/UserInput/Mouse.lua"}},{"name":"RemoveTargetFilter","desc":"Removes all instances in `targetFilter` so that they will not be filtered out when calculating `Mouse.Hit` and `Mouse.Target`.","params":[{"name":"targetFilter","desc":"","lua_type":"table"}],"returns":[],"function_type":"static","source":{"line":290,"path":"packages/UserInput/Mouse.lua"}},{"name":"Init","desc":"","params":[],"returns":[],"function_type":"static","ignore":true,"source":{"line":314,"path":"packages/UserInput/Mouse.lua"}}],"properties":[{"name":"OnLeftClick","desc":"A signal fired whenever the user left clicks on their mouse. ","lua_type":"Signal <isInputProcessed: boolean>","readonly":true,"source":{"line":46,"path":"packages/UserInput/Mouse.lua"}},{"name":"OnRightClick","desc":"A signal fired whenever the user right clicks on their mouse. ","lua_type":"Signal <isInputProcessed: boolean>","readonly":true,"source":{"line":54,"path":"packages/UserInput/Mouse.lua"}},{"name":"OnScrollClick","desc":"A signal fired whenever the user scroll clicks on their mouse. ","lua_type":"Signal <isInputProcessed: boolean>","readonly":true,"source":{"line":62,"path":"packages/UserInput/Mouse.lua"}},{"name":"OnMove","desc":"A signal fired whenever the user moves their mouse. ","lua_type":"Signal <deltaPosition: Vector2>","readonly":true,"source":{"line":70,"path":"packages/UserInput/Mouse.lua"}},{"name":"OnTargetChanged","desc":"A signal fired whenever `Mouse.Target` changes.","lua_type":"Signal <newTarget: Instance ?>","readonly":true,"source":{"line":78,"path":"packages/UserInput/Mouse.lua"}},{"name":"TargetFilters","desc":"A table of target filters, used in retrieving `Mouse.Target` and `Mouse.Hit`.","lua_type":"table","readonly":true,"source":{"line":86,"path":"packages/UserInput/Mouse.lua"}},{"name":"TargetFilterType","desc":"By default, the value is `Enum.RaycastFilterType.Blacklist`. Used as the filter type in\\nretrieving `Mouse.Target` and `Mouse.Hit`. \\n\\n:::note\\nThis member should only be set to `Enum.RaycastFilterType.Blacklist` or `Enum.RaycastFilterType.Whitelist`.\\n:::","lua_type":"RaycastFilterType","readonly":true,"source":{"line":99,"path":"packages/UserInput/Mouse.lua"}},{"name":"Hit","desc":"The cframe the mouse hit in the 3D world.","lua_type":"CFrame","readonly":true,"source":{"line":107,"path":"packages/UserInput/Mouse.lua"}},{"name":"UnitRay","desc":"The unit ray from the mouse\'s 2D position to the 3D world.","lua_type":"Ray","readonly":true,"source":{"line":115,"path":"packages/UserInput/Mouse.lua"}},{"name":"X","desc":"The `X` coordinate of the mouse\'s 2D position on the screen.","lua_type":"number","readonly":true,"source":{"line":123,"path":"packages/UserInput/Mouse.lua"}},{"name":"X","desc":"The `Y` coordinate of the mouse\'s 2D position on the screen.","lua_type":"number","readonly":true,"source":{"line":131,"path":"packages/UserInput/Mouse.lua"}},{"name":"Target","desc":"The instance the mouse hit in the 3D world.","lua_type":"Instance ?","readonly":true,"source":{"line":139,"path":"packages/UserInput/Mouse.lua"}},{"name":"Origin","desc":"The origin of the mouse i.e `Workspace.CurrentCamera.CFrame.Position`.","lua_type":"Vector3","readonly":true,"source":{"line":147,"path":"packages/UserInput/Mouse.lua"}}],"types":[],"name":"Mouse","desc":"The mouse module is a superior module designed over the legacy mouse (which may soon go deprecated in the near future) Roblox has provided us.\\nIt should be used over `player:GetMouse()`.","source":{"line":38,"path":"packages/UserInput/Mouse.lua"}}')}}]);