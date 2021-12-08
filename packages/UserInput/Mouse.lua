-- angrybino
-- Mouse
-- September 26, 2021

--[[
	Mouse.OnLeftClick : Signal <isInputProcessed : boolean>
	Mouse.OnRightClick : Signal <isInputProcessed : boolean>
	Mouse.OnScrollClick : Signal <isInputProcessed : boolean>
	Mouse.OnMove : Signal <deltaPosition : Vector3>
	Mouse.OnTargetChange : Signal <newTarget : Instance ?>

	Mouse.UnitRay : Vector3
	Mouse.Hit : CFrame
	Mouse.X : number
	Mouse.Y : number
	Mouse.Target : Instance ?
	Mouse.Origin : Vector3

	Mouse.CastRay(distance : number, raycastParams : RaycastParams ?) --> RaycastResult 
	Mouse.LockToCurrentPosition() --> () 
	Mouse.Unlock() --> () 
	Mouse.LockToCenter() --> () 
	Mouse.GetDeltaPosition() --> Vector3 
	Mouse.SetTargetFilterType(targetFilterType : EnumItem) --> ()
	Mouse.AddTargetFilter(targetFilter : Instance) --> ()
	Mouse.RemoveTargetFilter(targetFilter : Instance) --> ()
]]

--[=[
	@class Mouse

	The mouse module is a superior module designed over the legacy mouse Roblox has provided us. This module 
	should be used over `player:GetMouse()`.
]=]

--[=[
	@within Mouse
	@prop OnLeftClick Signal <isInputProcessed: boolean>
	@readonly

	A signal fired whenever the user left clicks on their mouse. 
]=]

--[=[
	@within Mouse
	@prop OnRightClick Signal <isInputProcessed: boolean>
	@readonly

	A signal fired whenever the user right clicks on their mouse. 
]=]

--[=[
	@within Mouse
	@prop OnScrollClick Signal <isInputProcessed: boolean>
	@readonly

	A signal fired whenever the user scroll clicks on their mouse. 
]=]

--[=[
	@within Mouse
	@prop OnMove Signal <deltaPosition: Vector3>
	@readonly

	A signal fired whenever the user moves their mouse. 
]=]

--[=[
	@within Mouse
	@prop OnTargetChange Signal <newTarget: Instance ?>
	@readonly

	A signal which is fired whenever `Mouse.Target` changes.
]=]

--[=[
	@within Mouse
	@prop TargetFilterType EnumItem
	@readonly

	By default, the value is `Enum.RaycastFilterType.Blacklist`. Used as the filter type in
	retrieving `Mouse.Target` and `Mouse.Hit`. 
	
	:::note
	This member should only be set to `Enum.RaycastFilterType.Blacklist` or `Enum.RaycastFilterType.Whitelist`.
	:::
]=]

--[=[
	@within Mouse
	@prop Hit CFrame
	@readonly

	The CFrame the mouse hit in the 3D world.
]=]

--[=[
	@within Mouse
	@prop UnitRay Ray
	@readonly

	The unit ray from the mouse's 2D position to the 3D world.
]=]

--[=[
	@within Mouse
	@prop X number
	@readonly

	The `X` coordinate of the mouse's position on the screen.
]=]

--[=[
	@within Mouse
	@prop X number
	@readonly

	The `Y` coordinate of the mouse's position on the screen.
]=]

--[=[
	@within Mouse
	@prop Target Instance ?
	@readonly

	The instance the mouse hit in the 3D world.
]=]

--[=[
	@within Mouse
	@prop Origin CFrame
	@readonly

	A CFrame at the camera's position, facing the 3D position of the mouse. Equivalent to `CFrame.lookAt(Workspace.CurrentCamera.CFrame.Position, Mouse.Hit.Position)`.
]=]

local Mouse = {
	_raycastParams = RaycastParams.new(),
	_mouseBehaviorConnections = {},
}

local UserInputService = game:GetService("UserInputService")
local Workspace = game:GetService("Workspace")
local RunService = game:GetService("RunService")

local dependencies = script.Parent.Parent
local Signal = require(dependencies.Signal)
local SharedConstants = require(script.Parent.SharedConstants)

