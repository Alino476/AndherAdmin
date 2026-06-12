local decalPart = script.Parent
local clickDetector = decalPart:FindFirstChildOfClass("ClickDetector") or Instance.new("ClickDetector", decalPart)

clickDetector.MouseClick:Connect(function(player)
    -- This runs when the admin decal is clicked, loading your opener GUI script
    local success, err = pcall(function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/Alino476/AndherAdmin/main/opener.lua"))()
    end)
    
    if not success then
        warn("Failed to load Opener Script: " .. tostring(err))
    end
end)
