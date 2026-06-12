local Players = game:Service("Players")
local UserInputService = game:Service("UserInputService")

local localPlayer = Players.LocalPlayer

-- ==========================================
-- 1. GUI & BRANDING REFERENCES
-- ==========================================
local ScreenGui = script.Parent
local MainToggleBtn = ScreenGui:WaitForChild("MainAdminButton") 
local AdminPanel = ScreenGui:WaitForChild("AdminPanelFrame")     

-- Your Custom Logo Asset Integration
local PanelLogo = AdminPanel:WaitForChild("LogoImageLabel") -- Ensure you have an ImageLabel named this
PanelLogo.Image = "rbxassetid://124015883540524" -- Applies your specific asset ID

-- Tabs Layout
local TabButtons = AdminPanel:WaitForChild("TabButtons") 
local ContentTabs = AdminPanel:WaitForChild("ContentTabs") 

local FeaturesTab = ContentTabs:WaitForChild("FeaturesPage")
local TrollTab = ContentTabs:WaitForChild("TrollPage")
local AdminTab = ContentTabs:WaitForChild("AdminPage")

-- ==========================================
-- 2. DRAGGABLE WINDOW LOGIC
-- ==========================================
local dragging, dragInput, dragStart, startPos

local function update(input)
	local delta = input.Position - dragStart
	AdminPanel.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
end

AdminPanel.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
		dragging = true
		dragStart = input.Position
		startPos = AdminPanel.Position
		
		input.Changed:Connect(function()
			if input.UserInputState == Enum.UserInputState.End then
				dragging = false
			end
		end)
	end
end)

AdminPanel.InputChanged:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
		dragInput = input
	end
end)

UserInputService.InputChanged:Connect(function(input)
	if input == dragInput and dragging then
		update(input)
	end
end)

-- ==========================================
-- 3. TOGGLE PANEL & TAB SWITCHING
-- ==========================================
MainToggleBtn.MouseButton1Click:Connect(function()
	AdminPanel.Visible = not AdminPanel.Visible
end)

local function showTab(pageToShow)
	FeaturesTab.Visible = false
	TrollTab.Visible = false
	AdminTab.Visible = false
	pageToShow.Visible = true
end

TabButtons.FeaturesBtn.MouseButton1Click:Connect(function() showTab(FeaturesTab) end)
TabButtons.TrollBtn.MouseButton1Click:Connect(function() showTab(TrollTab) end)
TabButtons.AdminBtn.MouseButton1Click:Connect(function() showTab(AdminTab) end)

-- ==========================================
-- 4. FEATURES TAB (Fly, Walkspeed, etc.)
-- ==========================================
if FeaturesTab:FindFirstChild("SetSpeedBtn") then
	FeaturesTab.SetSpeedBtn.MouseButton1Click:Connect(function()
		local character = localPlayer.Character
		if character and character:FindFirstChildOfClass("Humanoid") then
			local speed = tonumber(FeaturesTab.SpeedInput.Text) or 16
			character:FindFirstChildOfClass("Humanoid").WalkSpeed = speed
		end
	end)
end

-- ==========================================
-- 5. ADMIN TAB EXECUTION (BTools & Custom Exploits)
-- ==========================================

-- BTools Integration
if AdminTab:FindFirstChild("BToolsBtn") then
	AdminTab.BToolsBtn.MouseButton1Click:Connect(function()
		local tools = {"Clone", "Delete", "Move", "Wiring"}
		for _, toolName in ipairs(tools) do
			if not localPlayer.Backpack:FindFirstChild(toolName) then
				local tool = Instance.new("HopperBin")
				tool.BinType = Enum.BinType[toolName]
				tool.Parent = localPlayer.Backpack
			end
		end
	end)
end

-- R6/R15 & Body Type Changer Integration Point
if AdminTab:FindFirstChild("R6Btn") then
	AdminTab.R6Btn.MouseButton1Click:Connect(function()
		-- Your specific R6 conversion code goes here
		print("Executing R6 conversion logic...")
	end)
end
