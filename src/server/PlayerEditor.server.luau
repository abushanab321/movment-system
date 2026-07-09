local Players = game:GetService("Players")

local function onCharacterAdded(Character)
	Character:SetAttribute("Sliding", false)
end

local function onPlayerAdded(Player)
	Player.CharacterAppearanceLoaded:Connect(onCharacterAdded)
	local leaderstats = Instance.new("Folder")
	leaderstats.Name = "leaderstats"
	leaderstats.Parent = Player
end

Players.PlayerAdded:Connect(onPlayerAdded)
