-- LocalScript ULTIMATE MOBILE CHEAT GUI
-- Place dans StarterGui

local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoidRootPart = character:WaitForChild("HumanoidRootPart")
local humanoid = character:WaitForChild("Humanoid")
local mouse = player:GetMouse()
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Lighting = game:GetService("Lighting")

-- ==================== VARIABLES ====================
local settings = {
    flying = false,
    flySpeed = 50,
    noclipping = false,
    speedHack = false,
    walkSpeed = 100,
    jumpPower = 150,
    godMode = false,
    invisible = false,
    spinning = false,
    spinSpeed = 50,
    esp = false,
    fullbright = false,
    rainbow = false,
    antiTouchFling = false,
    clickTP = false,
    platform = false
}

local bodyVelocity, bodyGyro
local platformPart
local isMobile = UserInputService.TouchEnabled and not UserInputService.KeyboardEnabled

-- ==================== GUI CREATION ====================
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "MobileCheatGUI"
screenGui.ResetOnSpawn = false
screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
screenGui.Parent = player:WaitForChild("PlayerGui")

-- ==================== BOUTON FLOTTANT (FAB) ====================
local fabButton = Instance.new("ImageButton")
fabButton.Name = "FAB"
fabButton.Size = UDim2.new(0, 70, 0, 70)
fabButton.Position = UDim2.new(1, -90, 1, -90)
fabButton.BackgroundColor3 = Color3.fromRGB(255, 0, 150)
fabButton.BorderSizePixel = 0
fabButton.Image = "rbxassetid://3926305904"
fabButton.ImageRectOffset = Vector2.new(324, 364)
fabButton.ImageRectSize = Vector2.new(36, 36)
fabButton.ScaleType = Enum.ScaleType.Fit
fabButton.Active = true
fabButton.Draggable = true
fabButton.Parent = screenGui

local fabCorner = Instance.new("UICorner")
fabCorner.CornerRadius = UDim.new(1, 0)
fabCorner.Parent = fabButton

local fabShadow = Instance.new("ImageLabel")
fabShadow.Name = "Shadow"
fabShadow.Size = UDim2.new(1, 20, 1, 20)
fabShadow.Position = UDim2.new(0, -10, 0, -10)
fabShadow.BackgroundTransparency = 1
fabShadow.Image = "rbxasset://textures/ui/GuiImagePlaceholder.png"
fabShadow.ImageColor3 = Color3.fromRGB(0, 0, 0)
fabShadow.ImageTransparency = 0.5
fabShadow.ScaleType = Enum.ScaleType.Slice
fabShadow.SliceCenter = Rect.new(10, 10, 10, 10)
fabShadow.ZIndex = 0
fabShadow.Parent = fabButton

-- Gradient animé sur FAB
local fabGradient = Instance.new("UIGradient")
fabGradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 0, 150)),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(0, 200, 255)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(150, 0, 255))
}
fabGradient.Rotation = 45
fabGradient.Parent = fabButton

spawn(function()
    while wait(0.05) do
        if fabGradient then
            fabGradient.Rotation = fabGradient.Rotation + 2
        end
    end
end)

-- Pulse animation
spawn(function()
    while wait(1) do
        if fabButton then
            TweenService:Create(fabButton, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                Size = UDim2.new(0, 80, 0, 80)
            }):Play()
            wait(0.3)
            TweenService:Create(fabButton, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                Size = UDim2.new(0, 70, 0, 70)
            }):Play()
        end
    end
end)

-- ==================== MENU PRINCIPAL ====================
local mainFrame = Instance.new("Frame")
mainFrame.Name = "MainFrame"
mainFrame.Size = UDim2.new(0, 0, 0, 0)
mainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
mainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
mainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
mainFrame.BorderSizePixel = 0
mainFrame.Visible = false
mainFrame.ClipsDescendants = true
mainFrame.Parent = screenGui

local mainCorner = Instance.new("UICorner")
mainCorner.CornerRadius = UDim.new(0, 20)
mainCorner.Parent = mainFrame

-- ==================== TOP BAR ====================
local topBar = Instance.new("Frame")
topBar.Name = "TopBar"
topBar.Size = UDim2.new(1, 0, 0, 60)
topBar.BackgroundColor3 = Color3.fromRGB(255, 0, 150)
topBar.BorderSizePixel = 0
topBar.Parent = mainFrame

local topBarCorner = Instance.new("UICorner")
topBarCorner.CornerRadius = UDim.new(0, 20)
topBarCorner.Parent = topBar

local topBarGradient = Instance.new("UIGradient")
topBarGradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 0, 150)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(150, 0, 255))
}
topBarGradient.Rotation = 90
topBarGradient.Parent = topBar

