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
    Title = game:GetService("MarketplaceService"):GetProductInfo(16732694052).Name .. " | NengzXHUB-Freemium",
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

-- // // // Locals // // // --
local LocalPlayer = Players.LocalPlayer
local LocalCharacter = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local HumanoidRootPart = LocalCharacter:WaitForChild("HumanoidRootPart")

-- // // // Features List // // // --


-- // // // Functions // // // --
function ShowNotification(String)
    Fluent:Notify({
        Title = "NengzXHUB",
        Content = String,
        Duration = 5
    })
end

local function getPlayerNames()
    local names = {}
    for _, player in pairs(Players:GetPlayers()) do
        if player.Name ~= LocalPlayer.Name then -- Exclude yourself
            table.insert(names, player.Name)
        end
    end
    return names
end

local function teleportToPlayer(playerName)
    local player = Players:FindFirstChild(playerName)
    if player and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
        HumanoidRootPart.CFrame = player.Character.HumanoidRootPart.CFrame + Vector3.new(0, 5, 0) -- Slightly above the player
        ShowNotification("Teleported to " .. playerName)
    else
        ShowNotification("Player not found or has no character!")
    end
end

-- // // // Tabs Gui // // // --

local Tabs = {
    Home = Window:AddTab({ Title = "Home", Icon = "home" }),
    Main = Window:AddTab({ Title = "Main", Icon = "list" }),
    Items = Window:AddTab({ Title = "Items", Icon = "box" }),
    Teleports = Window:AddTab({ Title = "Teleports", Icon = "map-pin" }),
    Misc = Window:AddTab({ Title = "Misc", Icon = "file-text" }),
    Trade = Window:AddTab({ Title = "Trade", Icon = "gift" })
}

-- // Teleports Tab // --
local Section = Tabs.Teleports:AddSection("Select Teleport")

local PlayerTPDropdown = Tabs.Teleports:AddDropdown("PlayerTPDropdown", {
    Title = "Teleport To Player",
    Values = getPlayerNames(),
    Multi = false,
    Default = nil,
})

PlayerTPDropdown:OnChanged(function(selectedPlayerName)
    if selectedPlayerName then
        teleportToPlayer(selectedPlayerName)
        PlayerTPDropdown:SetValue(nil) -- Optionally reset the dropdown
    end
end)

Players.PlayerAdded:Connect(function()
    PlayerTPDropdown:SetValues(getPlayerNames())
end)

Players.PlayerRemoving:Connect(function()
    PlayerTPDropdown:SetValues(getPlayerNames())
end)

PlayerTPDropdown:SetValues(getPlayerNames()) -- Initialize the dropdown values

-- The rest of your code follows here...
-- Add the previous sections, such as Options, various toggle buttons, and other sections for fishing, selling items, etc.

Window:SelectTab(1)

Fluent:Notify({
    Title = "NengzX",
    Content = "Executed!",
    Duration = 8
})

-- The rest of the original functionality of your script should be included here to keep everything intact.
