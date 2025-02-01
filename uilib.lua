local Library = {}

function Library:CreateWindow(name)
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = name
    ScreenGui.Parent = game:GetService("CoreGui")
    ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

    -- Main Container
    local Vigil = Instance.new("ImageLabel")
    Vigil.Name = "Vigil"
    Vigil.Parent = ScreenGui
    Vigil.AnchorPoint = Vector2.new(0.5, 0.5)
    Vigil.BackgroundTransparency = 1
    Vigil.Position = UDim2.new(0.5, 0, 0.5, 0)
    Vigil.Size = UDim2.new(0.534, 0, 0.608, 0)
    Vigil.Image = "rbxassetid://119971145457961"
    Vigil.ScaleType = Enum.ScaleType.Fit

    -- Aspect Ratio Constraint
    local UIAspectRatioConstraint = Instance.new("UIAspectRatioConstraint")
    UIAspectRatioConstraint.Parent = Vigil
    UIAspectRatioConstraint.AspectRatio = 1.562

    -- Content Frame
    local Content = Instance.new("Frame")
    Content.Name = "Content"
    Content.Parent = Vigil
    Content.AnchorPoint = Vector2.new(0.5, 0.5)
    Content.BackgroundTransparency = 1
    Content.Position = UDim2.new(0.5, 0, 0.562, 0)
    Content.Size = UDim2.new(1, 0, 0.876, 0)

    -- Options Tab
    local OptionsTap = Instance.new("ImageLabel")
    OptionsTap.Name = "OptionsTap"
    OptionsTap.Parent = Content
    OptionsTap.AnchorPoint = Vector2.new(0, 0.5)
    OptionsTap.BackgroundTransparency = 1
    OptionsTap.Position = UDim2.new(0.353, 0, 0.47, 0)
    OptionsTap.Size = UDim2.new(0.647, 0, 0.942, 0)
    OptionsTap.Image = "rbxassetid://114891277539091"
    OptionsTap.ScaleType = Enum.ScaleType.Fit

    -- Scrolling Frame
    local Scroller = Instance.new("ScrollingFrame")
    Scroller.Name = "Scroller"
    Scroller.Parent = OptionsTap
    Scroller.AnchorPoint = Vector2.new(0.5, 0.5)
    Scroller.BackgroundTransparency = 1
    Scroller.Position = UDim2.new(0.5, 0, 0.5, 0)
    Scroller.Size = UDim2.new(1, 0, 1, 0)
    Scroller.CanvasSize = UDim2.new(0, 0, 2, 0)
    Scroller.ScrollBarThickness = 8

    local UIListLayout = Instance.new("UIListLayout")
    UIListLayout.Parent = Scroller
    UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
    UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
    UIListLayout.Padding = UDim.new(0.024, 0)

    local lib = {
        Elements = {},
        Callbacks = {}
    }

    -- Button Component
    function lib:Button(options)
        local button = Instance.new("ImageButton")
        button.Name = options.Name
        button.Parent = Scroller
        button.AnchorPoint = Vector2.new(0.5, 0.5)
        button.BackgroundTransparency = 1
        button.Size = UDim2.new(0.937, 0, 0.111, 0)
        button.Image = "rbxassetid://81214913856279"
        button.ScaleType = Enum.ScaleType.Fit

        local Txt = Instance.new("TextLabel")
        Txt.Name = "Text"
        Txt.Parent = button
        Txt.AnchorPoint = Vector2.new(0.5, 0.5)
        Txt.BackgroundTransparency = 1
        Txt.Position = UDim2.new(0.5, 0, 0.5, 0)
        Txt.Size = UDim2.new(0.936, 0, 0.467, 0)
        Txt.Font = Enum.Font.GothamMedium
        Txt.Text = options.Name
        Txt.TextColor3 = Color3.fromRGB(255, 255, 255)
        Txt.TextScaled = true
        Txt.TextSize = 14
        Txt.TextWrapped = true
        Txt.TextXAlignment = Enum.TextXAlignment.Left

        button.MouseButton1Click:Connect(options.Callback)
        return button
    end

    -- Toggle Component
    function lib:Toggle(options)
        local toggle = Instance.new("ImageLabel")
        toggle.Name = options.Name
        toggle.Parent = Scroller
        toggle.AnchorPoint = Vector2.new(0.5, 0.5)
        toggle.BackgroundTransparency = 1
        toggle.Size = UDim2.new(0.937, 0, 0.111, 0)
        toggle.Image = "rbxassetid://81214913856279"
        toggle.ScaleType = Enum.ScaleType.Fit

        local state = options.Default or false
        
        -- Toggle Text
        local Txt = Instance.new("TextLabel")
        Txt.Name = "Text"
        Txt.Parent = toggle
        Txt.AnchorPoint = Vector2.new(0.5, 0.5)
        Txt.BackgroundTransparency = 1
        Txt.Position = UDim2.new(0.369, 0, 0.5, 0)
        Txt.Size = UDim2.new(0.673, 0, 0.467, 0)
        Txt.Font = Enum.Font.GothamMedium
        Txt.Text = options.Name
        Txt.TextColor3 = Color3.fromRGB(255, 255, 255)
        Txt.TextScaled = true
        Txt.TextSize = 14
        Txt.TextWrapped = true
        Txt.TextXAlignment = Enum.TextXAlignment.Left

        -- Toggle Switch
        local Button = Instance.new("ImageButton")
        Button.Name = "Switch"
        Button.Parent = toggle
        Button.AnchorPoint = Vector2.new(1, 0.5)
        Button.BackgroundTransparency = 1
        Button.Position = UDim2.new(0.971, 0, 0.5, 0)
        Button.Size = UDim2.new(0.108, 0, 0.533, 0)
        Button.Image = "rbxassetid://123317618042392"
        Button.ScaleType = Enum.ScaleType.Fit

        local Off = Instance.new("ImageLabel")
        Off.Name = "Off"
        Off.Parent = Button
        Off.AnchorPoint = Vector2.new(0, 0.5)
        Off.BackgroundTransparency = 1
        Off.Position = UDim2.new(0.06, 0, 0.5, 0)
        Off.Size = UDim2.new(0.388, 0, 0.813, 0)
        Off.Image = "rbxassetid://112376976170886"
        Off.ScaleType = Enum.ScaleType.Fit
        Off.Visible = not state

        local On = Instance.new("ImageLabel")
        On.Name = "On"
        On.Parent = Button
        On.AnchorPoint = Vector2.new(1, 0.5)
        On.BackgroundTransparency = 1
        On.Position = UDim2.new(0.94, 0, 0.5, 0)
        On.Size = UDim2.new(0.388, 0, 0.813, 0)
        On.Image = "rbxassetid://112376976170886"
        On.ScaleType = Enum.ScaleType.Fit
        On.Visible = state

        Button.MouseButton1Click:Connect(function()
            state = not state
            On.Visible = state
            Off.Visible = not state
            options.Callback(state)
        end)

        return toggle
    end

    -- Slider Component
    function lib:Slider(options)
        local slider = Instance.new("ImageLabel")
        slider.Name = options.Name
        slider.Parent = Scroller
        slider.AnchorPoint = Vector2.new(0.5, 0.5)
        slider.BackgroundTransparency = 1
        slider.Size = UDim2.new(0.937, 0, 0.111, 0)
        slider.Image = "rbxassetid://81214913856279"
        slider.ScaleType = Enum.ScaleType.Fit

        local min = options.Min or 0
        local max = options.Max or 100
        local value = options.Default or min
        
        -- Slider Text
        local Txt = Instance.new("TextLabel")
        Txt.Name = "Text"
        Txt.Parent = slider
        Txt.AnchorPoint = Vector2.new(0.5, 0.5)
        Txt.BackgroundTransparency = 1
        Txt.Position = UDim2.new(0.28, 0, 0.5, 0)
        Txt.Size = UDim2.new(0.496, 0, 0.466, 0)
        Txt.Font = Enum.Font.GothamMedium
        Txt.Text = options.Name
        Txt.TextColor3 = Color3.fromRGB(255, 255, 255)
        Txt.TextScaled = true
        Txt.TextSize = 14
        Txt.TextWrapped = true
        Txt.TextXAlignment = Enum.TextXAlignment.Left

        -- Progress Bar
        local LoadingBar = Instance.new("ImageLabel")
        LoadingBar.Name = "LoadingBar"
        LoadingBar.Parent = slider
        LoadingBar.AnchorPoint = Vector2.new(1, 0.5)
        LoadingBar.BackgroundTransparency = 1
        LoadingBar.Position = UDim2.new(0.986, 0, 0.5, 0)
        LoadingBar.Size = UDim2.new(0.457, 0, 0.716, 0)
        LoadingBar.Image = "rbxassetid://117462785670806"
        LoadingBar.ScaleType = Enum.ScaleType.Fit

        local TxtValue = Instance.new("TextLabel")
        TxtValue.Name = "Value"
        TxtValue.Parent = LoadingBar
        TxtValue.AnchorPoint = Vector2.new(0.5, 0.5)
        TxtValue.BackgroundTransparency = 1
        TxtValue.Position = UDim2.new(0.5, 0, 0.5, 0)
        TxtValue.Size = UDim2.new(0.898, 0, 0.488, 0)
        TxtValue.Font = Enum.Font.Gotham
        TxtValue.Text = tostring(value)
        TxtValue.TextColor3 = Color3.fromRGB(170, 170, 170)
        TxtValue.TextScaled = true
        TxtValue.TextSize = 14
        TxtValue.TextWrapped = true
        TxtValue.TextXAlignment = Enum.TextXAlignment.Left

        -- Slider Logic
        local dragging = false
        local inputService = game:GetService("UserInputService")

        local function update(value)
            value = math.clamp(value, min, max)
            TxtValue.Text = tostring(math.floor(value))
            options.Callback(value)
        end

        slider.MouseButton1Down:Connect(function()
            dragging = true
            local mouse = inputService:GetMouseLocation()
            local absoluteX = slider.AbsolutePosition.X
            local percent = (mouse.X - absoluteX) / slider.AbsoluteSize.X
            update(min + (max - min) * percent)
        end)

        inputService.InputEnded:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 then
                dragging = false
            end
        end)

        inputService.InputChanged:Connect(function(input)
            if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
                local mouse = inputService:GetMouseLocation()
                local absoluteX = slider.AbsolutePosition.X
                local percent = (mouse.X - absoluteX) / slider.AbsoluteSize.X
                update(min + (max - min) * percent)
            end
        end)

        return slider
    end

    return lib
end

return Library
