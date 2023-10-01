local id, e = ...
local addName=USE_ITEM

local panel= CreateFrame("Frame")
local button

local Save= {
        item={
            --156833,--[凯蒂的印哨]
            194885,--[欧胡纳栖枝]收信
            40768,--[移动邮箱]
            114943,--[终极版侏儒军刀]
            168667,--[布林顿7000]

            49040,--[基维斯]
            144341,--[可充电的里弗斯电池]

            128353,--[海军上将的罗盘]
            167075,--[超级安全传送器：麦卡贡]
            168222,--[加密的黑市电台]
            184504,184501, 184503, 184502, 184500, 64457,--[侍神者的袖珍传送门：奥利波斯]
            198156,--龙洞发生器
            172924,--[虫洞发生器：暗影界]
            168807,--[虫洞发生器：库尔提拉斯]
            168808,--[虫洞发生器：赞达拉]
            151652,--[虫洞发生器：阿古斯]
            112059,--[虫洞离心机]
            87215,--[虫洞发生器：潘达利亚]
            48933,--[虫洞发生器：诺森德]
            30542,--[空间撕裂器 - 52区]
            151016,--[开裂的死亡之颅]
            136849, 52251,--[自然道标]
            139590,--[传送卷轴：拉文霍德]
            87216,--[热流铁砧]
            85500,--[垂钓翁钓鱼筏]
            37863,--[烈酒的遥控器]
            --141605,--[飞行管理员的哨子]
            200613,--艾拉格风石碎片
        },
        spell={
            83958,--移动银行
            69046,--[呼叫大胖],种族特性
            50977,--[黑锋之门]
            193753,--[传送：月光林地]
            556,--[星界传送]
            18960,--[梦境行者]
            126892,--[禅宗朝圣]
        },
        equip={
            65274,65360, 63206, 63207, 63352, 63353,--协同披风
            103678,--迷时神器
            142469,--魔导大师的紫罗兰印戒
            144391, 144392,--拳手的重击指环
        }
}

local function find_Type(type, ID)
    for index, ID2 in pairs(Save[type]) do
        if ID2==ID then
            return index
        end
    end
end

local function get_Find(ID, spell)
    if spell then
        if IsSpellKnown(ID) then
            return true
        end
    else
        if GetItemCount(ID)>0 or (PlayerHasToy(ID) and C_ToyBox.IsToyUsable(ID)) then
            return true
        end
    end
end

local function set_button_Event(self, isShown)--事件
    local tab={}
    if self.spellID then
        tab= {
            'SPELL_UPDATE_USABLE',
            'SPELL_UPDATE_COOLDOWN',
        }
    elseif self.itemID then
        tab={
            'BAG_UPDATE_DELAYED',
            'BAG_UPDATE_COOLDOWN'
        }
    end
    if isShown then
        FrameUtil.RegisterFrameForEvents(self, tab)
    else
        FrameUtil.UnregisterFrameForEvents(self, tab)
    end
end


