--4.0
local player = game.Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")
local UserInputService = game:GetService("UserInputService")

local isTargetPlayer = true
local isMobile = UserInputService.TouchEnabled and not UserInputService.KeyboardEnabled

local uiParams = isMobile and {
    mainFrameSize = UDim2.new(0, 300, 0, 260),
    mainFramePos = UDim2.new(0.5, -150, 0.5, -130),
    buttonSize = UDim2.new(1, -16, 0, 45),
    buttonTextSize = 16,
    titleTextSize = 22,
    authorTextSize = 12,
    minButtonSize = UDim2.new(0, 24, 0, 24),
    minButtonTextSize = 14
} or {
    mainFrameSize = UDim2.new(0, 400, 0, 350),
    mainFramePos = UDim2.new(0.5, -200, 0.5, -175),
    buttonSize = UDim2.new(1, -20, 0, 60),
    buttonTextSize = 20,
    titleTextSize = 28,
    authorTextSize = 14,
    minButtonSize = UDim2.new(0, 30, 0, 30),
    minButtonTextSize = 18
}

local function createGUI()
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "商店控制器"
    screenGui.IgnoreGuiInset = true
    screenGui.DisplayOrder = 9999
    screenGui.Parent = playerGui

    local mainFrame = Instance.new("Frame")
    mainFrame.Name = "MainFrame"
    mainFrame.Size = uiParams.mainFrameSize
    mainFrame.Position = uiParams.mainFramePos
    mainFrame.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2)
    mainFrame.BorderSizePixel = 0
    mainFrame.Parent = screenGui

    local minimizeButton = Instance.new("TextButton")
    minimizeButton.Name = "MinimizeButton"
    minimizeButton.Size = uiParams.minButtonSize
    minimizeButton.Position = UDim2.new(1, -uiParams.minButtonSize.X.Offset - 5, 0, 5)
    minimizeButton.BackgroundColor3 = Color3.new(0.5, 0.5, 0.5)
    minimizeButton.Text = "-"
    minimizeButton.TextColor3 = Color3.new(1, 1, 1)
    minimizeButton.TextSize = uiParams.minButtonTextSize
    minimizeButton.Font = Enum.Font.SourceSansBold
    minimizeButton.Parent = mainFrame

    local closeButton = Instance.new("TextButton")
    closeButton.Name = "CloseButton"
    closeButton.Size = uiParams.minButtonSize
    closeButton.Position = UDim2.new(1, -uiParams.minButtonSize.X.Offset - 5, 0, 5 + uiParams.minButtonSize.Y.Offset + 5)
    closeButton.BackgroundColor3 = Color3.new(0.8, 0, 0)
    closeButton.Text = "X"
    closeButton.TextColor3 = Color3.new(1, 1, 1)
    closeButton.TextSize = uiParams.minButtonTextSize
    closeButton.Font = Enum.Font.SourceSansBold
    closeButton.Parent = mainFrame

    local titleLabel = Instance.new("TextLabel")
    titleLabel.Name = "TitleLabel"
    titleLabel.Size = UDim2.new(1, 0, 0, 40)
    titleLabel.Position = UDim2.new(0, 0, 0, 0)
    titleLabel.BackgroundTransparency = 1
    titleLabel.Text = "商店控制器"
    titleLabel.TextColor3 = Color3.new(1, 1, 1)
    titleLabel.TextSize = uiParams.titleTextSize
    titleLabel.Font = Enum.Font.SourceSansBold
    titleLabel.Parent = mainFrame

    local authorLabel = Instance.new("TextLabel")
    authorLabel.Name = "AuthorLabel"
    authorLabel.Size = UDim2.new(1, 0, 0, 16)
    authorLabel.Position = UDim2.new(0, 0, 0, 40)
    authorLabel.BackgroundTransparency = 1
    authorLabel.Text = "脚本by:白羽"
    authorLabel.TextColor3 = Color3.new(1, 0, 0)
    authorLabel.TextSize = uiParams.authorTextSize
    authorLabel.Font = Enum.Font.SourceSans
    authorLabel.Parent = mainFrame

    local buttonYOffsets = isMobile and {60, 115, 170, 225} or {80, 150, 220, 290}

    local button1 = Instance.new("TextButton")
    button1.Name = "Button_Store"
    button1.Size = uiParams.buttonSize
    button1.Position = UDim2.new(0, 8, 0, buttonYOffsets[1])
    button1.BackgroundColor3 = Color3.new(0.3, 0.3, 0.3)
    button1.Text = "打开\\关闭商店GUI"
    button1.TextColor3 = Color3.new(1, 1, 1)
    button1.TextSize = uiParams.buttonTextSize
    button1.Font = Enum.Font.SourceSansBold
    button1.Parent = mainFrame

    local button2 = Instance.new("TextButton")
    button2.Name = "Button_UTCM"
    button2.Size = uiParams.buttonSize
    button2.Position = UDim2.new(0, 8, 0, buttonYOffsets[2])
    button2.BackgroundColor3 = Color3.new(0.3, 0.3, 0.3)
    button2.Text = "打开\\关闭UTCM商店GUI"
    button2.TextColor3 = Color3.new(0, 0, 1)
    button2.TextSize = uiParams.buttonTextSize
    button2.Font = Enum.Font.SourceSansBold
    button2.Parent = mainFrame

    local button3 = Instance.new("TextButton")
    button3.Name = "Button_UTSM"
    button3.Size = uiParams.buttonSize
    button3.Position = UDim2.new(0, 8, 0, buttonYOffsets[3])
    button3.BackgroundColor3 = Color3.new(0.3, 0.3, 0.3)
    button3.Text = "打开\\关闭UTSM商店GUI"
    button3.TextColor3 = Color3.new(1, 0, 0)
    button3.TextSize = uiParams.buttonTextSize
    button3.Font = Enum.Font.SourceSansBold
    button3.Parent = mainFrame

    local button4 = Instance.new("TextButton")
    button4.Name = "Button_UTTV"
    button4.Size = uiParams.buttonSize
    button4.Position = UDim2.new(0, 8, 0, buttonYOffsets[4])
    button4.BackgroundColor3 = Color3.new(0.3, 0.3, 0.3)
    button4.Text = "打开\\关闭UTTV商店GUI"
    button4.TextColor3 = Color3.new(1, 0, 1)
    button4.TextSize = uiParams.buttonTextSize
    button4.Font = Enum.Font.SourceSansBold
    button4.Parent = mainFrame

    local originalSize = mainFrame.Size
    local collapsibleElements = {authorLabel, button1, button2, button3, button4}
    local isMinimized = false

    minimizeButton.MouseButton1Click:Connect(function()
        isMinimized = not isMinimized
        if isMinimized then
            mainFrame.Size = UDim2.new(uiParams.mainFrameSize.X.Scale, uiParams.mainFrameSize.X.Offset, 0, 40)
            for _, elem in ipairs(collapsibleElements) do
                elem.Visible = false
            end
        else
            mainFrame.Size = originalSize
            for _, elem in ipairs(collapsibleElements) do
                elem.Visible = true
            end
        end
    end)

    closeButton.MouseButton1Click:Connect(function()
        screenGui:Destroy()
    end)

    local isDragging = false
    local dragStartPos, frameStartPos
    local activeTouchId = nil

    mainFrame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            isDragging = true
            dragStartPos = input.Position
            frameStartPos = mainFrame.Position
        elseif input.UserInputType == Enum.UserInputType.Touch then
            if not activeTouchId then
                activeTouchId = input.TouchId
                isDragging = true
                dragStartPos = input.Position
                frameStartPos = mainFrame.Position
            end
        end
    end)

    UserInputService.InputChanged:Connect(function(input)
        if isDragging then
            if input.UserInputType == Enum.UserInputType.MouseMovement then
                local delta = input.Position - dragStartPos
                mainFrame.Position = UDim2.new(
                    frameStartPos.X.Scale, frameStartPos.X.Offset + delta.X,
                    frameStartPos.Y.Scale, frameStartPos.Y.Offset + delta.Y
                )
            elseif input.UserInputType == Enum.UserInputType.Touch and input.TouchId == activeTouchId then
                local delta = input.Position - dragStartPos
                mainFrame.Position = UDim2.new(
                    frameStartPos.X.Scale, frameStartPos.X.Offset + delta.X,
                    frameStartPos.Y.Scale, frameStartPos.Y.Offset + delta.Y
                )
            end
        end
    end)

    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            isDragging = false
        elseif input.UserInputType == Enum.UserInputType.Touch and input.TouchId == activeTouchId then
            isDragging = false
            activeTouchId = nil
        end
    end)

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
