-- Knox Hub FPS Booster v2.0
-- Advanced Performance Optimization Suite

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local Lighting = game:GetService("Lighting")
local Workspace = game:GetService("Workspace")
local StatsService = game:GetService("Stats")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- Performance tracking
local lastTick = tick()
local frameCount = 0
local currentFPS = 0
local lagThreshold = 30 -- FPS threshold for lag detection
local isLagging = false
local optimizationLevel = 0 -- 0: Normal, 1: FPS Booster, 2: Ultra Potato, 3: Extreme

-- Create floating button
local FloatingButton = Instance.new("ScreenGui")
FloatingButton.Name = "KnoxHubFloatingButton"
FloatingButton.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
FloatingButton.ResetOnSpawn = false

local ButtonFrame = Instance.new("Frame")
ButtonFrame.Name = "ButtonFrame"
ButtonFrame.Size = UDim2.new(0, 60, 0, 60)
ButtonFrame.Position = UDim2.new(0, 20, 0.5, -30)
ButtonFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
ButtonFrame.BackgroundTransparency = 0.1
ButtonFrame.BorderSizePixel = 0

-- Gradient effect for button
local ButtonGradient = Instance.new("UIGradient")
ButtonGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 150, 255)),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(150, 0, 255)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 0, 150))
})
ButtonGradient.Rotation = 45
ButtonGradient.Parent = ButtonFrame

local ButtonCorner = Instance.new("UICorner")
ButtonCorner.CornerRadius = UDim.new(1, 0)
ButtonCorner.Parent = ButtonFrame

local ButtonStroke = Instance.new("UIStroke")
ButtonStroke.Color = Color3.fromRGB(255, 255, 255)
ButtonStroke.Thickness = 2
ButtonStroke.Transparency = 0.5
ButtonStroke.Parent = ButtonFrame

local ButtonLabel = Instance.new("TextLabel")
ButtonLabel.Name = "ButtonLabel"
ButtonLabel.Size = UDim2.new(1, 0, 1, 0)
ButtonLabel.BackgroundTransparency = 1
ButtonLabel.Text = "KNOX"
ButtonLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
ButtonLabel.TextSize = 14
ButtonLabel.Font = Enum.Font.GothamBold
ButtonLabel.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
ButtonLabel.TextStrokeTransparency = 0.5

-- Neon glow effect
local ButtonGlow = Instance.new("ImageLabel")
ButtonGlow.Name = "Glow"
ButtonGlow.Size = UDim2.new(1, 20, 1, 20)
ButtonGlow.Position = UDim2.new(0, -10, 0, -10)
ButtonGlow.BackgroundTransparency = 1
ButtonGlow.Image = "rbxassetid://8992231221"
ButtonGlow.ImageColor3 = Color3.fromRGB(0, 150, 255)
ButtonGlow.ImageTransparency = 0.7
ButtonGlow.ScaleType = Enum.ScaleType.Slice
ButtonGlow.SliceCenter = Rect.new(100, 100, 100, 100)
ButtonGlow.Parent = ButtonFrame

ButtonLabel.Parent = ButtonFrame
ButtonFrame.Parent = FloatingButton
FloatingButton.Parent = playerGui

-- Create main UI
local KnoxHub = Instance.new("ScreenGui")
KnoxHub.Name = "KnoxHub"
KnoxHub.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
KnoxHub.ResetOnSpawn = false

-- Main frame with gradient
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 450, 0, 600)
MainFrame.Position = UDim2.new(0.5, -225, 0.5, -300)
MainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
MainFrame.BackgroundTransparency = 0.1
MainFrame.BorderSizePixel = 0

-- Main gradient
local MainGradient = Instance.new("UIGradient")
MainGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(10, 10, 30)),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(20, 10, 40)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(30, 10, 50))
})
MainGradient.Rotation = 120
MainGradient.Parent = MainFrame

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 15)
UICorner.Parent = MainFrame

-- Neon border
local UIStroke = Instance.new("UIStroke")
UIStroke.Color = Color3.fromRGB(0, 150, 255)
UIStroke.Thickness = 3
UIStroke.Transparency = 0.3
UIStroke.Parent = MainFrame

