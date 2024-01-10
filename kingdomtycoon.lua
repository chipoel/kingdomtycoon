-- Find the player's tycoon
local tycoon = nil
local player = game.Players.LocalPlayer

for _, child in ipairs(game.Workspace.TycoonMain.Tycoons:GetChildren()) do
    if child:FindFirstChild("Owner") and child.Owner.Value == player.Name then
        tycoon = child.Name
        break
    end
end

-- Check if the tycoon exists
if not tycoon then
    print("No matching child found.")
    return
end

-- Set the crate pick-up functions to always enabled
local pickUpWoodenCrateEnabled = true
local pickUpGoldenCrateEnabled = true
local pickUpLegendaryCrateEnabled = true

local function pickUpCrate(crate)
    local success, message = pcall(function()
        game:GetService("ReplicatedStorage").remotes.PickUp:FireServer(crate)
    end)
    
    if not success then
        print("An error occurred while picking up the crate:", message)
    end
end

spawn(function()
    while true do
        if pickUpWoodenCrateEnabled then
            local crates = workspace.TycoonMain.Tycoons[tycoon].Essentials.Crates:GetChildren()
            for _, crate in ipairs(crates) do
                if crate.Name == "WoodenCrate" then
                    pickUpCrate(crate)
                end
            end
        end
        
        if pickUpGoldenCrateEnabled then
            local crates = workspace.TycoonMain.Tycoons[tycoon].Essentials.Crates:GetChildren()
            for _, crate in ipairs(crates) do
                if crate.Name == "GoldenCrate" then
                    pickUpCrate(crate)
                end
            end
        end
        
        if pickUpLegendaryCrateEnabled then
            local crates = workspace.TycoonMain.Tycoons[tycoon].Essentials.Crates:GetChildren()
            for _, crate in ipairs(crates) do
                if crate.Name == "LegendaryCrate" then
                    pickUpCrate(crate)
                end
            end
        end

        wait(0.5)
    end
end)
