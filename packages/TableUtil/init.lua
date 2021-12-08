-- finobinos
-- init.lua
-- 16 October 2021

--[[
    TableUtil.DeepCopy(tabl : table) --> table
    TableUtil.ShallowCopy(tabl : table) --> table
    TableUtil.Reconcile(tabl : table, templateTable : table) --> ()
    TableUtil.Shuffle(tabl : table, randomObject : Random ?) --> ()
    TableUtil.IsEmpty(tabl : table) --> boolean 
    TableUtil.Map(tabl : table, callback : function) --> () 
	TableUtil.DeepFreeze(tabl : table) --> ()
	TableUtil.Combine(... : table) --> table
	TableUtil.Reverse(tabl : table) --> () 
	TableUtil.GetElementCount(tabl : table) --> number 
	TableUtil.AreEqual(tabl : table, otherTable : table) --> boolean 
	TableUtil.Empty(tabl : table) --> ()
]]

--[=[
	@class TableUtil
	A utility designed to provide a layer of abstraction along with useful methods when working with tables.

	A common use case would be to compare 2 tables via their elements, for e.g:

	```lua
	local t1 = {1, 2, 3}
	local t2 = {1, 2, 3}
	local t3 = {1, 2}

	print(TableUtil.AreEqual(t1, t2)) --> true
	print(TableUtil.AreEqual(t1, t3)) --> false
	```
]=]

local TableUtil = {}

local LocalConstants = {
	ErrorMessages = {
		InvalidArgument = "Invalid argument#%d to %s: expected %s, got %s",
	},
}

--[=[
	@param tabl table 

	Freezes all keys and values in `tabl` via `table.freeze`, as well as in all other nested tables in `tabl`.
]=]

function TableUtil.DeepFreeze(tabl)
	assert(
		typeof(tabl) == "table",
		LocalConstants.ErrorMessages.InvalidArgument:format(1, "TableUtil.DeepFreeze", "table", typeof(tabl))
	)

	table.freeze(tabl)

	for key, value in pairs(tabl) do
		if typeof(value) == "table" and not table.isfrozen(value) then
			TableUtil.DeepFreeze(value)
		end

		if typeof(key) == "table" and not table.isfrozen(key) then
			TableUtil.DeepFreeze(key)
		end
	end
end

--[=[
	@param tabl table
	@return table

	Returns a deep copy of `tabl`, also accounting for nested keys and values.
]=]

function TableUtil.DeepCopy(tabl)
	assert(
		typeof(tabl) == "table",
		LocalConstants.ErrorMessages.InvalidArgument:format(1, "TableUtil.DeepCopy", "table", typeof(tabl))
	)

	local deepCopiedTable = {}

	for key, value in pairs(tabl) do
		if typeof(value) == "table" then
			deepCopiedTable[key] = TableUtil.DeepCopy(value)
			continue
		end

		deepCopiedTable[key] = value
	end

	return deepCopiedTable
end

--[=[
	@param tabl table
	@return table

	Works the same as `TableUtil.DeepCopy`, but doesn't account for nested keys and values. 
]=]

function TableUtil.ShallowCopy(tabl)
	assert(
		typeof(tabl) == "table",
		LocalConstants.ErrorMessages.InvalidArgument:format(1, "TableUtil.ShallowCopy()", "table", typeof(tabl))
	)

	local shallowCopiedTable = {}

	for key, value in pairs(tabl) do
		shallowCopiedTable[key] = value
	end

	return shallowCopiedTable
end

--[=[
	@param tabl table
	@param templateTable table

	Adds all missing elements from `templateTable` to `tabl`. 

	```lua
	local t1 = {}
	local templateTable = {1, 2, 3}

	TableUtil.Reconcile(t1, templateTable)
	print(t1) --> {1,2,3}
	```
]=]

