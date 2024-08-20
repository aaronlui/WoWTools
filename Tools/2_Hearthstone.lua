local id, e = ...
local addName= format(CLUB_FINDER_LOOKING_FOR_CLASS_SPEC, SLASH_RANDOM3:gsub('/',''), TUTORIAL_TITLE31)

local P_Items={
    [142542]=true,--城镇传送之书
    [162973]=true,--冬天爷爷的炉石
    [163045]=true,--无头骑士的炉石
    [165669]=true,--春节长者的炉石
    [165670]=true,--小匹德菲特的可爱炉石
    [165802]=true,--复活节的炉石
    [166746]=true,--吞火者的炉石
    [166747]=true,--美酒节狂欢者的炉石
    [168907]=true,--全息数字化炉石
    [172179]=true,--永恒旅者的炉石
    [188952]=true,--被统御的炉石
    [190196]=true,--开悟者炉石
    [190237]=true,--掮灵传送矩阵
    [193588]=true,--时光旅行者的炉石
    [200630]=true,--欧恩伊尔轻风贤者的炉石, 找不到数据
    [209035]=true,--烈焰炉石
    [212337]=true,--炉之石
    [210455]=true,--德莱尼全息宝石
    [93672]=true,--黑暗之门
    [206195]=true,--纳鲁之路
    [208704]=true,--幽邃住民的土灵炉石
}
local ModifiedTab={
    [6948]='Shift',--炉石
    [110560]='Ctrl',--要塞炉石
    [140192]='Alt',--达拉然炉石
}

for itemID in pairs(ModifiedTab) do
    e.LoadDate({id=itemID, type='item'})
end

for itemID, _ in pairs(P_Items) do
    e.LoadDate({id=itemID, type='item'})
end


local Save={
    items=P_Items,
    showBindNameShort=true,
    showBindName=true,
}

local ToyButton--ToyButton.items={}--存放有效
local panel= CreateFrame("Frame")
















--[[
local function getToy()--生成, 有效表格
    ToyButton.items={}
    local find
    for itemID ,_ in pairs(Save.items) do
        if PlayerHasToy(itemID) then
            find=true
            table.insert(ToyButton.items, itemID)
        end
    end
    if not find and C_Item.GetItemCount(6948)~=0 then
        ToyButton.items={6948}
    end
end







local function setAtt()--设置属性
    --if UnitAffectingCombat('player') then
    if not ToyButton:CanChangeAttribute()  then
        panel:RegisterEvent('PLAYER_REGEN_ENABLED')
        return
    end


    local icon
    local num=#ToyButton.items
    if num>0 then
        local index=math.random(1, num)
        local itemID=ToyButton.items[index]
        if itemID then
            ToyButton.texture:SetTexture(C_Item.GetItemIconByID(itemID) or 134414)
            ToyButton:SetAttribute('item1', C_Item.GetItemNameByID(itemID) or itemID)
            ToyButton.itemID=itemID
        end
    else
        ToyButton:SetAttribute('item1', nil)
        ToyButton.itemID=nil
    end
    ToyButton.texture:SetShown(icon)
end


]]


























local function set_BindLocation()--显示, 炉石, 绑定位置
    local text
    if Save.showBindName then
        text= e.cn(GetBindLocation())
        if text and Save.showBindNameShort then
            text= e.WA_Utf8Sub(text, 2, 5)
        end
    end
    if not ToyButton.showBindNameText and text then
        ToyButton.showBindNameText=e.Cstr(ToyButton, {size=10, color=true, justifyH='CENTER'})--10, nil, nil, true, nil, 'CENTER')
        ToyButton.showBindNameText:SetPoint('TOP', ToyButton, 'BOTTOM',0,5)
    end
    if ToyButton.showBindNameText then
        ToyButton.showBindNameText:SetText(text or '')
    end
end



















local function Set_Menu_Tooltip(tooltip, desc)
    WoWTools_ToolsButtonMixin:SetToyTooltip(tooltip, desc.data and desc.data.itemID)
end



local function set_ToggleCollectionsJournal(data)
    WoWTools_ToolsButtonMixin:LoadedCollectionsJournal(3)
    if data.name or data.itemID then
        local name= data.name or select(2, C_ToyBox.GetToyInfo(data.itemID)) or C_Item.GetItemNameByID(data.itemID)
        if name then
            C_ToyBoxInfo.SetDefaultFilters()
            if ToyBox.searchBox then
                ToyBox.searchBox:SetText(name)
            end
        end
    end
    return MenuResponse.Open
