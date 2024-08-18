local id, e = ...


local Save={
    --disabled=true,

    disabledADD={},
    scale=1,
    strata='HIGH',
    height=10,

    isEnterShow=true,
    isCombatHide=true,
    isMovingHide=true,
    showIcon=true,
    --show=false,
    --point
}












local Button
local addName= WoWTools_ToolsButtonMixin:GetName()
local Category, Layout






local function Init_Panel()
    Category, Layout= e.AddPanel_Sub_Category({name=addName})
    WoWTools_ToolsButtonMixin:SetCategory(Category, Layout)

    e.AddPanel_Check_Button({
        checkName= e.onlyChinese and '启用' or ENABLE,
        GetValue= function() return not Save.disabled end,
        SetValue= function()
            Save.disabled= not Save.disabled and true or nil
            print(id, addName, e.GetEnabeleDisable(not Save.disabled), e.onlyChinese and '需要重新加载' or REQUIRES_RELOAD)
        end,
        buttonText= e.onlyChinese and '重置位置' or RESET_POSITION,
        buttonFunc= function()
            Save.point=nil
            if Button then
                Button:set_point()
            end
            print(id, addName, e.onlyChinese and '重置位置' or RESET_POSITION)
        end,
        tooltip= addName,
        layout= Layout,
        category= Category,
    })

    e.AddPanel_Header(Layout, e.onlyChinese and '选项: 需要重新加载' or (OPTIONS..': '..REQUIRES_RELOAD))

    for _, data in pairs (WoWTools_ToolsButtonMixin:GetAllAddList()) do
        if data.option then
            data.option(Category, Layout)
        end
        if not data.isOnlyOptions then
            e.AddPanel_Check({
                category= Category,
                name= data.tooltip,
                tooltip= data.name,
                GetValue= function() return not Save.disabledADD[data.name] end,
                SetValue= function()
                    Save.disabledADD[data.name]= not Save.disabledADD[data.name] and true or nil
                end
            })
        end
    end

end















local function Init_Menu(self, root)
    local sub, sub2
    sub=root:CreateCheckbox(e.onlyChinese and '显示' or SHOW, function()
        return self.Frame:IsShown()
    end, function()
        self:set_shown()
    end)
    sub:SetTooltip(function(tooltip)
        tooltip:AddLine((UnitAffectingCombat('player') and '|cnRED_FONT_COLOR:' or '')..(e.onlyChinese and '脱离战斗' or HUD_EDIT_MODE_SETTING_ACTION_BAR_VISIBLE_SETTING_OUT_OF_COMBAT))
    end)

--显示
    sub:CreateTitle(e.onlyChinese and '显示' or SHOW)
    sub:CreateCheckbox('|A:newplayertutorial-drag-cursor:0:0|a'..(e.onlyChinese and '移过图标' or format(CLUB_FINDER_LOOKING_FOR_CLASS_SPEC, ENTER_LFG,EMBLEM_SYMBOL)), function()
        return Save.isEnterShow
    end, function()
        Save.isEnterShow = not Save.isEnterShow and true or nil
        self:save_data()
    end)

--隐藏
    sub:CreateTitle(e.onlyChinese and '隐藏' or HIDE)
    sub:CreateCheckbox('|A:Warfronts-BaseMapIcons-Horde-Barracks-Minimap:0:0|a'..(e.onlyChinese and '进入战斗' or ENTERING_COMBAT), function()
        return Save.isCombatHide
    end, function()
        Save.isCombatHide = not Save.isCombatHide and true or nil
        self:set_event()
    end)

    sub:CreateCheckbox('|A:transmog-nav-slot-feet:0:0|a'..(e.onlyChinese and '移动' or NPE_MOVE), function()
        return Save.isMovingHide
    end, function()
        Save.isMovingHide = not Save.isMovingHide and true or nil
        self:set_event()
    end)


    WoWTools_ToolsButtonMixin:OpenMenu(root)

    --[[sub=root:CreateButton('     '..(e.onlyChinese and '选项' or OPTIONS), function()
        if not Category then
            e.OpenPanelOpting()
        end
        e.OpenPanelOpting(Category, addName)
        return MenuResponse.Open
    end)
    sub:SetTooltip(function(tooltip)
        tooltip:AddLine(addName)
        tooltip:AddLine(e.onlyChinese and '打开选项界面' or OPTIONS)
    end)]]

    sub2=sub:CreateCheckbox('30x30', function()
        return Save.height==30
    end, function()
        Save.height= Save.height==10 and 30 or 10
        self:set_size()
    end)
    sub2:SetTooltip(function(tooltip)
        tooltip:AddLine(e.onlyChinese and '大小' or 'Size')
    end)

    sub2=sub:CreateCheckbox(e.onlyChinese and '图标' or EMBLEM_SYMBOL, function()
        return Save.showIcon
    end, function()
        Save.showIcon= not Save.showIcon and true or nil
        self:set_icon()
    end)
    sub2:SetTooltip(function(tooltip)
        tooltip:AddLine(e.GetShowHide(nil, true))
    end)

    WoWTools_MenuMixin:ScaleMenu(sub, function()
        return Save.scale
    end, function(data)
        Save.scale=data
        self:set_scale()
    end)

    WoWTools_MenuMixin:StrataMenu(sub, function(data)
        return self:GetFrameStrata()==data
    end, function(data)
        Save.strata= data
        self:set_strata()
    end)


    WoWTools_MenuMixin:RestPointMenu(sub, Save.point, function()
        Save.point=nil
        self:set_point()
    end)


