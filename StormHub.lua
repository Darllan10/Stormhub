-- Chaos Hub estilo para Brookhaven | Roblox Lua Script
-- Adaptado para Brookhaven

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer
local Mouse = LocalPlayer:GetMouse()

local Workspace = game:GetService("Workspace")

-- Criar GUI principal
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "ChaosHubBrookhaven"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")

-- Função para criar botão simples
local function CreateButton(text, pos, parent)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0,150,0,40)
    btn.Position = pos
    btn.BackgroundColor3 = Color3.fromRGB(30,30,30)
    btn.TextColor3 = Color3.new(1,1,1)
    btn.Font = Enum.Font.SourceSansBold
    btn.TextSize = 18
    btn.Text = text
    btn.Parent = parent
    btn.AutoButtonColor = true
    btn.BorderSizePixel = 0
    btn.BackgroundTransparency = 0.3
    return btn
end

-- Botão toggle flutuante
local toggleBtn = CreateButton("Chaos Hub", UDim2.new(0,10,0.5,-20), ScreenGui)
toggleBtn.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
toggleBtn.ZIndex = 10

-- Menu frame principal
local menuFrame = Instance.new("Frame")
menuFrame.Size = UDim2.new(0,400,0,500)
menuFrame.Position = UDim2.new(0,170,0.5,-250)
menuFrame.BackgroundColor3 = Color3.fromRGB(20,20,20)
menuFrame.BorderSizePixel = 0
menuFrame.Visible = false
menuFrame.Parent = ScreenGui
menuFrame.ClipsDescendants = true
menuFrame.ZIndex = 9

-- Barra de título
local titleBar = Instance.new("TextLabel")
titleBar.Size = UDim2.new(1,0,0,40)
titleBar.BackgroundColor3 = Color3.fromRGB(30,30,30)
titleBar.BorderSizePixel = 0
titleBar.Text = "Chaos Hub - Brookhaven"
titleBar.Font = Enum.Font.SourceSansBold
titleBar.TextSize = 24
titleBar.TextColor3 = Color3.fromRGB(255, 255, 255)
titleBar.Parent = menuFrame

-- Container abas (lado esquerdo)
local tabsFrame = Instance.new("Frame")
tabsFrame.Size = UDim2.new(0,120,1,-40)
tabsFrame.Position = UDim2.new(0,0,0,40)
tabsFrame.BackgroundColor3 = Color3.fromRGB(25,25,25)
tabsFrame.BorderSizePixel = 0
tabsFrame.Parent = menuFrame

-- Container conteúdo (lado direito)
local contentFrame = Instance.new("Frame")
contentFrame.Size = UDim2.new(1,-120,1,-40)
contentFrame.Position = UDim2.new(0,120,0,40)
contentFrame.BackgroundColor3 = Color3.fromRGB(15,15,15)
contentFrame.BorderSizePixel = 0
contentFrame.Parent = menuFrame

local contentLayout = Instance.new("UIListLayout")
contentLayout.Padding = UDim.new(0,10)
contentLayout.SortOrder = Enum.SortOrder.LayoutOrder
contentLayout.Parent = contentFrame

local function ClearContent()
    for _,v in pairs(contentFrame:GetChildren()) do
        if not v:IsA("UIListLayout") then
            v:Destroy()
        end
    end
end

-- Criar abas
local tabs = {}
local function CreateTab(name)
    local tabBtn = Instance.new("TextButton")
    tabBtn.Size = UDim2.new(1,0,0,40)
    tabBtn.BackgroundColor3 = Color3.fromRGB(35,35,35)
    tabBtn.BorderSizePixel = 0
    tabBtn.Font = Enum.Font.SourceSansBold
    tabBtn.TextSize = 18
    tabBtn.TextColor3 = Color3.fromRGB(220,220,220)
    tabBtn.Text = name
    tabBtn.Parent = tabsFrame
    return tabBtn
end

tabs["Teleport"] = CreateTab("Teleport")
tabs["Vehicles"] = CreateTab("Vehicles")
tabs["Movement"] = CreateTab("Movement")
tabs["ESP"] = CreateTab("ESP")
tabs["Trolls"] = CreateTab("Trolls")
tabs["Settings"] = CreateTab("Settings")