--#####
--主菜单
--#####
local function Init_Menu(_, level, type)--主菜单
    local info
    if type then
        for index, ID in pairs(Save[type]) do
            local name, icon, _
            if type=='spell' then
                name, _, icon =GetSpellInfo(ID)
            else
                name= C_Item.GetItemNameByID(ID)
                icon=C_Item.GetItemIconByID(ID)
            end
            name=name or (type..'ID '..ID)
            local text=(icon and '|T'..icon..':0|t' or '') ..name
            info={
                text= name,
                notCheckable=true,
                icon=icon,
                keepShownOnClick=true,
            }

            if (type=='spell' and not IsSpellKnown(ID)) or ((type=='item' or type=='equip') and GetItemCount(ID)==0 and not PlayerHasToy(ID)) then
                info.text= e.Icon.O2..info.text
                info.colorCode='|cff606060'
            end

            local isToy= type=='item' and C_ToyBox.GetToyInfo(ID)
            if isToy then
                info.text= '|A:soulbinds_tree_conduit_icon_utility:0:0|a'..info.text
                info.tooltipOnButton=true
                info.tooltipTitle= e.onlyChinese and '添加/移除' or (ADD..'/'..REMOVE)
                info.tooltipText= (e.onlyChinese and '藏品->玩具箱' or (COLLECTIONS..'->'..TOY_BOX))..e.Icon.left
                info.arg1=ID
                info.func=function(_, arg1)
                    if ToyBox and not ToyBox:IsVisible() then
                        ToggleCollectionsJournal(3)
                    end
                    local name2= arg1 and select(2, C_ToyBox.GetToyInfo(arg1))
                    if name2 then
                        C_ToyBoxInfo.SetDefaultFilters()
                        if ToyBox.searchBox then
                            ToyBox.searchBox:SetText(name2)
                        end
                    end
                end
            else
                info.arg1={type=type, index=index, name=text, ID=ID}
                info.func=function(_, arg1)
                    StaticPopup_Show(id..addName..'REMOVE',arg1.name, '', arg1)
                end
                info.tooltipOnButton=true
                info.tooltipTitle='|cnRED_FONT_COLOR:'..REMOVE..'|r'
            end
            e.LibDD:UIDropDownMenu_AddButton(info, level)
        end

        e.LibDD:UIDropDownMenu_AddSeparator(level)
        local cleraAllText='|cnRED_FONT_COLOR:'..(e.onlyChinese and '全部清除' or CLEAR_ALL)..'|r '..(type=='spell' and (e.onlyChinese and '法术' or SPELLS) or type=='item' and (e.onlyChinese and '物品' or ITEMS) or (e.onlyChinese and '装备' or EQUIPSET_EQUIP))..' #'..'|cnGREEN_FONT_COLOR:'..#Save[type]..'|r'
        info={--清除全部
            text=cleraAllText,
            notCheckable=true,
            keepShownOnClick=true,
            tooltipOnButton=true,
            tooltipTitle= e.onlyChinese and '重新加载UI' or RELOADUI,
            arg1=cleraAllText,
            arg2= type,
            func=function(_, arg1, arg2)
                StaticPopup_Show(id..addName..'REMOVE', arg1 ,nil, {type=arg2, clearAll=true})
            end,
        }
        e.LibDD:UIDropDownMenu_AddButton(info, level)
        return
    end

    local tab={
        [e.onlyChinese and '物品' or ITEMS]='item',
        [e.onlyChinese and '法术' or SPELLS]='spell',
        [e.onlyChinese and '装备' or EQUIPSET_EQUIP]='equip'
    }
    for text, type2 in pairs(tab) do
        info={
            text=text..' |cnGREEN_FONT_COLOR:'..#Save[type2]..'|r',
            notCheckable=true,
            hasArrow=true,
            menuList=type2,
            keepShownOnClick=true,
        }
        e.LibDD:UIDropDownMenu_AddButton(info, level);
    end
    e.LibDD:UIDropDownMenu_AddSeparator(level)
    info={
        text= e.onlyChinese and '重新加载UI' or RELOADUI,
        notCheckable=true,
        keepShownOnClick=true,
        tooltipOnButton=true,
        tooltipTitle='/reload',
        func=function()
            e.Reload()
        end
    }
    e.LibDD:UIDropDownMenu_AddButton(info, level);
    e.LibDD:UIDropDownMenu_AddSeparator(level)
    info={
        text= e.onlyChinese and '重置' or RESET,
        colorCode='|cffff0000',
        notCheckable=true,
        tooltipOnButton=true,
        tooltipTitle= e.onlyChinese and '全部重置' or RESET_ALL_BUTTON_TEXT,
        tooltipText= e.onlyChinese and '重新加载UI' or RELOADUI,
        func=function()
            StaticPopup_Show(id..addName..'RESETALL')
        end
    }
    e.LibDD:UIDropDownMenu_AddButton(info, level);
    e.LibDD:UIDropDownMenu_AddButton({text=addName, isTitle=true, notCheckable=true}, level);
    e.LibDD:UIDropDownMenu_AddButton({
        text= e.onlyChinese and '拖曳: 物品, 法术, 装备' or (DRAG_MODEL..', '..SPELLS..', '..ITEMS),
        isTitle=true,
        notCheckable=true
    }, level);

end


