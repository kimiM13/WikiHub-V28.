--[[ 
    WIKI HUB V28 - PREMIER EDITION (OFFICIAL FINAL)
    - Remastered Glassmorphism UI
    - Full Features: Aimbot, ESP, Speed, Jump, Anti-AFK
    - Key: WIKI-STICKY-2026
]]

local Players = game:GetService("Players")
local CoreGui = game:GetService("CoreGui")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer
local Mouse = LocalPlayer:GetMouse()
local Camera = workspace.CurrentCamera

-- 1. SETTINGS & TOGGLES
local CorrectKey = "WIKI-STICKY-2026"
local KeyLink = "https://link-target.net/5619429/sEc1X5tV24cw"

_G.Aimbot = false
_G.ESP = false
_G.AntiAFK = false
_G.WS_Enabled = false
_G.JP_Enabled = false

-- 2. GUI CONSTRUCTION
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "WikiHub_V28_Official"
ScreenGui.Parent = CoreGui
ScreenGui.ResetOnSpawn = false

-- FLOATING BUTTON
local ToggleBtn = Instance.new("TextButton")
ToggleBtn.Name = "WikiToggle"
ToggleBtn.Parent = ScreenGui
ToggleBtn.Size = UDim2.new(0, 55, 0, 55)
ToggleBtn.Position = UDim2.new(0.05, 0, 0.15, 0)
ToggleBtn.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
ToggleBtn.Text = "W"
ToggleBtn.TextColor3 = Color3.fromRGB(255, 0, 0)
ToggleBtn.Font = Enum.Font.GothamBold
ToggleBtn.TextSize = 25
ToggleBtn.Visible = false
ToggleBtn.Active = true
ToggleBtn.Draggable = true

local TCorner = Instance.new("UICorner", ToggleBtn)
TCorner.CornerRadius = UDim.new(1, 0)
local TStroke = Instance.new("UIStroke", ToggleBtn)
TStroke.Color = Color3.fromRGB(255, 0, 0)
TStroke.Thickness = 2

-- MAIN MENU FRAME
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.Size = UDim2.new(0, 380, 0, 320)
MainFrame.Position = UDim2.new(0.5, -190, 0.5, -160)
MainFrame.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
MainFrame.Visible = false
MainFrame.Active = true
MainFrame.Draggable = true

Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 15)
local MStroke = Instance.new("UIStroke", MainFrame)
MStroke.Color = Color3.fromRGB(40, 40, 40)
MStroke.Thickness = 1.5

-- Top Glow Bar
local GlowBar = Instance.new("Frame", MainFrame)
GlowBar.Size = UDim2.new(1, 0, 0, 3)
GlowBar.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
GlowBar.BorderSizePixel = 0

local Title = Instance.new("TextLabel", MainFrame)
Title.Size = UDim2.new(1, 0, 0, 55)
Title.Text = "WIKI HUB <font color='#FF0000'>V28</font>"
Title.RichText = true
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.BackgroundTransparency = 1
Title.Font = Enum.Font.GothamBold
Title.TextSize = 22

local Container = Instance.new("ScrollingFrame", MainFrame)
Container.Size = UDim2.new(1, -30, 1, -85)
Container.Position = UDim2.new(0, 15, 0, 65)
Container.BackgroundTransparency = 1
Container.CanvasSize = UDim2.new(0, 0, 2, 0)
Container.ScrollBarThickness = 0

local UIList = Instance.new("UIListLayout", Container)
UIList.Padding = UDim.new(0, 10)

-- 3. MODERN TOGGLE FUNCTION
local function CreateToggle(name, callback)
    local TFrame = Instance.new("Frame", Container)
    TFrame.Size = UDim2.new(1, 0, 0, 50)
    TFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    Instance.new("UICorner", TFrame).CornerRadius = UDim.new(0, 10)
    Instance.new("UIStroke", TFrame).Color = Color3.fromRGB(35, 35, 35)

    local TName = Instance.new("TextLabel", TFrame)
    TName.Size = UDim2.new(0.6, 0, 1, 0)
    TName.Position = UDim2.new(0, 15, 0, 0)
    TName.Text = name
    TName.TextColor3 = Color3.fromRGB(200, 200, 200)
    TName.TextXAlignment = Enum.TextXAlignment.Left
    TName.BackgroundTransparency = 1
    TName.Font = Enum.Font.GothamMedium
    TName.TextSize = 14

    local SwitchBG = Instance.new("TextButton", TFrame)
    SwitchBG.Size = UDim2.new(0, 48, 0, 24)
    SwitchBG.Position = UDim2.new(1, -60, 0.5, -12)
    SwitchBG.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    SwitchBG.Text = ""
    Instance.new("UICorner", SwitchBG).CornerRadius = UDim.new(1, 0)

    local Circle = Instance.new("Frame", SwitchBG)
    Circle.Size = UDim2.new(0, 18, 0, 18)
    Circle.Position = UDim2.new(0, 3, 0.5, -9)
    Circle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Instance.new("UICorner", Circle).CornerRadius = UDim.new(1, 0)

    local active = false
    SwitchBG.MouseButton1Click:Connect(function()
        active = not active
        local goalPos = active and UDim2.new(1, -21, 0.5, -9) or UDim2.new(0, 3, 0.5, -9)
        local goalCol = active and Color3.fromRGB(255, 0, 0) or Color3.fromRGB(40, 40, 40)
        
        TweenService:Create(Circle, TweenInfo.new(0.3, Enum.EasingStyle.Quart), {Position = goalPos}):Play()
        TweenService:Create(SwitchBG, TweenInfo.new(0.3), {BackgroundColor3 = goalCol}):Play()
        callback(active)
    end)