local titleLabel = Instance.new("TextLabel")
titleLabel.Size = UDim2.new(1, -120, 1, 0)
titleLabel.Position = UDim2.new(0, 20, 0, 0)
titleLabel.BackgroundTransparency = 1
titleLabel.Text = "⚡ AI Hub"
titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
titleLabel.TextSize = 24
titleLabel.Font = Enum.Font.GothamBold
titleLabel.TextXAlignment = Enum.TextXAlignment.Left
titleLabel.Parent = topBar

local closeButton = Instance.new("TextButton")
closeButton.Size = UDim2.new(0, 50, 0, 50)
closeButton.Position = UDim2.new(1, -60, 0, 5)
closeButton.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
closeButton.BorderSizePixel = 0
closeButton.Text = "✕"
closeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
closeButton.TextSize = 28
closeButton.Font = Enum.Font.GothamBold
closeButton.Parent = topBar

local closeBtnCorner = Instance.new("UICorner")
closeBtnCorner.CornerRadius = UDim.new(1, 0)
closeBtnCorner.Parent = closeButton

-- ==================== TABS SYSTEM ====================
local tabContainer = Instance.new("Frame")
tabContainer.Name = "TabContainer"
tabContainer.Size = UDim2.new(1, 0, 0, 70)
tabContainer.Position = UDim2.new(0, 0, 0, 60)
tabContainer.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
tabContainer.BorderSizePixel = 0
tabContainer.Parent = mainFrame

local tabLayout = Instance.new("UIListLayout")
tabLayout.FillDirection = Enum.FillDirection.Horizontal
tabLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
tabLayout.VerticalAlignment = Enum.VerticalAlignment.Center
tabLayout.Padding = UDim.new(0, 10)
tabLayout.Parent = tabContainer

local currentTab = "Movement"

local function createTab(name, icon, order)
    local tab = Instance.new("TextButton")
    tab.Name = name .. "Tab"
    tab.Size = UDim2.new(0, 110, 0, 55)
    tab.BackgroundColor3 = name == currentTab and Color3.fromRGB(255, 0, 150) or Color3.fromRGB(40, 40, 40)
    tab.BorderSizePixel = 0
    tab.Text = icon .. "\n" .. name
    tab.TextColor3 = Color3.fromRGB(255, 255, 255)
    tab.TextSize = 16
    tab.Font = Enum.Font.GothamBold
    tab.LayoutOrder = order
    tab.Parent = tabContainer
    
    local tabCorner = Instance.new("UICorner")
    tabCorner.CornerRadius = UDim.new(0, 12)
    tabCorner.Parent = tab
    
    return tab
end

local movementTab = createTab("Movement", "🚀", 1)
local characterTab = createTab("Character", "👤", 2)
local visualTab = createTab("Visual", "👁️", 3)
local funTab = createTab("Fun", "🎮", 4)

-- ==================== CONTENT FRAME ====================
local contentFrame = Instance.new("ScrollingFrame")
contentFrame.Name = "ContentFrame"
contentFrame.Size = UDim2.new(1, -20, 1, -150)
contentFrame.Position = UDim2.new(0, 10, 0, 140)
contentFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
contentFrame.BorderSizePixel = 0
contentFrame.ScrollBarThickness = 10
contentFrame.ScrollBarImageColor3 = Color3.fromRGB(255, 0, 150)
contentFrame.ClipsDescendants = true
contentFrame.Parent = mainFrame

local contentLayout = Instance.new("UIListLayout")
contentLayout.Padding = UDim.new(0, 12)
contentLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
contentLayout.Parent = contentFrame

local contentPadding = Instance.new("UIPadding")
contentPadding.PaddingTop = UDim.new(0, 10)
contentPadding.PaddingBottom = UDim.new(0, 10)
contentPadding.Parent = contentFrame

