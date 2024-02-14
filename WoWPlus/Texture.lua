local id, e= ...
local addName= TEXTURES_SUBHEADER
local Save={
    --disabled=true,
    alpha= 0.5,

    --disabledChatBubble=true,--禁用，聊天泡泡
    chatBubbleAlpha= 0.5,--聊天泡泡
    chatBubbleSacal= 0.85,

    classPowerNum= e.Player.husandro,--职业，显示数字
    classPowerNumSize= 12,

    --disabledMainMenu= not e.Player.husandro, --主菜单，颜色，透明度
    --disabledHelpTip=true,--隐藏所有教程
}









local min03, min05
local function GetMinValueAlpha()--min03，透明度，最小值
    min03= Save.alpha<0.3 and 0.3 or nil
    min05= Save.alpha<0.5 and 0.5 or nil
end








--隐藏，材质
local function hide_Texture(self, notClear)
    if not self then
        return
    end
    if not notClear and self:GetObjectType()=='Texture' then
        self:SetTexture(0)
    end
    self:SetShown(false)
end

--设置，颜色，透明度
local function set_Alpha_Color(self, notAlpha, notColor, alpha)
    if not self then
        return
    end
    if not notColor and e.Player.useColor then
        e.Set_Label_Texture_Color(self, {type=self:GetObjectType()})
    end
    if not notAlpha then
        self:SetAlpha(alpha or Save.alpha)
    end
end


--隐藏, frame, 子材质
local function hide_Frame_Texture(frame, tab)
    if not frame then
        return
    end
    local hideIndex= tab and tab.index
    for index, icon in pairs({frame:GetRegions()}) do
        if icon:GetObjectType()=="Texture" then
            if hideIndex then
                if hideIndex==index then
                    icon:SetTexture(0)
                    icon:SetShown(false)
                    break
                end
            else
                icon:SetTexture(0)
                icon:SetShown(false)
            end
        end
    end
end

--透明度, 颜色, frame, 子材质
local function set_Alpha_Frame_Texture(frame, tab)
    if not frame then
        return
    end
    tab=tab or {}
    local indexTexture= tab.index
    local notColor= tab.notColor
    local alpha
    if not tab.notAlpha then
        alpha= tab.alpha or Save.alpha
    end
    for index, icon in pairs({frame:GetRegions()}) do
        if icon:GetObjectType()=="Texture" then
            if indexTexture then
                if indexTexture== index then
                    if not notColor then
                        e.Set_Label_Texture_Color(icon, {type='Texture'})
                    end
                    if alpha then
                        icon:SetAlpha(alpha)
                    end
                    break
                end
            else
                if not notColor then
                    e.Set_Label_Texture_Color(icon, {type='Texture'})
                end
                if alpha then
                    icon:SetAlpha(alpha)
                end
            end
        end
    end
end


--设置，按钮
local function set_Button_Alpha(btn, tab)
    if not btn or not e.Player.useColor then
        return
    end
    local texture= btn:GetNormalTexture()
    if texture then
        tab = tab or {}
        if e.Player.useColor then
            local col= tab.color or e.Player.useColor
            texture:SetVertexColor(col.r, col.g, col.b, 1)
        end
        texture:SetAlpha(tab.alpha or Save.alpha)
    end
end


local function set_SearchBox(frame)
    if not frame then-- or not frame.SearchBox then
        return
    end
    set_Alpha_Color(frame.Middle, nil, nil, min05)
    set_Alpha_Color(frame.Left, nil, nil, min05)
    set_Alpha_Color(frame.Right, nil, nil, min05)
    set_Alpha_Color(frame.Mid, nil, nil, min05)
end

local setNineSliceTabs={
    'TopEdge',
    'BottomEdge',
    'LeftEdge',
    'RightEdge',
    'TopLeftCorner',
    'TopRightCorner',
    'BottomRightCorner',
    'BottomLeftCorner',
    'Center',
    'Background',
    'Bg',
}
local function set_NineSlice(frame, min, hide)
    if not frame or not frame.NineSlice then
        return
    end
    local alpha= min and min03 or nil
    for _, text in pairs(setNineSliceTabs) do
        if not hide then
            set_Alpha_Color(frame.NineSlice[text], nil, nil, alpha)
        else
            hide_Texture(frame.NineSlice[text])
        end
    end
end

--设置，滚动条，颜色
local function set_ScrollBar(frame)
    local bar= frame and frame.ScrollBar or frame
    if bar then
        if bar.Track then
            set_Alpha_Color(bar.Track.Thumb.Middle, true)
            set_Alpha_Color(bar.Track.Thumb.Begin, true)
            set_Alpha_Color(bar.Track.Thumb.End, true)
        end
        if bar.Back then
            set_Alpha_Color(bar.Back.Texture, true)
        end
        if bar.Forward then
            set_Alpha_Color(bar.Forward.Texture, true)
        end
        hide_Texture(bar.Backplate, nil, true)
        set_Alpha_Color(bar.Background, nil, true)
    end
end

local function set_Slider(frame)
    if not frame or not frame.Slider then
        return
    end

    local thumb= frame.Slider.Slider and frame.Slider.Slider.Thumb or frame.Slider.Thumb
    set_Alpha_Color(thumb, true)

    local back= frame.Slider.Back or frame.Back
    if back then
        for _, icon in pairs({back:GetRegions()}) do
            if icon:GetObjectType()=="Texture" then
                e.Set_Label_Texture_Color(icon, {type='Texture'})
            end
        end
    end
    local forward= frame.Slider.Forward or frame.Forward
    if forward then
        for _, icon in pairs({forward:GetRegions()}) do
            if icon:GetObjectType()=="Texture" then
                e.Set_Label_Texture_Color(icon, {type='Texture'})
            end
        end
    end

    local middle= frame.Slider.Slider and frame.Slider.Slider.Middle or frame.Slider.Middle
    local right= frame.Slider.Slider and frame.Slider.Slider.Right or frame.Slider.Right
    local left= frame.Slider.Slider and frame.Slider.Slider.Left or frame.Slider.Left
    e.Set_Label_Texture_Color(middle, {type='Texture'})
    e.Set_Label_Texture_Color(right, {type='Texture'})
    e.Set_Label_Texture_Color(left, {type='Texture'})
end

local function set_Menu(self)
    if self then
        set_Alpha_Frame_Texture(self, {notAlpha=true})
        set_Alpha_Frame_Texture(self.Button, {notAlpha=true})
        set_Alpha_Frame_Texture(self.DecrementButton, {notAlpha=true})
        set_Alpha_Frame_Texture(self.IncrementButton, {notAlpha=true})
        e.Set_Label_Texture_Color(self.Text, {type='FontString'})
    end
end

local function set_Label(self, shadowOffset)
    if self then
        e.Set_Label_Texture_Color(self, {type='FontString', alpha=min05})--设置颜色
        if shadowOffset then
            self:SetShadowOffset(shadowOffset, -shadowOffset)
        end
    end
end


































