--####
--物品
--####
local function set_Equip_Slot(self)--装备
    if UnitAffectingCombat('player') then
        self:RegisterEvent('PLAYER_REGEN_ENABLED')
        return
    end
    local slotItemID=GetInventoryItemID('player', self.slot)
    local slotItemLink=GetInventoryItemLink('player', self.slot)
    local name= slotItemLink and GetItemInfo(slotItemLink) or slotItemID and C_Item.GetItemNameByID(slotItemID)
    if name and slotItemID~=self.itemID and self:GetAttribute('item2')~=name then
        self:SetAttribute('item2', name)
        self.slotEquipName=name
        local icon = C_Item.GetItemIconByID(slotItemID)
        if icon and not self.slotTexture then--装备前的物品,提示
            self.slotequipedTexture=self:CreateTexture(nil, 'OVERLAY')
            self.slotequipedTexture:SetPoint('BOTTOMRIGHT',-7,9)
            self.slotequipedTexture:SetSize(8,8)
            self.slotequipedTexture:SetTexture(icon)
            self.slotequipedTexture:SetDrawLayer('OVERLAY', 2)
        end
    elseif not name then
        self:SetAttribute('item2', nil)
    end
    if slotItemID==self.itemID and not self.equipedTexture then--自身已装备提示
        self.equipedTexture=self:CreateTexture(nil, 'OVERLAY')
        self.equipedTexture:SetPoint('BOTTOMLEFT',2,5)
        self.equipedTexture:SetSize(15,15)
        self.equipedTexture:SetAtlas('charactercreate-icon-customize-body-selected')
        self.equipedTexture:SetDrawLayer('OVERLAY', 2)
    end

    if self.equipedTexture then
        self.equipedTexture:SetShown(slotItemID==self.itemID)
    end
    if  self.slotequipedTexture then
        self.slotequipedTexture:SetShown(slotItemID==self.itemID)
    end
    self:UnregisterEvent('PLAYER_REGEN_ENABLED')
end

local function set_Item_Count(self)--数量
    local num = GetItemCount(self.itemID,nil,true,true)
    if not PlayerHasToy(self.itemID) then
        if num~=1 and not self.count then
            self.count=e.Cstr(self, {size=10, color=true})--10,nil,nil,true)
            self.count:SetPoint('BOTTOMRIGHT',-2, 9)
        end
        if self.count then
            self.count:SetText(num~=1 and num or '')
        end
    end
    self.texture:SetDesaturated(num==0 and not PlayerHasToy(self.itemID))
end

local function set_Bling_Quest(self)--布林顿任务
    local complete=C_QuestLog.IsQuestFlaggedCompleted(56042)
    if not self.quest then
        self.quest=e.Cstr(self, {size=8})
        self.quest:SetPoint('BOTTOM',0,8)
    end
    self.quest:SetText(complete and '|cnGREEN_FONT_COLOR:'..COMPLETE..'|r' or e.Icon.info2)
end
local function init_Item_Button(self, equip)--设置按钮
    self:SetScript('OnEnter', function()
        e.tips:SetOwner(self, "ANCHOR_LEFT")
        e.tips:ClearLines()
        e.tips:SetItemByID(self.itemID)
        e.tips:Show()
    end)
    self:SetScript('OnLeave', function() e.tips:Hide() end)
    self:SetScript("OnEvent", function(self2, event, arg1)
        if event=='BAG_UPDATE_DELAYED' then
            set_Item_Count(self2)
        elseif event=='BAG_UPDATE_COOLDOWN' then
            e.SetItemSpellCool(self2, self2.itemID, nil)
        elseif event=='QUEST_COMPLETE' then
            set_Bling_Quest(self2)
        elseif event=='PLAYER_EQUIPMENT_CHANGED' or 'PLAYER_REGEN_ENABLED' then
            set_Equip_Slot(self2)
        end
    end)
    self:SetScript('OnShow', function(self2)
        set_button_Event(self2, true)--事件
        e.SetItemSpellCool(self, self.itemID, nil)
        set_Item_Count(self)
    end)
    self:SetScript('OnHide', function(self2)
        set_button_Event(self2)--事件
    end)

    if equip then
        self:RegisterEvent("PLAYER_EQUIPMENT_CHANGED")
        self:SetScript('OnMouseUp',function()
            local frame=PaperDollFrame
            if frame and not frame:IsVisible() then
                ToggleCharacter("PaperDollFrame");
            end
        end)
        set_Equip_Slot(self)
    end
    if self.itemID==168667 or self.itemID==87214 or self==111821 then--布林顿任务
        self:RegisterEvent('QUEST_COMPLETE')
        set_Bling_Quest(self)
    end
end

