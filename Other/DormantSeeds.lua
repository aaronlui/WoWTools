local id, e = ...
local addName= 'DormantSeeds'
local Save={
    disabled= not e.Player.husandro,
    scale=0.85,
}

local panel= CreateFrame('Frame')
local Button

local ItemTab={
    208066,--小小的梦境之种
    208067,--饱满的梦境之种
    208047,--硕大的梦境之种
   -- 210014
}
local CurrencyID= 2650

local function Init()
    Button= e.Cbtn(nil, {size={22,22}, icon='hide'})
    function Button:set_Point()
        if Save.point then
            self:SetPoint(Save.point[1], UIParent, Save.point[3], Save.point[4], Save.point[5])
        elseif e.Player.husandro then
            self:SetPoint('TOPRIGHT', PlayerFrame, 'TOPLEFT',10,10)
        else
            self:SetPoint('CENTER', -400, 200)
        end
    end
    function Button:set_Scale()
        self:SetScale(Save.scale or 1)
    end
    function Button:set_Tooltips()
        e.tips:SetOwner(self, "ANCHOR_LEFT")
        e.tips:ClearLines()
        e.tips:AddDoubleLine(id, addName)
        e.tips:AddLine(' ')
        for _, itemID in pairs(ItemTab) do
            local link= select(2, GetItemInfo(itemID)) or itemID
            local icon= C_Item.GetItemIconByID(itemID)
            icon= icon and '|T'..icon..':0|t' or ''
            local num
            num= GetItemCount(itemID)
            num= num>0 and '|cnGREEN_FONT_COLOR:'..num or ('|cnRED_FONT_COLOR:'..num)
            e.tips:AddDoubleLine(icon..link, num)
        end
        if CurrencyID and CurrencyID>0 then
            local info= C_CurrencyInfo.GetCurrencyInfo(CurrencyID)
            if info and info.quantity and info.name then
                e.tips:AddDoubleLine((info.iconFileID and '|T'..info.iconFileID..':0|t' or '')..info.name, info.quantity)
            end
        end
        e.tips:AddLine(' ')
        e.tips:AddDoubleLine(e.onlyChinese and '移动' or NPE_MOVE, 'Alt+'..e.Icon.right)
        local col= UnitAffectingCombat('player') and '|cff606060' or ''
        e.tips:AddDoubleLine(col..(e.onlyChinese and '缩放' or UI_SCALE)..' '..(Save.scale or 1), col..('Alt+'..e.Icon.mid))
        col= not Save.point and '|cff606060' or ''
        e.tips:AddDoubleLine(col..(e.onlyChinese and '重置位置' or RESET_POSITION), col..'Ctrl+'..e.Icon.right)
        e.tips:Show()
    end

    --[[Button.texture= Button:CreateTexture()
    Button.texture:SetAllPoints(Button)
    Button.texture:SetAtlas(e.Icon.icon)
    Button.texture:SetAlpha(0.5)]]

    Button:SetClampedToScreen(true)
    Button:SetMovable(true)
    Button:RegisterForDrag("RightButton")
    Button:SetScript("OnDragStart", function(self)
        if IsAltKeyDown() then
            self:StartMoving()
        end
    end)
    Button:SetScript("OnDragStop", function(self)
        self:StopMovingOrSizing()
        Save.point={self:GetPoint(1)}
        Save.point[2]=nil
    end)

    Button:SetScript("OnMouseUp", ResetCursor)
    Button:SetScript("OnMouseDown", function(self, d)
        if d=='RightButton' and IsAltKeyDown() then--移动
            SetCursor('UI_MOVE_CURSOR');
        elseif d=='RightButton' and IsControlKeyDown() then--还原
           self:ClearAllPoints()
           Save.point=nil
           self:set_Point()
           print(id, addName, e.onlyChinese and '重置位置' or RESET_POSITION)
        end
    end)
    Button:SetScript('OnMouseWheel',function(self, d)
        if IsAltKeyDown() and not UnitAffectingCombat('player') then
            local scale= Save.scale or 1
            if d==1 then
                scale= scale+ 0.05
            elseif d==-1 then
                scale= scale- 0.05
            end
            scale= scale>4 and 4 or scale
            scale= scale<0.4 and 0.4 or scale
            Save.scale=scale
            self:set_Scale()
            self:set_Tooltips()
        end
    end)
    Button:SetScript('OnLeave', function()
        e.tips:Hide()
        ResetCursor()
        --self.texture:SetAlpha(0.5)
    end)
    Button:SetScript('OnEnter', function(self)
        self:set_Tooltips()
        --self.texture:SetAlpha(1)
    end)

    --货币，数量
    if CurrencyID and CurrencyID>0 then
        Button.label=e.Cstr(Button, {color={r=1,g=1,b=1}})
        Button.label:SetPoint('BOTTOMRIGHT')
        Button.label:SetTextColor(e.Player.r, e.Player.g, e.Player.b)
        local currencyInfo = C_CurrencyInfo.GetCurrencyInfo(CurrencyID) or {}
        if currencyInfo.iconFileID then
            Button:SetNormalTexture(currencyInfo.iconFileID)
        end
        function Button:set_Currency()
            local info = C_CurrencyInfo.GetCurrencyInfo(CurrencyID) or {}
            self.label:SetText(info.quantity and info.quantity>0 and e.MK(info.quantity, 0) or '')
        end
        Button:set_Currency()
    else
        Button:SetNormalTexture(e.Icon.icon)
    end

    function Button:set_Event()
        self:UnregisterAllEvents()
        self:RegisterEvent('PLAYER_ENTERING_WORLD')
        if self.uiMapID then
            self:RegisterEvent('PLAYER_REGEN_DISABLED')
            self:RegisterEvent('PLAYER_REGEN_ENABLED')
            self:RegisterEvent('BAG_UPDATE')
            self:RegisterEvent('BAG_UPDATE_DELAYED')
            self:RegisterEvent('PET_BATTLE_OPENING_DONE')
            self:RegisterEvent('PET_BATTLE_CLOSE')
            if CurrencyID and CurrencyID>0 then
                self:RegisterEvent('CURRENCY_DISPLAY_UPDATE')
            end
        end
    end
    function Button:set_Shown()
        local show= self.uiMapID and not UnitAffectingCombat('player') and not C_PetBattles.IsInBattle()
        self:SetShown(show)
    end
    function Button:get_UIMapID()
        self.uiMapID= C_Map.GetBestMapForUnit('player')==2200 and true or false
    end
    Button:SetScript("OnEvent", function(self, event, arg1)
        if event=='PLAYER_ENTERING_WORLD' then
            self:get_UIMapID()
            self:set_Event()
            self:set_Shown()
        elseif event=='PLAYER_REGEN_ENABLED' then
            if self.setButtonInCombat then
                self:set_button()
            end
        elseif event=='BAG_UPDATE' or event=='BAG_UPDATE_DELAYED' then
            self:set_button()
        elseif event=='CURRENCY_DISPLAY_UPDATE' then--货币，数量
            if arg1==CurrencyID and CurrencyID and CurrencyID>0 then
                self:set_Currency()
            end
        end

        if event=='PLAYER_REGEN_DISABLED' or event=='PLAYER_REGEN_ENABLED' then
            self:set_Shown()
        elseif not UnitAffectingCombat('player') then
            self:set_Shown()
        end
    end)



    Button.btn={}
    function Button:set_button()
        self.setButtonInCombat=nil
        if UnitAffectingCombat('player') then
            self.setButtonInCombat=true
            return
        end
        local index=1
        for _, itemID in pairs(ItemTab) do
            local num= GetItemCount(itemID)
            if num>0 then
                local btn= self.btn[index]
                if not btn then
                    btn= e.Cbtn(self, {type=true, button='ItemButton', icon='hide'})
                    btn:SetAttribute('type*', 'item')
                    btn:SetPoint('TOP', index==1 and Button or self.btn[index-1], 'BOTTOM', 0, -6)
                    btn:SetScript('OnEnter', function(self2)
                        if self2.itemID  then
                            e.tips:SetOwner(self, "ANCHOR_LEFT")
                            e.tips:ClearLines()
                            e.tips:SetItemByID(self2.itemID)
                            e.tips:Show()
                        end
                    end)
                    btn:SetScript('OnLeave', function() e.tips:Hide() end)
                    btn:UpdateItemContextOverlayTextures(1)
                    self.btn[index]= btn
                end
                if btn.itemID~= itemID then
                    btn.itemID= itemID
                    local name=C_Item.GetItemNameByID(itemID) or GetItemInfo(itemID) or itemID
                    btn:SetAttribute('item*', name)
                    btn:SetItem(itemID)
                end
                btn:SetItemButtonCount(GetItemCount(itemID))
                index= index+1
            end
        end
        for i= index, #self.btn do
            local btn= self.btn[i]
            if btn then
                btn:Reset()
                btn:SetShown(false)
            end
        end
    end

    --Button:SetScript('OnShow', Button.set_button)
    Button:set_Point()
    Button:set_button()
    Button:set_Scale()
    Button:get_UIMapID()
    Button:set_Event()
    Button:set_Shown()
