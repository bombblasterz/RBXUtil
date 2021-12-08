-- finobinos
-- init.lua
-- 16 October 2021

--[[
	-- Static methods:
	
	Signal.new() --> Signal
	Signal.IsA(self : any) --> boolean 
	
	-- Instance members:
	
	Signal.ConnectionCount : number

	-- Instance methods:

	Signal:Connect(callback : function) --> Connection
		Connection:IsConnected() --> boolean
		Connection:Disconnect() --> () 

	Signal:Fire(...) --> ()
	Signal:DeferredFire(...) --> () 
	Signal:Wait() --> ...
	Signal:CleanupConnections() --> () 
	Signal:Destroy() --> () 
]]

--[=[
	@class Signal
	In layman's terms, signals dispatch events with necessary information.

	Here's an example use case for them:

	```lua
	local signal = Signal.new()

	signal:Connect(function(data)
		print(data) --> "Signals dispatch information like this one!"
	end

	signal:Fire("Signals dispatch information like this one!")
	```
]=]

--[=[
	@tag Signal
	@prop ConnectionCount number
	@within Signal
	@readonly

	The number of active connections.
]=]

local Signal = {}
Signal.__index = Signal

local LocalConstants = {
	ErrorMessages = {
		InvalidArgument = "Invalid argument#%d to %s: expected %s, got %s",
	},
}

--[=[
	@param self any
	@return boolean

	A method which returns a boolean indicating if `self` is a signal or not.
]=]

function Signal.IsA(self)
	return getmetatable(self) == Signal
end

--[=[
	@return Signal

	Creates and returns a new signal.
]=]

function Signal.new()
	return setmetatable({
		ConnectionCount = 0,
	}, Signal)
end

local Connection = {}
Connection.__index = Connection

do
	function Connection.new(signal, callback)
		signal.ConnectionCount += 1

		return setmetatable({
			Callback = callback,
			_signal = signal,
			_isConnected = true,
		}, Connection)
	end

	function Connection:Disconnect()
		assert(self:IsConnected(), "Connection is already disconnected")

		self._isConnected = false
		self._signal.ConnectionCount -= 1

		-- Unhook the node, but DON'T clear it. That way any fire calls that are
		-- currently sitting on this node will be able to iterate forwards off of
		-- it, but any subsequent fire calls will not hit it, and it will be GCed
		-- when no more fire calls are sitting on it. (Credits to starvant for this implementation)
		if self._signal.ConnectionListHead == self then
			self._signal.ConnectionListHead = self.Next
		else
			local connectionListHead = self._signal.ConnectionListHead

			while connectionListHead and connectionListHead.Next ~= self do
				connectionListHead = connectionListHead.Next
			end

			if connectionListHead then
				connectionListHead.Next = self.Next
			end
		end

		-- Clear out references:
		self._signal = nil
		self.Callback = nil
	end

	function Connection:IsConnected()
		return self._isConnected
	end
end

--[=[
	@return Connection
	@tag Signal
	@param callback function

	Connects `callback` to the signal so that it will be called when `Signal:Fire` or `Signal:DeferredFire` are called, and the arguments
	passed to them will be passed to `callback`. This method returns a connection which contains the following methods:

	| Methods      | Description                          |
	| ----------- | ------------------------------------ |
	| `Disconnect`  | The connection will be disconnected. |
	| `IsConnected` | Returns a boolean indicating if the connection is connected or not. |
]=]

function Signal:Connect(callback)
	assert(
		typeof(callback) == "function",
		LocalConstants.ErrorMessages.InvalidArgument:format(1, "Signal:Connect", "function", typeof(callback))
	)

	local connection = Connection.new(self, callback)

	-- Reversed linked list implementation; call handlers from last-start
	if self.ConnectionListHead then
		connection.Next = self.ConnectionListHead
		self.ConnectionListHead = connection
	else
		self.ConnectionListHead = connection
	end

	return connection
end

--[=[
	@tag Signal

	Disconnects all connections created through `Signal:Connect`.

	:::note
	Threads yielded under `signal:Wait` will be disregarded if this method is called and thus will not be resumed
	when `signal:Fire` is called. 

	For e.g:

	```lua
	local signal = Signal.new()

	task.spawn(function()
		print(signal:Wait()) -- infinite yield
	end)

	signal:CleanupConnections()
	signal:Fire() 
	```
	:::
]=]

function Signal:CleanupConnections()
	local connection = self.ConnectionListHead
	self.ConnectionListHead = nil

	while connection do
		connection:Disconnect()
		connection = connection.Next
	end
end

--[=[
	@tag Signal

	Destroys the signal,  renders it unusuable and cleans up everything.
]=]

function Signal:Destroy()
	self:CleanupConnections()
	setmetatable(self, nil)

	for key, _ in pairs(self) do
		self[key] = nil
	end
end

--[=[
	@tag Signal
	@yields
	@return ...

	Yields the current Luau thread until the signal is fired through `Signal:Fire` or `Signal:DeferredFire`. All 
	arguments passed to those methods (which were called) will be returned by this method.
]=]

function Signal:Wait()
	local yieldedCoroutine = coroutine.running()

	local connection
	connection = self:Connect(function(...)
		connection:Disconnect()
		task.spawn(yieldedCoroutine, ...)
	end)

	return coroutine.yield()
end

--[=[
	@tag Signal
	@param ... any
	
	Resumes any yielded threads and calls every connected connection's callback passing in `...` as the argument.
]=]

function Signal:Fire(...)
	self:_fire(task.spawn, ...)
end

--[=[
	@tag Signal
	@param ... any
	
	Works the same as `Signal:Fire`, but calls every connected connection's callback in the _next engine execution step_, 
	passing in `...` as the argument.
]=]

function Signal:DeferredFire(...)
	self:_fire(task.defer, ...)
end

function Signal:_fire(taskMethod, ...)
	local connection = self.ConnectionListHead

	while connection do
		taskMethod(connection.Callback, ...)
		connection = connection.Next
	end
end

return Signal