-- ==================== FONCTION POUR CRÉER DES BOUTONS MOBILES ====================
local function createMobileButton(text, icon, callback)
    local button = Instance.new("TextButton")
    button.Size = UDim2.new(1, -20, 0, 70)
    button.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    button.BorderSizePixel = 0
    button.AutoButtonColor = false
    button.Parent = contentFrame
    
    local btnCorner = Instance.new("UICorner")
    btnCorner.CornerRadius = UDim.new(0, 15)
    btnCorner.Parent = button
    
    -- Conteneur pour l'icône
    local iconLabel = Instance.new("TextLabel")
    iconLabel.Size = UDim2.new(0, 60, 1, 0)
    iconLabel.Position = UDim2.new(0, 10, 0, 0)
    iconLabel.BackgroundTransparency = 1
    iconLabel.Text = icon
    iconLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    iconLabel.TextSize = 32
    iconLabel.Font = Enum.Font.GothamBold
    iconLabel.Parent = button
    
    -- Label du texte
    local textLabel = Instance.new("TextLabel")
    textLabel.Size = UDim2.new(1, -160, 1, 0)
    textLabel.Position = UDim2.new(0, 70, 0, 0)
    textLabel.BackgroundTransparency = 1
    textLabel.Text = text
    textLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    textLabel.TextSize = 18
    textLabel.Font = Enum.Font.GothamBold
    textLabel.TextXAlignment = Enum.TextXAlignment.Left
    textLabel.TextWrapped = true
    textLabel.Parent = button
    
    -- Indicateur ON/OFF
    local indicator = Instance.new("Frame")
    indicator.Size = UDim2.new(0, 60, 0, 35)
    indicator.Position = UDim2.new(1, -70, 0.5, -17.5)
    indicator.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    indicator.BorderSizePixel = 0
    indicator.Parent = button
    
    local indCorner = Instance.new("UICorner")
    indCorner.CornerRadius = UDim.new(1, 0)
    indCorner.Parent = indicator
    
    local indCircle = Instance.new("Frame")
    indCircle.Size = UDim2.new(0, 28, 0, 28)
    indCircle.Position = UDim2.new(0, 4, 0.5, -14)
    indCircle.BackgroundColor3 = Color3.fromRGB(200, 200, 200)
    indCircle.BorderSizePixel = 0
    indCircle.Parent = indicator
    
    local circleCorner = Instance.new("UICorner")
    circleCorner.CornerRadius = UDim.new(1, 0)
    circleCorner.Parent = indCircle
    
    local isActive = false
    
    -- Effet tactile
    button.MouseButton1Down:Connect(function()
        TweenService:Create(button, TweenInfo.new(0.1), {
            BackgroundColor3 = Color3.fromRGB(50, 50, 50)
        }):Play()
    end)
    
    button.MouseButton1Up:Connect(function()
        TweenService:Create(button, TweenInfo.new(0.1), {
            BackgroundColor3 = Color3.fromRGB(35, 35, 35)
        }):Play()
    end)
    
    button.MouseButton1Click:Connect(function()
        isActive = not isActive
        
        if isActive then
            -- Animation ON
            TweenService:Create(indicator, TweenInfo.new(0.3), {
                BackgroundColor3 = Color3.fromRGB(0, 255, 150)
            }):Play()
            TweenService:Create(indCircle, TweenInfo.new(0.3), {
                Position = UDim2.new(1, -32, 0.5, -14),
                BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            }):Play()
        else
            -- Animation OFF
            TweenService:Create(indicator, TweenInfo.new(0.3), {
                BackgroundColor3 = Color3.fromRGB(60, 60, 60)
            }):Play()
            TweenService:Create(indCircle, TweenInfo.new(0.3), {
                Position = UDim2.new(0, 4, 0.5, -14),
                BackgroundColor3 = Color3.fromRGB(200, 200, 200)
            }):Play()
        end
        
        callback(isActive)
    end)
    
    return button, indicator
end

