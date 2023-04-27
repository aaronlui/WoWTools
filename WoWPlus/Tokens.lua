local id, e = ...
local addName=TOKENS
local Save={
	Hide=true,
	str=true,
	tokens={},--{[currencyID]=true}指定显示，表
	--indicato=nil,--指定显示
}
local button


local Get_Currency= function(tab)--e.Get_Currency({id=nil, index=nil, link=nil, soloValue=nil, showIcon=true, showName=true, showID=true, bit=3, showMax=nil})--货币
    local info = tab.index and C_CurrencyInfo.GetCurrencyListInfo(tab.index) or tab.id and C_CurrencyInfo.GetCurrencyInfo(tab.id) or C_CurrencyInfo.GetCurrencyInfoFromLink(tab.link)
    if not info then--or (not info.discovered and info.quality==0 and not info.isHeader) then
        return
    end
    if tab.soloValue then--仅，返回值
        return info
    end

    if info.isHeader then
        return tab.showName and (tab.showIcon and '|A:'..e.Icon.icon..':0:0|a|cffffffff' or '')..info.name..'|r'
    end
    if not info.quantity or info.quality==0 then
        return
    end
    local t=''
    t= tab.showName and '   ' or t
    if tab.showID then--显示ID
        local ID= tab.id or tab.link and C_CurrencyInfo.GetCurrencyIDFromLink(tab.link)
        if tab.index then
            local link=tab.link or C_CurrencyInfo.GetCurrencyListLink(tab.index)
            ID= link and C_CurrencyInfo.GetCurrencyIDFromLink(link)
        end
        if ID then
            t= ID and t..ID..' ' or t
        end
    end
    if tab.showIcon and info.iconFileID then--图标
        t= t..'|T'..info.iconFileID..':0|t'
    end
    if tab.showName and info.name then--名称
        t= t..info.name..' '
    end

    local max= info.quantity and info.quantity>0 and (
            info.quantity==info.maxQuantity--最大数
        or (info.canEarnPerWeek and info.maxWeeklyQuantity==info.quantityEarnedThisWeek)--本周
        or (info.useTotalEarnedForMaxQty and info.totalEarned==info.maxQuantity)--赛季
    )
    if max then--最大数量
        t=t..'|cnRED_FONT_COLOR:'..e.MK(info.quantity, tab.bit)..'|r'..e.Icon.O2
    else
        t=t..e.MK(info.quantity, tab.bit)..(tab.showMax and info.maxQuantity and info.maxQuantity>0 and ' /'..e.MK(info.maxQuantity, tab.bit) or '')
    end

    if info.canEarnPerWeek and info.quantityEarnedThisWeek< info.maxWeeklyQuantity then--本周,收入
        t= t..' |cnGREEN_FONT_COLOR:(+'..e.MK(info.maxWeeklyQuantity - info.quantityEarnedThisWeek, tab.bit)..'|r'
    elseif info.useTotalEarnedForMaxQty and info.totalEarned< info.maxQuantity  and info.totalEarned< info.maxQuantity then--赛季,收入
        t= t..' |cnGREEN_FONT_COLOR:(+'..e.MK(info.maxQuantity- info.totalEarned, tab.bit)..'|r'
    end

    return t
end