--###############
--初始化, 隐藏材质
--###############
local function Init_All_Frame()
    hide_Texture(GameMenuFrame.Header.RightBG)
    hide_Texture(GameMenuFrame.Header.CenterBG)
    hide_Texture(GameMenuFrame.Header.LeftBG)
    GameMenuFrame.Header.Text:ClearAllPoints()
    GameMenuFrame.Header.Text:SetPoint('TOP', 0 ,-24)
    set_Alpha_Frame_Texture(GameMenuFrame.Border, {alpha= min05})

    for i=1, MAX_BOSS_FRAMES do
        local frame= _G['Boss'..i..'TargetFrame']
        hide_Texture(frame.TargetFrameContainer.FrameTexture)
    end

    hooksecurefunc('PlayerFrame_UpdateArt', function()--隐藏材质, 载具
        if OverrideActionBarEndCapL then
            hide_Texture(OverrideActionBarEndCapL)
            hide_Texture(OverrideActionBarEndCapR)
            hide_Texture(OverrideActionBarBorder)
            hide_Texture(OverrideActionBarBG)
            hide_Texture(OverrideActionBarButtonBGMid)
            hide_Texture(OverrideActionBarButtonBGR)
            hide_Texture(OverrideActionBarButtonBGL)
        end
        if OverrideActionBarMicroBGMid then
            hide_Texture(OverrideActionBarMicroBGMid)
            hide_Texture(OverrideActionBarMicroBGR)
            hide_Texture(OverrideActionBarMicroBGL)
            hide_Texture(OverrideActionBarLeaveFrameExitBG)

            hide_Texture(OverrideActionBarDivider2)
            hide_Texture(OverrideActionBarLeaveFrameDivider3)
        end
        if OverrideActionBarExpBar then
            hide_Texture(OverrideActionBarExpBarXpMid)
            hide_Texture(OverrideActionBarExpBarXpR)
            hide_Texture(OverrideActionBarExpBarXpL)
        end
    end)
    if ExtraActionButton1 then hide_Texture(ExtraActionButton1.style) end--额外技能
    if ZoneAbilityFrame then hide_Texture(ZoneAbilityFrame.Style) end--区域技能



    if PetBattleFrame then--宠物
        hide_Texture(PetBattleFrame.TopArtLeft)
        hide_Texture(PetBattleFrame.TopArtRight)
        hide_Texture(PetBattleFrame.TopVersus)
        PetBattleFrame.TopVersusText:SetText('')
        PetBattleFrame.TopVersusText:SetShown(false)
        hide_Texture(PetBattleFrame.WeatherFrame.BackgroundArt)

        hide_Texture(PetBattleFrameXPBarLeft)
        hide_Texture(PetBattleFrameXPBarRight)
        hide_Texture(PetBattleFrameXPBarMiddle)

        if PetBattleFrame.BottomFrame then
            hide_Texture(PetBattleFrame.BottomFrame.LeftEndCap)
            hide_Texture(PetBattleFrame.BottomFrame.RightEndCap)
            hide_Texture(PetBattleFrame.BottomFrame.Background)
            hide_Texture(PetBattleFrame.BottomFrame.TurnTimer.ArtFrame2)
            PetBattleFrame.BottomFrame.FlowFrame:SetShown(false)
            PetBattleFrame.BottomFrame.Delimiter:SetShown(false)
        end
    end

    hide_Frame_Texture(PetBattleFrame.BottomFrame.MicroButtonFrame)

    hooksecurefunc('PetBattleFrame_UpdatePassButtonAndTimer', function(self)--Blizzard_PetBattleUI.lua
        hide_Texture(self.BottomFrame.TurnTimer.TimerBG)
        --self.BottomFrame.TurnTimer.Bar:SetShown(true);
        hide_Texture(self.BottomFrame.TurnTimer.ArtFrame);
        hide_Texture(self.BottomFrame.TurnTimer.ArtFrame2);
    end)




    if MultiBarBottomLeftButton10 then hide_Texture(MultiBarBottomLeftButton10.SlotBackground) end

     if CompactRaidFrameManager then--隐藏, 团队, 材质 Blizzard_CompactRaidFrameManager.lua
        hide_Texture(CompactRaidFrameManagerBorderTop)
        hide_Texture(CompactRaidFrameManagerBorderRight)
        hide_Texture(CompactRaidFrameManagerBorderBottom)
        hide_Texture(CompactRaidFrameManagerBorderTopRight)
        hide_Texture(CompactRaidFrameManagerBorderTopLeft)
        hide_Texture(CompactRaidFrameManagerBorderBottomLeft)
        hide_Texture(CompactRaidFrameManagerBorderBottomRight)
        hide_Texture(CompactRaidFrameManagerDisplayFrameHeaderDelineator)
        hide_Texture(CompactRaidFrameManagerDisplayFrameHeaderBackground)
        hide_Texture(CompactRaidFrameManagerBg)
        hide_Texture(CompactRaidFrameManagerDisplayFrameFilterOptionsFooterDelineator)

        CompactRaidFrameManager.toggleButton:SetNormalAtlas(e.Icon.toRight,true)--展开, 图标
        CompactRaidFrameManager.toggleButton:SetAlpha(0.3)
        CompactRaidFrameManager.toggleButton:SetHeight(30)
        hooksecurefunc('CompactRaidFrameManager_Collapse', function()
            CompactRaidFrameManager.toggleButton:SetNormalAtlas(e.Icon.toRight)
        end)
        hooksecurefunc('CompactRaidFrameManager_Expand', function()
            CompactRaidFrameManager.toggleButton:SetNormalAtlas(e.Icon.toLeft)
        end)
        if CompactRaidFrameManagerDisplayFrameLeaderOptionsCountdownText then
            CompactRaidFrameManagerDisplayFrameLeaderOptionsCountdownText:SetText('|A:countdown-swords:22:22|a10')
            CompactRaidFrameManagerDisplayFrameLeaderOptionsInitiateRolePollText:SetText('|A:groupfinder-icon-role-large-tank:22:22:|a|A:groupfinder-icon-role-large-heal:22:22|a')
            CompactRaidFrameManagerDisplayFrameLeaderOptionsInitiateReadyCheckText:SetText('|A:'..e.Icon.select..':22:22|a')
        end
     end
     set_Alpha_Color(PlayerCastingBarFrame.Border)
     set_Alpha_Color(PlayerCastingBarFrame.Background)
     set_Alpha_Color(PlayerCastingBarFrame.TextBorder)
     set_Alpha_Color(PlayerCastingBarFrame.Shine)

     --角色，界面
     set_NineSlice(CharacterFrameInset, true)
     set_NineSlice(CharacterFrame, true)
     set_NineSlice(CharacterFrameInsetRight, true)

     set_Alpha_Color(CharacterFrameBg)
     hide_Texture(CharacterFrameInset.Bg)

     set_Alpha_Color(PaperDollInnerBorderBottom, nil, nil, min03)
     set_Alpha_Color(PaperDollInnerBorderRight, nil, nil, min03)
     set_Alpha_Color(PaperDollInnerBorderLeft, nil, nil, min03)
     set_Alpha_Color(PaperDollInnerBorderTop, nil, nil, min03)

     set_Alpha_Color(PaperDollInnerBorderTopLeft, nil, nil, min03)
     set_Alpha_Color(PaperDollInnerBorderTopRight, nil, nil, min03)
     set_Alpha_Color(PaperDollInnerBorderBottomLeft, nil, nil, min03)
     set_Alpha_Color(PaperDollInnerBorderBottomRight, nil, nil, min03)


     hide_Texture(PaperDollInnerBorderBottom2)
     hide_Texture(CharacterFrameInsetRight.Bg)

     set_ScrollBar(ReputationFrame)
     set_ScrollBar(TokenFrame)

     set_Alpha_Color(CharacterStatsPane.ClassBackground, nil, nil, min03)
     set_Alpha_Color(CharacterStatsPane.EnhancementsCategory.Background)
     set_Alpha_Color(CharacterStatsPane.AttributesCategory.Background)
     set_Alpha_Color(CharacterStatsPane.ItemLevelCategory.Background)
     hooksecurefunc('PaperDollTitlesPane_UpdateScrollBox', function()--PaperDollFrame.lua
         for _, button in pairs(PaperDollFrame.TitleManagerPane.ScrollBox:GetFrames()) do
             hide_Texture(button.BgMiddle)
         end
     end)
     set_ScrollBar(PaperDollFrame.TitleManagerPane)
     hooksecurefunc('PaperDollEquipmentManagerPane_Update', function()--PaperDollFrame.lua
        for _, button in pairs(PaperDollFrame.EquipmentManagerPane.ScrollBox:GetFrames()) do
             hide_Texture(button.BgMiddle)
         end
     end)
     set_ScrollBar(PaperDollFrame.EquipmentManagerPane)
     set_ScrollBar(ReputationFrame)
     set_ScrollBar(TokenFrame)

     hide_Texture(CharacterModelFrameBackgroundTopLeft)--角色3D背景
     hide_Texture(CharacterModelFrameBackgroundTopRight)
     hide_Texture(CharacterModelFrameBackgroundBotLeft)
     hide_Texture(CharacterModelFrameBackgroundBotRight)
     hide_Texture(CharacterModelFrameBackgroundOverlay)

     hide_Frame_Texture(GearManagerPopupFrame.BorderBox)
     set_Alpha_Color(GearManagerPopupFrame.BG, nil, nil, min03)
     set_ScrollBar(GearManagerPopupFrame.IconSelector)
     set_SearchBox(GearManagerPopupFrame.BorderBox.IconSelectorEditBox)
     set_Menu(GearManagerPopupFrame.BorderBox.IconTypeDropDown.DropDownMenu)

     --法术书
     set_NineSlice(SpellBookFrame, true)
     set_NineSlice(SpellBookFrameInset)
     if SpellBookPageText then
         SpellBookPageText:SetTextColor(1, 0.82, 0)
     end

     hide_Texture(SpellBookPage1)
     hide_Texture(SpellBookPage2)
     set_Alpha_Color(SpellBookFrameBg)
     hide_Texture(SpellBookFrameInset.Bg)

     for i=1, 12 do
         set_Alpha_Color(_G['SpellButton'..i..'Background'])
         set_Alpha_Color(_G['SpellButton'..i..'SlotFrame'])

         local frame= _G['SpellButton'..i]
         if frame then
             hooksecurefunc(frame, 'UpdateButton', function(self)--SpellBookFrame.lua
                 self.SpellSubName:SetTextColor(1, 1, 1)
             end)
         end
     end

     set_Alpha_Frame_Texture(SpellBookFrameTabButton1, {alpha=min05})
     set_Alpha_Frame_Texture(SpellBookFrameTabButton2, {alpha=min05})
     set_Alpha_Frame_Texture(SpellBookFrameTabButton3, {alpha=min05})


     --世界地图
     set_NineSlice(WorldMapFrame.BorderFrame, true)
     set_Alpha_Color(WorldMapFrameBg)
     set_Alpha_Color(QuestMapFrame.Background)
     hide_Texture(WorldMapFrame.NavBar.overlay)
     hide_Texture(WorldMapFrame.NavBar.InsetBorderBottom)
     hide_Texture(WorldMapFrame.NavBar.InsetBorderRight)
     hide_Texture(WorldMapFrame.NavBar.InsetBorderLeft)
     hide_Texture(WorldMapFrame.NavBar.InsetBorderBottomRight)
     hide_Texture(WorldMapFrame.NavBar.InsetBorderBottomLeft)
     hide_Texture(WorldMapFrame.BorderFrame.InsetBorderTop)
     WorldMapFrame.NavBar:DisableDrawLayer('BACKGROUND')
     set_ScrollBar(QuestMapDetailsScrollFrame)


     set_Alpha_Color(QuestMapFrame.VerticalSeparator)
     set_Alpha_Color(QuestScrollFrame.DetailFrame.BottomDetail)
     set_Alpha_Color(QuestScrollFrame.Edge)
     set_Alpha_Color(QuestScrollFrame.DetailFrame.TopDetail)
     set_Alpha_Color(QuestScrollFrame.Contents.Separator.Divider, nil, nil, min03)
     set_ScrollBar(QuestScrollFrame)
     set_ScrollBar(QuestMapFrame.DetailsFrame.RewardsFrame.RewardsScrollFrame)



     --地下城和团队副本
     hide_Texture(PVEFrame.TopTileStreaks)--最上面

     set_NineSlice(PVEFrame, true)
     set_SearchBox(LFGListFrame.SearchPanel.SearchBox)
     set_ScrollBar(LFGListFrame.SearchPanel)
     --set_Alpha_Color(LFGListFrame.CategorySelection.Inset.CustomBG)
     --hide_Texture(LFGListFrame.CategorySelection.Inset.Bg)
     set_Alpha_Frame_Texture(LFGListFrame.CategorySelection.Inset, {alpha= min05})
     set_Alpha_Frame_Texture(LFGDungeonReadyDialog.Border, {alpha= min05})
     set_Alpha_Frame_Texture(LFDRoleCheckPopup.Border, {alpha= min05})
     set_Alpha_Frame_Texture(LFGDungeonReadyStatus.Border, {alpha= min05})



     set_NineSlice(LFGListFrame.CategorySelection.Inset, nil, true)
     set_NineSlice(LFGListFrame.EntryCreation.Inset, nil, true)
     hide_Texture(LFGListFrame.EntryCreation.Inset.CustomBG)
     hide_Texture(LFGListFrame.EntryCreation.Inset.Bg)

     set_Alpha_Color(LFGListFrameMiddleMiddle)
     set_Alpha_Color(LFGListFrameMiddleLeft)
     set_Alpha_Color(LFGListFrameMiddleRight)
     set_Alpha_Color(LFGListFrameBottomMiddle)
     set_Alpha_Color(LFGListFrameTopMiddle)
     set_Alpha_Color(LFGListFrameTopLeft)
     set_Alpha_Color(LFGListFrameBottomLeft)
     set_Alpha_Color(LFGListFrameTopRight)
     set_Alpha_Color(LFGListFrameBottomRight)

     set_ScrollBar(LFGListFrame.ApplicationViewer)

     set_Alpha_Color(RaidFinderQueueFrameBackground)
     set_Menu(RaidFinderQueueFrameSelectionDropDown)
     hide_Texture(RaidFinderFrameRoleBackground)


     --右边
     hide_Texture(PVEFrameLLVert)
     hide_Texture(PVEFrameRLVert)
     hide_Texture(PVEFrameBLCorner)
     hide_Texture(PVEFrameBottomLine)
     hide_Texture(PVEFrameBRCorner)
     hide_Texture(PVEFrameTLCorner)
     hide_Texture(PVEFrameTopLine)
     hide_Texture(PVEFrameTRCorner)


     set_Alpha_Color(PVEFrameBg)--左边


     hide_Texture(PVEFrameBlueBg)
     hide_Texture(PVEFrameLeftInset.Bg)
     set_NineSlice(PVEFrameLeftInset, nil, true)
     hide_Frame_Texture(PVEFrame.shadows)

     set_Alpha_Color(LFDQueueFrameBackground)
     set_Menu(LFDQueueFrameTypeDropDown)

     set_NineSlice(LFDParentFrameInset, nil, true)
     set_Alpha_Color(LFDParentFrameInset.Bg)
     set_NineSlice(RaidFinderFrameBottomInset, nil, true)
     set_Alpha_Color(RaidFinderFrameBottomInset.Bg)

     set_Alpha_Color(LFDParentFrameRoleBackground)

    hide_Texture(LFDParentFrameRoleBackground)
    set_NineSlice(RaidFinderFrameRoleInset, nil, true)
    hide_Texture(RaidFinderFrameRoleInset.Bg)


    --GossipFrame
    set_NineSlice(GossipFrame, true)
     set_Alpha_Color(GossipFrameBg)
     hide_Texture(GossipFrameInset.Bg)
     set_ScrollBar(GossipFrame.GreetingPanel)

     set_Alpha_Frame_Texture(PVEFrameTab1, {alpha=min05})
     set_Alpha_Frame_Texture(PVEFrameTab2, {alpha=min05})
     set_Alpha_Frame_Texture(PVEFrameTab3, {alpha=min05})

     if e.Player.class=='HUNTER' and PetStableFrame then--猎人，宠物
        set_NineSlice(PetStableFrame, true)
        set_NineSlice(PetStableLeftInset, nil, true)
        set_Alpha_Color(PetStableActiveBg, nil, nil, min03)
        set_Alpha_Color(PetStableFrameBg)
        set_NineSlice(PetStableFrameInset, nil, true)
        hide_Texture(PetStableFrameInset.Bg)
        set_Alpha_Color(PetStableFrameModelBg, nil, nil, min05)

        set_Alpha_Color(PetStableFrameStableBg, nil, nil, min05)

        for i=1, NUM_PET_STABLE_SLOTS do--NUM_PET_STABLE_PAGES * NUM_PET_STABLE_SLOTS do
            if i<=5 then
                hide_Texture(_G['PetStableActivePet'..i..'Background'])
                set_Alpha_Color(_G['PetStableActivePet'..i..'Border'], nil, nil, min05)
            end
            set_Alpha_Color(_G['PetStableStabledPet'..i..'Background'])
        end
     end





     --银行
     set_NineSlice(BankFrame,true)

     hide_Texture(BankFrameMoneyFrameInset.Bg)
     hide_Texture(BankFrameMoneyFrameBorderMiddle)
     hide_Texture(BankFrameMoneyFrameBorderRight)
     hide_Texture(BankFrameMoneyFrameBorderLeft)
     hide_Texture(BankFrameMoneyFrameInset.NineSlice)

     set_SearchBox(BankItemSearchBox)

     BankFrame:DisableDrawLayer('BACKGROUND')
     local texture= BankFrame:CreateTexture(nil,'BORDER',nil, 1)
     texture:SetAtlas('auctionhouse-background-buy-noncommodities-market')
     texture:SetAllPoints(BankFrame)
     set_Alpha_Color(texture)
     hide_Texture(BankFrameBg)

     hooksecurefunc('BankFrameItemButton_Update',function(button)--银行
         if button.NormalTexture and button.NormalTexture:IsShown() then
             hide_Texture(button.NormalTexture)
         end
         if ReagentBankFrame.numColumn and not ReagentBankFrame.hidexBG then
             ReagentBankFrame.hidexBG=true
             for column = 1, 7 do
                 hide_Texture(ReagentBankFrame["BG"..column])
             end
         end
     end)
     set_Alpha_Frame_Texture(BankFrameTab1, {alpha=min05})
     set_Alpha_Frame_Texture(BankFrameTab2, {alpha=min05})

     --背包
     if ContainerFrameCombinedBags and ContainerFrameCombinedBags.NineSlice then
        set_NineSlice(ContainerFrameCombinedBags, true)

         set_Alpha_Color(ContainerFrameCombinedBags.MoneyFrame.Border.Middle)
         set_Alpha_Color(ContainerFrameCombinedBags.MoneyFrame.Border.Right)
         set_Alpha_Color(ContainerFrameCombinedBags.MoneyFrame.Border.Left)

         set_Alpha_Color(ContainerFrameCombinedBags.Bg.TopSection, true)
         --set_Alpha_Color(ContainerFrameCombinedBags.Bg.BottomEdge)
         --set_Alpha_Color(ContainerFrameCombinedBags.Bg.BottomRight)
         --set_Alpha_Color(ContainerFrameCombinedBags.Bg.BottomLeft)
         set_Alpha_Color(BagItemSearchBox.Middle)
         set_Alpha_Color(BagItemSearchBox.Left)
         set_Alpha_Color(BagItemSearchBox.Right)
     end
     for i=1 ,NUM_TOTAL_EQUIPPED_BAG_SLOTS + NUM_BANKBAGSLOTS+1 do
         local frame= _G['ContainerFrame'..i]
         if frame and frame.NineSlice then
             set_Alpha_Color(frame.Bg.TopSection, true)
             set_NineSlice(frame, true)
         end
     end


     hide_Frame_Texture(CharacterHeadSlot)--1
     hide_Frame_Texture(CharacterNeckSlot)--2
     hide_Frame_Texture(CharacterShoulderSlot)--3
     hide_Frame_Texture(CharacterShirtSlot)--4
     hide_Frame_Texture(CharacterChestSlot)--5
     hide_Frame_Texture(CharacterWaistSlot)--6
     hide_Frame_Texture(CharacterLegsSlot)--7
     hide_Frame_Texture(CharacterFeetSlot)--8
     hide_Frame_Texture(CharacterWristSlot)--9
     hide_Frame_Texture(CharacterHandsSlot)--10
     hide_Frame_Texture(CharacterBackSlot)--15
     hide_Frame_Texture(CharacterTabardSlot)--19
     hide_Frame_Texture(CharacterFinger0Slot)--11
     hide_Frame_Texture(CharacterFinger1Slot)--12
     hide_Frame_Texture(CharacterTrinket0Slot)--13
     hide_Frame_Texture(CharacterTrinket1Slot)--14
     hide_Frame_Texture(CharacterMainHandSlot)--16
     hide_Frame_Texture(CharacterSecondaryHandSlot)--17

     set_Alpha_Frame_Texture(CharacterFrameTab1, {alpha=min05})
     set_Alpha_Frame_Texture(CharacterFrameTab2, {alpha=min05})
     set_Alpha_Frame_Texture(CharacterFrameTab3, {alpha=min05})

     --好友列表
     set_NineSlice(FriendsFrame, true)
     set_Alpha_Color(FriendsFrameBg)
     set_NineSlice(FriendsFrameInset, true)
     set_Alpha_Color(FriendsFrameInset.Bg, nil, nil, min05)
     set_ScrollBar(FriendsListFrame)
     set_ScrollBar(IgnoreListFrame)
     set_Menu(FriendsFrameStatusDropDown)
     set_Alpha_Frame_Texture(FriendsFrameBattlenetFrame.BroadcastButton, {notAlpha=true})

     --好友列表，团队
     if RecruitAFriendFrame and RecruitAFriendFrame.RecruitList then
        set_ScrollBar(RecruitAFriendFrame.RecruitList)
        set_Alpha_Color(RecruitAFriendFrame.RecruitList.ScrollFrameInset.Bg)
     end
     if RaidInfoFrame then--团队信息
        hide_Texture(RaidInfoDetailHeader)
        set_Alpha_Color(RaidInfoFrame.Header.LeftBG)
        set_Alpha_Color(RaidInfoFrame.Header.CenterBG)
        set_Alpha_Color(RaidInfoFrame.Header.RightBG)
        set_Alpha_Color(RaidInfoDetailFooter)
        set_Alpha_Color(RaidInfoFrame.Border.LeftEdge, nil, nil, min03)
        set_Alpha_Color(RaidInfoFrame.Border.RightEdge, nil, nil, min03)
        set_Alpha_Color(RaidInfoFrame.Border.TopEdge, nil, nil, min03)
        set_Alpha_Color(RaidInfoFrame.Border.BottomEdge, nil, nil, min03)
        set_Alpha_Color(RaidInfoFrame.Border.TopLeftCorner, nil, nil, min03)
        set_Alpha_Color(RaidInfoFrame.Border.BottomLeftCorner, nil, nil, min03)
        set_Alpha_Color(RaidInfoFrame.Border.BottomRightCorner, nil, nil, min03)
        set_Alpha_Color(RaidInfoFrame.Border.TopRightCorner, nil, nil, min03)
        set_ScrollBar(RaidInfoFrame)
        set_Alpha_Color(RaidInfoFrame.Border.Bg, nil, nil, min05)
     end

     set_NineSlice(WhoFrameListInset, true)
     set_NineSlice(WhoFrameEditBoxInset, true)
     hide_Texture(WhoFrameListInset.Bg)
     set_ScrollBar(WhoFrame)
     set_Menu(WhoFrameDropDown)

     hide_Texture(WhoFrameEditBoxInset.Bg)
     set_ScrollBar(QuickJoinFrame)

     for i=1, 4 do
        set_Alpha_Frame_Texture(_G['FriendsFrameTab'..i], {alpha=min05})
        set_Alpha_Frame_Texture(_G['FriendsTabHeaderTab'..i], {alpha=min05})
        set_Alpha_Frame_Texture(_G['WhoFrameColumnHeader'..i], {alpha=min05})
     end


     --聊天设置
     set_NineSlice(ChannelFrame, true)
     set_Alpha_Color(ChannelFrameBg)
     hide_Texture(ChannelFrameInset.Bg)
     hide_Texture(ChannelFrame.RightInset.Bg)
     hide_Texture(ChannelFrame.LeftInset.Bg)
     set_ScrollBar(ChannelFrame.ChannelRoster)
     set_ScrollBar(ChannelFrame.ChannelList)


     --任务
     set_NineSlice(QuestFrame, true)
     set_Alpha_Color(QuestFrameBg)
     hide_Texture(QuestFrameInset.Bg)
     set_ScrollBar(QuestFrame)
     set_ScrollBar(QuestProgressScrollFrame)
     set_ScrollBar(QuestDetailScrollFrame)

     set_NineSlice(QuestLogPopupDetailFrame, true)
     set_Alpha_Color(QuestLogPopupDetailFrameBg)
     hide_Frame_Texture(QuestLogPopupDetailFrameInset)
     set_ScrollBar(QuestLogPopupDetailFrameScrollFrame)
     set_NineSlice(QuestLogPopupDetailFrameInset, nil, true)

     set_Alpha_Frame_Texture(QuestModelScene)
     set_Alpha_Color(QuestNPCModelTextFrameBg, nil, nil, min05)
     set_ScrollBar(QuestNPCModelTextScrollChildFrame)
     --[[set_NineSlice(QuestLogPopupDetailFrame, true)
     set_Alpha_Color(QuestLogPopupDetailFrameBg)
     hide_Frame_Texture(QuestLogPopupDetailFrameInset)
     set_ScrollBar(QuestLogPopupDetailFrameScrollFrame)
     set_NineSlice(QuestLogPopupDetailFrameInset, nil, true)

     set_Alpha_Color(QuestNPCModelTopBg)
     hide_Texture(QuestNPCModelBg)
     
     set_Alpha_Color(QuestNPCModelTopBg)]]

     --信箱
          set_NineSlice(MailFrame, true)
     set_Alpha_Color(MailFrameBg)
     hide_Texture(InboxFrameBg)
     hide_Texture(MailFrameInset.Bg)
     set_NineSlice(OpenMailFrame, true)
     set_Alpha_Color(OpenMailFrameBg)
     set_Alpha_Color(OpenMailFrameInset.Bg)

     set_Alpha_Frame_Texture(MailFrameTab1, {alpha=min05})
     set_Alpha_Frame_Texture(MailFrameTab2, {alpha=min05})

     SendMailBodyEditBox:HookScript('OnEditFocusLost', function()
         set_Alpha_Color(SendStationeryBackgroundLeft)
         set_Alpha_Color(SendStationeryBackgroundRight)
     end)
     SendMailBodyEditBox:HookScript('OnEditFocusGained', function()
         if SendStationeryBackgroundLeft then
             SendStationeryBackgroundLeft:SetAlpha(1)
             SendStationeryBackgroundLeft:SetVertexColor(1,1,1)
             SendStationeryBackgroundRight:SetAlpha(1)
             SendStationeryBackgroundRight:SetVertexColor(1,1,1)
         end
     end)
     set_Alpha_Color(SendStationeryBackgroundLeft)
     set_Alpha_Color(SendStationeryBackgroundRight)

     --set_Alpha_Color(SendMailMoneyBgMiddle)
     --set_Alpha_Color(SendMailMoneyBgRight)
     --set_Alpha_Color(SendMailMoneyBgLeft)
     hide_Texture(SendMailMoneyInset.Bg)
     set_NineSlice(MailFrameInset, true)
     set_ScrollBar(SendMailScrollFrame)

     set_ScrollBar(OpenMailScrollFrame)

     --拾取, 历史
     set_NineSlice(GroupLootHistoryFrame, true)
     set_Alpha_Color(GroupLootHistoryFrameBg)
     set_ScrollBar(GroupLootHistoryFrame)
     set_Alpha_Color(GroupLootHistoryFrameMiddle)
     set_Alpha_Color(GroupLootHistoryFrameLeft)
     set_Alpha_Color(GroupLootHistoryFrameRight)
     set_Menu(GroupLootHistoryFrame.EncounterDropDown)
     set_Alpha_Frame_Texture(GroupLootHistoryFrame.ResizeButton, {alpha=min05})




     --频道, 设置
     set_NineSlice(ChatConfigCategoryFrame,true)
     set_NineSlice(ChatConfigBackgroundFrame,true)
     set_NineSlice(ChatConfigChatSettingsLeft, true)
     hide_Texture(ChatConfigBackgroundFrame.NineSlice.Center)
     hide_Texture(ChatConfigCategoryFrame.NineSlice.Center)
     hide_Texture(ChatConfigChatSettingsLeft.NineSlice.Center)

     set_ScrollBar(ChatConfigCombatSettingsFilters)

     set_Alpha_Color(ChatConfigFrame.Border, nil, nil, min03)
     set_Alpha_Color(ChatConfigFrame.Header.RightBG, true)
     set_Alpha_Color(ChatConfigFrame.Header.LeftBG, true)
     set_Alpha_Color(ChatConfigFrame.Header.CenterBG, true)


     for i= 1, 5 do
        set_Alpha_Frame_Texture(_G['CombatConfigTab'..i], {alpha=min05})
     end

     hooksecurefunc('ChatConfig_CreateCheckboxes', function(frame)--ChatConfigFrame.lua
        if frame.NineSlice then
            hide_Texture(frame.NineSlice.TopEdge)
            hide_Texture(frame.NineSlice.BottomEdge)
            hide_Texture(frame.NineSlice.RightEdge)
            hide_Texture(frame.NineSlice.LeftEdge)
            hide_Texture(frame.NineSlice.TopLeftCorner)
            hide_Texture(frame.NineSlice.TopRightCorner)
            hide_Texture(frame.NineSlice.BottomLeftCorner)
            hide_Texture(frame.NineSlice.BottomRightCorner)
            hide_Texture(frame.NineSlice.Center)
        end
        local checkBoxNameString = frame:GetName().."CheckBox";
        for index, _ in ipairs(frame.checkBoxTable) do
            local checkBox = _G[checkBoxNameString..index];
            if checkBox and checkBox.NineSlice then
                hide_Texture(checkBox.NineSlice.TopEdge)
                hide_Texture(checkBox.NineSlice.RightEdge)
                hide_Texture(checkBox.NineSlice.LeftEdge)
                hide_Texture(checkBox.NineSlice.TopRightCorner)
                hide_Texture(checkBox.NineSlice.TopLeftCorner)
                hide_Texture(checkBox.NineSlice.BottomRightCorner)
                hide_Texture(checkBox.NineSlice.BottomLeftCorner)
            end
        end
    end)
    hooksecurefunc('ChatConfig_UpdateCheckboxes', function(frame)--频道颜色设置 ChatConfigFrame.lua
        if not FCF_GetCurrentChatFrame() then
            return
        end
        local checkBoxNameString = frame:GetName().."CheckBox";
        for index, value in ipairs(frame.checkBoxTable) do
            if value and value.type then
                local r, g, b = GetMessageTypeColor(value.type)
                if r and g and b then
                    if _G[checkBoxNameString..index.."CheckText"] then
                        _G[checkBoxNameString..index.."CheckText"]:SetTextColor(r,g,b)
                    end
                    local checkBox = _G[checkBoxNameString..index]
                    if checkBox and checkBox.NineSlice and checkBox.NineSlice.BottomEdge then
                        checkBox.NineSlice.BottomEdge:SetVertexColor(r,g,b)
                    end
                end
            end
        end
    end)

     --插件，管理
     set_NineSlice(AddonList,true)
     set_ScrollBar(AddonList)
     set_Alpha_Color(AddonListBg)
     set_Alpha_Color(AddonListInset.Bg, nil, nil, min03)
     set_Menu(AddonCharacterDropDown)

     --场景 Blizzard_ScenarioObjectiveTracker.lua
     hooksecurefunc('Scenario_ChallengeMode_ShowBlock', function()--Blizzard_ScenarioObjectiveTracker.lua
        set_Alpha_Frame_Texture(ScenarioChallengeModeBlock, {alpha=min05})
     end)
     set_Alpha_Color(ScenarioStageBlock.NormalBG, nil, nil, min05)
     --[[if ObjectiveTrackerBlocksFrame then
         set_Alpha_Color(ObjectiveTrackerBlocksFrame.ScenarioHeader.Background)
         set_Alpha_Color(ObjectiveTrackerBlocksFrame.AchievementHeader.Background)
         set_Alpha_Color(ObjectiveTrackerBlocksFrame.QuestHeader.Background)
         hooksecurefunc('ScenarioStage_UpdateOptionWidgetRegistration', function(stageBlock, widgetSetID)
             set_Alpha_Color(stageBlock.NormalBG, nil, true)
             set_Alpha_Color(stageBlock.FinalBG)
         end)
     end]]

     if MainStatusTrackingBarContainer then--货币，XP，追踪，最下面BAR
         hide_Texture(MainStatusTrackingBarContainer.BarFrameTexture)
     end

     --插件，菜单
     hide_Frame_Texture(AddonCompartmentFrame, {alpha= min03})
     set_Alpha_Color(AddonCompartmentFrame.Text, nil, nil, min03)
     C_Timer.After(2, function()
         AddonCompartmentFrame:HookScript('OnEnter', function(self)
             self.Text:SetAlpha(1)
         end)
         AddonCompartmentFrame:HookScript('OnLeave', function(self)
             set_Alpha_Color(self.Text, nil, nil, min03)
         end)
     end)


     hide_Texture(PlayerFrameAlternateManaBarBorder)
     hide_Texture(PlayerFrameAlternateManaBarLeftBorder)
     hide_Texture(PlayerFrameAlternateManaBarRightBorder)

     --小地图
     set_Alpha_Color(MinimapCompassTexture)
     set_Alpha_Frame_Texture(MinimapCluster.BorderTop)
     set_Alpha_Frame_Texture(GameTimeFrame)
     hide_Texture(MinimapCluster.Tracking.Background)
     set_Button_Alpha(MinimapCluster.Tracking.Button, {alpha= min03})

     --小队，背景
    set_Alpha_Frame_Texture(PartyFrame.Background, {alpha= min03})

     --任务，追踪柆
     hooksecurefunc('ObjectiveTracker_Initialize', function(self)
         for _, module in ipairs(self.MODULES) do
             set_Alpha_Color(module.Header.Background)
         end
     end)

     --社交，按钮
     set_Alpha_Color(QuickJoinToastButton.FriendsButton, nil, nil, min03)
     --set_Alpha_Color(QuickJoinToastButton.QueueButton, nil, nil, min03)
     set_Alpha_Frame_Texture(ChatFrameChannelButton, {alpha= min03})
     set_Alpha_Frame_Texture(ChatFrameMenuButton, {alpha= min03})
     set_Alpha_Frame_Texture(TextToSpeechButton, {alpha=min03})

     --[[hooksecurefunc('ObjectiveTracker_UpdateOpacity', function()
         --for _, module in ipairs(ObjectiveTrackerBlocksFrame.MODULES) do
           --  set_Alpha_Color(module.Header.Background)
         --end
     end)]]


     for i=1, NUM_CHAT_WINDOWS do
        local frame= _G["ChatFrame"..i]
        if frame then
            set_Alpha_Color(_G['ChatFrame'..i..'EditBoxMid'], nil, nil, min03)
            set_Alpha_Color(_G['ChatFrame'..i..'EditBoxLeft'], nil, nil, min03)
            set_Alpha_Color(_G['ChatFrame'..i..'EditBoxRight'], nil, nil, min03)
            set_ScrollBar(frame)
            set_Alpha_Frame_Texture(frame.ScrollToBottomButton, {notAlpha=true})
        end
     end




     --商人
     set_Alpha_Color(MerchantFrameLootFilterMiddle)
     set_Alpha_Color(MerchantFrameLootFilterLeft)
     set_Alpha_Color(MerchantFrameLootFilterRight)
     set_Alpha_Color(MerchantFrameBottomLeftBorder)
     set_Alpha_Frame_Texture(MerchantFrameTab1, {alpha=min05})
     set_Alpha_Frame_Texture(MerchantFrameTab2, {alpha=min05})
     set_ScrollBar(MerchantFrame)
     set_Alpha_Color(MerchantFrameBg)
     set_NineSlice(MerchantFrameInset, true)
     set_NineSlice(MerchantFrame, true)
     hide_Texture(MerchantFrameInset.Bg)
     set_Alpha_Color(MerchantMoneyInset.Bg)
     hide_Texture(MerchantMoneyBgMiddle)
     hide_Texture(MerchantMoneyBgLeft)
     hide_Texture(MerchantMoneyBgRight)
     set_Alpha_Color(MerchantExtraCurrencyBg)
     set_Alpha_Color(MerchantExtraCurrencyInset)
     hide_Texture(MerchantFrameBottomLeftBorder)

     C_Timer.After(2, function()
         if SpellFlyout and SpellFlyout.Background then--Spell Flyout
             hide_Texture(SpellFlyout.Background.HorizontalMiddle)
             hide_Texture(SpellFlyout.Background.End)
             hide_Texture(SpellFlyout.Background.VerticalMiddle)
         end


         for i=1, C_AddOns.GetNumAddOns() do
             if C_AddOns.GetAddOnEnableState(i)==2 then
                 local name=C_AddOns.GetAddOnInfo(i)
                 name= name:match('(.-)%-') or name
                 if name then
                     set_Alpha_Frame_Texture(_G['LibDBIcon10_'..name], {index=2})
                 end
             end
         end

         --商人, SellBuy.lua
         for i=1, MERCHANT_ITEMS_PER_PAGE do--math.max(MERCHANT_ITEMS_PER_PAGE, BUYBACK_ITEMS_PER_PAGE) do --MERCHANT_ITEMS_PER_PAGE = 10; BUYBACK_ITEMS_PER_PAGE = 12;
             set_Alpha_Color(_G['MerchantItem'..i..'SlotTexture'])
         end
         hide_Texture(MerchantBuyBackItemSlotTexture)
     end)

     set_Alpha_Color(StackSplitFrame.SingleItemSplitBackground, true)
     set_Alpha_Color(StackSplitFrame.MultiItemSplitBackground, true)


    --考古学 ArchaeologyProgressBar.xml
    if ArcheologyDigsiteProgressBar then
        set_Alpha_Color(ArcheologyDigsiteProgressBar.BarBorderAndOverlay, true)
        hide_Texture(ArcheologyDigsiteProgressBar.Shadow)
        ArcheologyDigsiteProgressBar.BarTitle:SetTextColor(e.Player.r, e.Player.g, e.Player.b)
        ArcheologyDigsiteProgressBar.BarTitle:SetShadowOffset(1, -1)
        hide_Texture(ArcheologyDigsiteProgressBar.BarBackground)
    end










    hooksecurefunc('CooldownFrame_Set', function(self, start, duration, enable)
        if enable and enable ~= 0 and start > 0 and duration > 0 then
            self:SetDrawEdge(true)--冷却动画的移动边缘绘制亮线
        end
    end)




    --颜色
    set_Alpha_Frame_Texture(ColorPickerFrame.Header, {alpha= min05})
    set_Alpha_Frame_Texture(ColorPickerFrame.Border, {alpha= min05})

    --编辑模式
    set_Menu(EditModeManagerFrame.LayoutDropdown.DropDownMenu)
    set_ScrollBar(EditModeManagerFrame.AccountSettings.SettingsContainer)
    set_Alpha_Frame_Texture(EditModeManagerFrame.Border, {alpha=min05})
    set_Alpha_Frame_Texture(EditModeManagerFrame.AccountSettings.SettingsContainer.BorderArt, {alpha=min05})
    set_Slider(EditModeManagerFrame.GridSpacingSlider)

    set_Alpha_Frame_Texture(BNToastFrame, {alpha=min05})


    hooksecurefunc(SettingsCategoryListButtonMixin, 'Init', function(self, initializer)--列表 Blizzard_CategoryList.lua
        set_Alpha_Frame_Texture(self.Button, {notAlpha=true})
    end)
    hooksecurefunc(SettingsCategoryListHeaderMixin, 'Init', function(self, initializer)
        set_Alpha_Color(self.Background, nil, nil, min05)
    end)
    hooksecurefunc(SettingsCheckBoxControlMixin, 'Init', function(self, initializer)
        set_Alpha_Frame_Texture(self.CheckBox, {notAlpha=true})
    end)

    hooksecurefunc(SettingsSliderControlMixin, 'Init', function(self, initializer)
        set_Slider(self.SliderWithSteppers)
    end)
    hooksecurefunc(SettingsDropDownControlMixin, 'Init', function(self, initializer)
        set_Menu(self.DropDown)
    end)
    hooksecurefunc(SettingsCheckBoxWithButtonControlMixin, 'Init', function(self, initializer)
        set_Alpha_Frame_Texture(self.CheckBox, {notAlpha=true})
        --set_Alpha_Frame_Texture(self.Button, {notAlpha=true})
    end)
    hooksecurefunc(SettingsCheckBoxSliderControlMixin, 'Init', function(self, initializer)--Blizzard_SettingControls.lua
        set_Alpha_Frame_Texture(self.CheckBox, {notAlpha=true})
        set_Slider(self.SliderWithSteppers)
    end)
    hooksecurefunc(SettingsCheckBoxDropDownControlMixin, 'Init', function(self, initializer)--Blizzard_SettingControls.lua
        set_Alpha_Frame_Texture(self.CheckBox, {notAlpha=true})
        set_Menu(self.DropDown)
    end)
    hooksecurefunc(KeyBindingFrameBindingTemplateMixin, 'Init', function(self, initializer)
        set_Alpha_Frame_Texture(self.Button1, {notAlpha=true})
        set_Alpha_Frame_Texture(self.Button2, {notAlpha=true})
    end)

    --ReportFrame
    set_Alpha_Frame_Texture(ReportFrame)
    set_Alpha_Frame_Texture(ReportFrame.Border)
    hide_Texture(ReportFrame.BottomInset)
    hide_Texture(ReportFrame.TopInset)
    set_Alpha_Frame_Texture(ReportFrame.CloseButton, {notAlpha=true})
    set_Menu(ReportFrame.ReportingMajorCategoryDropdown)
    set_ScrollBar(ReportFrame.Comment)

    set_Alpha_Frame_Texture(BattleTagInviteFrame.Border, {notAlpha=true})

    --就绪
    set_NineSlice(ReadyCheckListenerFrame, true)
    set_Alpha_Color(ReadyCheckListenerFrame.Bg, true)

    --团队 RolePoll.lua
    set_Alpha_Frame_Texture(RolePollPopup.Border, {notAlpha=true})

    --对话框
    set_Alpha_Frame_Texture(StaticPopup1.Border, {notAlpha=true})

    --ItemTextFrame
    set_NineSlice(ItemTextFrame, true)
    hide_Texture(ItemTextFrameBg)
    hide_Frame_Texture(ItemTextFrameInset)
    set_Alpha_Color(ItemTextMaterialTopLeft, nil, nil, min05)
    set_Alpha_Color(ItemTextMaterialTopRight, nil, nil, min05)
    set_Alpha_Color(ItemTextMaterialBotLeft, nil, nil, min05)
    set_Alpha_Color(ItemTextMaterialBotRight, nil, nil, min05)
    set_ScrollBar(ItemTextScrollFrame)
    set_NineSlice(ItemTextFrameInset, true)

    --试衣间
    set_NineSlice(DressUpFrame, true)
    set_Alpha_Color(DressUpFrameBg)
    hide_Texture(DressUpFrameInset.Bg)
    set_Alpha_Frame_Texture(DressUpFrameInset)
    set_Alpha_Color(DressUpFrame.ModelBackground, nil, nil, min05)
    set_Alpha_Frame_Texture(DressUpFrame.OutfitDetailsPanel, {alpha=min03})
    hide_Texture(DressUpFrame.OutfitDetailsPanel.BlackBackground)
    set_Menu(DressUpFrameOutfitDropDown)

    --插件，UIDropDownMenu
    if e.LibDD and e.LibDD.UIDropDownMenu_SetWidth then
        hooksecurefunc(e.LibDD, 'UIDropDownMenu_SetWidth', function(_, menu)
            set_Menu(menu)
        end)
    end
