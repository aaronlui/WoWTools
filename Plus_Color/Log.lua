local e= select(2, ...)
local function Save()
	return WoWTools_ColorMixin.Save
end

local Textures={}










local function Set_SaveList()
	local n= #Save().logColor
	local logColor= Save().logColor
	for i=1, n do
		local texture= Textures[i]
		local col= logColor[i]
		if not Textures[i] then
			texture= WoWTools_ColorMixin:Create_Texture(col.r, col.g, col.b, 1)--记录，打开时的颜色， 和历史
			if i==1 then
				texture:SetPoint('TOPRIGHT', ColorPickerFrame, "TOPLEFT", 0, -20)
			else
				texture:SetPoint('TOP', Textures[i-1], 'BOTTOM')
			end
			table.insert(Textures, texture)
		end
		texture.r, texture.g, texture.b, texture.a= col.r, col.g, col.b, col.a
		texture:SetColorTexture(col.r, col.g, col.b , col.a)
		texture:SetShown(true)
	end

	for i= 11, n, 10 do
		Textures[i]:ClearAllPoints()
		Textures[i]:SetPoint('TOPRIGHT', Textures[i-10], 'TOPLEFT')
	end

	for i=n+1, #Textures, 1 do
		Textures[i]:SetShown(false)
	end
end















local function Init_Menu(self, root)
	local sub
--颜色


	local function set_tooltip(tooltip, desc)
		tooltip:AddDoubleLine(
			'r'..tonumber(format('%.2f',desc.data.r))
			..'  g'..tonumber(format('%.2f',desc.data.g))
			..'  b'..tonumber(format('%.2f',desc.data.b)),

            'a'..(desc.data.a and tonumber(format('%.2f',desc.data.a) or 1))
        )
	end

	local function add_texture(button, desc)
		local icon = button:AttachTexture()
		icon:SetSize(20, 20);
		icon:SetPoint("RIGHT")
		icon:SetColorTexture(desc.data.r, desc.data.g, desc.data.b, 1)
		return 20 + button.fontString:GetUnboundedStringWidth(), 20
	end

--当前
	sub= root:CreateButton('|cffffd100'..(e.onlyChinese and '当前' or REFORGE_CURRENT),
		function ()
			return MenuResponse
		end,
		{r=self.r, g=self.g, b=self.b, a=self.a or 1}
	)
	sub:AddInitializer(add_texture)
	sub:SetTooltip(set_tooltip)
	root:CreateDivider()

--替换
	local col=select(5, WoWTools_ColorMixin:Get_ColorFrameRGBA())
	sub= root:CreateButton(
		(self.r==col.r and self.g==col.g and self.b==col.b and self.a==self.a and '|cff828282' or '|cnGREEN_FONT_COLOR:')
		..(e.onlyChinese and '替换' or REPLACE),
	function(data)
		Save().saveColor[self.index]= {data.r, data.g, data.b, data.a}
		self.r, self.g, self.b, self.a= data.r, data.g, data.b, data.a
		self:SetColorTexture(data.r, data.g, data.b)
		print(WoWTools_ColorMixin.addName, e.onlyChinese and '替换成功' or format(CLUB_FINDER_LOOKING_FOR_CLASS_SPEC, REPLACE, COMPLETE))
		return MenuResponse
	end, col)
	sub:AddInitializer(add_texture)
	sub:SetTooltip(set_tooltip)
end