--#############
--套装,转换,货币
--Blizzard_ItemInteractionUI.lua
local function set_ItemInteractionFrame_Currency(self)
	if not self then
		return
	end
    local itemInfo= C_ItemInteraction.GetItemInteractionInfo()
    local currencyID= itemInfo and itemInfo.currencyTypeId or self.chargeCurrencyTypeId or 2533--2167

	if self==ItemInteractionFrame then
		TokenFrame.chargeCurrencyTypeId= currencyID
	end

    local info= C_CurrencyInfo.GetCurrencyInfo(currencyID)
	local text
    if info and info.quantity and (info.discovered or info.quantity>0) then
        text= info.iconFileID and '|T'..info.iconFileID..':0|t' or ''
        text= text.. info.quantity
        text= info.maxQuantity and text..'/'..info.maxQuantity or text
        if not self.ItemInteractionFrameCurrencyText then
            self.ItemInteractionFrameCurrencyText= e.Cstr(self)
            self.ItemInteractionFrameCurrencyText:SetPoint('TOPLEFT', 55, -38)
			self.ItemInteractionFrameCurrencyText:EnableMouse(true)
			self.ItemInteractionFrameCurrencyText:SetScript('OnEnter', function(self2)
				if self2.chargeCurrencyTypeId then
					e.tips:SetOwner(self2, "ANCHOR_LEFT")
					e.tips:ClearLines()
					e.tips:SetCurrencyByID(self2.chargeCurrencyTypeId)
					e.tips:AddLine(' ')
					e.tips:AddDoubleLine(id, addName)
					e.tips:Show()
				end
			end)
			self.ItemInteractionFrameCurrencyText:SetScript('OnLeave', function() e.tips:Hide() end)
        end
		self.ItemInteractionFrameCurrencyText.chargeCurrencyTypeId= currencyID

        local chargeInfo = C_ItemInteraction.GetChargeInfo()
        local timeToNextCharge = chargeInfo.timeToNextCharge
        if (self.interactionType == Enum.UIItemInteractionType.ItemConversion) and timeToNextCharge>0 then
            text= text ..' |cnGREEN_FONT_COLOR:'..SecondsToClock(timeToNextCharge, true)..'|r'
        end

		if info.canEarnPerWeek and info.maxWeeklyQuantity and info.maxWeeklyQuantity>0 then
			text= text..' ('..info.quantityEarnedThisWeek..'/'..info.maxWeeklyQuantity..')'
		end
    end

	if self.ItemInteractionFrameCurrencyText then
		self.ItemInteractionFrameCurrencyText:SetText(text or '')
	end
end


local function set_Text()
	if not Save.str or not button.btn or not button.btn:IsShown() then
		if button.btn then
			button.btn.text:SetText('')
		end
		return
	end
	local m=''

	if Save.indicato then
		local tab={}
		for currentID, index in pairs(Save.tokens) do
			table.insert(tab, {currentID= currentID, index=index==true and 1 or index})
		end
		table.sort(tab, function(a,b) return a.index< b.index end)
		for _, info in pairs(tab) do
			local text= Get_Currency({id=info.currentID, index=nil, link=nil, soloValue=nil, showIcon=true, showName=Save.nameShow, showID=Save.showID, bit=3, showMax=nil})--货币
			if text then
				m= m..text..'\n' or m
			end
		end
	else
		for index=1, C_CurrencyInfo.GetCurrencyListSize() do
			local text= Get_Currency({id=nil, index=index, link=nil, soloValue=nil, showIcon=true, showName=Save.nameShow, showID=Save.showID, bit=3, showMax=nil})--货币
			if text then
				m= m..text..'\n' or m
			end
		end
	end
	if m=='' then
		m='..'
	end
	button.btn:SetNormalTexture(0)
	button.btn.text:SetText(m)
end