end























--#########
--事件, 透明
--#########
local function Init_Event(arg1)
    if arg1=='Blizzard_TrainerUI' then--专业训练师
        set_NineSlice(ClassTrainerFrame, true)
        hide_Texture(ClassTrainerFrameInset.Bg)
        hide_Texture(ClassTrainerFrameBg)

        hide_Texture(ClassTrainerFrameBottomInset.Bg)
        set_Menu(ClassTrainerFrameFilterDropDown)
        set_ScrollBar(ClassTrainerFrame)

    elseif arg1=='Blizzard_TimeManager' then--小时图，时间
        set_NineSlice(TimeManagerFrame, true)
        set_Alpha_Color(TimeManagerFrameBg)
        hide_Texture(TimeManagerFrameInset.Bg)
        set_SearchBox(TimeManagerAlarmMessageEditBox)
        e.Set_Label_Texture_Color(TimeManagerClockTicker, {type='FontString', alpha=1})--设置颜色
        --[[if e.Player.useColor then
            TimeManagerClockTicker:SetTextColor(e.Player.useColor.r, e.Player.useColor.g, e.Player.useColor.b)
        end]]
        --秒表

         --Blizzard_TimeManager.lua
         hide_Texture(StopwatchFrameBackgroundLeft)
         if StopwatchFrame then
             hide_Texture(select(2, StopwatchFrame:GetRegions()))
             hide_Texture(StopwatchTabFrameMiddle)
             hide_Texture(StopwatchTabFrameRight)
             hide_Texture(StopwatchTabFrameLeft)
         end

    elseif arg1=='Blizzard_ClassTalentUI' then--天赋
        set_Alpha_Color(ClassTalentFrame.TalentsTab.BottomBar)--下面
        set_NineSlice(ClassTalentFrame, true)
        set_Alpha_Color(ClassTalentFrameBg)--里面
        hide_Texture(ClassTalentFrame.TalentsTab.BlackBG)
        hooksecurefunc(ClassTalentFrame.TalentsTab, 'UpdateSpecBackground', function(self2)--Blizzard_ClassTalentTalentsTab.lua
            if self2.specBackgrounds then
                for _, background in ipairs(self2.specBackgrounds) do
                    hide_Texture(background)
                end
            end
        end)

        hide_Texture(ClassTalentFrame.SpecTab.Background)
        hide_Texture(ClassTalentFrame.SpecTab.BlackBG)
        hooksecurefunc(ClassTalentFrame.SpecTab, 'UpdateSpecContents', function(self2)--Blizzard_ClassTalentSpecTab.lua
            local numSpecs= self2.numSpecs
            if numSpecs and numSpecs>0 then
                for i = 1, numSpecs do
                    local contentFrame = self2.SpecContentFramePool:Acquire();
                    if contentFrame then
                        hide_Texture(contentFrame.HoverBackground)
                    end
                end
            end
        end)

        set_Alpha_Color(ClassTalentFrameMiddle)
        set_Alpha_Color(ClassTalentFrameLeft)
        set_Alpha_Color(ClassTalentFrameRight)
        set_SearchBox(ClassTalentFrame.TalentsTab.SearchBox)



        --TabSystemOwner.lua
        for _, tabID in pairs(ClassTalentFrame:GetTabSet() or {}) do
            local btn= ClassTalentFrame:GetTabButton(tabID)
            set_Alpha_Frame_Texture(btn, {alpha=min05})
        end


    elseif arg1=='Blizzard_AchievementUI' then--成就
        set_Alpha_Color(AchievementFrame.Header.PointBorder)
        hide_Texture(AchievementFrameSummary.Background)
        hide_Texture(AchievementFrameCategoriesBG)
        hide_Texture(AchievementFrameAchievements.Background)

        hide_Texture(AchievementFrameWaterMark)
        hide_Texture(AchievementFrameGuildEmblemRight)

        hide_Texture(AchievementFrame.BottomRightCorner)
        hide_Texture(AchievementFrame.BottomLeftCorner)
        hide_Texture(AchievementFrame.TopLeftCorner)
        hide_Texture(AchievementFrame.TopRightCorner)

        hide_Texture(AchievementFrame.BottomEdge)
        hide_Texture(AchievementFrame.TopEdge)
        hide_Texture(AchievementFrame.LeftEdge)
        hide_Texture(AchievementFrame.RightEdge)
        hide_Texture(AchievementFrame.Header.Right)
        hide_Texture(AchievementFrame.Header.Left)

        set_SearchBox(AchievementFrame.SearchBox)

        set_Alpha_Color(AchievementFrame.Background)
        set_Alpha_Color(AchievementFrameMetalBorderBottomLeft)
        set_Alpha_Color(AchievementFrameMetalBorderBottom)
        set_Alpha_Color(AchievementFrameMetalBorderBottomRight)
        set_Alpha_Color(AchievementFrameMetalBorderRight)
        set_Alpha_Color(AchievementFrameMetalBorderLeft)
        set_Alpha_Color(AchievementFrameMetalBorderTopLeft)
        set_Alpha_Color(AchievementFrameMetalBorderTop)
        set_Alpha_Color(AchievementFrameMetalBorderTopRight)

        set_Alpha_Color(AchievementFrameWoodBorderBottomLeft)
        set_Alpha_Color(AchievementFrameWoodBorderBottomRight)
        set_Alpha_Color(AchievementFrameWoodBorderTopLeft)
        set_Alpha_Color(AchievementFrameWoodBorderTopRight)

        hide_Texture(AchievementFrameSummaryCategoriesStatusBarFillBar)
        for i=1, 10 do
            hide_Texture(_G['AchievementFrameCategoriesCategory'..i..'Bar'])
        end
        if AchievementFrameStatsBG then
            AchievementFrameStatsBG:Hide()
        end
        set_Alpha_Color(AchievementFrame.Header.LeftDDLInset)
        set_Alpha_Color(AchievementFrame.Header.RightDDLInset)
        hooksecurefunc(AchievementTemplateMixin, 'Init', function(self)
            if self.Icon then
                hide_Texture(self.Icon.frame)
            end
        end)
        set_ScrollBar(AchievementFrameAchievements)
        set_ScrollBar(AchievementFrameStats)
        set_ScrollBar(AchievementFrameCategories)
        set_Alpha_Frame_Texture(AchievementFrameTab1, {alpha=min05})
        set_Alpha_Frame_Texture(AchievementFrameTab2, {alpha=min05})
        set_Alpha_Frame_Texture(AchievementFrameTab3, {alpha=min05})

        set_NineSlice(AchievementFrameCategories)
        hide_Texture(AchievementFrame.BackgroundBlackCover)

    elseif arg1=='Blizzard_Communities' then--公会和社区
        set_NineSlice(CommunitiesFrame, true)
        set_ScrollBar(CommunitiesFrameCommunitiesList)
        set_ScrollBar(CommunitiesFrame.Chat)
        set_ScrollBar(CommunitiesFrame.MemberList)
        set_ScrollBar(CommunitiesFrame.GuildBenefitsFrame.Rewards)
        set_ScrollBar(CommunitiesFrameGuildDetailsFrameNews)
        set_ScrollBar(ClubFinderCommunityAndGuildFinderFrame.CommunityCards)

        set_Alpha_Color(CommunitiesFrameBg)
        set_Alpha_Color(CommunitiesFrame.MemberList.ColumnDisplay.Background)
        set_Alpha_Color(CommunitiesFrameCommunitiesList.Bg)
        set_Alpha_Color(CommunitiesFrameInset.Bg, nil, nil, min03)
        set_NineSlice(CommunitiesFrameInset, nil, true)
        set_NineSlice(CommunitiesFrameCommunitiesList.InsetFrame, true)
        CommunitiesFrame.GuildBenefitsFrame.Perks:DisableDrawLayer('BACKGROUND')
        CommunitiesFrameGuildDetailsFrameInfo:DisableDrawLayer('BACKGROUND')
        CommunitiesFrameGuildDetailsFrameNews:DisableDrawLayer('BACKGROUND')

        set_SearchBox(CommunitiesFrame.ChatEditBox)
        set_NineSlice(CommunitiesFrame.Chat.InsetFrame, true)
        set_NineSlice(CommunitiesFrame.MemberList.InsetFrame, true)
        set_Alpha_Color(CommunitiesFrameMiddle)

        set_NineSlice(ClubFinderCommunityAndGuildFinderFrame.InsetFrame, nil, true)
        hide_Texture(CommunitiesFrame.GuildBenefitsFrame.Rewards.Bg)

        hooksecurefunc(CommunitiesFrameCommunitiesList,'UpdateCommunitiesList',function(self)
            C_Timer.After(0.3, function()
                for _, button in pairs(CommunitiesFrameCommunitiesList.ScrollBox:GetFrames()) do
                set_Alpha_Color(button.Background)
                end
            end)
        end)

        set_Alpha_Color(ClubFinderCommunityAndGuildFinderFrame.InsetFrame.Bg)

        hide_Frame_Texture(CommunitiesFrame.ChatTab, {index=1})
        hide_Frame_Texture(CommunitiesFrame.RosterTab, {index=1})
        hide_Frame_Texture(CommunitiesFrame.GuildBenefitsTab, {index=1})
        hide_Frame_Texture(CommunitiesFrame.GuildInfoTab, {index=1})
        set_Menu(CommunitiesFrame.StreamDropDownMenu)
        set_Alpha_Frame_Texture(CommunitiesFrame.AddToChatButton, {notAlpha=true})

        hide_Frame_Texture(ClubFinderCommunityAndGuildFinderFrame.ClubFinderSearchTab, {index=1})
        hide_Frame_Texture(ClubFinderCommunityAndGuildFinderFrame.ClubFinderPendingTab, {index=1})

        set_Alpha_Color(ClubFinderGuildFinderFrame.InsetFrame.Bg)

        set_Alpha_Frame_Texture(CommunitiesFrame.NotificationSettingsDialog.Selector)
        set_ScrollBar(CommunitiesFrame.NotificationSettingsDialog.ScrollFrame)
        set_Alpha_Color(CommunitiesFrame.NotificationSettingsDialog.BG, {notAlpha=true})
        set_Menu(CommunitiesFrame.NotificationSettingsDialog.CommunitiesListDropDownMenu)

        set_Alpha_Frame_Texture(GuildControlUI)
        set_Alpha_Frame_Texture(GuildControlUIHbar)
        set_Menu(GuildControlUINavigationDropDown)

        set_Menu(CommunitiesFrame.GuildMemberListDropDownMenu)

        set_Alpha_Frame_Texture(CommunitiesGuildLogFrame)
        set_NineSlice(CommunitiesGuildLogFrame.Container, true)
        set_ScrollBar(CommunitiesGuildLogFrame.Container.ScrollFrame)
        set_Menu(CommunitiesFrame.CommunitiesListDropDownMenu)


    elseif arg1=='Blizzard_PVPUI' then--地下城和团队副本, PVP
        hide_Texture(HonorFrame.Inset.Bg)
        hide_Texture(HonorFrame.BonusFrame.ShadowOverlay)
        hide_Texture(HonorFrame.BonusFrame.WorldBattlesTexture)
        set_NineSlice(HonorFrame.Inset, nil, true)
        set_Alpha_Color(HonorFrame.BonusFrame.WorldBattlesTexture)
        hide_Texture(HonorFrame.ConquestBar.Background)

        set_NineSlice(PVPQueueFrame.HonorInset, nil, true)--最右边

        set_NineSlice(ConquestFrame.Inset, nil, true)--中间
        hide_Texture(ConquestFrame.Inset.Bg)
        hide_Texture(ConquestFrameLeft)
        hide_Texture(ConquestFrameRight)
        hide_Texture(ConquestFrameTopRight)
        hide_Texture(ConquestFrameTop)
        hide_Texture(ConquestFrameTopLeft)
        hide_Texture(ConquestFrameBottomLeft)
        hide_Texture(ConquestFrameBottom)
        hide_Texture(ConquestFrameBottomRight)

        set_Alpha_Color(ConquestFrame.RatedBGTexture)
        PVPQueueFrame.HonorInset:DisableDrawLayer('BACKGROUND')
        set_Alpha_Color(PVPQueueFrame.HonorInset.CasualPanel.HonorLevelDisplay.Background)
        set_Menu(HonorFrameTypeDropDown)
        hide_Texture(ConquestFrame.RatedBGTexture)
        set_ScrollBar(LFDQueueFrameSpecific)


    elseif arg1=='Blizzard_EncounterJournal' then--冒险指南
        set_NineSlice(EncounterJournal, true)

        hide_Texture(EncounterJournalBg)
        set_Alpha_Color(EncounterJournalInset.Bg, nil, nil, min03)
        set_NineSlice(EncounterJournalInset, nil, true)
        set_Alpha_Color(EncounterJournalInstanceSelectBG)
        set_ScrollBar(EncounterJournalInstanceSelect)
        set_SearchBox(EncounterJournalSearchBox)
        set_ScrollBar(EncounterJournal.LootJournalItems.ItemSetsFrame)
        set_ScrollBar(EncounterJournalEncounterFrameInfo.LootContainer)
        set_ScrollBar(EncounterJournalEncounterFrameInfoDetailsScrollFrame)
        hide_Texture(EncounterJournalNavBar.overlay)
        hide_Texture(EncounterJournalNavBarInsetBottomBorder)
        hide_Texture(EncounterJournalNavBarInsetRightBorder)
        hide_Texture(EncounterJournalNavBarInsetLeftBorder)
        hide_Texture(EncounterJournalNavBarInsetBotRightCorner)
        hide_Texture(EncounterJournalNavBarInsetBotLeftCorner)


        set_Alpha_Color(EncounterJournalEncounterFrameInfoModelFrameDungeonBG)
        EncounterJournalNavBar:DisableDrawLayer('BACKGROUND')

        set_Menu(EncounterJournalInstanceSelectTierDropDown)


        C_Timer.After(0.3, function()
            if EncounterJournalMonthlyActivitiesFrame then
                set_Alpha_Color(EncounterJournalMonthlyActivitiesFrame.Bg)
            end
            set_ScrollBar(EncounterJournalMonthlyActivitiesFrame)
        end)

        set_Alpha_Frame_Texture(EncounterJournalSuggestTab, {alpha=min05})
        set_Alpha_Frame_Texture(EncounterJournalMonthlyActivitiesTab, {alpha=min05})
        set_Alpha_Frame_Texture(EncounterJournalDungeonTab, {alpha=min05})
        set_Alpha_Frame_Texture(EncounterJournalRaidTab, {alpha=min05})
        set_Alpha_Frame_Texture(EncounterJournalLootJournalTab, {alpha=min05})
        set_Menu(EncounterJournalLootJournalViewDropDown)


        set_ScrollBar(EncounterJournalEncounterFrameInfo.BossesScrollBar)
        set_ScrollBar(EncounterJournalEncounterFrameInstanceFrame.LoreScrollBar)
        set_ScrollBar(EncounterJournal.LootJournal)

    elseif arg1=="Blizzard_GuildBankUI" then--公会银行
        set_Alpha_Color(GuildBankFrame.BlackBG)
        hide_Texture(GuildBankFrame.TitleBg)
        hide_Texture(GuildBankFrame.RedMarbleBG)
        set_Alpha_Color(GuildBankFrame.MoneyFrameBG)

        set_Alpha_Color(GuildBankFrame.TabLimitBG)
        set_Alpha_Color(GuildBankFrame.TabLimitBGLeft)
        set_Alpha_Color(GuildBankFrame.TabLimitBGRight)
        set_SearchBox(GuildItemSearchBox)

        set_Alpha_Color(GuildBankFrame.TabTitleBG)
        set_Alpha_Color(GuildBankFrame.TabTitleBGLeft)
        set_Alpha_Color(GuildBankFrame.TabTitleBGRight)

        for i=1, 7 do
            local frame= GuildBankFrame['Column'..i]
            if frame then
                hide_Texture(frame.Background)
            end
            set_Alpha_Frame_Texture(_G['GuildBankFrameTab'..i], {alpha=min05})
        end

        local MAX_GUILDBANK_SLOTS_PER_TAB = 98;
        local NUM_SLOTS_PER_GUILDBANK_GROUP = 14;
        hooksecurefunc(GuildBankFrame,'Update', function(self)--Blizzard_GuildBankUI.lua
            if ( self.mode == "bank" ) then
                local tab = GetCurrentGuildBankTab() or 1
                for i=1, MAX_GUILDBANK_SLOTS_PER_TAB do
                    local index = mod(i, NUM_SLOTS_PER_GUILDBANK_GROUP);
                    if ( index == 0 ) then
                        index = NUM_SLOTS_PER_GUILDBANK_GROUP;
                    end
                    local column = ceil((i-0.5)/NUM_SLOTS_PER_GUILDBANK_GROUP);
                    local button = self.Columns[column].Buttons[index];
                    if button and button.NormalTexture then
                        local texture= GetGuildBankItemInfo(tab, i)
                        button.NormalTexture:SetAlpha(texture and 1 or 0.1)
                    end
                end
            end
        end)

        set_ScrollBar(GuildBankFrame.Log)
        set_ScrollBar(GuildBankInfoScrollFrame)

    elseif arg1=='Blizzard_AuctionHouseUI' then--拍卖行
        set_Alpha_Color(AuctionHouseFrameBg)
        set_NineSlice(AuctionHouseFrame, true)
        set_Alpha_Color(AuctionHouseFrameMiddle, nil, nil, min03)
        set_Alpha_Color(AuctionHouseFrameLeft, nil, nil, min03)
        set_Alpha_Color(AuctionHouseFrameRight, nil, nil, min03)

        set_Alpha_Frame_Texture(AuctionHouseFrameBuyTab, {alpha= min05})
        set_Alpha_Frame_Texture(AuctionHouseFrameSellTab, {alpha= min05})
        set_Alpha_Frame_Texture(AuctionHouseFrameAuctionsTab, {alpha= min05})
        set_Alpha_Frame_Texture(AuctionHouseFrame.SearchBar.FilterButton, {alpha= min05})

        set_NineSlice(AuctionHouseFrame.CategoriesList, nil, true)
        set_ScrollBar(AuctionHouseFrame.CategoriesList)
        hide_Texture(AuctionHouseFrame.CategoriesList.Background)

        set_ScrollBar(AuctionHouseFrameAuctionsFrame.BidsList)
        set_NineSlice(AuctionHouseFrameAuctionsFrame.BidsList, nil, true)
        set_NineSlice(AuctionHouseFrameAuctionsFrame.AllAuctionsList, nil, true)
        set_ScrollBar(AuctionHouseFrameAuctionsFrame.AllAuctionsList)
        set_ScrollBar(AuctionHouseFrameAuctionsFrame.SummaryList)
        set_NineSlice(AuctionHouseFrameAuctionsFrame.SummaryList, nil, true)


        set_NineSlice(AuctionHouseFrame.BrowseResultsFrame.ItemList, nil, true)
        set_ScrollBar(AuctionHouseFrame.BrowseResultsFrame.ItemList)

        set_NineSlice(AuctionHouseFrame.MoneyFrameInset, nil, true)
        hide_Texture(AuctionHouseFrame.MoneyFrameInset.Bg)
        hide_Frame_Texture(AuctionHouseFrame.MoneyFrameBorder)

        set_SearchBox(AuctionHouseFrame.SearchBar.SearchBox)


        set_NineSlice(AuctionHouseFrame.CommoditiesSellList, nil, true)
        set_ScrollBar(AuctionHouseFrame.CommoditiesSellList)
        set_NineSlice(AuctionHouseFrame.CommoditiesSellFrame, nil, true)
        set_Alpha_Frame_Texture(AuctionHouseFrame.CommoditiesSellFrame.ItemDisplay, {alpha=0})
        set_SearchBox(AuctionHouseFrame.CommoditiesSellFrame.QuantityInput.InputBox)
        set_SearchBox(AuctionHouseFrame.CommoditiesSellFrame.PriceInput.MoneyInputFrame.GoldBox)
        set_SearchBox(AuctionHouseFrame.CommoditiesSellFrame.PriceInput.MoneyInputFrame.SilverBox)
        set_Menu(AuctionHouseFrame.CommoditiesSellFrame.DurationDropDown.DropDown)
        set_Alpha_Color(AuctionHouseFrame.CommoditiesSellFrame.CreateAuctionTabMiddle, nil, nil, min05)
        set_Alpha_Color(AuctionHouseFrame.CommoditiesSellFrame.CreateAuctionTabLeft, nil, nil, min05)
        set_Alpha_Color(AuctionHouseFrame.CommoditiesSellFrame.CreateAuctionTabRight, nil, nil, min05)

        set_NineSlice(AuctionHouseFrame.ItemSellList, nil, true)
        set_ScrollBar(AuctionHouseFrame.ItemSellList)
        set_NineSlice(AuctionHouseFrame.ItemSellFrame, nil, true)
        set_Alpha_Frame_Texture(AuctionHouseFrame.ItemSellFrame.ItemDisplay, {alpha=0})
        set_SearchBox(AuctionHouseFrame.ItemSellFrame.QuantityInput.InputBox)
        set_SearchBox(AuctionHouseFrame.ItemSellFrame.PriceInput.MoneyInputFrame.GoldBox)
        set_SearchBox(AuctionHouseFrame.ItemSellFrame.PriceInput.MoneyInputFrame.SilverBox)
        set_Menu(AuctionHouseFrame.ItemSellFrame.DurationDropDown.DropDown)
        set_Alpha_Color(AuctionHouseFrame.ItemSellFrame.CreateAuctionTabMiddle, nil, nil, min05)
        set_Alpha_Color(AuctionHouseFrame.ItemSellFrame.CreateAuctionTabLeft, nil, nil, min05)
        set_Alpha_Color(AuctionHouseFrame.ItemSellFrame.CreateAuctionTabRight, nil, nil, min05)

        --拍卖，所在物品，页面
        set_SearchBox(AuctionHouseFrameAuctionsFrameBidsTab)
        set_SearchBox(AuctionHouseFrameAuctionsFrameAuctionsTab)
        set_Alpha_Frame_Texture(AuctionHouseFrameAuctionsFrameGold, {alpha=min05})
        set_Alpha_Frame_Texture(AuctionHouseFrameAuctionsFrameSilver, {alpha=min05})
        set_NineSlice(AuctionHouseFrameAuctionsFrame.ItemDisplay, nil, true)
        set_NineSlice(AuctionHouseFrameAuctionsFrame.CommoditiesList, nil, true)

        --时光
        set_ScrollBar(AuctionHouseFrame.WoWTokenResults.DummyScrollBar)
        set_NineSlice(AuctionHouseFrame.WoWTokenResults, nil, true)
        --购买
        set_NineSlice(AuctionHouseFrame.ItemBuyFrame.ItemDisplay, nil, true)
        set_ScrollBar(AuctionHouseFrame.ItemBuyFrame.ItemList)
        set_NineSlice(AuctionHouseFrame.ItemBuyFrame.ItemList, nil, true)

    elseif arg1=='Blizzard_ProfessionsCustomerOrders' then--专业定制
        set_NineSlice(ProfessionsCustomerOrdersFrame, true)

        set_SearchBox(ProfessionsCustomerOrdersFrame.BrowseOrders.SearchBar.SearchBox)

        set_Alpha_Color(ProfessionsCustomerOrdersFrameMiddleMiddle)
        set_Alpha_Color(ProfessionsCustomerOrdersFrameMiddleLeft)
        set_Alpha_Color(ProfessionsCustomerOrdersFrameMiddleRight)
        set_Alpha_Color(ProfessionsCustomerOrdersFrame.BrowseOrders.CategoryList.Background)

        set_Alpha_Color(ProfessionsCustomerOrdersFrame.Form.LeftPanelBackground.Background)
        set_Alpha_Color(ProfessionsCustomerOrdersFrame.Form.RightPanelBackground.Background)

        hide_Texture(ProfessionsCustomerOrdersFrame.MoneyFrameInset.Bg)
        set_Alpha_Color(ProfessionsCustomerOrdersFrameLeft)
        set_Alpha_Color(ProfessionsCustomerOrdersFrameMiddle)
        set_Alpha_Color(ProfessionsCustomerOrdersFrameRight)

        set_NineSlice(ProfessionsCustomerOrdersFrame.BrowseOrders.CategoryList, nil, true)
        set_NineSlice(ProfessionsCustomerOrdersFrame.BrowseOrders.RecipeList, nil, true)
        set_ScrollBar(ProfessionsCustomerOrdersFrame.BrowseOrders.CategoryList)
        set_ScrollBar(ProfessionsCustomerOrdersFrame.BrowseOrders.RecipeList)
        set_Alpha_Frame_Texture(ProfessionsCustomerOrdersFrameBrowseTab, {alpha=min05})
        set_Alpha_Frame_Texture(ProfessionsCustomerOrdersFrameOrdersTab, {alpha=min05})

        set_NineSlice(ProfessionsCustomerOrdersFrame.MyOrdersPage.OrderList, nil, true)
        set_ScrollBar(ProfessionsCustomerOrdersFrame.MyOrdersPage.OrderList)

        set_NineSlice(ProfessionsCustomerOrdersFrame.Form.CurrentListings, true)
        set_ScrollBar(ProfessionsCustomerOrdersFrame.Form.CurrentListings.OrderList)
        hide_Texture(ProfessionsCustomerOrdersFrameBg)

        set_NineSlice(ProfessionsCustomerOrdersFrame.Form.LeftPanelBackground, true)
        set_NineSlice(ProfessionsCustomerOrdersFrame.Form.RightPanelBackground, true)

    elseif arg1=='Blizzard_BlackMarketUI' then--黑市
        set_Alpha_Color(BlackMarketFrameTitleBg)
        set_Alpha_Color(BlackMarketFrameBg)
        set_Alpha_Color(BlackMarketFrame.LeftBorder)
        set_Alpha_Color(BlackMarketFrame.RightBorder)
        set_Alpha_Color(BlackMarketFrame.BottomBorder)
        set_ScrollBar(BlackMarketFrame)

    elseif arg1=='Blizzard_Collections' then--收藏
        set_NineSlice(CollectionsJournal, true)
        set_Alpha_Color(CollectionsJournalBg)

        set_Alpha_Frame_Texture(MountJournal.MountCount, {alpha=min03})
        hide_Texture(MountJournal.LeftInset.Bg)
        set_Alpha_Color(MountJournal.MountDisplay.YesMountsTex)
        hide_Texture(MountJournal.RightInset.Bg)
        set_Alpha_Color(MountJournal.BottomLeftInset.Background)
        hide_Texture(MountJournal.BottomLeftInset.Bg)
        set_ScrollBar(MountJournal)
        set_SearchBox(MountJournalSearchBox)
        set_NineSlice(MountJournal.BottomLeftInset, nil, true)
        set_NineSlice(MountJournal.RightInset, nil, true)
        set_NineSlice(MountJournal.LeftInset, nil, true)
        set_Alpha_Frame_Texture(MountJournalFilterButton, {alpha=min03})

        set_Alpha_Color(PetJournalPetCardBG, nil, nil, min03)
        set_Alpha_Color(PetJournalPetCardInset.Bg)
        set_Alpha_Color(PetJournalRightInset.Bg)
        set_Alpha_Color(PetJournalLoadoutPet1BG, nil, nil, min03)
        set_Alpha_Color(PetJournalLoadoutPet2BG, nil, nil, min03)
        set_Alpha_Color(PetJournalLoadoutPet3BG, nil, nil, min03)
        set_Alpha_Color(PetJournalLoadoutBorderSlotHeaderBG)
        hide_Texture(PetJournalLeftInset.Bg)
        hide_Texture(PetJournalLoadoutBorder)

        set_ScrollBar(PetJournal)
        set_SearchBox(PetJournalSearchBox)

        set_Alpha_Color(PetJournal.PetCount.BorderTopMiddle, nil, nil, min03)
        set_Alpha_Color(PetJournal.PetCount.Bg, nil, nil, min03)
        set_Alpha_Color(PetJournal.PetCount.BorderBottomMiddle, nil, nil, min03)
        set_Alpha_Color(PetJournal.PetCount.BorderTopRightMiddle, nil, nil, min03)
        set_Alpha_Color(PetJournal.PetCount.BorderTopLeftMiddle, nil, nil, min03)
        set_Alpha_Color(PetJournal.PetCount.BorderBottomLeft, nil, nil, min03)
        set_Alpha_Color(PetJournal.PetCount.BorderTopLeft, nil, nil, min03)
        set_Alpha_Color(PetJournal.PetCount.BorderBottomRight, nil, nil, min03)
        set_Alpha_Color(PetJournal.PetCount.BorderTopRight, nil, nil, min03)
        set_Alpha_Color(PetJournal.PetCount.BorderLeftMiddle, nil, nil, min03)
        set_Alpha_Color(PetJournal.PetCount.BorderRightMiddle, nil, nil, min03)
        set_Alpha_Frame_Texture(PetJournalFilterButton, {alpha=min03})
        set_NineSlice(PetJournalLeftInset, nil, true)
        set_NineSlice(PetJournalPetCardInset, nil, true)
        set_NineSlice(PetJournalRightInset, nil, true)


        hide_Texture(ToyBox.iconsFrame.BackgroundTile)
        hide_Texture(ToyBox.iconsFrame.Bg)
        set_SearchBox(ToyBox.searchBo)
        set_SearchBox(ToyBox.searchBox)
        set_Alpha_Frame_Texture(ToyBoxFilterButton, {alpha=min03})
        hide_Texture(ToyBox.iconsFrame.ShadowLineTop)
        hide_Texture(ToyBox.iconsFrame.ShadowLineBottom)

        set_NineSlice(ToyBox.iconsFrame, nil, true)
        ToyBox.progressBar:DisableDrawLayer('BACKGROUND')


        set_Menu(HeirloomsJournalClassDropDown)
        hide_Texture(HeirloomsJournal.iconsFrame.BackgroundTile)
        hide_Texture(HeirloomsJournal.iconsFrame.Bg)
        set_SearchBox(HeirloomsJournalSearchBox)
        set_Alpha_Color(HeirloomsJournalMiddleMiddle)
        set_Alpha_Color(HeirloomsJournalMiddleLeft)
        set_Alpha_Color(HeirloomsJournalMiddleRight)
        set_Alpha_Color(HeirloomsJournalBottomMiddle)
        set_Alpha_Color(HeirloomsJournalTopMiddle)
        set_Alpha_Color(HeirloomsJournalBottomLeft)
        set_Alpha_Color(HeirloomsJournalBottomRight)
        set_Alpha_Color(HeirloomsJournalTopLeft)
        set_Alpha_Color(HeirloomsJournalTopRight)
        hide_Texture(HeirloomsJournal.iconsFrame.ShadowLineBottom)
        hide_Texture(HeirloomsJournal.iconsFrame.ShadowLineTop)
        set_NineSlice(HeirloomsJournal.iconsFrame, nil, true)
        HeirloomsJournal.progressBar:DisableDrawLayer('BACKGROUND')
        set_Alpha_Frame_Texture(HeirloomsJournal.FilterButton, {alpha=min03})

        hide_Texture(WardrobeCollectionFrame.ItemsCollectionFrame.ShadowLineBottom)
        hide_Texture(WardrobeCollectionFrame.ItemsCollectionFrame.ShadowLineTop)
        set_NineSlice(WardrobeCollectionFrame.ItemsCollectionFrame, nil, true)
        hide_Texture(WardrobeCollectionFrame.ItemsCollectionFrame.BackgroundTile)
        hide_Texture(WardrobeCollectionFrame.ItemsCollectionFrame.Bg)
        hide_Texture(WardrobeCollectionFrame.ItemsCollectionFrame.ShadowLineTop)

        hide_Texture(WardrobeCollectionFrame.SetsCollectionFrame.RightInset.BackgroundTile)
        hide_Texture(WardrobeCollectionFrame.SetsCollectionFrame.RightInset.Bg)
        hide_Texture(WardrobeCollectionFrame.SetsCollectionFrame.LeftInset.Bg)
        set_ScrollBar(WardrobeCollectionFrame.SetsCollectionFrame.ListContainer)
        hide_Texture(WardrobeCollectionFrame.SetsCollectionFrame.RightInset.ShadowLineTop)
        hide_Texture(WardrobeCollectionFrame.SetsCollectionFrame.RightInset.BGCornerBottomRight)
        hide_Texture(WardrobeCollectionFrame.SetsCollectionFrame.RightInset.BGCornerBottomLeft)
        set_NineSlice(WardrobeCollectionFrame.SetsCollectionFrame.RightInset, nil, true)
        hide_Texture(WardrobeCollectionFrame.SetsCollectionFrame.RightInset.ShadowLineBottom)
        set_NineSlice(WardrobeCollectionFrame.SetsCollectionFrame.LeftInset, nil, true)

        set_SearchBox(WardrobeCollectionFrameSearchBox)
        set_Alpha_Color(WardrobeCollectionFrameMiddleMiddle)
        set_Alpha_Color(WardrobeCollectionFrameTopMiddle)
        set_Alpha_Color(WardrobeCollectionFrameBottomMiddle)
        set_Alpha_Color(WardrobeCollectionFrameTopMiddle)
        set_Alpha_Color(WardrobeCollectionFrameMiddleLeft)
        set_Alpha_Color(WardrobeCollectionFrameMiddleRight)
        set_Alpha_Color(WardrobeCollectionFrameTopLeft)
        set_Alpha_Color(WardrobeCollectionFrameBottomLeft)
        set_Alpha_Color(WardrobeCollectionFrameBottomRight)
        set_Alpha_Color(WardrobeCollectionFrameTopLeft)
                 --WardrobeCollectionFrameBottomRight

        set_Alpha_Frame_Texture(WardrobeCollectionFrame.FilterButton, {alpha=min03})
        set_Alpha_Frame_Texture(WardrobeSetsCollectionVariantSetsButton, {alpha=min03})


        --[[set_Alpha_Color(WardrobeSetsCollectionVariantSetsButtonMiddleMiddle, nil, nil, min03)
        set_Alpha_Color(WardrobeSetsCollectionVariantSetsButtonBottomMiddle, nil, nil, min03)
        set_Alpha_Color(WardrobeSetsCollectionVariantSetsButtonTopMiddle, nil, nil, min03)
        set_Alpha_Color(WardrobeSetsCollectionVariantSetsButtonMiddleLeft)
        set_Alpha_Color(WardrobeSetsCollectionVariantSetsButtonMiddleRight)
        set_Alpha_Color(WardrobeSetsCollectionVariantSetsButtonTopLeft)
        set_Alpha_Color(WardrobeSetsCollectionVariantSetsButtonBottomLeft)
        set_Alpha_Color(WardrobeSetsCollectionVariantSetsButtonTopRight)
        set_Alpha_Color(WardrobeSetsCollectionVariantSetsButtonBottomRight)]]
        hide_Texture(WardrobeCollectionFrame.SetsCollectionFrame.DetailsFrame.ModelFadeTexture)

        set_Alpha_Frame_Texture(WardrobeCollectionFrameTab1, {alpha=min05})
        set_Alpha_Frame_Texture(WardrobeCollectionFrameTab2, {alpha=min05})
        --[[hooksecurefunc(WardrobeSetsScrollFrameButtonMixin, 'Init', function(button, displayData)--外观列表
            set_Alpha_Color(button.Background)
        end)]]

        --试衣间
        set_NineSlice(WardrobeFrame, true)
        hide_Texture(WardrobeFrameBg)
        hide_Texture(WardrobeTransmogFrame.Inset.Bg)
        set_Alpha_Color(WardrobeTransmogFrame.Inset.BG)
        hide_Texture(WardrobeCollectionFrame.SetsTransmogFrame.BackgroundTile)
        set_Alpha_Color(WardrobeCollectionFrame.SetsTransmogFrame.Bg)
        set_Menu(WardrobeOutfitDropDown)

        set_Alpha_Color(WardrobeTransmogFrame.MoneyMiddle)
        set_Alpha_Color(WardrobeTransmogFrame.MoneyLeft)
        set_Alpha_Color(WardrobeTransmogFrame.MoneyRight)
        for v=1,4 do
            for h= 1, 2 do
                local button= WardrobeCollectionFrame.SetsTransmogFrame['ModelR'..h..'C'..v]
                if button then
                    button:DisableDrawLayer('BACKGROUND')
                end
            end
        end
        WardrobeCollectionFrame.progressBar:DisableDrawLayer('BACKGROUND')
        set_Menu(WardrobeCollectionFrameWeaponDropDown)

        for i=1, 7 do
            set_Alpha_Frame_Texture(_G['CollectionsJournalTab'..i], {alpha=min05})
        end

        if _G['RematchJournal'] then
            set_NineSlice(_G['RematchJournal'], true)
            set_Alpha_Color(_G['RematchJournalBg'])
            set_Alpha_Color(RematchLoadoutPanel.Target.InsetBack)
            hide_Texture(RematchPetPanel.Top.InsetBack)
            set_Alpha_Color(RematchQueuePanel.List.Background.InsetBack)
            set_Alpha_Color(RematchQueuePanel.Top.InsetBack)
            hide_Texture(RematchPetPanel.Top.TypeBar.NineSlice)
            set_Alpha_Color(RematchTeamPanel.List.Background.InsetBack)
            set_Alpha_Color(RematchOptionPanel.List.Background.InsetBack)
            set_Alpha_Color(RematchLoadoutPanel.TopLoadout.InsetBack)
        end

    elseif arg1=='Blizzard_Calendar' then--日历
        set_Alpha_Color(CalendarFrameTopMiddleTexture)
        set_Alpha_Color(CalendarFrameTopLeftTexture)
        set_Alpha_Color(CalendarFrameTopRightTexture)

        set_Alpha_Color(CalendarFrameLeftTopTexture)
        set_Alpha_Color(CalendarFrameLeftMiddleTexture)
        set_Alpha_Color(CalendarFrameLeftBottomTexture)
        set_Alpha_Color(CalendarFrameRightTopTexture)
        set_Alpha_Color(CalendarFrameRightMiddleTexture)
        set_Alpha_Color(CalendarFrameRightBottomTexture)

        set_Alpha_Color(CalendarFrameBottomRightTexture)
        set_Alpha_Color(CalendarFrameBottomMiddleTexture)
        set_Alpha_Color(CalendarFrameBottomLeftTexture)
        for i= 1, 42 do
            local frame= _G['CalendarDayButton'..i]
            if frame then
                frame:DisableDrawLayer('BACKGROUND')
            end
        end
        set_Alpha_Color(CalendarCreateEventFrame.Border.Bg)


    elseif arg1=='Blizzard_FlightMap' then--飞行地图
        set_NineSlice(FlightMapFrame.BorderFrame, true)
        hide_Texture(FlightMapFrame.ScrollContainer.Child.TiledBackground)
        hide_Texture(FlightMapFrameBg)

    elseif arg1=='Blizzard_ItemSocketingUI' then--镶嵌宝石，界面
        set_NineSlice(ItemSocketingFrame, true)
        set_NineSlice(ItemSocketingFrameInset, nil, true)
        set_Alpha_Color(ItemSocketingFrameBg)
        hide_Texture(ItemSocketingFrameInset.Bg)
        hide_Texture(ItemSocketingFrame['SocketFrame-Right'])
        hide_Texture(ItemSocketingFrame['SocketFrame-Left'])
        hide_Texture(ItemSocketingFrame['ParchmentFrame-Top'])
        hide_Texture(ItemSocketingFrame['ParchmentFrame-Bottom'])
        hide_Texture(ItemSocketingFrame['ParchmentFrame-Right'])
        hide_Texture(ItemSocketingFrame['ParchmentFrame-Left'])
        set_Alpha_Color(ItemSocketingFrame['GoldBorder-Top'])
        set_Alpha_Color(ItemSocketingFrame['GoldBorder-Bottom'])
        set_Alpha_Color(ItemSocketingFrame['GoldBorder-Right'])
        set_Alpha_Color(ItemSocketingFrame['GoldBorder-Left'])
        set_Alpha_Color(ItemSocketingFrame['GoldBorder-BottomLeft'])
        set_Alpha_Color(ItemSocketingFrame['GoldBorder-TopLeft'])
        set_Alpha_Color(ItemSocketingFrame['GoldBorder-BottomRight'])
        set_Alpha_Color(ItemSocketingFrame['GoldBorder-TopRight'])
        set_Alpha_Color(_G['ItemSocketingScrollFrameMiddle'])
        set_Alpha_Color(_G['ItemSocketingScrollFrameTop'])
        set_Alpha_Color(_G['ItemSocketingScrollFrameBottom'])
        set_ScrollBar(ItemSocketingScrollFrame)

        hide_Texture(ItemSocketingFrame.TopLeftNub)
        hide_Texture(ItemSocketingFrame.TopRightNub)
        hide_Texture(ItemSocketingFrame.MiddleLeftNub)
        hide_Texture(ItemSocketingFrame.MiddleRightNub)
        hide_Texture(ItemSocketingFrame.BottomLeftNub)
        hide_Texture(ItemSocketingFrame.BottomRightNub)

    elseif arg1=='Blizzard_ChallengesUI' then--挑战, 钥匙插入， 界面
        set_Alpha_Color(ChallengesFrameInset.Bg)

        hooksecurefunc(ChallengesKeystoneFrame, 'Reset', function(self2)--钥匙插入， 界面
            set_Alpha_Frame_Texture(self2, {index=1})
            hide_Texture(self2.InstructionBackground)
        end)

    elseif arg1=='Blizzard_WeeklyRewards' then--周奖励提示
        set_Alpha_Color(WeeklyRewardsFrame.BackgroundTile)
        set_SearchBox(WeeklyRewardsFrame.HeaderFrame)
        set_Alpha_Color(WeeklyRewardsFrame.RaidFrame.Background)
        set_Alpha_Color(WeeklyRewardsFrame.MythicFrame.Background)
        set_Alpha_Color(WeeklyRewardsFrame.PVPFrame.Background)
        hooksecurefunc(WeeklyRewardsFrame,'UpdateSelection', function(self2)
            for _, frame in ipairs(self2.Activities) do
                set_Alpha_Color(frame.Background)
            end
        end)

    elseif arg1=='Blizzard_ItemInteractionUI' then--套装, 转换
        set_NineSlice(ItemInteractionFrame, true)
        set_Alpha_Color(ItemInteractionFrameBg)
        set_Alpha_Color(ItemInteractionFrame.Inset.Bg)
        set_Alpha_Color(ItemInteractionFrameMiddle)

        set_Alpha_Color(ItemInteractionFrameRight)
        set_Alpha_Color(ItemInteractionFrameLeft)

        hide_Texture(ItemInteractionFrame.ButtonFrame.BlackBorder)

    elseif arg1=='Blizzard_InspectUI' then--玩家, 观察角色, 界面
        set_NineSlice(InspectFrame, true)
        set_Alpha_Color(InspectFrameBg)
        hide_Texture(InspectFrameInset.Bg)
        hide_Texture(InspectPVPFrame.BG)
        hide_Texture(InspectGuildFrameBG)
        set_Alpha_Frame_Texture(InspectFrameTab1, {alpha=min05})
        set_Alpha_Frame_Texture(InspectFrameTab2, {alpha=min05})
        set_Alpha_Frame_Texture(InspectFrameTab3, {alpha=min05})
        set_NineSlice(InspectFrame, true)
        set_NineSlice(InspectFrameInset, nil, true)

    elseif arg1=='Blizzard_ItemUpgradeUI' then--装备升级,界面 
        set_NineSlice(ItemUpgradeFrame, true)
        set_Alpha_Color(ItemUpgradeFrameBg)
        hide_Texture(ItemUpgradeFrame.TopBG)
        hide_Texture(ItemUpgradeFrame.BottomBG)
        set_Alpha_Color(ItemUpgradeFramePlayerCurrenciesBorderMiddle)
        set_Alpha_Color(ItemUpgradeFramePlayerCurrenciesBorderLeft)
        set_Alpha_Color(ItemUpgradeFramePlayerCurrenciesBorderRight)

        set_Alpha_Color(ItemUpgradeFrameMiddle)
        set_Alpha_Color(ItemUpgradeFrameRight)
        set_Alpha_Color(ItemUpgradeFrameLeft)

    elseif arg1=='Blizzard_MacroUI' then--宏
        set_NineSlice(MacroFrame, true)
        hide_Texture(MacroFrameBg)
        set_Alpha_Color(MacroFrameInset.Bg)
        set_ScrollBar(MacroFrame.MacroSelector)
        hide_Texture(MacroFrameSelectedMacroBackground)
    elseif arg1=='Blizzard_GarrisonUI' then--要塞
        set_NineSlice(GarrisonCapacitiveDisplayFrame, true)
        if GarrisonCapacitiveDisplayFrame then--要塞订单
            set_Alpha_Color(GarrisonCapacitiveDisplayFrameBg)
            hide_Texture(GarrisonCapacitiveDisplayFrame.TopTileStreaks)
            hide_Texture(GarrisonCapacitiveDisplayFrameInset.Bg)
        end

    elseif arg1=='Blizzard_GenericTraitUI' then--欲龙术
        set_Alpha_Color(GenericTraitFrame.Background)
        set_NineSlice(GenericTraitFrame, true)

    elseif arg1=='Blizzard_PlayerChoice' then----任务选择
        hooksecurefunc(PlayerChoiceFrame, 'SetupFrame', function(self)
            if self.Background then
                set_Alpha_Color(self.Background.BackgroundTile, nil, nil, 0)
                set_Alpha_Color(self.Background, nil, nil, 0)
            end

            set_NineSlice(self)
            set_Alpha_Color(self.Header)
            set_SearchBox(self.Title)
        end)
    elseif arg1=='Blizzard_MajorFactions' then--派系声望
        set_Alpha_Color(MajorFactionRenownFrame.Background)


    elseif arg1=='Blizzard_Professions' then--专业, 初始化, 透明
        set_NineSlice(ProfessionsFrame, true)
        set_Alpha_Color(ProfessionsFrameBg)
        set_Alpha_Color(ProfessionsFrame.CraftingPage.SchematicForm.Background, nil, nil, min05)
        set_Alpha_Color(ProfessionsFrame.CraftingPage.RankBar.Background, nil, nil, min05)

        set_Alpha_Color(ProfessionsFrame.CraftingPage.SchematicForm.Details.BackgroundTop)
        set_Alpha_Color(ProfessionsFrame.CraftingPage.SchematicForm.Details.BackgroundMiddle)
        set_Alpha_Color(ProfessionsFrame.CraftingPage.SchematicForm.Details.BackgroundBottom)

        hide_Texture(ProfessionsFrame.SpecPage.TreeView.Background)
        hide_Texture(ProfessionsFrame.SpecPage.DetailedView.Background)
        set_Alpha_Color(ProfessionsFrame.SpecPage.DetailedView.Path.DialBG)
        set_Alpha_Color(ProfessionsFrame.SpecPage.DetailedView.UnspentPoints.CurrencyBackground)

        set_Alpha_Color(InspectRecipeFrameBg)
        set_Alpha_Color(InspectRecipeFrame.SchematicForm.MinimalBackground)
        for _, tabID in pairs(ProfessionsFrame:GetTabSet() or {}) do
            local btn= ProfessionsFrame:GetTabButton(tabID)
            set_Alpha_Frame_Texture(btn, {alpha=min05})
        end

        if ProfessionsFrame.SpecPage then
            hooksecurefunc(ProfessionsFrame.SpecPage, 'UpdateTabs', function(self)
                for tab, bool in self.tabsPool:EnumerateActive() do
                    if bool then
                        set_Alpha_Frame_Texture(tab, {alpha=min05})
                    end
                end
            end)
            set_Alpha_Color(ProfessionsFrame.SpecPage.PanelFooter)

            set_Alpha_Color(ProfessionsFrame.OrdersPage.BrowseFrame.RecipeList.Background, nil, nil, min05)
            set_Alpha_Color(ProfessionsFrame.OrdersPage.BrowseFrame.OrderList.Background, nil,nil, min05)
        end

        set_Alpha_Color(ProfessionsFrame.OrdersPage.OrderView.OrderInfo.Background, nil, nil, min05)
        set_Alpha_Color(ProfessionsFrame.OrdersPage.OrderView.OrderDetails.Background, nil, nil, min05)
        set_NineSlice(ProfessionsFrame.OrdersPage.OrderView.OrderInfo.NineSlice, true)
        set_NineSlice(ProfessionsFrame.OrdersPage.OrderView.OrderDetails.NineSlice, true)

        set_Alpha_Color(ProfessionsFrame.OrdersPage.BrowseFrame.PublicOrdersButton.Middle, nil, nil, min05)
        set_Alpha_Color(ProfessionsFrame.OrdersPage.BrowseFrame.PublicOrdersButton.Right, nil, nil, min05)
        set_Alpha_Color(ProfessionsFrame.OrdersPage.BrowseFrame.PublicOrdersButton.Left, nil, nil, min05)
        set_Alpha_Color(ProfessionsFrame.OrdersPage.BrowseFrame.PersonalOrdersButton.Middle, nil, nil, min05)
        set_Alpha_Color(ProfessionsFrame.OrdersPage.BrowseFrame.PersonalOrdersButton.Right, nil, nil, min05)
        set_Alpha_Color(ProfessionsFrame.OrdersPage.BrowseFrame.PersonalOrdersButton.Left, nil, nil, min05)

        set_NineSlice(ProfessionsFrame.CraftingPage.CraftingOutputLog, true)
        set_ScrollBar(ProfessionsFrame.CraftingPage.CraftingOutputLog)

    elseif arg1=='Blizzard_ClickBindingUI' then--点击，施法
        set_NineSlice(ClickBindingFrame, true)
        set_ScrollBar(ClickBindingFrame)
        set_Alpha_Color(ClickBindingFrameBg)
        ClickBindingFrame.ScrollBoxBackground:Hide()
        --set_NineSlice(ClickBindingFrame.ScrollBoxBackground, nil, true)

        set_NineSlice(ClickBindingFrame.TutorialFrame, true)

    elseif arg1=='Blizzard_ArchaeologyUI' then
        set_NineSlice(ArchaeologyFrame, true)
        set_NineSlice(ArchaeologyFrameInset, nil, true)
        hide_Texture(ArchaeologyFrameBg)
        hide_Texture(ArchaeologyFrameInset.Bg)
        hide_Texture(ArchaeologyFrameRankBarBackground)
        set_Alpha_Color(ArchaeologyFrameRaceFilterMiddle, nil, nil, min03)
        set_Alpha_Color(ArchaeologyFrameRaceFilterLeft, nil, nil, min03)
        set_Alpha_Color(ArchaeologyFrameRaceFilterRight, nil, nil, min03)
    end
