local id , e = ...
if e.Is_Timerunning then
    return
end


local Save={
    aura={
        [16591]=false,--变骷髅
        [16595]=false,--变小
        [16593]=true,
    }
}

local addName
local button
local ItemID= 8529
local ItemName
if LOCALE_zhCN then
    ItemName= '诺格弗格药剂'
elseif LOCALE_zhTW then
    ItemName= '諾格弗格藥劑'
elseif LOCALE_koKR then
    ItemName= '노겐포저의 비약'
elseif LOCALE_frFR then
    ItemName= 'Élixir Brouillecaboche'
elseif LOCALE_deDE then
    ItemName= 'Noggenfoggers Elixier'
elseif LOCALE_esES or LOCALE_esMX then--西班牙语
    ItemName= 'Elixir de Tragonublo'
elseif LOCALE_ruRU then   
    ItemName= 'Эликсир Гогельмогеля'
elseif LOCALE_ptBR then--葡萄牙语    
    ItemName= 'Elixir Nublacuca'
elseif LOCALE_itIT then
    ItemName= 'Elisir di Granstrippo'
else
    ItemName= 'Noggenfogger Elixir'
end









local function setAura()--光环取消
    if UnitAffectingCombat('player') then
        return
    end
    for i = 1, 255 do
        local data=C_UnitAuras.GetAuraDataByIndex('player', i, 'HELPFUL')
        if data then
            if Save.aura[data.spellId] then                
                CancelUnitBuff("player", i, nil)-- 'CANCELABLE')
                print(addName,
                    e.onlyChinese and '取消光环' or format(CLUB_FINDER_LOOKING_FOR_CLASS_SPEC, CANCEL, AURAS),
                    WoWTools_SpellMixin:GetLink(data.spellId, true)
                )
                break
            end
        else
            break
        end
    end
end






local function setCount()--设置数量
    local num = C_Item.GetItemCount(ItemID, false, true, true, false) or 0
    button.count:SetText(num~=1 and num or '')
    button.texture:SetDesaturated(num==0)
end




























local function Init_Menu(_, root)
    local sub
    for spellID in pairs(Save.aura) do
        sub=root:CreateCheckbox(
            WoWTools_SpellMixin:GetName(spellID),
        function(data)
            return Save.aura[data.spellID]
        end, function(data)
            Save.aura[data.spellID]= not Save.aura[data.spellID] and true or false
        end, {spellID=spellID})
        WoWTools_SetTooltipMixin:SetTooltip(nil, nil, sub, nil)
    end

    root:CreateSpacer()
    WoWTools_Key_Button:SetMenu(root, {
        icon='|A:NPE_ArrowDown:0:0|a',
        name=addName,
        key=Save.KEY,
        GetKey=function(key)
            Save.KEY=key
            WoWTools_Key_Button:Setup(button)--设置捷键
        end,
        OnAlt=function()
            Save.KEY=nil
            WoWTools_Key_Button:Setup(button)--设置捷键
        end,
    })

end

--#####
--主菜单
--#####
local function InitMenu(self, level)--主菜单
    for spellID, type in pairs(Save.aura) do
        local name= C_Spell.GetSpellName(spellID)
        local icon= C_Spell.GetSpellTexture(spellID)
        name= name or (e.onlyChinese and '光环' or AURAS)..' '..spellID
        local info={
            text=name,
            icon=icon,
            checked= type,
            tooltipOnButton=true,
            keepShownOnClick=true,
            tooltipTitle=  e.onlyChinese and '脱离战斗' or HUD_EDIT_MODE_SETTING_ACTION_BAR_VISIBLE_SETTING_OUT_OF_COMBAT,
            func=function()
                Save.aura[spellID] = not type and true or false
            end
        }
        e.LibDD:UIDropDownMenu_AddButton(info, level)
    end
    e.LibDD:UIDropDownMenu_AddSeparator(level)

    local info={--快捷键,设置对话框
        text= e.onlyChinese and '快捷键' or SETTINGS_KEYBINDINGS_LABEL,--..(Save.KEY and ' |cnGREEN_FONT_COLOR:'..Save.KEY..'|r' or ''),
        checked=Save.KEY and true or nil,
        disabled=UnitAffectingCombat('player'),
        keepShownOnClick=true,
        func=function()
            StaticPopupDialogs[id..addName..'KEY']={--快捷键,设置对话框
                text=id..' '..addName..'|n'..(e.onlyChinese and '快捷键' or SETTINGS_KEYBINDINGS_LABEL)..'|n|nQ, BUTTON5',
                whileDead=true, hideOnEscape=true, exclusive=true,
                hasEditBox=1,
                button1=SETTINGS,
                button2=CANCEL,
                button3=REMOVE,
                OnShow = function(self2, data)
                    self2.editBox:SetText(Save.KEY or ';')
                    if Save.KEY then
                        self2.button1:SetText(e.onlyChinese and '修改' or EDIT)
                    end
                    self2.button3:SetEnabled(Save.KEY)
                end,
                OnHide= function(self2)
                    self2.editBox:SetText("")
                    e.call(ChatEdit_FocusActiveWindow)
                end,
                OnAccept = function(self2, data)
                    local text= self2.editBox:GetText()
                    text=text:gsub(' ','')
                    text=text:gsub('%[','')
                    text=text:gsub(']','')
                    text=text:upper()
                    Save.KEY=text
                    set_KEY()--设置捷键
                end,
                OnAlt = function()
                    Save.KEY=nil
                    set_KEY()--设置捷键
                end,
                EditBoxOnTextChanged=function(self2, data)
                    local text= self2:GetText()
                    text=text:gsub(' ','')
                    self2:GetParent().button1:SetEnabled(text~='')
                end,
                EditBoxOnEscapePressed = function(s)
                    s:SetAutoFocus(false)
                    s:ClearFocus()
                    s:GetParent():Hide()
                end,
            }
            StaticPopup_Show(id..addName..'KEY')
        end,
    }
    e.LibDD:UIDropDownMenu_AddButton(info, level)
