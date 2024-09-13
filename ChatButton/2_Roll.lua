local id, e = ...

local Save={
    autoClear=true,--进入战斗时,清除数据
    save={},--保存数据,最多30个
}

local addName
local RollButton
local panel= CreateFrame("Frame")
local RollTab={}

--local MaxPlayer, MinPlayer


local Max, Min
local function findRolled(name)--查找是否ROLL过
    for _, tab in pairs(RollTab) do
        if tab.name==name then
            return true
        end
    end
end

local rollText= e.Magic(RANDOM_ROLL_RESULT)--"%s掷出%d（%d-%d）";
local function setCHAT_MSG_SYSTEM(text)
    if not text then
        return
    end
    local name, roll, minText, maxText=text:match(rollText)
    roll=  roll and tonumber(roll)
    if not (name and roll and minText=='1' and maxText=='100') then
        return
    end
    name=name:find('%-') and name or (name..'-'..e.Player.realm)
    if not findRolled(name) then
        if not Max or roll>Max then
            if Max then
                Min= (not Min or Min>Max) and Max or Min
            end
            Max=roll
        elseif not Min or Min>roll then
            Min=roll
        end

        RollButton.rightTopText:SetText(Max)

        if Min then
            RollButton.rightBottomText:SetText(Min)
        end
    end

    local faction,guid
    if name==e.Player.name_realm then
        faction= e.Player.faction
        guid= e.Player.guid
    elseif e.GroupGuid[name] then
        faction= e.GroupGuid[name].faction
        guid= e.GroupGuid[name].guid
    end

    table.insert(RollTab, {name=name,
                        roll=roll,
                        date=date('%X'),
                        text=text,
                        guid= guid,
                        faction= faction,
                    })

    if GameTooltip:IsOwned(RollButton) then
        RollButton:set_tooltip()
    end
end












local function get_Save_Max()--清除时,保存数据
    local maxTab, max= nil, 0
    for _, tab in pairs(RollTab) do
        if tab.roll and tab.roll>max then
            maxTab= tab
            if tab==100 then
                break
            end
        end
    end
    if maxTab then
        if #Save.save>=30 then
            table.remove(Save.save, 1)
        end
        table.insert(Save.save, maxTab)
    end
end

local function setRest()--重置
    get_Save_Max()--清除时,保存数据
    RollTab={}
    Max, Min= nil, nil
    RollButton.rightBottomText:SetText('')
    RollButton.rightTopText:SetText('')
end



local function setAutoClearRegisterEvent()--注册自动清除事件
    if Save.autoClear then
        panel:RegisterEvent('PLAYER_REGEN_DISABLED')
    else
        panel:UnregisterEvent('PLAYER_REGEN_DISABLED')
    end
    RollButton.autoClearTips:SetShown(Save.autoClear)
end

















--#####
--主菜单
--#####

local function Init_Menu(_, root)
    local sub, sub2, icon
    local rollNum= #RollTab
    local saveNum= #Save.save

    root:SetScrollMode(20*44)

    sub=root:CreateButton('|A:bags-button-autosort-up:0:0|a'..(e.onlyChinese and '全部清除' or CLEAR_ALL)..' |cnGREEN_FONT_COLOR:#'..rollNum..'|r', function()
        setRest()--重置
        return MenuResponse.Close
    end)

    sub2= sub:CreateCheckbox('|A:bags-button-autosort-up:0:0|a'..(e.onlyChinese and '自动清除' or format(CLUB_FINDER_LOOKING_FOR_CLASS_SPEC, SELF_CAST_AUTO, SLASH_STOPWATCH_PARAM_STOP2)), function ()
        return Save.autoClear
    end, function ()
        Save.autoClear= not Save.autoClear and true or false
        setAutoClearRegisterEvent()--注册自动清除事件
    end)
    sub2:SetTooltip(function (tooltip)
        GameTooltip_SetTitle(tooltip, e.onlyChinese and '进入战斗时: 清除' or (ENTERING_COMBAT..': '..SLASH_STOPWATCH_PARAM_STOP2))
    end)

if saveNum>0 then
    sub:CreateButton('|A:bags-button-autosort-up:0:0|a'..(e.onlyChinese and '清除记录' or format(CLUB_FINDER_LOOKING_FOR_CLASS_SPEC, SLASH_STOPWATCH_PARAM_STOP2, EVENTTRACE_LOG_HEADER))..' |cnGREEN_FONT_COLOR:#'..saveNum..'|r', function()
        Save.save={}
        return MenuResponse.Close
    end)
    sub:CreateDivider()
    for _, tab in pairs(Save.save) do
        sub2= sub:CreateButton(
            '|TInterface\\PVPFrame\\Icons\\PVP-Banner-Emblem-47:0|t|cffffffff'..tab.roll..'|r '
            ..WoWTools_UnitMixin:GetPlayerInfo(tab.unit, tab.guid, tab.name, {reName=true, reRealm=true})..' '..tab.date,
        function(text)
            e.Chat(text, nil, nil)
            return MenuResponse.Refresh
        end, tab.text)
        sub2:SetTooltip(function(tooltip, data)
            GameTooltip_SetTitle(tooltip, data.data)
            GameTooltip_AddNormalLine(tooltip, '|A:voicechat-icon-textchat-silenced:0:0|a'..(e.onlyChinese and '发送信息' or SEND_MESSAGE))
        end)
    end
    WoWTools_MenuMixin:SetGridMode(sub, saveNum)