end



























--####
--职业
--####
local function Init_Class_Power(init)--职业
    if not Save.classPowerNum then
        return
    end

    local function set_Num_Texture(self, num, color, parent)
        if self and not self.numTexture and (self.layoutIndex or num) then
            self.numTexture= (parent or self):CreateTexture(nil, 'OVERLAY', nil, 7)
            self.numTexture:SetSize(Save.classPowerNumSize, Save.classPowerNumSize)
            self.numTexture:SetPoint('CENTER', self, 'CENTER')
            self.numTexture:SetAtlas(e.Icon.number..(num or self.layoutIndex))
            if color~=false then
                if not color then
                    set_Alpha_Color(self.numTexture, true)
                else
                    self.numTexture:SetVertexColor(color.r, color.g, color.b)
                end
            end
        end
    end

    if e.Player.class=='PALADIN' then--QS PaladinPowerBarFrame
        if PaladinPowerBarFrame and PaladinPowerBarFrame.Background and PaladinPowerBarFrame.ActiveTexture then
            hide_Texture(PaladinPowerBarFrame.Background, true)
            hide_Texture(PaladinPowerBarFrame.ActiveTexture, true)
            if ClassNameplateBarPaladinFrame then
                hide_Texture(ClassNameplateBarPaladinFrame.Background)
                hide_Texture(ClassNameplateBarPaladinFrame.ActiveTexture)
            end
            local maxHolyPower = UnitPowerMax('player', Enum.PowerType.HolyPower)--UpdatePower
            for i=1,maxHolyPower do
                local holyRune = PaladinPowerBarFrame["rune"..i]
                set_Num_Texture(holyRune, i, false)
            end
            if init then
                PaladinPowerBarFrame:HookScript('OnEnter', function(self2)
                    self2.Background:SetShown(true)
                    self2.ActiveTexture:SetShown(true)
                end)
                PaladinPowerBarFrame:HookScript('OnLeave', function(self2)
                    hide_Texture(self2.Background, true)
                    hide_Texture(self2.ActiveTexture, true)
                end)
            end
        end

    elseif e.Player.class=='MAGE' then--法师
        if MageArcaneChargesFrame and MageArcaneChargesFrame.classResourceButtonTable then
            for _, mage in pairs(MageArcaneChargesFrame.classResourceButtonTable) do
                hide_Texture(mage.ArcaneBG)
            end
            if ClassNameplateBarMageFrame and ClassNameplateBarMageFrame.classResourceButtonTable then
                for _, mage in pairs(ClassNameplateBarMageFrame.classResourceButtonTable) do
                    hide_Texture(mage.ArcaneBG)
                end
            end
        end

    elseif e.Player.class=='DRUID' then--DruidComboPointBarFrame
        local function set_DruidComboPointBarFrame(self)
            if self then
                for btn, _ in pairs(self) do
                    hide_Texture(btn.BG_Active)
                    hide_Texture(btn.BG_Inactive)
                    set_Num_Texture(btn)
                end
            end
        end
        set_DruidComboPointBarFrame(DruidComboPointBarFrame and DruidComboPointBarFrame.classResourceButtonPool and DruidComboPointBarFrame.classResourceButtonPool.activeObjects)
        if DruidComboPointBarFrame then
            DruidComboPointBarFrame:HookScript('OnEvent', function(self)
                set_DruidComboPointBarFrame(self.classResourceButtonPool.activeObjects)
            end)
        end
        if ClassNameplateBarFeralDruidFrame and ClassNameplateBarFeralDruidFrame.classResourceButtonTable then
            for _, btn in pairs(ClassNameplateBarFeralDruidFrame.classResourceButtonTable) do
                hide_Texture(btn.BG_Active)
                hide_Texture(btn.BG_Inactive)
                set_Num_Texture(btn)
            end
        end

    elseif e.Player.class=='ROGUE' then--DZ RogueComboPointBarFrame
        if RogueComboPointBarFrame and RogueComboPointBarFrame.UpdateMaxPower and init then
            hooksecurefunc(RogueComboPointBarFrame, 'UpdateMaxPower',function(self)
                C_Timer.After(0.5, function()
                    for _, btn in pairs(self.classResourceButtonTable or {}) do
                        hide_Texture(btn.BGActive)
                        hide_Texture(btn.BGInactive)
                        set_Alpha_Color(btn.BGShadow, nil, nil, 0.3)
                        set_Num_Texture(btn)
                    end
                    if ClassNameplateBarRogueFrame and ClassNameplateBarRogueFrame.classResourceButtonTable then
                        for _, btn in pairs(ClassNameplateBarRogueFrame.classResourceButtonTable) do
                            hide_Texture(btn.BGActive)
                            hide_Texture(btn.BGInactive)
                            set_Alpha_Color(btn.BGShadow, nil, nil, 0.3)
                            set_Num_Texture(btn)
                        end
                    end
                end)
            end)
        end

    elseif e.Player.class=='MONK' then--MonkHarmonyBarFrame
        local function set_MonkHarmonyBarFrame(btn)
            if btn then
                hide_Texture(btn.Chi_BG_Active)
                hide_Texture(btn.BGInactive)
                set_Alpha_Color(btn.Chi_BG, nil, nil, 0.2)
                set_Num_Texture(btn, nil, false)
            end
        end
        if init then
            hooksecurefunc(MonkHarmonyBarFrame, 'UpdateMaxPower', function(self)
                C_Timer.After(0.5, function()
                    for i = 1, #self.classResourceButtonTable do
                        set_MonkHarmonyBarFrame(self.classResourceButtonTable[i])
                    end
                    local tab= ClassNameplateBarWindwalkerMonkFrame and ClassNameplateBarWindwalkerMonkFrame.classResourceButtonTable or {}
                    for i = 1, #tab do
                        set_MonkHarmonyBarFrame(tab[i])
                    end
                end)
            end)
            hooksecurefunc(MonkHarmonyBarFrame, 'UpdatePower', function(self)
                for _, btn in pairs(self.classResourceButtonTable or {}) do
                    if btn.Chi_BG then
                        btn.Chi_BG:SetAlpha(0.2)
                    end
                end
                if ClassNameplateBarWindwalkerMonkFrame then
                    for _, btn in pairs(ClassNameplateBarWindwalkerMonkFrame.classResourceButtonTable or {}) do
                        if btn.Chi_BG then
                            btn.Chi_BG:SetAlpha(0.2)
                        end
                    end
                end
            end)
        end

    elseif e.Player.class=='DEATHKNIGHT' then
        if RuneFrame.Runes then
            for _, btn in pairs(RuneFrame.Runes) do
                hide_Texture(btn.BG_Active)
                hide_Texture(btn.BG_Inactive)
                --set_Num_Texture(btn, index, false, RuneFrame)
            end
        end
        if DeathKnightResourceOverlayFrame.Runes then
            for _, btn in pairs(DeathKnightResourceOverlayFrame.Runes) do
                hide_Texture(btn.BG_Active)
                hide_Texture(btn.BG_Inactive)
            end
        end

    elseif e.Player.class=='EVOKER' then
        C_Timer.After(2, function()
            if EssencePlayerFrame and EssencePlayerFrame.classResourceButtonTable then--EssenceFramePlayer.lua
                for _, btn in pairs(EssencePlayerFrame.classResourceButtonTable) do
                    set_Alpha_Color(btn.EssenceFillDone.EssenceIcon, true)
                    set_Alpha_Color(btn.EssenceFillDone.CircBGActive, true)
                    set_Num_Texture(btn, nil, false)
                end
            end
        end)
    end
