-- Carregar Rayfield UI
getgenv().SecureMode = true  -- ativa modo mais seguro (redução de detecção)
local Rayfield = loadstring(game:HttpGet("https://raw.githubusercontent.com/shlexware/Rayfield/main/source"))()

-- Função principal
local function StartHub(language)
    local texts = {
        pt = {
            hubName = "Storm Hub - Chaos Style",
            movement = "Movimento",
            teleport = "Teleporte",
            troll = "Troll",
            speed = "Velocidade x2",
            teleport1 = "Local 1",
            teleport2 = "Local 2",
            spam = "Spam no chat"
        },
        en = {
            hubName = "Storm Hub - Chaos Style",
            movement = "Movement",
            teleport = "Teleport",
            troll = "Troll",
            speed = "Speed x2",
            teleport1 = "Location 1",
            teleport2 = "Location 2",
            spam = "Chat Spam"
        }
    }

    local window = Rayfield:CreateWindow({
        Name = texts[language].hubName,
        LoadingTitle = texts[language].hubName,
        ConfigurationSaving = {
            Enabled = true,
            FolderName = "StormHubChaos",
            FileName = "Config"
        },
        Discord = { Enabled = false },
        KeySystem = false
    })

    -- Abas (estilo Chaos Hub)
    local movementTab = window:CreateTab("🏃 " .. texts[language].movement, 12252969349)
    local teleportTab = window:CreateTab("📍 " .. texts[language].teleport, 12252969349)
    local trollTab = window:CreateTab("😈 " .. texts[language].troll, 12252969349)

    movementTab:CreateButton({
        Name = texts[language].speed,
        Callback = function()
            local plr = game.Players.LocalPlayer
            if plr.Character and plr.Character:FindFirstChild("Humanoid") then
                plr.Character.Humanoid.WalkSpeed = 32
                Rayfield:Notify({Title = texts[language].movement, Content = "Velocidade x2!", Duration = 3})
            end
        end
    })

    teleportTab:CreateButton({
        Name = texts[language].teleport1,
        Callback = function()
            local p = game.Players.LocalPlayer
            if p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
                p.Character.HumanoidRootPart.CFrame = CFrame.new(100,10,100)
            end
        end
    })

    teleportTab:CreateButton({
        Name = texts[language].teleport2,
        Callback = function()
            local p = game.Players.LocalPlayer
            if p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
                p.Character.HumanoidRootPart.CFrame = CFrame.new(-100,10,-100)
            end
        end
    })

    trollTab:CreateButton({
        Name = texts[language].spam,
        Callback = function()
            Rayfield:Notify({Title = "Troll", Content = "Spam iniciado! Para parar, reinicie.", Duration = 4})
            spawn(function()
                while true do
                    wait(0.5)
                    game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer("Chaos Style Spam!", "All")
                end
            end)
        end
    })
end

-- Início: loading + seleção do idioma
local Load = Rayfield:CreateWindow({
    Name = "Loading",
    LoadingTitle = "Storm Hub",
    LoadingSubtitle = "0%",
    ConfigurationSaving = { Enabled = false }
})

for i = 1, 100 do
    wait(0.02)
    Load:SetLoadingSubtitle(tostring(i).."%")
end
Load:Destroy()

local Lang = Rayfield:CreateWindow({
    Name = "Seleção de Idioma",
    LoadingTitle = "Escolha o Idioma",
    ConfigurationSaving = { Enabled = false }
})

Lang:CreateButton({
    Name = "Português 🇧🇷",
    Callback = function()
        Lang:Destroy()
        StartHub("pt")
    end
})
Lang:CreateButton({
    Name = "English 🇺🇸",
    Callback = function()
        Lang:Destroy()
        StartHub("en")
    end
})