local function createSliderButton(text, icon, minValue, maxValue, defaultValue, callback)
    local container = Instance.new("Frame")
    container.Size = UDim2.new(1, -20, 0, 100)
    container.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    container.BorderSizePixel = 0
    container.Parent = contentFrame
    
    local containerCorner = Instance.new("UICorner")
    containerCorner.CornerRadius = UDim.new(0, 15)
    containerCorner.Parent = container
    
    -- Header
    local header = Instance.new("Frame")
    header.Size = UDim2.new(1, 0, 0, 50)
    header.BackgroundTransparency = 1
    header.Parent = container
    
    local iconLabel = Instance.new("TextLabel")
    iconLabel.Size = UDim2.new(0, 50, 1, 0)
    iconLabel.Position = UDim2.new(0, 10, 0, 0)
    iconLabel.BackgroundTransparency = 1
    iconLabel.Text = icon
    iconLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    iconLabel.TextSize = 28
    iconLabel.Font = Enum.Font.GothamBold
    iconLabel.Parent = header
    
    local textLabel = Instance.new("TextLabel")
    textLabel.Size = UDim2.new(1, -140, 1, 0)
    textLabel.Position = UDim2.new(0, 60, 0, 0)
    textLabel.BackgroundTransparency = 1
    textLabel.Text = text
    textLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    textLabel.TextSize = 16
    textLabel.Font = Enum.Font.GothamBold
    textLabel.TextXAlignment = Enum.TextXAlignment.Left
    textLabel.Parent = header
    
    local valueLabel = Instance.new("TextLabel")
    valueLabel.Size = UDim2.new(0, 70, 1, 0)
    valueLabel.Position = UDim2.new(1, -75, 0, 0)
    valueLabel.BackgroundTransparency = 1
    valueLabel.Text = tostring(defaultValue)
    valueLabel.TextColor3 = Color3.fromRGB(0, 255, 150)
    valueLabel.TextSize = 20
    valueLabel.Font = Enum.Font.GothamBold
    valueLabel.Parent = header
    
    -- Slider
    local sliderBg = Instance.new("Frame")
    sliderBg.Size = UDim2.new(1, -30, 0, 20)
    sliderBg.Position = UDim2.new(0, 15, 0, 60)
    sliderBg.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    sliderBg.BorderSizePixel = 0
    sliderBg.Parent = container
    
    local sliderBgCorner = Instance.new("UICorner")
    sliderBgCorner.CornerRadius = UDim.new(1, 0)
    sliderBgCorner.Parent = sliderBg
    
    local sliderFill = Instance.new("Frame")
    sliderFill.Size = UDim2.new((defaultValue - minValue) / (maxValue - minValue), 0, 1, 0)
    sliderFill.BackgroundColor3 = Color3.fromRGB(255, 0, 150)
    sliderFill.BorderSizePixel = 0
    sliderFill.Parent = sliderBg
    
    local sliderFillCorner = Instance.new("UICorner")
    sliderFillCorner.CornerRadius = UDim.new(1, 0)
    sliderFillCorner.Parent = sliderFill
    
    local sliderButton = Instance.new("TextButton")
    sliderButton.Size = UDim2.new(0, 35, 0, 35)
    sliderButton.Position = UDim2.new((defaultValue - minValue) / (maxValue - minValue), -17.5, 0.5, -17.5)
    sliderButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    sliderButton.BorderSizePixel = 0
    sliderButton.Text = ""
    sliderButton.Parent = sliderBg
    
    local sliderBtnCorner = Instance.new("UICorner")
    sliderBtnCorner.CornerRadius = UDim.new(1, 0)
    sliderBtnCorner.Parent = sliderButton
    
    local dragging = false
    local currentValue = defaultValue
    
    sliderButton.MouseButton1Down:Connect(function()
        dragging = true
    end)
    
    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = false
        end
    end)
    
    RunService.RenderStepped:Connect(function()
        if dragging then
            local mousePos
            if isMobile then
                local touches = UserInputService:GetTouchPositions()
                if #touches > 0 then
                    mousePos = touches[1].X
                end
            else
                mousePos = UserInputService:GetMouseLocation().X
            end
            
            if mousePos then
                local sliderPos = sliderBg.AbsolutePosition.X
                local sliderSize = sliderBg.AbsoluteSize.X
                local percentage = math.clamp((mousePos - sliderPos) / sliderSize, 0, 1)
                
                currentValue = math.floor(minValue + (percentage * (maxValue - minValue)))
                valueLabel.Text = tostring(currentValue)
                
                TweenService:Create(sliderButton, TweenInfo.new(0.1), {
                    Position = UDim2.new(percentage, -17.5, 0.5, -17.5)
                }):Play()
                
                TweenService:Create(sliderFill, TweenInfo.new(0.1), {
                    Size = UDim2.new(percentage, 0, 1, 0)
                }):Play()
                
                callback(currentValue)
            end
        end
    end)
    
    return container
end

-- ==================== NOTIFICATION SYSTEM ====================
local notifContainer = Instance.new("Frame")
notifContainer.Name = "NotificationContainer"
notifContainer.Size = UDim2.new(0, 300, 0, 100)
notifContainer.Position = UDim2.new(0.5, -150, 0, -120)
notifContainer.BackgroundTransparency = 1
notifContainer.Parent = screenGui

local function notify(text, color)
    local notif = Instance.new("Frame")
    notif.Size = UDim2.new(1, 0, 0, 60)
    notif.Position = UDim2.new(0, 0, 0, 0)
    notif.BackgroundColor3 = color or Color3.fromRGB(255, 0, 150)
    notif.BorderSizePixel = 0
    notif.Parent = notifContainer
    
    local notifCorner = Instance.new("UICorner")
    notifCorner.CornerRadius = UDim.new(0, 15)
    notifCorner.Parent = notif
    
    local notifText = Instance.new("TextLabel")
    notifText.Size = UDim2.new(1, -20, 1, 0)
    notifText.Position = UDim2.new(0, 10, 0, 0)
    notifText.BackgroundTransparency = 1
    notifText.Text = text
    notifText.TextColor3 = Color3.fromRGB(255, 255, 255)
    notifText.TextSize = 16
    notifText.Font = Enum.Font.GothamBold
    notifText.TextWrapped = true
    notifText.Parent = notif
    
    -- Animation entrée
    notif.Position = UDim2.new(0, 0, 0, -70)
    TweenService:Create(notif, TweenInfo.new(0.5, Enum.EasingStyle.Back), {
        Position = UDim2.new(0, 0, 0, 0)
    }):Play()
    
    -- Animation sortie
    wait(2)
    TweenService:Create(notif, TweenInfo.new(0.3), {
        Position = UDim2.new(0, 0, 0, -70)
    }):Play()
    wait(0.3)
    notif:Destroy()
