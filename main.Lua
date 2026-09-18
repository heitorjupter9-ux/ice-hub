local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")
local oldGui = playerGui:FindFirstChild("IceHub")
if oldGui then
	oldGui:Destroy()
end

local routes = {
	{1, 9, "Bandit Quest Giver"},
	{10, 14, "Monkey Quest Giver"},
	{15, 29, "Gorilla Quest Giver"},
	{30, 59, "Pirate Quest Giver"},
	{60, 74, "Brute Quest Giver"},
	{75, 89, "Desert Adventurer"},
	{90, 119, "Snow Quest Giver"},
	{120, 149, "Chief Petty Officer Quest Giver"},
	{150, 174, "Chief Warden Quest Giver"},
	{175, 189, "Swan Pirate Quest Giver"},
	{190, 209, "Magma Admiral Quest Giver"},
	{210, 249, "Fishman Warrior Quest Giver"},
	{250, 299, "Sky Quest Giver"},
	{300, 374, "Colosseum Quest Giver"},
	{375, 449, "Royal Squad Quest Giver"},
	{450, 524, "Royal Soldier Quest Giver"},
	{525, 624, "Galley Pirate Quest Giver"},
	{625, 699, "Galley Captain Quest Giver"},
	{700, 724, "Area 1 Quest Giver"},
	{725, 774, "Area 2 Quest Giver"},
	{775, 899, "Area 3 Quest Giver"},
	{900, 949, "Green Zone Quest Giver"},
	{950, 999, "Graveyard Quest Giver"},
	{1000, 1049, "Snow Mountain Quest Giver"},
	{1050, 1099, "Snow Mountain Quest Giver"},
	{1100, 1124, "Hot and Cold Quest Giver"},
	{1125, 1174, "Hot and Cold Quest Giver"},
	{1175, 1249, "Hot and Cold Quest Giver"},
	{1250, 1274, "Cursed Ship Quest Giver"},
	{1275, 1299, "Cursed Ship Quest Giver"},
	{1300, 1349, "Cursed Ship Quest Giver"},
	{1350, 1374, "Ice Castle Quest Giver"},
	{1375, 1424, "Ice Castle Quest Giver"},
	{1425, 1474, "Forgotten Island Quest Giver"},
	{1475, 1499, "Forgotten Island Quest Giver"},
	{1500, 1524, "Pirate Port Quest Giver"},
	{1525, 1574, "Pirate Port Quest Giver"},
	{1575, 1624, "Hydra Island Quest Giver"},
	{1625, 1699, "Hydra Island Quest Giver"},
	{1700, 1774, "Great Tree Quest Giver"},
	{1775, 1824, "Floating Turtle Quest Giver"},
	{1825, 1874, "Floating Turtle Quest Giver"},
	{1875, 1924, "Floating Turtle Quest Giver"},
	{1925, 1974, "Floating Turtle Quest Giver"},
	{1975, 1999, "Castle on the Sea Quest Giver"},
	{2000, 2024, "Haunted Castle Quest Giver"},
	{2025, 2074, "Haunted Castle Quest Giver"},
	{2075, 2124, "Sea of Treats Quest Giver"},
	{2125, 2174, "Sea of Treats Quest Giver"},
	{2175, 2224, "Sea of Treats Quest Giver"},
	{2225, 2274, "Sea of Treats Quest Giver"},
	{2275, 2324, "Sea of Treats Quest Giver"},
	{2325, 2374, "Sea of Treats Quest Giver"},
	{2375, 2424, "Cake Land Quest Giver"},
	{2425, 9999, "Cake Land Quest Giver"},
}

local function getPlayerLevel()
	local data = player:FindFirstChild("Data")
	local levelValue = data and data:FindFirstChild("Level")
	if levelValue and tonumber(levelValue.Value) then
		return tonumber(levelValue.Value)
	end

	local stats = player:FindFirstChild("leaderstats")
	levelValue = stats and stats:FindFirstChild("Level")
	if levelValue and tonumber(levelValue.Value) then
		return tonumber(levelValue.Value)
	end

	return nil
end