end

-- 4. CORE ENGINE (LOGIC)
local function GetClosest()
    local target, dist = nil, math.huge
    for _, v in pairs(Players:GetPlayers()) do
        if v ~= LocalPlayer and v.Character and v.Character:FindFirstChild("HumanoidRootPart") then
            local pos, vis = Camera:WorldToViewportPoint(v.Character.HumanoidRootPart.Position)
            if vis then
                local mag = (Vector2.new(pos.X, pos.Y) - Vector2.new(Mouse.X, Mouse.Y)).Magnitude
                if mag < dist then target = v; dist = mag end
            end
        end
    end
    return target
end

RunService.RenderStepped:Connect(function()
    -- Aimbot Logic
    if _G.Aimbot then
        local t = GetClosest()
        if t then Camera.CFrame = CFrame.new(Camera.CFrame.Position, t.Character.HumanoidRootPart.Position) end
    end
    
    -- ESP & Stats Logic
    for _, v in pairs(Players:GetPlayers()) do
        if v ~= LocalPlayer and v.Character then
            local h = v.Character:FindFirstChild("WikiESP")
            if _G.ESP then
                if not h then
                    h = Instance.new("Highlight", v.Character)
                    h.Name = "WikiESP"
                    h.FillColor = Color3.fromRGB(255, 0, 0)
                end
                h.Enabled = true
            elseif h then h.Enabled = false end
        end
    end

    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
        LocalPlayer.Character.Humanoid.WalkSpeed = _G.WS_Enabled and 100 or 16
        LocalPlayer.Character.Humanoid.JumpPower = _G.JP_Enabled and 150 or 50
    end
end)

-- 5. FEATURES INJECTION
CreateToggle("Absolute Sticky (Aimbot)", function(v) _G.Aimbot = v end)
CreateToggle("High-Res ESP (Red Glow)", function(v) _G.ESP = v end)
CreateToggle("Super Speed Mode (100)", function(v) _G.WS_Enabled = v end)
CreateToggle("Mega Jump Mode (150)", function(v) _G.JP_Enabled = v end)
CreateToggle("Anti-AFK Security", function(v) _G.AntiAFK = v end)

-- 6. KEY SYSTEM SCREEN
local KeyFrame = Instance.new("Frame", ScreenGui)
KeyFrame.Size = UDim2.new(0, 340, 0, 240)
KeyFrame.Position = UDim2.new(0.5, -170, 0.5, -120)
KeyFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
Instance.new("UICorner", KeyFrame).CornerRadius = UDim.new(0, 15)
local KStroke = Instance.new("UIStroke", KeyFrame)
KStroke.Color = Color3.fromRGB(255, 0, 0)

local KTitle = Title:Clone()
KTitle.Parent = KeyFrame
KTitle.Text = "AUTHENTICATION"

local KInput = Instance.new("TextBox", KeyFrame)
KInput.Size = UDim2.new(0.8, 0, 0, 45)
KInput.Position = UDim2.new(0.1, 0, 0.4, 0)
KInput.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
KInput.PlaceholderText = "Paste Key Here..."
KInput.Text = ""
KInput.TextColor3 = Color3.fromRGB(255, 255, 255)
Instance.new("UICorner", KInput)

local KSubmit = Instance.new("TextButton", KeyFrame)
KSubmit.Size = UDim2.new(0.8, 0, 0, 45)
KSubmit.Position = UDim2.new(0.1, 0, 0.65, 0)
KSubmit.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
KSubmit.Text = "ACTIVATE"
KSubmit.TextColor3 = Color3.fromRGB(255, 255, 255)
KSubmit.Font = Enum.Font.GothamBold
Instance.new("UICorner", KSubmit)

KSubmit.MouseButton1Click:Connect(function()
    if KInput.Text == CorrectKey then
        KeyFrame:Destroy()
        MainFrame.Visible = true
        ToggleBtn.Visible = true
    else
        KInput.Text = ""; KInput.PlaceholderText = "INVALID KEY!"
    end
end)

ToggleBtn.MouseButton1Click:Connect(function()
    MainFrame.Visible = not MainFrame.Visible
end)

LocalPlayer.Idled:Connect(function()
    if _G.AntiAFK then game:GetService("VirtualUser"):CaptureController(); game:GetService("VirtualUser"):ClickButton2(Vector2.new()) end
end)
