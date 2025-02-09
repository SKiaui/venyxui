
-- @ This UI uses SafeLoad V1. Will bypass most CoreGui checks. (ex: Peroxide, Da Hood)

-- $ VARIABLES
cloneref = cloneref or nil -- > defer warnings
local clone_service = cloneref or function(...) return ... end
local Services = setmetatable({}, {__index = function(self, name)
	local new_service = clone_service(game:GetService(name))
	self[name] = new_service
	return new_service
end})

-- $ SERVICES
local RunService = Services.RunService
local InputService = Services.UserInputService
local TweenService = Services.TweenService
local Players = Services.Players

-- $ EASING DATA
local tween_info = TweenInfo
local easing_style = Enum.EasingStyle
local easing_direction = Enum.EasingDirection

-- $ FUNCTIONS
function AddInstance(class : string, properties : {})
	local i

	local madeInstance, errorMessage = pcall(function()
		i = Instance.new(class)	
	end)

	if not madeInstance then
		return error(errorMessage, 99)
	end

	for property, value in properties do
		local _, err = pcall(function()
			i[property] = value
		end)

		if err then 
			return warn(`[{i}] Problem adding instance: {err}`) 
		end
	end

	return i or nil
end

function TableOverwrite(to_overwrite : {}, overwrite_with : {})
	for i, v in pairs(overwrite_with) do
		if type(v) == 'table' then
			to_overwrite[i] = TableOverwrite(to_overwrite[i] or {}, v)
		else
			to_overwrite[i] = v
		end
	end

	return to_overwrite or nil
end

