-- Storm Hub Simples - GUI Nativo Roblox com opções completas

local Players = game:GetService("Players")
local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- Função para criar texto simples
local function createText(parent, text, pos, size, color)
    local label = Instance.new("TextLabel")
    label.Parent = parent
    label.Text = text
    label.TextColor3 = color or Color3.new(1,1,1)
    label.BackgroundTransparency = 1
    label.Position = pos
    label.Size = size
    label.Font = Enum.Font.SourceSansBold
    label.TextScaled = true
    return label
end

-- Função para criar botão simples
local function createButton(parent, text, pos, size, callback)
    local button = Instance.new("TextButton")
    button.Parent = parent
    button.Text = text
    button.TextColor3 = Color3.new(1,1,1)
    button.BackgroundColor3 = Color3.fromRGB(30,30,30)
    button.Position = pos
    button.Size = size
    button.Font = Enum.Font.SourceSansBold
    button.TextScaled = true
    button.AutoButtonColor = true
    button.MouseButton1Click:Connect(callback)
    return button
end

-- Remove GUI antigo se existir
if playerGui:FindFirstChild("StormHub") then
    playerGui.StormHub:Destroy()
end

-- Criar ScreenGui
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "StormHub"
screenGui.Parent = playerGui

-- Tela Loading
local loadingFrame = Instance.new("Frame")
loadingFrame.Size = UDim2.new(0,300,0,150)
loadingFrame.Position = UDim2.new(0.5,-150,0.5,-75)
loadingFrame.BackgroundColor3 = Color3.fromRGB(25,25,25)
loadingFrame.Parent = screenGui

local loadingText = createText(loadingFrame, "Carregando... 0%", UDim2.new(0,0,0,60), UDim2.new(1,0,0,30), Color3.new(1,1,1))

-- Simular loading
coroutine.wrap(function()
    for i=0,100 do
        loadingText.Text = "Carregando... "..i.."%"
        wait(0.03)
    end
    loadingFrame.Visible = false
    showLanguageSelection()
end)()

-- Função para mostrar seleção de idioma
function showLanguageSelection()
    local langFrame = Instance.new("Frame")
    langFrame.Size = UDim2.new(0,300,0,150)
    langFrame.Position = UDim2.new(0.5,-150,0.5,-75)
    langFrame.BackgroundColor3 = Color3.fromRGB(25,25,25)
    langFrame.Parent = screenGui

    createText(langFrame, "Selecione o Idioma", UDim2.new(0,0,0,20), UDim2.new(1,0,0,30), Color3.new(1,1,1))

    createButton(langFrame, "Português 🇧🇷", UDim2.new(0.1,0,0.5,0), UDim2.new(0.35,0,0,40), function()
        langFrame:Destroy()
        openMainMenu("pt")
    end)

    createButton(langFrame, "English 🇺🇸", UDim2.new(0.55,0,0.5,0), UDim2.new(0.35,0,0,40), function()
        langFrame:Destroy()
        openMainMenu("en")
    end)
end

-- Função para abrir menu principal
function openMainMenu(lang)
    local texts = {
        pt = {
            movement = "Movimento",
            teleport = "Teleporte",
            troll = "Troll",
            spam = "Spam Texto",
            teleport1 = "Teleportar Local 1",
            teleport2 = "Teleportar Local 2",
            close = "Fechar",
            hubname = "Storm Hub"
        },
        en = {
            movement = "Movement",
            teleport = "Teleport",
            troll = "Troll",
            spam = "Text Spam",
            teleport1 = "Teleport Location 1",
            teleport2 = "Teleport Location 2",
            close = "Close",
            hubname = "Storm Hub"
        }
    }

    local menuFrame = Instance.new("Frame")
    menuFrame.Size = UDim2.new(0,350,0,300)
    menuFrame.Position = UDim2.new(0.5,-175,0.5,-150)
    menuFrame.BackgroundColor3 = Color3.fromRGB(30,30,30)
    menuFrame.Parent = screenGui

    -- Título
    createText(menuFrame, texts[lang].hubname, UDim2.new(0,0,0,10), UDim2.new(1,0,0,40), Color3.new(1,1,0))

    -- Botão Movimento (Exemplo simples: só printa)
    createButton(menuFrame, texts[lang].movement, UDim2.new(0.1,0,0.2,0), UDim2.new(0.8,0,0,40), function()
        print("Clicou em Movimento")
        -- Você pode adicionar aqui scripts de movimento depois
    end)

    -- Botão Teleporte
    createButton(menuFrame, texts[lang].teleport, UDim2.new(0.1,0,0.4,0), UDim2.new(0.8,0,0,40), function()
        -- Criar submenu simples de teleporte
        local teleportFrame = Instance.new("Frame")
        teleportFrame.Size = UDim2.new(0,300,0,150)
        teleportFrame.Position = UDim2.new(0.5,-150,0.5,-75)
        teleportFrame.BackgroundColor3 = Color3.fromRGB(40,40,40)
        teleportFrame.Parent = screenGui

        createText(teleportFrame, texts[lang].teleport, UDim2.new(0,0,0,10), UDim2.new(1,0,0,30), Color3.new(1,1,1))

        createButton(teleportFrame, texts[lang].teleport1, UDim2.new(0.1,0,0.4,0), UDim2.new(0.8,0,0,40), function()
            if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                player.Character.HumanoidRootPart.CFrame = CFrame.new(100,10,100)
            end
        end)

        createButton(teleportFrame, texts[lang].teleport2, UDim2.new(0.1,0,0.7,0), UDim2.new(0.8,0,0,40), function()
            if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                player.Character.HumanoidRootPart.CFrame = CFrame.new(-100,10,-100)
            end
        end)

        -- Botão fechar submenu
        createButton(teleportFrame, texts[lang].close, UDim2.new(0.7,0,0.85,0), UDim2.new(0.25,0,0,30), function()
            teleportFrame:Destroy()
        end)
    end)

    -- Botão Troll - Spam texto
    createButton(menuFrame, texts[lang].troll, UDim2.new(0.1,0,0.6,0), UDim2.new(0.8,0,0,40), function()
        spawn(function()
            while wait(0.5) do
                game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer("Storm Hub é o melhor! ⚡", "All")
            end
        end)
    end)

    -- Botão fechar menu
    createButton(menuFrame, texts[lang].close, UDim2.new(0.7,0,0.85,0), UDim2.new(0.25,0,0,30), function()
        screenGui:Destroy()
    end)
end
