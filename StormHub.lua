-- Carregar Rayfield UI
local Rayfield = loadstring(game:HttpGet("https://raw.githubusercontent.com/shlexware/Rayfield/main/source"))()

-- Tela de Loading com barra e porcentagem
local LoadingScreen = Rayfield:CreateWindow({
    Name = "Storm Hub - Loading",
    LoadingTitle = "Storm Hub ⚡",
    LoadingSubtitle = "0%",
    ConfigurationSaving = { Enabled = false }
})

for i = 1, 100 do
    wait(0.03)
    LoadingScreen:SetLoadingSubtitle(tostring(i) .. "%")
end

LoadingScreen:Destroy()

-- Tela de escolha de idioma
local selectedLanguage = nil

local LanguageWindow = Rayfield:CreateWindow({
    Name = "🌐 Escolha o idioma / Choose your language",
    LoadingTitle = "Selecione o idioma",
    LoadingSubtitle = "",
    ConfigurationSaving = { Enabled = false }
})

LanguageWindow:CreateButton({
    Name = "🇧🇷 Português",
    Callback = function()
        selectedLanguage = "pt"
        Rayfield:Notify({ Title = "Idioma", Content = "Idioma definido para Português.", Duration = 3 })
        LanguageWindow:Destroy()
        StartHub(selectedLanguage)
    end
})

LanguageWindow:CreateButton({
    Name = "🇺🇸 English",
    Callback = function()
        selectedLanguage = "en"
        Rayfield:Notify({ Title = "Language", Content = "Language set to English.", Duration = 3 })
        LanguageWindow:Destroy()
        StartHub(selectedLanguage)
    end
})

-- Função para iniciar o Hub
function StartHub(language)
    local texts = {
        pt = {
            hubName = "Storm Hub - Chaos Style",
            movement = "Movimento",
            teleport = "Teleporte",
            troll = "Troll",
            speed = "Velocidade x2",
            teleport1 = "Ir para Local 1",
            teleport2 = "Ir para Local 2",
            spam = "Spam no chat"
        },
        en = {
            hubName = "Storm Hub - Chaos Style",
            movement = "Movement",
            teleport = "Teleport",
            troll = "Troll",
            speed = "Speed x2",
            teleport1 = "Go to Location 1",
            teleport2 = "Go to Location 2",
            spam = "Chat Spam"
        }
    }

    local window = Rayfield:CreateWindow({
        Name = texts[language].hubName,
        LoadingTitle = "Bem-vindo! / Welcome!",
        LoadingSubtitle = "",
        ConfigurationSaving = { Enabled = true, FolderName = "StormHubChaos", FileName = "Config" }
    })

    local movementTab = window:CreateTab("🏃 " .. texts[language].movement, 4483362458)
    local teleportTab = window:CreateTab("📍 " .. texts[language].teleport, 4483362458)
    local trollTab = window:CreateTab("😈 " .. texts[language].troll, 4483362458)

    -- Movimento
    movementTab:CreateButton({
        Name = texts[language].speed,
        Callback = function()
            local player = game.Players.LocalPlayer
            if player and player.Character and player.Character:FindFirstChild("Humanoid") then
                player.Character.Humanoid.WalkSpeed = 32
                Rayfield:Notify({ Title = "Storm Hub", Content = "Velocidade aumentada!", Duration = 3 })
            end
        end
    })

    -- Teleporte
    teleportTab:CreateButton({
        Name = texts[language].teleport1,
        Callback = function()
            local player = game.Players.LocalPlayer
            if player and player.Character then
                player.Character:MoveTo(Vector3.new(100, 10, 100))
                Rayfield:Notify({ Title = "Storm Hub", Content = "Teleportado para Local 1!", Duration = 3 })
            end
        end
    })

    teleportTab:CreateButton({
        Name = texts[language].teleport2,
        Callback = function()
            local player = game.Players.LocalPlayer
            if player and player.Character then
                player.Character:MoveTo(Vector3.new(-100, 10, -100))
                Rayfield:Notify({ Title = "Storm Hub", Content = "Teleportado para Local 2!", Duration = 3 })
            end
        end
    })

    -- Troll (Spam no chat)
    trollTab:CreateButton({
        Name = texts[language].spam,
        Callback = function()
            Rayfield:Notify({ Title = "Storm Hub", Content = "Spam iniciado! Para parar, reinicie o script.", Duration = 5 })
            spawn(function()
                while true do
                    wait(0.5)
                    game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer("Storm Hub Chaos Style é o melhor! ⚡", "All")
                end
            end)
        end
    })
end