end







local function Init_Menu_Toy(self, root)
    local sub, sub2, name
    local index=0
    for itemID, _ in pairs(Save.items) do
        e.LoadDate({id=itemID, type='item'})

        local _, toyName, icon = C_ToyBox.GetToyInfo(itemID)
        index= index+ 1

        name=e.cn(toyName, {itemID=itemID, isName=true})
        if name then
            name=name:match('|c........(.-)|r') or name
        else
            name='itemID '.. itemID
        end

        sub=root:CreateCheckbox(
            (PlayerHasToy(itemID) and '' or '|cff9e9e9e')
            ..index..') |T'..(icon or 0)..':0|t'
            ..name,
            function(data) return PlayerHasToy(data.itemID) end,
            set_ToggleCollectionsJournal,
            {itemID=itemID, name=toyName}
        )
        sub:SetTooltip(Set_Menu_Tooltip)


        sub2=sub:CreateButton(
            '|A:common-icon-zoomin:0:0|a'..(e.onlyChinese and '设置' or SETTINGS),
            set_ToggleCollectionsJournal,
            {itemID=itemID, name=toyName}
        )
        sub2:SetTooltip(function(tooltip)
            tooltip:AddLine(MicroButtonTooltipText(e.onlyChinese and '战团藏品' or COLLECTIONS, "TOGGLECOLLECTIONS"))
        end)

        sub:CreateDivider()
        sub2=sub:CreateButton(
            '|A:common-icon-redx:0:0|a'..(e.onlyChinese and '移除' or REMOVE),
            function(data)
                Save.items[data.itemID]=nil
                print(id, addName, select(2, C_Item.GetItemInfo(data.itemID)) or data.itemID, e.onlyChinese and '移除' or REMOVE)
                ToyButton:init_toy()
                return MenuResponse.Open
            end,
            {itemID=itemID, name=toyName}
        )
        sub2:SetTooltip(Set_Menu_Tooltip)
    end

    if index>35 then
        root:SetGridMode(MenuConstants.VerticalGridDirection, math.ceil(index/35))
    end

--全部清除
    if index>1 then
        root:CreateDivider()
        sub=root:CreateButton(e.onlyChinese and '全部清除' or CLEAR_ALL, function()
            if IsControlKeyDown() then
                Save.items={}
                print(id, addName, e.onlyChinese and '全部清除' or CLEAR_ALL)
                ToyButton:init_toy()
            else
                return MenuResponse.Open
            end
        end)
        sub:SetTooltip(function(tooltip)
            tooltip:AddLine('|cnGREEN_FONT_COLOR:Ctrl+'..e.Icon.left)
        end)
    end

--还原
    local all= 0
    for _ in pairs(P_Items) do
        all=all+1
    end
    sub=root:CreateButton((e.onlyChinese and '还原' or TRANSMOGRIFY_TOOLTIP_REVERT)..' '..all, function()
        if IsControlKeyDown() then
            Save.items= P_Items
            ToyButton:init_toy()
            print(id, addName, '|cnGREEN_FONT_COLOR:', e.onlyChinese and '还原' or TRANSMOGRIFY_TOOLTIP_REVERT)
        else
            return MenuResponse.Open
        end
    end)
    sub:SetTooltip(function(tooltip)
        tooltip:AddLine('|cnGREEN_FONT_COLOR:Ctrl+'..e.Icon.left)
    end)
end










--#####
--主菜单
--#####
local function Init_Menu(self, root)
    local sub
    sub= root:CreateButton(addName..' '..#ToyButton.items, function()
        return MenuResponse.Open
    end)

    Init_Menu_Toy(self, sub)

    --选项
    root:CreateDivider()
    sub=WoWTools_ToolsButtonMixin:OpenMenu(root)

    sub:CreateCheckbox(e.onlyChinese and '绑定位置' or SPELL_TARGET_CENTER_LOC, function()
        return Save.showBindName
    end, function()
        Save.showBindName= not Save.showBindName and true or nil
        self:set_location()--显示, 炉石, 绑定位置
    end)

    sub:CreateCheckbox(e.onlyChinese and '截取名称' or format(CLUB_FINDER_LOOKING_FOR_CLASS_SPEC, SHORT, NAME), function()
        return Save.showBindNameShort
    end, function()
        Save.showBindNameShort= not Save.showBindNameShort and true or nil
        self:set_location()--显示, 炉石, 绑定位置
    end)

    sub=root:CreateButton(
        '|A:common-icon-zoomin:0:0|a'..(e.onlyChinese and '设置' or SETTINGS),
        set_ToggleCollectionsJournal,
        {}
    )
    sub:SetTooltip(function(tooltip)
        tooltip:AddLine(MicroButtonTooltipText(e.onlyChinese and '战团藏品' or COLLECTIONS, "TOGGLECOLLECTIONS"))
    end)

