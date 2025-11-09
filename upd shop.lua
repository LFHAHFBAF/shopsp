local player = game.Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")
local UserInputService = game:GetService("UserInputService")

local shouldRecreateUI = true
local lastFramePosition = nil

local uiParams = {
    mainFrameSize = UDim2.new(0, 300, 0, 360),
    mainFramePos = UDim2.new(0.5, -150, 0.5, -180),
    buttonSize = UDim2.new(0.45, -8, 0, 40),
    buttonTextSize = 17,
    titleTextSize = 22,
    minButtonSize = UDim2.new(0, 28, 0, 28),
    minButtonTextSize = 18,
    authorTextSize = 13
}

local mainFrame, screenGui
local isMinimized = false
local isDragging = false
local dragStartPos, frameStartPos
local activeTouchId = nil

local function isPointInFrame(point, frame)
    local absPos = frame.AbsolutePosition
    local absSize = frame.AbsoluteSize
    return point.X >= absPos.X 
        and point.X <= absPos.X + absSize.X 
        and point.Y >= absPos.Y 
        and point.Y <= absPos.Y + absSize.Y
end

local function createGUI()
    if screenGui then
        screenGui:Destroy()
    end

    if not shouldRecreateUI then
        return
    end

    screenGui = Instance.new("ScreenGui")
    screenGui.Name = "通用UI控制器"
    screenGui.IgnoreGuiInset = true
    screenGui.DisplayOrder = 9999
    screenGui.Parent = playerGui

    mainFrame = Instance.new("Frame")
    mainFrame.Name = "MainFrame"
    mainFrame.Size = uiParams.mainFrameSize
    mainFrame.Position = lastFramePosition or uiParams.mainFramePos
    mainFrame.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
    mainFrame.BorderSizePixel = 2
    mainFrame.BorderColor3 = Color3.new(0.3, 0.3, 0.3)
    mainFrame.Parent = screenGui

    local titleBar = Instance.new("Frame")
    titleBar.Name = "TitleBar"
    titleBar.Size = UDim2.new(1, 0, 0, 50)
    titleBar.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2)
    titleBar.Parent = mainFrame

    local titleLabel = Instance.new("TextLabel")
    titleLabel.Name = "TitleLabel"
    titleLabel.Size = UDim2.new(1, 0, 1, 0)
    titleLabel.BackgroundTransparency = 1
    titleLabel.Text = "UI控制器"
    titleLabel.TextColor3 = Color3.new(1, 1, 1)
    titleLabel.TextSize = uiParams.titleTextSize
    titleLabel.Font = Enum.Font.SourceSansBold
    titleLabel.TextXAlignment = Enum.TextXAlignment.Center
    titleLabel.Parent = titleBar

    local minimizeButton = Instance.new("TextButton")
    minimizeButton.Name = "MinimizeButton"
    minimizeButton.Size = uiParams.minButtonSize
    minimizeButton.Position = UDim2.new(1, -uiParams.minButtonSize.X.Offset*2 - 8, 0, (50 - uiParams.minButtonSize.Y.Offset)/2)
    minimizeButton.BackgroundColor3 = Color3.new(0.2, 0.8, 0.2)
    minimizeButton.Text = "-"
    minimizeButton.TextColor3 = Color3.new(1, 1, 1)
    minimizeButton.TextSize = uiParams.minButtonTextSize
    minimizeButton.Font = Enum.Font.SourceSansBold
    minimizeButton.Parent = titleBar

    local closeButton = Instance.new("TextButton")
    closeButton.Name = "CloseButton"
    closeButton.Size = uiParams.minButtonSize
    closeButton.Position = UDim2.new(1, -uiParams.minButtonSize.X.Offset - 4, 0, (50 - uiParams.minButtonSize.Y.Offset)/2)
    closeButton.BackgroundColor3 = Color3.new(0.8, 0, 0)
    closeButton.Text = "X"
    closeButton.TextColor3 = Color3.new(1, 1, 1)
    closeButton.TextSize = uiParams.minButtonTextSize
    closeButton.Font = Enum.Font.SourceSansBold
    closeButton.Parent = titleBar

    local buttonContainer = Instance.new("Frame")
    buttonContainer.Name = "ButtonContainer"
    buttonContainer.Size = UDim2.new(1, 0, 1, -75)
    buttonContainer.Position = UDim2.new(0, 0, 0, 50)
    buttonContainer.BackgroundTransparency = 1
    buttonContainer.Parent = mainFrame

    local buttonLabels = {
        "商店", "UTC商店", "UTS商店", "UTTV商店",
        "提交样本", "升级等级", "DJ商店", "TV商店"
    }
    local buttonColors = {
        Color3.new(1, 1, 1), Color3.new(0, 0, 1), Color3.new(1, 0, 0), Color3.new(1, 0, 1),
        Color3.new(1, 0.8, 0), Color3.new(1, 0.8, 0), Color3.new(0.8, 0, 0.8), Color3.new(0.5, 0, 0.5)
    }
    local buttonYOffsets = {12, 62, 112, 162}

    local buttons = {}
    for i = 1, 8 do
        local button = Instance.new("TextButton")
        button.Name = "Button" .. i
        button.Size = uiParams.buttonSize
        local columnOffset = i > 4 and 0.53 or 0.02
        button.Position = UDim2.new(columnOffset, 0, 0, buttonYOffsets[(i - 1) % 4 + 1])
        button.BackgroundColor3 = Color3.new(0.15, 0.15, 0.15)
        button.BorderSizePixel = 1
        button.BorderColor3 = Color3.new(0.4, 0.4, 0.4)
        button.Text = buttonLabels[i]
        button.TextColor3 = buttonColors[i]
        button.TextSize = uiParams.buttonTextSize
        button.Font = Enum.Font.SourceSansBold
        button.Parent = buttonContainer
        button.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                input.Handled = false
            end
        end)
        buttons[i] = button
    end

    buttons[1].MouseButton1Click:Connect(function()
        local gui003A = playerGui:FindFirstChild("003-A")
        if gui003A then
            gui003A.Enabled = not gui003A.Enabled
            buttons[1].BackgroundColor3 = Color3.new(0.3, 0.3, 0.3)
            task.wait(0.1)
            buttons[1].BackgroundColor3 = Color3.new(0.15, 0.15, 0.15)
        end
    end)

    buttons[2].MouseButton1Click:Connect(function()
        local upgradeCameraShop = playerGui:FindFirstChild("UpgradeCameraShop")
        if upgradeCameraShop then
            upgradeCameraShop.Enabled = not upgradeCameraShop.Enabled
            buttons[2].BackgroundColor3 = Color3.new(0.2, 0.2, 0.4)
            task.wait(0.1)
            buttons[2].BackgroundColor3 = Color3.new(0.15, 0.15, 0.15)
        end
    end)

    buttons[3].MouseButton1Click:Connect(function()
        local confirmUTSM = playerGui:FindFirstChild("ConfirmUTSM")
        if confirmUTSM then
            confirmUTSM.Enabled = not confirmUTSM.Enabled
            buttons[3].BackgroundColor3 = Color3.new(0.4, 0.2, 0.2)
            task.wait(0.1)
            buttons[3].BackgroundColor3 = Color3.new(0.15, 0.15, 0.15)
        end
    end)

    buttons[4].MouseButton1Click:Connect(function()
        local upgradeTVShop = playerGui:FindFirstChild("UpgradeTVShop")
        if upgradeTVShop then
            upgradeTVShop.Enabled = not upgradeTVShop.Enabled
            buttons[4].BackgroundColor3 = Color3.new(0.4, 0.2, 0.4)
            task.wait(0.1)
            buttons[4].BackgroundColor3 = Color3.new(0.15, 0.15, 0.15)
        end
    end)

    buttons[5].MouseButton1Click:Connect(function()
        local astroScrap = playerGui:FindFirstChild("AstroScrap")
        if astroScrap then astroScrap.Enabled = not astroScrap.Enabled end
        local astroItem = playerGui:FindFirstChild("AstroItem")
        if astroItem then astroItem.Enabled = not astroItem.Enabled end
        buttons[5].BackgroundColor3 = Color3.new(0.4, 0.3, 0.1)
        task.wait(0.1)
        buttons[5].BackgroundColor3 = Color3.new(0.15, 0.15, 0.15)
    end)

    buttons[6].MouseButton1Click:Connect(function()
        local astroTechUpgrade = playerGui:FindFirstChild("AstroTechUpgrade")
        if astroTechUpgrade then
            astroTechUpgrade.Enabled = not astroTechUpgrade.Enabled
            buttons[6].BackgroundColor3 = Color3.new(0.4, 0.3, 0.1)
            task.wait(0.1)
            buttons[6].BackgroundColor3 = Color3.new(0.15, 0.15, 0.15)
        end
    end)

    buttons[7].MouseButton1Click:Connect(function()
        local confirmDJToilet = playerGui:FindFirstChild("ConfirmDJToilet")
        if confirmDJToilet then
            confirmDJToilet.Enabled = not confirmDJToilet.Enabled
            local towerUI = confirmDJToilet:FindFirstChild("Tower-UI")
            if towerUI then
                towerUI.Position = UDim2.new(0.5, 0, 0.5, 0)
            end
            buttons[7].BackgroundColor3 = Color3.new(0.4, 0.1, 0.4)
            task.wait(0.1)
            buttons[7].BackgroundColor3 = Color3.new(0.15, 0.15, 0.15)
        end
    end)

    buttons[8].MouseButton1Click:Connect(function()
        local confirmCinema = playerGui:FindFirstChild("ConfirmCinema")
        if confirmCinema then
            confirmCinema.Enabled = not confirmCinema.Enabled
            local towerUI = confirmCinema:FindFirstChild("Tower-UI")
            if towerUI then
                towerUI.Position = UDim2.new(0.5, 0, 0.5, 0)
            end
            buttons[8].BackgroundColor3 = Color3.new(0.3, 0.1, 0.3)
            task.wait(0.1)
            buttons[8].BackgroundColor3 = Color3.new(0.15, 0.15, 0.15)
        end
    end)

    local authorLabel = Instance.new("TextLabel")
    authorLabel.Name = "AuthorLabel"
    authorLabel.Size = UDim2.new(1, 0, 0, 25)
    authorLabel.Position = UDim2.new(0, 0, 1, -25)
    authorLabel.BackgroundTransparency = 1
    authorLabel.Text = "脚本by白羽"
    authorLabel.TextColor3 = Color3.new(1, 0, 0)
    authorLabel.TextSize = uiParams.authorTextSize
    authorLabel.Font = Enum.Font.SourceSans
    authorLabel.TextXAlignment = Enum.TextXAlignment.Center
    authorLabel.Parent = mainFrame

    minimizeButton.MouseButton1Click:Connect(function()
        isMinimized = not isMinimized
        buttonContainer.Visible = not isMinimized
        authorLabel.Visible = not isMinimized
        mainFrame.Size = isMinimized and UDim2.new(uiParams.mainFrameSize.X.Scale, uiParams.mainFrameSize.X.Offset, 0, 50) or uiParams.mainFrameSize
    end)

    closeButton.MouseButton1Click:Connect(function()
        shouldRecreateUI = false
        screenGui:Destroy()
    end)
