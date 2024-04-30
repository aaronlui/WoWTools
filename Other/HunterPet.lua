local id, e= ...
if e.Player.class~='HUNTER' then --or C_AddOns.IsAddOnLoaded("ImprovedStableFrame") then
    return
end
--PetStableFrame, C_AddOns.IsAddOnLoaded("ImprovedStableFrame")
--PetStable.lua
local addName= format(CLUB_FINDER_LOOKING_FOR_CLASS_SPEC,  UnitClass('player'), DUNGEON_FLOOR_ORGRIMMARRAID8) --猎人兽栏
local Save={
    --hideIndex=true,--隐藏索引
    --hideTalent=true,--隐藏天赋
   -- modelScale=0.65,
    --sortIndex=4,--1, 2,3,4,5 icon, name, level, family, talent排序
    --line=15,

    --10.2.7
    --show_All_List=true,显示，所有宠物，图标列表
    --sortDown= true,--排序, 降序
    --all_List_Size==28--图标表表，图标大小
}
local Initializer








local ISF_SearchInput--查询
local maxSlots
local NUM_PER_ROW= 15--行数
local IsInSearch--排序用
local function Get_Food_Text(slotPet)
    if slotPet then
        return BuildListString(GetStablePetFoodTypes(slotPet))
    end
end
local function Set_Food_Lable()--食物
    PetStablePetInfo.foodLable:SetText(Get_Food_Text(PetStableFrame.selectedPet) or '')
end
local function set_PetStable_Update()--查询
    if IsInSearch then
        return
    end
    local input = ISF_SearchInput:GetText()
    local all= maxSlots + NUM_PET_ACTIVE_SLOTS
    local num=0
    local btn
    local isSearch= input and input:trim()~= ""

    for i = 1, all do
        local icon, name, _, family, talent = GetStablePetInfo(i);
        if i<=NUM_PET_ACTIVE_SLOTS then
            btn= _G['PetStableActivePet'..i]
        else
            btn= _G["PetStableStabledPet"..i- NUM_PET_ACTIVE_SLOTS]
        end
        if btn and btn.dimOverlay then
            local show= isSearch
            if icon then
                if isSearch then
                    local food = BuildListString(GetStablePetFoodTypes(i)) or ''
                    local matched, expected = 0, 0
                    for str in input:gmatch("([^%s]+)") do
                        expected = expected + 1
                        str = str:trim():lower()
                        if name:lower():find(str)
                            or family:lower():find(str)
                            or talent:lower():find(str)
                            or food:lower():find(str)
                           -- or level:lower():find(str)
                        then
                            matched = matched + 1
                        end
                    end
                    if matched == expected then
                    show= false
                        num= num +1
                    end
                else
                    num= num +1
                end
            end

            btn.dimOverlay:SetShown(show)
        end
    end
    ISF_SearchInput.text:SetFormattedText(isSearch and (e.onlyChinese and '搜索' or SEARCH)..' |cnGREEN_FONT_COLOR:%d|r /%d' or (e.onlyChinese and '已收集（%d/%d）' or ITEM_PET_KNOWN), num, all)
end

