function EncryptedString()
	-- > local characters = "azxcvnmiopqyu1234567890"
	local characters = [[救效须介首助职例热毕节害击乱态嗯宝倒注]]
	local str = ''
	for i=1, 99 do
		str = str .. characters:sub(
			math.random(1, #characters), 
			math.random(1, #characters)
		)
	end

	return str
end

function SafeLoad(instance : Instance, encrypt_names : boolean)
	if encrypt_names then
		for _,__ in ipairs(instance:GetDescendants()) do
			__.Name = EncryptedString()
		end
	end

	local ElevationAllowed = pcall(function() local a = cloneref(game:GetService("CoreGui")):GetFullName() end)
	instance.Parent = ElevationAllowed and Services.CoreGui
end

-- $ LIBRARY
local Vigil = { LIBRARY_INSTANCE = nil }

-- $ LIBRARY FUNCTIONS
function Vigil.init()
	if Vigil.LIBRARY_INSTANCE then
		SafeLoad(Vigil.LIBRARY_INSTANCE, true)
	end
end

function Vigil.new(Name, ...)
	-- $$ Metadata
	local UI_Dragging = false;
	local UI_DragPos = nil;
	local UI_FramePos = nil;
	local UI_DeltaPos = nil;
	local Window, Meta = {
		Hidden = false;
		Pages = {};
	}, {
		ToggleKey = nil;
		Anchor = Vector2.new(.5, .5);
		Size = UDim2.new(0, 600, 0, 526);
		Pos = UDim2.new(0.809, 0, 0.75, 0);
	}

	Meta = TableOverwrite(Meta, ... or {})

	-- $$ Instances
	local WindowFrame = AddInstance("ImageLabel", { Parent = nil, Name = [[WindowFrame]], AnchorPoint = Meta.Anchor, Active = true, Selectable = true, Image = [[rbxassetid://92051109372532]], BorderSizePixel = 0, Size = Meta.Size, ScaleType = Enum.ScaleType.Stretch, BorderColor3 = Color3.fromRGB(0, 0, 0), Position = Meta.Pos, BackgroundTransparency = 1, BackgroundColor3 = Color3.fromRGB(255, 255, 255),})
	local TopBarFrame = AddInstance("Frame", { Parent = WindowFrame, Name = [[Banner]], AnchorPoint = Vector2.new(0.5, 0), BorderSizePixel = 0, Size = UDim2.new(1, 0, 0.118902437, 0), BorderColor3 = Color3.fromRGB(0, 0, 0), Position = UDim2.new(0.5, 0, 0, 0), BackgroundTransparency = 1, BackgroundColor3 = Color3.fromRGB(255, 255, 255),})
	local ContentFrame = AddInstance("Frame", { Parent = WindowFrame, Name = [[Content]], AnchorPoint = Vector2.new(0.5, 0.5), BorderSizePixel = 0, Size = UDim2.new(1, 0, 0.875, 0), BorderColor3 = Color3.fromRGB(0, 0, 0), Position = UDim2.new(0.5, 0, 0.562061369, 0), BackgroundTransparency = 1, BackgroundColor3 = Color3.fromRGB(255, 255, 255),})
	local SidebarFrame = AddInstance("ImageLabel", { Parent = ContentFrame, Name = [[SidebarFrame]], LayoutOrder = 1, AnchorPoint = Vector2.new(0.5, 0.5), Image = [[rbxassetid://84563213653891]], BorderSizePixel = 0, Size = UDim2.new(0.302439034, 0, 0.959999979, 0), ScaleType = Enum.ScaleType.Stretch, BorderColor3 = Color3.fromRGB(0, 0, 0), Position = UDim2.new(0.0175609756, 0, 0.5, 0), BackgroundTransparency = 1, BackgroundColor3 = Color3.fromRGB(255, 255, 255),})
	local TabsFrame = AddInstance("ImageLabel", { Parent = ContentFrame, Name = [[ContentFrame]], LayoutOrder = 2, AnchorPoint = Vector2.new(0, 0.5), Image = [[rbxassetid://91973614665311]], BorderSizePixel = 0, Size = UDim2.new(0.646829247, 0, 0.959999979, 0), ScaleType = Enum.ScaleType.Stretch, BorderColor3 = Color3.fromRGB(0, 0, 0), Position = UDim2.new(0.0175609756, 0, 0.5, 0), BackgroundTransparency = 1, BackgroundColor3 = Color3.fromRGB(255, 255, 255),})
	local TitleTextLabel = AddInstance("TextLabel", { Parent = TopBarFrame, Name = [[TitleTextLabel]], TextWrapped = false, BorderSizePixel = 0, TextScaled = true, BackgroundColor3 = Color3.fromRGB(255, 255, 255), AnchorPoint = Vector2.new(0.5, 0.5), TextSize = 14, Size = UDim2.new(1, 0, 0.632911384, 0), BorderColor3 = Color3.fromRGB(0, 0, 0), Text = Name, Font = Enum.Font.Gotham, Position = UDim2.new(0.5, 0, 0.5, 0), TextColor3 = Color3.fromRGB(117, 117, 117), BackgroundTransparency = 1,})
	local SidebarScrollingFrame = AddInstance("ScrollingFrame", { Parent = SidebarFrame, ClipsDescendants = false; ScrollingDirection = Enum.ScrollingDirection.Y, BorderSizePixel = 0, CanvasSize = UDim2.new(0, 0, 0, 0), BackgroundColor3 = Color3.fromRGB(255, 255, 255), AnchorPoint = Vector2.new(0.5, 0.5), Size = UDim2.new(0.836525023, 0, 1, 0), ScrollBarImageColor3 = Color3.fromRGB(101, 101, 101), AutomaticCanvasSize = Enum.AutomaticSize.Y, BorderColor3 = Color3.fromRGB(0, 0, 0), ScrollBarThickness = 6, Position = UDim2.new(0.543262482, 0, 0.5, 0), BackgroundTransparency = 1, Selectable = false,})
	local SelectionLine = AddInstance("Frame", { Parent = nil, Name = [[Line]], AnchorPoint = Vector2.new(0, 0.5), BorderSizePixel = 0, Size = UDim2.new(0, 2, 1, 9), BorderColor3 = Color3.fromRGB(0, 0, 0), Position = UDim2.new(0, -5, 0.5, 0), BackgroundColor3 = Color3.fromRGB(154, 154, 154),})

	-- $$ UI Effects
	AddInstance("Frame", { Parent = SidebarScrollingFrame, Name = [[BottomPadding]], AnchorPoint = Vector2.new(0.5, 0.5), BorderSizePixel = 0, Size = UDim2.new(1.04502976, 0, 0, 0), BorderColor3 = Color3.fromRGB(0, 0, 0), LayoutOrder = 99, Position = UDim2.new(0.0450000018, 0, 0.112000003, 0), BackgroundTransparency = 1, BackgroundColor3 = Color3.fromRGB(255, 255, 255),})
	AddInstance("Frame", { Parent = SidebarScrollingFrame, Name = [[TopPadding]], AnchorPoint = Vector2.new(0.5, 0.5), BorderSizePixel = 0, Size = UDim2.new(1.04502976, 0, -0.00529100513, 0), BorderColor3 = Color3.fromRGB(0, 0, 0), LayoutOrder = -99, Position = UDim2.new(0.0450000018, 0, 0.112000003, 0), BackgroundTransparency = 1, BackgroundColor3 = Color3.fromRGB(255, 255, 255),})
	AddInstance("UIListLayout", { Parent = SidebarScrollingFrame, Padding = UDim.new(0.0599999987, 0), SortOrder = Enum.SortOrder.LayoutOrder,})
	--AddInstance("UIAspectRatioConstraint", { Parent = WindowFrame, AspectRatio = 1.1388888359069824,})
	AddInstance("UIListLayout", { Parent = ContentFrame, VerticalAlignment = Enum.VerticalAlignment.Center, FillDirection = Enum.FillDirection.Horizontal, Padding = UDim.new(0.0160000008, 0), SortOrder = Enum.SortOrder.LayoutOrder, HorizontalAlignment = Enum.HorizontalAlignment.Center,})

	-- $$ If UI does not exist, create one
	if not Vigil.LIBRARY_INSTANCE then
		Vigil.LIBRARY_INSTANCE = AddInstance('ScreenGui', {
			Name = EncryptedString();
			IgnoreGuiInset = true;
			ResetOnSpawn = false;
		})

		-- $ Loads UI into Vigil Instance
		WindowFrame.Parent = Vigil.LIBRARY_INSTANCE
	end

	-- $$ Functions + Connections
	local function ValidateInputType(InputType)
		if InputType == Enum.UserInputType.MouseButton1 then return true end
		if InputType == Enum.UserInputType.MouseMovement then return true end
		if InputType == Enum.UserInputType.Touch then return true end
	end

	InputService.InputBegan:Connect(function(Input)
		local InputType = Input.UserInputType
		
		if Input.KeyCode == Meta.ToggleKey then
			Window.Hidden = not Window.Hidden
			
			TweenService:Create(
				WindowFrame,
				tween_info.new(.25, easing_style.Quad, easing_direction.InOut),
				{ Size = Window.Hidden and UDim2.new(Meta.Size.X.Scale, Meta.Size.X.Offset, 0, 0) or Meta.Size }
			):Play()

			TweenService:Create(
				TitleTextLabel,
				tween_info.new(.25, easing_style.Quad, easing_direction.InOut),
				{ TextTransparency = Window.Hidden and 1 or 0 }
			):Play()
			
			ContentFrame.Visible = not Window.Hidden
		end

		if ValidateInputType(InputType) and WindowFrame.GuiState == Enum.GuiState.Press then
			UI_DragPos = Input.Position
			UI_FramePos = WindowFrame.Position
			UI_Dragging = true
		end

		-- >> Input Ended
		Input.Changed:Connect(function(InputType)
			local InputState = Input.UserInputState

			if InputState == Enum.UserInputState.End then
				UI_Dragging = false
			end
		end)
	end)

	InputService.InputChanged:Connect(function(Input)
		local InputType = Input.UserInputType

		if ValidateInputType(InputType) then
			if UI_Dragging then
				UI_DeltaPos = Input.Position - UI_DragPos

				WindowFrame.Position = UDim2.new(
					UI_FramePos.X.Scale, UI_FramePos.X.Offset + UI_DeltaPos.X,
					UI_FramePos.Y.Scale, UI_FramePos.Y.Offset + UI_DeltaPos.Y
				)
			end
		end
	end)

	function Window:addPage(Name, ...)
		-- $$$ Metadata
		local Page, Meta = {}, {
			Name = 'Page'
		}

		-- $$$ Instances
		local PageButton = AddInstance("TextButton", { Parent = SidebarScrollingFrame, Name = [[TabButton]], TextWrapped = false, BorderSizePixel = 0, TextScaled = true, BackgroundColor3 = Color3.fromRGB(255, 255, 255), AnchorPoint = Vector2.new(0.5, 0.5), TextSize = 14, Size = UDim2.new(1.04502976, 0, 0.0449735448, 0), LayoutOrder = 6, TextXAlignment = Enum.TextXAlignment.Left, BorderColor3 = Color3.fromRGB(0, 0, 0), Text = Name, Font = Enum.Font.GothamMedium, Position = UDim2.new(0.5, 0, 0.5, 0), TextColor3 = Color3.fromRGB(81, 81, 81), BackgroundTransparency = 1, Selectable = false,});
		local PageFrame = AddInstance("ScrollingFrame", { Parent = TabsFrame, Name = [[TabFrame]], ScrollingDirection = Enum.ScrollingDirection.Y, BorderSizePixel = 0, CanvasSize = UDim2.new(0, 0, 0, 0), BackgroundColor3 = Color3.fromRGB(255, 255, 255), AnchorPoint = Vector2.new(0.5, 0), Size = UDim2.new(1, 0, 0, 0), ScrollBarImageColor3 = Color3.fromRGB(141, 141, 141), AutomaticCanvasSize = Enum.AutomaticSize.Y, BorderColor3 = Color3.fromRGB(0, 0, 0), ScrollBarThickness = 6, Position = UDim2.new(0.5, 0, 0, 0), BackgroundTransparency = 1,});
		AddInstance("UIListLayout", { Parent = PageFrame, Padding = UDim.new(0, 10), SortOrder = Enum.SortOrder.LayoutOrder, HorizontalAlignment = Enum.HorizontalAlignment.Center,})
		AddInstance("UIPadding", { Parent = PageFrame, PaddingTop = UDim.new(0, 10), PaddingBottom = UDim.new(0, 10), PaddingLeft = UDim.new(0, 10), PaddingRight = UDim.new(0, 10)})

		Window.Pages[Name] = {
			PageButton = PageButton;
			PageFrame = PageFrame;
		}

		-- $$$ Functions + Connections
		PageButton.MouseButton1Click:Connect(function()
			for _, Page in Window.Pages do
				Page.PageFrame.Visible = false
				Page.PageFrame.Size = UDim2.new(1,0,0,0)

				TweenService:Create(
					Page.PageButton,
					TweenInfo.new(.25, easing_style.Quad, easing_direction.InOut),
					{ TextColor3 = Color3.fromHSV(0,0,0.317) }
				):Play()

				TweenService:Create(
					SelectionLine,
					TweenInfo.new(.1, easing_style.Quad, easing_direction.InOut),
					{ BackgroundTransparency = 1 }
				):Play()
			end

			SelectionLine.Parent = PageButton
			PageFrame.Visible = true
			TweenService:Create(
				PageButton,
				TweenInfo.new(.25, easing_style.Quad, easing_direction.InOut),
				{ TextColor3 = Color3.fromHSV(0, 0, 0.592157) }
			):Play()

			TweenService:Create(
				SelectionLine,
				TweenInfo.new(.1, easing_style.Quad, easing_direction.InOut),
				{ BackgroundTransparency = 0 }
			):Play()

			TweenService:Create(
				PageFrame,
				TweenInfo.new(.25, easing_style.Quad, easing_direction.InOut),
				{ Size = UDim2.new(1,0,1,0) }
			):Play()
		end)

		function Page:addSection(SectionName)
			-- $$$$ Metadata
			local Section, Meta = {}, {}

			local SectionFrame = AddInstance("Frame", { Parent = PageFrame, AutomaticSize = Enum.AutomaticSize.Y; Name = [[Section]], BorderSizePixel = 0, Size = UDim2.new(1, 0, 0, 0), BorderColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 1, BackgroundColor3 = Color3.fromRGB(255, 255, 255),})
			local SectionLabel = AddInstance("TextLabel", { Parent = SectionFrame, Name = [[SectionLabel]], TextWrapped = true, BorderSizePixel = 0, TextYAlignment = Enum.TextYAlignment.Top, TextScaled = true, BackgroundColor3 = Color3.fromRGB(255, 255, 255), AnchorPoint = Vector2.new(0.5, 0.5), TextSize = 14, Size = UDim2.new(1, 0, 0, 14), LayoutOrder = -1, TextXAlignment = Enum.TextXAlignment.Left, BorderColor3 = Color3.fromRGB(0, 0, 0), Text = SectionName, FontFace = Font.new('rbxasset://fonts/families/GothamSSm.json', Enum.FontWeight.SemiBold, Enum.FontStyle.Normal), Position = UDim2.new(0.500000298, 0, 0.0535870567, 0), TextColor3 = Color3.fromRGB(172, 172, 172), BackgroundTransparency = 1,})
			local UIListLayout = AddInstance("UIListLayout", { Parent = SectionFrame, Padding = UDim.new(0, 10), SortOrder = Enum.SortOrder.LayoutOrder, HorizontalAlignment = Enum.HorizontalAlignment.Center,})
			local UIPadding = AddInstance("UIPadding", { Parent = SectionFrame, PaddingRight = UDim.new(0, 5), PaddingLeft = UDim.new(0, 5),})

			-- $$$$ Functions + Connections
			function Section:addKeybind(...)
				-- $$$$$ Metadata
				local Keybind, Meta = { Key = nil; Pressed = false; }, {
					title = 'Keybind';
					default = nil;
					mode = 'click';
					on_update = function()
						print('Keybind does not have the "on_update" connection binded.')
					end,
					on_press = function()
						print('Keybind does not have the "on_press" connection binded.')
					end,
					on_release = function()
						print('Keybind does not have the "on_release" connection binded.')
					end,
				}

				Meta = TableOverwrite(Meta, ... or {})
				if Meta.default then Keybind.Key = Enum.KeyCode[Meta.default] end
				local EditingKeybind = false

				-- $$$$$ Instances
				local KeybindFrame = AddInstance("Frame", { Parent = SectionFrame, Name = [[KeybindFrame]], BorderSizePixel = 0, Size = UDim2.new(1, 0, 0, 30), BorderColor3 = Color3.fromRGB(0, 0, 0), BackgroundColor3 = Color3.fromRGB(39, 39, 39),})
				local KeybindLabel = AddInstance("TextLabel", { Parent = KeybindFrame, Name = [[KeybindLabel]], TextWrapped = false, BorderSizePixel = 0, BackgroundColor3 = Color3.fromRGB(255, 255, 255), AnchorPoint = Vector2.new(0, 0.5), TextSize = 16, Size = UDim2.new(0.5, 0, 1, 0), TextXAlignment = Enum.TextXAlignment.Left, BorderColor3 = Color3.fromRGB(0, 0, 0), Text = Meta.title, Font = Enum.Font.GothamMedium, Position = UDim2.new(0, 0, 0.5, 0), TextColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1,})
				local KeybindBox = AddInstance("ImageLabel", { Parent = KeybindFrame, Name = [[InputBox]], AnchorPoint = Vector2.new(1, 0.5), Image = [[rbxassetid://114222904430574]], Selectable = true, BorderSizePixel = 0, Size = UDim2.new(0, 24, 0, 24), ScaleType = Enum.ScaleType.Fit, BorderColor3 = Color3.fromRGB(0, 0, 0), Position = UDim2.new(1, 0, 0.5, 0), BackgroundTransparency = 1, BackgroundColor3 = Color3.fromRGB(255, 255, 255),})
				local KeybindButton = AddInstance("TextButton", { Parent = KeybindBox, Name = [[Hitbox]], TextScaled = true; Text = `{Meta.default or '...'}`; BorderSizePixel = 0, BackgroundColor3 = Color3.fromRGB(255, 255, 255), TextSize = 14, Size = UDim2.new(1, 0, 1, 0), BorderColor3 = Color3.fromRGB(0, 0, 0), FontFace = Font.new('rbxasset://fonts/families/GothamSSm.json', Enum.FontWeight.SemiBold, Enum.FontStyle.Normal), TextColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1,})
				AddInstance("UIPadding", { Parent = KeybindFrame, PaddingRight = UDim.new(0, 3), PaddingLeft = UDim.new(0, 10),})
				AddInstance("UICorner", { Parent = KeybindFrame, CornerRadius = UDim.new(0, 4),})
				AddInstance("UIStroke", { Parent = KeybindFrame, Thickness = 2, Color = Color3.fromRGB(68, 68, 68),})

				-- $$$$$ Functions + Connections
				local Blacklist = {
					'RightSuper',
					'LeftSuper',
					'BackSlash',
					'Backspace',
					'Unknown',
					'Return',
					'Escape',
				}

				KeybindButton.MouseButton1Down:Connect(function()
					TweenService:Create(
						KeybindBox,
						tween_info.new(.25, easing_style.Quint, easing_direction.InOut),
						{ Size = UDim2.new(0,20,0,20) }
					):Play()
				end)

				KeybindButton.MouseButton1Up:Connect(function()
					TweenService:Create(
						KeybindBox,
						tween_info.new(.25, easing_style.Quint, easing_direction.InOut),
						{ Size = UDim2.new(0,24,0,24) }
					):Play()
				end)

				KeybindButton.MouseButton1Click:Connect(function()
					EditingKeybind = true
					KeybindButton.Text = '...'
					KeybindButton.TextColor3 = Color3.fromRGB(200, 200, 200)
				end)

				InputService.InputBegan:Connect(function(Input)
					if EditingKeybind then
						KeybindButton.TextColor3 = Color3.new(0.784, 0.784, 0.784)

						if table.find(Blacklist, tostring(Input.KeyCode):gsub('Enum.KeyCode.', '')) then
							Keybind.Key = nil
							KeybindButton.Text = '...'
							--KeybindButton.Size = UDim2.new(0, 30, 1, 0)	
							EditingKeybind = false
							return
						end

						Keybind.Key = Input.KeyCode
						KeybindButton.Text = tostring(Input.KeyCode):gsub('Enum.KeyCode.', '')
						Meta.on_update(Keybind.Key)

						--if KeybindButton.TextBounds.X > 30 then
						--	KeybindButton.Size = UDim2.new(0, KeybindButton.TextBounds.X + 6, 1, 0)	
						--end

						--if KeybindButton.TextBounds.X < 30 then
						--	KeybindButton.Size = UDim2.new(0, 30, 1, 0)	
						--end

						EditingKeybind = false 
						return
					end

					if Keybind.Key == nil then return end

					if Input.KeyCode == Keybind.Key then
						if Meta.mode == 'hold' then
							Keybind.Pressed = true
							Meta.on_press(Keybind.Key)
							--while Keybind.Pressed do task.wait()
							--end
						elseif Meta.mode == 'toggle' then
							Keybind.Pressed = not Keybind.Pressed
							while Keybind.Pressed do task.wait()
								Meta.on_press(Keybind.Key)
							end
						elseif Meta.mode == 'click' then
							Meta.on_press(Keybind.Key)
						end
					end
				end)

				InputService.InputEnded:Connect(function(Input)
					if Keybind.Key == nil then return end

					if Input.KeyCode == Keybind.Key and Meta.mode == 'hold' then
						Keybind.Pressed = false
						Meta.on_release(Keybind.Key)
					end
				end)
			end

			function Section:addSlider(...)
				-- $$$$$ Metadata
				local Slider, Meta = { Value = 0; }, {
					title = 'Slider';
					default = 0;
					min = 0;
					max = 100;
					suffix = '';
					decimals = false;
					callback = function()
						print('Slider does not have a callback binded.')
					end,
				}

				Meta = TableOverwrite(Meta, ... or {})

				-- $$$$$ Instances
				local SliderFrame = AddInstance("Frame", { Parent = SectionFrame, Name = [[SliderFrame]], BorderSizePixel = 0, Size = UDim2.new(1, 0, 0, 30), BorderColor3 = Color3.fromRGB(0, 0, 0), BackgroundColor3 = Color3.fromRGB(39, 39, 39),})
				local SliderLabel = AddInstance("TextLabel", { Parent = SliderFrame, Name = [[SliderLabel]], TextWrapped = false, BorderSizePixel = 0, BackgroundColor3 = Color3.fromRGB(255, 255, 255), AnchorPoint = Vector2.new(0, 0.5), TextSize = 16, Size = UDim2.new(0.5, 0, 1, 0), TextXAlignment = Enum.TextXAlignment.Left, BorderColor3 = Color3.fromRGB(0, 0, 0), Text = Meta.title, Font = Enum.Font.GothamMedium, Position = UDim2.new(0, 0, 0.5, 0), TextColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1,})
				local SliderBar = AddInstance("ImageButton", { Parent = SliderFrame, Name = [[SliderBar]], AnchorPoint = Vector2.new(1, 0.5), Image = [[rbxassetid://117462785670806]], BorderSizePixel = 0, Size = UDim2.new(0.5, -20, 0, 24), ScaleType = Enum.ScaleType.Fit, BorderColor3 = Color3.fromRGB(0, 0, 0), Position = UDim2.new(1, -3, 0.5, 0), BackgroundTransparency = 1, BackgroundColor3 = Color3.fromRGB(255, 255, 255),})
				local SliderFill = AddInstance("ImageLabel", { Parent = SliderBar, Name = [[SliderFill]], AnchorPoint = Vector2.new(0, 0.5), Image = [[rbxassetid://81914770912624]], BorderSizePixel = 0, Size = UDim2.new((Meta.default - Meta.min) / (Meta.max - Meta.min), 0, 1, 0), ScaleType = Enum.ScaleType.Slice, SliceCenter = Rect.new(12, 21, 268, 21), BorderColor3 = Color3.fromRGB(0, 0, 0), Position = UDim2.new(0, 0, 0.5, 0), BackgroundTransparency = 1, BackgroundColor3 = Color3.fromRGB(255, 255, 255),})
				local SliderValueLabel = AddInstance("TextLabel", { Parent = SliderBar, Name = [[SliderValueLabel]], TextWrapped = false, ZIndex = 2, BorderSizePixel = 0, TextScaled = true, BackgroundColor3 = Color3.fromRGB(255, 255, 255), AnchorPoint = Vector2.new(0.5, 0.5), TextSize = 14, Size = UDim2.new(1, 0, 1, 0), TextXAlignment = Enum.TextXAlignment.Left, BorderColor3 = Color3.fromRGB(0, 0, 0), Text = `{Meta.default}{Meta.suffix}`; FontFace = Font.new('rbxasset://fonts/families/GothamSSm.json', Enum.FontWeight.SemiBold, Enum.FontStyle.Normal), Position = UDim2.new(0.5, 0, 0.5, 0), TextColor3 = Color3.fromRGB(170, 170, 170), BackgroundTransparency = 1,})
				AddInstance("UIPadding", { Parent = SliderValueLabel, PaddingTop = UDim.new(0, 6), PaddingRight = UDim.new(0, 9), PaddingLeft = UDim.new(0, 8), PaddingBottom = UDim.new(0, 6),})
				AddInstance("UICorner", { Parent = SliderBar, CornerRadius = UDim.new(0.195121944, 0),})
				AddInstance("UICorner", { Parent = SliderFrame, CornerRadius = UDim.new(0, 4),})
				AddInstance("UIStroke", { Parent = SliderFrame, Thickness = 2, Color = Color3.fromRGB(68, 68, 68),})
				AddInstance("UIPadding", { Parent = SliderFrame, PaddingLeft = UDim.new(0, 10),})

				-- $$$$$ Functions + Connections
				local Player = Services.Players.LocalPlayer
				local Mouse = Player:GetMouse()

				local min = Meta.min
				local max = Meta.max
				local mouse_down = false
				local mouse_on = false

				Slider.Value = Meta.default
				SliderFill.Size = UDim2.new((Slider.Value - min) / (max - min), 0, 1, 0)
				SliderValueLabel.Text = tostring(Slider.Value):sub(1,4)

				local function update_value()
					local mouse_x = math.clamp(Mouse.X - SliderBar.AbsolutePosition.X, min, SliderBar.AbsoluteSize.X)

					if Meta.decimals then
						Slider.Value = (math.clamp((mouse_x / SliderBar.AbsoluteSize.X) * (max - min) + min, min, max))
						SliderValueLabel.Text = tostring(Slider.Value):sub(1,4)
					elseif not Meta.decimals then
						Slider.Value = math.floor(math.clamp((mouse_x / SliderBar.AbsoluteSize.X) * (max - min) + min, min, max))
						SliderValueLabel.Text = tostring(Slider.Value)
					end

					TweenService:Create(
						SliderFill,
						TweenInfo.new(0, easing_style.Quad, easing_direction.InOut),
						{ Size = UDim2.new((Slider.Value - min) / (max - min), 0, 1, 0) }
					):Play()

					Meta.callback(Slider.Value)
				end

				Mouse.Move:Connect(function() if mouse_down then update_value() end end)
				SliderBar.MouseButton1Down:Connect(function() mouse_down = true update_value() end)
				SliderBar.MouseButton1Up:Connect(function() mouse_down = false end)
				SliderBar.MouseEnter:Connect(function() mouse_on = true end)
				SliderBar.MouseLeave:Connect(function() mouse_on = false end)

				InputService.InputEnded:Connect(function(input)
					if input.UserInputType == Enum.UserInputType.MouseButton1 then
						mouse_down = false
					end
				end)

				return Slider
			end

			function Section:addTextbox(...)
				-- $$$$$ Metadata
				local Textbox, Meta = { Value = nil }, {
					title = 'Textbox';
					default = nil;
					callback = function()
						print('Textbox does not have a callback binded.')
					end,
				}

				Meta = TableOverwrite(Meta, ... or {})

				-- $$$$$ Instances
				local TextboxFrame = AddInstance("Frame", { Parent = SectionFrame, Name = [[TextboxFrame]], BorderSizePixel = 0, Size = UDim2.new(1, 0, 0, 30), BorderColor3 = Color3.fromRGB(0, 0, 0), BackgroundColor3 = Color3.fromRGB(39, 39, 39),})
				local TextboxLabel = AddInstance("TextLabel", { Parent = TextboxFrame, Name = [[TextboxLabel]], TextWrapped = false, BorderSizePixel = 0, BackgroundColor3 = Color3.fromRGB(255, 255, 255), AnchorPoint = Vector2.new(0, 0.5), TextSize = 16, Size = UDim2.new(0.5, 0, 1, 0), TextXAlignment = Enum.TextXAlignment.Left, BorderColor3 = Color3.fromRGB(0, 0, 0), Text = Meta.title, Font = Enum.Font.GothamMedium, Position = UDim2.new(0, 0, 0.5, 0), TextColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1,})
				local InputBox = AddInstance("ImageLabel", { Parent = TextboxFrame, Name = [[InputBox]], AnchorPoint = Vector2.new(1, 0.5), Image = [[rbxassetid://130232878751373]], BorderSizePixel = 0, Size = UDim2.new(0, 80, 0, 24), ScaleType = Enum.ScaleType.Fit, BorderColor3 = Color3.fromRGB(0, 0, 0), Position = UDim2.new(1, 0, 0.5, 0), BackgroundTransparency = 1, BackgroundColor3 = Color3.fromRGB(255, 255, 255),})
				local TextInputBox = AddInstance("TextBox", { Parent = InputBox, CursorPosition = -1, PlaceholderColor3 = Color3.fromRGB(125, 125, 125), BorderSizePixel = 0, TextScaled = true, BackgroundColor3 = Color3.fromRGB(255, 255, 255), AnchorPoint = Vector2.new(0.5, 0.5), TextWrapped = true, Text = Meta.default or ''; PlaceholderText = [[...]], TextSize = 14, Size = UDim2.new(1, 0, 0.5, 0), TextColor3 = Color3.fromRGB(178, 178, 178), BorderColor3 = Color3.fromRGB(0, 0, 0), FontFace = Font.new('rbxasset://fonts/families/GothamSSm.json', Enum.FontWeight.SemiBold, Enum.FontStyle.Normal), Position = UDim2.new(0.5, 0, 0.5, 0), BackgroundTransparency = 1,})
				AddInstance("UIPadding", { Parent = TextboxFrame, PaddingRight = UDim.new(0, 3), PaddingLeft = UDim.new(0, 10),})
				AddInstance("UIPadding", { Parent = TextInputBox, PaddingRight = UDim.new(0, 5), PaddingLeft = UDim.new(0, 5),})
				AddInstance("UICorner", { Parent = TextboxFrame, CornerRadius = UDim.new(0, 4),})
				AddInstance("UIStroke", { Parent = TextboxFrame, Thickness = 2, Color = Color3.fromRGB(68, 68, 68),})

				-- $$$$$ Functions + Connections
				TextInputBox.FocusLost:Connect(function()
					Textbox.Value = TextInputBox.Text
					Meta.callback(Textbox.Value)
				end)

				return Textbox
			end

			function Section:addDropdown(...)
				-- $$$$$ Metadata
				local Dropdown, Meta = { Selection = {}; Dropped = false }, {
					title = 'Dropdown';
					default = nil;
					mode = 'single';
					list = {};
					callback = function()
						print('Dropdown does not have a callback binded.')
					end,
				}

				Meta = TableOverwrite(Meta, ... or {})

				-- $$$$$ Instances
				local DropdownFrame = AddInstance("Frame", { Parent = SectionFrame, AutomaticSize = Enum.AutomaticSize.Y, Name = [[DropdownFrame]], Active = true, BorderSizePixel = 0, Size = UDim2.new(1, 0, 0, 30), BorderColor3 = Color3.fromRGB(0, 0, 0), BackgroundColor3 = Color3.fromRGB(39, 39, 39),})
				local OptionFrame = AddInstance("Frame", { Parent = DropdownFrame, AutomaticSize = Enum.AutomaticSize.Y, Name = [[OptionFrame]], Visible = false; BorderSizePixel = 0, Size = UDim2.new(1, 0, 0, 0), BorderColor3 = Color3.fromRGB(0, 0, 0), LayoutOrder = 1, Position = UDim2.new(0, 0, 0, 30), BackgroundTransparency = 1, BackgroundColor3 = Color3.fromRGB(255, 255, 255),})
				local TopbarFrame = AddInstance("Frame", { Parent = DropdownFrame, Name = [[TopbarFrame]], BorderSizePixel = 0, Size = UDim2.new(1, 0, 0, 30), BorderColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 1, BackgroundColor3 = Color3.fromRGB(255, 255, 255),})
				local DropdownButton = AddInstance("ImageButton", { Parent = TopbarFrame, Name = [[DropdownButton]], BackgroundTransparency = 1, AnchorPoint = Vector2.new(1, 0), Image = [[rbxassetid://76471184936187]], BorderSizePixel = 0, Size = UDim2.new(0, 8, 0, 8), BorderColor3 = Color3.fromRGB(0, 0, 0), Position = UDim2.new(1, 0, 0, 11), BackgroundColor3 = Color3.fromRGB(255, 255, 255),})
				local DropdownLabel = AddInstance("TextLabel", { Parent = TopbarFrame, Name = [[DropdownLabel]], TextWrapped = false, BorderSizePixel = 0, BackgroundColor3 = Color3.fromRGB(255, 255, 255), TextSize = 16, Size = UDim2.new(0.5, 0, 0, 30), TextXAlignment = Enum.TextXAlignment.Left, BorderColor3 = Color3.fromRGB(0, 0, 0), Text = Meta.title, Font = Enum.Font.GothamMedium, TextColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1,})
				AddInstance("UIListLayout", { Parent = OptionFrame, Padding = UDim.new(0, 0), SortOrder = Enum.SortOrder.LayoutOrder,})
				AddInstance("UIListLayout", { Parent = DropdownFrame, SortOrder = Enum.SortOrder.LayoutOrder,})
				AddInstance("UICorner", { Parent = DropdownFrame, CornerRadius = UDim.new(0, 4),})
				AddInstance("UIStroke", { Parent = DropdownFrame, Thickness = 2, Color = Color3.fromRGB(68, 68, 68),})
				AddInstance("UIPadding", { Parent = DropdownFrame, PaddingRight = UDim.new(0, 11), PaddingLeft = UDim.new(0, 10),})

				-- $$$$$ Populate Dropdown
				for Index, Option in Meta.list do
					local OptionButton = AddInstance("TextButton", { Parent = OptionFrame, Name = [[OptionButton]], TextYAlignment = Enum.TextYAlignment.Top; TextWrapped = false, BorderSizePixel = 0, BackgroundColor3 = Color3.fromRGB(255, 255, 255), TextSize = 14, Size = UDim2.new(1, 0, 0, 20), TextXAlignment = Enum.TextXAlignment.Left, BorderColor3 = Color3.fromRGB(0, 0, 0), Text = Option, Font = Enum.Font.Gotham, TextColor3 = Color3.fromRGB(164, 164, 164), BackgroundTransparency = 1,})
					OptionButton.MouseButton1Click:Connect(function()
						if Meta.mode == 'single' then
							for _, Button in OptionFrame:GetChildren() do
								if Button:IsA('TextButton') then
									Button.TextColor3 = Color3.fromRGB(164,164,164)
									Button.FontFace = Font.new(
										'rbxasset://fonts/families/GothamSSm.json', 
										Enum.FontWeight.Regular, 
										Enum.FontStyle.Normal
									)
								end
							end

							Dropdown.Selection[1] = Option
							Meta.callback(Dropdown.Selection)
							OptionButton.TextColor3 = Color3.fromRGB(200, 200, 200)
							OptionButton.FontFace = Font.new(
								'rbxasset://fonts/families/GothamSSm.json', 
								Enum.FontWeight.SemiBold, 
								Enum.FontStyle.Normal
							)
						elseif Meta.mode == 'multi' then
							if OptionButton:GetAttribute('Selected') == nil then 
								OptionButton:SetAttribute('Selected', false)
							end

							OptionButton:SetAttribute('Selected', not OptionButton:GetAttribute('Selected'))

							if OptionButton:GetAttribute('Selected') then
								table.insert(Dropdown.Selection, Option)
								Meta.callback(Dropdown.Selection)
								OptionButton.TextColor3 = Color3.fromRGB(200, 200, 200)
								OptionButton.FontFace = Font.new(
									'rbxasset://fonts/families/GothamSSm.json', 
									Enum.FontWeight.SemiBold, 
									Enum.FontStyle.Normal
								)
							elseif not OptionButton:GetAttribute('Selected') then
								for i, __ in Dropdown.Selection do
									if __ == Option then
										table.remove(Dropdown.Selection, i)
									end
								end
								Meta.callback(Dropdown.Selection)
								OptionButton.TextColor3 = Color3.fromRGB(164, 164, 164)
								OptionButton.FontFace = Font.new(
									'rbxasset://fonts/families/GothamSSm.json', 
									Enum.FontWeight.Regular, 
									Enum.FontStyle.Normal
								)
							end

							if #Dropdown.Selection > 0 then
								DropdownLabel.Text = `{Meta.title} ({#Dropdown.Selection})`
							elseif #Dropdown.Selection <= 0 then
								DropdownLabel.Text = Meta.title
							end
						end
					end)
				end

				-- $$$$$ Functions + Connections
				function Dropdown:addOption(Option)
					table.insert(Meta.list, Option)
					local OptionButton = AddInstance("TextButton", { Parent = OptionFrame, Name = [[OptionButton]],  TextYAlignment = Enum.TextYAlignment.Top; TextWrapped = false, BorderSizePixel = 0, BackgroundColor3 = Color3.fromRGB(255, 255, 255), TextSize = 14, Size = UDim2.new(1, 0, 0, 15), TextXAlignment = Enum.TextXAlignment.Left, BorderColor3 = Color3.fromRGB(0, 0, 0), Text = [[Option1]], Font = Enum.Font.Gotham, TextColor3 = Color3.fromRGB(164, 164, 164), BackgroundTransparency = 1,})
					OptionButton.MouseButton1Click:Connect(function()
						if Meta.mode == 'single' then
							for _, Button in OptionFrame:GetChildren() do
								if Button:IsA('TextButton') then
									Button.TextColor3 = Color3.fromRGB(164,164,164)
									Button.FontFace = Font.new(
										'rbxasset://fonts/families/GothamSSm.json', 
										Enum.FontWeight.Regular, 
										Enum.FontStyle.Normal
									)
								end
							end

							Dropdown.Selection[1] = Option
							Meta.callback(Dropdown.Selection)
							OptionButton.TextColor3 = Color3.fromRGB(200, 200, 200)
							OptionButton.FontFace = Font.new(
								'rbxasset://fonts/families/GothamSSm.json', 
								Enum.FontWeight.SemiBold, 
								Enum.FontStyle.Normal
							)
						elseif Meta.mode == 'multi' then
							if OptionButton:GetAttribute('Selected') == nil then 
								OptionButton:SetAttribute('Selected', false)
							end

							OptionButton:SetAttribute('Selected', not OptionButton:GetAttribute('Selected'))

							if OptionButton:GetAttribute('Selected') then
								table.insert(Dropdown.Selection, Option)
								Meta.callback(Dropdown.Selection)
								OptionButton.TextColor3 = Color3.fromRGB(200, 200, 200)
								OptionButton.FontFace = Font.new(
									'rbxasset://fonts/families/GothamSSm.json', 
									Enum.FontWeight.SemiBold, 
									Enum.FontStyle.Normal
								)
							elseif not OptionButton:GetAttribute('Selected') then
								for i, __ in Dropdown.Selection do
									if __ == Option then
										table.remove(Dropdown.Selection, i)
									end
								end
								Meta.callback(Dropdown.Selection)
								OptionButton.TextColor3 = Color3.fromRGB(164, 164, 164)
								OptionButton.FontFace = Font.new(
									'rbxasset://fonts/families/GothamSSm.json', 
									Enum.FontWeight.Regular, 
									Enum.FontStyle.Normal
								)
							end
						end
					end)
				end

				DropdownButton.MouseButton1Click:Connect(function()
					Dropdown.Dropped = not Dropdown.Dropped
					DropdownButton.Rotation = Dropdown.Dropped and 180 or 0
					OptionFrame.Visible = Dropdown.Dropped

					for _, Button in OptionFrame:GetChildren() do
						if Button:IsA('TextButton') then
							Button.Size = UDim2.new(1, 0, 0, 0)
							Button.TextTransparency = 1

							TweenService:Create(
								Button,
								tween_info.new(.45, easing_style.Quart), {
									Size = UDim2.new(1, 0, 0, 20),
									TextTransparency = 0,
								}
							):Play()
						end
					end
				end)

				return Dropdown
			end

			function Section:addToggle(...)
				-- $$$$$ Metadata
				local Toggle, Meta = { Value = false }, {
					title = 'Toggle';
					toggled = false;
					callback = function()
						print('Toggle does not have a callback binded.')
					end;
				}

				Meta = TableOverwrite(Meta, ... or {})

				-- $$$$$ Instances
				local ToggleFrame = AddInstance("Frame", { Parent = SectionFrame, Name = [[ToggleFrame]], BorderSizePixel = 0, Size = UDim2.new(1, 0, 0, 30), BorderColor3 = Color3.fromRGB(0, 0, 0), BackgroundColor3 = Color3.fromRGB(39, 39, 39),})
				local ToggleLabel = AddInstance("TextLabel", { Parent = ToggleFrame, Name = [[ToggleLabel]], TextWrapped = false, BorderSizePixel = 0, BackgroundColor3 = Color3.fromRGB(255, 255, 255), AnchorPoint = Vector2.new(0, 0.5), TextSize = 16, Size = UDim2.new(0.5, 0, 1, 0), TextXAlignment = Enum.TextXAlignment.Left, BorderColor3 = Color3.fromRGB(0, 0, 0), Text = Meta.title, Font = Enum.Font.GothamMedium, Position = UDim2.new(0, 0, 0.5, 0), TextColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1,})
				local ToggleButton = AddInstance("ImageButton", { Parent = ToggleFrame, Name = [[ToggleButton]], BackgroundTransparency = 1, ScaleType = Enum.ScaleType.Fit, AnchorPoint = Vector2.new(1, 0.5), Image = [[rbxassetid://123317618042392]], BorderSizePixel = 0, Size = UDim2.new(0, 40, 0, 20), BorderColor3 = Color3.fromRGB(0, 0, 0), Position = UDim2.new(1, 5, 0.5, 0), BackgroundColor3 = Color3.fromRGB(255, 255, 255),})
				local ToggleCircle = AddInstance("ImageLabel", { Parent = ToggleButton, Name = [[On]], AnchorPoint = Vector2.new(0, 0.5), Image = [[rbxassetid://112376976170886]], BorderSizePixel = 0, Size = UDim2.new(0.388059705, 0, 0.81250006, 0), ScaleType = Enum.ScaleType.Fit, BorderColor3 = Color3.fromRGB(0, 0, 0), Position = UDim2.new(0, 0, 0.5, 0), BackgroundTransparency = 1, BackgroundColor3 = Color3.fromRGB(255, 255, 255),})
				AddInstance("UICorner", { Parent = ToggleFrame, CornerRadius = UDim.new(0, 4),})
				AddInstance("UIStroke", { Parent = ToggleFrame, Thickness = 2, Color = Color3.fromRGB(68, 68, 68),})
				AddInstance("UIPadding", { Parent = ToggleButton, PaddingRight = UDim.new(0, 3), PaddingLeft = UDim.new(0, 3),})
				AddInstance("UIPadding", { Parent = ToggleFrame, PaddingRight = UDim.new(0, 10), PaddingLeft = UDim.new(0, 10),})

				-- $$$$$ Functions + Connections
				ToggleButton.MouseButton1Click:Connect(function()
					Toggle.Value = not Toggle.Value
					Meta.callback(Toggle.Value)

					TweenService:Create(
						ToggleCircle,
						TweenInfo.new(.1, easing_style.Quad, easing_direction.InOut), {
							Position = Toggle.Value and UDim2.new(1,0,0.5,0) or UDim2.new(0,0,0.5,0);
							AnchorPoint = Toggle.Value and Vector2.new(1,0.5) or Vector2.new(0,0.5);
						}
					):Play()
				end)

				return Toggle
			end

			return Section
		end

		return Page
	end

	return Window
end

return Vigil
