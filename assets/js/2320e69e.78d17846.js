"use strict";(self.webpackChunkdocs=self.webpackChunkdocs||[]).push([[8144],{80159:function(e){e.exports=JSON.parse('{"functions":[{"name":"IsA","desc":"A method which returns a boolean indicating if `self` is a ray or not.","params":[{"name":"self","desc":"","lua_type":"any"}],"returns":[{"desc":"","lua_type":"boolean"}],"function_type":"static","source":{"line":160,"path":"packages/Ray/init.lua"}},{"name":"new","desc":"A constructor which creates and returns a new ray from `origin`, `direction` and `params` (if provided).\\n\\n:::note\\n`origin` and `direction` must not be equal to prevent certain CFrame edge cases.\\n:::","params":[{"name":"origin","desc":"","lua_type":"Vector3 ?"},{"name":"direction","desc":"","lua_type":"Vector3"},{"name":"params","desc":"","lua_type":"RaycastParams ?"}],"returns":[{"desc":"","lua_type":"Ray"}],"function_type":"static","source":{"line":177,"path":"packages/Ray/init.lua"}},{"name":"Visualize","desc":"Visualizes the ray.","params":[],"returns":[],"function_type":"method","tags":["Ray"],"source":{"line":218,"path":"packages/Ray/init.lua"}},{"name":"SetVisualizerThickness","desc":"Sets the thickness of the ray visualizer.","params":[],"returns":[],"function_type":"method","tags":["Ray"],"source":{"line":228,"path":"packages/Ray/init.lua"}},{"name":"Unvisualize","desc":"Unvisualizes the ray.","params":[],"returns":[],"function_type":"method","tags":["Ray"],"source":{"line":248,"path":"packages/Ray/init.lua"}},{"name":"GetTouchingParts","desc":"Gets and returns all the parts the ray is touching within a specified limit `maxTouchingParts` (or `30` if not provided), as well as with the surface each part hit.\\n\\n```lua\\nfor surfaceThePartHit, part in pairs(ray:GetTouchingParts()) do\\n\\tprint((\\"%s hit the %s of the ray\\"):format(part.Name, surfaceThePartHit))\\nend\\n```","params":[{"name":"maxTouchingParts","desc":"","lua_type":"number"}],"returns":[{"desc":"","lua_type":"table"}],"function_type":"method","tags":["Ray"],"source":{"line":266,"path":"packages/Ray/init.lua"}},{"name":"AddTargetFilter","desc":"Adds `targetFilter` to the filter list so that it will be filtered out when calculating the instances the ray is intersecting.","params":[{"name":"targetFilter","desc":"","lua_type":"Instance"}],"returns":[],"function_type":"method","source":{"line":295,"path":"packages/Ray/init.lua"}},{"name":"SetTargetFilterType","desc":"Sets the filter type to `targetFilterType` which is used internally in filtering \\ninstances added through `Ray:AddTargetFilter` when calculating the parts the ray is intersecting.\\n\\n| EnumItem      | Description                          |\\n| ----------- | ------------------------------------ |\\n| `Enum.RaycastFilterType.Whitelist`       | Only the instances added through `Ray:AddTargetFilter` will be respected.  |\\n| `Enum.RaycastFilterType.Blacklist`       | The instances added through `Ray:AddTargetFilter` will be ignored.  |\\n\\nBy default, the filter type is set to `Enum.RaycastFilterType.Blacklist`.","params":[{"name":"targetFilterType","desc":"","lua_type":"EnumItem"}],"returns":[],"function_type":"method","tags":["Ray"],"source":{"line":322,"path":"packages/Ray/init.lua"}},{"name":"RemoveTargetFilter","desc":"Removes `targetFilter` fronm the filter list so that it will not be filtered out when calculating the instances the ray is intersecting.","params":[{"name":"targetFilter","desc":"","lua_type":"Instance"}],"returns":[],"function_type":"method","tags":["Ray"],"source":{"line":359,"path":"packages/Ray/init.lua"}},{"name":"Update","desc":"A very useful method which is used for dynamically updating the origin, direction or the size of the ray. \\n\\n| Data members      | Type                          | Description                     |\\n| ----------- | ------------------------------------ | ------------------------------------ |\\n| `Origin`  | Vector3       | The new origin to update to.\\n| `Direction`  | Vector3    |  The new direction to update to.\\n| `Size`    | number        | The new size to update to.\\n\\n:::note \\nNote that at least 1 of these members must be specified.\\n:::\\n\\n:::tip \\nOther neccesary data such as the ray visualizer and other properties wil be updated as well to accommodate the new changes.\\n:::","params":[{"name":"data","desc":"","lua_type":"table"}],"returns":[],"function_type":"method","tags":["Ray"],"source":{"line":396,"path":"packages/Ray/init.lua"}},{"name":"Destroy","desc":"Destroys the ray and renders it unusable.","params":[],"returns":[],"function_type":"method","tags":["Ray"],"source":{"line":429,"path":"packages/Ray/init.lua"}}],"properties":[{"name":"Origin","desc":"The origin of the ray.","lua_type":"Vector3","tags":["Ray"],"readonly":true,"source":{"line":54,"path":"packages/Ray/init.lua"}},{"name":"Direction","desc":"The direction of the ray, relative to it\'s origin.","lua_type":"Vector3","tags":["Ray"],"readonly":true,"source":{"line":63,"path":"packages/Ray/init.lua"}},{"name":"Unit","desc":"The unit vector of the direction. Note that in a certain edge case where the direction is `Vector3.new(0, 0, 0)`, then this will be\\n`Vector3.new(0, 1, 0`).","lua_type":"Vector3","tags":["Ray"],"readonly":true,"source":{"line":73,"path":"packages/Ray/init.lua"}},{"name":"Size","desc":"The size of the ray from it\'s origin to it\'s final position.","lua_type":"number","tags":["Ray"],"readonly":true,"source":{"line":82,"path":"packages/Ray/init.lua"}},{"name":"OnInstanceHit","desc":"A signal which is fired whenever an instance \\"hits\\" the ray, respecting raycast params (if provided).","lua_type":"Signal <instanceHit : Instance>","tags":["Ray"],"readonly":true,"source":{"line":91,"path":"packages/Ray/init.lua"}},{"name":"Visualizer","desc":"An instance which is used to visualize the ray. \\n\\n:::note\\nRay visualizers will never be 100% accurate, due to how small rays actually are. However, they will be accurate up to\\n99.2% if their thickness is the default (i.e not set through `Ray:SetVisualizerThickness`).\\n:::","lua_type":"Instance","tags":["Ray"],"source":{"line":104,"path":"packages/Ray/init.lua"}},{"name":"Results","desc":"A table of raycast results.\\n\\n| Results      | Description                          |\\n| ----------- | ------------------------------------ |\\n| `Instance`  | The BasePart or Terrain cell that the ray intersected.  |\\n| `Position`  | The world space point at which the intersection occurred, usually a point directly on the surface of the instance. |\\n| `Material`  | The Material at the intersection point. For normal parts this is the BasePart.Material; for Terrain this can vary depending on terrain data. |\\n| `Normal`    | The normal vector of the intersected face. |","lua_type":"table","tags":["Ray"],"readonly":true,"source":{"line":120,"path":"packages/Ray/init.lua"}}],"types":[],"name":"Ray","desc":"Rays are objects which extend and abstract the functionality of existing raycast features Roblox has given us.\\n\\nA common use case would be to visualize rays, for e.g:\\n\\n```lua\\nlocal ray = Ray.new(_, Vector3.new(35, 0, 75))\\nray:Visualize() -- Visualize the ray!\\n```","source":{"line":45,"path":"packages/Ray/init.lua"}}')}}]);