end


panel:RegisterEvent("ADDON_LOADED")
panel:RegisterEvent('PLAYER_LOGOUT')
panel:SetScript("OnEvent", function(self, event, arg1)
    if event == "ADDON_LOADED" then
        if arg1==id then
            Save= WoWToolsSave[addName] or Save

            --添加控制面板
            e.AddPanel_Check({
                name= '|T656681:0|t'..addName,
                tooltip= function()
                    e.tips:SetOwner(SettingsPanel, "ANCHOR_LEFT")
                    e.tips:ClearLines()
                    e.tips:SetItemByID(208047)
                    e.tips:AddLine(' ')
                    local info= C_Map.GetMapInfo(2200) or {}
                    e.tips:AddDoubleLine( '|cnGREEN_FONT_COLOR:'..format(LFG_LIST_CROSS_FACTION, info.name or 'uiMapID 2200'), '|cnGREEN_FONT_COLOR:uiMapID 2200')
                    e.tips:Show()
                end,
                value= not Save.disabled,
                func= function()
                    Save.disabled = not Save.disabled and true or nil
                    print(id, addName, e.GetEnabeleDisable(not Save.disabled), e.onlyChinese and '需求重新加载' or REQUIRES_RELOAD)
                end
            })

            if not Save.disabled then
                for _, itemID in pairs(ItemTab) do
                    e.LoadDate({id=itemID, type='item'})
                end
                C_Timer.After(2, Init)
            end

            self:UnregisterEvent('ADDON_LOADED')
        end

    elseif event == "PLAYER_LOGOUT" then
        if not e.ClearAllSave then
            WoWToolsSave[addName]=Save
        end

    end
end)