end

-- ==================== TAB SWITCHING ====================
local function switchTab(tabName)
    currentTab = tabName
    
    -- Update tab colors
    for _, tab in pairs(tabContainer:GetChildren()) do
        if tab:IsA("TextButton") then
            if tab.Name == tabName .. "Tab" then
                TweenService:Create(tab, TweenInfo.new(0.3), {
                    BackgroundColor3 = Color3.fromRGB(255, 0, 150)
                }):Play()
            else
                TweenService:Create(tab, TweenInfo.new(0.3), {
                    BackgroundColor3 = Color3.fromRGB(40, 40, 40)
                }):Play()
            end
        end
    end
    
    -- Clear content
    for _, child in pairs(contentFrame:GetChildren()) do
        if not child:IsA("UIListLayout") and not child:IsA("UIPadding") then
            child:Destroy()
        end
    end
    
    -- Load tab content
    if tabName == "Movement" then
        loadMovementTab()
    elseif tabName == "Character" then
        loadCharacterTab()
    elseif tabName == "Visual" then
        loadVisualTab()
    elseif tabName == "Fun" then
        loadFunTab()
    end
    
    -- Update canvas size
    contentFrame.CanvasSize = UDim2.new(0, 0, 0, contentLayout.AbsoluteContentSize.Y + 20)
end

movementTab.MouseButton1Click:Connect(function() switchTab("Movement") end)
characterTab.MouseButton1Click:Connect(function() switchTab("Character") end)
visualTab.MouseButton1Click:Connect(function() switchTab("Visual") end)
funTab.MouseButton1Click:Connect(function() switchTab("Fun") end)

-- ==================== MOVEMENT TAB ====================
function loadMovementTab()
    -- FLY
    createMobileButton("Fly Mode", "✈️", function(active)
        settings.flying = active
        
        if active then
            notify("Fly Mode: ON", Color3.fromRGB(0, 255, 150))
            
            bodyVelocity = Instance.new("BodyVelocity")
            bodyVelocity.Velocity = Vector3.new(0, 0, 0)
            bodyVelocity.MaxForce = Vector3.new(9e9, 9e9, 9e9)
            bodyVelocity.Parent = humanoidRootPart
            
            bodyGyro = Instance.new("BodyGyro")
            bodyGyro.MaxTorque = Vector3.new(9e9, 9e9, 9e9)
            bodyGyro.P = 9e4
            bodyGyro.Parent = humanoidRootPart
            
            spawn(function()
                while settings.flying do
                    local camera = workspace.CurrentCamera
                    local direction = Vector3.new(0, 0, 0)
                    
                    if UserInputService:IsKeyDown(Enum.KeyCode.W) then
                        direction = direction + (camera.CFrame.LookVector * settings.flySpeed)
                    end
                    if UserInputService:IsKeyDown(Enum.KeyCode.S) then
                        direction = direction - (camera.CFrame.LookVector * settings.flySpeed)
                    end
                    if UserInputService:IsKeyDown(Enum.KeyCode.A) then
                        direction = direction - (camera.CFrame.RightVector * settings.flySpeed)
                    end
                    if UserInputService:IsKeyDown(Enum.KeyCode.D) then
                        direction = direction + (camera.CFrame.RightVector * settings.flySpeed)
                    end
                    
                    -- Mobile touch controls
                    if isMobile then
                        local moveVector = humanoid.MoveVector
                        if moveVector.Magnitude > 0 then
                            direction = camera.CFrame:VectorToWorldSpace(moveVector) * settings.flySpeed
                        end
                    end
                    
                    if bodyVelocity then
                        bodyVelocity.Velocity = direction
                    end
                    if bodyGyro then
                        bodyGyro.CFrame = camera.CFrame
                    end
                    
                    wait()
                end
            end)
        else
            notify("Fly Mode: OFF", Color3.fromRGB(255, 100, 100))
            
            if bodyVelocity then bodyVelocity:Destroy() end
            if bodyGyro then bodyGyro:Destroy() end
        end
    end)
    
    -- FLY SPEED SLIDER
    createSliderButton("Fly Speed", "⚡", 10, 200, 50, function(value)
        settings.flySpeed = value
    end)
    
    -- SPEED HACK
    createMobileButton("Speed Hack", "🏃", function(active)
        settings.speedHack = active
        
        if active then
            humanoid.WalkSpeed = settings.walkSpeed
            notify("Speed Hack: ON", Color3.fromRGB(0, 255, 150))
        else
            humanoid.WalkSpeed = 16
            notify("Speed Hack: OFF", Color3.fromRGB(255, 100, 100))
        end
    end)
    
    -- WALK SPEED SLIDER
    createSliderButton("Walk Speed", "🏃", 16, 200, 100, function(value)
        settings.walkSpeed = value
        if settings.speedHack then
            humanoid.WalkSpeed = value
        end
    end)
    
    -- SUPER JUMP
    createMobileButton("Super Jump", "🚀", function(active)
        if active then
            humanoid.JumpPower = settings.jumpPower
            notify("Super Jump: ON", Color3.fromRGB(0, 255, 150))
        else
            humanoid.JumpPower = 50
            notify("Super Jump: OFF", Color3.fromRGB(255, 100, 100))
        end
    end)
    
    -- JUMP POWER SLIDER
    createSliderButton("Jump Power", "🚀", 50, 300, 150, function(value)
        settings.jumpPower = value
        if humanoid.JumpPower ~= 50 then
            humanoid.JumpPower = value
        end
    end)
    
    -- NOCLIP
    createMobileButton("Noclip", "👻", function(active)
        settings.noclipping = active
        
        if active then
            notify("Noclip: ON", Color3.fromRGB(0, 255, 150))
            
            spawn(function()
                while settings.noclipping do
                    if character then
                        for _, part in pairs(character:GetDescendants()) do
                            if part:IsA("BasePart") then
                                part.CanCollide = false
                            end
                        end
                    end
                    wait(0.1)
                end
            end)
        else
            notify("Noclip: OFF", Color3.fromRGB(255, 100, 100))
            
            if character then
                for _, part in pairs(character:GetDescendants()) do
                    if part:IsA("BasePart") and part.Name ~= "HumanoidRootPart" then
                        part.CanCollide = true
                    end
                end
            end
        end
    end)
    
    -- INFINITE JUMP
    createMobileButton("Infinite Jump", "♾️", function(active)
        settings.infiniteJump = active
        
        if active then
            notify("Infinite Jump: ON", Color3.fromRGB(0, 255, 150))
        else
            notify("Infinite Jump: OFF", Color3.fromRGB(255, 100, 100))
        end
    end)
    
    UserInputService.JumpRequest:Connect(function()
        if settings.infiniteJump and humanoid then
            humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
        end
    end)
    
    -- PLATFORM
    createMobileButton("Spawn Platform", "🟦", function(active)
        settings.platform = active
        
        if active then
            notify("Platform: Spawned", Color3.fromRGB(0, 255, 150))
            
            platformPart = Instance.new("Part")
            platformPart.Size = Vector3.new(10, 1, 10)
            platformPart.Anchored = true
            platformPart.Transparency = 0.5
            platformPart.BrickColor = BrickColor.new("Bright blue")
            platformPart.Material = Enum.Material.Neon
            platformPart.Parent = workspace
            
            spawn(function()
                while settings.platform and platformPart do
                    platformPart.CFrame = humanoidRootPart.CFrame * CFrame.new(0, -3.5, 0)
                    wait()
                end
            end)
        else
            notify("Platform: Removed", Color3.fromRGB(255, 100, 100))
            
            if platformPart then
                platformPart:Destroy()
                platformPart = nil
            end
        end
    end)
    
    contentFrame.CanvasSize = UDim2.new(0, 0, 0, contentLayout.AbsoluteContentSize.Y + 20)
