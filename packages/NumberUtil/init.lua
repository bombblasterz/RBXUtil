-- finobinos
-- init.lua
-- 16 October 2021

--[[
    NumberUtil.e : number
    NumberUtil.Tau : number
	NumberUtil.Phi : number
    
    NumberUtil.InverseLerp(min : number, max : number, alpha : number) --> number 
    NumberUtil.Map(number : number, inMin : number, inMax : number, outMin : number, outMax : number) --> number 
    NumberUtil.Round(number : number, to : number) --> number 
    NumberUtil.Lerp(number : number, to : number, alpha : number) --> number 
    NumberUtil.QuadraticLerp(number : number, to : number, alpha : number) --> number 
	NumberUtil.IsNaN(number : number) --> boolean 
	NumberUtil.Root(number : number) --> number 
	NumberUtil.Factorial(number : number) --> number 
	NumberUtil.Factors(number : number) --> table 
	NumberUtil.IsInfinite(number : number) --> boolean 
	NumberUtil.AreClose(number : number, to : number, eplison : number ?) --> boolean 
]]

--[=[
	@class NumberUtil
	A useful number utility module which provides a lot of useful methods which are commonly used when
	working with numbers and handling certain edge cases.

	For e.g:
	
	```lua
	local nan = 0/0

	print(NumberUtil.IsNaN(nan)) --> true
	print(NumberUtil.AreClose(0.1 + 0.2, 0.3)) --> true
	```
]=]

--[=[
	@prop e number
	@readonly
	@within NumberUtil
	Known as Euler's number, is a mathematical constant approximately equal to `2.7182818284590`.
]=]

--[=[
	@prop Tau number
	@readonly
	@within NumberUtil
	The circle constant representing the ratio between circumference and radius. 
	The constant is equal to `math.pi * 2` approximately.
]=]

--[=[
	@prop Phi number
	@readonly
	@within NumberUtil
	An irrational number which is often known as the golden ratio or the most beautiful number in maths.
]=]

local NumberUtil = {
	e = 2.7182818284590,
	Tau = 2 * math.pi,
	Phi = 1.618033988749895,
}

local LocalConstants = {
	ErrorMessages = {
		InvalidArgument = "Invalid argument#%d to %s: expected %s, got %s",
	},

	DefaultNumberEpsilonRadius = 1e-7,
}

--[=[
	Smoothly interpolates `number` to `goal`, with `alpha` .

	@param number number
	@param goal number
	@param alpha number
	@return number  
]=]

function NumberUtil.Lerp(number, goal, alpha)
	assert(
		typeof(number) == "number",
		LocalConstants.ErrorMessages.InvalidArgument:format(1, "NumberUtil.Lerp", "number", typeof(number))
	)
	assert(
		typeof(goal) == "number",
		LocalConstants.ErrorMessages.InvalidArgument:format(2, "NumberUtil.Lerp", "number", typeof(goal))
	)
	assert(
		typeof(alpha) == "number",
		LocalConstants.ErrorMessages.InvalidArgument:format(3, "NumberUtil.Lerp", "number", typeof(alpha))
	)

	return number + (goal - number) * alpha
end

--[=[
	Same as `NumberUtil.Lerp`, except the lerp is quadratic.

	@param number number
	@param goal number
	@param alpha number
	@return number  
]=]

function NumberUtil.QuadraticLerp(number, goal, alpha)
	assert(
		typeof(number) == "number",
		LocalConstants.ErrorMessages.InvalidArgument:format(1, "NumberUtil.QuadraticLerp", "number", typeof(number))
	)
	assert(
		typeof(goal) == "number",
		LocalConstants.ErrorMessages.InvalidArgument:format(2, "NumberUtil.QuadraticLerp", "number", typeof(goal))
	)
	assert(
		typeof(alpha) == "number",
		LocalConstants.ErrorMessages.InvalidArgument:format(3, "NumberUtil.QuadraticLerp", "number", typeof(alpha))
	)

	return (number - goal) * alpha * (alpha - 2) + number
end

--[=[
	Inversely lerps `min` to `goal`, with `alpha` being the multiplier.

	@param min number
	@param max number
	@param alpha number
	@return number  
]=]

function NumberUtil.InverseLerp(min, max, alpha)
	assert(
		typeof(min) == "number",
		LocalConstants.ErrorMessages.InvalidArgument:format(1, "NumberUtil.InverseLerp", "number", typeof(min))
	)
	assert(
		typeof(max) == "number",
		LocalConstants.ErrorMessages.InvalidArgument:format(2, "NumberUtil.InverseLerp", "number", typeof(max))
	)
	assert(
		typeof(alpha) == "number",
		LocalConstants.ErrorMessages.InvalidArgument:format(3, "NumberUtil.InverseLerp", "number", typeof(alpha))
	)

	return ((alpha - min) / (max - min))
end

--[=[
	Maps `number` between `inMin`, `inMax`, `outMin` and `outMax`.

	@param number number
	@param inMin number
	@param inMax number
	@param outMin number
	@param outMax number
	@return number  
]=]

