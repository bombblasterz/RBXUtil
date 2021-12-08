-- finobinos
-- Keyboard.lua
-- 17 October 2021

--[[
	Keyboard.OnKeyDown: Signal <keycode : EnumItem>, isInputProcessed : boolean>
	Keyboard.OnKeyRelease : Signal <keycode : EnumItem>, isInputProcessed : boolean>

    Keyboard.AreAllKeysDown(... : EnumItem) --> boolean 
    Keyboard.AreAnyKeysDown(... : EnumItem) --> boolean 
	Keyboard.IsKeyDown(keycode : EnumItem) --> boolean 
]]

--[=[
	@class Keyboard

	The keyboard module is a small module designed to provide a few methods regarding keyboard input.
	Use [UserInputService](https://developer.roblox.com/en-us/api-reference/class/UserInputService) for the rest of
	the work. 
]=]

local Keyboard = {}

local UserInputService = game:GetService("UserInputService")

local dependencies = script.Parent.Parent
local Signal = require(dependencies.Signal)
local SharedConstants = require(script.Parent.SharedConstants)

--[=[
	@ignore
]=]

function Keyboard.Init()
	Keyboard.OnKeyDown = Signal.new()
	Keyboard.OnKeyRelease = Signal.new()

	UserInputService.InputBegan:Connect(function(input, isInputProcessed)
		local keycode = input.KeyCode

		while UserInputService:IsKeyDown(keycode) do
			Keyboard.OnKeyDown:Fire(keycode, isInputProcessed)
			task.wait()
		end
	end)

	UserInputService.InputEnded:Connect(function(input, isInputProcessed)
		Keyboard.OnKeyRelease:Fire(input.KeyCode, isInputProcessed)
	end)
end

--[=[
	@return boolean
	@param ... EnumItem

	A method which returns a boolean indicating if all keys in `...` are held down.
]=]

function Keyboard.AreAllKeysDown(...)
	for _, keycode in ipairs({ ... }) do
		if not UserInputService:IsKeyDown(keycode) then
			return false
		end
	end

	return true
end

--[=[
	@return boolean
	@param ... EnumItem

	A method which returns a boolean indicating if any keys in `...` are held down.
]=]

function Keyboard.AreAnyKeysDown(...)
	for _, keycode in ipairs({ ... }) do
		if UserInputService:IsKeyDown(keycode) then
			return true
		end
	end

	return false
end

--[=[
	@return boolean
	@param keycode EnumItem

	A method which returns a boolean indicating if `keycode` is held down.
]=]

function Keyboard.IsKeyDown(keycode)
	assert(
		typeof(keycode) == "EnumItem",
		SharedConstants.ErrorMessages.InvalidArgument:format(1, "Keyboard.IsKeyDown", "EnumItem", typeof(keycode))
	)

	return UserInputService:IsKeyDown(keycode)
end

return Keyboard
