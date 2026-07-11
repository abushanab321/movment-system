local RunService = game:GetService("RunService")
local SlidingModule = {}
SlidingModule.__index = SlidingModule

----Constructors----
function SlidingModule.NewSlide(Player, Speed, StartPosition)
	local Character = Player.Character or Player.CharacterAdded:Wait()
	local self = setmetatable({}, SlidingModule)
	self.Character = Character
	self.Speed = Speed
	self.StartPosition = StartPosition
	self.HeartbeatConnection = nil
	return self
end

----operators----
function SlidingModule:StartSlide()
	local Character = self.Character
	local Speed = self.Speed
	local StartPosition = self.StartPosition + Vector3.new(1, 0, 0)

	local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart")
	HumanoidRootPart.Anchored = true
	HumanoidRootPart.Position = StartPosition

	--[[Physical formula for motion in a straight line:
	Position = StartPosition + StartSpeed * time
]]
	--
	self.HeartbeatConnection = RunService.Heartbeat:Connect(function(deltaTime)
		local Position = StartPosition.Z + Speed * deltaTime

		HumanoidRootPart.Position = HumanoidRootPart.Position + Vector3.new(0, 0, Position)
	end)
end

function SlidingModule:StopSlide()
	self.HeartbeatConnection:Disconnect()
	self.Character.HumanoidRootPart.Anchored = false
end
return SlidingModule