end

-- ==================== CHARACTER TAB ====================
function loadCharacterTab()
    -- GOD MODE
    createMobileButton("God Mode", "🛡️", function(active)
        settings.godMode = active
        
        if active then
            humanoid.MaxHealth = math.huge
            humanoid.Health = math.huge
            notify("God Mode: Immortal", Color3.fromRGB(0, 255, 150))
        else
            humanoid.MaxHealth = 100
            humanoid.Health = 100
            notify("God Mode: OFF", Color3.fromRGB(255, 100, 100))
        end
    end)
    
    -- INVISIBLE
    createMobileButton("Invisibility", "👁️", function(active)
        settings.invisible = active
        
        if active then
            for _, part in pairs(character:GetDescendants()) do
                if part:IsA("BasePart") then
                    part.Transparency = 1
                elseif part:IsA("Decal") or part:IsA("Texture") then
                    part.Transparency = 1
                end
            end
            notify("Invisibility: Stealth", Color3.fromRGB(0, 255, 150))
        else
            for _, part in pairs(character:GetDescendants()) do
                if part:IsA("BasePart") and part.Name ~= "HumanoidRootPart" then
                    part.Transparency = 0
                elseif part:IsA("Decal") or part:IsA("Texture") then
                    part.Transparency = 0
                end
            end
            notify("Invisibility: Visible", Color3.fromRGB(255, 100, 100))
        end
    end)
    
    -- SPIN HACK
    createMobileButton("Spin Hack", "🌀", function(active)
        settings.spinning = active
        
        if active then
            notify("Spin Hack: ON", Color3.fromRGB(0, 255, 150))
            
            local spinBodyGyro = Instance.new("BodyGyro")
            spinBodyGyro.MaxTorque = Vector3.new(0, 9e9, 0)
            spinBodyGyro.P = 9e4
            spinBodyGyro.Parent = humanoidRootPart
            
            spawn(function()
                while settings.spinning do
                    if spinBodyGyro then
                        spinBodyGyro.CFrame = spinBodyGyro.CFrame * CFrame.Angles(0, math.rad(settings.spinSpeed), 0)
                    end
                    wait()
                end
                if spinBodyGyro then
                    spinBodyGyro:Destroy()
                end
            end)
        else
            notify("Spin Hack: Stopped", Color3.fromRGB(255, 100, 100))
            settings.spinning = false
        end
    end)
    
    -- SPIN SPEED SLIDER
    createSliderButton("Spin Speed", "🌀", 10, 100, 50, function(value)
        settings.spinSpeed = value
    end)
    
    -- RAINBOW
    createMobileButton("Rainbow Mode", "🌈", function(active)
        settings.rainbow = active
        
        if active then
            notify("Rainbow Mode: ON", Color3.fromRGB(0, 255, 150))
            
            spawn(function()
                while settings.rainbow do
                    if character then
                        for _, part in pairs(character:GetChildren()) do
                            if part:IsA("BasePart") then
                                part.BrickColor = BrickColor.Random()
                            end
                        end
                    end
                    wait(0.2)
                end
            end)
        else
            notify("Rainbow Mode: OFF", Color3.fromRGB(255, 100, 100))
        end
    end)
    
    -- BIG HEAD
    createMobileButton("Big Head Mode", "🤯", function(active)
        if active and character:FindFirstChild("Head") then
            character.Head.Size = Vector3.new(10, 10, 10)
            notify("Big Head: ON", Color3.fromRGB(0, 255, 150))
        else
            if character:FindFirstChild("Head") then
                character.Head.Size = Vector3.new(2, 1, 1)
            end
            notify("Big Head: OFF", Color3.fromRGB(255, 100, 100))
        end
    end)
    
    -- RESET
    createMobileButton("Reset Character", "🔄", function(active)
        if humanoid then
            humanoid.Health = 0
            notify("Character Reset", Color3.fromRGB(255, 50, 50))
        end
    end)
    
    contentFrame.CanvasSize = UDim2.new(0, 0, 0, contentLayout.AbsoluteContentSize.Y + 20)
