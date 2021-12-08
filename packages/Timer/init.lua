-- finobinos
-- init.lua
-- 17 October 2021

--[[
	-- Static methods:

    Timer.new(timer : number ?, updateSignal : RBXScriptSignal ?) --> Timer
    Timer.IsA(self : any) --> boolean 

   	-- Instance members:

	Timer.OnTick : Signal <deltaTime : number>

	-- Instance methods:
	
	Timer:IsPaused() --> boolean 
	Timer:IsStarted() --> boolean
    Timer:Start() --> () 
    Timer:Stop() --> () 
	Timer:Reset() --> () 
	timer:Pause() --> ()
    Timer:Resume() --> () 
	Timer:Destroy() --> () 
]]

--[=[
	@class Timer
	Timers designed to work like alarms and are used to run code
	at a specific later time.

	For e.g:

	```lua
	local timer = Timer.new(2)
	timer.OnTick:Connect(function(deltaTime)
		warn(("Approximately %d seconds have passed"):format(deltaTime))
	end)

	timer:Start()
	```
]=]

--[=[
	@tag Timer
	@prop Boost number
	@within Timer
	@readonly

	A value which by default is 0. This value is added to the delta time of every approximate frame the timer is updated (or if an update signal was specified, which in case 
	the number fired to the custom update signal). Increasing it will lead to faster timer updates.

	```lua
	local timer = Timer.new(5)
	timer.Boost = 4

	timer:Start()

	timer.OnTick:Connect(function(deltaTime)
		print(deltaTime) --> 8 (approx) 
	end)
	```
]=]

--[=[
	@tag Timer
	@prop OnTick Signal <deltaTime: number>
	@within Timer
	@readonly

	A signal which is fired whenever the timer "ticks" (when started). 

	```lua
	timer.OnTick:Connect(function(deltaTime)
		warn(("After %d seconds, tick!"):format(deltaTime))
	end)

	timer:Start()
	```
]=]

local Timer = {}
Timer.__index = Timer

local RunService = game:GetService("RunService")

local Signal = require(script.Parent.Signal)

local LocalConstants = {
	ErrorMessages = {
		InvalidArgument = "Invalid argument#%d to %s: expected %s, got %s",
	},
}

--[=[
	@param self any
	@return boolean

	A method which returns a boolean indicating if `self` is a timer or not.
]=]

function Timer.IsA(self)
	return getmetatable(self) == Timer
end

--[=[
	@param timer number ?
	@param updateSignal RBXScriptSignal ?
	@return Timer

	Creates and returns a new timer. If `timer` is not specified, it will default to `0` i.e the timer will be updated
	every frame. If `updateSignal` is not specified, it will default to 
	[RunService.Heartbeat](https://developer.roblox.com/en-us/api-reference/event/RunService/Heartbeat).

	:::note
	If `updateSignal` is specified, it must be fired with a number as the first argument so that the timer is updated based on that number.

	For e.g:

	```lua
	local updateSignal = Instance.new("BindableEvent")
	local timer = Timer.new(5, updateSignal.Event)

	while true do
		-- The timer will be updated by exactly 5 seconds every approx second:
		updateSignal:Fire(5)
		task.wait(1)
	end
	```
	:::
]=]

function Timer.new(timer, updateSignal)
	if timer then
		assert(
			typeof(timer) == "number",
			LocalConstants.ErrorMessages.InvalidArgument:format(1, "Timer.new", "number or nil", typeof(timer))
		)
	end

	if updateSignal then
		assert(
			typeof(updateSignal) == "RBXScriptSignal",
			LocalConstants.ErrorMessages.InvalidArgument:format(
				2,
				"Timer.new",
				"RBXScriptSignal or nil",
				typeof(updateSignal)
			)
		)
	end

	return setmetatable({
		OnTick = Signal.new(),
		Boost = 0,
		_updateSignal = updateSignal or RunService.Heartbeat,
		_tickGoal = timer or 0,
		_currentTick = 0,
		_isPaused = false,
		_isStarted = false,
		_wasPreviouslyStarted = false,
	}, Timer)
end

--[=[
	@tag Timer
	Resets the timer.
]=]

function Timer:Reset()
	self._currentTick = 0
end

--[=[
	@tag Timer
	Starts the timer.
]=]

function Timer:Start()
	assert(not self:IsStarted(), "Cannot start timer again as it is already started")

	self._isStarted = true

	self._updateSignalConnection = self._updateSignal:Connect(function(deltaTime)
		if self:IsPaused() or self.OnTick.ConnectionCount == 0 then
			return
		end

		self._currentTick += deltaTime + self.Boost

		if self._currentTick >= self._tickGoal then
			self.OnTick:Fire(self._currentTick)
			self:Reset()
		end
	end)
end

--[=[
	@tag Timer
	@return boolean
	Returns a boolean indicating if the timer has started.
]=]

function Timer:IsStarted()
	return self._isStarted
end

--[=[
	@tag Timer
	Pauses the timer.
]=]

function Timer:Pause()
	assert(not self:IsPaused(), "Cannot pause timer as it is already paused")

	self._isPaused = true
	self._wasPreviouslyStarted = self:IsStarted()
	self._isStarted = false
end

--[=[
	@tag Timer
	Resumes or "un-pauses" the timer.
]=]

function Timer:Resume()
	assert(self:IsPaused(), "Cannot resume timer as it is not paused")

	self._isStarted = self._wasPreviouslyStarted
	self._wasPreviouslyStarted = false
	self._isPaused = false
end

--[=[
	@tag Timer
	@return boolean
	Returns a boolean indicating if the timer has being paused.
]=]

function Timer:IsPaused()
	return self._isPaused
end

--[=[
	@tag Timer

	Destroys the timer, renders it unusuable and cleans up everything.
]=]

function Timer:Destroy()
	self:Stop()
	self.OnTick:Destroy()

	setmetatable(self, nil)
	for key, _ in pairs(self) do
		self[key] = nil
	end
end

--[=[
	@tag Timer

	Stops the timer.
]=]

function Timer:Stop()
	assert(self:IsStarted(), "Cannot stop timer as it is not started")

	local updateSignalConnection = self._updateSignalConnection
	self._updateSignalConnection = nil

	self._isStarted = false
	self._isPaused = false

	if updateSignalConnection then
		updateSignalConnection:Disconnect()
	end
end

return Timer
