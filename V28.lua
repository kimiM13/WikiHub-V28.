--[[ 
    WIKI HUB | V28 ULTIMATE EDITION (OFFICIAL RELEASE)
    - Fully Integrated Key System (Linkvertise Optimized)
    - Absolute Sticky & Kinetic Tracking (Run/Jump Lock)
    - Admin Shield & Ghost Stealth Bypass
    - Discord: https://discord.gg/TD2zmggGZ
]]

-- 1. GHOST STEALTH BYPASS (Anti-Log/Anti-Report)
local function StealthBypass()
    local mt = getrawmetatable(game)
    setreadonly(mt, false)
    local old = mt.__namecall
    mt.__namecall = newcclosure(function(self, ...)
        if not checkcaller() and (getnamecallmethod() == "FireServer") then
            local name = self.Name:lower()
            if name:find("log") or name:find("cheat") or name:find("report") then return nil end
        end
        return old(self, ...)
    end)
    setreadonly(mt, true)
end
pcall(StealthBypass)

-- 2. UI LIBRARY LOAD (Rayfield)
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

-- 3. GLOBAL VARIABLES
_G.CorrectKey = "WIKI-STICKY-2026"
_G.KeyEntered = false
_G.KeyLink = "https://link-target.net/5619429/sEc1X5tV24cw"

-- 4. INITIAL VERIFICATION WINDOW
local KeyWindow = Rayfield:CreateWindow({
   Name = "WIKI HUB | VERIFICATION SYSTEM",
   LoadingTitle = "Authenticating Wiki Hub License...",
   LoadingSubtitle = "Secure Access Terminal",
   ConfigurationSaving = { Enabled = false }
})

local KeyTab = KeyWindow:CreateTab("Key Access", 4483362458)

