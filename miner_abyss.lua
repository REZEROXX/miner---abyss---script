if not game:IsLoaded() then
    game.Loaded:Wait()
end

getgenv().AutoFarm = true
getgenv().AutoSell = true

local Players = game:GetService("Players")
local VirtualUser = game:GetService("VirtualUser")
local Player = Players.LocalPlayer

-- Anti AFK
Player.Idled:Connect(function()
    VirtualUser:Button2Down(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
    task.wait(1)
    VirtualUser:Button2Up(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
end)

local function getChar()
    local char = Player.Character or Player.CharacterAdded:Wait()
    return char, char:WaitForChild("HumanoidRootPart")
end

-- FUNÇÃO UNIVERSAL PARA PROMPT
local function triggerPrompt(prompt)
    if fireproximityprompt then
        fireproximityprompt(prompt)
    elseif firesignal then
        firesignal(prompt.Triggered)
    end
end

-- AUTO FARM
task.spawn(function()
    while getgenv().AutoFarm do
        local , hrp = getChar()

        for , v in pairs(workspace:GetDescendants()) do
            if v:IsA("ProximityPrompt") and v.Enabled then
                pcall(function()
                    hrp.CFrame = v.Parent.CFrame * CFrame.new(0,0,2)
                    task.wait(0.15)
                    triggerPrompt(v)
                end)
            end
        end
        task.wait()
    end
end)

print("Miner Abyss | Script carregado")