local function Set_Slot_Info(btn, index, isActiveSlot)--创建，提示内容
    if not isActiveSlot then
        function btn:set_slot_index()
            if not Save.hideIndex and not self.slotIndexText then
                self.slotIndexText= e.Cstr(self, {layer='BACKGROUND', color={r=1,g=1,b=1,a=0.2}})--栏位
                self.slotIndexText:SetPoint('CENTER')
            end
            if self.slotIndexText then
                self.slotIndexText:SetText(not Save.hideIndex and index or '')
            end
        end
        btn:set_slot_index()
    else
        local CALL_PET_SPELL_IDS = {0883, 83242, 83243, 83244, 83245}--召唤，宠物，法术
        btn.spellTexture= btn:CreateTexture()
        btn.spellTexture:SetSize(28,28)
        btn.spellTexture:SetPoint('RIGHT', btn, 'LEFT', -2,0)
        btn.spellTexture:SetAtlas('services-number-'..index)
        e.Set_Label_Texture_Color(btn.spellTexture, {type='Texture', alpha=0.3})
        if CALL_PET_SPELL_IDS[index] then--召唤，宠物，法术
            btn.spellTexture.spellID= CALL_PET_SPELL_IDS[index]
            btn.spellTexture:SetScript('OnLeave', function(self) e.tips:Hide() self:SetAlpha(0.3) end)
            btn.spellTexture:SetScript('OnEnter', function(self)
                e.tips:SetOwner(self, "ANCHOR_LEFT")
                e.tips:ClearLines()
                e.tips:SetSpellByID(self.spellID)
                e.tips:AddLine(' ')
                e.tips:AddDoubleLine(id, Initializer:GetName())
                e.tips:Show()
                self:SetAlpha(1)
            end)
        end
        btn.spellTexture:SetShown(not Save.hideIndex)
        function btn:set_slot_index()
            self.spellTexture:SetShown(not Save.hideIndex)
        end

         --已激活宠物，提示
         local modelH= (PetStableLeftInset:GetHeight()-28)/NUM_PET_ACTIVE_SLOTS
         btn.model= CreateFrame("PlayerModel", nil, PetStableFrame)
         btn.model:SetSize(modelH, modelH)
         btn.model:SetFacing(0.3)
         if index==1 then
             btn.model:SetPoint('TOPRIGHT', PetStableLeftInset, 'TOPLEFT', -16,-28)
         else
             btn.model:SetPoint('TOP', _G['PetStableActivePet'..index-1].model, 'BOTTOM')
         end

         local bg=btn.model:CreateTexture('BACKGROUND')
         bg:SetPoint('LEFT')
         bg:SetSize(modelH+14, modelH)
         bg:SetAtlas('ShipMission_RewardsBG-Desaturate')
         e.Set_Label_Texture_Color(bg, {type='Texture', alpha=0.3})
         function btn:set_model_info(petSlot)
            local creatureDisplayID = C_PlayerInfo.GetPetStableCreatureDisplayInfoID(petSlot);
            if creatureDisplayID and creatureDisplayID>0 then
                if creatureDisplayID~=btn.creatureDisplayID then
                    btn.model:SetDisplayInfo(creatureDisplayID)
                end
            else
                btn.model:ClearModel()
            end
            btn.creatureDisplayID= creatureDisplayID--提示用，
         end

         btn:ClearAllPoints()
         btn:SetPoint('LEFT', btn.model, 'RIGHT', 43,0)

         if btn.PetName then
            btn.PetName:ClearAllPoints()
            btn.PetName:SetPoint('BOTTOM', btn.Border, 0,-10)
            e.Set_Label_Texture_Color(btn.PetName, {type='FontString'})
            btn.PetName:SetShadowOffset(1, -1)
            btn.PetName:SetJustifyH('LEFT')
            btn.PetName:SetScale(0.85)
         end
    end

    btn:HookScript('OnEnter', function(self)--GameTooltip 提示用 tooltips.lua
        local petIcon, _, petLevel= GetStablePetInfo(self.petSlot)
        if petIcon then
            local food= Get_Food_Text(self.petSlot)
            if food then
                e.tips:AddLine(format(e.onlyChinese and '|cffffd200食物：|r%s' or PET_DIET_TEMPLATE, food, 1, 1, 1, true))
            end
            if petLevel then
                e.tips:AddDoubleLine((e.onlyChinese and '等级' or LEVEL)..': '..petLevel, petIcon and '|T'..petIcon..':0|t'..petIcon)
            end
            e.tips:AddDoubleLine('petSlot:', self.petSlot)
            local creatureDisplayID = C_PlayerInfo.GetPetStableCreatureDisplayInfoID(self.petSlot);
            if creatureDisplayID and creatureDisplayID>0 and e.tips.playerModel then
                e.tips.playerModel:SetDisplayInfo(creatureDisplayID)
                e.tips.playerModel:SetShown(true)
            end
            e.tips:AddDoubleLine('creatureDisplayID:', creatureDisplayID)
            e.tips:AddLine(' ')
            e.tips:AddDoubleLine(id, Initializer:GetName())
            e.tips:Show()
        end
    end)

    function btn:set_settings()
        if not Save.hideTalent then
            if not self.talentText then
                self.talentText= e.Cstr(btn, {layer='ARTWORK', color=true})--天赋
                self.talentText:SetPoint('BOTTOM')
            end
            local talent= self.petSlot and select(5, GetStablePetInfo(self.petSlot))
            self.talentText:SetText(talent and e.WA_Utf8Sub(talent, 2, 5, true) or '')
        elseif self.talentText then
            self.talentText:SetText('')
        end
        local creatureDisplayID = C_PlayerInfo.GetPetStableCreatureDisplayInfoID(self.petSlot);
        if self.model then--已激活宠物，提示
            if creatureDisplayID and creatureDisplayID>0 then
                if creatureDisplayID~=self.creatureDisplayID then
                    self.model:SetDisplayInfo(creatureDisplayID)
                end
            else
                self.model:ClearModel()
            end
            self.creatureDisplayID= creatureDisplayID--提示用，
        end
        if creatureDisplayID then
            SetPortraitTextureFromCreatureDisplayID(self.icon2, creatureDisplayID)
        end
        self.icon2:SetShown(creatureDisplayID and creatureDisplayID>0 and true or false)
    end

    btn.dimOverlay = btn.dimOverlay or btn:CreateTexture(nil, "OVERLAY");--查询提示用
    btn.dimOverlay:SetColorTexture(0, 0, 0, 0.8);
    btn.dimOverlay:SetAllPoints();
    btn.dimOverlay:Hide();


    btn.icon2=btn:CreateTexture(nil, 'BORDER',nil, 1)
    btn.icon2:SetAllPoints(btn)
    btn.icon2:SetTexCoord(1,0,0,1)

    local icon= _G[btn:GetName()..'IconTexture']
    if icon then
        icon:ClearAllPoints()
        icon:SetShown(false)
    end

    btn.Checked:SetAtlas('bag-border')
    local w,h= btn:GetSize()
    btn.Checked:ClearAllPoints()
    btn.Checked:SetPoint('CENTER',3,-2)
    btn.Checked:SetSize(w+18, h+18)
        --[[local w,h= btn:GetSize()
        btn.Checked:ClearAllPoints()
        btn.Checked:SetPoint('CENTER')
        btn.Checked:SetSize(w+10, h+10)
        btn.Checked:SetVertexColor(0,1,0)]]
    

    --btn.Background:SetAtlas('bag-border-search')
    --btn.Background:ClearAllPoints()
    --btn.Background:SetPoint('CENTER', btn)
    --btn.Background:SetSize(w/2,w/2)
    e.Set_Label_Texture_Color(btn.Background, {type='Texture', alpha=0.1})--设置颜色


    btn:RegisterForDrag('LeftButton', "RightButton")
    btn:RegisterForClicks(e.LeftButtonDown, e.RightButtonDown)
end

