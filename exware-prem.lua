local library = loadstring(game:HttpGet("https://raw.githubusercontent.com/Consistt/Ui/main/UnLeaked"))()
local NetworkClient = cloneref(game:GetService("NetworkClient"))
library.rank = "Guest"
local Wm = library:Watermark("exware | v" .. library.version ..  " | " .. library:GetUsername() .. " | rank: " .. library.rank)


local Notif = library:InitNotifications()

local LoadingXSX = Notif:Notify("Loading ExWare please wait!.", 2, "LAST UPDATE 06/16/2024") 

library.title = "ExWare - The Strongest Battlegrounds"

library:Introduction()
wait(1)
local Init = library:Init()

local CombatTab = Init:NewTab("Combat")
local VisualTab = Init:NewTab("Visuals")
local TrollTab = Init:NewTab("Trolling")
local CombatSection = CombatTab:NewSection("PVP")
local VisualSection = VisualTab:NewSection("Visuals")
local TrollSection = TrollTab:NewSection("Trolling")

CombatSettings = {
    TargetWS = 3,
    EnableWalkSpeed = false,
    IsStunEnabled = false,
    TargetJP = 50,
    FlingEnabled = false,
    AutoBlock = false,
    Noclip = false,
    Crushing = false,
    Lethal = false,
    Flowing = false,
    SpeedMethod = "CFrame"
}

VisualSettings = {
    HighlightDC = false,
    ShowUlt = false,
}

local CrushingKill = TrollTab:NewToggle("Serious Crushing Pull", false, function(value)
    CombatSettings.Crushing = value
end)

local SeriousLethal = TrollTab:NewToggle("Serious Lethal Whirlwind", false, function(value)
    CombatSettings.Lethal = value
end)

local SeriousFlow = TrollTab:NewToggle("Serious Flowing Water", false, function(value)
    CombatSettings.Flowing = value
end)

local UseSpeedToggle = CombatTab:NewToggle("Use WalkSpeed", false, function(value)
    CombatSettings.EnableWalkSpeed = value
end):AddKeybind(Enum.KeyCode.LeftControl)
local UseSpeedToggle = CombatTab:NewToggle("Use Fling", false, function(value)
    CombatSettings.FlingEnabled = value
end):AddKeybind(Enum.KeyCode.Z)

local UseStunToggle = CombatTab:NewToggle("No Stun", false, function(value)
    CombatSettings.IsStunEnabled = value
end)

local AutoBlockToggle = CombatTab:NewToggle("Auto Block", false, function(value)
    CombatSettings.AutoBlock = value
end)

local AntiFlingToggle = CombatTab:NewToggle("Noclip/Antifling", false, function(value)
    CombatSettings.Noclip = value
end)




local WalkSpeedSlider = CombatTab:NewSlider("WalkSpeed", "", true, "/", {min = 1, max = 30, default = 3}, function(value)
    CombatSettings.TargetWS = value
end)

local WalkSpeedSlider = CombatTab:NewSlider("JumpPower", "", true, "/", {min = 50, max = 500, default = 500}, function(value)
    CombatSettings.TargetJP = value
end)

local MovementSelector = CombatTab:NewSelector("Select Speed Method", "Select Speed", {"CFrame", "Velocity", "WalkSpeed"}, function(d)
    CombatSettings.SpeedMethod = d
end)





local HitBoxSlider = CombatTab:NewSlider("Hitbox Extender", "", true, "/", {min = 1, max = 15, default = 10}, function(value)
    game.Players.LocalPlayer.Character:FindFirstChild("Hitbox_LeftArm").Size = Vector3.new(value, value, value)
    game.Players.LocalPlayer.Character:FindFirstChild("Hitbox_RightArm").Size = Vector3.new(value, value, value)
end)

local LagSec = CombatTab:NewSection("Lag Switch")
local lagtoggle = CombatTab:NewToggle("Imcoming Lag", false, function(value)
    if value == true then
        settings():GetService("NetworkSettings").IncomingReplicationLag = 5000
    else
        settings():GetService("NetworkSettings").IncomingReplicationLag = 0
    end
end):AddKeybind(Enum.KeyCode.LeftShift)

local cchar