end








































--#############
--玩具界面, 按钮
--#############
local function setToySpellButton_UpdateButton(btn)--标记, 是否已选取
    if not btn.hearthstone then
        btn.hearthstone= e.Cbtn(btn,{size={16,16}, texture=134414})
        btn.hearthstone:SetPoint('TOPLEFT',btn.name,'BOTTOMLEFT')

        function btn.hearthstone:get_itemID()
            return self:GetParent().itemID
        end
        function btn.hearthstone:set_alpha()
            self:SetAlpha(Save.items[self:get_itemID()] and 1 or 0.1)
        end
        function btn.hearthstone:set_tooltips()
            e.tips:SetOwner(self, "ANCHOR_LEFT")
            e.tips:ClearLines()
            e.tips:AddDoubleLine(id, addName)
            --e.tips:AddLine(e.onlyChinese and '需要重新加载' or REQUIRES_RELOAD)
            e.tips:AddLine(' ')
            local itemID=self:get_itemID()
            local icon= C_Item.GetItemIconByID(itemID)
            e.tips:AddDoubleLine(
                (icon and '|T'..icon..':0|t' or '')..(itemID and C_ToyBox.GetToyLink(itemID) or itemID),
                e.GetEnabeleDisable(Save.items[itemID])..e.Icon.left
            )
            e.tips:AddDoubleLine(e.onlyChinese and '菜单' or SLASH_TEXTTOSPEECH_MENU, e.Icon.right)
            e.tips:Show()
            self:SetAlpha(1)
        end
        btn.hearthstone:SetScript('OnMouseDown', function(self, d)
            if d=='LeftButton' then
                local itemID=self:get_itemID()
                Save.items[itemID]= not Save.items[itemID] and true or nil
                ToyButton:set_run()
                self:set_tooltips()
                self:set_alpha()
            else
                MenuUtil.CreateContextMenu(self, Init_Menu_Toy)
            end
        end)
        btn.hearthstone:SetScript('OnLeave', function(self) e.tips:Hide() self:set_alpha() end)
        btn.hearthstone:SetScript('OnEnter', btn.hearthstone.set_tooltips)
    end
    btn.hearthstone:set_alpha()
end






