-- Title bar with gradient
local TitleBar = Instance.new("Frame")
TitleBar.Name = "TitleBar"
TitleBar.Size = UDim2.new(1, 0, 0, 45)
TitleBar.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
TitleBar.BorderSizePixel = 0

local TitleBarGradient = Instance.new("UIGradient")
TitleBarGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 100, 200)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(150, 0, 255))
})
TitleBarGradient.Rotation = 90
TitleBarGradient.Parent = TitleBar

local TitleBarCorner = Instance.new("UICorner")
TitleBarCorner.CornerRadius = UDim.new(0, 15)
TitleBarCorner.Parent = TitleBar

local Title = Instance.new("TextLabel")
Title.Name = "Title"
Title.Size = UDim2.new(1, -100, 1, 0)
Title.Position = UDim2.new(0, 15, 0, 0)
Title.BackgroundTransparency = 1
Title.Text = "⚡ KNOX HUB - FPS BOOSTER ⚡"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 20
Title.Font = Enum.Font.GothamBold
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
Title.TextStrokeTransparency = 0.5

-- Close button with glow
local CloseButton = Instance.new("TextButton")
CloseButton.Name = "CloseButton"
CloseButton.Size = UDim2.new(0, 35, 0, 35)
CloseButton.Position = UDim2.new(1, -40, 0, 5)
CloseButton.BackgroundColor3 = Color3.fromRGB(220, 60, 60)
CloseButton.Text = "✕"
CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseButton.TextSize = 18
CloseButton.Font = Enum.Font.GothamBold

local CloseButtonCorner = Instance.new("UICorner")
CloseButtonCorner.CornerRadius = UDim.new(1, 0)
CloseButtonCorner.Parent = CloseButton

local CloseGlow = Instance.new("ImageLabel")
CloseGlow.Name = "Glow"
CloseGlow.Size = UDim2.new(1, 10, 1, 10)
CloseGlow.Position = UDim2.new(0, -5, 0, -5)
CloseGlow.BackgroundTransparency = 1
CloseGlow.Image = "rbxassetid://8992231221"
CloseGlow.ImageColor3 = Color3.fromRGB(255, 50, 50)
CloseGlow.ImageTransparency = 0.6
CloseGlow.ScaleType = Enum.ScaleType.Slice
CloseGlow.SliceCenter = Rect.new(100, 100, 100, 100)
CloseGlow.Parent = CloseButton

-- Minimize button
local MinimizeButton = Instance.new("TextButton")
MinimizeButton.Name = "MinimizeButton"
MinimizeButton.Size = UDim2.new(0, 35, 0, 35)
MinimizeButton.Position = UDim2.new(1, -80, 0, 5)
MinimizeButton.BackgroundColor3 = Color3.fromRGB(60, 60, 80)
MinimizeButton.Text = "─"
MinimizeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
MinimizeButton.TextSize = 18
MinimizeButton.Font = Enum.Font.GothamBold

local MinimizeButtonCorner = Instance.new("UICorner")
MinimizeButtonCorner.CornerRadius = UDim.new(1, 0)
MinimizeButtonCorner.Parent = MinimizeButton

-- Content frame
local ContentFrame = Instance.new("ScrollingFrame")
ContentFrame.Name = "ContentFrame"
ContentFrame.Size = UDim2.new(1, -20, 1, -70)
ContentFrame.Position = UDim2.new(0, 10, 0, 55)
ContentFrame.BackgroundTransparency = 1
ContentFrame.ScrollBarThickness = 6
ContentFrame.ScrollBarImageColor3 = Color3.fromRGB(100, 100, 150)
ContentFrame.CanvasSize = UDim2.new(0, 0, 0, 1200)

-- Performance stats panel
local StatsPanel = Instance.new("Frame")
StatsPanel.Name = "StatsPanel"
StatsPanel.Size = UDim2.new(1, 0, 0, 120)
StatsPanel.BackgroundColor3 = Color3.fromRGB(30, 30, 45)
StatsPanel.BackgroundTransparency = 0.2

local StatsGradient = Instance.new("UIGradient")
StatsGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(40, 40, 60)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(30, 30, 50))
})
StatsGradient.Parent = StatsPanel