end
















local function Init()
    function Button:set_size()
        self:SetHeight(Save.height)
    end

    function Button:set_icon()
        self.texture:SetShown(Save.showIcon)
    end

    function Button:save_data()
        WoWTools_ToolsButtonMixin:SetSaveData(Save)
    end

    function Button:set_point()
        self:ClearAllPoints()
        if Save.point then
            self:SetPoint(Save.point[1], UIParent, Save.point[3], Save.point[4], Save.point[5])
        elseif e.Player.husandro then
            self:SetPoint('BOTTOMRIGHT', -420, 15)
        else
            self:SetPoint('CENTER', 300, 100)
        end
    end

    function Button:set_scale()
        self:SetScale(Save.scale or 1)
    end

    function Button:set_strata()
        self:SetFrameStrata(Save.strata or 'HIGH')
    end

    function Button:set_tooltip()
        e.tips:SetOwner(self, "ANCHOR_LEFT")
        e.tips:ClearLines()
        e.tips:AddDoubleLine((UnitAffectingCombat('player') and '|cff9e9e9e' or '')..e.GetShowHide(nil, true), e.Icon.left)
        e.tips:AddLine(' ')
        e.tips:AddDoubleLine((e.onlyChinese and '缩放' or UI_SCALE), '|cnGREEN_FONT_COLOR:'..(Save.scale or 1)..'|r Alt+'..e.Icon.mid)
        e.tips:AddDoubleLine(e.onlyChinese and '移动' or NPE_MOVE or SLASH_TEXTTOSPEECH_MENU, 'Alt+'..e.Icon.right)
        e.tips:AddDoubleLine(e.onlyChinese and '菜单' or SLASH_TEXTTOSPEECH_MENU, e.Icon.right)
        e.tips:Show()
    end

    Button:RegisterForDrag("RightButton")
    Button:SetMovable(true)
    Button:SetClampedToScreen(true)

    Button:SetScript("OnDragStart", function(self, d)
        if d=='RightButton' and IsAltKeyDown() then
            self:StartMoving()
        end
    end)

    Button:SetScript("OnDragStop", function(self)
        ResetCursor()
        self:StopMovingOrSizing()
        Save.point={self:GetPoint(1)}
        Save.point[2]=nil
    end)

    Button:SetScript("OnLeave",function(self)
        e.tips:Hide()
        ResetCursor()
    end)

    Button:SetScript('OnEnter', function(self)
        WoWTools_ToolsButtonMixin:EnterShowFrame()
        self:set_tooltip()
    end)

    Button:SetScript("OnMouseUp", ResetCursor)
    Button:SetScript("OnMouseDown", function(_, d)
        if IsAltKeyDown() and d=='RightButton' then--移动光标
            SetCursor('UI_MOVE_CURSOR')
        end
    end)

    Button:SetScript('OnMouseWheel', function(self, d)
        Save.scale=WoWTools_MenuMixin:ScaleFrame(self, d, Save.scale, nil)
    end)

    Button:SetScript("OnClick", function(self, d)
        if IsModifierKeyDown() then
            return
        end
        if d=='RightButton' then
            MenuUtil.CreateContextMenu(self, Init_Menu)

        elseif d=='LeftButton' then
            self:set_shown()
        end
    end)

    Button:set_scale()
    Button:set_point()
    Button:set_strata()


    function Button:set_shown()
        if not UnitAffectingCombat('player') then
            self.Frame:SetShown(not self.Frame:IsShown())
        end
    end

    function Button:set_event()
        self.Frame:UnregisterAllEvents()
        if Save.isCombatHide then
            self.Frame:RegisterEvent('PLAYER_REGEN_DISABLED')
        end
        if Save.isMovingHide then
            self.Frame:RegisterEvent('PLAYER_STARTED_MOVING')
        end
    end

    Button.Frame:SetScript('OnEvent', function(self, event)
        if event=='PLAYER_REGEN_DISABLED' then
            if self:IsShown() then
                self:SetShown(false)--设置, TOOLS 框架,隐藏
            end
        elseif event=='PLAYER_STARTED_MOVING' then
            if not UnitAffectingCombat('player') and self:IsShown() then
                self:SetShown(false)--设置, TOOLS 框架,隐藏
            end
        end
    end)
    Button:set_event()
end















local panel= CreateFrame("Frame")
panel:RegisterEvent("ADDON_LOADED")
panel:RegisterEvent("PLAYER_LOGOUT")
panel:SetScript("OnEvent", function(_, event, arg1)
    if event == "ADDON_LOADED" then
        if arg1== id then
            Save= WoWToolsSave['WoWTools_ToolsButton'] or Save
            Button= WoWTools_ToolsButtonMixin:Init(Save)

            if Button  then
                Init()
            end

            if C_AddOns.IsAddOnLoaded('Blizzard_Settings') then
                Init_Panel()
            end
        elseif arg1=='Blizzard_Settings' then
            Init_Panel()
        end

    elseif event == "PLAYER_LOGOUT" then
        if not e.ClearAllSave then
            Save.show= Button and Button.Frame:IsShown()
            WoWToolsSave['WoWTools_ToolsButton']=Save
        end
    end
end)