end

-- ==================== VISUAL TAB ====================
function loadVisualTab()
    -- ESP
    createMobileButton("ESP Wallhack", "📡", function(active)
        settings.esp = active
        
        if active then
            notify("ESP: Tracking", Color3.fromRGB(0, 255, 150))
            
            for _, otherPlayer in pairs(Players:GetPlayers()) do
                if otherPlayer ~= player and otherPlayer.Character then
                    local highlight = Instance.new("Highlight")
                    highlight.Name = "ESPHighlight"
                    highlight.Adornee = otherPlayer.Character
                    highlight.FillColor = Color3.fromRGB(255, 0, 0)
                    highlight.OutlineColor = Color3.fromRGB(255, 255, 0)
                    highlight.FillTransparency = 0.5
                    highlight.OutlineTransparency = 0
                    highlight.Parent = otherPlayer.Character
                end
            end
        else
            notify("ESP: OFF", Color3.fromRGB(255, 100, 100))
            
            for _, otherPlayer in pairs(Players:GetPlayers()) do
                if otherPlayer.Character then
                    for _, obj in pairs(otherPlayer.Character:GetDescendants()) do
                        if obj.Name == "ESPHighlight" then
                            obj:Destroy()
                        end
                    end
                end
            end
        end
    end)
    
    -- FULLBRIGHT
    createMobileButton("Fullbright", "💡", function(active)
        settings.fullbright = active
        
        if active then
            Lighting.Brightness = 2
            Lighting.ClockTime = 14
            Lighting.FogEnd = 100000
            Lighting.GlobalShadows = false
            Lighting.OutdoorAmbient = Color3.fromRGB(128, 128, 128)
            notify("Fullbright: ON", Color3.fromRGB(0, 255, 150))
        else
            Lighting.Brightness = 1
            Lighting.ClockTime = 12
            Lighting.FogEnd = 10000
            Lighting.GlobalShadows = true
            Lighting.OutdoorAmbient = Color3.fromRGB(70, 70, 70)
            notify("Fullbright: OFF", Color3.fromRGB(255, 100, 100))
        end
    end)
    
    -- FOV CHANGER
    createSliderButton("FOV Changer", "🎥", 70, 120, 70, function(value)
        workspace.CurrentCamera.FieldOfView = value
    end)
    
    contentFrame.CanvasSize = UDim2.new(0, 0, 0, contentLayout.AbsoluteContentSize.Y + 20)
end

