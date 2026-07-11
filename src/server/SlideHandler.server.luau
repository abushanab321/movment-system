local ReplicatedStorage = game:GetService("ReplicatedStorage")
local SlidingModule = require(ReplicatedStorage.Modules.SlidingModule)
local SlideRemote = ReplicatedStorage.Remotes.SlideRemote

SlideRemote.OnServerEvent:Connect(function(Player)
	local Slide = SlidingModule.NewSlide(Player, Speed, StartCFrame)
end)
