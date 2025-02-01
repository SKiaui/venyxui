local Library = {}

function Library:CreateWindow(name)
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = name
    ScreenGui.Parent = game:GetService("CoreGui")
    ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

    local Vigil = Instance.new("ImageLabel")
    Vigil.Name = "Vigil"
    Vigil.Parent = ScreenGui
    Vigil.AnchorPoint = Vector2.new(0.5, 0.5)
    Vigil.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Vigil.BackgroundTransparency = 1.000
    Vigil.BorderColor3 = Color3.fromRGB(0, 0, 0)
    Vigil.BorderSizePixel = 0
    Vigil.Position = UDim2.new(0.5, 0, 0.5, 0)
    Vigil.Size = UDim2.new(0.317800254, 0, 0.361586094, 0)
    Vigil.Image = "rbxassetid://119971145457961"
    Vigil.ScaleType = Enum.ScaleType.Fit

    local UIAspectRatioConstraint = Instance.new("UIAspectRatioConstraint")
    UIAspectRatioConstraint.Parent = Vigil
    UIAspectRatioConstraint.AspectRatio = 1.562

    local Content = Instance.new("Frame")
    Content.Name = "Content"
    Content.Parent = Vigil
    Content.AnchorPoint = Vector2.new(0.5, 0.5)
    Content.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Content.BackgroundTransparency = 1.000
    Content.BorderColor3 = Color3.fromRGB(0, 0, 0)
    Content.BorderSizePixel = 0
    Content.Position = UDim2.new(0.5, 0, 0.562061369, 0)
    Content.Size = UDim2.new(1, 0, 0.87587738, 0)

    local OptionsTap = Instance.new("ImageLabel")
    OptionsTap.Name = "OptionsTap"
    OptionsTap.Parent = Content
    OptionsTap.AnchorPoint = Vector2.new(0, 0.5)
    OptionsTap.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    OptionsTap.BackgroundTransparency = 1.000
    OptionsTap.BorderColor3 = Color3.fromRGB(0, 0, 0)
    OptionsTap.BorderSizePixel = 0
    OptionsTap.Position = UDim2.new(0.353150517, 0, 0.470397532, 0)
    OptionsTap.Size = UDim2.new(0.646829247, 0, 0.94156456, 0)
    OptionsTap.Image = "rbxassetid://114891277539091"
    OptionsTap.ScaleType = Enum.ScaleType.Fit

    local Scroller = Instance.new("ScrollingFrame")
    Scroller.Name = "Scroller"
    Scroller.Parent = OptionsTap
    Scroller.AnchorPoint = Vector2.new(0.5, 0.5)
    Scroller.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Scroller.BackgroundTransparency = 1.000
    Scroller.BorderColor3 = Color3.fromRGB(0, 0, 0)
    Scroller.BorderSizePixel = 0
    Scroller.Position = UDim2.new(0.5, 0, 0.5, 0)
    Scroller.Size = UDim2.new(1, 0, 1, 0)
    Scroller.CanvasSize = UDim2.new(0, 0, 0, 0)
    Scroller.ScrollBarThickness = 8

    local UIListLayout = Instance.new("UIListLayout")
    UIListLayout.Parent = Scroller
    UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
    UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
    UIListLayout.Padding = UDim.new(0.0240295753, 0)

    local lib = {
        Elements = {},
        Callbacks = {}
    }

    function lib:Button(options)
        local Button = Instance.new("ImageButton")
        Button.Name = "Button"
        Button.Parent = Scroller
        Button.AnchorPoint = Vector2.new(0.5, 0.5)
        Button.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        Button.BackgroundTransparency = 1.000
        Button.BorderColor3 = Color3.fromRGB(0, 0, 0)
        Button.BorderSizePixel = 0
        Button.Position = UDim2.new(0.0450000018, 0, 0.112000003, 0)
        Button.Size = UDim2.new(0.936651587, 0, 0.110905729, 0)
        Button.Image = "rbxassetid://81214913856279"
        Button.ScaleType = Enum.ScaleType.Fit

        local Txt = Instance.new("TextLabel")
        Txt.Name = "Txt"
        Txt.Parent = Banner
        Txt.AnchorPoint = Vector2.new(0.5, 0.5)
        Txt.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        Txt.BackgroundTransparency = 1.000
        Txt.BorderColor3 = Color3.fromRGB(0, 0, 0)
        Txt.BorderSizePixel = 0
        Txt.Position = UDim2.new(0.5, 0, 0.5, 0)
        Txt.Size = UDim2.new(1, 0, 0.632911384, 0)
        Txt.Font = Enum.Font.Gotham
        Txt.Text = options.Name
        Txt.TextColor3 = Color3.fromRGB(117, 117, 117)
        Txt.TextScaled = true
        Txt.TextSize = 14.000
        Txt.TextWrapped = true

        button.MouseButton1Click:Connect(options.Callback)
        return button
    end

    function lib:Toggle(options)
        local Toggle = Instance.new("ImageLabel")
        Toggle.Name = "Toggle"
        Toggle.Parent = Scroller
        Toggle.AnchorPoint = Vector2.new(0.5, 0.5)
        Toggle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        Toggle.BackgroundTransparency = 1.000
        Toggle.BorderColor3 = Color3.fromRGB(0, 0, 0)
        Toggle.BorderSizePixel = 0
        Toggle.Position = UDim2.new(0.0450000018, 0, 0.112000003, 0)
        Toggle.Selectable = true
        Toggle.Size = UDim2.new(0.936651587, 0, 0.110905729, 0)
        Toggle.Image = "rbxassetid://81214913856279"
        Toggle.ScaleType = Enum.ScaleType.Fit

        local state = options.Default or false

        local Txt = Instance.new("TextLabel")
        Txt.Name = "Txt"
        Txt.Parent = Banner
        Txt.AnchorPoint = Vector2.new(0.5, 0.5)
        Txt.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        Txt.BackgroundTransparency = 1.000
        Txt.BorderColor3 = Color3.fromRGB(0, 0, 0)
        Txt.BorderSizePixel = 0
        Txt.Position = UDim2.new(0.5, 0, 0.5, 0)
        Txt.Size = UDim2.new(1, 0, 0.632911384, 0)
        Txt.Font = Enum.Font.Gotham
        Txt.Text = options.Name
        Txt.TextColor3 = Color3.fromRGB(117, 117, 117)
        Txt.TextScaled = true
        Txt.TextSize = 14.000
        Txt.TextWrapped = true

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

    function lib:Slider(options)
        local Slider = Instance.new("ImageLabel")
        Slider.Name = options.Name
        Slider.Parent = Scroller
        Slider.AnchorPoint = Vector2.new(0.5, 0.5)
        Slider.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        Slider.BackgroundTransparency = 1.000
        Slider.BorderColor3 = Color3.fromRGB(0, 0, 0)
        Slider.BorderSizePixel = 0
        Slider.Position = UDim2.new(0.0450000018, 0, 0.112000003, 0)
        Slider.Selectable = true
        Slider.Size = UDim2.new(0.936651587, 0, 0.110905729, 0)
        Slider.Image = "rbxassetid://81214913856279"
        Slider.ScaleType = Enum.ScaleType.Fit

        local min = options.Min or 0
        local max = options.Max or 100
        local value = options.Default or min

        local Txt = Instance.new("TextLabel")
        Txt.Name = "Txt"
        Txt.Parent = Banner
        Txt.AnchorPoint = Vector2.new(0.5, 0.5)
        Txt.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        Txt.BackgroundTransparency = 1.000
        Txt.BorderColor3 = Color3.fromRGB(0, 0, 0)
        Txt.BorderSizePixel = 0
        Txt.Position = UDim2.new(0.5, 0, 0.5, 0)
        Txt.Size = UDim2.new(1, 0, 0.632911384, 0)
        Txt.Font = Enum.Font.Gotham
        Txt.Text = options.Name
        Txt.TextColor3 = Color3.fromRGB(117, 117, 117)
        Txt.TextScaled = true
        Txt.TextSize = 14.000
        Txt.TextWrapped = true

        local LoadingBar = Instance.new("ImageLabel")
        LoadingBar.Name = "LoadingBar"
        LoadingBar.Parent = Slider
        LoadingBar.AnchorPoint = Vector2.new(1, 0.5)
        LoadingBar.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        LoadingBar.BackgroundTransparency = 1.000
        LoadingBar.BorderColor3 = Color3.fromRGB(0, 0, 0)
        LoadingBar.BorderSizePixel = 0
        LoadingBar.Position = UDim2.new(0.98550725, 0, 0.5, 0)
        LoadingBar.Size = UDim2.new(0.457326889, 0, 0.716118515, 0)
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

        local dragging = false
        local inputService = game:GetService("UserInputService")

        local function update(value)
            value = math.clamp(value, min, max)
            TxtValue.Text = tostring(math.floor(value))
            options.Callback(value)
        end

        Slider.MouseButton1Down:Connect(function()
            dragging = true
            local mouse = inputService:GetMouseLocation()
            local absoluteX = Slider.AbsolutePosition.X
            local percent = (mouse.X - absoluteX) / Slider.AbsoluteSize.X
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
