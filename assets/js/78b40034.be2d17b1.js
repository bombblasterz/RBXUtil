"use strict";(self.webpackChunkdocs=self.webpackChunkdocs||[]).push([[189],{82155:function(e){e.exports=JSON.parse('{"functions":[{"name":"GetComponentObjectFromInstance","desc":"A method which returns an component object binded to `instance`. If `component` is provided, then\\nthe method will return an object **only** in the component binded to `instance`.","params":[{"name":"instance","desc":"","lua_type":"Instance"},{"name":"component","desc":"","lua_type":"Component | nil"}],"returns":[{"desc":"","lua_type":"table | nil"}],"function_type":"static","source":{"line":143,"path":"packages/Component/init.lua"}},{"name":"GetComponentFromTags","desc":"A method which returns a component whose `RequiredTags` or `OptionalTags` match `tags`.\\n\\n| Tag members      | Description                          |\\n| ----------- | ------------------------------------ |\\n| `OptionalTags`  | This member will be compared against the `OptionalTags` member of the component (if it has one). If they are equal, the component will be returned.  |\\n| `RequiredTags`  | This member will be compared against the `RequiredTags` member of the component (if it has one). If they are equal, the component will be returned. |\\n\\n:::note\\nThe `tags` table must contain only of these members which must be a table.\\n:::\\n\\n```lua\\nlocal tags = {\\n\\tRequiredTags = {\\n\\t\\t\\"A\\",\\n\\t\\t\\"B\\"\\n\\t}\\n}\\n\\n-- Will get a component whose RequiredTags is the same as tags.RequiredTags\\nlocal component = Component.GetComponentFromTags(tags)\\n```","params":[{"name":"tags","desc":"","lua_type":"table"}],"returns":[{"desc":"","lua_type":"table | nil"}],"function_type":"static","source":{"line":278,"path":"packages/Component/init.lua"}},{"name":"IsA","desc":"Returns a boolean indicating if the given argument is a component or not.","params":[{"name":"self","desc":"","lua_type":"any"}],"returns":[{"desc":"","lua_type":"boolean"}],"function_type":"static","source":{"line":309,"path":"packages/Component/init.lua"}},{"name":"GetAll","desc":"Returns an array of all components.","params":[],"returns":[{"desc":"","lua_type":"table"}],"function_type":"static","source":{"line":318,"path":"packages/Component/init.lua"}},{"name":"WaitForComponentFromTags","desc":"Works the same as `Component.GetComponentFromTags`,\\texcept yields the thread until a valid component is found under `timeout` seconds, if provided.","params":[{"name":"tags","desc":"","lua_type":"tags"},{"name":"timeout","desc":"","lua_type":"number | nil"}],"returns":[{"desc":"","lua_type":"Component | nil"}],"function_type":"static","yields":true,"source":{"line":331,"path":"packages/Component/init.lua"}},{"name":"RegisterComponentsIn","desc":"Binds all the descendants (module scripts) in `componentsFolder` such that each will binded to it\'s own\\ncomponent through `Component.new` when `Component.Start` is called. \\n\\n:::note\\nIf the required module script in `componentsFolder` doesn\'t have a `ShouldRegisterAsComponent` member, it will be ignored. \\n:::","params":[{"name":"componentsFolder","desc":"","lua_type":"Folder"}],"returns":[],"function_type":"static","source":{"line":404,"path":"packages/Component/init.lua"}},{"name":"new","desc":"Creates and binds `module` to a new component, `module` must have these members and methods:\\n\\n| Required members and methods     | Description                          |\\n| ----------- | ------------------------------------ |\\n| `.new`  | A constructor method which will be called whenever a new object is to be binded to the component.  |\\n| `:Destroy`     | A method which will be called on a object to be destroyed. |\\n| `OptionalTags` or `RequiredTags`    | The tags that an instance must have in order to be binded to the component |\\n\\n`module` can also have these optional lifecycle methods and members:\\n\\n| Optional lifecycle methods and members     | Description                          |\\n| ----------- | ------------------------------------ |\\n| `PreRenderUpdatePriority`  | An `EnumItem`. Learn more about it [here](https://developer.roblox.com/en-us/api-reference/function/RunService/BindToRenderStep).  |\\n| `:Start`  | A method which will be called on an object added, after `.new` is called for it.  |\\n| `:Stop`     | A method which will be called on an object just before its destroyed. |\\n| `PostSimulationUpdate`  | A method called every `RunService.Heartbeat` on an object. |\\n| `PreSimulationUpdate`  | A method called every `RunService.Stepped` on an object. |\\n| `PreRenderUpdate`  | A method called every `RunService.RenderStepped` on an object. |\\n\\n:::note\\n`module` must have a `ShouldRegisterAsComponent` member in order to have it\'s component created and binded to it.\\n:::","params":[{"name":"module","desc":"","lua_type":"ModuleScript"}],"returns":[],"function_type":"static","source":{"line":457,"path":"packages/Component/init.lua"}},{"name":"Start","desc":"Creates and binds a component to each module script registered through the `RegisterComponentsIn` method.","params":[],"returns":[],"function_type":"static","source":{"line":471,"path":"packages/Component/init.lua"}},{"name":"DestroyAllObjects","desc":"Destroys all objects in the component.","params":[],"returns":[],"function_type":"method","tags":["Component"],"source":{"line":483,"path":"packages/Component/init.lua"}},{"name":"Destroy","desc":"Destroys the component it self i.e cleaning up all signals and destroying all objects.","params":[],"returns":[],"function_type":"method","tags":["Component"],"source":{"line":495,"path":"packages/Component/init.lua"}},{"name":"GetAllObjects","desc":"Returns all the objects in the component.","params":[],"returns":[{"desc":"","lua_type":"table"}],"function_type":"method","tags":["Component"],"source":{"line":506,"path":"packages/Component/init.lua"}}],"properties":[{"name":"OnComponentAdded","desc":"A signal which is fired whenever a component is added. ","lua_type":"Signal <componentAdded : Component>","readonly":true,"source":{"line":50,"path":"packages/Component/init.lua"}},{"name":"OnComponentDestroyed","desc":"A signal which is fired whenever a component is destroyed.","lua_type":"Signal <componentDestroyed : Component>","readonly":true,"source":{"line":58,"path":"packages/Component/init.lua"}},{"name":"OnObjectAdded","desc":"A signal which is fired whenever a new object is created in the component.","lua_type":"Signal <objectAdded: table>","tags":["Component"],"readonly":true,"source":{"line":67,"path":"packages/Component/init.lua"}},{"name":"OnObjectDestroyed","desc":"A signal which is fired whenever an object of the component is destroyed. ","lua_type":"Signal  <objectDestroyed: table>","tags":["Component"],"readonly":true,"source":{"line":76,"path":"packages/Component/init.lua"}},{"name":"Objects","desc":"A table which contains all the active objects of the component.","lua_type":"table","tags":["Component"],"readonly":true,"source":{"line":85,"path":"packages/Component/init.lua"}},{"name":"Tags","desc":"A table which contains the tags of the component i.e `Component.RequiredTags` or `Component.OptionalTags`.","lua_type":"table","tags":["Component"],"readonly":true,"source":{"line":94,"path":"packages/Component/init.lua"}}],"types":[],"name":"Component","desc":"A class which is used to bind instances to tags and extend their functionality. Components are like binders, but are\\nhandled differently.","source":{"line":42,"path":"packages/Component/init.lua"}}')}}]);