--###
--初始
--###
local function Init()
    for itemID, _ in pairs(Save.items) do
        e.LoadDate({id=itemID, type='item'})
    end

    ToyButton:SetAttribute("type1", "item")
    ToyButton:SetAttribute("alt-type1", "item")
    ToyButton:SetAttribute("shift-type1", "item")
    ToyButton:SetAttribute("ctrl-type1", "item")

    ToyButton.alt= ToyButton:CreateTexture(nil,'OVERLAY')--达拉然炉石
    ToyButton.alt:SetSize(10, 10)
    ToyButton.alt:SetPoint('BOTTOMRIGHT',-3,3)
    ToyButton.alt:SetDrawLayer('OVERLAY',2)
    ToyButton.alt:AddMaskTexture(ToyButton.mask)
    ToyButton.alt:SetTexture(1444943)

    ToyButton.ctrl= ToyButton:CreateTexture(nil,'OVERLAY')--要塞炉石
    ToyButton.ctrl:SetSize(10, 10)
    ToyButton.ctrl:SetPoint('BOTTOMLEFT',2,2)
    ToyButton.ctrl:SetDrawLayer('OVERLAY',2)
    ToyButton.ctrl:AddMaskTexture(ToyButton.mask)
    ToyButton.ctrl:SetTexture(1041860)

    ToyButton.shift= ToyButton:CreateTexture(nil,'OVERLAY')--炉石
    ToyButton.shift:SetSize(10, 10)
    ToyButton.shift:SetPoint('TOPLEFT',2,-2)
    ToyButton.shift:SetDrawLayer('OVERLAY',2)
    ToyButton.shift:AddMaskTexture(ToyButton.mask)
    ToyButton.shift:SetTexture(134414)

    ToyButton.text=e.Cstr(ToyButton, {size=10, color=true, justifyH='CENTER'})--10, nil, nil, true, nil, 'CENTER')
    ToyButton.text:SetPoint('TOP', ToyButton, 'BOTTOM',0,5)


    function ToyButton:set_alt()
        self.isAltEvent=nil
        if not self:CanChangeAttribute() then
            self.isAltEvent=true
            self:RegisterEvent('PLAYER_REGEN_ENABLED')
            return
        end
        for itemID, type in pairs(ModifiedTab) do
            local name= C_Item.GetItemNameByID(itemID) or select(2,  C_ToyBox.GetToyInfo(itemID))
            if name then
                self:SetAttribute(type.."-item1",  name)
            else
                self.isAltEvent=true
            end
        end
        if self.isAltEvent then
            self:RegisterEvent('ITEM_DATA_LOAD_RESULT')
        end
    end



    function ToyButton:set_attribute(itemID)
        if not itemID then
            return
        end
        self.isRunEvent=nil
        if not self:CanChangeAttribute() then
            self.isRunEvent=true
            self:RegisterEvent('PLAYER_REGEN_ENABLED')
            return
        end
        local name=C_Item.GetItemNameByID(itemID) or select(2,  C_ToyBox.GetToyInfo(itemID))
        if not name then
            self.isRunEvent=true
            self:RegisterEvent('ITEM_DATA_LOAD_RESULT')
            return
        end
        self.itemID=itemID
        self:SetAttribute('item1', name)
        self.texture:SetTexture(C_Item.GetItemIconByID(itemID) or 134414)
    end

    function ToyButton:set_only_item()
        self:set_attribute(self.items[1] or 6948)
        self.items={}
    end

    function ToyButton:get_toys()
        self.items={}
        self.onlyItem=nil
        for itemID ,_ in pairs(Save.items) do
            if PlayerHasToy(itemID) then
                table.insert(self.items, itemID)
            end
        end
        local num= #self.items
        if num<=1 then
            self:set_only_item()
            self.onlyItem=true
        end
        return num
    end

    function ToyButton:set_run()
        if self.onlyItem then
            return
        end
        self.isRunEvent=nil
        if not self:CanChangeAttribute()  then
            self.isRunEvent=true
            self:RegisterEvent('PLAYER_REGEN_ENABLED')
            return
        end
        local num= #self.items
        do
            if num==0 then
                num=self:get_toys()
            end
        end
        if num>0 then
            local index=math.random(1, num)
            self:set_attribute(self.items[index])
            table.remove(self.items, index)
        end
    end

    function ToyButton:init_toy()
        self:get_toys()
        self:set_run()
    end

    function ToyButton:get_location()
        return e.cn(GetBindLocation())
    end

    function ToyButton:set_location()--显示, 炉石, 绑定位置
        local text
        if Save.showBindName then
            text= self:get_location()
            if text and Save.showBindNameShort then
                text= e.WA_Utf8Sub(text, 2, 5)
            end
        end
        self.text:SetText(text or '')
    end


    ToyButton:RegisterEvent('HEARTHSTONE_BOUND')
    ToyButton:RegisterEvent('BAG_UPDATE_COOLDOWN')
    ToyButton:RegisterEvent('TOYS_UPDATED')
    ToyButton:RegisterEvent('NEW_TOY_ADDED')

    ToyButton:SetScript('OnEvent', function(self, event, itemID, success)
        if event=='ITEM_DATA_LOAD_RESULT' then
            if success then
                if ModifiedTab[itemID] then
                    self:set_alt()
                elseif Save.items[itemID] then
                    if self.onlyItem then
                        self:set_only_item()
                    else
                        self:set_run()
                    end
                end
                if not self.isAltEvent and not self.isRunEvent then
                    self:UnregisterEvent('ITEM_DATA_LOAD_RESULT')
                end
            end

        elseif event=='PLAYER_REGEN_ENABLED' then
            if self.isAltEvent then
                self:set_alt()
            end
            if self.isRunEvent then
                if self.onlyItem then
                    self:set_only_item()
                else
                    self:set_run()
                end
            end
            if not self.isAltEvent and not self.isRunEvent then
                self:UnregisterEvent('PLAYER_REGEN_ENABLED')
            end

        elseif event=='TOYS_UPDATED' or event=='NEW_TOY_ADDED' then
            self:init_toy()

        elseif event=='HEARTHSTONE_BOUND' then
            self:set_location()

        elseif event=='BAG_UPDATE_COOLDOWN' then
            e.SetItemSpellCool(self, {item=self.itemID})--主图标冷却
        end
    end)




    function ToyButton:set_tooltips()
        e.tips:SetOwner(self, "ANCHOR_LEFT")
        e.tips:ClearLines()
        if self.itemID then
            WoWTools_ToolsButtonMixin:SetToyTooltip(e.tips, self.itemID)
        else
            e.tips:AddLine(id, addName)
            e.tips:AddLine(' ')
        end

        local name, col
        for itemID, type in pairs(ModifiedTab) do
            name= e.cn(C_Item.GetItemNameByID(itemID), {itemID=itemID, isName=true})
            if name then
                name= name:match('|c........(.-)|r') or name
            else
                name='itemID: '..itemID
            end
            col=(PlayerHasToy(itemID) or C_Item.GetItemCount(itemID)>0) and '' or '|cff9e9e9e'

            e.tips:AddDoubleLine(
                col
                ..'|T'..(C_Item.GetItemIconByID(itemID) or 0)..':0|t'
                ..name
                ..(e.GetSpellItemCooldown(nil, itemID) or ''),
                col..type..'+'..e.Icon.left
            )
        end

        e.tips:AddLine(' ')
        e.tips:AddDoubleLine(e.onlyChinese and '菜单' or SLASH_TEXTTOSPEECH_MENU, e.Icon.right)
        e.tips:Show()
        if e.tips.textLeft then
            e.tips.textLeft:SetText(self:get_location() or '')
        end
    end


    ToyButton:SetScript("OnEnter",function(self)
        self:set_tooltips()
        self:SetScript('OnUpdate', function (s, elapsed)
            s.elapsed = (s.elapsed or 0.3) + elapsed
            if s.elapsed > 0.3 and s.itemID then
                s.elapsed = 0
                if GameTooltip:IsOwned(s) and select(3, GameTooltip:GetItem())~=s.itemID then
                    s:set_tooltips()
                end
            end
        end)
    end)

    ToyButton:SetScript("OnLeave",function(self)
        e.tips:Hide()
        self:SetScript('OnUpdate',nil)
        self.elapsed=nil
        self:set_run()
    end)

    ToyButton:SetScript("OnMouseDown", function(self,d)
        if d=='RightButton' and not IsModifierKeyDown() then
            MenuUtil.CreateContextMenu(self, Init_Menu)
        end
    end)

    ToyButton:SetScript("OnMouseUp", function(self, d)
        self:set_run()
    end)
    ToyButton:SetScript('OnMouseWheel', ToyButton.set_run)--设置属性



    ToyButton:init_toy()
    ToyButton:set_alt()
    ToyButton:set_location()

    C_Timer.After(2, function()
        --getToy()--生成, 有效表格
        --setAtt()--设置属性
        e.SetItemSpellCool(ToyButton, {item=ToyButton.itemID})--主图标冷却
    end)