end



if rollNum>0 then
    root:CreateDivider()
    local tabNew={}
    for _, tab in pairs(RollTab) do
        if not tabNew[tab.name] then
            --col=tabNew[tab.name] and '|cff9e9e9e' or ''
            icon=tab.roll==Max and '|A:auctionhouse-icon-checkmark:0:0|a' or (tab.roll==Min and '|T450905:0|a') or ''
            sub=root:CreateButton(
                '|TInterface\\PVPFrame\\Icons\\PVP-Banner-Emblem-47:0|t|cffffffff'..tab.roll..'|r '
                ..WoWTools_UnitMixin:GetPlayerInfo(tab.unit, tab.guid, tab.name, {reName=true, reRealm=true})
                ..' '..tab.date..icon,
            function(text)
                e.Chat(text, nil, nil)
                return MenuResponse.Refresh
            end, tab.text)
            sub:SetTooltip(function(tooltip, data)
                GameTooltip_SetTitle(tooltip, data.data)
                GameTooltip_AddNormalLine(tooltip, '|A:voicechat-icon-textchat-silenced:0:0|a'..(e.onlyChinese and '发送信息' or SEND_MESSAGE))
            end)
            tabNew[tab.name]=true
        end
    end
    WoWTools_MenuMixin:SetGridMode(root, rollNum)
end



end























--####
--初始
--####
local function Init()


    RollButton.texture:SetTexture('Interface\\PVPFrame\\Icons\\PVP-Banner-Emblem-47')

    RollButton.autoClearTips= RollButton:CreateTexture(nil,'OVERLAY')
    RollButton.autoClearTips:SetPoint('BOTTOMLEFT',4, 4)
    RollButton.autoClearTips:SetSize(12,12)
    RollButton.autoClearTips:SetAtlas('bags-button-autosort-up')

    RollButton.rightBottomText=e.Cstr(RollButton, {color={r=0,g=1,b=0}})
    RollButton.rightBottomText:SetPoint('BOTTOMRIGHT',-2,3)

    RollButton.rightTopText=e.Cstr(RollButton, {color={r=0,g=1,b=0}})
    RollButton.rightTopText:SetPoint('TOPLEFT',2,-3)


    function RollButton:set_tooltip()
        e.tips:SetOwner(self, "ANCHOR_LEFT")
        e.tips:ClearLines()
        e.tips:AddDoubleLine(addName, e.Icon.left)
        if #RollTab>0 then
            e.tips:AddLine(' ')
            local tabNew={}
            for _, tab in pairs(RollTab) do
                local col=tabNew[tab.name] and '|cff9e9e9e' or ''
                local icon=tab.roll==Max and '|A:auctionhouse-icon-checkmark:0:0|a' or (tab.roll==Min and '|T450905:0|a') or ''
                e.tips:AddLine(
                    col
                    ..'|TInterface\\PVPFrame\\Icons\\PVP-Banner-Emblem-47:0|t|cffffffff'..tab.roll..'|r '
                    ..WoWTools_UnitMixin:GetPlayerInfo(tab.unit, tab.guid, tab.name, {reName=true, reRealm=true})
                    ..' '..tab.date..icon)
                tabNew[tab.name]=true
            end
        end
        e.tips:Show()
    end
    RollButton:SetScript('OnLeave', function(self)
        e.tips:Hide()
        self:state_leave()
    end)

    RollButton:SetScript('OnEnter', function(self)
        self:state_enter(Init_Menu)
        self:set_tooltip()
    end)

    RollButton:SetScript('OnClick',function(self, d)
        if d=='LeftButton' then
            RandomRoll(1, 100)
        else
            MenuUtil.CreateContextMenu(self, Init_Menu)
            e.tips:Hide()
        end
    end)

    setAutoClearRegisterEvent()--注册自动清除事件
end



















--###########
--加载保存数据
--###########
panel:RegisterEvent("ADDON_LOADED")
panel:RegisterEvent("PLAYER_LOGOUT")
panel:SetScript("OnEvent", function(self, event, arg1)
    if event == "ADDON_LOADED" then
        if arg1==id then
            Save= WoWToolsSave['ChatButton_Rool'] or Save
            addName= '|TInterface\\PVPFrame\\Icons\\PVP-Banner-Emblem-47:0|t'..(e.onlyChinese and '掷骰' or ROLL)
            RollButton= WoWTools_ChatButtonMixin:CreateButton('Roll', addName)

            if RollButton then


                Init()
                self:RegisterEvent('CHAT_MSG_SYSTEM')
            end
            self:UnregisterEvent('ADDON_LOADED')
        end

    elseif event == "PLAYER_LOGOUT" then
        if not e.ClearAllSave then
            get_Save_Max()--清除时,保存数据
            WoWToolsSave['ChatButton_Rool']= Save
        end

    elseif event=='CHAT_MSG_SYSTEM' then
        setCHAT_MSG_SYSTEM(arg1)

    elseif event=='PLAYER_REGEN_DISABLED' then
        setRest()--重置
    end
end)