"use strict";(self.webpackChunkdocs=self.webpackChunkdocs||[]).push([[144],{80159:function(e){e.exports=JSON.parse('{"functions":[{"name":"IsA","desc":"A method which is used to check if `self` is a ray or not.","params":[{"name":"self","desc":"","lua_type":"any"}],"returns":[{"desc":"","lua_type":"boolean"}],"function_type":"static","source":{"line":151,"path":"packages/Ray/init.lua"}},{"name":"new","desc":"A constructor which creates and returns a new ray from `origin`, `direction` and `params` (if provided).","params":[{"name":"origin","desc":"","lua_type":"Vector3 | nil"},{"name":"direction","desc":"","lua_type":"Vector3"},{"name":"params","desc":"","lua_type":"RaycastParams | nil"}],"returns":[{"desc":"","lua_type":"Ray"}],"function_type":"static","source":{"line":164,"path":"packages/Ray/init.lua"}},{"name":"Visualize","desc":"Visualizes the ray.","params":[],"returns":[],"function_type":"method","tags":["Ray"],"source":{"line":210,"path":"packages/Ray/init.lua"}},{"name":"SetVisualizerThickness","desc":"Sets the thickness of the ray visualizer.","params":[],"returns":[],"function_type":"method","tags":["Ray"],"source":{"line":220,"path":"packages/Ray/init.lua"}},{"name":"Unvisualize","desc":"Unvisualizes the ray.","params":[],"returns":[],"function_type":"method","tags":["Ray"],"source":{"line":240,"path":"packages/Ray/init.lua"}},{"name":"GetTouchingParts","desc":"Gets and returns all the parts the ray is touching within a specified limit `maxTouchingParts` (or `10` if not provided), \\nrespecting the raycast params provided to the constructor.","params":[{"name":"maxTouchingParts","desc":"","lua_type":"number"}],"returns":[{"desc":"","lua_type":"table"}],"function_type":"method","tags":["Ray"],"source":{"line":253,"path":"packages/Ray/init.lua"}},{"name":"Update","desc":"A very useful method which is used for dynamically updating the origin, direction or the size of the ray. \\n\\n| Data members      | Description                          |\\n| ----------- | ------------------------------------ |\\n| `Origin`  | If specified, must be a Vector3.  |\\n| `Direction`     | If specified, must be a Vector3. |\\n| `Size`    | If specified, must be a number. |\\n\\n:::note \\nNote that at least 1 of the members must be specified.\\n:::\\n\\n:::tip \\nOther neccesary data (such as the ray visualizer and other properties) wil be updated as well to accommodate the new changes.\\n:::","params":[{"name":"data","desc":"","lua_type":"table"}],"returns":[],"function_type":"method","tags":["Ray"],"source":{"line":327,"path":"packages/Ray/init.lua"}},{"name":"Destroy","desc":"Destroys the ray and makes it unusable.\\n\\n:::warning \\nTrivial errors will occur if your code unintentionally works on a destroyed ray, only call this method when you\'re done working with the ray!\\n:::","params":[],"returns":[],"function_type":"method","tags":["Ray"],"source":{"line":373,"path":"packages/Ray/init.lua"}}],"properties":[{"name":"Origin","desc":"The origin of the ray.","lua_type":"Vector3","tags":["Ray"],"readonly":true,"source":{"line":51,"path":"packages/Ray/init.lua"}},{"name":"Direction","desc":"The direction of the ray, relative to it\'s origin.","lua_type":"Vector3","tags":["Ray"],"readonly":true,"source":{"line":60,"path":"packages/Ray/init.lua"}},{"name":"Unit","desc":"The unit vector of the direction. Note that in a certain edge case where the direction is `Vector3.new(0, 0, 0)`, then this will be\\n`Vector3.new(0, 1, 0`).","lua_type":"Vector3","tags":["Ray"],"readonly":true,"source":{"line":70,"path":"packages/Ray/init.lua"}},{"name":"Size","desc":"The size of the ray from it\'s origin to it\'s final position.","lua_type":"number","tags":["Ray"],"readonly":true,"source":{"line":79,"path":"packages/Ray/init.lua"}},{"name":"OnInstanceHit","desc":"A signal which is fired whenever an instance \\"hits\\" the ray, respecting raycast params (if provided).","lua_type":"Signal <instanceHit : Instance>","tags":["Ray"],"readonly":true,"source":{"line":88,"path":"packages/Ray/init.lua"}},{"name":"Visualizer","desc":"An instance which is used to visualize the ray. \\n\\n:::note\\nRay visualizers will never be 100% accurate, due to how small rays actually are. However, they will be accurate up to\\n99.2% if their thickness is the default (i.e not set through `Ray:SetVisualizerThickness`).\\n:::","lua_type":"Instance","tags":["Ray"],"readonly":true,"source":{"line":102,"path":"packages/Ray/init.lua"}},{"name":"Results","desc":"A table of raycast results.\\n\\n| Results      | Description                          |\\n| ----------- | ------------------------------------ |\\n| `Instance`  | The BasePart or Terrain cell that the ray intersected.  |\\n| `Position`  | The world space point at which the intersection occurred, usually a point directly on the surface of the instance. |\\n| `Material`  | The Material at the intersection point. For normal parts this is the BasePart.Material; for Terrain this can vary depending on terrain data. |\\n| `Normal`    | The normal vector of the intersected face. |","lua_type":"table","tags":["Ray"],"readonly":true,"source":{"line":118,"path":"packages/Ray/init.lua"}}],"types":[],"name":"Ray","desc":"Rays are objects which extend and abstract the functionality of existing raycast features Roblox has given us.\\n\\nA common use case would be to visualize rays, for e.g:\\n\\n```lua\\nlocal ray = Ray.new(Vector3.new(), Vector3.new(35, 0, 75))\\nray:Visualize() -- Visualize the ray!\\n```","source":{"line":42,"path":"packages/Ray/init.lua"}}')}}]);