local function Init()
    maxSlots = NUM_PET_STABLE_PAGES * NUM_PET_STABLE_SLOTS

    local w, h= 720, 620--get_Frame_Size()--720, 630

    NUM_PET_STABLE_SLOTS = maxSlots
    NUM_PET_STABLE_PAGES = 1
    PetStableFrame.page = 1
    PetStableFrame:SetSize(w, h)--设置，大小

    PetStableNextPageButton:Hide()--隐藏
    PetStablePrevPageButton:Hide()
    PetStableBottomInset:Hide()

    PetStableStabledPet1:ClearAllPoints()--设置，200个按钮，第一个位置
    PetStableStabledPet1:SetPoint("TOPLEFT", PetStableFrame, 97, -37)

    local layer= PetStableFrame:GetFrameLevel()+ 1
    for i = 1, maxSlots do
        local btn= _G["PetStableStabledPet"..i] or CreateFrame("Button", "PetStableStabledPet"..i, PetStableFrame, "PetStableSlotTemplate", i)
        btn.petSlot= btn.petSlot or (NUM_PET_ACTIVE_SLOTS+i)
        btn:SetFrameLevel(layer)
        Set_Slot_Info(btn, i, nil)--创建，提示内容

       
        if i > 1 then--设置位置
            btn:ClearAllPoints()
            btn:SetPoint("LEFT", _G["PetStableStabledPet"..i-1], "RIGHT", 4, 0)
        end
    end

    for i = NUM_PER_ROW+1, maxSlots, NUM_PER_ROW do--换行
        _G["PetStableStabledPet"..i]:ClearAllPoints()
        _G["PetStableStabledPet"..i]:SetPoint("TOPLEFT", _G["PetStableStabledPet"..i-NUM_PER_ROW], "BOTTOMLEFT", 0, -4)
    end


    --已激活宠物
    for i= 1, NUM_PET_ACTIVE_SLOTS do
        local btn= _G['PetStableActivePet'..i]
        if btn then
            btn.petSlot= btn.petSlot or i
            Set_Slot_Info(btn, i, true)--创建，提示内容
        end
    end

    --查询
    ISF_SearchInput = _G['ISF_SearchInput'] or CreateFrame("EditBox", nil, PetStableStabledPet1, "SearchBoxTemplate")
    ISF_SearchInput.Middle:SetAlpha(0.5)
    ISF_SearchInput.Right:SetAlpha(0.5)
    ISF_SearchInput.Left:SetAlpha(0.5)
    ISF_SearchInput:SetSize(200,20)
    if  _G['ISF_SearchInput'] then ISF_SearchInput:ClearAllPoints() end--处理插件，Improved Stable Frame
    ISF_SearchInput:SetPoint('BOTTOMRIGHT',PetStableFrame, -6, 10)
    ISF_SearchInput:SetScale(1.2)
    ISF_SearchInput.Instructions:SetText(e.onlyChinese and '名称,类型,天赋,食物' or (NAME .. "," .. TYPE .. "," .. TALENT..','..POWER_TYPE_FOOD))
    ISF_SearchInput:SetTextColor(e.Player.r, e.Player.g, e.Player.b)
    ISF_SearchInput:HookScript("OnTextChanged", set_PetStable_Update)
    hooksecurefunc("PetStable_Update", set_PetStable_Update)
    ISF_SearchInput.text= e.Cstr(ISF_SearchInput, {color=true, alpha=0.5})
    ISF_SearchInput.text:SetPoint('BOTTOM', ISF_SearchInput, 'TOP')






    hooksecurefunc('PetStable_UpdateSlot', function(btn)--宠物，类型，已激MODEL
        if btn.set_settings then
            btn:set_settings()
        end
    end)


    e.Set_Label_Texture_Color(PetStableFrameTitleText, {type='FontString'})--标题, 颜色

    PetStableActiveBg:ClearAllPoints()--已激活宠物，背景，大小
    PetStableActiveBg:SetAllPoints(PetStableLeftInset)
    e.Set_Label_Texture_Color(PetStableActivePetsLabel, {type='FontString'})


    PetStableFrameInset.NineSlice:ClearAllPoints()--标示，背景
    PetStableFrameInset.NineSlice:SetPoint('TOPLEFT')
    PetStableFrameInset.NineSlice:SetPoint('BOTTOMRIGHT', PetStableFrame, -4, 4)
    PetStableFrameInset.Bg:ClearAllPoints()
    PetStableFrameInset.Bg:SetPoint('TOPLEFT')
    PetStableFrameInset.Bg:SetPoint('BOTTOMRIGHT', PetStableFrame, -4, 4)


    PetStableModelScene:ClearAllPoints()--设置，3D，位置
    PetStableModelScene:SetPoint('LEFT', PetStableFrame, 'RIGHT',0, -12)
    PetStableModelScene:SetSize(h-24, h-24)

    PetStableModelScene.zoomModelButton= e.Cbtn(PetStableFrameCloseButton, {size={22,22}, icon=true})--atlas='UI-HUD-Minimap-Zoom-In'})
    PetStableModelScene.zoomModelButton:SetPoint('RIGHT', PetStableFrameCloseButton, 'LEFT', -2,0)
    PetStableModelScene.zoomModelButton:SetAlpha(0.5)
    function PetStableModelScene.zoomModelButton:set_Tooltips()
        e.tips:SetOwner(self, "ANCHOR_LEFT")
        e.tips:ClearLines()
        e.tips:AddDoubleLine(id, Initializer:GetName())
        e.tips:AddLine(' ')
        e.tips:AddDoubleLine((e.onlyChinese and '天赋' or TALENT)..': '..e.GetShowHide(not Save.hideTalent),  e.Icon.left)
        e.tips:AddDoubleLine((e.onlyChinese and '索引' or 'Index')..': '..e.GetShowHide(not Save.hideIndex),  e.Icon.right)
        e.tips:AddDoubleLine((e.onlyChinese and '模型缩放' or format(CLUB_FINDER_LOOKING_FOR_CLASS_SPEC, MODEL, UI_SCALE))..' |cnGREEN_FONT_COLOR:'..(Save.modelScale or 1), e.Icon.mid)
        e.tips:Show()
    end
    function PetStableModelScene.zoomModelButton:set_Scale()
        PetStableModelScene:SetScale(Save.modelScale or 1)
    end
    function PetStableModelScene.zoomModelButton:set_Value_Scale(add)
        local n= Save.modelScale or 1
        n= add and n+0.05 or (n-0.05)
        n= n<0.1 and 0.1 or n
        n= n>2 and 2 or n
        Save.modelScale=n
        self:set_Scale()
        self:set_Tooltips()
    end
    PetStableModelScene.zoomModelButton:SetScript('OnMouseWheel', function(self, d)
        self:set_Value_Scale(d==-1)
    end)
    PetStableModelScene.zoomModelButton:SetScript('OnClick', function(self, d)
        if d=='LeftButton' then--显示/隐藏 天赋
            Save.hideTalent= not Save.hideTalent and true or nil
            for i= 1, maxSlots do
                local btn= _G['PetStableStabledPet'..i]
                if btn then
                    btn:set_settings()
                end
            end
            for i=1, NUM_PET_ACTIVE_SLOTS do
                local btn= _G['PetStableActivePet'..i]
                if btn then
                    btn:set_settings()
                end
            end
        elseif d=='RightButton' then--显示/隐藏 索引
            Save.hideIndex= not Save.hideIndex and true or nil
            for i= 1, maxSlots do
                local btn= _G['PetStableStabledPet'..i]
                if btn then
                    btn:set_slot_index()
                end
            end
            for i=1, NUM_PET_ACTIVE_SLOTS do
                local btn= _G['PetStableActivePet'..i]
                if btn then
                    btn:set_slot_index()
                end
            end
        end
        self:set_Tooltips()
    end)
    PetStableModelScene.zoomModelButton:SetScript('OnLeave', function(self) self:SetAlpha(0.5) e.tips:Hide() end)
    PetStableModelScene.zoomModelButton:SetScript('OnEnter', function(self)
        self:set_Tooltips()
        self:SetAlpha(1)
    end)
    PetStableModelScene.zoomModelButton:set_Scale()


    PetStableFrameModelBg:ClearAllPoints()--3D，背景
    PetStableFrameModelBg:SetAllPoints(PetStableModelScene)
    PetStableFrameModelBg:SetAtlas('ShipMission_RewardsBG-Desaturate')
    PetStableFrameModelBg:SetVertexColor(e.Player.r, e.Player.g, e.Player.b)

    PetStablePetInfo:ClearAllPoints()--宠物，信息
    PetStablePetInfo:SetPoint('BOTTOMLEFT', PetStableFrame, 'BOTTOMRIGHT',0, 4)

    PetStableDiet:ClearAllPoints()--食物，提示
    PetStableDiet:SetSize(PetStableSelectedPetIcon:GetSize())
    PetStableDiet:SetPoint('BOTTOMRIGHT', PetStableSelectedPetIcon,'TOPRIGHT', 0,2)
    PetStableDiet:HookScript('OnLeave', function(self) self:SetAlpha(1) end)
    PetStableDiet:HookScript('OnEnter', function(self) self:SetAlpha(0.5) end)

    PetStablePetInfo.foodLable= e.Cstr(PetStablePetInfo, {color=true})--食物
    PetStablePetInfo.foodLable:SetPoint('LEFT', PetStableDiet, 'Right',0,-2)

    Set_Food_Lable()--食物
    hooksecurefunc('PetStable_UpdatePetModelScene', Set_Food_Lable)--食物

    PetStableNameText:ClearAllPoints()
    PetStableNameText:SetPoint('TOPLEFT', PetStableSelectedPetIcon, 'RIGHT',0, -2)
    e.Set_Label_Texture_Color(PetStableNameText, {type='FontString'})--选定，宠物，名称

    PetStableTypeText:ClearAllPoints()--选定，宠物，类型
    PetStableTypeText:SetPoint('BOTTOMLEFT', PetStableSelectedPetIcon, 'RIGHT', 0,2)
    PetStableTypeText:SetJustifyH('LEFT')
    e.Set_Label_Texture_Color(PetStableTypeText, {type='FontString'})
    PetStableTypeText:SetShadowOffset(1, -1)




    local sortButton= e.Cbtn(ISF_SearchInput, {atlas='bags-button-autosort-up', size={26,26}})
    sortButton:SetPoint('RIGHT', ISF_SearchInput, 'LEFT', -6, 0)
    sortButton:SetAlpha(0.7)
    sortButton:SetScript('OnLeave', function(self)
        GameTooltip_Hide()
        self:SetAlpha(0.7)
    end)
    sortButton:SetScript('OnEnter', function(self)
        e.tips:SetOwner(self, "ANCHOR_LEFT")
        e.tips:ClearLines()
        e.tips:AddDoubleLine(
            e.onlyChinese and '排序图标' or format(CLUB_FINDER_LOOKING_FOR_CLASS_SPEC, HUD_EDIT_MODE_SETTING_UNIT_FRAME_SORT_BY, EMBLEM_SYMBOL),
            e.onlyChinese and '整理！' or POSTMASTER_BEGIN
        )
        e.tips:AddLine(' ')
        e.tips:AddDoubleLine(
            e.Icon.toRight2..(e.onlyChinese and '上' or HUD_EDIT_MODE_SETTING_AURA_FRAME_ICON_WRAP_UP)..e.Icon.left,
            e.Icon.right..(e.onlyChinese and '下' or HUD_EDIT_MODE_SETTING_AURA_FRAME_ICON_WRAP_UP)..e.Icon.toLeft2)
        e.tips:AddLine(' ')
        e.tips:AddDoubleLine(id, Initializer:GetName())
        e.tips:Show()
        self:SetAlpha(1)
    end)

    sortButton:SetScript('OnClick', function(self, d)
        self:SetEnabled(false)
        IsInSearch=true
        local func= PetStable_Update--排序用
        PetStable_Update= function() end
do
        local tab= {}
        for i= NUM_PET_ACTIVE_SLOTS+ 1, maxSlots+ NUM_PET_ACTIVE_SLOTS do
            local icon, name, level, family, talent = GetStablePetInfo(i)
            if icon then
                table.insert(tab, {
                    index= i,
                    icon= icon,
                    name= (string.byte(name, 1) or 0)+ (string.byte(name, 2) or 0)+ (string.byte(name, 3) or 0)+ (string.byte(name, 4) or 0),
                    level= level or 0,
                    family= (string.byte(family, 1) or 0)+ (string.byte(family, 2) or 0)+ (string.byte(family, 3) or 0)+ (string.byte(family, 4) or 0),
                    talen= (string.byte(talent, 1) or 0)+ (string.byte(talent, 2) or 0)+ (string.byte(talent, 3) or 0)+ (string.byte(talent, 4) or 0),
                })

            end
        end
        local str= Save.sortIndex==1 and 'icon'
                or Save.sortIndex==2 and 'name'
                or Save.sortIndex==3 and 'level'
                or Save.sortIndex==4 and 'family'
                or Save.sortIndex==5 and 'talen'

            table.sort(tab, function(a, b)
                return a[str] < b[str]
            end)


        if d=='LeftButton' then--点击，从前，向后
            for i, newTab in pairs(tab) do
                do
                    local index= i+ NUM_PET_ACTIVE_SLOTS
                    SetPetSlot(newTab.index, index)
                end
            end
        else
            local all= maxSlots+ NUM_PET_ACTIVE_SLOTS
            for i, newTab in pairs(tab) do
                do
                    local index= all-i+1
                    SetPetSlot(newTab.index, index)
                end
            end
        end
end
        PetStable_Update= func
        self.num= self.num and self.num+1 or 1
        print(id, Initializer:GetName(), e.onlyChinese and '完成' or DONE, '|cnGREEN_FONT_COLOR:'..self.num)
        IsInSearch=nil
        e.call('PetStable_Update')
        self:SetEnabled(true)
    end)


    local menu= CreateFrame('Frame', 'SortHunterPetDropDownMenu', sortButton, "UIDropDownMenuTemplate")
    e.LibDD:UIDropDownMenu_SetWidth(menu, 90)
    menu:SetPoint('RIGHT', sortButton, 'LEFT', 15, -2)
    function menu:get_text(index)
        return index==1 and (e.onlyChinese and '图标' or EMBLEM_SYMBOL)--'icon'
                or index==2 and (e.onlyChinese and '名称' or NAME)--'name'
                or index==3 and (e.onlyChinese and '等级' or LEVEL)--'level'
                or index==4 and (e.onlyChinese and '类型' or TYPE)--'family'
                or index==5 and (e.onlyChinese and '天赋' or TALENT)--'talen'
    end
    e.LibDD:UIDropDownMenu_SetText(menu,  menu:get_text(Save.sortIndex))
    e.LibDD:UIDropDownMenu_Initialize(menu, function(self, level)
        for i=1, 5 do
            local info={
                text=self:get_text(i),
                checked= Save.sortIndex==i,
                arg1=i,
                func=function(_, arg1)
                    Save.sortIndex= arg1
                    e.LibDD:UIDropDownMenu_SetText(self,  self:get_text(Save.sortIndex))
                end
            }
            e.LibDD:UIDropDownMenu_AddButton(info, level)
        end
    end)
   menu.Button:SetScript('OnMouseDown', function(self)
        e.LibDD:ToggleDropDownMenu(1, nil, self:GetParent(), self, 15, 0)
    end)

    for _, icon in pairs({menu:GetRegions()}) do
        if icon:GetObjectType()=="Texture" then
            icon:SetAlpha(0.5)
        end
    end
    for _, icon in pairs({menu.Button:GetRegions()}) do
        if icon:GetObjectType()=="Texture" then
            icon:SetAlpha(0.5)
        end
    end

    e.Set_Label_Texture_Color(menu.Text, {type='FontString', alpha=0.5})
    e.call('PetStable_Update')