local function Set()
	button:SetNormalAtlas(not Save.Hide and e.Icon.icon or e.Icon.disabled)
	if not Save.Hide and not button.btn then--监视声望按钮
		button.btn=e.Cbtn(nil, {icon=Save.str, size={18,18}})
		if Save.point then
			button.btn:SetPoint(Save.point[1], UIParent, Save.point[3], Save.point[4], Save.point[5])
		else
			button.btn:SetPoint('TOPLEFT', TokenFrame, 'TOPRIGHT',0, -35)
		end
		button.btn:RegisterForDrag("RightButton")
		button.btn:SetClampedToScreen(true);
		button.btn:SetMovable(true);
		button.btn:SetScript("OnDragStart", function(self2, d) if d=='RightButton' and not IsModifierKeyDown() then self2:StartMoving() end end)
		button.btn:SetScript("OnDragStop", function(self2)
				ResetCursor()
				self2:StopMovingOrSizing()
				Save.point={self2:GetPoint(1)}
				Save.point[2]=nil
		end)
		button.btn:SetScript("OnMouseUp", function() ResetCursor() end)
		button.btn:SetScript("OnMouseDown", function(self2, d)
			local key=IsModifierKeyDown()
			if d=='RightButton' and not key then--右击,移动
				SetCursor('UI_MOVE_CURSOR')

			elseif d=='LeftButton' and not key then--点击,显示隐藏
				Save.str= not Save.str and true or nil
				button.btn:SetNormalAtlas(Save.str and e.Icon.icon or e.Icon.disabled)
				print(id, addName, e.GetShowHide(Save.str))
				set_Text()

			elseif d=='LeftButton' and IsAltKeyDown() then--显示名称
				Save.nameShow= not Save.nameShow and true or nil
				set_Text()
				print(id, addName, SHOW, NAME, e.GetShowHide(Save.nameShow))

			elseif d=='LeftButton' and IsControlKeyDown() then --显示ID
				Save.showID= not Save.showID and true or nil
				print(id, addName, SHOW, 'ID', e.GetShowHide(Save.showID))
				set_Text()
			end
		end)
		button.btn:SetScript("OnEnter",function(self2)
			e.tips:SetOwner(self2, "ANCHOR_LEFT");
			e.tips:ClearLines();
			e.tips:AddDoubleLine((e.onlyChinese and '文本' or LOCALE_TEXT_LABEL)..': '..e.GetShowHide(Save.str),e.Icon.left)
			e.tips:AddDoubleLine(e.onlyChinese and '移动' or NPE_MOVE, e.Icon.right)
			e.tips:AddLine(' ')
			e.tips:AddDoubleLine(e.onlyChinese and '打开/关闭货币页面' or BINDING_NAME_TOGGLECURRENCY, e.Icon.mid)
			e.tips:AddDoubleLine((e.onlyChinese and '字体大小' or FONT_SIZE)..(Save.size or 12), 'Alt+'..e.Icon.mid)
			e.tips:AddLine(' ')
			e.tips:AddDoubleLine((e.onlyChinese and '名称' or NAME)..': '..e.GetShowHide(Save.nameShow), 'Alt+'..e.Icon.left)
			e.tips:AddDoubleLine('ID: '..e.GetShowHide(Save.showID), 'Ctrl+'..e.Icon.left)
			e.tips:AddLine(' ')
			e.tips:AddDoubleLine(id, addName)
			e.tips:Show();
		end)
		button.btn:SetScript("OnLeave", function(self2)
			self2:SetButtonState("NORMAL")
			ResetCursor()
			e.tips:Hide()
		end);
		button.btn:EnableMouseWheel(true)
		button.btn:SetScript("OnMouseWheel", function (self2, d)
			if IsAltKeyDown() then
				local n= Save.size or 12
				if d==1 then
					n= n+ 1
				elseif d==-1 then
					n= n- 1
				end
				n= n<6 and 6 or n
				n= n>32 and 32 or n
				Save.size=n
				e.Cstr(nil, {size=n, changeFont=button.btn.text, color=true})--n, nil, button.btn.text, true)
				print(id, addName, e.onlyChinese and '文本' or LOCALE_TEXT_LABEL, e.onlyChinese and '字体大小' or FONT_SIZE, n)
			else
				if d==1 and not TokenFrame:IsVisible() or d==-1 and TokenFrame:IsVisible() then
					ToggleCharacter("TokenFrame")--打开货币
				end
			end
		end)
		button.btn:RegisterEvent('CURRENCY_DISPLAY_UPDATE')
		button.btn:RegisterEvent('PLAYER_ENTERING_WORLD')
		button.btn:RegisterEvent('PET_BATTLE_OPENING_DONE')
		button.btn:RegisterEvent('PET_BATTLE_CLOSE')
		button.btn:SetScript('OnEvent', function(self)
			self:SetShown(not Save.Hide and not IsInInstance() and not C_PetBattles.IsInBattle())
			set_Text()
		end)

		button.btn.text=e.Cstr(button.btn, {size=Save.size, color=true})--内容显示文本
		button.btn.text:SetPoint('TOPLEFT',3,-3)
	end
	if button.btn then
		button.btn:SetShown(not Save.Hide and not IsInInstance() and not C_PetBattles.IsInBattle())
		button.btn:SetNormalAtlas(Save.str and e.Icon.icon or e.Icon.disabled)
		set_Text()
	end