--###
--法术
--###
local function set_Spell_Count(self)--次数
    local num, max= GetSpellCharges(self.spellID)
    if max and max>1 and not self.count then
        self.count=e.Cstr(self, {color=true})--nil,nil,nil,true)
        self.count:SetPoint('BOTTOMRIGHT',-2, 9)
    end
    if self.count then
        self.count:SetText((max and max>1) and num or '')
    end
    self.texture:SetDesaturated(num and num>0)
end

local function init_Spell_Button(self)--设置按钮
    self:SetScript('OnEnter', function()
        e.tips:SetOwner(self, "ANCHOR_LEFT")
        e.tips:ClearLines()
        e.tips:SetSpellByID(self.spellID)
        e.tips:Show()
    end)
    self:SetScript('OnLeave', function() e.tips:Hide() end)
    self:SetScript("OnEvent", function(self2, event)
        if event=='SPELL_UPDATE_USABLE' then
            set_Spell_Count(self2)
        elseif event=='SPELL_UPDATE_COOLDOWN' then
            e.SetItemSpellCool(self2, nil, self2.spellID)
        end
    end)
    self:SetScript('OnShow', function(self2)
        set_button_Event(self2, true)
        e.SetItemSpellCool(self, nil, self.spellID)
        set_Spell_Count(self)
    end)
    self:SetScript('OnHide', function(self2)
        set_button_Event(self2)
    end)
end


--#############
--玩具界面, 菜单
--#############
local function setToySpellButton_UpdateButton(self2)--标记, 是否已选取
    if not self2.useItem then
        self2.useItem= e.Cbtn(self2,{size={16,16}, atlas='soulbinds_tree_conduit_icon_utility'})
        self2.useItem:SetPoint('TOPLEFT',self2.name,'BOTTOMLEFT', 32,0)
        self2.useItem:SetScript('OnLeave', function() e.tips:Hide() end)
        self2.useItem:SetScript('OnEnter', function(self3)
            e.tips:SetOwner(self3, "ANCHOR_LEFT")
            e.tips:ClearLines()
            local itemID=self3:GetParent().itemID
            e.tips:AddDoubleLine(itemID and C_ToyBox.GetToyLink(itemID) or itemID, e.GetEnabeleDisable(find_Type('item', itemID))..e.Icon.left)
            e.tips:AddDoubleLine(e.onlyChinese and '菜单' or SLASH_TEXTTOSPEECH_MENU, e.Icon.right)
            e.tips:AddLine(' ')
            e.tips:AddDoubleLine(id,'Tools |A:soulbinds_tree_conduit_icon_utility:0:0|a'..addName)
            e.tips:Show()
        end)
        self2.useItem:SetScript('OnClick', function(self3, d)
            if d=='LeftButton' then
                local frame=self3:GetParent()
                local itemID= frame and frame.itemID
                local find=find_Type('item', itemID)
                if find then
                    table.remove(Save.item, find)
                else
                    table.insert(Save.item, itemID)
                end
                print(id, addName, C_ToyBox.GetToyLink(itemID), find and (e.onlyChinese and '移除' or REMOVE) or (e.onlyChinese and '添加' or ADD), '|cffff00ff', e.onlyChinese and '需要重新加载' or REQUIRES_RELOAD)
                e.call('ToySpellButton_UpdateButton', frame)
            else
                e.LibDD:ToggleDropDownMenu(1, nil, button.Menu, self3, 15, 0)
            end
        end)
    end
    self2.useItem:SetAlpha(find_Type('item', self2.itemID) and 1 or 0.1)
end


