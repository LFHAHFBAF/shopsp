local player = game.Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")
local UserInputService = game:GetService("UserInputService")

local isTargetPlayer = true

local function createGUI()
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "商店控制器"
    screenGui.IgnoreGuiInset = true
    screenGui.DisplayOrder = 9999
    screenGui.Parent = playerGui

    local mainFrame = Instance.new("Frame")
    mainFrame.Name = "MainFrame"
    mainFrame.Size = UDim2.new(0, 400, 0, 350)
    mainFrame.Position = UDim2.new(0.5, -200, 0.5, -175)
    mainFrame.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2)
    mainFrame.BorderSizePixel = 0
    mainFrame.Parent = screenGui

    local closeButton = Instance.new("TextButton")
    closeButton.Name = "CloseButton"
    closeButton.Size = UDim2.new(0, 30, 0, 30)
    closeButton.Position = UDim2.new(1, -35, 0, 5)
    closeButton.BackgroundColor3 = Color3.new(0.8, 0, 0)
    closeButton.Text = "X"
    closeButton.TextColor3 = Color3.new(1, 1, 1)
    closeButton.TextSize = 18
    closeButton.Font = Enum.Font.SourceSansBold
    closeButton.Parent = mainFrame

    closeButton.MouseButton1Click:Connect(function()
        screenGui:Destroy()
    end)

    local isDragging = false
    local dragStartPos, frameStartPos

    mainFrame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            isDragging = true
            dragStartPos = input.Position
            frameStartPos = mainFrame.Position
        end
    end)

    UserInputService.InputChanged:Connect(function(input)
        if isDragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            local delta = input.Position - dragStartPos
            mainFrame.Position = UDim2.new(
                frameStartPos.X.Scale, frameStartPos.X.Offset + delta.X,
                frameStartPos.Y.Scale, frameStartPos.Y.Offset + delta.Y
            )
        end
    end)

    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            isDragging = false
        end
    end)

    local titleLabel = Instance.new("TextLabel")
    titleLabel.Name = "TitleLabel"
    titleLabel.Size = UDim2.new(1, 0, 0, 50)
    titleLabel.Position = UDim2.new(0, 0, 0, 0)
    titleLabel.BackgroundTransparency = 1
    titleLabel.Text = "商店控制器"
    titleLabel.TextColor3 = Color3.new(1, 1, 1)
    titleLabel.TextSize = 28
    titleLabel.Font = Enum.Font.SourceSansBold
    titleLabel.Parent = mainFrame

    local authorLabel = Instance.new("TextLabel")
    authorLabel.Name = "AuthorLabel"
    authorLabel.Size = UDim2.new(1, 0, 0, 20)
    authorLabel.Position = UDim2.new(0, 0, 0, 50)
    authorLabel.BackgroundTransparency = 1
    authorLabel.Text = "脚本by:白羽"
    authorLabel.TextColor3 = Color3.new(1, 0, 0)
    authorLabel.TextSize = 14
    authorLabel.Font = Enum.Font.SourceSans
    authorLabel.Parent = mainFrame

    local button1 = Instance.new("TextButton")
    button1.Name = "Button_Store"
    button1.Size = UDim2.new(1, -20, 0, 60)
    button1.Position = UDim2.new(0, 10, 0, 80)
    button1.BackgroundColor3 = Color3.new(0.3, 0.3, 0.3)
    button1.Text = "打开\\关闭商店GUI"
    button1.TextColor3 = Color3.new(1, 1, 1)
    button1.TextSize = 20
    button1.Font = Enum.Font.SourceSansBold
    button1.Parent = mainFrame

    local button2 = Instance.new("TextButton")
    button2.Name = "Button_UTCM"
    button2.Size = UDim2.new(1, -20, 0, 60)
    button2.Position = UDim2.new(0, 10, 0, 150)
    button2.BackgroundColor3 = Color3.new(0.3, 0.3, 0.3)
    button2.Text = "打开\\关闭UTCM商店GUI"
    button2.TextColor3 = Color3.new(0, 0, 1)
    button2.TextSize = 20
    button2.Font = Enum.Font.SourceSansBold
    button2.Parent = mainFrame

    local button3 = Instance.new("TextButton")
    button3.Name = "Button_UTSM"
    button3.Size = UDim2.new(1, -20, 0, 60)
    button3.Position = UDim2.new(0, 10, 0, 220)
    button3.BackgroundColor3 = Color3.new(0.3, 0.3, 0.3)
    button3.Text = "打开\\关闭UTSM商店GUI"
    button3.TextColor3 = Color3.new(1, 0, 0)
    button3.TextSize = 20
    button3.Font = Enum.Font.SourceSansBold
    button3.Parent = mainFrame

    local button4 = Instance.new("TextButton")
    button4.Name = "Button_UTTV"
    button4.Size = UDim2.new(1, -20, 0, 60)
    button4.Position = UDim2.new(0, 10, 0, 290)
    button4.BackgroundColor3 = Color3.new(0.3, 0.3, 0.3)
    button4.Text = "打开\\关闭UTTV商店GUI"
    button4.TextColor3 = Color3.new(1, 0, 1)
    button4.TextSize = 20
    button4.Font = Enum.Font.SourceSansBold
    button4.Parent = mainFrame

    button1.MouseButton1Click:Connect(function()
        if isTargetPlayer then
            local gui003A = playerGui:FindFirstChild("003-A")
            if gui003A then
                gui003A.Enabled = not gui003A.Enabled
            end
        end
    end)

    button2.MouseButton1Click:Connect(function()
        if isTargetPlayer then
            local upgradeCameraShop = playerGui:FindFirstChild("UpgradeCameraShop")
            if upgradeCameraShop then
                upgradeCameraShop.Enabled = not upgradeCameraShop.Enabled
            end
        end
    end)

    button3.MouseButton1Click:Connect(function()
        if isTargetPlayer then
            local confirmUTSM = playerGui:FindFirstChild("ConfirmUTSM")
            if confirmUTSM then
                confirmUTSM.Enabled = not confirmUTSM.Enabled
            end
        end
    end)

    button4.MouseButton1Click:Connect(function()
        if isTargetPlayer then
            local upgradeTVShop = playerGui:FindFirstChild("UpgradeTVShop")
            if upgradeTVShop then
                upgradeTVShop.Enabled = not upgradeTVShop.Enabled
            end
        end
    end)
end

createGUI()
player.CharacterAdded:Connect(createGUI)