end


local function set_Tokens_Button(frame)--设置, 列表, 内容
	if not frame or not frame.index then
		return
	end
	local info = C_CurrencyInfo.GetCurrencyListInfo(frame.index)
	local link= C_CurrencyInfo.GetCurrencyListLink(frame.index)
	local currencyID= link and C_CurrencyInfo.GetCurrencyIDFromLink(link)
	if not frame.isHeader and info and currencyID  and not frame.check then
		frame.check= CreateFrame("CheckButton", nil, frame, "InterfaceOptionsCheckButtonTemplate")
		frame.check:SetPoint('LEFT', -3,0)
		frame.check:SetScript('OnClick', function(self)
			if self.currencyID then
				Save.tokens[self.currencyID]= not Save.tokens[self.currencyID] and self.index or nil
				frame.check:SetAlpha(Save.tokens[self.currencyID] and 1 or 0.5)
				set_Text()--设置, 文本
			end
		end)
		frame.check:SetScript('OnEnter', function(self)
			e.tips:SetOwner(self, "ANCHOR_RIGHT")
			e.tips:ClearLines()
			if self.currencyID then
				local info2=C_CurrencyInfo.GetCurrencyInfo(self.currencyID)
				if info2 and info2.name then
					e.tips:AddDoubleLine(info2.name, self.currencyID, 0,1,0, 0,1,0)
					e.tips:AddLine(' ')
				end
			end
			e.tips:AddDoubleLine((e.onlyChinese and '文本' or  LOCALE_TEXT_LABEL), e.onlyChinese and '指定' or COMBAT_ALLY_START_MISSION)
			e.tips:AddDoubleLine(id, addName)
			e.tips:Show()
		end)
		frame.check:SetScript('OnLeave', function() e.tips:Hide() end)
		frame.check:SetSize(15,15)
		frame.check:SetCheckedTexture(e.Icon.icon)
	end

	if frame.check then
		frame.check.currencyID= currencyID
		frame.check.index= frame.index
		frame.check:SetShown(not frame.isHeader)
		frame.check:SetChecked(Save.tokens[currencyID])
		frame.check:SetAlpha(Save.tokens[currencyID] and 1 or 0.5)
	end

	if info and frame.Count then--最大数
		local max= info.quantity and info.quantity>0 and (
						info.quantity==info.maxQuantity
					or (info.canEarnPerWeek and info.maxWeeklyQuantity==info.quantityEarnedThisWeek)--本周
					or (info.useTotalEarnedForMaxQty and info.totalEarned==info.maxQuantity)--赛季
				)
		if max then
			frame.Count:SetTextColor(1,0,0)
		elseif info.useTotalEarnedForMaxQty or info.canEarnPerWeek then
			frame.Count:SetTextColor(1,0,1)
		elseif info.maxQuantity and info.maxQuantity>0 then
			frame.Count:SetTextColor(0,1,0)
		else
			frame.Count:SetTextColor(1,1,1)
		end
	end
end