local LocalConstants = {
	MaxMouseRayDistance = 15000,
}

--[=[
	@return Vector3

	Returns the position of the mouse from the last frame to the current.
]=]

function Mouse.GetDeltaPosition()
	return Mouse.Hit.Position - Mouse._lastPosition
end

--[=[
	@return RaycastResult ?
	@param raycastParams RaycastParams ?
	@param distance number 

	Casts a ray from the mouse's current position to it's position extended `distance` studs, respecting `raycastParams` if provided.
]=]

function Mouse.CastRay(distance, raycastParams)
	assert(
		typeof(distance) == "number",
		SharedConstants.ErrorMessages.InvalidArgument:format(2, "Mouse.CastRay", "number", typeof(distance))
	)

	if raycastParams then
		assert(
			typeof(raycastParams) == "RaycastParams",
			SharedConstants.ErrorMessages.InvalidArgument:format(
				1,
				"Mouse.CastRay",
				"RaycastParams or nil",
				typeof(raycastParams)
			)
		)
	end

	local mouseRay = Mouse.UnitRay
	return Workspace:Raycast(mouseRay.Origin, mouseRay.Direction * distance, raycastParams)
end

--[=[
	Locks the mouse to it's current position.
]=]

function Mouse.LockToCurrentPosition()
	Mouse._disconnectMouseBehaviorConnections()

	local connection
	connection = RunService.RenderStepped:Connect(function()
		-- Support the behavior of deferred signal behavior:
		if not connection.Connected then
			return
		end

		UserInputService.MouseBehavior = Enum.MouseBehavior.LockCurrentPosition
	end)

	table.insert(Mouse._mouseBehaviorConnections, connection)
end

--[=[
	Unlocks the mouse.
]=]

function Mouse.Unlock()
	Mouse._disconnectMouseBehaviorConnections()
	UserInputService.MouseBehavior = Enum.MouseBehavior.Default
end

--[=[
	Locks the mouse to the center.
]=]

function Mouse.LockToCenter()
	Mouse._disconnectMouseBehaviorConnections()

	local connection
	connection = RunService.RenderStepped:Connect(function()
		-- Support the behavior of deferred signal behavior:
		if not connection.Connected then
			return
		end

		UserInputService.MouseBehavior = Enum.MouseBehavior.LockCenter
	end)

	table.insert(Mouse._mouseBehaviorConnections, connection)
end

--[=[
	@param targetFilter Instance

	Adds `targetFilter` to the filter list so that they will be filtered out when calculating `Mouse.Hit` and `Mouse.Target`.
]=]

function Mouse.AddTargetFilter(targetFilter)
	assert(
		typeof(targetFilter) == "Instance",
		SharedConstants.ErrorMessages.InvalidArgument:format(
			1,
			"Mouse.AddTargetFilter",
			"Instance",
			typeof(targetFilter)
		)
	)

	local newFilterDescendantsInstances = Mouse._raycastParams.FilterDescendantsInstances
	table.insert(newFilterDescendantsInstances, targetFilter)

	Mouse._raycastParams.FilterDescendantsInstances = newFilterDescendantsInstances
end

--[=[
	@param targetFilterType EnumItem
	
	Sets the filter type to `targetFilterType` which is used internally in filtering 
	instances added through `Mouse.AddTargetFilter` when calculating `Mouse.Hit` and `Mouse.Target`.

	| EnumItem      | Description                          |
	| ----------- | ------------------------------------ |
	| `Enum.RaycastFilterType.Whitelist`       | Only the instance added through `Mouse.AddTargetFilter` will be respected.  |
	| `Enum.RaycastFilterType.Blacklist`       | The instance added through `Mouse.AddTargetFilter` will be ignored.  |

	By default, the filter type is `Enum.RaycastFilterType.Blacklist`.
]=]

function Mouse.SetTargetFilterType(targetFilterType)
	assert(
		typeof(targetFilterType) == "EnumItem",
		SharedConstants.ErrorMessages.InvalidArgument:format(
			1,
			"Mouse.SetTargetFilterType",
			"EnumItem",
			typeof(targetFilterType)
		)
	)

	assert(
		targetFilterType == Enum.RaycastFilterType.Blacklist or targetFilterType == Enum.RaycastFilterType.Whitelist,
		"Invalid target filter type"
	)

	Mouse._raycastParams.FilterType = targetFilterType
