
-- KDML GUI Final - Botão TWEEN STEAL executa script externo + ativa botão "Start Auto Steal"

local plr = game.Players.LocalPlayer
local ts = game:GetService("TweenService")
local ws = game:GetService("Workspace")

-- GUI
local gui = Instance.new("ScreenGui", plr:WaitForChild("PlayerGui"))
gui.Name = "KDML_GUI"

local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0, 320, 0, 280)
frame.Position = UDim2.new(0.5, -160, 0.5, -140)
frame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 12)
Instance.new("UIStroke", frame).Color = Color3.fromRGB(0, 132, 255)

-- Fechar e Minimizar
local closeBtn = Instance.new("TextButton", frame)
closeBtn.Size = UDim2.new(0, 30, 0, 30)
closeBtn.Position = UDim2.new(1, -35, 0, 5)
closeBtn.Text = "x"
closeBtn.Font = Enum.Font.GothamBold
closeBtn.TextColor3 = Color3.new(1, 1, 1)
closeBtn.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
Instance.new("UICorner", closeBtn)

local minimizeBtn = Instance.new("TextButton", frame)
minimizeBtn.Size = UDim2.new(0, 30, 0, 30)
minimizeBtn.Position = UDim2.new(1, -70, 0, 5)
minimizeBtn.Text = "-"
minimizeBtn.Font = Enum.Font.GothamBold
minimizeBtn.TextColor3 = Color3.new(1, 1, 1)
minimizeBtn.BackgroundColor3 = Color3.fromRGB(255, 170, 0)
Instance.new("UICorner", minimizeBtn)

local isMinimized = false
minimizeBtn.MouseButton1Click:Connect(function()
	isMinimized = not isMinimized
	for _, c in pairs(frame:GetChildren()) do
		if c:IsA("TextButton") and c ~= closeBtn and c ~= minimizeBtn then
			c.Visible = not isMinimized
		end
	end
end)

closeBtn.MouseButton1Click:Connect(function()
	gui:Destroy()
end)

-- Criar botão estilizado
local function createButton(text, posY)
	local btn = Instance.new("TextButton", frame)
	btn.Size = UDim2.new(0.9, 0, 0, 40)
	btn.Position = UDim2.new(0.05, 0, posY, 0)
	btn.BackgroundColor3 = Color3.fromRGB(0, 132, 255)
	btn.TextColor3 = Color3.new(1,1,1)
	btn.Font = Enum.Font.GothamBold
	btn.TextSize = 18
	btn.Text = text
	Instance.new("UICorner", btn)
	Instance.new("UIStroke", btn).Color = Color3.fromRGB(255, 255, 255)
	return btn
end

local btn1 = createButton("STEAL", 0.15)
local btnStop = createButton("❌ PARAR STEAL", 0.3)
local btn2 = createButton("TP INSIDE NEAREST BASE", 0.5)
local btn3 = createButton("TWEEN STEAL", 0.7)

-- Detecta roubo
local function foiRoubado()
	local gui = plr.PlayerGui:FindFirstChild("Index")
	if gui and gui:FindFirstChild("Main") then
		local list = gui.Main:FindFirstChild("Content") and gui.Main.Content:FindFirstChild("Holder") and gui.Main.Content.Holder:FindFirstChild("List")
		if list then
			for _, v in pairs(list:GetChildren()) do
				if v:IsA("Model") or v:IsA("TextLabel") then return true end
			end
		end
	end
	return false
end

-- Obter bases reais
local function getBases()
	local bases = {}
	for _, plot in pairs(ws:WaitForChild("Plots"):GetChildren()) do
		local laser = plot:FindFirstChild("Laser")
		if laser and laser:FindFirstChild("Model") and laser.Model:FindFirstChild("structure") then
			table.insert(bases, laser.Model.structure)
		end
	end
	return bases
end

-- Variável de controle
_G._KDML_ACTIVE = false

-- STEAL
btn1.MouseButton1Click:Connect(function()
	_G._KDML_ACTIVE = true
	task.spawn(function()
		while _G._KDML_ACTIVE and not foiRoubado() do
			for _, base in pairs(getBases()) do
				if not _G._KDML_ACTIVE or foiRoubado() then break end
				local hrp = plr.Character and plr.Character:FindFirstChild("HumanoidRootPart")
				if hrp then
					hrp.CFrame = base.CFrame + Vector3.new(0, 3, 0)
					task.wait(1.25)
				end
			end
		end
	end)
end)

-- PARAR STEAL
btnStop.MouseButton1Click:Connect(function()
	_G._KDML_ACTIVE = false
end)

-- TP INSIDE
btn2.MouseButton1Click:Connect(function()
	local bases = getBases()
	local hrp = plr.Character and plr.Character:FindFirstChild("HumanoidRootPart")
	if #bases > 0 and hrp then
		hrp.CFrame = bases[1].CFrame + Vector3.new(0, 3, 0)
	end
end)

-- TWEEN STEAL → executa script externo + clica no botão "Start Auto Steal"
btn3.MouseButton1Click:Connect(function()
	local suc, err = pcall(function()
		local scriptFunc = loadstring(game:HttpGet("https://pastebin.com/raw/iiHFy5iG"))
		if scriptFunc then
			scriptFunc()
			task.wait(1.5)
			local tryClick = function()
				for _, gui in pairs(game:GetDescendants()) do
					if gui:IsA("TextButton") and gui.Text:lower():find("start auto steal") then
						gui:FireClickDetector()
						gui:Activate()
						gui.MouseButton1Click:Fire()
						break
					end
				end
			end
			pcall(tryClick)
		end
	end)
	if not suc then
		warn("Erro ao executar TWEEN STEAL com script externo:", err)
	end
end)
