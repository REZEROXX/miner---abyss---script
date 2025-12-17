-- Miner Abyss | Auto Farm Simples
-- Feito do zero para Xeno

if not game:IsLoaded() then
    game.Loaded:Wait()
end

-- ================= CONFIG =================
getgenv().AutoFarm = true
getgenv().AutoSell = true
getgenv().FarmDelay = 0.15
getgenv().SellDelay = 5
-- ==========================================

local Players = game:GetService("Players")
local VirtualUser = game:GetService("VirtualUser")
local Player = Players.LocalPlayer

-- ================= ANTI AFK =================
Player.Idled:Connect(function()
    VirtualUser:Button2Down(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
    task.wait(1)
    VirtualUser:Button2Up(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
end)

-- ================= CHARACTER =================
local function GetChar()
    local char = Player.Character or Player.CharacterAdded:Wait()
    return char, char:WaitForChild("HumanoidRootPart")
end

-- ================= AUTO FARM =================
task.spawn(function()
    while getgenv().AutoFarm do
        local char, hrp = GetChar()

        for , obj in pairs(workspace:GetDescendants()) do
            if not getgenv().AutoFarm then break end

            if obj:IsA("ProximityPrompt") 
            and obj.Enabled
            and obj.ActionText
            and string.find(obj.ActionText:lower(), "mine") then

                pcall(function()
                    hrp.CFrame = obj.Parent.CFrame * CFrame.new(0, 0, 2)
                    task.wait(0.1)
                    fireproximityprompt(obj)
                    task.wait(getgenv().FarmDelay)
                end)
            end
        end

        task.wait()
    end
end)

-- ================= AUTO SELL =================
task.spawn(function()
    while getgenv().AutoSell do
        local char, hrp = GetChar()

        for , obj in pairs(workspace:GetDescendants()) do
            if obj:IsA("ProximityPrompt")
            and obj.Enabled
            and obj.ActionText
            and string.find(obj.ActionText:lower(), "sell") then

                pcall(function()
                    hrp.CFrame = obj.Parent.CFrame * CFrame.new(0,0,2)
                    task.wait(0.2)
                    fireproximityprompt(obj)
                end)
            end
        end

        task.wait(getgenv().SellDelay)
    end
end)

print("⛏️ Miner Abyss | Auto Farm ATIVADO")
