local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- 1. Create the ScreenGui Container
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "AdminPanelGui"
screenGui.ResetOnSpawn = false
screenGui.Parent = playerGui

-- 2. Create the ImageButton (Your Admin Panel Logo)
local adminButton = Instance.new("ImageButton")
adminButton.Name = "AdminPanelButton"
adminButton.Size = UDim2.new(0, 150, 0, 150) -- Adjust size here (Width, Height in pixels)
adminButton.Position = UDim2.new(0.5, -75, 0.5, -75) -- Spawns dead center of the screen
adminButton.BackgroundTransparency = 1 -- Keeps the background invisible (utilizing your PNG transparency)

-- 🔴 IMPORTANT: Replace '0000000000' with your uploaded Roblox Asset ID
adminButton.Image = "rbxassetid://124015883540524" 

adminButton.Parent = screenGui

-- 3. Dragging Functionality Variables
local dragging = false
local dragInput
local dragStart
local startPos

-- 4. Smooth Dragging Logic
local function update(input)
	local delta = input.Position - dragStart
	adminButton.Position = UDim2.new(
		startPos.X.Scale, 
		startPos.X.Offset + delta.X, 
		startPos.Y.Scale, 
		startPos.Y.Offset + delta.Y
	)
end

adminButton.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
		dragging = true
		dragStart = input.Position
		startPos = adminButton.Position
		
		input.Changed:Connect(function()
			if input.UserInputState == Enum.UserInputState.End then
				dragging = false
			end
		end)
	end
end)

adminButton.InputChanged:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
		dragInput = input
	end
end)

UserInputService.InputChanged:Connect(function(input)
	if input == dragInput and dragging then
		update(input)
	end
end)