end

UserInputService.InputBegan:Connect(function(input)
    if not mainFrame then return end

    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        if isPointInFrame(input.Position, mainFrame) then
            isDragging = true
            dragStartPos = input.Position
            frameStartPos = mainFrame.Position
        end
    elseif input.UserInputType == Enum.UserInputType.Touch then
        if not activeTouchId and isPointInFrame(input.Position, mainFrame) then
            activeTouchId = input.TouchId
            isDragging = true
            dragStartPos = input.Position
            frameStartPos = mainFrame.Position
        end
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if not mainFrame or not isDragging then return end

    if input.UserInputType == Enum.UserInputType.MouseMovement then
        local delta = input.Position - dragStartPos
        mainFrame.Position = UDim2.new(
            frameStartPos.X.Scale, frameStartPos.X.Offset + delta.X,
            frameStartPos.Y.Scale, frameStartPos.Y.Offset + delta.Y
        )
        lastFramePosition = mainFrame.Position
    elseif input.UserInputType == Enum.UserInputType.Touch and input.TouchId == activeTouchId then
        local delta = input.Position - dragStartPos
        mainFrame.Position = UDim2.new(
            frameStartPos.X.Scale, frameStartPos.X.Offset + delta.X,
            frameStartPos.Y.Scale, frameStartPos.Y.Offset + delta.Y
        )
        lastFramePosition = mainFrame.Position
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

local function onCharacterAdded(character)
    character:WaitForChild("Humanoid")
    createGUI()
end

player.CharacterAdded:Connect(onCharacterAdded)
if player.Character then
    onCharacterAdded(player.Character)
end

createGUI()