function NumberUtil.Map(number, inMin, inMax, outMin, outMax)
	assert(
		typeof(number) == "number",
		LocalConstants.ErrorMessages.InvalidArgument:format(1, "NumberUtil.Map", "number", typeof(number))
	)
	assert(
		typeof(inMin) == "number",
		LocalConstants.ErrorMessages.InvalidArgument:format(2, "NumberUtil.Map", "number", typeof(inMin))
	)
	assert(
		typeof(inMax) == "number",
		LocalConstants.ErrorMessages.InvalidArgument:format(3, "NumberUtil.Map", "number", typeof(inMax))
	)
	assert(
		typeof(outMin) == "number",
		LocalConstants.ErrorMessages.InvalidArgument:format(4, "NumberUtil.Map", "number", typeof(outMin))
	)
	assert(
		typeof(outMax) == "number",
		LocalConstants.ErrorMessages.InvalidArgument:format(5, "NumberUtil.Map", "number", typeof(outMax))
	)

	return (outMin + ((outMax - outMin) * ((number - inMin) / (inMax - inMin))))
end

--[=[
	Rounds `number` to `to`.

	@param number number
	@param to number
	@return number  
]=]

function NumberUtil.Round(number, to)
	assert(
		typeof(number) == "number",
		LocalConstants.ErrorMessages.InvalidArgument:format(1, "NumberUtil.Round", "number", typeof(number))
	)
	assert(
		typeof(to) == "number",
		LocalConstants.ErrorMessages.InvalidArgument:format(2, "NumberUtil.Round", "number", typeof(to))
	)

	return math.floor(number / to + 0.5) * to
end

--[=[
	Returns a boolean if the provided number is `NaN` (Not a Number).

	@param number number
	@return boolean  
]=]

function NumberUtil.IsNaN(number)
	assert(
		typeof(number) == "number",
		LocalConstants.ErrorMessages.InvalidArgument:format(1, "NumberUtil.IsNaN", "number", typeof(number))
	)

	return number ~= number
end

--[=[
	Returns a boolean if the provided number is close to `to` under `eplision` (or the default eplison i.e `1e-5`).

	```lua
	print(0.1 + 0.2 == 0.3) --> false (due to floating point imprecision)
	print(NumberUtil.AreClose(0.1 + 0.2, 0.3)) --> true
	```

	@param number number
	@param to number
	@param eplison number ?
	@return boolean  
]=]

function NumberUtil.AreClose(number, to, eplison)
	assert(
		typeof(number) == "number",
		LocalConstants.ErrorMessages.InvalidArgument:format(1, "NumberUtil.AreClose", "number", typeof(number))
	)
	assert(
		typeof(to) == "number",
		LocalConstants.ErrorMessages.InvalidArgument:format(2, "NumberUtil.AreClose", "number", typeof(to))
	)

	if eplison then
		assert(
			typeof(eplison) == "number",
			LocalConstants.ErrorMessages.InvalidArgument:format(
				3,
				"NumberUtil.AreClose",
				"number or nil",
				typeof(eplison)
			)
		)
	end

	return math.abs(number - to) <= (eplison or LocalConstants.DefaultNumberEpsilonRadius)
end

--[=[
	Returns the "root" of `number`.

	```lua
	print(NumberUtil.Root(2, 2)) --> 1.4142135623731 (Square root)
	print(NumberUtil.Root(2, 3)) --> 1.2599210498949 (Cube root)
	print(NumberUtil.Root(2, 4)) --> 1.1892071150027 (Fourth root)
	```

	@param number number
	@param root number
	@return number  
]=]

function NumberUtil.Root(number, root)
	assert(
		typeof(number) == "number",
		LocalConstants.ErrorMessages.InvalidArgument:format(1, "NumberUtil.Root", "number", typeof(number))
	)
	assert(
		typeof(root) == "number",
		LocalConstants.ErrorMessages.InvalidArgument:format(2, "NumberUtil.Root", "number", typeof(root))
	)

	return number ^ (1 / root)
end

--[=[
	Returns the factorial of `number`. 

	@param number number
	@return number  
]=]

function NumberUtil.Factorial(number)
	assert(
		typeof(number) == "number",
		LocalConstants.ErrorMessages.InvalidArgument:format(1, "NumberUtil.Factorial", "number", typeof(number))
	)

	assert(number % 1 == 0 and number >= 0, "Number must be positive and an integral")

	if number == 0 then
		return 1
	end

	return number * NumberUtil.Factorial(number - 1)
end

--[=[
	Returns all the factors of `number`. 

	@param number number
	@return table  
]=]

function NumberUtil.Factors(number)
	assert(
		typeof(number) == "number",
		LocalConstants.ErrorMessages.InvalidArgument:format(1, "NumberUtil.Factors", "number", typeof(number))
	)

	local factors = {}

	for index = 1, number do
		if number % index == 0 then
			table.insert(factors, index)
		end
	end

	if number == 0 then
		table.insert(factors, 0)
	end

	return factors
end

--[=[
	Returns a boolean indicating if `number` is infinite i.e `math.huge`.

	@param number number
	@return boolean  
]=]

function NumberUtil.IsInfinite(number)
	assert(
		typeof(number) == "number",
		LocalConstants.ErrorMessages.InvalidArgument:format(1, "NumberUtil.IsInfinite", "number", typeof(number))
	)

	return math.abs(number) == math.huge
end

return NumberUtil
