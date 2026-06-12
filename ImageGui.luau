-- Inside your GUI creation logic where you define your Admin Tab buttons:

local ImageGuiButton = AdminTab:CreateButton({
    Name = "Spawn Admin Decal GUI",
    Callback = function()
        -- This executes your main image GUI script when the button is clicked
        loadstring(game:HttpGet("https://raw.githubusercontent.com/Alino476/AndherAdmin/main/ImageGui.lua"))()
    end,
})
