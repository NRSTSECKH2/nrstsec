if getgenv().nengzx then warn("NengzXHUB : Already executed!") return end
getgenv().nengzx = true

if not game:IsLoaded() then
    game.Loaded:Wait()
end

local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()
local SaveManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/SaveManager.lua"))()
local InterfaceManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/InterfaceManager.lua"))()

local DeviceType = game:GetService("UserInputService").TouchEnabled and "Mobile" or "PC"
if DeviceType == "Mobile" then
    local ClickButton = Instance.new("ScreenGui")
    local MainFrame = Instance.new("Frame")
    local ImageLabel = Instance.new("ImageLabel")
    local TextButton = Instance.new("TextButton")
    local UICorner = Instance.new("UICorner")
    local UICorner_2 = Instance.new("UICorner")

    ClickButton.Name = "ClickButton"
    ClickButton.Parent = game.CoreGui
    ClickButton.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

    MainFrame.Name = "MainFrame"
    MainFrame.Parent = ClickButton
    MainFrame.AnchorPoint = Vector2.new(1, 0)
    MainFrame.BackgroundTransparency = 0.8
    MainFrame.BackgroundColor3 = Color3.fromRGB(38, 38, 38)
    MainFrame.BorderSizePixel = 0
    MainFrame.Position = UDim2.new(1, -60, 0, 10)
    MainFrame.Size = UDim2.new(0, 45, 0, 45)

    UICorner.CornerRadius = UDim.new(1, 0)
    UICorner.Parent = MainFrame

    ImageLabel.Parent = MainFrame
    ImageLabel.AnchorPoint = Vector2.new(0.5, 0.5)
    ImageLabel.BackgroundColor3 = Color3.new(0, 0, 0)
    ImageLabel.BorderSizePixel = 0
    ImageLabel.Position = UDim2.new(0.5, 0, 0.5, 0)
    ImageLabel.Size = UDim2.new(0, 45, 0, 45)
    ImageLabel.Image = "rbxassetid://"

    TextButton.Parent = MainFrame
    TextButton.BackgroundColor3 = Color3.new(1, 1, 1)
    TextButton.BackgroundTransparency = 1
    TextButton.BorderSizePixel = 0
    TextButton.Position = UDim2.new(0, 0, 0, 0)
    TextButton.Size = UDim2.new(0, 45, 0, 45)
    TextButton.AutoButtonColor = false
    TextButton.Font = Enum.Font.SourceSans
    TextButton.Text = "Open"
    TextButton.TextColor3 = Color3.new(220, 125, 255)
    TextButton.TextSize = 20

    TextButton.MouseButton1Click:Connect(function()
        game:GetService("VirtualInputManager"):SendKeyEvent(true, "LeftControl", false, game)
        game:GetService("VirtualInputManager"):SendKeyEvent(false, "LeftControl", false, game)
    end)
end

local Window = Fluent:CreateWindow({
    Title = game:GetService("MarketplaceService"):GetProductInfo(16732694052).Name .." | NengzXHUB-Freemium",
    SubTitle = "t.me/ismenengzx)",
    TabWidth = 160,
    Size = UDim2.fromOffset(580, 460),
    Acrylic = false,
    Theme = "Rose",
    MinimizeKey = Enum.KeyCode.LeftControl
})

-- // // // Services // // // --
local VirtualInputManager = game:GetService("VirtualInputManager")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local VirtualUser = game:GetService("VirtualUser")
local HttpService = game:GetService("HttpService")
local GuiService = game:GetService("GuiService")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local Players = game:GetService("Players")
local CoreGui = game:GetService('StarterGui')
local UserInputService = game:GetService('UserInputService')

-- // // // Locals // // // --
local LocalPlayer = Players.LocalPlayer
local LocalCharacter = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local HumanoidRootPart = LocalCharacter:FindFirstChild("HumanoidRootPart")
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")
local teleportSpots = {}
local PlayerNamesCache = {}

-- // // // Functions // // // --
function ShowNotification(String)
    Fluent:Notify({
        Title = "NengzXHUB",
        Content = String,
        Duration = 5
    })
end

local function UpdatePlayerList() 
    PlayerNamesCache = {}
    for _, player in pairs(Players:GetPlayers()) do
        table.insert(PlayerNamesCache, player.Name)
    end
end

-- // UI and Button Configurations // -- 
local Tabs = {
    Home = Window:AddTab({ Title = "Home", Icon = "home" }),
    Main = Window:AddTab({ Title = "Main", Icon = "list" }),
    Items = Window:AddTab({ Title = "Items", Icon = "box" }),
    Teleports = Window:AddTab({ Title = "Teleports", Icon = "map-pin" }),
    Misc = Window:AddTab({ Title = "Misc", Icon = "file-text" }),
    Trade = Window:AddTab({ Title = "Trade", Icon = "gift" })
}