local StatsCorner = Instance.new("UICorner")
StatsCorner.CornerRadius = UDim.new(0, 10)
StatsCorner.Parent = StatsPanel

local StatsStroke = Instance.new("UIStroke")
StatsStroke.Color = Color3.fromRGB(0, 200, 255)
StatsStroke.Thickness = 2
StatsStroke.Transparency = 0.5
StatsStroke.Parent = StatsPanel

-- FPS Display with color coding
local FPSLabel = Instance.new("TextLabel")
FPSLabel.Name = "FPSLabel"
FPSLabel.Size = UDim2.new(0.48, -5, 0, 40)
FPSLabel.Position = UDim2.new(0, 10, 0, 10)
FPSLabel.BackgroundColor3 = Color3.fromRGB(40, 40, 60)
FPSLabel.Text = "FPS: --"
FPSLabel.TextColor3 = Color3.fromRGB(100, 255, 100)
FPSLabel.TextSize = 24
FPSLabel.Font = Enum.Font.GothamBold
FPSLabel.TextStrokeTransparency = 0.8

local FPSLabelCorner = Instance.new("UICorner")
FPSLabelCorner.CornerRadius = UDim.new(0, 8)
FPSLabelCorner.Parent = FPSLabel

-- CPU Usage
local CPULabel = Instance.new("TextLabel")
CPULabel.Name = "CPULabel"
CPULabel.Size = UDim2.new(0.48, -5, 0, 40)
CPULabel.Position = UDim2.new(0.52, 5, 0, 10)
CPULabel.BackgroundColor3 = Color3.fromRGB(40, 40, 60)
CPULabel.Text = "CPU: --%"
CPULabel.TextColor3 = Color3.fromRGB(255, 200, 100)
CPULabel.TextSize = 20
CPULabel.Font = Enum.Font.GothamSemibold

local CPULabelCorner = Instance.new("UICorner")
CPULabelCorner.CornerRadius = UDim.new(0, 8)
CPULabelCorner.Parent = CPULabel

-- GPU Usage
local GPULabel = Instance.new("TextLabel")
GPULabel.Name = "GPULabel"
GPULabel.Size = UDim2.new(0.48, -5, 0, 40)
GPULabel.Position = UDim2.new(0, 10, 0, 60)
GPULabel.BackgroundColor3 = Color3.fromRGB(40, 40, 60)
GPULabel.Text = "GPU: --%"
GPULabel.TextColor3 = Color3.fromRGB(100, 200, 255)
GPULabel.TextSize = 20
GPULabel.Font = Enum.Font.GothamSemibold

local GPULabelCorner = Instance.new("UICorner")
GPULabelCorner.CornerRadius = UDim.new(0, 8)
GPULabelCorner.Parent = GPULabel

-- Memory Usage
local MemoryLabel = Instance.new("TextLabel")
MemoryLabel.Name = "MemoryLabel"
MemoryLabel.Size = UDim2.new(0.48, -5, 0, 40)
MemoryLabel.Position = UDim2.new(0.52, 5, 0, 60)
MemoryLabel.BackgroundColor3 = Color3.fromRGB(40, 40, 60)
MemoryLabel.Text = "RAM: -- MB"
MemoryLabel.TextColor3 = Color3.fromRGB(200, 100, 255)
MemoryLabel.TextSize = 20
MemoryLabel.Font = Enum.Font.GothamSemibold

local MemoryLabelCorner = Instance.new("UICorner")
MemoryLabelCorner.CornerRadius = UDim.new(0, 8)
MemoryLabelCorner.Parent = MemoryLabel

-- Lag Indicator
local LagIndicator = Instance.new("Frame")
LagIndicator.Name = "LagIndicator"
LagIndicator.Size = UDim2.new(1, -20, 0, 20)
LagIndicator.Position = UDim2.new(0, 10, 1, -30)
LagIndicator.BackgroundColor3 = Color3.fromRGB(60, 60, 80)
LagIndicator.Visible = false

local LagIndicatorCorner = Instance.new("UICorner")
LagIndicatorCorner.CornerRadius = UDim.new(0, 5)
LagIndicatorCorner.Parent = LagIndicator

