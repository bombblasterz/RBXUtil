"use strict";(self.webpackChunkdocs=self.webpackChunkdocs||[]).push([[6241],{8050:function(e){e.exports=JSON.parse('{"functions":[{"name":"DeepFreezeTable","desc":"Freezes `tabl` via `table.freeze`, and all other nested tables in `tabl`.","params":[{"name":"tabl","desc":"","lua_type":"table"}],"returns":[{"desc":"","lua_type":"table"}],"function_type":"static","source":{"line":52,"path":"packages/TableUtil/init.lua"}},{"name":"DeepCopyTable","desc":"Unfreezes `tabl` via `table.unfreeze`, and all other nested tables in `tabl`.","params":[{"name":"tabl","desc":"","lua_type":"table"}],"returns":[{"desc":"","lua_type":"table"}],"function_type":"static","source":{"line":78,"path":"packages/TableUtil/init.lua"}},{"name":"ShallowCopyTable","desc":"Shallow copies all elements in `tabl` to a new table, i.e only the \\"children\\" of `tabl` are considered\\nand not their descendants. \\n\\n```lua\\nlocal t1 = {\\n\\t1,\\n\\t2,\\n\\t3,\\n\\t{\\n\\t\\ta = {}\\n\\t}\\n}\\n\\nprint(TableUtil.ShallowCopyTable(t1))\\n```","params":[{"name":"tabl","desc":"","lua_type":"table"}],"returns":[{"desc":"","lua_type":"table"}],"function_type":"static","source":{"line":119,"path":"packages/TableUtil/init.lua"}},{"name":"ReconcileTable","desc":"Adds all missing elements from `templateTable` to `tabl`, and also sets the metatable of `tabl` to `templateTable`. \\n\\n\\n```lua\\nlocal t1 = {}\\nlocal templateTable = {1, 2, 3}\\n\\nTableUtil.ReconcileTable(t1, templateTable)\\nprint(t1) --\x3e {1, 2, 3}\\n```","params":[{"name":"tabl","desc":"","lua_type":"table"},{"name":"templateTable","desc":"","lua_type":"table"}],"returns":[{"desc":"The first argument passed to this method","lua_type":"table"}],"function_type":"static","source":{"line":151,"path":"packages/TableUtil/init.lua"}},{"name":"ShuffleTable","desc":"Shuffles `tabl` such that the indices will have values of other indices in `tabl` in a random way. If `randomObject` is specified,\\nit will be used instead to shuffle `tabl`. \\n\\n:::note\\nThis method assumes that `tabl` is an array with no holes.\\n:::\\n\\n```lua\\nlocal t1 = {1, 2, 3, 4, 5}\\n\\nlocal shuffledTable = TableUtil.ShuffleTable(t1)\\nprint(shuffledTable) --\x3e {3, 2, 4, 5, 1, 6}\\n```","params":[{"name":"tabl","desc":"","lua_type":"table"},{"name":"randomObject","desc":"","lua_type":"Random | nil"}],"returns":[{"desc":"The first argument passed to this method","lua_type":"table"}],"function_type":"static","source":{"line":200,"path":"packages/TableUtil/init.lua"}},{"name":"IsTableEmpty","desc":"Returns a boolean indicating if `tabl` is empty i.e it is basically `{}`. For arrays with no holes, the `#` operator should be \\nused instead.","params":[{"name":"tabl","desc":"","lua_type":"table"}],"returns":[{"desc":"","lua_type":"boolean"},{"desc":"","lua_type":"table"}],"function_type":"static","source":{"line":239,"path":"packages/TableUtil/init.lua"}},{"name":"SyncTable","desc":"Syncs `tabl` to `templateSyncTable` such that `tabl` will have exactly the same keys and values that are in\\n`templateSyncTable`. \\n\\n```lua\\n\\tlocal t = {a = 5, b = {}}\\n\\tlocal templateT = {a = {}, b = 5}\\n\\n\\tTableUtil.SyncTable(t, templateT)\\n\\tprint(t) --\x3e {a = {}, b = 5}\\n```","params":[{"name":"tabl","desc":"","lua_type":"table"},{"name":"templateSyncTable","desc":"","lua_type":"table"}],"returns":[{"desc":"The first argument passed to this method","lua_type":"table"}],"function_type":"static","source":{"line":265,"path":"packages/TableUtil/init.lua"}},{"name":"Map","desc":"Performs a map against `tabl`, which can be used to map new values based on the old values at given indices. \\n\\n\\n```lua\\nlocal t = {1, 2, 3, 4, 5}\\nlocal t2 = TableUtil.Map(t, function(key, value)\\n\\treturn value * 2\\nend)\\nprint(t2) --\x3e {2, 4, 6, 8, 10}\\n```","params":[{"name":"tabl","desc":"","lua_type":"table"},{"name":"callback","desc":"","lua_type":"function"}],"returns":[{"desc":"The first argument passed to this method","lua_type":"table"}],"function_type":"static","source":{"line":329,"path":"packages/TableUtil/init.lua"}},{"name":"ConvertTableIndicesToStartFrom","desc":"A method which maps all numerical indices of the values in `tabl` to start from `index`. This method also accounts\\nfor nested tables. Returns `tabl`.\\n\\n```lua\\nlocal t = {1, 2, 3, 4, 5}\\nTableUtil.ConvertTableIndicesToStartFrom(t, 0)\\nprint(t[0], t[1], t[2], t[3]) --\x3e 1, 2, 3, 4\\n```","params":[{"name":"tabl","desc":"","lua_type":"table"},{"name":"index","desc":"","lua_type":"number"}],"returns":[{"desc":"The first argument passed to this method","lua_type":"table"}],"function_type":"static","source":{"line":362,"path":"packages/TableUtil/init.lua"}},{"name":"CombineTables","desc":"A method which combines all tables `...` into 1 single mega table.\\n\\n```lua\\nlocal t = {1, 2, 3, 4, 5}\\nlocal t1 = {7, 8, 9}\\nlocal t2 = {10, 11, 12}\\n\\nlocal combinedTable = TableUtil.CombineTables(t, t1, t2)\\nprint(combinedTable) --\x3e {1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12}\\n```","params":[{"name":"...","desc":"","lua_type":"table"}],"returns":[{"desc":"","lua_type":"table"}],"function_type":"static","source":{"line":412,"path":"packages/TableUtil/init.lua"}},{"name":"EmptyTable","desc":"Clears out all keys in `tabl`.\\n\\n```lua\\nlocal t = {1, 2, 3, 4, 5}\\nTableUtil.EmptyTable(t)\\nprint(t) --\x3e {}\\n```","params":[{"name":"tabl","desc":"","lua_type":"table"}],"returns":[],"function_type":"static","source":{"line":440,"path":"packages/TableUtil/init.lua"}},{"name":"ReverseTable","desc":"A method which reverses `tabl`. Returns `tabl`.\\n\\n:::note\\nThis method assumes that `tabl` is an array with no holes.\\n:::\\n\\n```lua\\nlocal t = {1, 2, 3, 4, 5}\\nTableUtil.ReverseTable(t)\\nprint(t) --\x3e {5, 4, 3, 2, 2, 1}\\n```","params":[{"name":"tabl","desc":"","lua_type":"table"}],"returns":[{"desc":"","lua_type":"table"}],"function_type":"static","source":{"line":468,"path":"packages/TableUtil/init.lua"}},{"name":"GetCount","desc":"A method which returns a number of all the elements in `tabl`.\\n\\n```lua\\nlocal t = {1, 2, 3, 4, 5, a = 5, b = 6}\\nprint(TableUtil.GetCount(t)) --\x3e 7\\n```","params":[{"name":"tabl","desc":"","lua_type":"table"}],"returns":[{"desc":"","lua_type":"number"}],"function_type":"static","source":{"line":491,"path":"packages/TableUtil/init.lua"}},{"name":"GetKeyFromValue","desc":"A method which returns the key in which `value` is stored at in `tabl`.\\n\\n```lua\\nlocal t = {a = 5, b = 10}\\nprint(TableUtil.GetKeyFromValue(t, 5)) --\x3e \\"a\\"\\n```\\n\\n:::note\\nThis method will not work well for different keys which have the same value, and doesn\'t account for nested values.\\n:::","params":[{"name":"tabl","desc":"","lua_type":"table"},{"name":"value","desc":"","lua_type":"any"}],"returns":[{"desc":"","lua_type":"any"}],"function_type":"static","source":{"line":523,"path":"packages/TableUtil/init.lua"}},{"name":"AreTablesSame","desc":"A method which checks if both `tabl` and `otherTable` are exactly equal. Also accounts for nested values.\\n\\n```lua\\nlocal t1 = {1, 2, 3, 4, 5, {a = 4}}\\nlocal t2 = {1, 2, 3, 4, 5, {a = 3}}\\n\\nprint(TableUtil.AreTablesSame(t1, t2)) --\x3e false\\n```\\n\\n```lua\\nlocal t1 = {1, 2, 3, 4, 5, {a = 4}}\\nlocal t2 = {1, 2, 3, 4, 5, {a = 4}}\\n\\nprint(TableUtil.AreTablesSame(t1, t2)) --\x3e true\\n```","params":[{"name":"tabl","desc":"","lua_type":"table"},{"name":"otherTable","desc":"","lua_type":"table"}],"returns":[{"desc":"","lua_type":"boolean"}],"function_type":"static","source":{"line":560,"path":"packages/TableUtil/init.lua"}}],"properties":[],"types":[],"name":"TableUtil","desc":"A utility designed to provide a layer of abstraction along with useful methods when working with tables.\\n\\nA common use case would be to compare 2 tables via their elements, for e.g:\\n\\n```lua\\nlocal t1 = {1, 2, 3}\\nlocal t2 = {1, 2, 3}\\nlocal t3 = {1, 2}\\n\\nprint(TableUtil.IsTableEqualTo(t1, t2)) --\x3e true\\nprint(TableUtil.IsTableEqualTo(t1, t3)) --\x3e false\\n```","source":{"line":37,"path":"packages/TableUtil/init.lua"}}')}}]);