function TableUtil.Reconcile(tabl, templateTable)
	assert(
		typeof(tabl) == "table",
		LocalConstants.ErrorMessages.InvalidArgument:format(1, "TableUtil.Reconcile", "table", typeof(tabl))
	)

	assert(
		typeof(templateTable) == "table",
		LocalConstants.ErrorMessages.InvalidArgument:format(2, "TableUtil.Reconcile", "table", typeof(templateTable))
	)

	for key, value in pairs(templateTable) do
		if not tabl[key] then
			if typeof(value) == "table" then
				tabl[key] = TableUtil.DeepCopy(value)
			else
				tabl[key] = value
			end
		end
	end
end

--[=[
	@param tabl table
	@param randomObject Random ?

	Shuffles `tabl` such that the indices will have values of other indices in `tabl` in a random way. If `randomObject` is specified,
	it will be used instead to shuffle `tabl`. 

	:::note
	This method assumes that `tabl` is an array with no holes.
	:::

	```lua
	local t1 = {1, 2, 3, 4, 5}

	TableUtil.Shuffle(t1)
	print(t1) --> {3, 2, 4, 5, 1, 6}
	```
]=]

function TableUtil.Shuffle(tabl, randomObject)
	assert(
		typeof(tabl) == "table",
		LocalConstants.ErrorMessages.InvalidArgument:format(1, "TableUtil.Shuffle", "table", typeof(tabl))
	)

	if randomObject then
		assert(
			typeof(randomObject) == "Random",
			LocalConstants.ErrorMessages.InvalidArgument:format(
				2,
				"TableUtil.Shuffle",
				"Random or nil",
				typeof(randomObject)
			)
		)
	end

	local random = randomObject or Random.new()

	for index = #tabl, 2, -1 do
		local randomIndex = random:NextInteger(1, index)
		-- Set the value of the current index to a value of a random index in the table, and set the value of the
		-- random index to the current value:
		tabl[index], tabl[randomIndex] = tabl[randomIndex], tabl[index]
	end
end

--[=[
	@param tabl table
	@return boolean

	Returns a boolean indicating if `tabl` is completely empty. 
]=]

function TableUtil.IsEmpty(tabl)
	assert(
		typeof(tabl) == "table",
		LocalConstants.ErrorMessages.InvalidArgument:format(1, "TableUtil.IsEmpty", "table", typeof(tabl))
	)

	return not next(tabl)
end

--[=[
	@param tabl table
	@param callback function

	Performs a map against `tabl`, which can be used to map new values based on the old values at given indices. 

	```lua
	local t = {1, 2, 3, 4, 5}
	TableUtil.Map(t, function(key, value)
		return value * 2
	end)
	print(t2) --> {2, 4, 6, 8, 10}
	```
]=]

function TableUtil.Map(tabl, callback)
	assert(
		typeof(tabl) == "table",
		LocalConstants.ErrorMessages.InvalidArgument:format(1, "TableUtil.Map", "table", typeof(tabl))
	)

	assert(
		typeof(callback) == "function",
		LocalConstants.ErrorMessages.InvalidArgument:format(2, "TableUtil.Map", "function", typeof(callback))
	)

	for key, value in pairs(tabl) do
		tabl[key] = callback(key, value)
	end
end

--[=[
	@param ... table
	@return table

	A method which combines all tables `...` into 1 single mega table.

	```lua
	local t = {1, 2, 3, 4, 5}
	local t1 = {7, 8, 9}
	local t2 = {10, 11, 12}

	local combinedTable = TableUtil.Combine(t, t1, t2)
	print(combinedTable) --> {1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12}
	```
]=]

function TableUtil.Combine(...)
	local combinedTable = {}

	for _, tabl in pairs({ ... }) do
		for key, value in pairs(tabl) do
			if typeof(key) == "number" then
				table.insert(combinedTable, value)
			else
				combinedTable[key] = value
			end
		end
	end

	return combinedTable
end

--[=[
	@param tabl table

	Clears out all keys in `tabl`.

	```lua
	local t = {1, 2, 3, 4, 5}
	TableUtil.Empty(t)
	print(t) --> {}
	```
]=]

function TableUtil.Empty(tabl)
	assert(
		typeof(tabl) == "table",
		LocalConstants.ErrorMessages.InvalidArgument:format(1, "TableUtil.Empty", "table", typeof(tabl))
	)

	for key, _ in pairs(tabl) do
		tabl[key] = nil
	end
end