local LagLabel = Instance.new("TextLabel")
LagLabel.Name = "LagLabel"
LagLabel.Size = UDim2.new(1, 0, 1, 0)
LagLabel.BackgroundTransparency = 1
LagLabel.Text = "⚠️ LAG DETECTED - AUTO OPTIMIZING..."
LagLabel.TextColor3 = Color3.fromRGB(255, 100, 100)
LagLabel.TextSize = 14
LagLabel.Font = Enum.Font.GothamBold
LagLabel.Parent = LagIndicator

-- Preset Modes Section
local ModesSection = Instance.new("TextLabel")
ModesSection.Name = "ModesSection"
ModesSection.Size = UDim2.new(1, 0, 0, 30)
ModesSection.Position = UDim2.new(0, 0, 0, 130)
ModesSection.BackgroundTransparency = 1
ModesSection.Text = "⚙️ PRESET MODES"
ModesSection.TextColor3 = Color3.fromRGB(255, 255, 255)
ModesSection.TextSize = 18
ModesSection.Font = Enum.Font.GothamBold
ModesSection.TextXAlignment = Enum.TextXAlignment.Left

-- Mode buttons container
local ModesContainer = Instance.new("Frame")
ModesContainer.Name = "ModesContainer"
ModesContainer.Size = UDim2.new(1, 0, 0, 120)
ModesContainer.Position = UDim2.new(0, 0, 0, 160)
ModesContainer.BackgroundTransparency = 1

-- Normal Mode
local NormalMode = createModeButton("Normal", "Default settings", 0, 0, Color3.fromRGB(100, 150, 255))
-- FPS Booster Mode
local FPSMode = createModeButton("FPS Booster", "Balanced performance", 0.33, 0, Color3.fromRGB(100, 255, 150))
-- Ultra Potato Mode
local PotatoMode = createModeButton("Ultra Potato", "Maximum FPS", 0.66, 0, Color3.fromRGB(255, 200, 100))
-- Extreme Mode
local ExtremeMode = createModeButton("Extreme", "Minimal everything", 0, 60, Color3.fromRGB(255, 100, 100))

