local id, e = ...
local addName= format(CLUB_FINDER_LOOKING_FOR_CLASS_SPEC, ADDONS, CHAT_MODERATE)
local Save={
        buttons={
            [BASE_SETTINGS_TAB]={
                ['WeakAuras']=true,
                --['WeakAurasOptions']=true,
                ['BugSack']=true,
                ['!BugGrabber']=true,
                ['TextureAtlasViewer']=true,-- true, i or guid
                [id]=true,
            },
        },
        fast={
            --[name]= index,
        },
        enableAllButtn= e.Player.husandro,--全部禁用时，不禁用本插件
    }

local Initializer
local Buttons={}
local FastButton={}











local function Get_AddList_Info()
    local load, some, sel= 0, 0, 0
    local tab= {}
    for i=1, C_AddOns.GetNumAddOns() do
        local name=C_AddOns.GetAddOnInfo(i)
        if C_AddOns.IsAddOnLoaded(name) then
            load= load+1
        end
        local stat= C_AddOns.GetAddOnEnableState(name) or 0
        if stat>0 then
            if stat==1 then
                some= some +1
            elseif stat==2 then
                sel= sel+1
            end
            tab[name]= stat==1 and e.Player.guid or i
        end
    end
    return load, some, sel, tab
end























local function Create_Button(btn)
    btn=e.Cbtn(AddonList, {icon='hide', size={88,22}})
    btn:SetHighlightAtlas('auctionhouse-nav-button-secondary-select')
    btn.Text= e.Cstr(btn)
    btn.Text:SetPoint('LEFT', 2, 0)

    function btn:set_status()
        self:SetButtonState(self.load==self.all and 'PUSHED' or 'NORMAL')
    end

    btn:SetScript('OnClick',function(self, d)
        if d=='LeftButton' then--加载
            local tab= Save.buttons[self.name]
            for i=1, C_AddOns.GetNumAddOns() do
                local name= C_AddOns.GetAddOnInfo(i)
                local value=tab[name]
                local vType= type(value)
                if vType=='boolean' or vType=='number' or value==e.Player.guid then
                    C_AddOns.EnableAddOn(i)
                else
                    C_AddOns.DisableAddOn(i)
                end
            end
            e.Reload()

        elseif d=='RightButton' then--移除
            StaticPopupDialogs['WoWTools_AddOns_DELETE']= StaticPopupDialogs['WoWTools_AddOns_DELETE'] or {
                text =id..' '..Initializer:GetName()..'|n|n< |cff00ff00%s|r >',
                button1 = e.onlyChinese and '删除' or DELETE,
                button2 = e.onlyChinese and '取消' or CANCEL,
                whileDead=true, hideOnEscape=true, exclusive=true,
                OnAccept=function(_, name)
                    Save.buttons[name]=nil
                    e.call('AddonList_Update')
                end,
            }
            StaticPopup_Show('WoWTools_AddOns_DELETE', self.name, nil, self.name)
        end
    end)

    btn:SetScript('OnEnter', function(self)
        e.tips:SetOwner(self, "ANCHOR_RIGHT")
        e.tips:ClearLines()
        local index=1
        for name, value in pairs(Save.buttons[self.name]) do
            local isLoaded= C_AddOns.IsAddOnLoaded(name)
            local vType= type(value)
            local text= vType=='string' and e.GetPlayerInfo({guid=value, reName=true, reRealm=true})
            if not text and not isLoaded then
                local reason= select(2, C_AddOns.IsAddOnLoadable(name))
                if reason then
                    text= '|cff606060'..e.cn(_G['ADDON_'..reason] or reason)..' ('..index
                end
            end
            e.tips:AddDoubleLine(
                format('%s|cffffd100%d)|r %s%s|r', index<10 and ' ' or '', index, isLoaded and '|cnGREEN_FONT_COLOR:' or '|cff606060', name),
                text or ' '
            )
            index= index+1
        end
        e.tips:AddLine(' ')
        e.tips:AddDoubleLine((e.onlyChinese and '加载插件' or LOAD_ADDON)..e.Icon.left, (e.onlyChinese and '删除' or DELETE)..e.Icon.right,1,0,1, 1,0,1)
        e.tips:AddLine(format('|cffff00ff%s|r', self.name))
        e.tips:Show()
    end)
    btn:SetScript('OnLeave', function(self)
      --  self:set_status()
        e.tips:Hide()
    end)
    return btn
end