local function getRoute()
	local level = getPlayerLevel()
	if not level then
		return nil, nil
	end

	for _, route in ipairs(routes) do
		if level >= route[1] and level <= route[2] then
			return level, route[3]
		end
	end
	return level, routes[#routes][3]
end

local function normalizeName(name)
	return string.lower(name):gsub("[^%w]", "")
end

local function findNpc(name)
	local normalizedTarget = normalizeName(name)
	local containers = {workspace:FindFirstChild("NPCs"), workspace:FindFirstChild("Map"), workspace}

	for _, container in ipairs(containers) do
		if container then
			local npc = container:FindFirstChild(name, true)
			if npc and npc:IsA("Model") then
				return npc
			end
		end
	end

	for _, container in ipairs(containers) do
		if container then
			for _, object in ipairs(container:GetDescendants()) do
				if object:IsA("Model") and normalizeName(object.Name) == normalizedTarget then
					return object
				end
			end
		end
	end

	return nil
end

local function teleportToNpc(name)
	local character = player.Character
	local root = character and character:FindFirstChild("HumanoidRootPart")
	local npc = findNpc(name)
	local npcRoot = npc and (npc.PrimaryPart or npc:FindFirstChild("HumanoidRootPart") or npc:FindFirstChildWhichIsA("BasePart"))
	if not root then
		return false, "Character not ready"
	end
	if not npcRoot then
		return false, name .. " not found"
	end
	character:PivotTo(npcRoot.CFrame + Vector3.new(0, 3, 0))
	return true, "Teleported to " .. name
end

local gui = Instance.new("ScreenGui")
gui.Name = "IceHub"
gui.ResetOnSpawn = false
gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
gui.Parent = playerGui

local window = Instance.new("Frame")
window.Size = UDim2.fromOffset(520, 330)
window.Position = UDim2.fromScale(0.5, 0.5)
window.AnchorPoint = Vector2.new(0.5, 0.5)
window.BackgroundColor3 = Color3.fromRGB(16, 19, 26)
window.BorderSizePixel = 0
window.Parent = gui

local windowCorner = Instance.new("UICorner")
windowCorner.CornerRadius = UDim.new(0, 10)
windowCorner.Parent = window

local windowStroke = Instance.new("UIStroke")
windowStroke.Color = Color3.fromRGB(57, 72, 95)
windowStroke.Parent = window

local sidebar = Instance.new("Frame")
sidebar.Size = UDim2.new(0, 145, 1, 0)
sidebar.BackgroundColor3 = Color3.fromRGB(21, 25, 34)
sidebar.BorderSizePixel = 0
sidebar.Parent = window

local sidebarCorner = Instance.new("UICorner")
sidebarCorner.CornerRadius = UDim.new(0, 10)
sidebarCorner.Parent = sidebar

local brand = Instance.new("TextLabel")
brand.Position = UDim2.fromOffset(18, 20)
brand.Size = UDim2.new(1, -36, 0, 30)
brand.BackgroundTransparency = 1
brand.Font = Enum.Font.GothamBold
brand.Text = "ICE HUB"
brand.TextColor3 = Color3.fromRGB(235, 245, 255)
brand.TextSize = 18
brand.TextXAlignment = Enum.TextXAlignment.Left
brand.Parent = sidebar

local divider = Instance.new("Frame")
divider.Position = UDim2.fromOffset(18, 58)
divider.Size = UDim2.new(1, -36, 0, 1)
divider.BackgroundColor3 = Color3.fromRGB(54, 70, 94)
divider.BorderSizePixel = 0
divider.Parent = sidebar

local content = Instance.new("Frame")
content.Position = UDim2.fromOffset(145, 0)
content.Size = UDim2.new(1, -145, 1, 0)
content.BackgroundTransparency = 1
content.Parent = window

local title = Instance.new("TextLabel")
title.Position = UDim2.fromOffset(25, 23)
title.Size = UDim2.new(1, -50, 0, 28)
title.BackgroundTransparency = 1
title.Font = Enum.Font.GothamSemibold
title.Text = "Main"
title.TextColor3 = Color3.fromRGB(235, 243, 255)
title.TextSize = 19
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = content

local subtitle = Instance.new("TextLabel")
subtitle.Position = UDim2.fromOffset(25, 52)
subtitle.Size = UDim2.new(1, -50, 0, 18)
subtitle.BackgroundTransparency = 1
subtitle.Font = Enum.Font.Gotham
subtitle.Text = "Level-based NPC route"
subtitle.TextColor3 = Color3.fromRGB(134, 148, 170)
subtitle.TextSize = 11
subtitle.TextXAlignment = Enum.TextXAlignment.Left
subtitle.Parent = content

local miniTitle = Instance.new("TextLabel")
miniTitle.Position = UDim2.fromOffset(16, 0)
miniTitle.Size = UDim2.new(1, -58, 1, 0)
miniTitle.BackgroundTransparency = 1
miniTitle.Font = Enum.Font.GothamBold
miniTitle.Text = "ICE HUB"
miniTitle.TextColor3 = Color3.fromRGB(235, 245, 255)
miniTitle.TextSize = 16
miniTitle.TextXAlignment = Enum.TextXAlignment.Left
miniTitle.Visible = false
miniTitle.Parent = window

local minimizeButton = Instance.new("TextButton")
minimizeButton.Name = "MinimizeButton"
minimizeButton.Position = UDim2.new(1, -38, 0, 9)
minimizeButton.Size = UDim2.fromOffset(28, 28)
minimizeButton.BackgroundColor3 = Color3.fromRGB(35, 45, 61)
minimizeButton.BorderSizePixel = 0
minimizeButton.AutoButtonColor = false
minimizeButton.Font = Enum.Font.GothamBold
minimizeButton.Text = "-"
minimizeButton.TextColor3 = Color3.fromRGB(211, 225, 242)
minimizeButton.TextSize = 18
minimizeButton.Parent = window

local minimizeCorner = Instance.new("UICorner")
minimizeCorner.CornerRadius = UDim.new(0, 6)
minimizeCorner.Parent = minimizeButton

local minimized = false
minimizeButton.Activated:Connect(function()
	minimized = not minimized
	minimizeButton.Text = minimized and "+" or "-"
	minimizeButton.Position = minimized
		and UDim2.new(1, -38, 0, 8)
		or UDim2.new(1, -38, 0, 9)
	miniTitle.Visible = minimized
	sidebar.Visible = not minimized
	content.Visible = not minimized
	window.Size = minimized and UDim2.fromOffset(220, 44) or UDim2.fromOffset(520, 330)
end)

local function createTab(text, y)
	local tab = Instance.new("TextButton")
	tab.Size = UDim2.new(1, -24, 0, 38)
	tab.Position = UDim2.fromOffset(12, y)
	tab.BackgroundColor3 = Color3.fromRGB(21, 25, 34)
	tab.BorderSizePixel = 0
	tab.AutoButtonColor = false
	tab.Font = Enum.Font.GothamMedium
	tab.Text = text
	tab.TextColor3 = Color3.fromRGB(153, 166, 187)
	tab.TextSize = 13
	tab.TextXAlignment = Enum.TextXAlignment.Left
	tab.Parent = sidebar

	local padding = Instance.new("UIPadding")
	padding.PaddingLeft = UDim.new(0, 12)
	padding.Parent = tab

	local corner = Instance.new("UICorner")
	corner.CornerRadius = UDim.new(0, 6)
	corner.Parent = tab
	return tab
end

local mainTab = createTab("Main", 82)
local farmTab = createTab("Auto Farm", 126)
local settingsTab = createTab("Settings", 170)

local function selectTab(selected)
	for _, tab in ipairs({mainTab, farmTab, settingsTab}) do
		local active = tab == selected
		tab.BackgroundColor3 = active and Color3.fromRGB(34, 80, 118) or Color3.fromRGB(21, 25, 34)
		tab.TextColor3 = active and Color3.fromRGB(218, 241, 255) or Color3.fromRGB(153, 166, 187)
	end
	title.Text = selected == farmTab and "Auto Farm" or selected.Text
	subtitle.Text = selected == settingsTab and "Teleport interval" or "Level-based NPC route"
end

local routeCard = Instance.new("Frame")
routeCard.Position = UDim2.fromOffset(25, 88)
routeCard.Size = UDim2.new(1, -50, 0, 76)
routeCard.BackgroundColor3 = Color3.fromRGB(22, 28, 39)
routeCard.BorderSizePixel = 0
routeCard.Parent = content

local routeCorner = Instance.new("UICorner")
routeCorner.CornerRadius = UDim.new(0, 7)
routeCorner.Parent = routeCard

local routeLabel = Instance.new("TextLabel")
routeLabel.Position = UDim2.fromOffset(14, 10)
routeLabel.Size = UDim2.new(1, -28, 0, 20)
routeLabel.BackgroundTransparency = 1
routeLabel.Font = Enum.Font.GothamMedium
routeLabel.Text = "Current route"
routeLabel.TextColor3 = Color3.fromRGB(176, 190, 211)
routeLabel.TextSize = 12
routeLabel.TextXAlignment = Enum.TextXAlignment.Left
routeLabel.Parent = routeCard

local routeValue = Instance.new("TextLabel")
routeValue.Position = UDim2.fromOffset(14, 35)
routeValue.Size = UDim2.new(1, -58, 0, 24)
routeValue.BackgroundTransparency = 1
routeValue.Font = Enum.Font.GothamSemibold
routeValue.TextColor3 = Color3.fromRGB(226, 240, 255)
routeValue.TextSize = 14
routeValue.TextXAlignment = Enum.TextXAlignment.Left
routeValue.Parent = routeCard

local routeIndicator = Instance.new("Frame")
routeIndicator.Name = "RouteStatus"
routeIndicator.AnchorPoint = Vector2.new(1, 0.5)
routeIndicator.Position = UDim2.new(1, -14, 0.5, 0)
routeIndicator.Size = UDim2.fromOffset(12, 12)
routeIndicator.BackgroundColor3 = Color3.fromRGB(91, 157, 235)
routeIndicator.BorderSizePixel = 0
routeIndicator.Parent = routeCard

local indicatorCorner = Instance.new("UICorner")
indicatorCorner.CornerRadius = UDim.new(0, 3)
indicatorCorner.Parent = routeIndicator

local farmButton = Instance.new("TextButton")
farmButton.Position = UDim2.fromOffset(25, 180)
farmButton.Size = UDim2.new(1, -50, 0, 48)
farmButton.BackgroundColor3 = Color3.fromRGB(29, 37, 51)
farmButton.BorderSizePixel = 0
farmButton.AutoButtonColor = false
farmButton.Font = Enum.Font.GothamMedium
farmButton.Text = "Start Auto Farm"
farmButton.TextColor3 = Color3.fromRGB(221, 232, 246)
farmButton.TextSize = 13
farmButton.TextXAlignment = Enum.TextXAlignment.Left
farmButton.Parent = content

local farmPadding = Instance.new("UIPadding")
farmPadding.PaddingLeft = UDim.new(0, 14)
farmPadding.Parent = farmButton

local farmCorner = Instance.new("UICorner")
farmCorner.CornerRadius = UDim.new(0, 7)
farmCorner.Parent = farmButton

local status = Instance.new("TextLabel")
status.Position = UDim2.fromOffset(25, 240)
status.Size = UDim2.new(1, -50, 0, 20)
status.BackgroundTransparency = 1
status.Font = Enum.Font.Gotham
status.Text = "Status: idle"
status.TextColor3 = Color3.fromRGB(137, 151, 173)
status.TextSize = 11
status.TextXAlignment = Enum.TextXAlignment.Left
status.Parent = content

local enabled = false
local function setEnabled(value)
	enabled = value
	farmButton.Text = enabled and "Stop Auto Farm" or "Start Auto Farm"
	farmButton.BackgroundColor3 = enabled and Color3.fromRGB(34, 91, 133) or Color3.fromRGB(29, 37, 51)
	status.Text = enabled and "Status: running" or "Status: idle"
	status.TextColor3 = enabled and Color3.fromRGB(116, 211, 255) or Color3.fromRGB(137, 151, 173)
end

farmButton.Activated:Connect(function()
	setEnabled(not enabled)
end)

for _, tab in ipairs({mainTab, farmTab, settingsTab}) do
	tab.Activated:Connect(function()
		selectTab(tab)
	end)
end

local dragging = false
local dragStart
local startPosition
window.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
		dragging = true
		dragStart = input.Position
		startPosition = window.Position
	end
end)
window.InputEnded:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
		dragging = false
	end