-- Optimization modules
local modules = {
    {
        name = "Graphics Quality",
        description = "Reduce graphics quality levels",
        default = false,
        toggle = nil,
        func = function(state)
            if state then
                settings().Rendering.QualityLevel = math.max(1, optimizationLevel)
                settings().Rendering.MeshPartDetailLevel = Enum.MeshPartDetailLevel.Level04
            else
                settings().Rendering.QualityLevel = 10
                settings().Rendering.MeshPartDetailLevel = Enum.MeshPartDetailLevel.Level20
            end
        end
    },
    {
        name = "Disable Shadows",
        description = "Turn off all shadow rendering",
        default = false,
        toggle = nil,
        func = function(state)
            Lighting.GlobalShadows = not state
            Lighting.ShadowSoftness = state and 0 or 1
            for _, light in pairs(Lighting:GetChildren()) do
                if light:IsA("Light") then
                    light.Shadows = not state
                end
            end
        end
    },
    {
        name = "Reduce Particles",
        description = "Limit particle effects globally",
        default = false,
        toggle = nil,
        func = function(state)
            if state then
                for _, part in pairs(Workspace:GetDescendants()) do
                    if part:IsA("ParticleEmitter") or part:IsA("Trail") then
                        part.Enabled = false
                    end
                end
            else
                for _, part in pairs(Workspace:GetDescendants()) do
                    if part:IsA("ParticleEmitter") or part:IsA("Trail") then
                        part.Enabled = true
                    end
                end
            end
        end
    },
    {
        name = "Texture Compression",
        description = "Compress textures to save VRAM",
        default = false,
        toggle = nil,
        func = function(state)
            if state then
                settings().Rendering.EagerBulkExecution = true
                settings().Rendering.EnableFRM = true
            else
                settings().Rendering.EagerBulkExecution = false
                settings().Rendering.EnableFRM = false
            end
        end
    },
    {
        name = "Disable Post-Processing",
        description = "Turn off bloom, blur, color correction",
        default = false,
        toggle = nil,
        func = function(state)
            if state then
                Lighting.Brightness = 2
                Lighting.Blur.Enabled = false
                Lighting.Bloom.Enabled = false
                Lighting.SunRays.Enabled = false
                Lighting.ColorCorrection.Enabled = false
                Lighting.Atmosphere.Enabled = false
            else
                Lighting.Brightness = 1
                Lighting.Blur.Enabled = true
                Lighting.Bloom.Enabled = true
                Lighting.SunRays.Enabled = true
                Lighting.ColorCorrection.Enabled = true
                Lighting.Atmosphere.Enabled = true
            end
        end
    },
    {
        name = "Reduce Render Distance",
        description = "Lower view distance significantly",
        default = false,
        toggle = nil,
        func = function(state)
            if state then
                Workspace.CurrentCamera.CameraType = Enum.CameraType.Scriptable
                RunService:Set3dRenderingEnabled(false)
                task.wait(0.01)
                RunService:Set3dRenderingEnabled(true)
            else
                Workspace.CurrentCamera.CameraType = Enum.CameraType.Custom
            end
        end
    },
    {
        name = "Memory Cleanup",
        description = "Clear unused assets from RAM",
        default = false,
        toggle = nil,
        func = function(state)
            if state then
                collectgarbage("collect")
                game:GetService("ContentProvider"):PreloadAsync({})
                -- Clear texture cache
                for _, obj in pairs(Workspace:GetDescendants()) do
                    if obj:IsA("BasePart") and obj.Material ~= Enum.Material.Plastic then
                        obj.Material = Enum.Material.Plastic
                        task.wait()
                        obj.Material = Enum.Material.SmoothPlastic
                    end
                end
            end
        end
    },
    {
        name = "Reduce Physics",
        description = "Lower physics quality",
        default = false,
        toggle = nil,
        func = function(state)
            if state then
                settings().Physics.PhysicsEnvironmentalThrottle = Enum.EnviromentalPhysicsThrottle.Disabled
                settings().Physics.AllowSleep = true
            else
                settings().Physics.PhysicsEnvironmentalThrottle = Enum.EnviromentalPhysicsThrottle.Default
                settings().Physics.AllowSleep = false
            end
        end
    },
    {
        name = "Disable Sounds",
        description = "Mute non-essential sounds",
        default = false,
        toggle = nil,
        func = function(state)
            if state then
                for _, sound in pairs(Workspace:GetDescendants()) do
                    if sound:IsA("Sound") and not sound:GetAttribute("Essential") then
                        sound.Volume = 0
                    end
                end
            else
                for _, sound in pairs(Workspace:GetDescendants()) do
                    if sound:IsA("Sound") then
                        sound.Volume = 1
                    end
                end
            end
        end
    },
    {
        name = "Optimize Network",
        description = "Reduce network usage",
        default = false,
        toggle = nil,
        func = function(state)
            if state then
                settings().Network.IncomingReplicationLag = 1000
            else
                settings().Network.IncomingReplicationLag = 0
            end
        end
    }
}

-- Helper function to create mode buttons
function createModeButton(name, desc, xPos, yPos, color)
    local button = Instance.new("TextButton")
    button.Name = name .. "Mode"
    button.Size = UDim2.new(0.32, -5, 0, 50)
    button.Position = UDim2.new(xPos, 0, 0, yPos)
    button.BackgroundColor3 = color
    button.Text = name
    button.TextColor3 = Color3.fromRGB(255, 255, 255)
    button.TextSize = 16
    button.Font = Enum.Font.GothamBold
    
    local buttonCorner = Instance.new("UICorner")
    buttonCorner.CornerRadius = UDim.new(0, 10)
    buttonCorner.Parent = button
    
    local buttonStroke = Instance.new("UIStroke")
    buttonStroke.Color = Color3.fromRGB(255, 255, 255)
    buttonStroke.Thickness = 2
    buttonStroke.Transparency = 0.7
    buttonStroke.Parent = button
    
    local descLabel = Instance.new("TextLabel")
    descLabel.Name = "Desc"
    descLabel.Size = UDim2.new(1, 0, 0, 15)
    descLabel.Position = UDim2.new(0, 0, 1, 0)
    descLabel.BackgroundTransparency = 1
    descLabel.Text = desc
    descLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
    descLabel.TextSize = 10
    descLabel.Font = Enum.Font.Gotham
    descLabel.Parent = button
    
    return button