--####
--按钮
--####
local function Set_Buttons()--设置按钮, 和位置
    local list={}
    for name, tab in pairs(Save.buttons) do
        local load, all=0, 0
        for add in pairs(tab) do
            if C_AddOns.DoesAddOnExist(add) then
                all=all+1
                if C_AddOns.IsAddOnLoaded(add) then
                    load= load+1
                end
            else
                tab[add]= nil
            end
        end
        table.insert(list, {name= name, tab=tab, load=load, all=all})
    end
    table.sort(list, function(a,b) return a.load< b.load end)


    for index, info in pairs(list) do
        local btn=Buttons[index]
        if not btn then
            btn= Create_Button()
            if index==1 then
                btn:SetPoint('TOPLEFT', AddonList, 'TOPRIGHT', 0, -22)
            else
                btn:SetPoint('TOPLEFT', Buttons[index-1], 'BOTTOMLEFT')
            end

            Buttons[index]= btn
        end

        btn.name= info.name
        btn.load= info.load
        btn.all= info.all

        btn.Text:SetFormattedText(
            '%s %s%d|r/%s%d|r',
            info.name,
            info.load==0 and '|cff606060' or '|cnGREEN_FONT_COLOR:',
            info.load,
            
            info.load==info.all and '|cnGREEN_FONT_COLOR:' or '',
            info.all
        )
        btn:SetWidth(btn.Text:GetWidth()+4)
        btn:set_status()
    end
end








--新建按钮
local function Init_Add_Save_Button()
    local btn= e.Cbtn(AddonList, {size={26,26}, atlas='communities-chat-icon-plus'})
    btn:SetPoint('TOPRIGHT', -2, -28)
    btn:SetScript('OnLeave', GameTooltip_Hide)
    btn:SetScript('OnEnter', function(self)
        e.tips:SetOwner(self, "ANCHOR_RIGHT")
        e.tips:ClearLines()
        e.tips:AddDoubleLine(id , Initializer:GetName())
        e.tips:AddLine(' ')
        local index=1
        local tab= select(4, Get_AddList_Info())
        for name, value in pairs(tab) do
            local isLoaded= C_AddOns.IsAddOnLoaded(name)
            local vType= type(value)
            local text= vType=='string' and e.GetPlayerInfo({guid=value})
            if not text and not isLoaded then
                local reason= select(2, C_AddOns.IsAddOnLoadable(name))
                if reason then
                    text= '|cff606060'..e.cn(_G['ADDON_'..reason] or reason)..' ('..index
                end
            end
            e.tips:AddDoubleLine(
                format('%s|cffffd100%d)|r %s%s|r', index<10 and ' ' or '', index, isLoaded and '|cnGREEN_FONT_COLOR:' or '|cff606060', name),
                text or ' '
            )
            index= index+1
        end
        e.tips:AddLine(' ')
        e.tips:AddDoubleLine(
            format('|A:communities-chat-icon-plus:0:0|a|cffff00ff%s|r%s', e.onlyChinese and '新建' or NEW, e.Icon.left),
            format('%s%s', e.onlyChinese and '选项' or OPTIONS, e.Icon.right)
        )
        e.tips:Show()
    end)
    btn:SetScript('OnClick',function(_, d)
        if d=='LeftButton' then
            StaticPopupDialogs['WoWTools_AddOns_NEW']= StaticPopupDialogs['WoWTools_AddOns_NEW'] or {
                text =id..' '..Initializer:GetName()
                    ..'|n|n'
                    ..(e.onlyChinese and '当前已选择' or ICON_SELECTION_TITLE_CURRENT)
                    ..' %s|n|n'
                    ..(e.onlyChinese and '新的方案' or PAPERDOLL_NEWEQUIPMENTSET),
                button1 = e.onlyChinese and '新建' or NEW,
                button2 = e.onlyChinese and '取消' or CANCEL,
                whileDead=true, hideOnEscape=true, exclusive=true,
                hasEditBox=true,
                OnAccept=function(self)
                    local text = self.editBox:GetText()
                    Save.buttons[text]= select(4 ,Get_AddList_Info())
                    e.call('AddonList_Update')
                end,
                OnShow=function(self)
                    self.editBox:SetText(e.onlyChinese and '一般' or RESISTANCE_FAIR)
                end,
                EditBoxOnTextChanged= function(self)
                    local btn=self:GetParent().button1
                    btn:SetText(Save.buttons[text] and (e.onlyChinese and '替换' or REPLACE) or (e.onlyChinese and '新建' or NEW))
                    btn:SetEnabled(self:GetText():gsub(' ', '')~='')
                end,
                EditBoxOnEscapePressed = function(self)
                    self:GetParent():Hide()
                end,
            }

            local _, some, sel= Get_AddList_Info()--检查列表, 选取数量, 总数, 数量/总数
            StaticPopup_Show('WoWTools_AddOns_NEW',
                format('%d%s',
                    sel,
                    some>0 and format(' (%s%d)', e.Icon.player, some) or ''
                )
            )
        elseif d=='RightButton' then
            e.OpenPanelOpting(Initializer)
        end
    end)
    btn.Text= e.Cstr(btn)
    btn.Text:SetPoint('RIGHT', btn, 'LEFT')
    AddonList.WoWToolsButton= btn