local lagouttoggle = CombatTab:NewToggle("Outgoing Lag", false, function(value)
    if value == true then

        local s = Instance.new("Sound", workspace)
        s.SoundId = "rbxassetid://8036843509"
        s:Play()
        local sky = Instance.new("Sky", game.Lighting)
        sky.Name = "galaxy"
        sky.SkyboxBk = "http://www.roblox.com/asset/?id=159454299"
        sky.SkyboxDn = "http://www.roblox.com/asset/?id=159454299"
        sky.SkyboxFt = "http://www.roblox.com/asset/?id=159454299"
        sky.SkyboxLf = "http://www.roblox.com/asset/?id=159454299"
        sky.SkyboxRt = "http://www.roblox.com/asset/?id=159454299"
        sky.SkyboxUp = "http://www.roblox.com/asset/?id=159454299"
        NetworkClient:SetOutgoingKBPSLimit(0.5)
        cchar = game.Players.LocalPlayer.Character:Clone()
        for i,v in cchar:GetDescendants() do
            if v:IsA("Part") or v:IsA("BasePart") then
                v.Anchored = true
                v.CanCollide = false
                v.Transparency = 0.8
            end
        end
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(game.Players.LocalPlayer.Character.HumanoidRootPart.Position + Vector3.new(10,0,0))
        cchar.Parent = workspace.Live
        

        Instance.new("Highlight", cchar)
    else
        NetworkClient:SetOutgoingKBPSLimit(50000000000000000000)
        if cchar then cchar:Destroy() end
        local s = Instance.new("Sound", workspace)
        s.SoundId = "rbxassetid://8036843509"
        s:Play()
        if game.Lighting:FindFirstChild("galaxy") then game.Lighting:FindFirstChild("galaxy"):Destroy() end
    end
end):AddKeybind(Enum.KeyCode.LeftShift)


local ShowDCToggle = VisualTab:NewToggle("Show DeathCounter", false, function(value)
    VisualSettings.HighlightDC = value
end)
local ShowDCToggle = VisualTab:NewToggle("Show Ultimates", false, function(value)
    VisualSettings.ShowUlt = value
end)

workspace.Live.DescendantAdded:Connect(function(dec)
    if dec.Name == "Counter" and VisualSettings.HighlightDC == true then
        local dparent = dec.Parent
        local a = Instance.new("Highlight", dec.Parent)
        a.Name = "hdc" 
        repeat
            task.wait()
        until dparent:FindFirstChild("Counter")==nil
        a:Destroy()
    end
    if dec.Name == "Crushing Pull" and dec.Parent.Name == game.Players.LocalPlayer.Name and CombatSettings.Crushing then
        local hr = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
        wait(0.25)
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(99999,9999,9999)
        wait(1)
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = hr
    end
    if dec.Name == "Lethal Whirlwind Stream" and dec.Parent.Name == game.Players.LocalPlayer.Name and CombatSettings.Lethal then
        local hr = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
        wait(0.55)
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(99999,9999,9999)
        wait(2.5)
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = hr
    end
    if dec.Name == "Flowing Water" and dec.Parent.Name == game.Players.LocalPlayer.Name and CombatSettings.Flowing then
        local hr = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
        wait(0.55)
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(99999,9999,9999)
        wait(2.5)
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = hr
    end
end)


game.Players.LocalPlayer.Character.DescendantAdded:Connect(function(dec)

    if dec.Name == "RagdollSim" and CombatSettings.IsStunEnabled == true then
        game.Players.LocalPlayer.Character:FindFirstChild("Torso").Anchored = true
        repeat
            wait()
        until game.Players.LocalPlayer.Character:FindFirstChild("RagdollSim")==nil
        repeat
            game.Players.LocalPlayer.Character:FindFirstChild("Torso").Anchored = false
            wait()
        until game.Players.LocalPlayer.Character:FindFirstChild("Torso").Anchored == false
    end

    if dec.Name == "Freeze"or dec.Name == "NoRotate" or dec:IsA("BodyVelocity") or dec.Name == "RagdollSim" or dec.Name == "BeingGrabbed" and dec.Name == "Freeze" or dec.Name == "NoJump" or dec.Name == "NoBlock" or dec.Name == "M1ing" or dec.Name == "UsedDash" and CombatSettings.IsStunEnabled == true then
        SetStateEnabled(Enum.HumanoidStateType.Jumping, true)
        SetStateEnabled(Enum.HumanoidStateType.Running, true)
        dec:Destroy()
    end
end)

local bv = Instance.new("BodyVelocity", workspace)
bv.MaxForce = Vector3.new(10000000,0,10000000)
bv.Velocity = Vector3.new(0,0,0)