end

--[=[
	@param targetFilter Instance

	Removes `targetFilter` from the filter list so that it will not be filtered out when calculating `Mouse.Hit` and `Mouse.Target`.
]=]

function Mouse.RemoveTargetFilter(targetFilter)
	assert(
		typeof(targetFilter) == "Instance",
		SharedConstants.ErrorMessages.InvalidArgument:format(
			1,
			"Mouse.RemoveTargetFilter",
			"Instance",
			typeof(targetFilter)
		)
	)

	local newFilterDescendantsInstances = Mouse._raycastParams.FilterDescendantsInstances
	table.remove(newFilterDescendantsInstances, table.find(newFilterDescendantsInstances, targetFilter))
	Mouse._raycastParams.FilterDescendantsInstances = newFilterDescendantsInstances
end

--[=[
	@ignore
]=]

function Mouse.Init()
	setmetatable(Mouse, {
		__index = function(_, key)
			if key == "UnitRay" then
				return Mouse._getViewPointToRay()
			elseif key == "Hit" then
				return Mouse._getHitCFrame()
			elseif key == "X" then
				return UserInputService:GetMouseLocation().X
			elseif key == "Y" then
				return UserInputService:GetMouseLocation().Y
			elseif key == "Target" then
				return Mouse._getMouseTarget()
			elseif key == "Origin" then
				return CFrame.lookAt(Workspace.CurrentCamera.CFrame.Position, Mouse.Hit.Position)
			end
		end,
	})

	Mouse.OnLeftClick = Signal.new()
	Mouse.OnRightClick = Signal.new()
	Mouse.OnMove = Signal.new()
	Mouse.OnTargetChange = Signal.new()
	Mouse.OnScrollClick = Signal.new()
	Mouse._lastPosition = Mouse.Hit.Position

	RunService.RenderStepped:Connect(function()
		local deltaPosition = Mouse.GetDeltaPosition()

		if deltaPosition.Magnitude > 0 then
			Mouse.OnMove:Fire(deltaPosition)
		end

		Mouse._lastPosition = Mouse.Hit.Position
	end)

	local lastTarget = Mouse.Target

	Mouse.OnMove:Connect(function()
		if Mouse.Target ~= lastTarget then
			Mouse.OnTargetChange:Fire(Mouse.Target)
		end

		lastTarget = Mouse.Target
	end)

	UserInputService.InputBegan:Connect(function(input, isInputProcessed)
		if input.UserInputType == Enum.UserInputType.MouseButton1 then
			Mouse.OnLeftClick:Fire(isInputProcessed)
		elseif input.UserInputType == Enum.UserInputType.MouseButton2 then
			Mouse.OnRightClick:Fire(isInputProcessed)
		elseif input.UserInputType == Enum.UserInputType.MouseButton3 then
			Mouse.OnScrollClick:Fire(isInputProcessed)
		end
	end)
end

function Mouse._getViewPointToRay()
	local mouseLocation = UserInputService:GetMouseLocation()

	return Workspace.CurrentCamera:ViewportPointToRay(mouseLocation.X, mouseLocation.Y)
end

function Mouse._getMouseTarget()
	local mouseRay = Mouse.UnitRay

	local ray = Workspace:Raycast(
		mouseRay.Origin,
		mouseRay.Direction * LocalConstants.MaxMouseRayDistance,
		Mouse._raycastParams
	)

	return if ray then ray.Instance else nil
end

function Mouse._getHitCFrame()
	local mouseRay = Mouse.UnitRay
	local mouseRayDirection = mouseRay.Direction * LocalConstants.MaxMouseRayDistance

	local ray = Workspace:Raycast(mouseRay.Origin, mouseRayDirection, Mouse._raycastParams)
	return CFrame.new(if ray then ray.Position else mouseRayDirection)
end

function Mouse._disconnectMouseBehaviorConnections()
	for _, connection in ipairs(Mouse._mouseBehaviorConnections) do
		connection:Disconnect()
	end

	table.clear(Mouse._mouseBehaviorConnections)
end

return Mouse
