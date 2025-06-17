-- Criar ScreenGui
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "ChaosStyleHub"
screenGui.Parent = game.CoreGui

-- Criar Frame principal (janela)
local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 350, 0, 400)
frame.Position = UDim2.new(0.5, -175, 0.5, -200)
frame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
frame.BorderSizePixel = 0
frame.Visible = true
frame.Parent = screenGui

-- Criar título
local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 40)
title.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
title.BorderSizePixel = 0
title.Text = "Chaos Hub Style"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.Font = Enum.Font.SourceSansBold
title.TextSize = 24
title.Parent = frame

-- Criar botão fechar
local closeButton = Instance.new("TextButton")
closeButton.Size = UDim2.new(0, 30, 0, 30)
closeButton.Position = UDim2.new(1, -35, 0, 5)
closeButton.BackgroundColor3 = Color3.fromRGB(170, 30, 30)
closeButton.Text = "X"
closeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
closeButton.Font = Enum.Font.SourceSansBold
closeButton.TextSize = 20
closeButton.Parent = frame

-- Função para fechar a janela
closeButton.MouseButton1Click:Connect(function()
    frame.Visible = false
    openButton.Visible = true
end)

-- Criar botão abrir (para quando a janela estiver fechada)
local openButton = Instance.new("TextButton")
openButton.Size = UDim2.new(0, 100, 0, 40)
openButton.Position = UDim2.new(0, 10, 0.5, -20)
openButton.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
openButton.Text = "Abrir Hub"
openButton.TextColor3 = Color3.fromRGB(255, 255, 255)
openButton.Font = Enum.Font.SourceSansBold
openButton.TextSize = 20
openButton.Visible = false
openButton.Parent = screenGui

openButton.MouseButton1Click:Connect(function()
    frame.Visible = true
    openButton.Visible = false
end)

-- Função para criar botões dentro da interface
local function createButton(parent, text, yPos, callback)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0, 320, 0, 40)
    btn.Position = UDim2.new(0, 15, 0, yPos)
    btn.BackgroundColor3 = Color3.fromRGB(55, 55, 55)
    btn.BorderSizePixel = 0
    btn.Text = text
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.Font = Enum.Font.SourceSans
    btn.TextSize = 20
    btn.Parent = parent

    btn.MouseButton1Click:Connect(callback)
end

-- Exemplo de botões dentro do hub
createButton(frame, "Aumentar Velocidade", 60, function()
    local player = game.Players.LocalPlayer
    if player and player.Character and player.Character:FindFirstChild("Humanoid") then
        player.Character.Humanoid.WalkSpeed = 50
    end
end)

createButton(frame, "Teleporte para Ponto 1", 110, function()
    local player = game.Players.LocalPlayer
    if player and player.Character then
        player.Character:MoveTo(Vector3.new(100, 10, 100))
    end
end)

createButton(frame, "Spam no Chat", 160, function()
    spawn(function()
        while true do
            wait(0.5)
            game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer("Chaos Hub style ativado!", "All")
        end
    end)
end)