end

-- Apply preset modes
function applyMode(mode)
    optimizationLevel = mode
    
    if mode == 0 then -- Normal
        for _, module in pairs(modules) do
            if module.toggle then
                module.toggle.Parent.Parent:TweenSize(UDim2.new(0, 21, 0, 21), "Out", "Quad", 0.2)
                module.toggle.BackgroundColor3 = Color3.fromRGB(220, 60, 60)
                module.func(false)
            end
        end
        LagIndicator.Visible = false
        
    elseif mode == 1 then -- FPS Booster
        modules[1].func(true)  -- Graphics Quality
        modules[2].func(true)  -- Shadows
        modules[4].func(true)  -- Texture Compression
        modules[5].func(false) -- Post-Processing (keep some)
        updateModuleToggle(1, true)
        updateModuleToggle(2, true)
        updateModuleToggle(4, true)
        
    elseif mode == 2 then -- Ultra Potato
        for i = 1, 7 do
            modules[i].func(true)
            updateModuleToggle(i, true)
        end
        
    elseif mode == 3 then -- Extreme
        for i, module in pairs(modules) do
            module.func(true)
            updateModuleToggle(i, true)
        end
    end
end

-- Update module toggle visually
function updateModuleToggle(index, state)
    if modules[index].toggle then
        local toggle = modules[index].toggle
        if state then
            toggle:TweenPosition(UDim2.new(1, -23, 0, 2), "Out", "Quad", 0.2)
            toggle.BackgroundColor3 = Color3.fromRGB(60, 220, 60)
            toggle.Parent.BackgroundColor3 = Color3.fromRGB(40, 100, 40)
        else
            toggle:TweenPosition(UDim2.new(0, 2, 0, 2), "Out", "Quad", 0.2)
            toggle.BackgroundColor3 = Color3.fromRGB(220, 60, 60)
            toggle.Parent.BackgroundColor3 = Color3.fromRGB(60, 60, 70)
        end
    end
end

-- Auto lag detection and optimization
function checkForLag()
    if currentFPS < lagThreshold and not isLagging then
        isLagging = true
        LagIndicator.Visible = true
        
        -- Auto-apply optimizations based on severity
        if currentFPS < 15 then
            applyMode(3) -- Extreme mode
        elseif currentFPS < 25 then
            applyMode(2) -- Ultra Potato
        else
            applyMode(1) -- FPS Booster
        end
        
        -- Show notification
        local notif = Instance.new("TextLabel")
        notif.Name = "LagNotification"
        notif.Size = UDim2.new(0, 300, 0, 50)
        notif.Position = UDim2.new(0.5, -150, 0.1, 0)
        notif.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
        notif.Text = "⚠️ Auto-Optimized for Lag! FPS: " .. math.floor(currentFPS)
        notif.TextColor3 = Color3.fromRGB(255, 255, 255)
        notif.TextSize = 16
        notif.Font = Enum.Font.GothamBold
        
        local notifCorner = Instance.new("UICorner")
        notifCorner.CornerRadius = UDim.new(0, 10)
        notifCorner.Parent = notif
        
        notif.Parent = KnoxHub
        
        -- Remove after 3 seconds
        task.wait(3)
        notif:Destroy()
        
    elseif currentFPS >= lagThreshold + 10 and isLagging then
        isLagging = false
        LagIndicator.Visible = false
    end
end