end













--插件，快捷，选中
local function Set_Fast_Button()
    local newTab={}
    for name, index in pairs(Save.fast) do
        if C_AddOns.DoesAddOnExist(name) then
            table.insert(newTab, {name=name, index= index or 0})
        else
            Save.fast[name]= nil
        end
    end
    table.sort(newTab, function(a, b) return a.index< b.index end)

    local last
    local index= 0
    for _, tab in pairs(newTab) do
        local name, _, _, _, reason = C_AddOns.GetAddOnInfo(tab.name)
        if name and reason~='MISSING' then
            index= index+1
            local check= FastButton[index]
            if not check then
                check= CreateFrame("CheckButton", nil, AddonList, "InterfaceOptionsCheckButtonTemplate")
                if not last then
                    check:SetPoint('TOPRIGHT', AddonList, 'TOPLEFT', 8,0)
                else
                    check:SetPoint('TOPRIGHT', last, 'BOTTOMRIGHT',0,9)
                end
                check.Text:ClearAllPoints()
                check.Text:SetPoint('RIGHT', check, 'LEFT')
                check:SetScript('OnClick', function(self2)
                    if C_AddOns.GetAddOnEnableState(self2.name)~=0 then
                        C_AddOns.DisableAddOn(self2.name)
                    else
                        C_AddOns.EnableAddOn(self2.name)
                    end
                    e.call('AddonList_Update')
                end)
                check:SetScript('OnLeave', function(self2) e.tips:Hide() self2:SetAlpha(1) end)
                check:SetScript('OnEnter', function(self2)
                    e.tips:SetOwner(self2, "ANCHOR_RIGHT")
                    e.tips:ClearLines()
                    e.tips:AddDoubleLine(self2.icon ..self2.name, self2.index)
                    e.tips:AddLine(' ')
                    e.tips:AddLine(e.onlyChinese and '快捷键' or SETTINGS_KEYBINDINGS_LABEL)
                    e.tips:AddDoubleLine(id, Initializer:GetName())
                    e.tips:Show()
                    self2:SetAlpha(0.3)
                end)
                check.index= tab.index
                FastButton[index]= check
            end
            local checked= C_AddOns.GetAddOnEnableState(name)~=0
            check:SetChecked(checked)
            check:SetShown(true)

            local iconTexture = C_AddOns.GetAddOnMetadata(name, "IconTexture")
            local iconAtlas = C_AddOns.GetAddOnMetadata(name, "IconAtlas")
            local icon= ''
            if iconTexture then
                icon= '|T'..iconTexture..':26|t'
            elseif iconAtlas then
                icon='|A:'..iconAtlas..':26:26|a'
            end
            check.Text:SetText(name..icon)
            if checked then
                check.Text:SetTextColor(0,1,0)
            else
                check.Text:SetTextColor(1, 0.82, 0)
            end
            check.icon= icon
            last= check
            check.name= name
        end
    end
    for i= index+1, #FastButton, 1 do
        local check= FastButton[i]
        if check then
            check:SetShown(false)
        end
    end
end









