end)
UserInputService.InputChanged:Connect(function(input)
	if not dragging or (input.UserInputType ~= Enum.UserInputType.MouseMovement and input.UserInputType ~= Enum.UserInputType.Touch) then
		return
	end
	local delta = input.Position - dragStart
	window.Position = UDim2.new(startPosition.X.Scale, startPosition.X.Offset + delta.X, startPosition.Y.Scale, startPosition.Y.Offset + delta.Y)
end)

local function refreshRoute()
	local level, npc = getRoute()
	if not level or not npc then
		routeValue.Text = "Level: detecting...  -  NPC: waiting"
		routeIndicator.BackgroundColor3 = Color3.fromRGB(241, 181, 82)
		return
	end

	routeValue.Text = string.format("Level %d  -  %s", level, npc)
	routeIndicator.BackgroundColor3 = findNpc(npc)
		and Color3.fromRGB(91, 197, 145)
		or Color3.fromRGB(241, 181, 82)
end

refreshRoute()
selectTab(mainTab)
task.spawn(function()
	while gui.Parent do
		refreshRoute()
		if enabled then
			local _, npc = getRoute()
			if not npc then
				status.Text = "Status: detecting level"
				status.TextColor3 = Color3.fromRGB(255, 185, 114)
				routeIndicator.BackgroundColor3 = Color3.fromRGB(241, 181, 82)
			else
				local ok, success, message = pcall(teleportToNpc, npc)
				if ok then
					status.Text = "Status: " .. message
					status.TextColor3 = success
						and Color3.fromRGB(116, 211, 255)
						or Color3.fromRGB(255, 185, 114)
					routeIndicator.BackgroundColor3 = success
						and Color3.fromRGB(91, 197, 145)
						or Color3.fromRGB(220, 91, 91)
				else
					status.Text = "Status: waiting for character"
					status.TextColor3 = Color3.fromRGB(255, 185, 114)
					routeIndicator.BackgroundColor3 = Color3.fromRGB(220, 91, 91)
				end
			end
		end
		task.wait(1.5)
	end
end)