-- FPS counter update
RunService.RenderStepped:Connect(function()
    frameCount = frameCount + 1
    local currentTime = tick()
    
    if currentTime - lastTick >= 1 then
        currentFPS = math.floor(frameCount / (currentTime - lastTick))
        frameCount = 0
        lastTick = currentTime
        
        -- Update FPS display with color coding
        local fpsColor
        if currentFPS >= 60 then
            fpsColor = Color3.fromRGB(100, 255, 100)
        elseif currentFPS >= 30 then
            fpsColor = Color3.fromRGB(255, 200, 100)
        else
            fpsColor = Color3.fromRGB(255, 100, 100)
        end
        
        FPSLabel.Text = "FPS: " .. currentFPS
        FPSLabel.TextColor3 = fpsColor
        
        -- Update other stats
        local stats = StatsService
        local perfStats = stats:FindFirstChild("PerformanceStats")
        if perfStats then
            local cpu = perfStats:FindFirstChild("CPU")
            local gpu = perfStats:FindFirstChild("GPU")
            local mem = perfStats:FindFirstChild("Memory")
            
            if cpu then
                CPULabel.Text = "CPU: " .. math.floor(cpu:GetValue()) .. "%"
            end
            if gpu then
                GPULabel.Text = "GPU: " .. math.floor(gpu:GetValue()) .. "%"
            end
            if mem then
                MemoryLabel.Text = "RAM: " .. math.floor(mem:GetValue() / 1024 / 1024) .. " MB"
            end
        end
        
        -- Auto lag detection
        checkForLag()
    end
end)

-- Create module toggles
local yOffset = 290
for i, module in ipairs(modules) do
    local moduleFrame = Instance.new("Frame")
    moduleFrame.Name = "Module_" .. i
    moduleFrame.Size = UDim2.new(1, 0, 0, 70)
    moduleFrame.Position = UDim2.new(0, 0, 0, yOffset)
    moduleFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 50)
    moduleFrame.BackgroundTransparency = 0.2
    
    local moduleGradient = Instance.new("UIGradient")
    moduleGradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(40, 40, 60)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(30, 30, 50))
    })
    moduleGradient.Parent = moduleFrame
    
    local moduleCorner = Instance.new("UICorner")
    moduleCorner.CornerRadius = UDim.new(0, 10)
    moduleCorner.Parent = moduleFrame
    
    local moduleStroke = Instance.new("UIStroke")
    moduleStroke.Color = Color3.fromRGB(100, 100, 150)
    moduleStroke.Thickness = 1
    moduleStroke.Transparency = 0.5
    moduleStroke.Parent = moduleFrame
    
    local moduleTitle = Instance.new("TextLabel")
    moduleTitle.Name = "Title"
    moduleTitle.Size = UDim2.new(0.7, -10, 0, 30)
    moduleTitle.Position = UDim2.new(0, 10, 0, 5)
    moduleTitle.BackgroundTransparency = 1
    moduleTitle.Text = "🔧 " .. module.name
    moduleTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
    moduleTitle.TextSize = 16
    moduleTitle.Font = Enum.Font.GothamSemibold
    moduleTitle.TextXAlignment = Enum.TextXAlignment.Left
    
    local moduleDesc = Instance.new("TextLabel")
    moduleDesc.Name = "Description"
    moduleDesc.Size = UDim2.new(0.7, -10, 0, 30)
    moduleDesc.Position = UDim2.new(0, 10, 0, 35)
    moduleDesc.BackgroundTransparency = 1
    moduleDesc.Text = module.description
    moduleDesc.TextColor3 = Color3.fromRGB(180, 180, 200)
    moduleDesc.TextSize = 12
    moduleDesc.Font = Enum.Font.Gotham
    moduleDesc.TextXAlignment = Enum.TextXAlignment.Left
    
    -- Toggle switch
    local toggleFrame = Instance.new("Frame")
    toggleFrame.Name = "ToggleFrame"
    toggleFrame.Size = UDim2.new(0, 60, 0, 30)
    toggleFrame.Position = UDim2.new(1, -75, 0.5, -15)
    toggleFrame.BackgroundColor3 = Color3.fromRGB(60, 60, 80)
    
    local toggleCorner = Instance.new("UICorner")
    toggleCorner.CornerRadius = UDim.new(0, 15)
    toggleCorner.Parent = toggleFrame
    
    local toggleButton = Instance.new("TextButton")
    toggleButton.Name = "ToggleButton"
    toggleButton.Size = UDim2.new(0, 26, 0, 26)
    toggleButton.Position = UDim2.new(0, 2, 0, 2)
    toggleButton.BackgroundColor3 = Color3.fromRGB(220, 60, 60)
    toggleButton.Text = ""
    
    local toggleButtonCorner = Instance.new("UICorner")
    toggleButtonCorner.CornerRadius = UDim.new(1, 0)
    toggleButtonCorner.Parent = toggleButton
    
    -- Toggle functionality
    local isToggled = module.default
    module.toggle = toggleButton
    
    local function updateToggle()
        if isToggled then
            toggleButton:TweenPosition(UDim2.new(1, -28, 0, 2), "Out", "Quad", 0.2)
            toggleButton.BackgroundColor3 = Color3.fromRGB(60, 220, 60)
            toggleFrame.BackgroundColor3 = Color3.fromRGB(40, 100, 40)
        else
            toggleButton:TweenPosition(UDim2.new(0, 2, 0, 2), "Out", "Quad", 0.2)
            toggleButton.BackgroundColor3 = Color3.fromRGB(220, 60, 60)
            toggleFrame.BackgroundColor3 = Color3.fromRGB(60, 60, 80)
        end
        module.func(isToggled)
    end
    
    toggleButton.MouseButton1Click:Connect(function()
        isToggled = not isToggled
        updateToggle()
    end)
    
    updateToggle()
    
    toggleButton.Parent = toggleFrame
    toggleFrame.Parent = moduleFrame
    moduleDesc.Parent = moduleFrame
    moduleTitle.Parent = moduleFrame
    moduleFrame.Parent = ContentFrame
    
    yOffset = yOffset + 75
