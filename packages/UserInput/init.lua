-- angrybino
-- init
-- September 26, 2021

--[[
	UserInput.OnInputTypeChange : Signal <newInputType : string>
	UserInput.InputType : table	
    
	UserInput.GetInputType() --> string 
]]

--[=[
	@class UserInput

	UserInput is a useful module which should be used to retrieve input type of the client in an abstracted way
	and provides access to other useful input modules.

	```lua
	UserInput.OnInputTypeChange:Connect(function(newInputType)

	end)

	print(UserInput.GetInputType())
	```
]=]

--[=[
	@within UserInput
	@prop OnInputTypeChange Signal <newInputType: string>
	@readonly

	A signal which is fired whenever the input type of the client changes. The new input type 
	will be a string which will always be a member of `UserInput.InputType`.
]=]

--[=[
	@within UserInput
	@prop Mouse table
	@readonly

	The required mouse module.
]=]

--[=[
	@within UserInput
	@prop Keyboard table
	@readonly

	The required keyboard module.
]=]

--[=[
	@within UserInput
	@prop InputType table
	@readonly

	A dictionary of input types.

	| InputTypes   |
	| ----------- | 
	| `Keyboard`    |
	| `Mouse`    |
	| `Gamepad`  |
	| `Touch`  |
]=]

local UserInput = {
	InputType = {
		Keyboard = "Keyboard",
		Mouse = "Mouse",
		Gamepad = "Gamepad",
		Touch = "Touch",
	},
}

local UserInputService = game:GetService("UserInputService")

local Signal = require(script.Parent.Signal)

local function SetInputType(newInputType)
	local previousLastInputType = UserInput._lastInputType

	if previousLastInputType ~= newInputType then
		UserInput._lastInputType = newInputType
		UserInput.OnInputTypeChange:Fire(newInputType)
	end
end

local function OnInputTypeUpdate(inputType)
	if inputType == Enum.UserInputType.Keyboard then
		SetInputType(UserInput.InputType.Keyboard)
	elseif inputType == Enum.UserInputType.Touch then
		SetInputType(UserInput.InputType.Touch)
	elseif inputType.Name:sub(1, 5) == "Mouse" then
		SetInputType(UserInput.InputType.Mouse)
	elseif inputType.Name:sub(1, 7) == "Gamepad" then
		SetInputType(UserInput.InputType.Gamepad)
	end
end

--[=[
	@return string 

	Returns the current input type of the client which will always be a member of `UserInput.InputType`.
]=]

function UserInput.GetInputType()
	return UserInput._lastInputType
end

function UserInput._initModules()
	for _, child in ipairs(script:GetChildren()) do
		local requiredModule = require(child)

		UserInput[child.Name] = requiredModule

		if typeof(requiredModule.Init) == "function" then
			requiredModule.Init()
		end
	end
end

function UserInput._init()
	UserInput._initModules()
	UserInput.OnInputTypeChange = Signal.new()
	
	OnInputTypeUpdate(UserInputService:GetLastInputType())
	UserInputService.LastInputTypeChanged:Connect(OnInputTypeUpdate)
end

UserInput._init()

return UserInput