local activeTab = nil

-- Funções das abas

local function SelectTab(name)
    activeTab = name
    ClearContent()

    if name == "Teleport" then
        local tpLabel = Instance.new("TextLabel")
        tpLabel.Text = "Locais Brookhaven:"
        tpLabel.Size = UDim2.new(1,0,0,30)
        tpLabel.BackgroundTransparency = 1
        tpLabel.TextColor3 = Color3.new(1,1,1)
        tpLabel.Font = Enum.Font.SourceSansBold
        tpLabel.TextSize = 18
        tpLabel.Parent = contentFrame

        local function createTPButton(text, cframe)
            local btn = CreateButton(text, UDim2.new(0,0,0,0), contentFrame)
            btn.Size = UDim2.new(1,0,0,35)
            btn.BackgroundColor3 = Color3.fromRGB(70,130,180)
            btn.TextColor3 = Color3.new(1,1,1)
            btn.Parent = contentFrame
            btn.MouseButton1Click:Connect(function()
                if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                    LocalPlayer.Character.HumanoidRootPart.CFrame = cframe
                end
            end)
            return btn
        end

        -- Posições aproximadas dos locais famosos (ajuste conforme o mapa)
        createTPButton("Casa", CFrame.new(6, 4, 11))
        createTPButton("Escola", CFrame.new(128, 4, 114))
        createTPButton("Hospital", CFrame.new(40, 4, 120))
        createTPButton("Shopping", CFrame.new(-100, 4, 70))
        createTPButton("Praia", CFrame.new(-190, 4, -70))
        createTPButton("Banco", CFrame.new(70, 4, -30))

    elseif name == "Vehicles" then
        local vehLabel = Instance.new("TextLabel")
        vehLabel.Text = "Spawn/Remove Vehicles"
        vehLabel.Size = UDim2.new(1,0,0,30)
        vehLabel.BackgroundTransparency = 1
        vehLabel.TextColor3 = Color3.new(1,1,1)
        vehLabel.Font = Enum.Font.SourceSansBold
        vehLabel.TextSize = 18
        vehLabel.Parent = contentFrame

        -- Função para spawnar veículo (se disponível)
        local spawnCarBtn = CreateButton("Spawn Car", UDim2.new(0,0,0,0), contentFrame)
        spawnCarBtn.Size = UDim2.new(1,0,0,35)
        spawnCarBtn.BackgroundColor3 = Color3.fromRGB(70,130,180)
        spawnCarBtn.TextColor3 = Color3.new(1,1,1)
        spawnCarBtn.Parent = contentFrame

        spawnCarBtn.MouseButton1Click:Connect(function()
            -- Tentativa de spawnar carro (exemplo)
            -- Em Brookhaven geralmente o carro é adquirido via interface do jogo,
            -- scripts comuns não conseguem spawnar diretamente, mas podemos tentar clonar algum veículo próximo

            local carModel = nil
            -- Procurar algum veículo na workspace que possamos clonar
            for _,obj in pairs(Workspace:GetChildren()) do
                if obj:IsA("Model") and obj.Name:lower():find("car") then
                    carModel = obj
                    break
                end
            end

            if carModel then
                local newCar = carModel:Clone()
                newCar.Parent = Workspace
                if newCar:FindFirstChild("PrimaryPart") then
                    newCar:SetPrimaryPartCFrame(LocalPlayer.Character.HumanoidRootPart.CFrame * CFrame.new(0,0,5))
                elseif newCar:FindFirstChild("HumanoidRootPart") then
                    newCar.HumanoidRootPart.CFrame = LocalPlayer.Character.HumanoidRootPart.CFrame * CFrame.new(0,0,5)
                end
            else
                print("Nenhum veículo encontrado para clonar")
            end
        end)

        -- Remover veículos próximos
        local removeCarsBtn = CreateButton("Remove Nearby Cars", UDim2.new(0,0,0,0), contentFrame)
        removeCarsBtn.Size = UDim2.new(1,0,0,35)
        removeCarsBtn.BackgroundColor3 = Color3.fromRGB(180,30,30)
        removeCarsBtn.TextColor3 = Color3.new(1,1,1)
        removeCarsBtn.Parent = contentFrame

        removeCarsBtn.MouseButton1Click:Connect(function()
            for _,obj in pairs(Workspace:GetChildren()) do
                if obj:IsA("Model") and obj.Name:lower():find("car") then
                    if obj.PrimaryPart then
                        local dist = (obj.PrimaryPart.Position - LocalPlayer.Character.HumanoidRootPart.Position).Magnitude
                        if dist < 50 then
                            obj:Destroy()
                        end
                    end
                end
            end
        end)

    elseif name == "Movement" then
        -- Noclip toggle
        local noclipToggleBtn = CreateButton("Toggle Noclip", UDim2.new(0,0,0,0), contentFrame)
        noclipToggleBtn.Size = UDim2.new(1,0,0,35)
        noclipToggleBtn.BackgroundColor3 = Color3.fromRGB(70,130,180)
        noclipToggleBtn.TextColor3 = Color3.new(1,1,1)
        noclipToggleBtn.Parent = contentFrame

        local noclipEnabled = false
        local noclipConn

        noclipToggleBtn.MouseButton1Click:Connect(function()
            noclipEnabled = not noclipEnabled
            noclipToggleBtn.Text = noclipEnabled and "Noclip: ON" or "Noclip: OFF"

            if noclipEnabled then
                noclipConn = RunService.Stepped:Connect(function()
                    if LocalPlayer.Character then
                        for _, part in pairs(LocalPlayer.Character:GetChildren()) do
                            if part:IsA("BasePart") then
                                part.CanCollide = false
                            end
                        end
                    end
                end)
            else
                if noclipConn then noclipConn:Disconnect() end
                if LocalPlayer.Character then
                    for _, part in pairs(LocalPlayer.Character:GetChildren()) do
                        if part:IsA("BasePart") then
                            part.CanCollide = true
                        end
                    end
                end
            end
        end)

        -- Fly toggle simples
        local flyToggleBtn = CreateButton("Toggle Fly", UDim2.new(0,0,0,0), contentFrame)
        flyToggleBtn.Size = UDim2.new(1,0,0,35)
        flyToggleBtn.BackgroundColor3 = Color3.fromRGB(70,130,180)
        flyToggleBtn.TextColor3 = Color3.new(1,1,1)
        flyToggleBtn.Parent = contentFrame

        local flying = false
        local bodyGyro, bodyVelocity

        flyToggleBtn.MouseButton1Click:Connect(function()
            flying = not flying
            flyToggleBtn.Text = flying and "Fly: ON" or "Fly: OFF"

            local character = LocalPlayer.Character
            if not character then return end
            local hrp = character:FindFirstChild("HumanoidRootPart")
            local humanoid = character:FindFirstChildOfClass("Humanoid")
            if not hrp or not humanoid then return end

            if flying then
                bodyGyro = Instance.new("BodyGyro", hrp)
                bodyGyro.P = 9e4
                bodyGyro.MaxTorque = Vector3.new(9e9, 9e9, 9e9)
                bodyGyro.CFrame = hrp.CFrame

                bodyVelocity = Instance.new("BodyVelocity", hrp)
                bodyVelocity.Velocity = Vector3.new(0,0,0)
                bodyVelocity.MaxForce = Vector3.new(9e9, 9e9, 9e9)

                -- Controlar voo
                local function flyLoop()
                    local speed = 50
                    local moveDir = Vector3.new(0,0,0)
                    if UserInputService:IsKeyDown(Enum.KeyCode.W) then
                        moveDir = moveDir + workspace.CurrentCamera.CFrame.LookVector
                    end
                    if UserInputService:IsKeyDown(Enum.KeyCode.S) then
                        moveDir = moveDir - workspace.CurrentCamera.CFrame.LookVector
                    end
                    if UserInputService:IsKeyDown(Enum.KeyCode.A) then
                        moveDir = moveDir - workspace.CurrentCamera.CFrame.RightVector
                    end
                    if UserInputService:IsKeyDown(Enum.KeyCode.D) then
                        moveDir = moveDir + workspace.CurrentCamera.CFrame.RightVector
                    end
                    if UserInputService:IsKeyDown(Enum.KeyCode.Space) then
                        moveDir = moveDir + Vector3.new(0,1,0)
                    end
                    if UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) then
                        moveDir = moveDir - Vector3.new(0,1,0)
                    end
                    bodyVelocity.Velocity = moveDir.Unit * speed
                    bodyGyro.CFrame = workspace.CurrentCamera.CFrame
                end

                flyLoop = RunService.Heartbeat:Connect(flyLoop)

                -- Guardar para desconectar depois
                flyToggleBtn._flyLoop = flyLoop

            else
                if bodyGyro then bodyGyro:Destroy() end
                if bodyVelocity then bodyVelocity:Destroy() end
                if flyToggleBtn._flyLoop then flyToggleBtn._flyLoop:Disconnect() end
            end
        end)

    elseif name == "ESP" then
        local espToggle = CreateButton("Toggle ESP", UDim2.new(0,0,0,0), contentFrame)
        espToggle.Size = UDim2.new(1,0,0,35)
        espToggle.BackgroundColor3 = Color3.fromRGB(70,130,180)
        espToggle.TextColor3 = Color3.new(1,1,1)
        espToggle.Parent = contentFrame

        local espEnabled = false
        local espBoxes = {}

        local function createBox(plr)
            if plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
                local box = Instance.new("BoxHandleAdornment")
                box.Adornee = plr.Character.HumanoidRootPart
                box.AlwaysOnTop = true
                box.ZIndex = 10
                box.Size = Vector3.new(2,5,1)
                box.Color3 = Color3.new(1,0,0)
                box.Parent = ScreenGui
                return box
            end
        end

        espToggle.MouseButton1Click:Connect(function()
            espEnabled = not espEnabled
            espToggle.Text = espEnabled and "ESP: ON" or "ESP: OFF"
            if espEnabled then
                for _,plr in pairs(Players:GetPlayers()) do
                    if plr ~= LocalPlayer then
                        local box = createBox(plr)
                        if box then
                            espBoxes[plr] = box
                        end
                    end
                end
                RunService.Heartbeat:Connect(function()
                    if not espEnabled then return end
                    for plr,box in pairs(espBoxes) do
                        if not plr.Character or not plr.Character:FindFirstChild("HumanoidRootPart") then
                            box:Destroy()
                            espBoxes[plr] = nil
                        else
                            box.Adornee = plr.Character.HumanoidRootPart
                        end
                    end
                end)
            else
                for _,box in pairs(espBoxes) do
                    box:Destroy()
                end
                espBoxes = {}
            end
        end)

    elseif name == "Trolls" then
        local trollBtn = CreateButton("Randomize Character Colors", UDim2.new(0,0,0,0), contentFrame)
        trollBtn.Size = UDim2.new(1,0,0,35)
        trollBtn.BackgroundColor3 = Color3.fromRGB(180,30,30)
        trollBtn.TextColor3 = Color3.new(1,1,1)
        trollBtn.Parent = contentFrame

        trollBtn.MouseButton1Click:Connect(function()
            if LocalPlayer.Character then
                for _,part in pairs(LocalPlayer.Character:GetChildren()) do
                    if part:IsA("BasePart") then
                        part.BrickColor = BrickColor.Random()
                    end
                end
            end
        end)

    elseif name == "Settings" then
        local resetSpeedBtn = CreateButton("Reset WalkSpeed/Jump", UDim2.new(0,0,0,0), contentFrame)
        resetSpeedBtn.Size = UDim2.new(1,0,0,35)
        resetSpeedBtn.BackgroundColor3 = Color3.fromRGB(100,100,100)
        resetSpeedBtn.TextColor3 = Color3.new(1,1,1)
        resetSpeedBtn.Parent = contentFrame

        resetSpeedBtn.MouseButton1Click:Connect(function()
            if LocalPlayer.Character and LocalPlayer.Character:FindFirst
