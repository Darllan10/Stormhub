-- Storm Hub - Versão Completa com Animação, Categorias, e Funções Troll
-- Feito para Delta Executor e KRNL

local success, Rayfield = pcall(function()
    return loadstring(game:HttpGet('https://raw.githubusercontent.com/shlexware/Rayfield/main/source'))()
end)

if not success or type(Rayfield) ~= "table" then
    warn("Erro ao carregar Rayfield UI. Verifique a conexão ou seu executor.")
    return
end

local LoadingScreen = Rayfield:CreateWindow({
    Name = 'Storm Hub - Loading',
    LoadingTitle = 'Storm Hub',
    LoadingSubtitle = 'Carregando... 0%',
    ConfigurationSaving = { Enabled = false }
})

for i = 1, 100 do
    wait(0.05)
    LoadingScreen:SetLoadingSubtitle('Carregando... ' .. tostring(i) .. '% ⚡')
end

local selectedLanguage = nil

local LanguageWindow = Rayfield:CreateWindow({
    Name = 'Storm Hub - Escolha de Idioma',
    LoadingTitle = 'Selecione o Idioma',
    LoadingSubtitle = 'Selecione seu idioma preferido',
    ConfigurationSaving = { Enabled = false }
})

LanguageWindow:CreateButton({
    Name = 'Português 🇧🇷',
    Callback = function()
        selectedLanguage = 'pt'
        Rayfield:Notify({
            Title = 'Idioma',
            Content = 'Idioma definido para Português.',
            Duration = 4
        })
        LanguageWindow:Destroy()
        StartHub(selectedLanguage)
    end
})

LanguageWindow:CreateButton({
    Name = 'English 🇺🇸',
    Callback = function()
        selectedLanguage = 'en'
        Rayfield:Notify({
            Title = 'Language',
            Content = 'Language set to English.',
            Duration = 4
        })
        LanguageWindow:Destroy()
        StartHub(selectedLanguage)
    end
})

function StartHub(language)
    local texts = {
        pt = {
            hubName = 'Storm Hub',
            teleport = 'Teleporte',
            troll = 'Troll',
            spam = 'Spam Texto'
        },
        en = {
            hubName = 'Storm Hub',
            teleport = 'Teleport',
            troll = 'Troll',
            spam = 'Text Spam'
        }
    }

    local MainWindow = Rayfield:CreateWindow({
        Name = texts[language].hubName,
        LoadingTitle = texts[language].hubName,
        LoadingSubtitle = '',
        ConfigurationSaving = {
            Enabled = true,
            FolderName = 'StormHubData',
            FileName = 'StormHubConfig'
        }
    })

    local TeleportTab = MainWindow:CreateTab({
        Name = texts[language].teleport,
        Icon = "🌀"
    })

    TeleportTab:CreateButton({
        Name = texts[language].teleport .. ' Local 1',
        Callback = function()
            game.Players.LocalPlayer.Character:MoveTo(Vector3.new(100, 10, 100))
        end
    })

    TeleportTab:CreateButton({
        Name = texts[language].teleport .. ' Local 2',
        Callback = function()
            game.Players.LocalPlayer.Character:MoveTo(Vector3.new(-100, 10, -100))
        end
    })

    local TrollTab = MainWindow:CreateTab({
        Name = texts[language].troll,
        Icon = "😈"
    })

    TrollTab:CreateButton({
        Name = texts[language].spam,
        Callback = function()
            spawn(function()
                while true do
                    wait(0.5)
                    game:GetService('ReplicatedStorage').DefaultChatSystemChatEvents.SayMessageRequest:FireServer('Storm Hub é o melhor! ⚡', 'All')
                end
            end)
        end
    })
end