game:GetService("RunService").RenderStepped:Connect(function()
    for i,v in workspace.Live:GetDescendants() do
        if v:IsA("Highlight") and v.Parent:FindFirstChild("Humanoid") and v.Parent.Name ~= game.Players.LocalPlayer.Name and v.Name == "hdc" then
            if (v.Parent:FindFirstChild("HumanoidRootPart").Position - game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart").Position).Magnitude < 10 then
                local newcf = CFrame.new(game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart").Position.X + 5, game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart").Position.Y, game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart").Position.Z + 5)
                game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart").CFrame = newcf
            end
        end
    end
        chr = game.Players.LocalPlayer.Character
        hum = chr and chr:FindFirstChildWhichIsA("Humanoid")
        hum.JumpPower = CombatSettings.TargetJP
        hb = game:GetService("RunService").Heartbeat
        local delta = hb:wait()
        if hum.MoveDirection.Magnitude > 0 and CombatSettings.EnableWalkSpeed and CombatSettings.SpeedMethod == "CFrame" then
            chr:TranslateBy(hum.MoveDirection * CombatSettings.TargetWS * delta * 10)
        else
            if CombatSettings.EnableWalkSpeed and CombatSettings.SpeedMethod == "CFrame" then
                chr:TranslateBy(hum.MoveDirection * delta * 10)
            end
        end
        if CombatSettings.EnableWalkSpeed and CombatSettings.SpeedMethod == "WalkSpeed" then
            hum.WalkSpeed = CombatSettings.TargetWS * 3
        end
        if CombatSettings.EnableWalkSpeed and CombatSettings.SpeedMethod == "Velocity" then
            bv.Parent = chr.HumanoidRootPart
            bv.Velocity = chr.Humanoid.MoveDirection * (CombatSettings.TargetWS * 10)
        else
            bv.Parent = workspace
        end

    if CombatSettings.Noclip then
        for i,v in game.Players.LocalPlayer.Character:GetDescendants() do
            if v:IsA("BasePart") then
                v.CanCollide = false
            end
        end
    end
    if CombatSettings.FlingEnabled == true then 
    local abc = game.Players.LocalPlayer.Character.HumanoidRootPart.Velocity
    game.Players.LocalPlayer.Character.HumanoidRootPart.Velocity = Vector3.new(1,1,1) * (2^16)
    game:GetService("RunService").RenderStepped:Wait()
    game.Players.LocalPlayer.Character.HumanoidRootPart.Velocity = abc
    end 
end)

workspace.Live.DescendantAdded:Connect(function(dec)
    if dec.Name == "M1ing"  and CombatSettings.AutoBlock == true then
        local TargetCharacterPos = dec.Parent:FindFirstChild("HumanoidRootPart").Position
        local dparent = dec.Parent
        local dname = dec.Name
        local lpos = game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart").Position
        if (lpos - TargetCharacterPos).Magnitude < 17 then
            keypress(Enum.KeyCode.F)
            repeat
                task.wait()
            until dparent:FindFirstChild(dname)==nil
            keyrelease(Enum.KeyCode.F)
        end
    end
end)

 game.Players.DescendantAdded:Connect(function(dec)
    if dec:IsA("Tool") and dec.Name == "Death Counter" or dec.Name == "The Final Hunt" or dec.Name == "Death Blow" or dec.Name == "Straight On" or dec.Name == "Sunset" or dec.Name == "Terrible Tornado" or dec.Name == "Incinerate" and VisualSettings.ShowUlt  == true then
        if VisualSettings.ShowUlt == true then
            local uh = Instance.new("Highlight", dec.Parent.Parent.Character)
            uh.Name = "Hult"
            uh.FillColor = Color3.fromRGB(255,255,0)
        end
    end
end)

game.Players.DescendantRemoving:Connect(function(dec)
    if dec:IsA("Tool") and dec.Name == "Death Counter" or dec.Name == "The Final Hunt" or dec.Name == "Death Blow" or dec.Name == "Straight On" or dec.Name == "Sunset" or dec.Name == "Terrible Tornado" or dec.Name == "Incinerate" and VisualSettings.ShowUlt and dec.Parent.Parent.Character:FindFirstChild("Hult") then
        dec.Parent.Parent.Character:FindFirstChild("Hult"):Destroy()
    end
end)