end
























--##################
--主菜单，颜色，透明度
--##################
local function set_BagTexture_Button(self)
    if not self.hasItem then
        hide_Texture(self.icon)
        hide_Texture(self.ItemSlotBackground)
        set_Alpha_Color(self.NormalTexture, true)
    end
    self.NormalTexture:SetAlpha(not self.hasItem and 0.3 or 1)
end
local function set_BagTexture(self)
    for _, itemButton in self:EnumerateValidItems() do
        set_BagTexture_Button(itemButton)
    end
end

local function Init_Main_Menu(init)--主菜单
    if init and Save.disabledMainMenu then
        return
    end
    local buttons = {
        'CharacterMicroButton',--菜单
        'SpellbookMicroButton',
        'TalentMicroButton',
        'AchievementMicroButton',
        'QuestLogMicroButton',
        'GuildMicroButton',
        'LFDMicroButton',
        'EJMicroButton',
        'CollectionsMicroButton',
        'MainMenuMicroButton',
        'HelpMicroButton',
        'StoreMicroButton',
        'MainMenuBarBackpackButton',--背包
        --'CharacterReagentBag0Slot',--材料包
    }
    for _, frame in pairs(buttons) do
        local self= _G[frame]
        if self then
            if not Save.disabledMainMenu then
                if init then
                    self:HookScript('OnEnter', function(self2)
                        local texture= self2.Portrait or self2:GetNormalTexture()
                        if texture then
                            texture:SetAlpha(1)
                            texture:SetVertexColor(1,1,1,1)
                        end
                        if self.Background then
                            self.Background:SetAlpha(1)
                        end
                    end)
                    self:HookScript('OnLeave', function(self2)
                        if not Save.disabledMainMenu then
                            set_Alpha_Color(self2.Portrait or self2:GetNormalTexture(), nil, nil, min03)
                            if self.Background then
                                self.Background:SetAlpha(0.5)
                            end
                        end
                    end)
                end
                set_Alpha_Color(self.Portrait or self:GetNormalTexture(), nil, nil, min03)

            else
                local texture= self.Portrait or self:GetNormalTexture()
                if texture then
                    texture:SetAlpha(1)
                    texture:SetVertexColor(1,1,1,1)
                end
            end
            if self.Background then
                self.Background:SetAlpha(0.5)
            end
        end
    end


    for i=1,  NUM_TOTAL_EQUIPPED_BAG_SLOTS+ NUM_REAGENTBAG_FRAMES do--10.25 出现错误
        local frame= _G['ContainerFrame'..i]
        if frame and frame.Bg and frame.Bg:GetObjectType()=='Frame' then
            frame.Bg:SetFrameStrata('BACKGROUND')
        end
    end

    if init then
         --材料包
        if CharacterReagentBag0Slot then
            set_Alpha_Color(CharacterReagentBag0SlotNormalTexture, nil, nil, min03)--外框

            local function set_Reagent_Bag_Alpha(show)
                if show then
                    CharacterReagentBag0SlotIconTexture:SetVertexColor(1,1,1,1)
                else
                    set_Alpha_Color(CharacterReagentBag0SlotIconTexture, nil, nil, min03)
                end
            end
            set_Reagent_Bag_Alpha(GetCVarBool("expandBagBar"))
            CharacterReagentBag0Slot:HookScript('OnLeave', function()
                if not Save.disabledMainMenu then
                    set_Reagent_Bag_Alpha(GetCVarBool("expandBagBar"))
                end
            end)
            CharacterReagentBag0Slot:HookScript('OnEnter', function()
                set_Reagent_Bag_Alpha(true)
            end)
            hooksecurefunc(MainMenuBarBagManager, 'ToggleExpandBar', function()
                set_Reagent_Bag_Alpha(GetCVarBool("expandBagBar"))
            end)
        end

        hooksecurefunc('ContainerFrame_GenerateFrame',function()--ContainerFrame.lua 背包里，颜色
            for _, frame in ipairs(ContainerFrameSettingsManager:GetBagsShown()) do
                if not frame.SetBagAlpha then
                    set_BagTexture(frame)
                    hooksecurefunc(frame, 'UpdateItems', set_BagTexture)
                    frame:SetTitle('')--名称
                    hooksecurefunc(frame, 'UpdateName', function(self2) self2:SetTitle('') end)
                    frame.SetBagAlpha=true
                end
            end
        end)

        hooksecurefunc('PaperDollItemSlotButton_Update', function(self)--PaperDollFrame.lua 主菜单，包
            local bagID= self:GetID()
            if bagID>30 then
                set_Alpha_Color(self:GetNormalTexture())
                set_Alpha_Color(self.icon)
                self:SetAlpha(GetInventoryItemTexture("player", bagID)~=nil and 1 or 0.1)
            end
        end)
    end
    --EditModeSettingDisplayInfoManager.systemSettingDisplayInfo[Enum.EditModeSystem.MicroMenu][3].minValue=50--EditModeSettingDisplayInfo.lua
