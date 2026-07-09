local Player = game:GetService("Players").LocalPlayer
local UserInputService = game:GetService("UserInputService")
local Character = Player.Character or Player.CharacterAdded:Wait()
local Humanoid = Character:WaitForChild("Humanoid")
local Animator = Humanoid:WaitForChild("Animator")

-- It's best practice to use WaitForChild for instances inside the script
local RunningAnimation = script:WaitForChild("RunningAnimation")
local JumpStartAnimation = script:WaitForChild("JumpStartAnimation")

local RunningTrack = Animator:LoadAnimation(RunningAnimation)
local StartJumpingTrack = Animator:LoadAnimation(JumpStartAnimation)

-- Set priority once instead of every time the key is pressed
RunningTrack.Priority = Enum.AnimationPriority.Movement

local isHoldingShift = false

-- Central function to handle sprint logic
local function UpdateSprint()
	-- If holding shift AND actually moving
	if isHoldingShift and Humanoid.MoveDirection.Magnitude > 0 then
		Humanoid.WalkSpeed = 32
		if not RunningTrack.IsPlaying then
			RunningTrack:Play()
		end
	else
		-- If not holding shift, OR magnitude is 0 (standing still)
		Humanoid.WalkSpeed = 16
		if RunningTrack.IsPlaying then
			RunningTrack:Stop()
		end
	end
end

-- Listen for key press
UserInputService.InputBegan:Connect(function(Input, GameProcessedEvent)
	if GameProcessedEvent then
		return
	end
	if Input.KeyCode == Enum.KeyCode.LeftShift then
		isHoldingShift = true
		UpdateSprint()
	end
end)

-- Listen for key release
UserInputService.InputEnded:Connect(function(Input)
	if Input.KeyCode == Enum.KeyCode.LeftShift then
		isHoldingShift = false
		UpdateSprint()
	end
end)

-- Listen for movement changes (walking vs standing still)
Humanoid:GetPropertyChangedSignal("MoveDirection"):Connect(function()
	UpdateSprint()
end)

-- Handle jumping
Humanoid.Jumping:Connect(function(Active)
	if Active then
		StartJumpingTrack:Play()
	end
end)