local function Init()
	Save().logColor= Save().logColor or {}
	Save().saveColor= Save().saveColor or {}

	ColorPickerFrame.Content.ColorSwatchCurrent:HookScript('OnLeave', function(self)
		e.tips:Hide()
		self:SetAlpha(1)
	end)
	ColorPickerFrame.Content.ColorSwatchCurrent:HookScript('OnEnter', function(self)
		e.tips:SetOwner(self, "ANCHOR_LEFT")
        e.tips:ClearLines()
		e.tips:AddLine(e.onlyChinese and "当前颜色" or format(CLUB_FINDER_LOOKING_FOR_CLASS_SPEC, REFORGE_CURRENT, COLOR))
		e.tips:Show()
		self:SetAlpha(0.5)
	end)

	ColorPickerFrame.Content.ColorSwatchOriginal:HookScript('OnLeave', function(self)
		e.tips:Hide()
		self:SetAlpha(1)
	end)
	ColorPickerFrame.Content.ColorSwatchOriginal:HookScript('OnEnter', function(self)
		local r,g,b,a= ColorPickerFrame:GetPreviousValues()
		e.tips:SetOwner(self, "ANCHOR_LEFT")
        e.tips:ClearLines()
		e.tips:AddDoubleLine(e.onlyChinese and "初始|n匹配值" or BATTLEGROUND_MATCHMAKING_VALUE, e.Icon.left)
		if r and g and b then
			e.tips:AddLine(' ')
			e.tips:AddDoubleLine(
				format(
					'r='..tonumber(format('%.2f', r))
					..'  g='..tonumber(format('%.2f', g))
					..'  b='..tonumber(format('%.2f', b))
				),
            	a and tonumber(format('%.2f', a)) or 1
			)
		end
		e.tips:Show()
		self:SetAlpha(0.5)
	end)
	ColorPickerFrame.Content.ColorSwatchOriginal:HookScript('OnMouseDown', function()
		local r,g,b,a= ColorPickerFrame:GetPreviousValues()
		if r and g and b then
			ColorPickerFrame.Content.ColorPicker:SetColorRGB(r, g, b)
			if ColorPickerFrame.hasOpacity then
				ColorPickerFrame.Content.ColorPicker:SetColorAlpha(a or 1)
			end
		end
	end)
	hooksecurefunc(ColorPickerFrame, 'SetupColorPickerAndShow', Set_SaveList)
	Set_SaveList()


--保存，记录数量
	ColorPickerFrame.Footer.OkayButton:HookScript('OnClick', function()
		local r, g, b, a= WoWTools_ColorMixin:Get_ColorFrameRGBA()
		for _, col in pairs(Save().logColor) do
			if col.r==r and col.g==g and col.b==b and col.a== a then
				return
			end
		end

		if #Save().logColor >=30 then--记录数量
			table.remove(Save().logColor, 1)
		end
		table.insert(Save().logColor,{r=r, g=g, b=b, a=a})
	end)

	--RestColor= WoWTools_ColorMixin:Create_Texture(e.Player.r, e.Player.g, e.Player.b, 1)--记录，打开时的颜色， 和历史
	--RestColor:SetPoint('TOPRIGHT', ColorPickerFrame.Content.ColorSwatchCurrent, 'TOPRIGHT', 10,0)

--保存，颜色
	for index, color in pairs(
		{
			{1, 0.82, 0, 1},
			{1, 0, 1, 1},
			{1, 1, 0, 1},
			{0, 1, 0, 1}
		}
	) do
		local col= Save().saveColor[index] or color
		local r,g,b,a= col[1],col[2],col[3], col[4] or 1
		local icon= WoWTools_ColorMixin:Create_Texture(r,g,b,a)--记录，打开时的颜色， 和历史
		local s= icon:GetWidth()
		if index==1 then
			icon:SetPoint('TOPLEFT', ColorPickerFrame.Content.ColorSwatchOriginal, 'BOTTOMLEFT', 0, 0)
		elseif index==2 then
			icon:SetPoint('TOPLEFT', ColorPickerFrame.Content.ColorSwatchOriginal, 'BOTTOMLEFT', 0, -s)
		elseif index==3 then
			icon:SetPoint('TOPLEFT', ColorPickerFrame.Content.ColorSwatchOriginal, 'BOTTOMLEFT', s, 0)
		else
			icon:SetPoint('TOPLEFT', ColorPickerFrame.Content.ColorSwatchOriginal, 'BOTTOMLEFT', s, -s)
		end
		icon.index= index
		icon.tooltip= function(self)
			e.tips:AddLine(' ')
			e.tips:AddDoubleLine(
				(e.onlyChinese and '常用颜色' or format(CLUB_FINDER_LOOKING_FOR_CLASS_SPEC, SAVE, COLOR))..' '..self.index,
				(e.onlyChinese and '替换' or REPLACE)..e.Icon.right
			)
		end
		icon.notClick='RightButton'
		icon:HookScript('OnMouseDown', function(self, d)
			if d=='RightButton' then
				MenuUtil.CreateContextMenu(self, Init_Menu)
			end
		end)
	end
end













function WoWTools_ColorMixin:Init_Log()
	Init()
end


--清除记录
function WoWTools_ColorMixin:Clear_Log()
	self.Save.logColor={}
	Set_SaveList()
end