--列表，内容
local function Init_Set_List(frame, addonIndex)
    local name= C_AddOns.GetAddOnInfo(addonIndex)
    if Save.fast[name] then
        Save.fast[name]= addonIndex
    end
    local checked= Save.fast[name]

    if not frame.check then
        frame.check=CreateFrame("CheckButton", nil, frame, "InterfaceOptionsCheckButtonTemplate")

        frame.check:SetSize(20,20)--Fast，选项

        frame.check:SetPoint('RIGHT', frame)
        frame.check:SetScript('OnClick', function(self)
            Save.fast[self.name]= not Save.fast[self.name] and self.index or nil
            Set_Fast_Button()
        end)

        frame.check.dep= frame:CreateLine()--依赖，提示
        frame.check.dep:SetColorTexture(1, 0.82, 0)
        frame.check.dep:SetStartPoint('BOTTOMLEFT', 55,2)
        frame.check.dep:SetEndPoint('BOTTOMRIGHT', -20,2)
        frame.check.dep:SetThickness(0.5)
        frame.check.dep:SetAlpha(0.2)

        frame.check.select= frame:CreateTexture(nil, 'OVERLAY')--光标，移过提示
        frame.check.select:SetAtlas('CreditsScreen-Selected')
        frame.check.select:SetAllPoints(frame)
        frame.check.select:Hide()

        frame.check.Text:SetParent(frame)--索引
        frame.check.Text:ClearAllPoints()
        frame.check.Text:SetPoint('RIGHT', frame.check, 'LEFT')

        function frame.check:set_leave_alpha()
            self:SetAlpha(Save.fast[self.name] and 1 or 0)
            self.Text:SetAlpha(C_AddOns.GetAddOnDependencies(self.index) and 0.3 or 1)
            self.select:SetShown(false)
            local check= self:GetParent().Enabled
            check:SetAlpha(check:GetChecked() and 1 or 0)
        end
        function frame.check:set_enter_alpha()
            self:SetAlpha(1)
            self.Text:SetAlpha(1)
            self.select:SetShown(true)
            self:GetParent().Enabled:SetAlpha(1)
        end

        frame.check:SetScript('OnLeave', function(self)
            e.tips:Hide()
            self:set_leave_alpha()
        end)
        frame.check:SetScript('OnEnter', function(self)
            e.tips:SetOwner(self, "ANCHOR_RIGHT")
            e.tips:ClearLines()
            e.tips:AddDoubleLine(id, Initializer:GetName())
            e.tips:AddLine(e.onlyChinese and '快捷键' or SETTINGS_KEYBINDINGS_LABEL)
            e.tips:AddLine(' ')
            e.tips:AddDoubleLine((self.icon or '')..self.name, self.index)
            e.tips:Show()
            self:set_enter_alpha()
        end)
        frame.Enabled:HookScript('OnLeave', function(self)
            self:GetParent().check:set_leave_alpha()
        end)
        frame.Enabled:HookScript('OnEnter', function(self)
            self:GetParent().check:set_enter_alpha()
        end)
        frame:HookScript('OnLeave', function(self)
            self.check:set_leave_alpha()
        end)
        frame:HookScript('OnEnter', function(self)
            self.check:set_enter_alpha()
        end)
    end

    local iconTexture = C_AddOns.GetAddOnMetadata(name, "IconTexture")
    local iconAtlas = C_AddOns.GetAddOnMetadata(name, "IconAtlas")

    if not iconTexture and not iconAtlas then--去掉，没有图标，提示
        local title= frame.Title:GetText()
        if title and title:find('|TInterface\\ICONS\\INV_Misc_QuestionMark:%d+:%d+|t') then
            frame.Title:SetText(title:gsub('|TInterface\\ICONS\\INV_Misc_QuestionMark:%d+:%d+|t', '      '))
        end
    end

    frame.check:SetCheckedTexture(iconTexture or e.Icon.icon)
    frame.check.icon= iconTexture and '|T'..iconTexture..':32|t' or (iconAtlas and '|A:'..iconAtlas..':32:32|a') or nil
    frame.check.index= addonIndex
    frame.check.name= name
    frame.check:SetChecked(checked and true or false)--fast
    frame.check:SetAlpha(checked and 1 or 0.1)

    frame.check.Text:SetText(addonIndex or '')--索引

    if C_AddOns.GetAddOnDependencies(addonIndex) then--依赖
        frame.check.select:SetVertexColor(0,1,0)
        frame.check.Text:SetTextColor(0,1,0)
        frame.check.Text:SetAlpha(0.3)
        frame.check.dep:SetShown(false)
    else
        frame.check.select:SetVertexColor(1,1,1)
        frame.check.Text:SetTextColor(1, 0.82, 0)
        frame.check.Text:SetAlpha(1)
        frame.check.dep:SetShown(true)
    end
    frame.Status:SetAlpha(0.5)
    frame.Enabled:SetAlpha(frame.Enabled:GetChecked() and 1 or 0)
end





























--#####
--初始化
--#####
local function Init()
    AddonListForceLoad:ClearAllPoints()
    AddonListForceLoad:SetPoint('TOP', AddonList, -16, -26)

    AddonListEnableAllButton.AllNumText= e.Cstr(AddonListEnableAllButton, {color={r=1,g=1,b=1}})
    AddonListEnableAllButton.AllNumText:SetPoint('LEFT',5,0)
    AddonListEnableAllButton.AllNumText:SetText(C_AddOns.GetNumAddOns())
    Init_Add_Save_Button()--新建按钮
    --Set_Fast_Button()
    hooksecurefunc('AddonList_InitButton', Init_Set_List)--列表，内容