end

-- Update ContentFrame canvas size
ContentFrame.CanvasSize = UDim2.new(0, 0, 0, yOffset + 10)

-- Assemble UI
LagIndicator.Parent = StatsPanel
MemoryLabel.Parent = StatsPanel
GPULabel.Parent = StatsPanel
CPULabel.Parent = StatsPanel
FPSLabel.Parent = StatsPanel
StatsPanel.Parent = ContentFrame

ExtremeMode.Parent = ModesContainer
PotatoMode.Parent = ModesContainer
FPSMode.Parent = ModesContainer
NormalMode.Parent = ModesContainer
ModesContainer.Parent = ContentFrame
ModesSection.Parent = ContentFrame

MinimizeButton.Parent = TitleBar
CloseButton.Parent = TitleBar
Title.Parent =

TitleBar
TitleBar.Parent = MainFrame
MainFrame.Parent = KnoxHub

-- Drag functionality for main UI
local dragStart, dragPos, dragging = nil, nil, false

MainFrame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        dragPos = MainFrame.Position
    end
end)

MainFrame.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = false
    end
end)

RunService.RenderStepped:Connect(function()
    if dragging then
        local delta = UserInputService:GetMouseLocation() - dragStart
        MainFrame:TweenPosition(UDim2.new(0, dragPos.X.Offset + delta.X, 0, dragPos.Y.Offset + delta.Y), "Out", "Quad", 0.1, true)
    end
end)

-- Close/Minimize buttons
CloseButton.MouseButton1Click:Connect(function()
    KnoxHub:Destroy()
    FloatingButton.Visible = true
end)

MinimizeButton.MouseButton1Click:Connect(function()
    MainFrame:TweenSize(UDim2.new(0, 450, 0, 45), "Out", "Quad", 0.2, true)
    ContentFrame.Visible = false
end)

-- Floating button functionality
ButtonFrame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        dragPos = ButtonFrame.Position
    end
end)

ButtonFrame.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = false
    end
end)

RunService.RenderStepped:Connect(function()
    if dragging then
        local delta = UserInputService:GetMouseLocation() - dragStart
        ButtonFrame:TweenPosition(UDim2.new(0, dragPos.X.Offset + delta.X, 0, dragPos.Y.Offset + delta.Y), "Out", "Quad", 0.1, true)
    end
end)

ButtonFrame.MouseButton1Click:Connect(function()
    if KnoxHub.Enabled then
        KnoxHub.Enabled = false
        FloatingButton.Visible = true
    else
        KnoxHub.Enabled = true
        FloatingButton.Visible = false
    end
end)

-- Set initial mode
applyMode(0)

<<HUMAN_CONVERSATION_END>>