end















































--取得，宠物，技能，图标
local function get_abilities_icons(pet)
    local icon=''
    for _, spellID in pairs(pet and pet.abilities or {}) do
        e.LoadDate({id=spellID, type='spell'})
        icon= icon..format('|T%d:14|t', GetSpellTexture(spellID) or 0)
    end
    return icon
end



--宠物，信息，提示
local function set_pet_tooltips(frame, pet, y)
    if not pet or not frame then
        return
    end
    e.tips:SetOwner(frame, "ANCHOR_LEFT", y or 0, 0)
    e.tips:ClearLines()
    e.tips:AddDoubleLine(id, Initializer:GetName())
    e.tips:AddLine(' ')
    local i=1
    for indexType, name in pairs(pet) do
        local col= indexType=='slotID' and '|cffff00ff'
                or (indexType=='name' and '|cnGREEN_FONT_COLOR:')
                or (select(2, math.modf(i/2))==0 and '|cffffffff')
                or '|cff00ccff'
        if type(name)=='table' then
            if indexType=='abilities' then
                e.tips:AddDoubleLine(col..indexType, get_abilities_icons(pet))
            end
        else
            name= indexType=='icon' and format('|T%d:14|t%d', name, name)
                or (name==false and 'false')
                or (name==true and 'true')
                or (name==nil and '')
                or name
            e.tips:AddDoubleLine(col..indexType, col..name)
        end
        i=i+1
    end
    e.tips:AddDoubleLine(format('|cff00ccff%s', e.onlyChinese and '食物' or POWER_TYPE_FOOD), format('|cff00ccff%s', BuildListString(GetStablePetFoodTypes(pet.slotID)) or ''))