--[=[
	@param tabl table

	A method which reverses `tabl`. 

	:::note
	This method assumes that `tabl` is an array with no holes.
	:::

	```lua
	local t = {1, 2, 3, 4, 5}
	TableUtil.Reverse(t)
	print(t) --> {5, 4, 3, 2, 2, 1}
	```
]=]

function TableUtil.Reverse(tabl)
	assert(
		typeof(tabl) == "table",
		LocalConstants.ErrorMessages.InvalidArgument:format(1, "TableUtil.Reverse", "table", typeof(tabl))
	)

	local newTable = TableUtil.ShallowCopy(tabl)
	table.clear(tabl)

	for i = 1, #newTable do
		tabl[i] = newTable[#newTable - i + 1]
	end
end

--[=[
	@param tabl table
	@return number

	A method which returns a number of all the elements in `tabl`.

	```lua
	local t = {1, 2, 3, 4, 5, a = 5, b = 6}
	print(TableUtil.GetElementCount(t)) --> 7
	```
]=]

function TableUtil.GetElementCount(tabl)
	assert(
		typeof(tabl) == "table",
		LocalConstants.ErrorMessages.InvalidArgument:format(1, "TableUtil.GetElementCount", "table", typeof(tabl))
	)

	local count = 0

	for _, _ in pairs(tabl) do
		count += 1
	end

	return count
end

--[=[
	@param tabl table
	@param value any 
	@return any  ?

	A method which returns the key in which `value` is stored at in `tabl`.

	```lua
	local t = {a = 5, b = 10}
	print(TableUtil.GetKeyFromValue(t, 5)) --> "a"
	```

	:::note
	This method will not work well for different keys which have the same value, and doesn't account for nested key and values.
	:::
]=]

function TableUtil.GetKeyFromValue(tabl, value)
	assert(
		typeof(tabl) == "table",
		LocalConstants.ErrorMessages.InvalidArgument:format(1, "TableUtil.GetKeyFromValue", "table", typeof(tabl))
	)

	for key, tableValue in pairs(tabl) do
		if value == tableValue then
			return key
		end
	end

	return nil
end

--[=[
	@param tabl1 table
	@param tabl2 table
	@return boolean

	A method which checks if both `tabl` and `otherTable` are equal in terms of values.

	```lua
	local t1 = {1, 2, 3, 4, 5, {a = 4}}
	local t2 = {1, 2, 3, 4, 5, {a = 3}}

	print(TableUtil.AreEqual(t1, t2)) --> false
	```

	```lua
	local t1 = {1, 2, 3, 4, 5, {a = 4}}
	local t2 = {1, 2, 3, 4, 5, {a = 4}}

	print(TableUtil.AreEqual(t1, t2)) --> true
	```

	:::note
	- This method works well on tables that contain only primitive values except for userdata and thread.
	- This method also doesn't check keys.

	For e.g:

	```lua
	local t = {
		[{}] = 5,
	}
	local b = {
		[{}] = 5,
	}

	print(TableUtil.AreEqual(t, b)) --> false 
	```
	:::
]=]

function TableUtil.AreEqual(tabl1, tabl2)
	assert(
		typeof(tabl1) == "table",
		LocalConstants.ErrorMessages.InvalidArgument:format(1, "TableUtil.AreEqual", "table", typeof(tabl1))
	)
	assert(
		typeof(tabl2) == "table",
		LocalConstants.ErrorMessages.InvalidArgument:format(2, "TableUtil.AreEqual", "table", typeof(tabl2))
	)

	-- Handle edge case of both tables being empty, in that case, we'll return true because there would be
	-- nothing to check for or if the tables are same:
	if TableUtil.IsEmpty(tabl1) and TableUtil.IsEmpty(tabl2) or tabl2 == tabl1 then
		return true
	end

	for key, value in pairs(tabl1) do
		local otherValue = tabl2[key]

		if typeof(value) == "table" and typeof(otherValue) == "table" then
			if not TableUtil.AreEqual(value, otherValue) then
				return false
			end

			continue
		end

		if otherValue ~= value then
			return false
		end
	end

	return true
end

return TableUtil