--###
--初始
--###
local function Init()
    --###########
    --添加, 对话框
    --###########
    StaticPopupDialogs[id..addName..'REMOVE']={
        text=id..' '..addName..'|n|n%s',
        whileDead=true, hideOnEscape=true, exclusive=true,
        button1='|cnRED_FONT_COLOR:'..(e.onlyChinese and '移除' or REMOVE)..'|r',
        button2=e.onlyChinese and '取消' or CANCEL,
        OnAccept = function(_, data)
            if data.clearAll then
                Save[data.type]={}
                e.Reload()
            else
                if Save[data.type][data.index] and Save[data.type][data.index]==data.ID then
                    table.remove(Save[data.type], data.index)
                    print(id, addName, '|cnGREEN_FONT_COLOR:'..(e.onlyChinese and '移除' or REMOVE)..'|r'..(e.onlyChinese and '完成' or COMPLETE), data.name, '|cnRED_FONT_COLOR:'..REQUIRES_RELOAD..'|r')
                else
                    print(id, addName,'|cnGREEN_FONT_COLOR:'..(e.onlyChinese and '错误' or ERROR_CAPS)..'|r', e.onlyChinese and '未发现物品' or	BROWSE_NO_RESULTS, data.name)
                end
            end
        end,
    }

    StaticPopupDialogs[id..addName..'RESETALL']={--重置所有
        text=id..' '..addName..'|n|n'..(e.onlyChinese and '全部重置' or RESET_ALL_BUTTON_TEXT)..'|n|n'..(e.onlyChinese and '重新加载UI' or RELOADUI),
        whileDead=true, hideOnEscape=true, exclusive=true,
        button1= e.onlyChinese and '重置' or RESET,
        button2= e.onlyChinese and '取消' or CANCEL,
        OnAccept = function()
            Save=nil
            e.Reload()
        end,
    }

    StaticPopupDialogs[id..addName..'ADD']={--添加, 移除
        text=id..' '..addName..'|n|n%s: %s',
        whileDead=true, hideOnEscape=true, exclusive=true,
        button1= e.onlyChinese and '添加' or ADD,
        button2= e.onlyChinese and '取消' or CANCEL,
        button3= e.onlyChinese and '移除' or REMOVE,
        OnShow = function(self, data)
            local find=find_Type(data.type, data.ID)
            data.index=find
            self.button3:SetEnabled(find)
            self.button1:SetEnabled(not find)
        end,
        OnAccept = function(_, data)
            table.insert(Save[data.type], data.ID)
            print(id, addName, '|cnGREEN_FONT_COLOR:'..(e.onlyChinese and '添加' or ADD)..'|r', e.onlyChinese and '完成' or COMPLETE, data.name, e.onlyChinese and '需要重新加载' or REQUIRES_RELOAD)
        end,
        OnAlt = function(_, data)
            table.remove(Save[data.type], data.index)
            print(id, addName, '|cnRED_FONT_COLOR:'..(e.onlyChinese and '移除' or REMOVE)..'|r', e.onlyChinese and '完成' or COMPLETE, data.name, e.onlyChinese and '需要重新加载' or REQUIRES_RELOAD)
        end,
    }

    button.Menu=CreateFrame("Frame", nil, button, "UIDropDownMenuTemplate")
    e.LibDD:UIDropDownMenu_Initialize(button.Menu, Init_Menu, 'MENU')

   for _, itemID in pairs(Save.item) do
        local name ,icon
        if get_Find(itemID) then
            name = C_Item.GetItemNameByID(itemID)
            icon = C_Item.GetItemIconByID(itemID)
            if name and icon then
                local btn= e.Cbtn2({
                    name=id..addName..name,
                    parent= e.toolsFrame,
                    click=true,-- right left
                    notSecureActionButton=nil,
                    notTexture=nil,
                    showTexture=true,
                    sizi=nil,
                })

                btn.itemID=itemID
                init_Item_Button(btn)
                e.ToolsSetButtonPoint(btn)--设置位置
                btn:SetAttribute('type', 'item')
                btn:SetAttribute('item', name)
                btn.texture:SetTexture(icon)
            end
        end
   end

    for _, itemID in pairs(Save.equip) do
        local name ,icon
        if GetItemCount(itemID)>0 then
            name = C_Item.GetItemNameByID(itemID)
            local itemEquipLoc, icon2 = select(4, GetItemInfoInstant(itemID))
            icon =icon2 or C_Item.GetItemIconByID(itemID)
            local slot=itemEquipLoc and e.itemSlotTable[itemEquipLoc]

            if name and icon and slot then
                local btn= e.Cbtn2({
                    name=nil,
                    parent= e.toolsFrame,
                    click=true,-- right left
                    notSecureActionButton=nil,
                    notTexture=nil,
                    showTexture=true,
                    sizi=nil,
                })
                btn.itemID=itemID
                btn.slot=slot
                init_Item_Button(btn, true)
                e.ToolsSetButtonPoint(btn)--设置位置
                btn:SetAttribute('type', 'item')
                btn:SetAttribute('item', name)
                btn:SetAttribute('type2', 'item')
                btn.texture:SetTexture(icon)
            end
        end
    end

    for _, spellID in pairs(Save.spell) do
        if IsSpellKnown(spellID) then
            local name, _, icon = GetSpellInfo(spellID)
            if name and icon then
                if name and icon then
                    local btn= e.Cbtn2({
                        name=nil,
                        parent= e.toolsFrame,
                        click=true,-- right left
                        notSecureActionButton=nil,
                        notTexture=nil,
                        showTexture=true,
                        sizi=nil,
                    })
                    btn.spellID=spellID
                    init_Spell_Button(btn)
                    e.ToolsSetButtonPoint(btn)--设置位置
                    btn:SetAttribute('type', 'spell')
                    btn:SetAttribute('spell', name)
                    btn.texture:SetTexture(icon)
                end
            end
        end
    end


    button:SetScript('OnMouseDown',function(self, d)--添加, 移除
        local infoType, itemID, itemLink ,spellID= GetCursorInfo()
        if infoType == "item" and itemID and itemLink then
            local itemEquipLoc= select(4, GetItemInfoInstant(itemLink))
            local slot=itemEquipLoc and e.itemSlotTable[itemEquipLoc]
            local type = slot and 'equip' or 'item'
            local text = slot and EQUIPSET_EQUIP or ITEMS
            local icon = C_Item.GetItemIconByID(itemLink)
            StaticPopup_Show(id..addName..'ADD', text , (icon and '|T'..icon..':0|t' or '')..itemLink, {type=type, name=itemLink, ID=itemID})
            ClearCursor()

        elseif infoType =='spell' and spellID then
            local spellLink=GetSpellLink(spellID) or (SPELLS..' ID: '..spellID)
            local icon=GetSpellTexture(spellID)
            StaticPopup_Show(id..addName..'ADD', SPELLS , (icon and '|T'..icon..':0|t' or '')..spellLink, {type='spell', name=spellLink, ID=spellID})
            ClearCursor()

        elseif d=='LeftButton' then
            e.tips:SetOwner(self, "ANCHOR_LEFT")
            e.tips:ClearLines()
            e.tips:AddDoubleLine(id, addName)
            e.tips:AddDoubleLine(DRAG_MODEL, ADD)
            e.tips:AddDoubleLine(SPELLS, ITEMS, 0,1,0, 0,1,0)
            e.tips:AddDoubleLine(MAINMENU or SLASH_TEXTTOSPEECH_MENU, e.Icon.right)
            e.tips:Show()
        elseif d=='RightButton' then
            e.LibDD:ToggleDropDownMenu(1, nil, self.Menu, self, 15, 0)
        end
    end)
    button:SetScript('OnEnter',function (self)
        self:SetAlpha(1.0)
    end)
    button:SetScript('OnLeave', function (self)
        self:SetAlpha(0.1)
        e.tips:Hide()
    end)

    --#################
    --法术书，界面, 菜单
    --#################
    local function set_Use_Spell_Button(self2, spellID)
        if not self2.useSpell and spellID then
            self2.useSpell= e.Cbtn(self2, {size={16,16}, atlas='soulbinds_tree_conduit_icon_utility'})
            self2.useSpell:SetPoint('TOP', self2, 'BOTTOM')
            function self2.useSpell:Set_Alpha()
                if self.spellID then
                    self:SetAlpha(find_Type('spell', self.spellID) and 1 or 0.2)
                end
            end
            self2.useSpell:SetScript('OnLeave', function(self3) e.tips:Hide() self3:Set_Alpha()  end)
            self2.useSpell:SetScript('OnEnter', function(self3)
                e.tips:SetOwner(self3, "ANCHOR_LEFT")
                e.tips:ClearLines()
                if self3.spellID then
                    local text
                    local icon= GetSpellTexture(self3.spellID)
                    text= icon and '|T'..icon..':0|t' or ''
                    text= text..(C_SpellBook.GetSpellLinkFromSpellID(self3.spellID) or '')..self3.spellID
                    e.tips:AddDoubleLine(text, e.GetEnabeleDisable(find_Type('spell', self3.spellID))..e.Icon.left)
                end
                e.tips:AddDoubleLine(e.onlyChinese and '菜单' or SLASH_TEXTTOSPEECH_MENU, e.Icon.right)
                e.tips:AddLine(' ')
                e.tips:AddDoubleLine(id,'Tools |A:soulbinds_tree_conduit_icon_utility:0:0|a'..addName)
                e.tips:Show()
                self3:SetAlpha(1)
            end)
            self2.useSpell:SetScript('OnClick', function(self3, d)
                if d=='LeftButton' then
                    if self3.spellID then
                        local findIndex= find_Type('spell', self3.spellID)
                        print(findIndex)
                        if findIndex then
                            table.remove(Save.spell, findIndex)
                        else
                            table.insert(Save.spell, self3.spellID)
                        end
                        print(id, addName, C_SpellBook.GetSpellLinkFromSpellID(self3.spellID), findIndex and (e.onlyChinese and '移除' or REMOVE) or (e.onlyChinese and '添加' or ADD), '|cffff00ff', e.onlyChinese and '需要重新加载' or REQUIRES_RELOAD)
                        self3:Set_Alpha()
                    end
                else
                    e.LibDD:ToggleDropDownMenu(1, nil, button.Menu, self3, 15, 0)
                end
            end)

        end
        if self2.useSpell then
            self2.useSpell.spellID= spellID
            self2.useSpell:Set_Alpha()
            self2.useSpell:SetShown(spellID and true or false)
        end
    end
    for i=1, SPELLS_PER_PAGE  do--SPELLS_PER_PAGE = 12
        local btn= _G['SpellButton'..i]
        if btn and btn.UpdateButton then
            hooksecurefunc(btn, 'UpdateButton', function(self2)--SpellBookFrame.lua
                local slot = SpellBook_GetSpellBookSlot(self2)
                if not slot or SpellBookFrame.bookType~='spell' then
                    if self2.useSpell then
                        self2.useSpell:SetShown(false)
                    end
                    return
                end
                set_Use_Spell_Button(self2, select(3, GetSpellBookItemName(slot, SpellBookFrame.bookType))
            )
            end)
        end
    end
    hooksecurefunc('SpellFlyoutButton_UpdateGlyphState', function(self2)
        local name = self2:GetParent():GetParent():GetName()
        if not (name and name:find('SpellButton')) or not self2.spellID then
            if self2.useSpell then
                self2.useSpell:SetShown(false)
            end
            return
        end
        set_Use_Spell_Button(self2, self2.spellID)
    end)