do
    -- Home Tab
    Tabs.Home:AddButton({
        Title = "Copy Telegram link",
        Description = "Chat With Dev!",
        Callback = function()
            setclipboard("https://t.me/ismenengzx")
        end
    })

    -- Main Tab
    local section = Tabs.Main:AddSection("Auto Fishing")
    local autoCastToggle = Tabs.Main:AddToggle("autoCast", {Title = "Auto Cast", Default = false })
    local autoShakeToggle = Tabs.Main:AddToggle("autoShake", {Title = "Auto Shake", Default = false })
    local autoReelToggle = Tabs.Main:AddToggle("autoReel", {Title = "Auto Reel", Default = false })
    local freezeCharacterToggle = Tabs.Main:AddToggle("freezeCharacter", {Title = "Freeze Character", Default = false })

    -- Mode Options
    local sectionModes = Tabs.Main:AddSection("Mode Fishing")
    local autoCastMode = Tabs.Main:AddDropdown("autoCastMode", {
        Title = "Auto Cast Mode",
        Values = {"Legit", "Blatant"},
        Multi = false,
        Default = "Legit",
    })
    local autoShakeMode = Tabs.Main:AddDropdown("autoShakeMode", {
        Title = "Auto Shake Mode",
        Values = {"Navigation", "Mouse"},
        Multi = false,
        Default = "Navigation",
    })
    local autoReelMode = Tabs.Main:AddDropdown("autoReelMode", {
        Title = "Auto Reel Mode",
        Values = {"Legit", "Blatant"},
        Multi = false,
        Default = "Legit",
    })

    -- Items Tab
    local sectionItems = Tabs.Items:AddSection("Sell Items")
    Tabs.Items:AddButton({
        Title = "Sell Hand",
        Callback = function()
            -- Implementation for selling hand
        end
    })
    Tabs.Items:AddButton({
        Title = "Sell All",
        Callback = function()
            -- Implementation for selling all
        end
    })

    -- Teleports Tab
    local sectionTeleports = Tabs.Teleports:AddSection("Select Teleport")
    local IslandTPDropdownUI = Tabs.Teleports:AddDropdown("IslandTPDropdownUI", {
        Title = "Area Teleport",
        Values = teleportSpots,
        Multi = false,
        Default = nil,
    })
    
    IslandTPDropdownUI:OnChanged(function(Value)
        if teleportSpots and HumanoidRootPart then
            xpcall(function()
                HumanoidRootPart.CFrame = TpSpotsFolder:FindFirstChild(Value).CFrame + Vector3.new(0, 5, 0)
                IslandTPDropdownUI:SetValue(nil) -- Reset the dropdown
            end,function (err)
                -- Handle any errors here
            end)
        end
    end)
    
    -- World Events Dropdown
    local WorldEventTPDropdownUI = Tabs.Teleports:AddDropdown("WorldEventTPDropdownUI", {
        Title = "Select World Event",
        Values = {"Strange Whirlpool", "Great Hammerhead Shark", "Great White Shark", "Whale Shark", "The Depths - Serpent", "Megalodon"},
        Multi = false,
        Default = nil,
    })

    WorldEventTPDropdownUI:OnChanged(function(Value)
        local offset = Vector3.new(0, 0, 0)
        local WorldEventLocations = {
            ["Strange Whirlpool"] = CFrame.new(game.Workspace.zones.fishing.Isonade.Position + offset),
            ["Great Hammerhead Shark"] = CFrame.new(game.Workspace.zones.fishing["Great Hammerhead Shark"].Position + offset),
            ["Great White Shark"] = CFrame.new(game.Workspace.zones.fishing["Great White Shark"].Position + offset),
            ["Whale Shark"] = CFrame.new(game.Workspace.zones.fishing["Whale Shark"].Position + offset),
            ["The Depths - Serpent"] = CFrame.new(game.Workspace.zones.fishing["The Depths - Serpent"].Position + Vector3.new(0, 50, 0)),
            ["Megalodon"] = CFrame.new(game.Workspace.zones.fishing["Megalodon"].Position + offset),
        }

        if WorldEventLocations[Value] and HumanoidRootPart then
            HumanoidRootPart.CFrame = WorldEventLocations[Value]
            WorldEventTPDropdownUI:SetValue(nil) -- Reset the dropdown
        else
            ShowNotification("Not found: " .. Value)
        end
    end)

    -- Dropdown for Teleporting to Players
    local TeleportToPlayerDropdownUI = Tabs.Teleports:AddDropdown("TeleportToPlayerDropdownUI", {
        Title = "Teleport To Player",
        Values = PlayerNamesCache,  -- To be filled with actual player names
        Multi = false,
        Default = nil,
    })

    TeleportToPlayerDropdownUI:OnChanged(function(Value)
        for _, player in pairs(Players:GetPlayers()) do
            if player.Name == Value and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                HumanoidRootPart.CFrame = player.Character.HumanoidRootPart.CFrame + Vector3.new(0, 5, 0)
                TeleportToPlayerDropdownUI:SetValue(nil) -- Reset the dropdown after teleporting
                break
            end
        end
    end)

    -- Button to teleport to the Traveler Merchant
    Tabs.Teleports:AddButton({
        Title = "Teleport to Traveler Merchant",
        Description = "Teleports to the Traveler Merchant.",
        Callback = function()
            local Merchant = Workspace.active:FindFirstChild("Merchant Boat")
            if not Merchant then return ShowNotification("Merchant not found") end
            HumanoidRootPart.CFrame = CFrame.new(Merchant.Boat["Merchant Boat"].r.HandlesR.Position)
        end
    })
    
    -- Update Dropdown Values
    UpdatePlayerList() -- Initial call to populate the dropdown with current player names
    Players.PlayerAdded:Connect(UpdatePlayerList)
    Players.PlayerRemoving:Connect(UpdatePlayerList)

end

Window:SelectTab(1)
Fluent:Notify({
    Title = "NengzX",
    Content = "Executed!",
    Duration = 8
})

-- End of the Code
