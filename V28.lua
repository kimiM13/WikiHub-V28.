--[[ 
    WIKI HUB V28 - ULTIMATE CUSTOM EDITION
    - Rayfield Style Sliding Toggles (Green/Red)
    - Smooth Tweens & Floating Button
    - Instant Load Logic
]]

local Players = game:GetService("Players")
local CoreGui = game:GetService("CoreGui")
local TweenService = game:GetService("TweenService")
local UIS = game:GetService("UserInputService")

-- 1. DATA & CONFIG
local CorrectKey = "WIKI-STICKY-2026"
local KeyLink = "https://link-target.net/5619429/sEc1X5tV24cw"
_G.Aimbot = false
_G.ESP = false
_G.AntiAFK = false

-- 2. GUI BASE
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "WikiHub_V28_Final"
ScreenGui.Parent = CoreGui
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.ResetOnSpawn = false

-- 3. FLOATING TOGGLE BUTTON (Open/Close)
local ToggleBtn = Instance.new("TextButton")
ToggleBtn.Parent = ScreenGui
ToggleBtn.Size = UDim2.new(0, 55, 0, 55)
ToggleBtn.Position = UDim2.new(0.05, 0, 0.4, 0)
ToggleBtn.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
ToggleBtn.Text = "W"
ToggleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleBtn.Font = Enum.Font.GothamBold
ToggleBtn.TextSize = 24
ToggleBtn.Visible = false -- Muncul lepas key betul
ToggleBtn.Active = true
ToggleBtn.Draggable = true
Instance.new("UICorner", ToggleBtn).CornerRadius = UDim.new(1, 0)

-- 4. MAIN HUB FRAME
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.Size = UDim2.new(0, 350, 0, 300)
MainFrame.Position = UDim2.new(0.5, -175, 0.5, -150)
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
MainFrame.Visible = false
MainFrame.Active = true
MainFrame.Draggable = true
Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 12)

-- Header
local Title = Instance.new("TextLabel", MainFrame)
Title.Size = UDim2.new(1, 0, 0, 50)
Title.Text = "WIKI HUB V28 | PREMIUM"
Title.TextColor3 = Color3.fromRGB(255, 0, 0)
Title.BackgroundTransparency = 1
Title.Font = Enum.Font.GothamBold
Title.TextSize = 20

local Container = Instance.new("ScrollingFrame", MainFrame)
Container.Size = UDim2.new(1, -20, 1, -70)
Container.Position = UDim2.new(0, 10, 0, 55)
Container.BackgroundTransparency = 1
Container.CanvasSize = UDim2.new(0, 0, 1.5, 0)
Container.ScrollBarThickness = 2

local UIList = Instance.new("UIListLayout", Container)
UIList.Padding = UDim.new(0, 8)

-- 5. FUNCTION: CREATE SLIDING TOGGLE (Rayfield Style)
local function CreateToggle(name, callback)
    local TFrame = Instance.new("Frame", Container)
    TFrame.Size = UDim2.new(1, 0, 0, 45)
    TFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    Instance.new("UICorner", TFrame)

    local TName = Instance.new("TextLabel", TFrame)
    TName.Size = UDim2.new(0.6, 0, 1, 0)
    TName.Position = UDim2.new(0, 15, 0, 0)
    TName.Text = name
    TName.TextColor3 = Color3.fromRGB(230, 230, 230)
    TName.TextXAlignment = Enum.TextXAlignment.Left
    TName.BackgroundTransparency = 1
    TName.Font = Enum.Font.Gotham
    TName.TextSize = 14

    local SwitchBG = Instance.new("TextButton", TFrame)
    SwitchBG.Size = UDim2.new(0, 44, 0, 22)
    SwitchBG.Position = UDim2.new(1, -55, 0.5, -11)
    SwitchBG.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
    SwitchBG.Text = ""
    Instance.new("UICorner", SwitchBG).CornerRadius = UDim.new(1, 0)

    local Circle = Instance.new("Frame", SwitchBG)
    Circle.Size = UDim2.new(0, 18, 0, 18)
    Circle.Position = UDim2.new(0, 2, 0.5, -9)
    Circle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Instance.new("UICorner", Circle).CornerRadius = UDim.new(1, 0)

    local isOn = false
    SwitchBG.MouseButton1Click:Connect(function()
        isOn = not isOn
        local targetPos = isOn and UDim2.new(1, -20, 0.5, -9) or UDim2.new(0, 2, 0.5, -9)
        local targetCol = isOn and Color3.fromRGB(0, 200, 100) or Color3.fromRGB(45, 45, 45)
        
        TweenService:Create(Circle, TweenInfo.new(0.25), {Position = targetPos}):Play()
        TweenService:Create(SwitchBG, TweenInfo.new(0.25), {BackgroundColor3 = targetCol}):Play()
        callback(isOn)
    end)