end


local function set_model(self)--StableActivePetButtonTemplateMixin
    local data= self.petData or {}--宠物，类型，图标
    if data.displayID and data.displayID>0 then
        if data.displayID~=self.displayID then
            self.model:SetDisplayInfo(data.displayID)
        end
    else
        self.model:ClearModel()
    end
    self.displayID= data.displayID--提示用，
end


--已激活宠物，Model 提示
local function created_model(btn)
    local w= btn:GetWidth()+40
    btn.model= CreateFrame("PlayerModel", nil, btn)
    btn.model:SetSize(w, w)
    btn.model:SetFacing(0.5)
    --[[
    local bg=btn.model:CreateTexture('BACKGROUND')
    bg:SetAllPoints(btn.model)
    bg:SetAtlas('ShipMission_RewardsBG-Desaturate')
    e.Set_Label_Texture_Color(bg, {type='Texture', alpha=0.3})
    ]]
end


local function set_button_size(btn)
    local n= Save.all_List_Size or 28
    StableFrame.AllListFrame.s= n
    btn:SetSize(n, n)
    btn.Icon:SetSize(n, n)
    local s= n*0.5
    btn.BackgroundMask:SetSize(s, s)
    local w= n+ ((85-66)/66)*n--0.287
    local h= n+ ((100-66)/66)*n--0.515
    btn.Highlight:SetSize(w, h)
end

--召唤，法术，提示
local CALL_PET_SPELL_IDS = {0883, 83242, 83243, 83244, 83245, }

e.LoadDate({id=267116, type='spell'})--动物伙伴









