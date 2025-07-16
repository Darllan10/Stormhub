local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")
local Player = Players.LocalPlayer
local Character = Player.Character or Player.CharacterAdded:Wait()
local hrp = Character:WaitForChild("HumanoidRootPart")

-- Função tween suave
local function TweenTo(targetCFrame, duration)
	local tween = TweenService:Create(hrp, TweenInfo.new(duration, Enum.EasingStyle.Linear), {CFrame = targetCFrame})
	tween:Play()
	tween.Completed:Wait()
end

-- Função TweenSteal com -3000 no Void
local function TweenSteal()
	local delivery

	for _, v in ipairs(workspace:WaitForChild("Plots"):GetDescendants()) do
		if v.Name == "DeliveryHitbox" and v:IsA("BasePart") and v.Parent:FindFirstChild("PlotSign") then
			local sign = v.Parent.PlotSign
			if sign:FindFirstChild("YourBase") and sign.YourBase.Enabled then
				delivery = v
				break
			end
		end
	end

	if not delivery then
		warn("Nenhum DeliveryHitbox encontrado.")
		return
	end

	local deliveryCF = delivery.CFrame * CFrame.new(0, -3, 0)
	local voidCF = CFrame.new(0, -3000, 0)

	-- 1º movimento para o delivery
	TweenTo(deliveryCF, 0.6)
	task.wait(0.2)

	-- 3x Void e 3x Delivery
	for _ = 1, 3 do
		TweenTo(voidCF, 0.5)
		task.wait(0.1)
		TweenTo(deliveryCF, 0.5)
		task.wait(0.1)
	end
end

-- GUI
local gui = Instance.new("ScreenGui", Player:WaitForChild("PlayerGui"))
gui.Name = "KDML_GUI"
gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

local blur = Instance.new("BlurEffect", workspace)
blur.Size = 0

local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0, 450, 0, 320)
frame.Position = UDim2.new(0.5, 0, 0.5, 0)
frame.AnchorPoint = Vector2.new(0.5, 0.5)
frame.BackgroundColor3 = Color3.fromRGB(10, 10, 15)
frame.BorderSizePixel = 0

Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 16)

local titleBar = Instance.new("Frame", frame)
titleBar.Size = UDim2.new(1, 0, 0, 40)
titleBar.BackgroundColor3 = Color3.fromRGB(15, 15, 20)

local titleText = Instance.new("TextLabel", titleBar)
titleText.Text = "KDML Hub"
titleText.TextSize = 20
titleText.Font = Enum.Font.GothamBlack
titleText.TextColor3 = Color3.new(1, 1, 1)
titleText.BackgroundTransparency = 1
titleText.Position = UDim2.new(0, 15, 0, 0)
titleText.Size = UDim2.new(1, -80, 1, 0)
titleText.TextXAlignment = Enum.TextXAlignment.Left

local btnFrame = Instance.new("Frame", titleBar)
btnFrame.Size = UDim2.new(0, 80, 1, 0)
btnFrame.Position = UDim2.new(1, -80, 0, 0)
btnFrame.BackgroundTransparency = 1

local minimize = Instance.new("TextButton", btnFrame)
minimize.Text = "-"
minimize.Size = UDim2.new(0, 24, 0, 24)
minimize.Position = UDim2.new(0.65, 0, 0.5, 0)
minimize.AnchorPoint = Vector2.new(0.5, 0.5)
minimize.BackgroundTransparency = 1
minimize.Font = Enum.Font.GothamBold
minimize.TextColor3 = Color3.fromRGB(255, 204, 0)
minimize.TextSize = 16

local close = Instance.new("TextButton", btnFrame)
close.Text = "X"
close.Size = UDim2.new(0, 24, 0, 24)
close.Position = UDim2.new(0.85, 0, 0.5, 0)
close.AnchorPoint = Vector2.new(0.5, 0.5)
close.BackgroundTransparency = 1
close.Font = Enum.Font.GothamBold
close.TextColor3 = Color3.fromRGB(255, 80, 80)
close.TextSize = 16

local content = Instance.new("Frame", frame)
content.Name = "Content"
content.BackgroundTransparency = 1
content.Position = UDim2.new(0, 0, 0, 40)
content.Size = UDim2.new(1, 0, 1, -40)

-- Botão 1: TP TO DELIVERY BOX
local btn1 = Instance.new("TextButton", content)
btn1.Text = "TP TO DELIVERY BOX"
btn1.Size = UDim2.new(0.8, 0, 0, 50)
btn1.Position = UDim2.new(0.1, 0, 0.1, 0)
btn1.BackgroundColor3 = Color3.fromRGB(0, 120, 255)
btn1.Font = Enum.Font.GothamSemibold
btn1.TextSize = 18
btn1.TextColor3 = Color3.fromRGB(255, 255, 255)
Instance.new("UICorner", btn1).CornerRadius = UDim.new(0, 12)

-- Botão 2: TP INSIDE NEAREST BASE
local btn2 = Instance.new("TextButton", content)
btn2.Text = "TP INSIDE NEAREST BASE"
btn2.Size = UDim2.new(0.8, 0, 0, 50)
btn2.Position = UDim2.new(0.1, 0, 0.35, 0)
btn2.BackgroundColor3 = Color3.fromRGB(0, 120, 255)
btn2.Font = Enum.Font.GothamSemibold
btn2.TextSize = 18
btn2.TextColor3 = Color3.fromRGB(255, 255, 255)
Instance.new("UICorner", btn2).CornerRadius = UDim.new(0, 12)

-- Botão 3: TWEEN STEAL
local btn3 = Instance.new("TextButton", content)
btn3.Text = "TWEEN STEAL"
btn3.Size = UDim2.new(0.8, 0, 0, 50)
btn3.Position = UDim2.new(0.1, 0, 0.6, 0)
btn3.BackgroundColor3 = Color3.fromRGB(0, 120, 255)
btn3.Font = Enum.Font.GothamSemibold
btn3.TextSize = 18
btn3.TextColor3 = Color3.fromRGB(255, 255, 255)
Instance.new("UICorner", btn3).CornerRadius = UDim.new(0, 12)

-- Conectar botão 3 à função TweenSteal
btn3.MouseButton1Click:Connect(TweenSteal)

-- Animação inicial
TweenService:Create(blur, TweenInfo.new(0.6), {Size = 15}):Play()
TweenService:Create(frame, TweenInfo.new(0.6, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
	BackgroundTransparency = 0
}):Play()