end

















local function Init()
    WoWTools_Key_Button:Init(button, function() return Save.KEY end)

    button:SetAttribute('type1','item')
    button:SetAttribute('item1', C_Item.GetItemNameByID(ItemID) or ItemName or ItemID)
    
    button.texture:SetTexture(C_Item.GetItemIconByID(ItemID) or 134863)
    button.count=e.Cstr(button, {size=12, color={r=1,g=1,b=1}})--10,nil,nil,true)
    button.count:SetPoint('BOTTOMRIGHT')

    setCount()--设置数量
    setAura()--光环取消   

    button:SetScript('OnEnter', function(self)
        e.tips:SetOwner(self, "ANCHOR_LEFT")
        e.tips:ClearLines()
        e.tips:SetItemByID(ItemID)
        e.tips:AddLine(' ')
        for spellID, type in pairs(Save.aura) do
            e.tips:AddDoubleLine( WoWTools_SpellMixin:GetLink(spellID, true), type and	'|cnGREEN_FONT_COLOR:'..(e.onlyChinese and '取消' or CANCEL)..'|r' or '...')
        end
        e.tips:AddLine(' ')
        local key= WoWTools_Key_Button:IsKeyValid(self)
        if key then
            e.tips:AddDoubleLine('|cnGREEN_FONT_COLOR:'..(e.onlyChinese and '快捷键' or SETTINGS_KEYBINDINGS_LABEL), '|cnGREEN_FONT_COLOR:'..key)
        end

        e.tips:AddDoubleLine(e.onlyChinese and '菜单' or SLASH_TEXTTOSPEECH_MENU, e.Icon.right)
        e.tips:Show()
    end)


    button:SetScript('OnLeave', GameTooltip_Hide)
    button:SetScript("OnMouseDown", function(self, d)
        if d=='RightButton' then
            MenuUtil.CreateContextMenu(self, Init_Menu)
        end
    end)
    

end





























--###########
--加载保存数据
--###########
local panel= CreateFrame("Frame")
panel:RegisterEvent("ADDON_LOADED")
panel:RegisterEvent('PLAYER_LOGOUT')
panel:SetScript("OnEvent", function(self, event, arg1)
    if event == "ADDON_LOADED" then
        if arg1== id then
            if (e.Is_Timerunning or C_Item.GetItemCount(ItemID)==0) then--没有时,不加载
                self:UnregisterEvent('ADDON_LOADED')
                return
            end

            

            addName= '|T134863:0|t'..(e.onlyChinese and '诺格弗格药剂' or ItemName)
            
            Save= WoWToolsSave['NoggenfoggerElixir'] or Save
            button= WoWTools_ToolsButtonMixin:CreateButton({
                name='NoggenfoggerElixir',
                tooltip=addName,
            })

            if button then
                ItemName= C_Item.GetItemNameByID(ItemID) or ItemName
                
                self:RegisterEvent("PLAYER_REGEN_ENABLED")
                self:RegisterEvent("PLAYER_REGEN_DISABLED")
                self:RegisterEvent('BAG_UPDATE_DELAYED')
                self:RegisterUnitEvent("UNIT_AURA", 'player')
                self:RegisterEvent('BAG_UPDATE_COOLDOWN')
                
            
                Init()--初始
            end
            self:UnregisterEvent('ADDON_LOADED')
        end

    elseif event == "PLAYER_LOGOUT" then
        if not e.ClearAllSave then
            WoWToolsSave['NoggenfoggerElixir']=Save
        end

    elseif event=='PLAYER_REGEN_ENABLED' then
        self:RegisterUnitEvent("UNIT_AURA", 'player')
       

    elseif event=='PLAYER_REGEN_DISABLED' then
        self:UnregisterEvent('UNIT_AURA')

    elseif event=='BAG_UPDATE_DELAYED' then
        setCount()--设置数量

    elseif event=='UNIT_AURA' then
        setAura()--光环取消

    elseif event=='BAG_UPDATE_COOLDOWN' then
        e.SetItemSpellCool(button, {item=ItemID})
    end
end)