--猎人，兽栏 Plus 10.2.7 Blizzard_StableUI.lua
local function Init_StableFrame_Plus()
    hooksecurefunc(StableStabledPetButtonTemplateMixin, 'SetPet', function(btn)--宠物，列表，提示
        if btn.set_list_button_settings then
            btn:set_list_button_settings()
            return
        end
        btn:HookScript('OnEnter', function(self)--信息，提示
            set_pet_tooltips(self, self.petData, -10)
            e.tips:Show()
        end)
        btn.Portrait2= btn:CreateTexture(nil, 'OVERLAY')--宠物，类型，图标
        btn.Portrait2:SetSize(20, 20)
        btn.Portrait2:SetPoint('RIGHT', btn.Portrait,'LEFT')
        btn.Portrait2:SetAlpha(0.5)
        btn.abilitiesText= e.Cstr(btn)--宠物，技能，提示
        btn.abilitiesText:SetPoint('BOTTOMRIGHT', btn.Background, -9, 8)
        btn.indexText= e.Cstr(btn)--, {color={r=1,g=0,b=1}})--SlotID
        btn.indexText:SetPoint('TOPRIGHT', -9,-6)
        btn.indexText:SetAlpha(0.5)
        function btn:set_list_button_settings()
            self.abilitiesText:SetText(get_abilities_icons(self.petData))--宠物，技能，提示
            local data= self.petData or {}--宠物，类型，图标
            self.Portrait2:SetTexture(data.icon or nil)
            self.indexText:SetText(data.slotID or '')
        end
    end)


    for i, btn in ipairs(StableFrame.ActivePetList.PetButtons) do    --已激，宠物栏，提示
        btn.index=btn:GetID()

        btn.callSpellButton= e.Cbtn(btn, {size={18,18},icon='hide'})--召唤，法术，提示
        btn.callSpellButton.Texture=btn.callSpellButton:CreateTexture(nil, 'OVERLAY')
        btn.callSpellButton.Texture:SetAllPoints(btn.callSpellButton)
        SetPortraitToTexture(btn.callSpellButton.Texture, 132161)
        btn.callSpellButton:SetPoint('BOTTOMLEFT', -8, -16)
        btn.callSpellButton.spellID=CALL_PET_SPELL_IDS[btn.index]
        btn.callSpellButton:SetScript('OnLeave', function(self) self:SetAlpha(0.3) GameTooltip_Hide() end)
        btn.callSpellButton:SetScript('OnEnter', function(self)
            if not self.spellID then return end
            GameTooltip:SetOwner(self, "ANCHOR_LEFT")
            GameTooltip:ClearLines()
            GameTooltip:SetSpellByID(self.spellID, true, true);
            GameTooltip:Show();
            self:SetAlpha(1)
        end)
        btn.callSpellButton:SetAlpha(0.5)

        btn:HookScript('OnEnter', function(self)--信息，提示
            set_pet_tooltips(self, self.petData, -10)
            if not self.petData then return end
            e.tips:AddLine(' ')
            e.tips:AddDoubleLine(e.onlyChinese and '移除' or REMOVE, e.Icon.right)
            e.tips:Show()
        end)

        btn.Portrait2= btn.callSpellButton:CreateTexture(nil, 'OVERLAY')--宠物，类型，图标
        btn.Portrait2:SetSize(18, 18)

        btn.Portrait2:SetPoint('LEFT', btn.callSpellButton, 'RIGHT')
        btn.abilitiesText= e.Cstr(btn, {SetJustifyH='RIGHT'})--宠物，技能，提示
        btn.abilitiesText:SetPoint('BOTTOMRIGHT', btn.callSpellButton, 'BOTTOMLEFT', 2, -4)

        btn.indexText=e.Cstr(btn.callSpellButton)--索引
        btn.indexText:SetPoint('LEFT', btn.Portrait2, 'RIGHT', 4,0)
        btn.indexText:SetText(i)


        created_model(btn)--已激活宠物，Model 提示
        btn.model:SetPoint('TOP', btn, 'BOTTOM', 0, -14)

        hooksecurefunc(btn, 'SetPet', function(self)--StableActivePetButtonTemplateMixin
            local icon= get_abilities_icons(self.petData)
            icon= icon:gsub('|T.-|t', function(a) return a..'|n' end)

            self.abilitiesText:SetText(icon)--宠物，技能，提示

            local data= self.petData or {}--宠物，类型，图标
            self.Portrait2:SetTexture(data.icon or 0)

            set_model(self)
        end)
    end




    local btn= StableFrame.ActivePetList.BeastMasterSecondaryPetButton--第二个，宠物，提示
    created_model(btn)--已激活宠物，Model 提示
    hooksecurefunc(btn, 'SetPet', set_model)
    btn.model:SetFacing(-0.5)
    btn.model:SetPoint('RIGHT', btn, 'LEFT')

    btn:HookScript('OnEnter', function(self)
        if not self.petData or not self:IsEnabled() then
            return
        end
        set_pet_tooltips(self, self.petData, 0)
        e.tips:AddLine(' ')
        e.tips:AddDoubleLine(
            format('|A:UI-HUD-MicroMenu-SpecTalents-Mouseover:0:0|a|cffaad372%s|r', e.onlyChinese and '天赋' or TALENT),
            format('|T461112:0|t|cffaad372%s|r', e.onlyChinese and '动物伙伴' or GetSpellLink(267116) or GetSpellInfo(267116) or 'Animal Companion')
        )
        e.tips:AddDoubleLine(e.onlyChinese and '移除' or REMOVE, e.Icon.right)
        e.tips:Show()
    end)

    local frame= CreateFrame('Frame', nil, btn, 'StablePetAbilityTemplate')--StablePetAbilityMixin
    frame:SetPoint('TOPRIGHT', btn, 'BOTTOMRIGHT', 10,-6)
    frame:Initialize(267116)--动物伙伴
    frame.Icon:ClearAllPoints()
    frame.Icon:SetPoint('RIGHT')
    frame.Name:ClearAllPoints()
    frame.Name:SetPoint('RIGHT', frame.Icon, 'LEFT')

    --食物
    StableFrame.PetModelScene.PetInfo.Food=e.Cstr(StableFrame.PetModelScene.PetInfo, {copyFont=StableFrame.PetModelScene.PetInfo.Specialization, color={r=1,g=1,b=1}, size=16})
    StableFrame.PetModelScene.PetInfo.Food:SetPoint('TOPRIGHT', StableFrame.PetModelScene.PetInfo.Exotic, 'BOTTOMRIGHT')
    hooksecurefunc(StableFrame.PetModelScene.PetInfo, 'SetPet', function(self)
        self.Food:SetFormattedText(PET_DIET_TEMPLATE, BuildListString(GetStablePetFoodTypes(self.petData.slotID)) or '')
        --(e.onlyChinese and '|cffffd200食物：|r%s' or 
    end)
end










function Init_UI()
    --移动，缩放

    StableFrame.PetModelScene:ClearAllPoints()
    StableFrame.PetModelScene:SetPoint('TOPLEFT', StableFrame.Topper, 'BOTTOMLEFT', 330, 0)
    StableFrame.PetModelScene:SetPoint('BOTTOMRIGHT', -2, 92)
    --[[StableFrame.ActivePetList:ClearAllPoints()
    StableFrame.ActivePetList:SetPoint('TOPLEFT', StableFrame.PetModelScene, 'BOTTOMLEFT', 0, -45)
    StableFrame.ActivePetList:SetPoint('TOPRIGHT', StableFrame.PetModelScene, 'BOTTOMRIGHT', 0, -45)
    ]]
    e.Set_Move_Frame(StableFrame, {needSize=true, needMove=true, setSize=true, minW=860, minH=440, initFunc=function()
            --[[StableFrame.PetModelScene:ClearAllPoints()
            StableFrame.PetModelScene:SetPoint('TOPLEFT', StableFrame.Topper, 'BOTTOMLEFT', 330, 0)
            StableFrame.PetModelScene:SetPoint('BOTTOMRIGHT', -2, 92)
            StableFrame.ActivePetList:ClearAllPoints()
            StableFrame.ActivePetList:SetPoint('TOPLEFT', StableFrame.PetModelScene, 'BOTTOMLEFT', 0, -45)
            StableFrame.ActivePetList:SetPoint('TOPRIGHT', StableFrame.PetModelScene, 'BOTTOMRIGHT', 0, -45)
            e.Set_Move_Frame(StableFrame.StabledPetList.ScrollBox, {frame=StableFrame})]]
        end, sizeRestFunc=function(btn)
            btn.target:SetSize(1040, 638)
    end})

    StableFrame.ReleasePetButton:ClearAllPoints()
    StableFrame.ReleasePetButton:SetPoint('BOTTOMLEFT', StableFrame.PetModelScene, 'TOPLEFT', 0,20)
    StableFrame.ReleasePetButton:SetAlpha(0.5)
    StableFrame.ReleasePetButton:HookScript('OnLeave', function(self) self:SetAlpha(0.5) end)
    StableFrame.ReleasePetButton:HookScript('OnEnter', function(self) self:SetAlpha(1) end)

    StableFrame.StableTogglePetButton:ClearAllPoints()
    StableFrame.StableTogglePetButton:SetPoint('BOTTOMRIGHT', StableFrame.PetModelScene)

    StableFrame.PetModelScene.AbilitiesList:ClearAllPoints()
    StableFrame.PetModelScene.AbilitiesList:SetPoint('LEFT', 8, -40)


    --StableFrame.PetModelScene.PetInfo.Type:SetJustifyH('RIGHT')
    StableFrame.PetModelScene.PetInfo.Specialization:ClearAllPoints()
    StableFrame.PetModelScene.PetInfo.Specialization:SetPoint('TOPRIGHT', StableFrame.PetModelScene.PetInfo.Type, 'BOTTOMRIGHT', 0, -2)

    StableFrame.PetModelScene.PetInfo.Exotic:ClearAllPoints()
    StableFrame.PetModelScene.PetInfo.Exotic:SetPoint('TOPRIGHT', StableFrame.PetModelScene.PetInfo.Specialization, 'BOTTOMRIGHT', 0, -2)
    StableFrame.PetModelScene.PetInfo.Exotic:SetTextColor(0,1,0)

    StableFrame.ActivePetList.ActivePetListBG:ClearAllPoints()
    StableFrame.ActivePetList.ActivePetListBG:SetPoint('TOPLEFT', StableFrame.PetModelScene, 'BOTTOMLEFT', 0, -2)
    StableFrame.ActivePetList.ActivePetListBG:SetPoint('BOTTOMRIGHT', StableFrame)
    StableFrame.PetModelScene.ControlFrame:ClearAllPoints()
    StableFrame.PetModelScene.ControlFrame:SetPoint('TOP')

    StableFrame.PetModelScene.PetShadow:ClearAllPoints()
    StableFrame.PetModelScene.PetShadow:SetPoint('BOTTOMLEFT')
    StableFrame.PetModelScene.PetShadow:SetPoint('BOTTOMRIGHT')

    StableFrame.ActivePetList.BeastMasterSecondaryPetButton:ClearAllPoints()
    StableFrame.ActivePetList.BeastMasterSecondaryPetButton:SetPoint('BOTTOMRIGHT',  StableFrame.PetModelScene, -20 , 80)
    StableFrame.ActivePetList.Divider:ClearAllPoints()
    StableFrame.ActivePetList.Divider:Hide()

    local x= 40
    StableFrame.ActivePetList.PetButton3:ClearAllPoints()
    StableFrame.ActivePetList.PetButton3:SetPoint('CENTER')

    StableFrame.ActivePetList.PetButton2:ClearAllPoints()
    StableFrame.ActivePetList.PetButton2:SetPoint('RIGHT', StableFrame.ActivePetList.PetButton3, 'LEFT', -x, 0)

    StableFrame.ActivePetList.PetButton1:ClearAllPoints()
    StableFrame.ActivePetList.PetButton1:SetPoint('RIGHT', StableFrame.ActivePetList.PetButton2, 'LEFT', -x, 0)

    StableFrame.ActivePetList.PetButton4:ClearAllPoints()
    StableFrame.ActivePetList.PetButton4:SetPoint('LEFT', StableFrame.ActivePetList.PetButton3, 'RIGHT', x, 0)

    StableFrame.ActivePetList.PetButton5:ClearAllPoints()
    StableFrame.ActivePetList.PetButton5:SetPoint('LEFT', StableFrame.ActivePetList.PetButton4, 'RIGHT', x, 0)

    StableFrame.ActivePetList.ListName:ClearAllPoints()
    StableFrame.ActivePetList.ListName:SetPoint('BOTTOMLEFT', StableFrame.ActivePetList.ActivePetListBG, 'TOPLEFT',0,-6)
end










--初始，宠物列表
function Set_StableFrame_List()
    if StableFrame.AllListFrame or not Save.show_All_List then
        if StableFrame.AllListFrame then
            StableFrame.AllListFrame:set_shown()
        end
        return
    end

    local frame= CreateFrame('Frame', nil, StableFrame)
    StableFrame.AllListFrame=frame
    frame:SetPoint('TOPLEFT', StableFrame, 'TOPRIGHT',12,0)
    frame:SetSize(1,1)
    frame:Hide()
    function frame:set_shown()
        self:SetShown(Save.show_All_List)
    end

    frame.Buttons={}

    frame.s= Save.all_List_Size or 28

    frame.Bg= frame:CreateTexture(nil, "BACKGROUND")
    frame.Bg:SetAtlas('footer-bg')
    frame.Bg:SetPoint('TOPLEFT')

    for i=Constants.PetConsts.STABLED_PETS_FIRST_SLOT_INDEX+ 1, Constants.PetConsts.NUM_PET_SLOTS do
        local btn= CreateFrame('Button', nil, frame, 'StableActivePetButtonTemplate', i)
        --btn.Icon:SetTexCoord(1,0,0,1)--左右，对换
        btn:HookScript('OnEnter', function(self)
            if not self.petData then return end
            set_pet_tooltips(self, self.petData, 0)
            e.tips:AddLine(' ')
            e.tips:AddDoubleLine(e.onlyChinese and '激活' or SPEC_ACTIVE, e.Icon.right)
            e.tips:Show()
        end)
        set_button_size(btn)
        btn.Border:SetTexture(nil)
        btn.Border:ClearAllPoints()
        btn.Border:Hide()
        frame.Buttons[i]= btn
        --table.insert(frame.Buttons, btn)
    end


    function frame:set_point()
        if not self:IsShown() then return end

        local x, y = 0, 0
        local btnY
        local s= StableFrame:GetHeight()
        for _, btn in pairs(self.Buttons) do
            btn:ClearAllPoints()
            btn:SetPoint('TOPLEFT', x, y)
            y= y-self.s
            if -y> s then
                btnY=btn
                y=0
                x=x+ self.s
            end
        end
        frame.Bg:ClearAllPoints()
        frame.Bg:SetPoint('TOPLEFT', frame.Buttons[Constants.PetConsts.STABLED_PETS_FIRST_SLOT_INDEX+ 1])
        frame.Bg:SetPoint('BOTTOM', btnY)
        frame.Bg:SetPoint('RIGHT', frame.Buttons[Constants.PetConsts.NUM_PET_SLOTS])
    end

    function frame:Refresh()
        if not self:IsShown() then return end
        local pets={}
        for _, pet in pairs(C_StableInfo.GetStabledPetList() or {}) do
            pets[pet.slotID]= pet
        end
        for index, btn in pairs(frame.Buttons) do
            btn:SetPet(pets[index])
            
        end
    end

    hooksecurefunc(StableFrame, 'Refresh', function(self)
        self.AllListFrame:Refresh()
    end)
    frame:SetScript('OnShow', function(self)
        self:Refresh()
        self:set_point()
    end)
    frame:SetScript('OnHide', function(self)
        for _, btn in pairs(self.Buttons) do
            btn:SetPet(nil)
        end
    end)

    StableFrame:HookScript('OnSizeChanged', function(self) self.AllListFrame:set_point() end)

    frame:set_shown()
end

































local function get_text_byte(text)
    local num=0
    if type(text)=='number' then
        num= text
    elseif type(text)=='string' then
         for i=1, #text do
            num= num+ (string.byte(text, i) or 0)
         end
    end
    return num
end



local Is_In_Search
local function sort_pets_list(type, d)
    if Is_In_Search then
        return
    end
    Is_In_Search= true
    do
        local tab= {}
        for _, btn in pairs(StableFrame.AllListFrame.Buttons) do
            if btn.petData and btn.petData.slotID then
                local info = C_StableInfo.GetStablePetInfo(btn.petData.slotID)
                    table.insert(tab, {
                        slotID= get_text_byte(info.slotID),
                        petNumber= get_text_byte(info.petNumber),
                        type= get_text_byte(info.type),
                        creatureID= get_text_byte(info.CreatureID),
                        uiModelSceneID= get_text_byte(info.uiModelSceneID),
                        displayID= get_text_byte(displayID),
                        name= get_text_byte(info.name),
                        specialization= get_text_byte(info.specialization),
                        icon= get_text_byte(info.icon),
                        familyName= get_text_byte(info.familyName)
                    })
            end
        end
        table.sort(tab, function(a, b)
            return a[type] < b[type]
        end)

        if not Save.sortDown then--点击，从前，向后
            for i, newTab in pairs(tab) do
                do
                    local index= i+  Constants.PetConsts.STABLED_PETS_FIRST_SLOT_INDEX+ 1
                    C_StableInfo.SetPetSlot(newTab.slotID, index)
                end
            end
        else
            local all= #StableFrame.AllListFrame.Buttons
            for i, newTab in pairs(tab) do
                do
                    local newIndex= all-i+1
                    C_StableInfo.SetPetSlot(newTab.slotID, newIndex)
                end
            end
        end
    end
    Is_In_Search=nil
end












--宠物列表
function Init_StableFrame_List()
    local btn= e.Cbtn(StableFrame, {size={20,20}, atlas='dressingroom-button-appearancelist-up'})
    btn:SetPoint('RIGHT', StableFrameCloseButton, 'LEFT', -2, 0)
    btn:SetFrameLevel(StableFrameCloseButton:GetFrameLevel()+1)
    function btn:set_show_tips()
        if Save.show_All_List then
            self:SetButtonState('PUSHED')
        else
            self:SetButtonState('NORMAL')
        end
        self:SetAlpha(Save.show_All_List and 0.3 or 1)
    end
    function btn:set_tooltips()
        e.tips:SetOwner(self, "ANCHOR_LEFT")
        e.tips:ClearLines()
        e.tips:AddDoubleLine(id, Initializer:GetName())
        e.tips:AddLine(' ')
        e.tips:AddDoubleLine(format('%s %s', e.onlyChinese and '所有宠物' or BATTLE_PETS_TOTAL_PETS, e.GetEnabeleDisable(Save.show_All_List)), e.Icon.left)
        e.tips:AddDoubleLine(e.onlyChinese and '菜单' or HUD_EDIT_MODE_MICRO_MENU_LABEL, e.Icon.right)
        e.tips:AddDoubleLine(format('%s |cnGREEN_FONT_COLOR:%d|r', e.onlyChinese and '图标尺寸' or HUD_EDIT_MODE_SETTING_ACTION_BAR_ICON_SIZE, Save.all_List_Size or 28), e.Icon.mid)
        e.tips:Show()
        self:SetAlpha(1)
    end
    btn:SetScript('OnClick', function(self, d)
        if d=='LeftButton' then
            Save.show_All_List= not Save.show_All_List and true or nil
            Set_StableFrame_List()--初始，宠物列表
            self:set_tooltips()
        else

            if not self.menu then
                self.menu= CreateFrame('Frame', nil, btn , "UIDropDownMenuTemplate")
                e.LibDD:UIDropDownMenu_Initialize(self.menu, function(_, level, menuList)
                    if menuList=='SortType' then
                        e.LibDD:UIDropDownMenu_AddButton({
                            text= e.onlyChinese and '升序' or PERKS_PROGRAM_ASCENDING,
                            checked= not Save.sortDown,
                            func= function()
                                Save.sortDown= not Save.sortDown and true or nil
                            end
                        }, level)
                        return
                    end
                    e.LibDD:UIDropDownMenu_AddButton({
                        text= e.onlyChinese and '排序' or CLUB_FINDER_SORT_BY,
                        colorCode='|cffff7f00',
                        notCheckable=true,
                        keepShownOnClick=true,
                        hasArrow=true,
                        menuList='SortType',
                    }, level)

                    local tab={
                        ['petNumber']=  'petNumber',
                        [e.onlyChinese and '类型' or TYPE]= 'type',
                        ['creatureID']= 'creatureID',
                        ['uiModelSceneID']= 'uiModelSceneID',
                        ['displayID']= 'displayID',
                        [e.onlyChinese and '名称' or NAME]= 'name',
                        [e.onlyChinese and '天赋' or TALENT]= 'specialization',
                        [e.onlyChinese and '图标' or EMBLEM_SYMBOL]='icon',
                        ['familyName']= 'familyName',
                    }
                   for text, name in pairs(tab) do
                        local info={
                            text=text,
                            notCheckable=true,
                            arg1=name,
                            keepShownOnClick=true,
                            disabled= not StableFrame.AllListFrame or not StableFrame.AllListFrame:IsShown(),
                            func=function(_, arg1)
                                sort_pets_list(arg1)
                            end
                        }
                        e.LibDD:UIDropDownMenu_AddButton(info, level)
                    end

                    e.LibDD:UIDropDownMenu_AddSeparator(level)

                    e.LibDD:UIDropDownMenu_AddButton({
                        text= e.onlyChinese and '所有宠物' or BATTLE_PETS_TOTAL_PETS,
                        checked= Save.show_All_List,
                        icon= 'dressingroom-button-appearancelist-up',
                        func= function()
                            Save.show_All_List= not Save.show_All_List and true or nil
                            Set_StableFrame_List()--初始，宠物列表
                        end
                    }, level)
                    e.LibDD:UIDropDownMenu_AddButton({
                        text= e.onlyChinese and '选项' or OPTIONS,
                        notCheckable=true,
                        icon='mechagon-projects',
                        func= function()
                            e.OpenPanelOpting(Initializer:GetName())
                        end
                    }, level)
                end, "MENU")
            end
            e.LibDD:ToggleDropDownMenu(1, nil, self.menu, self, -100, 0)

        end
    end)


    btn:SetScript('OnMouseWheel', function(self, d)
        local n= Save.all_List_Size or 28
        n= d==1 and n-2 or n
        n= d==-1 and n+2 or n
        n= n>66 and 66 or n
        n= n<8 and 8 or n
        Save.all_List_Size= n
        local frame= StableFrame.AllListFrame
        if frame then
            frame.s=n
            for _, btn in pairs(StableFrame.AllListFrame.Buttons) do
                set_button_size(btn)
            end
            if frame:IsShown() then
                frame:set_point()
            end
        end
        self:set_tooltips()
    end)


    btn:SetScript('OnLeave', function(self)
        self:set_show_tips()
        e.tips:Hide()
    end)
    btn:SetScript('OnEnter', btn.set_tooltips)
    btn:set_show_tips()

    StableFrame.AllListButton= btn
    Set_StableFrame_List()--初始，宠物列表
end













local panel=CreateFrame("Frame")
panel:RegisterEvent('ADDON_LOADED')
panel:SetScript("OnEvent", function(self, event, arg1)
    if event == "ADDON_LOADED" then
        if arg1==id then
            Save= WoWToolsSave[addName] or Save
            Save.sortIndex= Save.sortIndex or 4

            --添加控制面板
            Initializer= e.AddPanel_Check({
                name= '|A:groupfinder-icon-class-hunter:0:0|a'..(e.onlyChinese and '猎人兽栏' or addName),
                tooltip= nil,
                value= not Save.disabled,
                func= function()
                    Save.disabled = not Save.disabled and true or nil
                    print(id, Initializer:GetName(), e.GetEnabeleDisable(not Save.disabled), e.onlyChinese and '需求重新加载' or REQUIRES_RELOAD)
                end
            })


            if Save.disabled  then-- or C_AddOns.IsAddOnLoaded("ImprovedStableFrame") then
                self:UnregisterAllEvents()
            else
                if StableFrame then--10.2.7
                    Init_StableFrame_List()
                    Init_StableFrame_Plus()
                    Init_UI()
                else
                    self:RegisterEvent('PET_STABLE_SHOW')
                end
            end
            self:UnregisterEvent('ADDON_LOADED')
            self:RegisterEvent('PLAYER_LOGOUT')
        end

    elseif event == "PLAYER_LOGOUT" then
        if not e.ClearAllSave then
            WoWToolsSave[addName]=Save
        end

    elseif event=='PET_STABLE_SHOW' then
        Init()
        self:UnregisterEvent('PET_STABLE_SHOW')
    end
end)