end

-- ADD FEATURES
CreateToggle("Absolute Sticky (Aimbot)", function(v) _G.Aimbot = v end)
CreateToggle("High-Resolution ESP", function(v) _G.ESP = v end)
CreateToggle("Anti-AFK Security", function(v) _G.AntiAFK = v end)

-- 6. KEY SYSTEM SCREEN
local KeyFrame = Instance.new("Frame", ScreenGui)
KeyFrame.Size = UDim2.new(0, 320, 0, 220)
KeyFrame.Position = UDim2.new(0.5, -160, 0.5, -110)
KeyFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
Instance.new("UICorner", KeyFrame).CornerRadius = UDim.new(0, 15)

local KTitle = Instance.new("TextLabel", KeyFrame)
KTitle.Size = UDim2.new(1, 0, 0, 50)
KTitle.Text = "WIKI HUB | VERIFICATION"
KTitle.TextColor3 = Color3.fromRGB(255, 0, 0)
KTitle.BackgroundTransparency = 1
KTitle.Font = Enum.Font.GothamBold
KTitle.TextSize = 18

local KInput = Instance.new("TextBox", KeyFrame)
KInput.Size = UDim2.new(0.85, 0, 0, 45)
KInput.Position = UDim2.new(0.075, 0, 0.3, 0)
KInput.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
KInput.PlaceholderText = "Enter Key Here..."
KInput.Text = ""
KInput.TextColor3 = Color3.fromRGB(255, 255, 255)
KInput.Font = Enum.Font.Gotham
Instance.new("UICorner", KInput)

local KSubmit = Instance.new("TextButton", KeyFrame)
KSubmit.Size = UDim2.new(0.85, 0, 0, 40)
KSubmit.Position = UDim2.new(0.075, 0, 0.55, 0)
KSubmit.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
KSubmit.Text = "SUBMIT"
KSubmit.TextColor3 = Color3.fromRGB(255, 255, 255)
KSubmit.Font = Enum.Font.GothamBold
Instance.new("UICorner", KSubmit)

local KGet = Instance.new("TextButton", KeyFrame)
KGet.Size = UDim2.new(0.85, 0, 0, 30)
KGet.Position = UDim2.new(0.075, 0, 0.78, 0)
KGet.BackgroundTransparency = 1
KGet.Text = "Get Key (Copy Linkvertise)"
KGet.TextColor3 = Color3.fromRGB(150, 150, 150)
KGet.Font = Enum.Font.Gotham
KGet.TextSize = 12

-- KEY LOGIC
KSubmit.MouseButton1Click:Connect(function()
    if KInput.Text == CorrectKey then
        KeyFrame:Destroy()
        MainFrame.Visible = true
        ToggleBtn.Visible = true
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "Success!",
            Text = "Wiki Hub Activated. Press 'W' to toggle.",
            Duration = 5
        })
    else
        KInput.Text = ""
        KInput.PlaceholderText = "WRONG KEY! TRY AGAIN."
    end
end)

KGet.MouseButton1Click:Connect(function()
    setclipboard(KeyLink)
    KGet.Text = "LINK COPIED TO CLIPBOARD!"
    task.wait(2)
    KGet.Text = "Get Key (Copy Linkvertise)"
end)

-- TOGGLE BUTTON LOGIC
ToggleBtn.MouseButton1Click:Connect(function()
    MainFrame.Visible = not MainFrame.Visible
end)

-- 7. CORE LOGIC (Anti-AFK)
game:GetService("Players").LocalPlayer.Idled:Connect(function()
    if _G.AntiAFK then
        local VU = game:GetService("VirtualUser")
        VU:CaptureController()
        VU:ClickButton2(Vector2.new())
    end
end)

print("Wiki Hub V28 Loaded Successfully!")
