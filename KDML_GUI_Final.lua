
-- KDML GUI Final (Darllan) - GUI igual ao vídeo + funcionalidades

local plr = game.Players.LocalPlayer
local rs = game:GetService("ReplicatedStorage")
local ts = game:GetService("TweenService")

-- Criar GUI
local gui = Instance.new("ScreenGui", plr:WaitForChild("PlayerGui"))
gui.Name = "KDML_Gui"

local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0, 320, 0, 240)
frame.Position = UDim2.new(0.5, -160, 0.5, -120)
frame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
frame.BorderSizePixel = 0
frame.Name = "MainFrame"

Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 12)
Instance.new("UIStroke", frame).Color = Color3.fromRGB(0, 132, 255)

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

local btn1 = createButton("STEAL", 0.1)
local btn2 = createButton("TP INSIDE NEAREST BASE", 0.45)
local btn3 = createButton("TWEEN STEAL", 0.75)

-- Função para detectar se brainrot foi roubado
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

-- STEAL: teleportando até conseguir roubar
btn1.MouseButton1Click:Connect(function()
	task.spawn(function()
		while not foiRoubado() do
			for _, base in pairs(rs.Bases.ThirdFloor.AnimalPodiums:GetChildren()) do
				local teleport = base:FindFirstChild("Base")
				if teleport then
					plr.Character:MoveTo(teleport.Position + Vector3.new(0,3,0))
					wait(0.5)
				end
			end
		end
	end)
end)

-- TP INSIDE: teleporta para primeira base encontrada
btn2.MouseButton1Click:Connect(function()
	for _, base in pairs(rs.Bases.ThirdFloor.AnimalPodiums:GetChildren()) do
		local p = base:FindFirstChild("Base")
		if p then
			plr.Character:MoveTo(p.Position + Vector3.new(0,3,0))
			break
		end
	end
end)

-- TWEEN STEAL: flutua até a base, volta se falhar
btn3.MouseButton1Click:Connect(function()
	task.spawn(function()
		for _, base in pairs(rs.Bases.ThirdFloor.AnimalPodiums:GetChildren()) do
			local ponto = base:FindFirstChild("Base")
			if ponto then
				local humanoideRoot = plr.Character:FindFirstChild("HumanoidRootPart")
				if humanoideRoot then
					local origem = humanoideRoot.Position
					local tween = ts:Create(humanoideRoot, TweenInfo.new(2), {CFrame = ponto.CFrame + Vector3.new(0,3,0)})
					tween:Play()
					tween.Completed:Wait()
					wait(0.5)
					if not foiRoubado() then
						local voltar = ts:Create(humanoideRoot, TweenInfo.new(2), {CFrame = CFrame.new(origem)})
						voltar:Play()
						voltar.Completed:Wait()
					else
						break
					end
				end
			end
		end
	end)
end)
