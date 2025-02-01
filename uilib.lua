local Library = {}
local TweenService = game:GetService("TweenService")

function Library:CreateWindow(name)
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = name
    ScreenGui.Parent = game:GetService("CoreGui")
    ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

    local Vigil = Instance.new("ImageLabel")
    Vigil.Name = "Vigil"
    Vigil.Parent = ScreenGui
    Vigil.AnchorPoint = Vector2.new(0.5, 0.5)
    Vigil.BackgroundTransparency = 1
    Vigil.Position = UDim2.new(0.5, 0, 0.5, 0)
    Vigil.Size = UDim2.new(0.3, 0, 0.4, 0)
    Vigil.Image = "rbxassetid://119971145457961"
    Vigil.ScaleType = Enum.ScaleType.Fit
    Vigil.ImageTransparency = 1 -- Start transparent for fade-in effect

    local fadeIn = TweenService:Create(Vigil, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {ImageTransparency = 0})
    fadeIn:Play()

    local Content = Instance.new("Frame")
    Content.Name = "Content"
    Content.Parent = Vigil
    Content.AnchorPoint = Vector2.new(0.5, 0.5)
    Content.BackgroundTransparency = 1
    Content.Position = UDim2.new(0.5, 0, 0.6, 0)
    Content.Size = UDim2.new(1, 0, 0.8, 0)

    local Scroller = Instance.new("ScrollingFrame")
    Scroller.Parent = Content
    Scroller.Size = UDim2.new(1, 0, 1, 0)
    Scroller.CanvasSize = UDim2.new(0, 0, 0, 0)
    Scroller.ScrollBarThickness = 8
    Scroller.BackgroundTransparency = 1

    local UIListLayout = Instance.new("UIListLayout")
    UIListLayout.Parent = Scroller
    UIListLayout.Padding = UDim.new(0.02, 0)

    local lib = {}

    function lib:Button(options)
        local Button = Instance.new("TextButton")
        Button.Parent = Scroller
        Button.Size = UDim2.new(1, 0, 0.1, 0)
        Button.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
        Button.Text = options.Name
        Button.TextColor3 = Color3.new(1, 1, 1)
        Button.TextScaled = true

        Button.MouseButton1Click:Connect(options.Callback)
        return Button
    end

    function lib:Slider(options)
        local SliderFrame = Instance.new("Frame")
        SliderFrame.Parent = Scroller
        SliderFrame.Size = UDim2.new(1, 0, 0.1, 0)
        SliderFrame.BackgroundTransparency = 1

        local SliderBar = Instance.new("Frame")
        SliderBar.Parent = SliderFrame
        SliderBar.Size = UDim2.new(1, 0, 0.5, 0)
        SliderBar.Position = UDim2.new(0, 0, 0.5, 0)
        SliderBar.BackgroundColor3 = Color3.fromRGB(60, 60, 60)

        local Knob = Instance.new("ImageButton")
        Knob.Parent = SliderBar
        Knob.Size = UDim2.new(0, 20, 1, 0)
        Knob.BackgroundColor3 = Color3.fromRGB(200, 200, 200)
        Knob.Position = UDim2.new(0, 0, 0, 0)
        Knob.AutoButtonColor = false

        local TxtValue = Instance.new("TextLabel")
        TxtValue.Parent = SliderFrame
        TxtValue.Position = UDim2.new(0.5, 0, 0, -20)
        TxtValue.Size = UDim2.new(0.5, 0, 0.5, 0)
        TxtValue.Text = tostring(options.Default or 0)
        TxtValue.TextColor3 = Color3.new(1, 1, 1)
        TxtValue.BackgroundTransparency = 1
        TxtValue.TextScaled = true

        local min, max = options.Min or 0, options.Max or 100
        local dragging = false

        local function update(input)
            local delta = input.Position.X - SliderBar.AbsolutePosition.X
            local percent = math.clamp(delta / SliderBar.AbsoluteSize.X, 0, 1)
            local value = math.floor(min + (max - min) * percent)
            TxtValue.Text = tostring(value)
            Knob.Position = UDim2.new(percent, -10, 0, 0)
            options.Callback(value)
        end

        Knob.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 then
                dragging = true
            end
        end)

        game:GetService("UserInputService").InputChanged:Connect(function(input)
            if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
                update(input)
            end
        end)

        game:GetService("UserInputService").InputEnded:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 then
                dragging = false
            end
        end)

        return SliderFrame
    end

    return lib
end

return Library