end


























--###########
--加载保存数据
--###########
panel:RegisterEvent("ADDON_LOADED")
panel:RegisterEvent("PLAYER_LOGOUT")
panel:SetScript("OnEvent", function(self, event, arg1)
    if event == "ADDON_LOADED" then
        if arg1== id then
            --旧版本
            if WoWToolsSave[format(CLUB_FINDER_LOOKING_FOR_CLASS_SPEC, SLASH_RANDOM3:gsub('/',''), TUTORIAL_TITLE31)] then
                Save= WoWToolsSave[format(CLUB_FINDER_LOOKING_FOR_CLASS_SPEC, SLASH_RANDOM3:gsub('/',''), TUTORIAL_TITLE31)]
                WoWToolsSave[format(CLUB_FINDER_LOOKING_FOR_CLASS_SPEC, SLASH_RANDOM3:gsub('/',''), TUTORIAL_TITLE31)]=nil
            else
                Save= WoWToolsSave['Tools_Hearthstone'] or Save
            end
            addName='|T134414:0|t'..(e.onlyChinese and '炉石' or TUTORIAL_TITLE31)

            ToyButton= WoWTools_ToolsButtonMixin:CreateButton({
                name='Hearthstone',
                tooltip=addName,
                setParent=false,
                point='BOTTOM'
            })

            if ToyButton then
                Init()--初始
            else
                self:UnregisterEvent('ADDON_LOADED')
            end

        elseif arg1=='Blizzard_Collections' then
            hooksecurefunc('ToySpellButton_UpdateButton', setToySpellButton_UpdateButton)
        end

    elseif event == "PLAYER_LOGOUT" then
        if not e.ClearAllSave then
            WoWToolsSave['Tools_Hearthstone']=Save
        end
    end
end)