end
















--######
--动作条
--######
local function Init_Main_Button()

    local KEY_BUTTON_Tab={
        [KEY_BUTTON1]= e.Icon.left,-- 'ML',--鼠标左键";
        [KEY_BUTTON3]= e.Icon.mid, --'MR',--鼠标中键";
        [KEY_BUTTON2]= e.Icon.right,--'MM',--鼠标右键";
        --[[[KEY_BUTTON10]= 'M10',--鼠标按键10";
        [KEY_BUTTON11]= 'M11',--鼠标按键11";
        [KEY_BUTTON12]= 'M12',--鼠标按键12";
        [KEY_BUTTON13]= 'M13',--鼠标按键13";
        [KEY_BUTTON14]= 'M14',--鼠标按键14";
        [KEY_BUTTON15]= 'M15',--鼠标按键15";
        [KEY_BUTTON16]= 'M16',--鼠标按键16";
        [KEY_BUTTON17]= 'M17',--鼠标按键17";
        [KEY_BUTTON18]= 'M18',--鼠标按键18";
        [KEY_BUTTON19]= 'M19',--鼠标按键19";
        [KEY_BUTTON20]= 'M20',--鼠标按键20";
        [KEY_BUTTON21]= 'M21',--鼠标按键21";
        [KEY_BUTTON22]= 'M22',--鼠标按键22";
        [KEY_BUTTON23]= 'M23',--鼠标按键23";
        [KEY_BUTTON24]= 'M24',--鼠标按键24";
        [KEY_BUTTON25]= 'M25',--鼠标按键25";
        [KEY_BUTTON26]= 'M26',--鼠标按键26";
        [KEY_BUTTON27]= 'M27',--鼠标按键27";
        [KEY_BUTTON28]= 'M28',--鼠标按键28";
        [KEY_BUTTON29]= 'M29',--鼠标按键29";
        [KEY_BUTTON30]= 'M30',--鼠标按键30";
        [KEY_BUTTON31]= 'M31',--鼠标按键31";]]
        [KEY_BUTTON4]= 'M4',--鼠标按键4";
        [KEY_BUTTON5]= 'M5',--鼠标按键5";
        [KEY_BUTTON6]= 'M6',--鼠标按键6";
        [KEY_BUTTON7]= 'M7',--鼠标按键7";
        [KEY_BUTTON8]= 'M8',--鼠标按键8";
        [KEY_BUTTON9]= 'M9',--鼠标按键9";
    }
    local function set_main_button(self)
        if not self then
            return
        end
        hide_Texture(self.NormalTexture)--外框，方块
        hide_Texture(self.SlotBackground, true)--背景
        if self.HotKey then--快捷键
            self.HotKey:SetShadowOffset(1, -1)
            local text=self.HotKey:GetText()
            if text and text~='' and text~= RANGE_INDICATOR and #text>4 then
                for key, mouse in pairs(KEY_BUTTON_Tab) do
                    if text:find(key) then
                        self.HotKey:SetText(text:gsub(key, mouse))
                    end
                end
            end
        end
        if self.Count then--数量
            self.Count:SetShadowOffset(1, -1)
        end
        if self.Name then--名称
            self.Name:SetShadowOffset(1, -1)
        end
        if self.cooldown then
            self.cooldown:SetCountdownFont('NumberFontNormal')
        end
    end

    hooksecurefunc(MainMenuBar, 'UpdateDividers', function(self)--主动作条
        for i=1, MAIN_MENU_BAR_NUM_BUTTONS do
            set_main_button(_G['ActionButton'..i])--主动作条
        end
        --local dividersPool = self.isHorizontal and self.HorizontalDividersPool or self.VerticalDividersPool;
        --for _ in pairs(MainMenuBar.actionButtons) do local divider = dividersPool:Acquire() --BUG
    end)
    for i=1, MAIN_MENU_BAR_NUM_BUTTONS do
        set_main_button(_G['ActionButton'..i])--主动作条
        set_Alpha_Color(_G['ActionButton'..i].SlotArt, nil, nil, min05)
        set_main_button(_G['MultiBarBottomLeftButton'..i])--作条2
        set_main_button(_G['MultiBarBottomRightButton'..i])--作条3
        set_main_button(_G['MultiBarLeftButton'..i])--作条4
        set_main_button(_G['MultiBarRightButton'..i])--作条5
        set_main_button(_G['StanceButton'..i])
        for index=5, 7 do
            set_main_button(_G['MultiBar'..index..'Button'..i])--作条6, 7, 8
        end
    end
    
    set_Alpha_Frame_Texture(MainMenuBar.ActionBarPageNumber.UpButton, {alpha=min05})
    set_Alpha_Frame_Texture(MainMenuBar.ActionBarPageNumber.DownButton, {alpha=min05})
    set_Label(MainMenuBar.ActionBarPageNumber.Text, 1)

    if MainMenuBar.EndCaps then
        set_Alpha_Color(MainMenuBar.EndCaps.LeftEndCap, nil, nil, min05)
        set_Alpha_Color(MainMenuBar.EndCaps.RightEndCap, nil, nil, min05)
    end
    set_Alpha_Color(MainMenuBar.BorderArt, nil, nil, min05)
end
















--#######
--聊天泡泡
--ChatBubbles https://wago.io/yyX84OlOD
local BubblesFrame
local function Init_Chat_Bubbles()
    if BubblesFrame or Save.disabledChatBubble then
        if BubblesFrame then
            BubblesFrame:set_event()
            if not Save.disabledChatBubble then
                BubblesFrame:set_chat_bubbles(true)
            end
        end
        return
    end
    BubblesFrame= CreateFrame('Frame')
    function BubblesFrame:set_chat_bubbles(set)
        for _, buble in pairs(C_ChatBubbles.GetAllChatBubbles() or {}) do
            if not buble.setAlphaOK or set then
                local frame= buble:GetChildren()
                if frame then
                    local fontString = frame.String
                    local point, relativeTo, relativePoint, ofsx, ofsy = fontString:GetPoint(1)
                    local currentScale= buble:GetScale()
                    frame:SetScale(Save.chatBubbleSacal)
                    if point then
                        local scaleRatio = Save.chatBubbleSacal / currentScale
                        fontString:SetPoint(point, relativeTo, relativePoint, ofsx / scaleRatio, ofsy / scaleRatio)
                    end
                    local tab={frame:GetRegions()}
                    for _, region in pairs(tab) do
                        if region:GetObjectType()=='Texture' then-- .String
                            e.Set_Label_Texture_Color(region, {type='Texture', alpha=Save.chatBubbleAlpha})
                        end
                    end
                    buble.setAlphaOK= true
                end
            end
        end
    end

    function BubblesFrame:set_event()
        self:UnregisterAllEvents()
        if Save.disabledChatBubble then
            return
        end
        self:RegisterEvent('PLAYER_ENTERING_WORLD')
        if not IsInInstance() then
            local chatBubblesEvents={
                'CHAT_MSG_SAY',
                'CHAT_MSG_YELL',
                'CHAT_MSG_PARTY',
                'CHAT_MSG_PARTY_LEADER',
                'CHAT_MSG_RAID',
                'CHAT_MSG_RAID_LEADER',
                'CHAT_MSG_MONSTER_PARTY',
                'CHAT_MSG_MONSTER_SAY',
                'CHAT_MSG_MONSTER_YELL',
            }
            FrameUtil.RegisterFrameForEvents(BubblesFrame, chatBubblesEvents)
        end
    end
    BubblesFrame:SetScript('OnEvent', function(self, event)
        if event=='PLAYER_ENTERING_WORLD' then
            self:set_event()
        else
            self:set_chat_bubbles()
        end
    end)
    BubblesFrame:set_event()
end

















--隐藏教程
--########
local function Init_HelpTip()
    if Save.disabledHelpTip then
        return
    end
    hooksecurefunc(HelpTip, 'Show', function(self, parent)--隐藏所有HelpTip HelpTip.lua
        self:HideAll(parent)
    end)

    C_CVar.SetCVar("showNPETutorials",'0')

    --Blizzard_TutorialPointerFrame.lua 隐藏, 新手教程
    hooksecurefunc(TutorialPointerFrame, 'Show',function(self, content, direction, anchorFrame, ofsX, ofsY, relativePoint, backupDirection, showMovieName, loopMovie, resolution)
        if not anchorFrame or not self.DirectionData[direction] then
            return
        end
        local ID=self.NextID
        if ID then
            C_Timer.After(2, function()
                TutorialPointerFrame:Hide(ID-1)
                print(id, e.cn(addName), '|cffff00ff'..content)
            end)
        end
    end)

    hooksecurefunc(ReportFrame, 'UpdateThankYouMessage', function(self, showThankYouMessage)
        if showThankYouMessage then
            C_Timer.After(1, function()
                if self:IsShown() then
                    self:Hide()
                    print(id, e.cn(addName), '|cnGREEN_FONT_COLOR:'..(e.onlyChinese and '感谢您的举报！' or ERR_REPORT_SUBMITTED_SUCCESSFULLY)..'|r', e.onlyChinese and '关闭' or CLOSE)
                end
            end)
        end
    end)

    C_Timer.After(2, function()
        if SplashFrame and SplashFrame:IsShown() then
            SplashFrame:Close();
            print(id, addName, '|cnRED_FONT_COLOR:'..(e.onlyChinese and '隐藏' or HIDE)..'|r|n|cff00ff00', SplashFrame.Label and SplashFrame.Label:GetText() or '')
        end
    end)
end






















local Category, Layout= e.AddPanel_Sub_Category({name= '|A:AnimCreate_Icon_Texture:0:0|a'..(e.onlyChinese and '材质' or addName)})
local function Init_Options()
    local initializer2= e.AddPanel_Check_Button({
        checkName= e.onlyChinese and '材质' or TEXTURES_SUBHEADER,
        checkValue= not Save.disabled,
        checkFunc= function()
            Save.disabled= not Save.disabled and true or nil
            print(id, e.cn(addName), e.GetEnabeleDisable(not Save.disabled), e.onlyChinese and '需要重新加载' or REQUIRES_RELOAD)
        end,
        buttonText= e.onlyChinese and '设置颜色' or format(CLUB_FINDER_LOOKING_FOR_CLASS_SPEC, SETTINGS ,COLOR),
        buttonFunc= function()
            e.OpenPanelOpting((e.Player.useColor and e.Player.useColor.hex or '')..(e.onlyChinese and '颜色' or COLOR))
        end,
        tooltip= e.cn(addName),
        layout= Layout,
        category= Category
    })

    local initializer= e.AddPanelSider({
        name= e.onlyChinese and '透明度' or 'Alpha',
        value= Save.alpha,
        minValue= 0,
        maxValue= 1,
        setp= 0.1,
        tooltip= e.cn(addName),
        category= Category,
        func= function(_, _, value2)
            local value3= e.GetFormatter1to10(value2, 0, 1)
            Save.alpha= value3
            Init()
            print(id, e.cn(addName), e.onlyChinese and '需要重新加载' or REQUIRES_RELOAD)
        end
    })
    initializer:SetParentInitializer(initializer2, function() return not Save.disabled end)

    initializer= e.AddPanel_Check({
        name= e.onlyChinese and '主菜单' or MAINMENU_BUTTON,
        tooltip= e.cn(addName),
        category= Category,
        value= not Save.disabledMainMenu,
        func= function()
            Save.disabledMainMenu= not Save.disabledMainMenu and true or nil
            Init_Main_Menu()
            print(id, e.cn(addName), e.onlyChinese and '需要重新加载' or REQUIRES_RELOAD)
        end
    })
    initializer:SetParentInitializer(initializer2, function() return not Save.disabledColor end)

    e.AddPanel_Header(Layout, e.onlyChinese and '其它' or OTHER)

    initializer2= e.AddPanel_Check({
        name= e.onlyChinese and '聊天泡泡' or CHAT_BUBBLES_TEXT,
        tooltip= (e.onlyChinese and '在副本无效' or (INSTANCE..' ('..DISABLE..')'))
                ..'|n|n'..((e.onlyChinese and '说' or SAY)..' CVar: chatBubbles '.. e.GetShowHide(C_CVar.GetCVarBool("chatBubbles")))
                ..'|n'..((e.onlyChinese and '小队' or SAY)..' CVar: chatBubblesParty '.. e.GetShowHide(C_CVar.GetCVarBool("chatBubblesParty"))),
        category= Category,
        value= not Save.disabledChatBubble,
        func= function()
            Save.disabledChatBubble= not Save.disabledChatBubble and true or nil
            Init_Chat_Bubbles()
            if Save.disabledChatBubble and BubblesFrame then
                print(id, e.cn(addName), e.onlyChinese and '需要重新加载' or REQUIRES_RELOAD)
            end
        end
    })
    initializer= e.AddPanelSider({
        name= e.onlyChinese and '透明度' or 'Alpha',
        value= Save.chatBubbleAlpha,
        minValue= 0,
        maxValue= 1,
        setp= 0.1,
        tooltip= e.cn(addName),
        category= Category,
        func= function(_, _, value2)
            local value3= e.GetFormatter1to10(value2, 0, 1)
            Save.chatBubbleAlpha= value3
            Init_Chat_Bubbles()
        end
    })
    initializer:SetParentInitializer(initializer2, function() return not Save.disabledChatBubble end)

    initializer= e.AddPanelSider({
        name= e.onlyChinese and '缩放' or UI_SCALE,
        value= Save.chatBubbleSacal,
        minValue= 0.3,
        maxValue= 1,
        setp= 0.1,
        tooltip= e.cn(addName),
        category= Category,
        func= function(_, _, value2)
            local value3= e.GetFormatter1to10(value2, 0.3, 1)
            Save.chatBubbleSacal= value3
            Init_Chat_Bubbles()
        end
    })
    initializer:SetParentInitializer(initializer2, function() return not Save.disabledChatBubble end)

    e.AddPanel_Check_Sider({
        checkName= (e.onlyChinese and '职业能量' or format(CLUB_FINDER_LOOKING_FOR_CLASS_SPEC, CLASS, ENERGY))..' 1 2 3',
        checkValue= Save.classPowerNum,
        checkTooltip= e.cn(addName),
        checkFunc= function()
            Save.classPowerNum= not Save.classPowerNum and true or false
            print(id, e.cn(addName), e.onlyChinese and '需要重新加载' or REQUIRES_RELOAD)
        end,
        sliderValue= Save.classPowerNumSize,
        sliderMinValue= 6,
        sliderMaxValue= 64,
        sliderStep= 1,
        siderName= nil,
        siderTooltip= nil,
        siderFunc= function(_, _, value2)
            local value3= e.GetFormatter1to10(value2, 6, 64)
            Save.classPowerNumSize= value3
            Init_Class_Power()--职业
            print(id, e.cn(addName),'|cnGREEN_FONT_COLOR:'.. value3..'|r', e.onlyChinese and '需要重新加载' or REQUIRES_RELOAD)
        end,
        layout= Layout,
        category= Category,
    })

    e.AddPanel_Check({
        name= e.onlyChinese and '隐藏教程' or  format(CLUB_FINDER_LOOKING_FOR_CLASS_SPEC, HIDE, SHOW_TUTORIALS ),
        tooltip='HelpTip',
        category= Category,
        value= not Save.disabledHelpTip,
        func= function()
            Save.disabledHelpTip= not Save.disabledHelpTip and true or nil
            print(id, e.cn(addName), e.onlyChinese and '需要重新加载' or REQUIRES_RELOAD)
        end
    })
end
























--###########
--加载保存数据
--###########
local panel=CreateFrame("Frame")
panel:RegisterEvent("ADDON_LOADED")
panel:RegisterEvent("PLAYER_LOGOUT")
local eventTab={}
panel:SetScript("OnEvent", function(_, event, arg1)
    if event == "ADDON_LOADED" then
        if arg1== id then
            Save= WoWToolsSave[addName] or Save
            Save.classPowerNumSize= Save.classPowerNumSize or 12
            GetMinValueAlpha()--min03，透明度，最小值

            Category, Layout= e.AddPanel_Sub_Category({name= '|A:AnimCreate_Icon_Texture:0:0|a'..(e.onlyChinese and '材质' or addName)})
            if Save.disabled then
                e.AddPanel_Check({
                    name= e.onlyChinese and '材质' or TEXTURES_SUBHEADER,
                    tooltip= e.cn(addName),
                    category= Category,
                    value= not Save.disabled,
                    func= function()
                        Save.disabled= not Save.disabled and true or nil
                        print(id, e.cn(addName), e.GetEnabeleDisable(not Save.disabled), e.onlyChinese and '需要重新加载' or REQUIRES_RELOAD)
                    end
                })
                panel:UnregisterEvent('ADDON_LOADED')
            else

                for _, ent in pairs(eventTab or {}) do
                    Init_Event(ent)
                end

                Init_All_Frame()
                Init_Class_Power(true)--职业
                Init_Chat_Bubbles()--聊天泡泡
                Init_HelpTip()--隐藏教程
                Init_Main_Button()
                C_Timer.After(2, function()
                    Init_Main_Menu(true)--主菜单, 颜色
                end)

            end
            eventTab=nil

        elseif arg1=='Blizzard_Settings' then
            Init_Options()

            set_Alpha_Frame_Texture(SettingsPanel.NineSlice, {alpha=min05})
            set_Alpha_Color(SettingsPanel.Bg, nil, nil, min05)
            set_ScrollBar(SettingsPanel.Container.SettingsList)
            set_ScrollBar(SettingsPanel.CategoryList)

            set_NineSlice(PingSystemTutorial, true)
            set_NineSlice(PingSystemTutorialInset, nil, true)
            hide_Texture(PingSystemTutorialBg)
            set_Alpha_Frame_Texture(SettingsPanel.GameTab, {notAlpha=true})
            set_Alpha_Frame_Texture(SettingsPanel.AddOnsTab, {notAlpha=true})
            set_SearchBox(SettingsPanel.SearchBox)
            set_Alpha_Frame_Texture(SettingsPanel, {index=1})
        else
            if eventTab then
                table.insert(eventTab, arg1)
            else
                Init_Event(arg1)
            end
        end

    elseif event == "PLAYER_LOGOUT" then
        if not e.ClearAllSave then
            WoWToolsSave[addName]=Save
        end
    end
end)