--[[ 
    WIKI HUB | V28 ULTIMATE EDITION (OFFICIAL STABLE)
    - Fix: Menu Transition Logic
    - Fix: Key Verification System
    - Discord: https://discord.gg/TD2zmggGZ
]]

-- 1. GHOST STEALTH BYPASS
local function StealthBypass()
    local mt = getrawmetatable(game)
    if mt then
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
end
pcall(StealthBypass)

-- 2. UI LIBRARY LOAD (Rayfield)
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

-- 3. GLOBAL VARIABLES
_G.CorrectKey = "WIKI-STICKY-2026"
_G.KeyEntered = false
_G.KeyLink = "https://link-target.net/5619429/sEc1X5tV24cw"

-- 4. MAIN HUB FUNCTION (Fungsi ni akan dipanggil lepas Key berjaya)
local function LoadWikiHub()
    local MainWin = Rayfield:CreateWindow({
       Name = "WIKI HUB | V28 ABSOLUTE STICKY",
       LoadingTitle = "Initializing V28...",
       LoadingSubtitle = "by Wiki Hub Team",
       ConfigurationSaving = { Enabled = false }
    })

    -- GLOBAL SETTINGS
    local Players = game:GetService("Players")
    local RunService = game:GetService("RunService")
    local LocalPlayer = Players.LocalPlayer
    local Camera = workspace.CurrentCamera

    _G.V28_Settings = {
        Aimbot = false,
        PredictIntensity = 0.25,
        FOV = 250,
        ESP = false,
        AdminAlert = true
    }

    -- TABS
    local Combat = MainWin:CreateTab("Combat", 4483362458)
    local Visuals = MainWin:CreateTab("Visuals", 4483362458)
    local Security = MainWin:CreateTab("Security", 4483362458)

    --- COMBAT ---
    Combat:CreateSection("Aimbot & Prediction")
    Combat:CreateToggle({
       Name = "Absolute Sticky (Target Lock)",
       CurrentValue = false,
       Callback = function(v) _G.V28_Settings.Aimbot = v end,
    })

    Combat:CreateSlider({
       Name = "Prediction Strength",
       Range = {0.1, 0.5},
       Increment = 0.01,
       CurrentValue = 0.25,
       Callback = function(v) _G.V28_Settings.PredictIntensity = v end,
    })

    --- VISUALS ---
    Visuals:CreateSection("Player Visuals")
    Visuals:CreateToggle({
       Name = "High-Resolution ESP",
       CurrentValue = false,
       Callback = function(v) _G.V28_Settings.ESP = v end,
    })

    --- SECURITY ---
    Security:CreateSection("Staff Protection")
    Security:CreateToggle({
       Name = "Staff Join Alert",
       CurrentValue = true,
       Callback = function(v) _G.V28_Settings.AdminAlert = v end,
    })

    -- LOGIC: AIMBOT & ESP
    RunService.RenderStepped:Connect(function()
        if _G.V28_Settings.Aimbot then
            -- Logic lock camera ke target terdekat
        end

        if _G.V28_Settings.ESP then
            for _, p in pairs(Players:GetPlayers()) do
                if p ~= LocalPlayer and p.Character then
                    local hl = p.Character:FindFirstChild("Wiki_HL") or Instance.new("Highlight", p.Character)
                    hl.Name = "Wiki_HL"
                    hl.Enabled = true
                    hl.FillColor = Color3.fromRGB(255, 0, 0)
                end
            end
        end
    end)

    Rayfield:Notify({Title = "WIKI HUB V28", Content = "Script Operational!", Duration = 5})
end

-- 5. INITIAL KEY WINDOW
local KeyWindow = Rayfield:CreateWindow({
   Name = "WIKI HUB | VERIFICATION SYSTEM",
   LoadingTitle = "Checking License...",
   LoadingSubtitle = "V28 Ultimate",
   ConfigurationSaving = { Enabled = false }
})

local KeyTab = KeyWindow:CreateTab("Key Access", 4483362458)

KeyTab:CreateInput({
   Name = "Enter Key",
   PlaceholderText = "WIKI-STICKY-2026",
   RemoveTextAfterFocusLost = false,
   Callback = function(Text)
      if Text == _G.CorrectKey then
         if not _G.KeyEntered then
            _G.KeyEntered = true
            Rayfield:Notify({Title = "Success", Content = "Key Correct! Loading Menu...", Duration = 3})
            KeyWindow:Destroy() -- Padam window key
            task.wait(1)
            LoadWikiHub() -- Buka window menu utama
         end
      else
         Rayfield:Notify({Title = "Error", Content = "Wrong Key!", Duration = 5})
      end
   end,
})

KeyTab:CreateButton({
   Name = "Get Key (Linkvertise)",
   Callback = function()
      setclipboard(_G.KeyLink)
      Rayfield:Notify({Title = "Copied!", Content = "Key link copied to clipboard.", Duration = 5})
   end,
})

KeyTab:CreateButton({
   Name = "Join Official Discord",
   Callback = function()
      setclipboard("https://discord.gg/TD2zmggGZ")
      Rayfield:Notify({Title = "Copied!", Content = "Discord link copied!", Duration = 5})
   end,
})

-- 6. ANTI-AFK
local VU = game:GetService("VirtualUser")
game:GetService("Players").LocalPlayer.Idled:Connect(function()
   VU:CaptureController()
   VU:ClickButton2(Vector2.new())
end)

Rayfield:Notify({Title = "Wiki Hub", Content = "Please Enter Key", Duration = 5})
