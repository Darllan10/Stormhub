-- Storm Hub - Versão Completa com Animação, Categorias, e Funções Troll -- Feito para Delta Executor e KRNL

-- Carregar Rayfield UI local Rayfield = loadstring(game:HttpGet('https://raw.githubusercontent.com/shlexware/Rayfield/main/source'))()

-- Função de Loading Progressivo com Animação de Fundo local LoadingProgress = 0 local LoadingScreen = Rayfield:CreateWindow({ Name = 'Storm Hub - Loading', LoadingTitle = 'Storm Hub', LoadingSubtitle = 'Carregando... 0%', ConfigurationSaving = { Enabled = false } })

-- Simular carregamento até 100% com Animação de Fundo for i = 1, 100 do wait(0.05) LoadingProgress = i LoadingScreen:SetLoadingSubtitle('Carregando... ' .. tostring(i) .. '% ⚡') end

-- Tela de escolha de idioma local selectedLanguage = nil

local LanguageWindow = Rayfield:CreateWindow({ Name = 'Storm Hub - Escolha de Idioma', LoadingTitle = 'Selecione o Idioma', LoadingSubtitle = 'Selecione seu idioma preferido', ConfigurationSaving = { Enabled = false } })

LanguageWindow:CreateButton({ Name = 'Português 🇧🇷', Callback = function() selectedLanguage = 'pt' Rayfield:Notify({Title = 'Idioma', Content = 'Idioma definido para Português.', Duration = 4}) StartHub(selectedLanguage) end })

LanguageWindow:CreateButton({ Name = 'English 🇺🇸', Callback = function() selectedLanguage = 'en' Rayfield:Notify({Title = 'Language', Content = 'Language set to English.', Duration = 4}) StartHub(selectedLanguage) end })

-- Função para iniciar o Hub com idioma e categorias function StartHub(language) local texts = { pt = { hubName = 'Storm Hub', movement = 'Movimento', teleport = 'Teleporte', troll = 'Troll', speed = 'Velocidade', fly = 'Voar', spam = 'Spam Texto' }, en = { hubName = 'Storm Hub', movement = 'Movement', teleport = 'Teleport', troll = 'Troll', speed = 'Speed', fly = 'Fly', spam = 'Text Spam' } }

-- Categoria: Movimento
local MovementTab = Rayfield:CreateWindow({
Name = '⚡ ' .. texts[language].movement .. ' ⚡',
LoadingTitle = texts[language].movement,
LoadingSubtitle = '',
ConfigurationSaving = {
Enabled = true,
FolderName = 'StormHubData',
FileName = 'StormHubConfig'
}
})

MovementTab:CreateButton({
Name = texts[language].speed,
Callback = function()
loadstring(game:HttpGet('https://raw.githubusercontent.com/SEUUSUARIO/script-velocidade/main.lua'))()
end
})

MovementTab:CreateButton({
Name = texts[language].fly,
Callback = function()
loadstring(game:HttpGet('https://raw.githubusercontent.com/SEUUSUARIO/script-fly/main.lua'))()
end
})

-- Categoria: Teleporte
local TeleportTab = Rayfield:CreateWindow({
Name = '🌀 ' .. texts[language].teleport .. ' 🌀',
LoadingTitle = texts[language].teleport,
LoadingSubtitle = '',
ConfigurationSaving = {
Enabled = true,
FolderName = 'StormHubData',
FileName = 'StormHubConfig'
}
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

-- Categoria: Troll
local TrollTab = Rayfield:CreateWindow({
Name = '😈 ' .. texts[language].troll .. ' 😈',
LoadingTitle = texts[language].troll,
LoadingSubtitle = '',
ConfigurationSaving = {
Enabled = true,
FolderName = 'StormHubData',
FileName = 'StormHubConfig'
}
})

TrollTab:CreateButton({
Name = texts[language].spam,
Callback = function()
while true do
wait(0.5)
game:GetService('ReplicatedStorage').DefaultChatSystemChatEvents.SayMessageRequest:FireServer('Storm Hub é o melhor! ⚡', 'All')
end
end
})

end