end

--###########
--加载保存数据
--###########
panel:RegisterEvent("ADDON_LOADED")
panel:RegisterEvent("PLAYER_LOGOUT")
panel:RegisterEvent("PLAYER_REGEN_ENABLED")

panel:SetScript("OnEvent", function(_, event, arg1)
    if event == "ADDON_LOADED" then
        if arg1== id then
            button=e.Cbtn(e.toolsFrame, {atlas='Soulbinds_Tree_Conduit_Icon_Utility', size={20,20}})
            button:SetPoint('BOTTOMLEFT', e.toolsFrame, 'TOPRIGHT',-2,5)

            if not WoWToolsSave[addName..'Tools'] then
                button:SetAlpha(1)
            else
                button:SetAlpha(0.1)
            end

            if (not WoWToolsSave or not WoWToolsSave[addName..'Tools']) and PlayerHasToy(156833) and Save.item[1]==194885 then
                Save.item[1] = 156833
            end

            Save= WoWToolsSave[addName..'Tools'] or Save

            if not e.toolsFrame.disabled then
                for _, ID in pairs(Save.item) do
                    e.LoadDate({id=ID, type='item'})
                end
                for _, ID in pairs(Save.spell) do
                    e.LoadDate({id=ID, type='spell'})
                end
                for _, ID in pairs(Save.equip) do
                    e.LoadDate({id=ID, type='item'})
                end

                C_Timer.After(2.3, function()
                    if UnitAffectingCombat('player') then
                        panel.combat= true
                    else
                        Init()--初始
                    end
                end)
            else
                panel:UnregisterAllEvents()
                panel:SetShown(false)
            end

        elseif arg1=='Blizzard_Collections' then
            --hooksecurefunc('ToyBox_ShowToyDropdown', setToyBox_ShowToyDropdown)
            hooksecurefunc('ToySpellButton_UpdateButton', setToySpellButton_UpdateButton)
        end

    elseif event == "PLAYER_LOGOUT" then
        if not e.ClearAllSave then

            WoWToolsSave[addName..'Tools']=Save
        end

    elseif event=='PLAYER_REGEN_ENABLED' then
        if panel.combat then
            panel.combat=nil
            Init()--初始
        end
        panel:UnregisterEvent("PLAYER_REGEN_ENABLED")
    end
end)