--######
--初始化
--######
local function Init()
	button= e.Cbtn(TokenFrame, {icon=false, size={18,18}})
	button:SetPoint("TOPRIGHT", TokenFrame, 'TOPRIGHT',-6,-35)
	button:SetScript('OnClick', function (self, d)
		Save.Hide= not Save.Hide and true or nil
		print(id, addName, e.GetEnabeleDisable(not Save.Hide))
		Set()
		if button.btn then
			button.btn:SetButtonState('PUSHED')
		end
		if Save.Hide then
			button.indcatoCheck.text:SetTextColor(0.82, 0.82, 0.82, 0.5)
		else
			button.indcatoCheck.text:SetTextColor(1, 1, 1, 1)
		end
	end)
	button:SetScript("OnEnter", function(self2)
		e.tips:SetOwner(self2, "ANCHOR_LEFT")
		e.tips:ClearLines()
		e.tips:AddDoubleLine((e.onlyChinese and '文本' or  LOCALE_TEXT_LABEL)..': '..e.GetEnabeleDisable(not Save.Hide),e.Icon.left)
		e.tips:AddLine(' ')
		e.tips:AddDoubleLine(e.onlyChinese and '副本/宠物对战' or INSTANCE..'/'..SHOW_PET_BATTLES_ON_MAP_TEXT, e.GetEnabeleDisable(false))
		e.tips:AddDoubleLine(id, addName)
		e.tips:Show()
	end)
	button:SetScript('OnLeave', function ()
		e.tips:Hide()
	end)

	--展开,合起
	button.down=e.Cbtn(button, {icon=false, size={18,18}});
	button.down:SetPoint('RIGHT', button, 'LEFT', -2,0)
	button.down:SetNormalTexture('Interface\\Buttons\\UI-MinusButton-Up')
	button.down:SetScript("OnMouseDown", function(self)
			for i=1, C_CurrencyInfo.GetCurrencyListSize() do--展开所有
				local info = C_CurrencyInfo.GetCurrencyListInfo(i)
				if info  and info.isHeader and not info.isHeaderExpanded then
					C_CurrencyInfo.ExpandCurrencyList(i,true);
				end
			end
			TokenFrame_Update()
	end)
	button.up=e.Cbtn(button, {icon=false, size={18,18}})
	button.up:SetPoint('RIGHT', button.down, 'LEFT',-2,0)
	button.up:SetSize(18,18);
	button.up:SetNormalTexture("Interface\\Buttons\\UI-PlusButton-Up")
	button.up:SetScript("OnMouseDown", function(self)
			for i=1, C_CurrencyInfo.GetCurrencyListSize() do--展开所有
				local info = C_CurrencyInfo.GetCurrencyListInfo(i);
				if info  and info.isHeader and info.isHeaderExpanded then
					C_CurrencyInfo.ExpandCurrencyList(i, false);
				end
			end
			TokenFrame_Update();
	end)
	button.bag=e.Cbtn(button, {icon='hide', size={18,18}})
	button.bag:SetPoint('RIGHT', button.up, 'LEFT',-2,0)
	button.bag:SetNormalAtlas(e.Icon.bag)
	button.bag:SetScript("OnMouseDown", function(self)
		for index=1, BackpackTokenFrame:GetMaxTokensWatched() do--Blizzard_TokenUI.lua
			local info = C_CurrencyInfo.GetBackpackCurrencyInfo(index)
			if info then
				local link=C_CurrencyInfo.GetCurrencyLink(info.currencyTypesID) or info.name
				--C_CurrencyInfo.SetCurrencyBackpack(index, false)
				print(link)
			end
		end
		ToggleAllBags()
		TokenFrame_Update();
	end)
	button.bag:SetScript('OnEnter', function(self2)
		e.tips:SetOwner(self2, "ANCHOR_LEFT")
		e.tips:ClearLines()
		e.tips:AddDoubleLine(e.onlyChinese and '在行囊上显示' or SHOW_ON_BACKPACK, GetNumWatchedTokens())
		for index=1, BackpackTokenFrame:GetMaxTokensWatched() do--Blizzard_TokenUI.lua
			local info = C_CurrencyInfo.GetBackpackCurrencyInfo(index)
			if info and info.name and info.iconFileID then
				e.tips:AddDoubleLine(info.name, '|T'..info.iconFileID..':0|t')
			end
		end
		e.tips:Show()
	end)
	button.bag:SetScript('OnLeave', function() e.tips:Hide() end)

	Set()

	button.indcatoCheck= CreateFrame("CheckButton", nil, TokenFrame, "InterfaceOptionsCheckButtonTemplate")--指定显示, 选项
	button.indcatoCheck:SetPoint('TOP', 0, -32)
	button.indcatoCheck:SetScript('OnMouseDown', function(self, d)
		if d=='LeftButton' then
			Save.indicato= not Save.indicato and true or nil
			print(id, addName, e.onlyChinese and '文本' or  LOCALE_TEXT_LABEL, e.GetShowHide(not Save.Hide))
		elseif d=='RightButton' then
			Save.tokens={}
			print(id, addName, e.onlyChinese and '全部清除' or CLEAR_ALL, e.onlyChinese and '类型' or TYPE, e.onlyChinese and '指定' or COMBAT_ALLY_START_MISSION)
			TokenFrame_Update()
		end
		set_Text()--设置, 文本
	end)
	button.indcatoCheck:SetScript('OnEnter', function(self)
		local num= 0
		for _, _ in pairs(Save.tokens) do
			num= num+1
		end
		e.tips:SetOwner(self, "ANCHOR_LEFT")
		e.tips:ClearLines()
		e.tips:AddDoubleLine(e.onlyChinese and '文本 (类型): 指定' or  LOCALE_TEXT_LABEL..' ('..TYPE..'): '..COMBAT_ALLY_START_MISSION, e.Icon.left)
		e.tips:AddDoubleLine( e.onlyChinese and '全部清除' or CLEAR_ALL, '|cnGREEN_FONT_COLOR:#'..num..'|r'.. e.Icon.right)
		e.tips:AddLine(' ')
		e.tips:AddDoubleLine((e.onlyChinese and '文本' or  LOCALE_TEXT_LABEL), e.GetShowHide(not Save.Hide))
		e.tips:AddDoubleLine(id, addName)
		e.tips:Show()
	end)
	button.indcatoCheck:SetScript('OnLeave', function() e.tips:Hide() end)
	button.indcatoCheck.text:SetText(e.onlyChinese and '指定' or COMBAT_ALLY_START_MISSION)
	button.indcatoCheck:SetChecked(Save.indicato)
	if Save.Hide then
		button.indcatoCheck.text:SetTextColor(0.82, 0.82, 0.82, 0.5)
	end

	hooksecurefunc('TokenFrame_InitTokenButton',function(self, frame, elementData)--Blizzard_TokenUI.lua
		set_Tokens_Button(frame)--设置, 列表, 内容
	end)
	hooksecurefunc('TokenFrame_Update', function()
		for _, frame in pairs(TokenFrame.ScrollBox:GetFrames()) do
			set_Tokens_Button(frame)--设置, 列表, 内容
		end
		set_ItemInteractionFrame_Currency(TokenFrame)--套装,转换,货币
		set_Text()--设置, 文本
	end)