-- ==================== FUN TAB ====================
function loadFunTab()
    -- CLICK TP
    createMobileButton("Click Teleport", "🎯", function(active)
        settings.clickTP = active
        
        if active then
            notify("Click TP: Active - Tap screen!", Color3.fromRGB(0, 255, 150))
        else
            notify("Click TP: OFF", Color3.fromRGB(255, 100, 100))
        end
    end)
    
    -- EXPLOSION
    createMobileButton("Explosion Effect", "💥", function(active)
        if humanoidRootPart then
            local explosion = Instance.new("Explosion")
            explosion.Position = humanoidRootPart.Position
            explosion.BlastRadius = 20
            explosion.BlastPressure = 500000
            explosion.Parent = workspace
            notify("BOOM!", Color3.fromRGB(255, 100, 0))
        end
    end)
    
    -- ANTI-TOUCH FLING
    createMobileButton("Anti-Touch Fling", "⚡", function(active)
        settings.antiTouchFling = active
        
        if active then
            notify("Anti-Touch: ON", Color3.fromRGB(0, 255, 150))
            
            for _, part in pairs(character:GetDescendants()) do
                if part:IsA("BasePart") then
                    part.Touched:Connect(function(hit)
                        if not settings.antiTouchFling then return end
                        
                        local otherPlayer = Players:GetPlayerFromCharacter(hit.Parent)
                        if otherPlayer and otherPlayer ~= player and otherPlayer.Character then
                            local otherHRP = otherPlayer.Character:FindFirstChild("HumanoidRootPart")
                            if otherHRP then
                                local direction = (otherHRP.Position - humanoidRootPart.Position).Unit
                                otherHRP.AssemblyLinearVelocity = Vector3.new(
                                    direction.X * 100000,
                                    50000,
                                    direction.Z * 100000
                                )
                            end
                        end
                    end)
                end
            end
        else
            notify("Anti-Touch: OFF", Color3.fromRGB(255, 100, 100))
        end
    end)
    
    -- REJOIN
    createMobileButton("Rejoin Server", "🔄", function(active)
        game:GetService("TeleportService"):Teleport(game.PlaceId, player)
    end)
    
    contentFrame.CanvasSize = UDim2.new(0, 0, 0, contentLayout.AbsoluteContentSize.Y + 20)
end

-- ==================== CLICK TP POUR MOBILE ====================
UserInputService.TouchTap:Connect(function(touchPositions, gameProcessed)
    if settings.clickTP and not gameProcessed then
        local camera = workspace.CurrentCamera
        local unitRay = camera:ScreenPointToRay(touchPositions[1].X, touchPositions[1].Y)
        local ray = Ray.new(unitRay.Origin, unitRay.Direction * 1000)
        local hitPart, hitPosition = workspace:FindPartOnRay(ray, character)
        
        if hitPosition and humanoidRootPart then
            humanoidRootPart.CFrame = CFrame.new(hitPosition + Vector3.new(0, 3, 0))
            notify("Teleported!", Color3.fromRGB(0, 255, 150))
        end
    end
end)

-- ==================== FAB BUTTON ACTION ====================
fabButton.MouseButton1Click:Connect(function()
    mainFrame.Visible = not mainFrame.Visible
    
    if mainFrame.Visible then
        -- Open animation
        mainFrame.Size = UDim2.new(0, 0, 0, 0)
        TweenService:Create(mainFrame, TweenInfo.new(0.4, Enum.EasingStyle.Back), {
            Size = UDim2.new(0.9, 0, 0.8, 0)
        }):Play()
        
        -- Load default tab
        switchTab("Movement")
    else
        -- Close animation
        TweenService:Create(mainFrame, TweenInfo.new(0.3), {
            Size = UDim2.new(0, 0, 0, 0)
        }):Play()
    end
end)

closeButton.MouseButton1Click:Connect(function()
    TweenService:Create(mainFrame, TweenInfo.new(0.3), {
        Size = UDim2.new(0, 0, 0, 0)
    }):Play()
    wait(0.3)
    mainFrame.Visible = false
end)

-- ==================== CHARACTER RESPAWN ====================
player.CharacterAdded:Connect(function(newChar)
    character = newChar
    humanoidRootPart = newChar:WaitForChild("HumanoidRootPart")
    humanoid = newChar:WaitForChild("Humanoid")
    
    wait(1)
    
    -- Reapply active settings
    if settings.speedHack then
        humanoid.WalkSpeed = settings.walkSpeed
    end
    if settings.godMode then
        humanoid.MaxHealth = math.huge
        humanoid.Health = math.huge
    end
end)

-- ==================== INTRO ANIMATION ====================
wait(0.5)
notify("🎮 MOBILE CHEAT HUB LOADED!", Color3.fromRGB(0, 255, 150))
print("✅ Ultimate Mobile Cheat GUI loaded! Tap the floating button to open!")
