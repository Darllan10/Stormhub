
-- KDML GUI (by Darllan) com Minimize e Fechar + Bases reais no Workspace.Plots

local plr = game.Players.LocalPlayer
local rs = game:GetService("ReplicatedStorage")
local ts = game:GetService("TweenService")
local ws = game:GetService("Workspace")

-- Criar GUI
local gui = Instance.new("ScreenGui", plr:WaitForChild("PlayerGui"))
gui.Name = "KDML_GUI"

local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0, 320, 0, 240)
frame.Position = UDim2.new(0.5, -160, 0.5, -120)
frame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
frame.Name = "MainFrame"
Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 12)
Instance.new("UIStroke", frame).Color = Color3.fromRGB(0, 132, 255)

-- Minimizar e Fechar
local closeBtn = Instance.new("TextButton", frame)
closeBtn.Size = UDim2.new(0, 30, 0, 30)
closeBtn.Position = UDim2.new(1, -35, 0, 5)
closeBtn.Text = "x"
closeBtn.TextSize = 18
closeBtn.Font = Enum.Font.GothamBold
closeBtn.TextColor3 = Color3.new(1, 1, 1)
closeBtn.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
Instance.new("UICorner", closeBtn)

local minimizeBtn = Instance.new("TextButton", frame)
minimizeBtn.Size = UDim2.new(0, 30, 0, 30)
minimizeBtn.Position = UDim2.new(1, -70, 0, 5)
minimizeBtn.Text = "-"
minimizeBtn.TextSize = 18
minimizeBtn.Font = Enum.Font.GothamBold
minimizeBtn.TextColor3 = Color3.new(1, 1, 1)
minimizeBtn.BackgroundColor3 = Color3.fromRGB(255, 170, 0)
Instance.new("UICorner", minimizeBtn)

local isMinimized = false
minimizeBtn.MouseButton1Click:Connect(function()
	isMinimized = not isMinimized
	for _, child in pairs(frame:GetChildren()) do
		if child:IsA("TextButton") and child ~= closeBtn and child ~= minimizeBtn then
			child.Visible = not isMinimized
		end
	end
end)

closeBtn.MouseButton1Click:Connect(function()
	gui:Destroy()
end)

-- Criar Botões de Função
local function createButton(text, posY)
	local button = Instance.new("TextButton", frame)
	button.Size = UDim2.new(0.9, 0, 0, 50)
	button.Position = UDim2.new(0.05, 0, posY, 0)
	button.BackgroundColor3 = Color3.fromRGB(0, 132, 255)
	button.TextColor3 = Color3.new(1,1,1)
	button.Font = Enum.Font.GothamBold
	button.TextSize = 18
	button.Text = text
	Instance.new("UICorner", button).CornerRadius = UDim.new(0, 8)
	Instance.new("UIStroke", button).Color = Color3.fromRGB(255, 255, 255)
	return button
end

local btn1 = createButton("STEAL", 0.2)
local btn2 = createButton("TP INSIDE NEAREST BASE", 0.45)
local btn3 = createButton("TWEEN STEAL", 0.7)

-- Função de detecção de roubo
local function foiRoubado()
	local holder = plr.PlayerGui:FindFirstChild("Index")
	if not holder then return false end
	local lista = holder:FindFirstChild("Main") and holder.Main:FindFirstChild("Content") and holder.Main.Content:FindFirstChild("Holder") and holder.Main.Content.Holder:FindFirstChild("List")
	if not lista then return false end
	for _, v in pairs(lista:GetChildren()) do
		if v:IsA("Model") or v:IsA("TextLabel") then
			return true
		end
	end
	return false
end

-- Obter todas as bases reais do mapa
local function getBases()
	local bases = {}
	for _, plot in pairs(ws.Plots:GetChildren()) do
		local laser = plot:FindFirstChild("Laser")
		if laser and laser:FindFirstChild("Model") and laser.Model:FindFirstChild("structure") then
			table.insert(bases, laser.Model.structure)
		end
	end
	return bases
end

-- Botão 1: STEAL
btn1.MouseButton1Click:Connect(function()
	task.spawn(function()
		while not foiRoubado() do
			for _, base in pairs(getBases()) do
				plr.Character:MoveTo(base.Position + Vector3.new(0,3,0))
				task.wait(0.5)
			end
		end
	end)
end)

-- Botão 2: TP INSIDE
btn2.MouseButton1Click:Connect(function()
	local bases = getBases()
	if #bases > 0 then
		plr.Character:MoveTo(bases[1].Position + Vector3.new(0,3,0))
	end
end)

-- Botão 3: TWEEN STEAL
btn3.MouseButton1Click:Connect(function()
	task.spawn(function()
		for _, base in pairs(getBases()) do
			local humanoideRoot = plr.Character:FindFirstChild("HumanoidRootPart")
			if humanoideRoot then
				local origem = humanoideRoot.Position
				local tween = ts:Create(humanoideRoot, TweenInfo.new(2), {CFrame = base.CFrame + Vector3.new(0,3,0)})
				tween:Play()
				tween.Completed:Wait()
				task.wait(0.5)
				if not foiRoubado() then
					local voltar = ts:Create(humanoideRoot, TweenInfo.new(2), {CFrame = CFrame.new(origem)})
					voltar:Play()
					voltar.Completed:Wait()
				else
					break
				end
			end
		end
	end)
end)
