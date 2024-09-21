local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")

local ScreenGui = Instance.new("ScreenGui")
local MenuFrame = Instance.new("Frame")
local ExecuteButton = Instance.new("TextButton")
local Label = Instance.new("TextLabel")
local UICornerFrame = Instance.new("UICorner")
local UICornerButton = Instance.new("UICorner")
local UICornerLabel = Instance.new("UICorner")
local UICornerShadow = Instance.new("UICorner")

MenuFrame.Size = UDim2.new(0.3, 0, 0.4, 0)
MenuFrame.Position = UDim2.new(0.35, 0, 0.3, 0)
MenuFrame.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
MenuFrame.BorderSizePixel = 0
MenuFrame.Parent = ScreenGui

UICornerFrame.Parent = MenuFrame
UICornerFrame.CornerRadius = UDim.new(0, 15)

Label.Size = UDim2.new(1, 0, 0.4, 0)
Label.Position = UDim2.new(0, 0, 0, 0)
Label.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
Label.Text = "ESP SCRIPT | BY SKY_SLL"
Label.TextColor3 = Color3.fromRGB(255, 255, 255)
Label.TextScaled = true
Label.TextStrokeTransparency = 0.5
Label.Parent = MenuFrame

UICornerLabel.Parent = Label
UICornerLabel.CornerRadius = UDim.new(0, 15)

ExecuteButton.Size = UDim2.new(0.9, 0, 0.3, 0)
ExecuteButton.Position = UDim2.new(0.05, 0, 0.5, 0)
ExecuteButton.BackgroundColor3 = Color3.fromRGB(0, 200, 0)
ExecuteButton.Text = "Executar"
ExecuteButton.TextScaled = true
ExecuteButton.TextColor3 = Color3.fromRGB(255, 255, 255)
ExecuteButton.TextStrokeTransparency = 0.5
ExecuteButton.Parent = MenuFrame

UICornerButton.Parent = ExecuteButton
UICornerButton.CornerRadius = UDim.new(0, 10)

local Shadow = Instance.new("Frame")
Shadow.Size = ExecuteButton.Size + UDim2.new(0, 10, 0, 10)
Shadow.Position = ExecuteButton.Position + UDim2.new(0, -5, 0, 5)
Shadow.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
Shadow.BackgroundTransparency = 0.5
Shadow.ZIndex = ExecuteButton.ZIndex - 1
Shadow.Parent = MenuFrame

UICornerShadow.Parent = Shadow
UICornerShadow.CornerRadius = UDim.new(0, 10)

local UIBlur = Instance.new("BlurEffect")
UIBlur.Size = 10
UIBlur.Parent = Shadow

ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

local function createOnOffGui()
    local NewScreenGui = Instance.new("ScreenGui")
    local OnOffFrame = Instance.new("Frame")
    local OnOffButton = Instance.new("TextButton")
    local UICornerOnOffFrame = Instance.new("UICorner")
    local UICornerOnOffButton = Instance.new("UICorner")
    local ESPLabel = Instance.new("TextLabel")

    OnOffFrame.Size = UDim2.new(0.3, 0, 0.3, 0)
    OnOffFrame.Position = UDim2.new(0.35, 0, 0.35, 0)
    OnOffFrame.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    OnOffFrame.Parent = NewScreenGui

    UICornerOnOffFrame.Parent = OnOffFrame
    UICornerOnOffFrame.CornerRadius = UDim.new(0, 15)

    OnOffButton.Size = UDim2.new(0.6, 0, 0.4, 0)
    OnOffButton.Position = UDim2.new(0.2, 0, 0.4, 0)
    OnOffButton.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
    OnOffButton.Text = "Off"
    OnOffButton.TextScaled = true
    OnOffButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    OnOffButton.Parent = OnOffFrame

    UICornerOnOffButton.Parent = OnOffButton
    UICornerOnOffButton.CornerRadius = UDim.new(0, 10)

    ESPLabel.Size = UDim2.new(1, 0, 0.2, 0)
    ESPLabel.Position = UDim2.new(0, 0, 0.1, 0)
    ESPLabel.BackgroundTransparency = 1
    ESPLabel.Text = "Ativar ESP"
    ESPLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    ESPLabel.TextScaled = true
    ESPLabel.Parent = OnOffFrame

    NewScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

    local isOn = false
    local espRunning = false

    local function addHighlight(player)
        if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            local highlight = Instance.new("Highlight")
            highlight.Parent = player.Character
            highlight.Adornee = player.Character
            highlight.FillColor = Color3.fromRGB(255, 0, 0)
            highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
            highlight.Name = "PlayerESPHighlight"
            highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
            
            local nameTag = Instance.new("BillboardGui")
            nameTag.Adornee = player.Character.HumanoidRootPart
            nameTag.Size = UDim2.new(0, 100, 0, 50)
            nameTag.StudsOffset = Vector3.new(0, 3, 0)
            nameTag.AlwaysOnTop = true

            local label = Instance.new("TextLabel")
            label.Size = UDim2.new(1, 0, 1, 0)
            label.BackgroundTransparency = 1
            label.TextColor3 = Color3.fromRGB(255, 255, 255)
            label.TextScaled = true
            label.Text = player.DisplayName
            label.Parent = nameTag

            nameTag.Parent = player.Character.HumanoidRootPart
        end
    end

    local function removeHighlights()
        for _, player in pairs(Players:GetPlayers()) do
            if player.Character and player.Character:FindFirstChild("PlayerESPHighlight") then
                player.Character.PlayerESPHighlight:Destroy()
            end
            if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                for _, v in pairs(player.Character.HumanoidRootPart:GetChildren()) do
                    if v:IsA("BillboardGui") then
                        v:Destroy()
                    end
                end
            end
        end
    end

    OnOffButton.MouseButton1Click:Connect(function()
        isOn = not isOn
        if isOn then
            OnOffButton.Text = "On"
            OnOffButton.BackgroundColor3 = Color3.fromRGB(0, 200, 0)
            espRunning = true

            while espRunning do
                for _, player in pairs(Players:GetPlayers()) do
                    addHighlight(player)
                end
                wait(1)
            end
        else
            OnOffButton.Text = "Off"
            OnOffButton.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
            removeHighlights()
            espRunning = false
        end
    end)

    Players.LocalPlayer.CharacterAdded:Connect(function()
        if isOn then
            wait(0.5)
            for _, player in pairs(Players:GetPlayers()) do
                addHighlight(player)
            end
        end
    end)

    OnOffFrame.Position = UDim2.new(0.35, 0, -0.5, 0)

    local descendTween = TweenService:Create(OnOffFrame, TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
        Position = UDim2.new(0.35, 0, 0.35, 0)
    })

    local ascendTween = TweenService:Create(OnOffFrame, TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
        Position = UDim2.new(0.75, 0, 0.05, 0)
    })

    descendTween:Play()
    descendTween.Completed:Connect(function()
        ascendTween:Play()
    end)
end

ExecuteButton.MouseButton1Click:Connect(function()
    print("Botão Executar foi clicado!")
    ScreenGui:Destroy()
    createOnOffGui()
end)
