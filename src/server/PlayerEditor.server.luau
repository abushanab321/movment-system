local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local SlidingModule = require(ReplicatedStorage.Modules.SlidingModule)

local function onCharacterAdded(Character)
	Character:SetAttribute("Sliding", false)
	SlidingModule.NewSlide(Players:GetPlayerFromCharacter(Character), 10, Workspace.Part.CFrame):StartSlide()
end

local function onPlayerAdded(Player)
	Player.CharacterAppearanceLoaded:Connect(onCharacterAdded)
	local leaderstats = Instance.new("Folder")
	leaderstats.Name = "leaderstats"
	leaderstats.Parent = Player
end

Players.PlayerAdded:Connect(onPlayerAdded)