end


--###########
--加载保存数据
--###########
local panel= CreateFrame("Frame")
panel:RegisterEvent("ADDON_LOADED")
panel:SetScript("OnEvent", function(self, event, arg1)
    if event == "ADDON_LOADED" then
		if arg1==id then
            Save= WoWToolsSave[addName] or Save
			Save.tokens= Save.tokens or {}

            --添加控制面板        
            local sel=e.CPanel('|A:bags-junkcoin:0:0|a'..(e.onlyChinese and '货币' or addName), not Save.disabled)
            sel:SetScript('OnMouseDown', function()
                Save.disabled= not Save.disabled and true or nil
                print(id, addName, e.GetEnabeleDisable(not Save.disabled), e.onlyChinese and '需要重新加载' or REQUIRES_RELOAD)
            end)

            if Save.disabled then
                panel:UnregisterAllEvents()
            else
				Init()
            end
            panel:RegisterEvent("PLAYER_LOGOUT")

		elseif arg1=='Blizzard_ItemInteractionUI' then
            hooksecurefunc(ItemInteractionFrame, 'SetupChargeCurrency', set_ItemInteractionFrame_Currency)
		end

    elseif event == "PLAYER_LOGOUT" then
        if not e.ClearAllSave then
            WoWToolsSave[addName]=Save
        end
	end
end)