-- e.call('AddonList_HasAnyChanged')
    hooksecurefunc('AddonList_Update', function()
        local load, some, sel, tab= Get_AddList_Info()--检查列表, 选取数量, 总数, 数量/总数
        local all= some+ sel
        AddonList.WoWToolsButton:SetShown(all>0)
        AddonList.WoWToolsButton.Text:SetFormattedText('%d%s/|cnGREEN_FONT_COLOR:%d|r', sel, some>0 and format(' (%s%d) ', e.Icon.player, some) or '', load)
        Set_Fast_Button()--插件，快捷，选中
        Set_Buttons()

    end)



    --#############
    --不禁用，本插件
    --#############
    AddonListDisableAllButton.btn= e.Cbtn(AddonListDisableAllButton, {size={18,18}, icon= Save.enableAllButtn})
    AddonListDisableAllButton.btn:SetPoint('LEFT', AddonListDisableAllButton, 'RIGHT', 2,0)
    AddonListDisableAllButton.btn:SetScript('OnClick', function(self2)
        Save.enableAllButtn= not Save.enableAllButtn and true or nil
        self2:SetNormalAtlas(Save.enableAllButtn and e.Icon.icon or e.Icon.disabled)
    end)
    AddonListDisableAllButton.btn:SetAlpha(0.3)
    AddonListDisableAllButton.btn:SetScript('OnLeave', function(self2) e.tips:Hide() self2:GetParent():SetAlpha(1) end)
    AddonListDisableAllButton.btn:SetScript('OnEnter', function(self2)
        e.tips:SetOwner(self2, "ANCHOR_RIGHT")
        e.tips:ClearLines()
        e.tips:AddDoubleLine(e.onlyChinese and '启用' or ENABLE, id)
        e.tips:AddLine(' ')
        e.tips:AddDoubleLine(e.onlyChinese and '设置' or SETTINGS, e.GetEnabeleDisable(Save.enableAllButtn))
        e.tips:AddDoubleLine(id, e.cn(addName))
        e.tips:Show()
        self2:GetParent():SetAlpha(0.3)
    end)
    AddonListDisableAllButton:HookScript('OnClick', function()
        if Save.enableAllButtn then
            C_AddOns.EnableAddOn(id)
            e.call('AddonList_Update')
        end
    end)
end


















--###########
--加载保存数据
--###########
local panel= CreateFrame('Frame')
panel:RegisterEvent("ADDON_LOADED")
panel:RegisterEvent("PLAYER_LOGOUT")
panel:SetScript("OnEvent", function(_, event, arg1)
    if event == "ADDON_LOADED" then
        if arg1==id then
            Save= WoWToolsSave[addName] or Save
            Save.fast= Save.fast or {}

            --[[if e.Player.husandro then
                Save.buttons[e.onlyChinese and '宠物对战' or PET_BATTLE_COMBAT_LOG ]={
                    ['BugSack']=true,
                    ['!BugGrabber']=true,
                    ['tdBattlePetScript']=true,
                    --['zAutoLoadPetTeam_Rematch']=true,
                    ['Rematch']=true,
                    [id]=true,
                }
                Save.buttons[e.onlyChinese and '副本' or INSTANCE ]={
                    ['BugSack']=true,
                    ['!BugGrabber']=true,
                    ['WeakAuras']=true,
                    ['WeakAurasOptions']=true,
                    ['Details']=true,
                    ['DBM-Core']=true,
                    ['DBM-Challenges']=true,
                    ['DBM-StatusBarTimers']=true,
                    [id]=true,
                }
                Save.fast={
                    ['TextureAtlasViewer']=78,
                    ['WoWeuCN_Tooltips']=96,
                }
            end]]

            --添加控制面板
            Initializer= e.AddPanel_Check({
                name= '|A:Garr_Building-AddFollowerPlus:0:0|a'..(e.onlyChinese and '插件管理' or addName),
                tooltip= e.cn(addName),
                value= not Save.disabled,
                func= function()
                    Save.disabled = not Save.disabled and true or nil
                    print(id, e.cn(addName), e.GetEnabeleDisable(not Save.disabled), e.onlyChinese and '需求重新加载' or REQUIRES_RELOAD)
                end
            })

            if not Save.disabled then
                Init()
            end
          panel:UnregisterEvent('ADDON_LOADED')
        end

    elseif event == "PLAYER_LOGOUT" then
        if not e.ClearAllSave then
            WoWToolsSave[addName]=Save
        end
    end
end)