local RunService = game:GetService("RunService")
local SlidingModule = {}
SlidingModule.__index = SlidingModule

----Constructors----
function SlidingModule.NewSlide(Player, Speed, StartCFrame)
	local Character = Player.Character or Player.CharacterAdded:Wait()
	local self = setmetatable({}, SlidingModule)
	self.Character = Character
	self.Speed = Speed
	self.StartCFrame = StartCFrame
	self.HeartbeatConnection = nil
	return self
end

----operators----
function SlidingModule:StartSlide()
	local Character = self.Character
	local Speed = self.Speed
	local StartCFrame = self.StartCFrame * CFrame.new(1, 0, 0)

	local HumanoidRootPart = Character.PrimaryPart
	HumanoidRootPart.Anchored = true
	Character:PivotTo(StartCFrame)

	--[[Physical formula for motion in a straight line:
	Position = StartPosition + StartSpeed * time
	]]
	--
	self.HeartbeatConnection = RunService.Heartbeat:Connect(function(deltaTime)
		local Position = StartCFrame.Z + Speed * deltaTime
		Character:PivotTo(HumanoidRootPart.CFrame * CFrame.new(0, 0, Position))
	end)
end

function SlidingModule:StopSlide()
	self.HeartbeatConnection:Disconnect()
	self.Character.HumanoidRootPart.Anchored = false
end
return SlidingModule