-- 5. MAIN SCRIPT FUNCTION (LOADS AFTER KEY)
local function LoadWikiHub()
    local MainWin = Rayfield:CreateWindow({
       Name = "WIKI HUB | V28 ABSOLUTE STICKY",
       LoadingTitle = "Initializing Hub...",
       LoadingSubtitle = "Precision Technology Enabled",
       ConfigurationSaving = { Enabled = false }
    })

    -- GLOBAL SETTINGS
    local Players = game:GetService("Players")
    local RunService = game:GetService("RunService")
    local LocalPlayer = Players.LocalPlayer
    local Camera = workspace.CurrentCamera

    local _G_V28 = {
        Aimbot = false,
        WallCheck = true,
        PredictIntensity = 0.25,
        FOV = 250,
        ESP = false,
        TeamCheck = true,
        AdminAlert = true
    }

    -- TABS
    local Combat = MainWin:CreateTab("Combat", 4483362458)
    local Visuals = MainWin:CreateTab("Visuals", 4483362458)
    local Security = MainWin:CreateTab("Security", 4483362458)

    --- COMBAT SECTION ---
    Combat:CreateSection("Aimbot & Prediction")

    Combat:CreateToggle({
       Name = "Absolute Sticky (Target Lock)",
       CurrentValue = false,
       Callback = function(v) _G_V28.Aimbot = v end,
    })

    Combat:CreateSlider({
       Name = "Prediction Strength",
       Range = {0.1, 0.5},
       Increment = 0.01,
       CurrentValue = 0.25,
       Callback = function(v) _G_V28.PredictIntensity = v end,
    })

    Combat:CreateSlider({
       Name = "FOV Radius",
       Range = {50, 800},
       Increment = 10,
       CurrentValue = 250,
       Callback = function(v) _G_V28.FOV = v end,
    })

    --- VISUALS SECTION ---
    Visuals:CreateSection("Player Visuals")

    Visuals:CreateToggle({
       Name = "High-Resolution ESP",
       CurrentValue = false,
       Callback = function(v) _G_V28.ESP = v end,
    })

    --- SECURITY SECTION ---
    Security:CreateSection("Admin Protection")

    Security:CreateToggle({
       Name = "Staff Join Notification",
       CurrentValue = true,
       Callback = function(v) _G_V28.AdminAlert = v end,
    })

    -- CORE LOGIC: ABSOLUTE STICKY
    local function GetStickyPos(target)
        local char = target.Character
        local hrp = char:FindFirstChild("HumanoidRootPart")
        local myHRP = LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
        if char and hrp and myHRP then
            local relVel = hrp.Velocity - myHRP.Velocity
            local yOffset = (math.abs(hrp.Velocity.Y) > 1) and (hrp.Velocity.Y * _G_V28.PredictIntensity * 0.5) or 0
            return char.Head.Position + (relVel * _G_V28.PredictIntensity) + Vector3.new(0, yOffset, 0)
        end
        return nil
    end

    local function GetClosestTarget()
        local target = nil
        local shortest = _G_V28.FOV
        for _, p in pairs(Players:GetPlayers()) do
            if p ~= LocalPlayer and p.Character and p.Character:FindFirstChild("Head") then
                if _G_V28.TeamCheck and (p.Team == LocalPlayer.Team) then continue end
                if p.Character:FindFirstChild("Humanoid") and p.Character.Humanoid.Health <= 0 then continue end
                
                local pos, onScreen = Camera:WorldToViewportPoint(p.Character.Head.Position)
                if onScreen then
                    local dist = (Vector2.new(pos.X, pos.Y) - Vector2.new(Camera.ViewportSize.X/2, Camera.ViewportSize.Y/2)).Magnitude
                    if dist < shortest then
                        if _G_V28.WallCheck then
                            local ray = Ray.new(Camera.CFrame.Position, (p.Character.Head.Position - Camera.CFrame.Position).Unit * 1000)
                            local hit = workspace:FindPartOnRayWithIgnoreList(ray, {LocalPlayer.Character, Camera})
                            if not (hit and hit:IsDescendantOf(p.Character)) then continue end
                        end
                        shortest = dist
                        target = p
                    end
                end
            end
        end
        return target
    end

    RunService.RenderStepped:Connect(function()
        if _G_V28.Aimbot then
            local t = GetClosestTarget()
            if t then
                local pPos = GetStickyPos(t)
                if pPos then
                    Camera.CFrame = CFrame.lookAt(Camera.CFrame.Position, pPos)
                end
            end
        end

        if _G_V28.ESP then
            for _, p in pairs(Players:GetPlayers()) do
                if p ~= LocalPlayer and p.Character then
                    local hl = p.Character:FindFirstChild("Wiki_HL")
                    if not hl then 
                        hl = Instance.new("Highlight", p.Character)
                        hl.Name = "Wiki_HL"
                    end
                    hl.Enabled = true
                    hl.FillColor = (p.Team ~= LocalPlayer.Team) and Color3.new(1,0,0) or Color3.new(0,1,0)
                end
            end
        end
    end)

    -- STAFF DETECTION
    Players.PlayerAdded:Connect(function(p)
        if _G_V28.AdminAlert then
            task.wait(2)
            local n = p.Name:lower()
            if n:find("admin") or n:find("mod") or n:find("staff") or n:find("dev") then
                Rayfield:Notify({Title = "SECURITY WARNING", Content = "Staff Member Detected: " .. p.Name, Duration = 10})
            end
        end
    end)

    Rayfield:Notify({Title = "System Operational", Content = "Welcome to Wiki Hub V28!", Duration = 5})
end

-- 6. KEY SYSTEM INTERFACE
KeyTab:CreateSection("Verification")

KeyTab:CreateInput({
   Name = "Enter Key",
   PlaceholderText = "Paste key here...",
   RemoveTextAfterFocusLost = false,
   Callback = function(Text)
      if Text == _G.CorrectKey then
         if not _G.KeyEntered then
            _G.KeyEntered = true
            Rayfield:Notify({Title = "Access Granted", Content = "Loading Main Hub...", Duration = 3})
            KeyWindow:Destroy()
            task.wait(0.5)
            LoadWikiHub()
         end
      else
         Rayfield:Notify({Title = "Invalid Key", Content = "Please check the key again or get a new one.", Duration = 5})
      end
   end,
})

KeyTab:CreateSection("Key Management")

KeyTab:CreateButton({
   Name = "Get Key (Linkvertise)",
   Callback = function()
      setclipboard(_G.KeyLink)
      Rayfield:Notify({Title = "Copied!", Content = "Linkvertise URL copied to clipboard.", Duration = 7})
   end,
})

KeyTab:CreateButton({
   Name = "Join Official Discord",
   Callback = function()
      setclipboard("https://discord.gg/TD2zmggGZ")
      Rayfield:Notify({Title = "Discord Link", Content = "Discord invite copied!", Duration = 5})
   end,
})

-- 7. ANTI-AFK MODULE
local VU = game:GetService("VirtualUser")
game:GetService("Players").LocalPlayer.Idled:Connect(function()
   VU:CaptureController()
   VU:ClickButton2(Vector2.new())
end)

Rayfield:Notify({Title = "Wiki Hub", Content = "Ready for Verification", Duration = 5})
