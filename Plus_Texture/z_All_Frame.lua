



local function set_BagTexture(frame)
    if not frame:IsVisible() then
        return
    end
    for _, btn in frame:EnumerateValidItems() do
        if not btn.hasItem then
            WoWTools_PlusTextureMixin:HideTexture(btn.icon)
            WoWTools_PlusTextureMixin:HideTexture(btn.ItemSlotBackground)
            WoWTools_PlusTextureMixin:SetAlphaColor(btn.NormalTexture, true)
        end
        btn.NormalTexture:SetAlpha(not btn.hasItem and 0.3 or 1)
    end
end











local function Init(mixin)

    mixin:HideTexture(GameMenuFrame.Header.RightBG)
    mixin:HideTexture(GameMenuFrame.Header.CenterBG)
    mixin:HideTexture(GameMenuFrame.Header.LeftBG)
    GameMenuFrame.Header.Text:ClearAllPoints()
    GameMenuFrame.Header.Text:SetPoint('TOP', 0 ,-24)
    mixin:SetFrame(GameMenuFrame.Border, {alpha= 0.3})

    for i=1, MAX_BOSS_FRAMES do
        local frame= _G['Boss'..i..'TargetFrame']
        if frame then
            mixin:HideTexture(frame.TargetFrameContainer.FrameTexture)
        end
    end

    hooksecurefunc('PlayerFrame_UpdateArt', function()--隐藏材质, 载具
        if OverrideActionBarEndCapL then
            mixin:HideTexture(OverrideActionBarEndCapL)
            mixin:HideTexture(OverrideActionBarEndCapR)
            mixin:HideTexture(OverrideActionBarBorder)
            mixin:HideTexture(OverrideActionBarBG)
            mixin:HideTexture(OverrideActionBarButtonBGMid)
            mixin:HideTexture(OverrideActionBarButtonBGR)
            mixin:HideTexture(OverrideActionBarButtonBGL)
        end
        if OverrideActionBarMicroBGMid then
            mixin:HideTexture(OverrideActionBarMicroBGMid)
            mixin:HideTexture(OverrideActionBarMicroBGR)
            mixin:HideTexture(OverrideActionBarMicroBGL)
            mixin:HideTexture(OverrideActionBarLeaveFrameExitBG)

            mixin:HideTexture(OverrideActionBarDivider2)
            mixin:HideTexture(OverrideActionBarLeaveFrameDivider3)
        end
        if OverrideActionBarExpBar then
            mixin:HideTexture(OverrideActionBarExpBarXpMid)
            mixin:HideTexture(OverrideActionBarExpBarXpR)
            mixin:HideTexture(OverrideActionBarExpBarXpL)
            for i=1, 19 do
                mixin:SetAlphaColor(_G['OverrideActionBarXpDiv'..i], nil, nil, 0.3)
            end
        end
    end)
    if ExtraActionButton1 then mixin:HideTexture(ExtraActionButton1.style) end--额外技能
    if ZoneAbilityFrame then mixin:HideTexture(ZoneAbilityFrame.Style) end--区域技能



    if PetBattleFrame then--宠物
        mixin:HideTexture(PetBattleFrame.TopArtLeft)
        mixin:HideTexture(PetBattleFrame.TopArtRight)
        mixin:HideTexture(PetBattleFrame.TopVersus)
        PetBattleFrame.TopVersusText:SetText('')
        PetBattleFrame.TopVersusText:SetShown(false)
        mixin:HideTexture(PetBattleFrame.WeatherFrame.BackgroundArt)

        mixin:HideTexture(PetBattleFrameXPBarLeft)
        mixin:HideTexture(PetBattleFrameXPBarRight)
        mixin:HideTexture(PetBattleFrameXPBarMiddle)

        if PetBattleFrame.BottomFrame then
            mixin:HideTexture(PetBattleFrame.BottomFrame.LeftEndCap)
            mixin:HideTexture(PetBattleFrame.BottomFrame.RightEndCap)
            mixin:HideTexture(PetBattleFrame.BottomFrame.Background)
            mixin:HideTexture(PetBattleFrame.BottomFrame.TurnTimer.ArtFrame2)
            PetBattleFrame.BottomFrame.FlowFrame:SetShown(false)
            PetBattleFrame.BottomFrame.Delimiter:SetShown(false)
        end
    end

    mixin:HideFrame(PetBattleFrame.BottomFrame.MicroButtonFrame)

    hooksecurefunc('PetBattleFrame_UpdatePassButtonAndTimer', function(self)--Blizzard_PetBattleUI.lua
        mixin:HideTexture(self.BottomFrame.TurnTimer.TimerBG)
        mixin:HideTexture(self.BottomFrame.TurnTimer.ArtFrame)
        mixin:HideTexture(self.BottomFrame.TurnTimer.ArtFrame2)
    end)




    if MultiBarBottomLeftButton10 then
        mixin:HideTexture(MultiBarBottomLeftButton10.SlotBackground)
    end

    if CompactRaidFrameManager then--隐藏, 团队, 材质 Blizzard_CompactRaidFrameManager.lua
        mixin:SetAlphaColor(_G['CompactRaidFrameManagerBG-regulars'], nil, nil, 0)
        mixin:SetAlphaColor(_G['CompactRaidFrameManagerBG-party-leads'], nil, nil, 0)
        mixin:SetAlphaColor(_G['CompactRaidFrameManagerBG-leads'], nil, nil, 0)
        mixin:SetAlphaColor(_G['CompactRaidFrameManagerBG-party-regulars'], nil,nil,0)

        CompactRaidFrameManagerToggleButtonForward:SetAlpha(0.3)
        CompactRaidFrameManagerToggleButtonBack:SetAlpha(0.3)
    end

    --施法条 CastingBarFrameTemplate
    for _, frame in pairs({
        PlayerCastingBarFrame,
        PetCastingBarFrame,
        OverlayPlayerCastingBarFrame,
    }) do
        if frame then
            mixin:SetAlphaColor(frame.Border)
            mixin:SetAlphaColor(frame.Background)
            mixin:SetAlphaColor(frame.TextBorder)
            mixin:SetAlphaColor(frame.Shine)
        end
    end


    --角色，界面
    mixin:SetNineSlice(CharacterFrameInset, true)
    mixin:SetNineSlice(CharacterFrame, true)
    mixin:SetNineSlice(CharacterFrameInsetRight, true)

    mixin:SetAlphaColor(CharacterFrameBg)
    mixin:HideTexture(CharacterFrameInset.Bg)

    mixin:SetAlphaColor(CharacterFrame.Background)

    mixin:SetAlphaColor(PaperDollInnerBorderBottom, nil, nil, 0.3)
    mixin:SetAlphaColor(PaperDollInnerBorderRight, nil, nil, 0.3)
    mixin:SetAlphaColor(PaperDollInnerBorderLeft, nil, nil, 0.3)
    mixin:SetAlphaColor(PaperDollInnerBorderTop, nil, nil, 0.3)

    mixin:SetAlphaColor(PaperDollInnerBorderTopLeft, nil, nil, 0.3)
    mixin:SetAlphaColor(PaperDollInnerBorderTopRight, nil, nil, 0.3)
    mixin:SetAlphaColor(PaperDollInnerBorderBottomLeft, nil, nil, 0.3)
    mixin:SetAlphaColor(PaperDollInnerBorderBottomRight, nil, nil, 0.3)


    mixin:HideTexture(PaperDollInnerBorderBottom2)
    mixin:HideTexture(CharacterFrameInsetRight.Bg)




    mixin:SetAlphaColor(CharacterStatsPane.ClassBackground, nil, nil, 0.3)
    mixin:SetAlphaColor(CharacterStatsPane.EnhancementsCategory.Background)
    mixin:SetAlphaColor(CharacterStatsPane.AttributesCategory.Background)
    mixin:SetAlphaColor(CharacterStatsPane.ItemLevelCategory.Background)
    hooksecurefunc('PaperDollTitlesPane_UpdateScrollBox', function()--PaperDollFrame.lua
        local frame= PaperDollFrame.TitleManagerPane.ScrollBox
        if not frame or not frame:GetView() then
            return
        end
        for _, button in pairs(frame:GetFrames() or {}) do
            mixin:HideTexture(button.BgMiddle)
        end
    end)
    mixin:SetScrollBar(PaperDollFrame.TitleManagerPane)
    hooksecurefunc('PaperDollEquipmentManagerPane_Update', function()--PaperDollFrame.lua

    for _, button in pairs(PaperDollFrame.EquipmentManagerPane.ScrollBox:GetFrames() or {}) do
            mixin:HideTexture(button.BgMiddle)
        end
    end)
    mixin:SetScrollBar(PaperDollFrame.EquipmentManagerPane)



    mixin:HideTexture(CharacterModelFrameBackgroundTopLeft)--角色3D背景
    mixin:HideTexture(CharacterModelFrameBackgroundTopRight)
    mixin:HideTexture(CharacterModelFrameBackgroundBotLeft)
    mixin:HideTexture(CharacterModelFrameBackgroundBotRight)
    mixin:HideTexture(CharacterModelFrameBackgroundOverlay)

    mixin:HideFrame(GearManagerPopupFrame.BorderBox)
    mixin:SetAlphaColor(GearManagerPopupFrame.BG, nil, nil, 0.3)
    mixin:SetScrollBar(GearManagerPopupFrame.IconSelector)
    mixin:SetSearchBox(GearManagerPopupFrame.BorderBox.IconSelectorEditBox)


    --声望
    mixin:SetScrollBar(ReputationFrame)
    mixin:SetMenu(ReputationFrame.filterDropdown)


    --货币
    mixin:SetScrollBar(TokenFrame)
    mixin:SetNineSlice(CurrencyTransferLog, true)
    mixin:SetAlphaColor(CurrencyTransferLogBg, nil, nil, 0.3)
    mixin:SetNineSlice(CurrencyTransferLogInset, true)
    mixin:SetScrollBar(CurrencyTransferLog)
    mixin:SetNineSlice(CurrencyTransferMenu, true)
    mixin:SetAlphaColor(CurrencyTransferMenuBg, nil, nil, 0.3)
    mixin:SetNineSlice(CurrencyTransferMenuInset)
    mixin:SetFrame(TokenFramePopup.Border, {alpha=0.3})
    mixin:SetMenu(TokenFrame.filterDropdown)
    


    mixin:SetSearchBox(CurrencyTransferMenu.AmountSelector.InputBox)

    --世界地图
    mixin:SetNineSlice(WorldMapFrame.BorderFrame, true)
    mixin:SetAlphaColor(WorldMapFrameBg)
    mixin:SetAlphaColor(QuestMapFrame.Background)
    mixin:HideTexture(WorldMapFrame.NavBar.overlay)
    mixin:HideTexture(WorldMapFrame.NavBar.InsetBorderBottom)
    mixin:HideTexture(WorldMapFrame.NavBar.InsetBorderRight)
    mixin:HideTexture(WorldMapFrame.NavBar.InsetBorderLeft)
    mixin:HideTexture(WorldMapFrame.NavBar.InsetBorderBottomRight)
    mixin:HideTexture(WorldMapFrame.NavBar.InsetBorderBottomLeft)
    mixin:HideTexture(WorldMapFrame.BorderFrame.InsetBorderTop)
    WorldMapFrame.NavBar:DisableDrawLayer('BACKGROUND')
    mixin:SetScrollBar(QuestMapDetailsScrollFrame)
    hooksecurefunc(WorldMapFrame, 'SynchronizeDisplayState', function(self)--最大化时，隐藏背景
        if self:IsMaximized() then
            self.BlackoutFrame:Hide()
        end
    end)
    mixin:HideTexture(QuestScrollFrame.Background, true)
    mixin:SetScrollBar(QuestScrollFrame)
    mixin:SetScrollBar(MapLegendScrollFrame)
    mixin:SetAlphaColor(QuestScrollFrame.SettingsDropdown.Icon, true, nil, nil)
    mixin:SetAlphaColor(QuestScrollFrame.BorderFrame.Border, true, nil, nil)
    mixin:SetAlphaColor(QuestMapFrame.QuestsFrame.DetailsFrame.BorderFrame, true, nil, nil)
    mixin:SetSearchBox(QuestScrollFrame.SearchBox)
    

    if QuestMapFrame.MapLegendTab then--11.1
       mixin:HideTexture(QuestMapFrame.MapLegendTab.Background)
       mixin:HideTexture(QuestMapFrame.QuestsTab.Background)
    end

     --地下城和团队副本
     mixin:HideTexture(PVEFrame.TopTileStreaks)--最上面
     mixin:SetNineSlice(PVEFrame, true)
     mixin:SetSearchBox(LFGListFrame.SearchPanel.SearchBox)
     mixin:SetScrollBar(LFGListFrame.SearchPanel)
     mixin:SetFrame(LFGListFrame.CategorySelection.Inset, {alpha= 0.3})
     mixin:SetFrame(LFGDungeonReadyDialog.Border, {alpha= 0.3})
     mixin:SetFrame(LFDRoleCheckPopup.Border, {alpha= 0.3})
     mixin:SetFrame(LFGDungeonReadyStatus.Border, {alpha= 0.3})



     mixin:SetNineSlice(LFGListFrame.CategorySelection.Inset, nil, true)
     mixin:SetNineSlice(LFGListFrame.EntryCreation.Inset, nil, true)
     mixin:HideTexture(LFGListFrame.EntryCreation.Inset.CustomBG)
     mixin:HideTexture(LFGListFrame.EntryCreation.Inset.Bg)

     mixin:SetAlphaColor(LFGListFrameMiddleMiddle)
     mixin:SetAlphaColor(LFGListFrameMiddleLeft)
     mixin:SetAlphaColor(LFGListFrameMiddleRight)
     mixin:SetAlphaColor(LFGListFrameBottomMiddle)
     mixin:SetAlphaColor(LFGListFrameTopMiddle)
     mixin:SetAlphaColor(LFGListFrameTopLeft)
     mixin:SetAlphaColor(LFGListFrameBottomLeft)
     mixin:SetAlphaColor(LFGListFrameTopRight)
     mixin:SetAlphaColor(LFGListFrameBottomRight)

     mixin:SetScrollBar(LFGListFrame.ApplicationViewer)
     mixin:SetNineSlice(LFGListFrame.ApplicationViewer.Inset)

     mixin:SetAlphaColor(RaidFinderQueueFrameBackground)

     mixin:HideTexture(RaidFinderFrameRoleBackground)


     --右边
     mixin:HideTexture(PVEFrameLLVert)
     mixin:HideTexture(PVEFrameRLVert)
     mixin:HideTexture(PVEFrameBLCorner)
     mixin:HideTexture(PVEFrameBottomLine)
     mixin:HideTexture(PVEFrameBRCorner)
     mixin:HideTexture(PVEFrameTLCorner)
     mixin:HideTexture(PVEFrameTopLine)
     mixin:HideTexture(PVEFrameTRCorner)


     mixin:SetAlphaColor(PVEFrameBg)--左边


     mixin:HideTexture(PVEFrameBlueBg)
     mixin:HideTexture(PVEFrameLeftInset.Bg)
     mixin:SetNineSlice(PVEFrameLeftInset, nil, true)
     mixin:HideFrame(PVEFrame.shadows)

     mixin:SetAlphaColor(LFDQueueFrameBackground)


     mixin:SetNineSlice(LFDParentFrameInset, nil, true)
     mixin:SetAlphaColor(LFDParentFrameInset.Bg)
     mixin:SetNineSlice(RaidFinderFrameBottomInset, nil, true)
     mixin:SetAlphaColor(RaidFinderFrameBottomInset.Bg)

     mixin:SetAlphaColor(LFDParentFrameRoleBackground)

    mixin:HideTexture(LFDParentFrameRoleBackground)
    mixin:SetNineSlice(RaidFinderFrameRoleInset, nil, true)
    mixin:HideTexture(RaidFinderFrameRoleInset.Bg)


    --GossipFrame
    mixin:SetNineSlice(GossipFrame, true)
     mixin:SetAlphaColor(GossipFrameBg)
     mixin:HideTexture(GossipFrameInset.Bg)
     mixin:SetScrollBar(GossipFrame.GreetingPanel)

     mixin:SetFrame(PVEFrameTab1, {notAlpha=true})
     mixin:SetFrame(PVEFrameTab2, {notAlpha=true})
     mixin:SetFrame(PVEFrameTab3, {notAlpha=true})
     mixin:SetFrame(PVEFrameTab4, {notAlpha=true})

     --[[if PetStableFrame then--猎人，宠物
        mixin:SetNineSlice(PetStableFrame, true)
        mixin:SetNineSlice(PetStableLeftInset, nil, true)
        mixin:SetAlphaColor(PetStableActiveBg, nil, nil, 0.3)
        mixin:SetAlphaColor(PetStableFrameBg)
        mixin:SetNineSlice(PetStableFrameInset, nil, true)
        mixin:HideTexture(PetStableFrameInset.Bg)
        mixin:SetAlphaColor(PetStableFrameModelBg, nil, nil, 0.3)

        mixin:SetAlphaColor(PetStableFrameStableBg, nil, nil, 0.3)

        for i=1, NUM_PET_STABLE_SLOTS do--NUM_PET_STABLE_PAGES * NUM_PET_STABLE_SLOTS do
            if i<=5 then
                mixin:HideTexture(_G['PetStableActivePet'..i..'Background'])
                mixin:SetAlphaColor(_G['PetStableActivePet'..i..'Border'], nil, nil, 0.3)
            end
            mixin:SetAlphaColor(_G['PetStableStabledPet'..i..'Background'])
        end
    end]]





     --背包
     if ContainerFrameCombinedBags and ContainerFrameCombinedBags.NineSlice then
        mixin:SetNineSlice(ContainerFrameCombinedBags, true)

         mixin:SetAlphaColor(ContainerFrameCombinedBags.MoneyFrame.Border.Middle)
         mixin:SetAlphaColor(ContainerFrameCombinedBags.MoneyFrame.Border.Right)
         mixin:SetAlphaColor(ContainerFrameCombinedBags.MoneyFrame.Border.Left)

         mixin:SetAlphaColor(ContainerFrameCombinedBags.Bg.TopSection, true)
         mixin:SetAlphaColor(BagItemSearchBox.Middle)
         mixin:SetAlphaColor(BagItemSearchBox.Left)
         mixin:SetAlphaColor(BagItemSearchBox.Right)
     end
     for i=1 ,NUM_TOTAL_EQUIPPED_BAG_SLOTS + NUM_BANKBAGSLOTS+1 do
         local frame= _G['ContainerFrame'..i]
         if frame and frame.NineSlice then
             mixin:SetAlphaColor(frame.Bg.TopSection, true)
             mixin:SetNineSlice(frame, true)
         end
     end
     for i=1,  NUM_TOTAL_EQUIPPED_BAG_SLOTS+ NUM_REAGENTBAG_FRAMES do--10.25 出现错误
        local frame= _G['ContainerFrame'..i]
        if frame and frame.Bg and frame.Bg:GetObjectType()=='Frame' then
            frame.Bg:SetFrameStrata('BACKGROUND')
        end
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


    for _, text in pairs({
        'CharacterBag0Slot',
        'CharacterBag1Slot',
        'CharacterBag2Slot',
        'CharacterBag3Slot',
        'CharacterReagentBag0Slot',
    }) do
        if _G[text] then
            mixin:SetAlphaColor(_G[text]:GetNormalTexture(), true)
        end
    end


     mixin:HideFrame(CharacterHeadSlot)--1
     mixin:HideFrame(CharacterNeckSlot)--2
     mixin:HideFrame(CharacterShoulderSlot)--3
     mixin:HideFrame(CharacterShirtSlot)--4
     mixin:HideFrame(CharacterChestSlot)--5
     mixin:HideFrame(CharacterWaistSlot)--6
     mixin:HideFrame(CharacterLegsSlot)--7
     mixin:HideFrame(CharacterFeetSlot)--8
     mixin:HideFrame(CharacterWristSlot)--9
     mixin:HideFrame(CharacterHandsSlot)--10
     mixin:HideFrame(CharacterBackSlot)--15
     mixin:HideFrame(CharacterTabardSlot)--19
     mixin:HideFrame(CharacterFinger0Slot)--11
     mixin:HideFrame(CharacterFinger1Slot)--12
     mixin:HideFrame(CharacterTrinket0Slot)--13
     mixin:HideFrame(CharacterTrinket1Slot)--14
     mixin:HideFrame(CharacterMainHandSlot)--16
     mixin:HideFrame(CharacterSecondaryHandSlot)--17

     mixin:SetFrame(CharacterFrameTab1, {notAlpha=true})
     mixin:SetFrame(CharacterFrameTab2, {notAlpha=true})
     mixin:SetFrame(CharacterFrameTab3, {notAlpha=true})

     --好友列表
     mixin:SetNineSlice(FriendsFrame, true)
     mixin:SetAlphaColor(FriendsFrameBg)
     mixin:SetNineSlice(FriendsFrameInset, true)
     mixin:SetAlphaColor(FriendsFrameInset.Bg, nil, nil, 0.3)
     mixin:SetScrollBar(FriendsListFrame)
     mixin:SetScrollBar(IgnoreListFrame)

     mixin:SetFrame(FriendsFrameBattlenetFrame.BroadcastButton, {notAlpha=true})

     --好友列表，召募
     if RecruitAFriendFrame and RecruitAFriendFrame.RecruitList then
        mixin:SetScrollBar(RecruitAFriendFrame.RecruitList)
        mixin:SetAlphaColor(RecruitAFriendFrame.RecruitList.ScrollFrameInset.Bg)
        mixin:SetNineSlice(RecruitAFriendFrame.RewardClaiming.Inset)
        mixin:SetNineSlice(RecruitAFriendFrame.RecruitList.ScrollFrameInset)
        mixin:HideTexture(RecruitAFriendFrame.RecruitList.Header.Background)
        mixin:SetAlphaColor(RecruitAFriendFrame.RewardClaiming.Inset.Bg)

     end
     if RaidInfoFrame then--团队信息
        mixin:HideTexture(RaidInfoDetailHeader)
        mixin:SetAlphaColor(RaidInfoFrame.Header.LeftBG)
        mixin:SetAlphaColor(RaidInfoFrame.Header.CenterBG)
        mixin:SetAlphaColor(RaidInfoFrame.Header.RightBG)
        mixin:SetAlphaColor(RaidInfoDetailFooter)
        mixin:SetAlphaColor(RaidInfoFrame.Border.LeftEdge, nil, nil, 0.3)
        mixin:SetAlphaColor(RaidInfoFrame.Border.RightEdge, nil, nil, 0.3)
        mixin:SetAlphaColor(RaidInfoFrame.Border.TopEdge, nil, nil, 0.3)
        mixin:SetAlphaColor(RaidInfoFrame.Border.BottomEdge, nil, nil, 0.3)
        mixin:SetAlphaColor(RaidInfoFrame.Border.TopLeftCorner, nil, nil, 0.3)
        mixin:SetAlphaColor(RaidInfoFrame.Border.BottomLeftCorner, nil, nil, 0.3)
        mixin:SetAlphaColor(RaidInfoFrame.Border.BottomRightCorner, nil, nil, 0.3)
        mixin:SetAlphaColor(RaidInfoFrame.Border.TopRightCorner, nil, nil, 0.3)
        mixin:SetScrollBar(RaidInfoFrame)
        mixin:SetAlphaColor(RaidInfoFrame.Border.Bg, nil, nil, 0.3)
     end

     mixin:SetNineSlice(WhoFrameListInset, true)
     mixin:SetNineSlice(WhoFrameEditBoxInset, true)
     mixin:HideTexture(WhoFrameListInset.Bg)
     mixin:SetScrollBar(WhoFrame)


     mixin:HideTexture(WhoFrameEditBoxInset.Bg)
     mixin:SetScrollBar(QuickJoinFrame)

     for i=1, 4 do
        mixin:SetFrame(_G['FriendsFrameTab'..i], {notAlpha=true})
        mixin:SetFrame(_G['FriendsTabHeaderTab'..i], {notAlpha=true})
        mixin:SetFrame(_G['WhoFrameColumnHeader'..i], {notAlpha=true})
     end


     --聊天设置     
     mixin:SetAlphaColor(ChannelFrameBg)

     mixin:HideTexture(ChannelFrameInset.Bg)
     mixin:HideTexture(ChannelFrame.RightInset.Bg)
     mixin:HideTexture(ChannelFrame.LeftInset.Bg)

     mixin:SetScrollBar(ChannelFrame.ChannelRoster)
     mixin:SetScrollBar(ChannelFrame.ChannelList)

     mixin:SetNineSlice(ChannelFrame)
     mixin:SetNineSlice(ChannelFrameInset)
     mixin:SetNineSlice(ChannelFrame.RightInset)
     mixin:SetNineSlice(ChannelFrame.LeftInset)


     --任务
     mixin:SetNineSlice(QuestFrame, true)
     mixin:SetAlphaColor(QuestFrameBg)
     mixin:HideTexture(QuestFrameInset.Bg)
     mixin:SetScrollBar(QuestFrame)
     mixin:SetScrollBar(QuestProgressScrollFrame)
     mixin:SetScrollBar(QuestDetailScrollFrame)

     mixin:SetNineSlice(QuestLogPopupDetailFrame, true)
     mixin:SetAlphaColor(QuestLogPopupDetailFrameBg)
     mixin:HideFrame(QuestLogPopupDetailFrameInset)
     mixin:SetScrollBar(QuestLogPopupDetailFrameScrollFrame)
     mixin:SetNineSlice(QuestLogPopupDetailFrameInset, nil, true)

     mixin:SetFrame(QuestModelScene)
     mixin:SetAlphaColor(QuestNPCModelTextFrameBg, nil, nil, 0.3)
     mixin:SetScrollBar(QuestNPCModelTextScrollChildFrame)


     --信箱
     mixin:SetNineSlice(MailFrame, true)
     mixin:SetAlphaColor(MailFrameBg)
     mixin:SetAlphaColor(SendMailMoneyBgRight, nil, nil, 0.3)
     mixin:SetAlphaColor(SendMailMoneyBgLeft, nil, nil, 0.3)
     mixin:SetAlphaColor(SendMailMoneyBgMiddle, nil, nil, 0.3)
     mixin:SetAlphaColor(MailFrameInset.Bg)
     mixin:SetNineSlice(OpenMailFrame, true)
     mixin:SetAlphaColor(OpenMailFrameBg)
     mixin:SetAlphaColor(OpenMailFrameInset.Bg)
     mixin:SetFrame(MailFrameTab1, {notAlpha=true})
     mixin:SetFrame(MailFrameTab2, {notAlpha=true})
     mixin:HideTexture(SendMailMoneyInset.Bg)
     mixin:SetNineSlice(MailFrameInset, true)
     mixin:SetScrollBar(SendMailScrollFrame)
     mixin:SetScrollBar(OpenMailScrollFrame)

     --拾取, 历史
     mixin:SetNineSlice(GroupLootHistoryFrame, true)
     mixin:SetAlphaColor(GroupLootHistoryFrameBg)
     mixin:SetScrollBar(GroupLootHistoryFrame)
     mixin:SetAlphaColor(GroupLootHistoryFrameMiddle)
     mixin:SetAlphaColor(GroupLootHistoryFrameLeft)
     mixin:SetAlphaColor(GroupLootHistoryFrameRight)

     mixin:SetFrame(GroupLootHistoryFrame.ResizeButton, {alpha=0.3})




     --频道, 设置
     mixin:SetNineSlice(ChatConfigCategoryFrame,true)
     mixin:SetNineSlice(ChatConfigBackgroundFrame,true)
     mixin:SetNineSlice(ChatConfigChatSettingsLeft, true)
     mixin:HideTexture(ChatConfigBackgroundFrame.NineSlice.Center)
     mixin:HideTexture(ChatConfigCategoryFrame.NineSlice.Center)
     mixin:HideTexture(ChatConfigChatSettingsLeft.NineSlice.Center)

     mixin:SetScrollBar(ChatConfigCombatSettingsFilters)

     mixin:SetAlphaColor(ChatConfigFrame.Border, nil, nil, 0.3)
     mixin:SetAlphaColor(ChatConfigFrame.Header.RightBG, true)
     mixin:SetAlphaColor(ChatConfigFrame.Header.LeftBG, true)
     mixin:SetAlphaColor(ChatConfigFrame.Header.CenterBG, true)


     for i= 1, 5 do
        mixin:SetFrame(_G['CombatConfigTab'..i], {notAlpha=true})
     end

     hooksecurefunc('ChatConfig_CreateCheckboxes', function(frame)--ChatConfigFrame.lua
        mixin:SetNineSlice(frame, nil, true)
        local checkBoxNameString = frame:GetName().."Checkbox"
        local checkBoxName, checkBox
        for index in pairs(frame.checkBoxTable or {}) do
            checkBoxName = checkBoxNameString..index
            checkBox = _G[checkBoxName]
            if checkBox and checkBox.NineSlice then
                mixin:HideTexture(checkBox.NineSlice.TopEdge)
                mixin:HideTexture(checkBox.NineSlice.RightEdge)
                mixin:HideTexture(checkBox.NineSlice.LeftEdge)
                mixin:HideTexture(checkBox.NineSlice.TopRightCorner)
                mixin:HideTexture(checkBox.NineSlice.TopLeftCorner)
                mixin:HideTexture(checkBox.NineSlice.BottomRightCorner)
                mixin:HideTexture(checkBox.NineSlice.BottomLeftCorner)
            end
        end
    end)
    hooksecurefunc('ChatConfig_UpdateCheckboxes', function(frame)--频道颜色设置 ChatConfigFrame.lua
        if not FCF_GetCurrentChatFrame() then return end

        local checkBoxNameString = frame:GetName().."Checkbox"
        local baseName, colorSwatch
        for index, value in pairs(frame.checkBoxTable or {}) do
            local r,g,b
            baseName = checkBoxNameString..index
            colorSwatch = _G[baseName.."ColorSwatch"]
            if  colorSwatch and not value.isBlank then
                r, g, b = GetMessageTypeColor(value.type)
            end
            r,g,b= r or 1, g or 1, b or 1
            if _G[checkBoxNameString..index.."CheckText"] then
                _G[checkBoxNameString..index.."CheckText"]:SetTextColor(r,g,b)
            end

            local checkBox = _G[checkBoxNameString..index]
            if checkBox and checkBox.NineSlice and checkBox.NineSlice.BottomEdge then
                checkBox.NineSlice.BottomEdge:SetVertexColor(r,g,b)
            end
        end
    end)


    hooksecurefunc('ChatConfig_CreateColorSwatches', function(frame)
        local checkBoxNameString = frame:GetName().."Swatch"
        local checkBoxName, checkBox
        for index in pairs(frame.swatchTable or {}) do
            checkBoxName = checkBoxNameString..index
            checkBox = _G[checkBoxName]
            if checkBox and checkBox.NineSlice then
                mixin:HideTexture(checkBox.NineSlice.TopEdge)
                mixin:HideTexture(checkBox.NineSlice.RightEdge)
                mixin:HideTexture(checkBox.NineSlice.LeftEdge)
                mixin:HideTexture(checkBox.NineSlice.TopRightCorner)
                mixin:HideTexture(checkBox.NineSlice.TopLeftCorner)
                mixin:HideTexture(checkBox.NineSlice.BottomRightCorner)
                mixin:HideTexture(checkBox.NineSlice.BottomLeftCorner)
            end
        end
    end)
    hooksecurefunc('ChatConfig_UpdateSwatches', function(frame)
        if ( not FCF_GetCurrentChatFrame() ) then
            return
        end
        local nameString = frame:GetName().."Swatch"
        local baseName, colorSwatch, r,g,b
        for index, value in ipairs(frame.swatchTable or {}) do
            baseName = nameString..index
            colorSwatch = _G[baseName.."ColorSwatch"]
            if ( colorSwatch ) then
                r,g,b= GetChatUnitColor(value.type)
            end
            r,g,b= r or 1, g or 1, b or 1
            _G[baseName.."Text"]:SetTextColor(r, g, b)
            _G[baseName].NineSlice.BottomEdge:SetVertexColor(r, g, b)
        end
    end)

    mixin:SetNineSlice(CombatConfigColorsUnitColors, nil, true)
    mixin:SetNineSlice(CombatConfigColorsHighlighting, nil, true)
    mixin:SetNineSlice(CombatConfigColorsColorizeUnitName, nil, true)
    mixin:SetNineSlice(CombatConfigColorsColorizeSpellNames, nil, true)
    mixin:SetNineSlice(CombatConfigColorsColorizeDamageNumber, nil, true)
    mixin:SetNineSlice(CombatConfigColorsColorizeDamageSchool, nil, true)
    mixin:SetNineSlice(CombatConfigColorsColorizeEntireLine, nil, true)



     --插件，管理
    mixin:SetNineSlice(AddonList,true)
    mixin:SetScrollBar(AddonList)
    mixin:SetAlphaColor(AddonListBg)
    mixin:SetNineSlice(AddonListInset, true)
    mixin:SetAlphaColor(AddonListInset.Bg, nil, nil, 0.3)
    mixin:SetMenu(AddonList.Dropdown)



     if MainStatusTrackingBarContainer then--货币，XP，追踪，最下面BAR
         mixin:HideTexture(MainStatusTrackingBarContainer.BarFrameTexture)
     end

     --插件，菜单
     mixin:HideFrame(AddonCompartmentFrame, {alpha= 0.3})
     mixin:SetAlphaColor(AddonCompartmentFrame.Text, nil, nil, 0.3)


     mixin:HideTexture(PlayerFrameAlternateManaBarBorder)
     mixin:HideTexture(PlayerFrameAlternateManaBarLeftBorder)
     mixin:HideTexture(PlayerFrameAlternateManaBarRightBorder)

     --小地图
     mixin:SetAlphaColor(MinimapCompassTexture)
     mixin:SetButton(GameTimeFrame)
     if MinimapCluster and MinimapCluster.TrackingFrame then
        mixin:SetButton(MinimapCluster.TrackingFrame.Button, {alpha= 0.3, all=false})
        mixin:SetFrame(MinimapCluster.BorderTop)
     end

     --小队，背景
    mixin:SetFrame(PartyFrame.Background, {alpha= 0.3})

     --任务，追踪柆
     mixin:SetAlphaColor(ScenarioObjectiveTracker.StageBlock.NormalBG, nil, nil, 0.3)

     --社交，按钮
     mixin:SetAlphaColor(QuickJoinToastButton.FriendsButton, nil, nil, 0.5)
     mixin:SetFrame(ChatFrameChannelButton, {alpha= 0.5})
     mixin:SetFrame(ChatFrameMenuButton, {alpha= 0.5})
     mixin:SetFrame(TextToSpeechButton, {alpha= 0.5})


    for i=1, NUM_CHAT_WINDOWS do
    local frame= _G["ChatFrame"..i]
    if frame then
        mixin:SetAlphaColor(_G['ChatFrame'..i..'EditBoxMid'], nil, nil, 0.3)
        mixin:SetAlphaColor(_G['ChatFrame'..i..'EditBoxLeft'], nil, nil, 0.3)
        mixin:SetAlphaColor(_G['ChatFrame'..i..'EditBoxRight'], nil, nil, 0.3)
        mixin:SetScrollBar(frame)
        mixin:SetFrame(frame.ScrollToBottomButton, {notAlpha=true})
    end
    end
    mixin:SetSearchBox(ChatFrame1EditBox)



     --商人
     mixin:SetAlphaColor(MerchantFrameLootFilterMiddle)
     mixin:SetAlphaColor(MerchantFrameLootFilterLeft)
     mixin:SetAlphaColor(MerchantFrameLootFilterRight)
     mixin:SetFrame(MerchantFrameTab1, {notAlpha=true})
     mixin:SetFrame(MerchantFrameTab2, {notAlpha=true})
     mixin:SetScrollBar(MerchantFrame)
     mixin:SetNineSlice(MerchantFrameInset, true)
     mixin:SetNineSlice(MerchantFrame, true)
     mixin:SetMenu(MerchantFrame.FilterDropdown)

     mixin:SetAlphaColor(MerchantMoneyInset.Bg)
     mixin:HideTexture(MerchantMoneyBgMiddle)
     mixin:HideTexture(MerchantMoneyBgLeft)
     mixin:HideTexture(MerchantMoneyBgRight)
     mixin:SetAlphaColor(MerchantExtraCurrencyBg)
     mixin:SetAlphaColor(MerchantExtraCurrencyInset)
     mixin:HideTexture(MerchantFrameBottomLeftBorder)

     C_Timer.After(2, function()

        WoWTools_PlusTextureMixin:HideTexture(SpellFlyout.Background.Start)
        WoWTools_PlusTextureMixin:HideTexture(SpellFlyout.Background.End)
        WoWTools_PlusTextureMixin:HideTexture(SpellFlyout.Background.HorizontalMiddle)
        WoWTools_PlusTextureMixin:HideTexture(SpellFlyout.Background.VerticalMiddle)


         local libDBIcon = LibStub("LibDBIcon-1.0", true)
         if libDBIcon and libDBIcon.objects then
            for name in pairs(libDBIcon.objects) do
                mixin:SetFrame(_G['LibDBIcon10_'..name], {index=2})
            end
         end

         --商人, SellBuy.lua
         for i=1, math.max(MERCHANT_ITEMS_PER_PAGE, BUYBACK_ITEMS_PER_PAGE) do --MERCHANT_ITEMS_PER_PAGE = 10 BUYBACK_ITEMS_PER_PAGE = 12
             mixin:SetAlphaColor(_G['MerchantItem'..i..'SlotTexture'])
         end
         mixin:HideTexture(MerchantBuyBackItemSlotTexture)
     end)

     mixin:SetAlphaColor(StackSplitFrame.SingleItemSplitBackground, true)
     mixin:SetAlphaColor(StackSplitFrame.MultiItemSplitBackground, true)
     mixin:HideFrame(MerchantRepairItemButton, {index=1})
     mixin:HideFrame(MerchantRepairAllButton, {index=1})
     mixin:HideFrame(MerchantGuildBankRepairButton, {index=1})
     mixin:HideFrame(MerchantSellAllJunkButton, {index=1})


    --考古学 ArchaeologyProgressBar.xml
    if ArcheologyDigsiteProgressBar then
        mixin:SetAlphaColor(ArcheologyDigsiteProgressBar.BarBorderAndOverlay, true)
        mixin:HideTexture(ArcheologyDigsiteProgressBar.Shadow)
        --ArcheologyDigsiteProgressBar.BarTitle:SetTextColor(e.Player.r, e.Player.g, e.Player.b)
        ArcheologyDigsiteProgressBar.BarTitle:SetShadowOffset(1, -1)
        mixin:HideTexture(ArcheologyDigsiteProgressBar.BarBackground)
    end







    --颜色
    mixin:SetFrame(ColorPickerFrame.Header, {alpha= 0.3})
    mixin:SetFrame(ColorPickerFrame.Border, {alpha= 0.3})

    --编辑模式
    mixin:SetScrollBar(EditModeManagerFrame.AccountSettings.SettingsContainer)
    mixin:SetFrame(EditModeManagerFrame.Border, {alpha=0.3})
    mixin:SetFrame(EditModeManagerFrame.AccountSettings.SettingsContainer.BorderArt, {alpha=0.3})
    mixin:SetSlider(EditModeManagerFrame.GridSpacingSlider)

    mixin:SetFrame(BNToastFrame, {alpha=0.3})



    --ReportFrame
    mixin:SetFrame(ReportFrame)
    mixin:SetFrame(ReportFrame.Border)
    mixin:HideTexture(ReportFrame.BottomInset)
    mixin:HideTexture(ReportFrame.TopInset)
    mixin:SetFrame(ReportFrame.CloseButton, {notAlpha=true})

    mixin:SetScrollBar(ReportFrame.Comment)

    mixin:SetFrame(BattleTagInviteFrame.Border, {notAlpha=true})

    --就绪
    mixin:SetNineSlice(ReadyCheckListenerFrame, true)
    mixin:SetAlphaColor(ReadyCheckListenerFrame.Bg, true)

    --团队 RolePoll.lua
    mixin:SetFrame(RolePollPopup.Border, {notAlpha=true})

    --对话框
    mixin:SetFrame(StaticPopup1.Border, {notAlpha=true})
    mixin:SetAlphaColor(StaticPopup1.Border.Bg, true)

    --ItemTextFrame
    mixin:SetNineSlice(ItemTextFrame, true)
    mixin:HideTexture(ItemTextFrameBg)
    mixin:HideFrame(ItemTextFrameInset)
    mixin:SetAlphaColor(ItemTextMaterialTopLeft, nil, nil, 0.3)
    mixin:SetAlphaColor(ItemTextMaterialTopRight, nil, nil, 0.3)
    mixin:SetAlphaColor(ItemTextMaterialBotLeft, nil, nil, 0.3)
    mixin:SetAlphaColor(ItemTextMaterialBotRight, nil, nil, 0.3)
    mixin:SetScrollBar(ItemTextScrollFrame)
    mixin:SetNineSlice(ItemTextFrameInset, true)

    --试衣间
    mixin:SetNineSlice(DressUpFrame, true)
    mixin:SetAlphaColor(DressUpFrameBg)
    mixin:HideTexture(DressUpFrameInset.Bg)
    mixin:SetFrame(DressUpFrameInset)
    mixin:SetAlphaColor(DressUpFrame.ModelBackground, nil, nil, 0.3)
    mixin:SetFrame(DressUpFrame.OutfitDetailsPanel, {alpha=0.3})
    mixin:SetAlphaColor(DressUpFrame.OutfitDetailsPanel.BlackBackground)



    if ExpansionLandingPage then
        hooksecurefunc(ExpansionLandingPage, 'RefreshExpansionOverlay', function(self)
            if self.overlayFrame then
                mixin:SetAlphaColor(self.overlayFrame.Background, nil, nil, 0.3)
                mixin:HideTexture(self.overlayFrame.ScrollFadeOverlay)
            end
        end)
    end
end







 --公会和社区 Blizzard_Communities
local function Blizzard_Communities(mixin)
    mixin:SetNineSlice(CommunitiesFrame, true)
    mixin:SetScrollBar(CommunitiesFrameCommunitiesList)
    mixin:SetScrollBar(CommunitiesFrame.Chat)
    mixin:SetScrollBar(CommunitiesFrame.MemberList)
    mixin:SetScrollBar(CommunitiesFrame.GuildBenefitsFrame.Rewards)
    mixin:SetScrollBar(CommunitiesFrameGuildDetailsFrameNews)
    mixin:SetScrollBar(ClubFinderCommunityAndGuildFinderFrame.CommunityCards)

    mixin:SetAlphaColor(CommunitiesFrameBg)
    mixin:SetAlphaColor(CommunitiesFrame.MemberList.ColumnDisplay.Background)
    mixin:SetAlphaColor(CommunitiesFrameCommunitiesList.Bg)
    mixin:SetAlphaColor(CommunitiesFrameInset.Bg, nil, nil, 0.3)
    mixin:SetNineSlice(CommunitiesFrameInset, nil, true)
    mixin:SetNineSlice(CommunitiesFrameCommunitiesList.InsetFrame, true)
    CommunitiesFrame.GuildBenefitsFrame.Perks:DisableDrawLayer('BACKGROUND')
    CommunitiesFrameGuildDetailsFrameInfo:DisableDrawLayer('BACKGROUND')
    CommunitiesFrameGuildDetailsFrameNews:DisableDrawLayer('BACKGROUND')

    mixin:SetSearchBox(CommunitiesFrame.ChatEditBox)
    mixin:SetNineSlice(CommunitiesFrame.Chat.InsetFrame, true)
    mixin:SetNineSlice(CommunitiesFrame.MemberList.InsetFrame, true)
    mixin:SetAlphaColor(CommunitiesFrameMiddle)

    mixin:SetNineSlice(ClubFinderCommunityAndGuildFinderFrame.InsetFrame, nil, true)
    mixin:HideTexture(CommunitiesFrame.GuildBenefitsFrame.Rewards.Bg)

    hooksecurefunc(CommunitiesFrameCommunitiesList,'UpdateCommunitiesList',function()
        C_Timer.After(0.3, function()
             local frame= CommunitiesFrameCommunitiesList.ScrollBox
            if not frame or not frame:GetView() then
                return
            end
            for _, button in pairs(frame:GetFrames() or {}) do
                mixin:SetAlphaColor(button.Background)
            end
        end)
    end)

    mixin:SetAlphaColor(ClubFinderCommunityAndGuildFinderFrame.InsetFrame.Bg)

    mixin:HideFrame(CommunitiesFrame.ChatTab, {index=1})
    mixin:HideFrame(CommunitiesFrame.RosterTab, {index=1})
    mixin:HideFrame(CommunitiesFrame.GuildBenefitsTab, {index=1})
    mixin:HideFrame(CommunitiesFrame.GuildInfoTab, {index=1})

    mixin:SetFrame(CommunitiesFrame.AddToChatButton, {notAlpha=true})

    mixin:HideFrame(ClubFinderCommunityAndGuildFinderFrame.ClubFinderSearchTab, {index=1})
    mixin:HideFrame(ClubFinderCommunityAndGuildFinderFrame.ClubFinderPendingTab, {index=1})

    mixin:SetAlphaColor(ClubFinderGuildFinderFrame.InsetFrame.Bg)

    mixin:SetFrame(CommunitiesFrame.NotificationSettingsDialog.Selector)
    mixin:SetScrollBar(CommunitiesFrame.NotificationSettingsDialog.ScrollFrame)
    mixin:SetAlphaColor(CommunitiesFrame.NotificationSettingsDialog.BG, {notAlpha=true})


    mixin:SetFrame(GuildControlUI)
    mixin:SetFrame(GuildControlUIHbar)

    mixin:SetFrame(CommunitiesGuildLogFrame)
    mixin:SetNineSlice(CommunitiesGuildLogFrame.Container, true)
    mixin:SetScrollBar(CommunitiesGuildLogFrame.Container.ScrollFrame)


    mixin:SetMenu(ClubFinderGuildFinderFrame.OptionsList.ClubFilterDropdown)
    mixin:SetMenu(ClubFinderGuildFinderFrame.OptionsList.ClubSizeDropdown)


--霸业风暴商店
    if AccountStoreFrame then
        mixin:HideTexture(AccountStoreFrame.LeftInset.Bg)
        mixin:HideTexture(AccountStoreFrame.RightInset.Bg)
        mixin:SetFrame(AccountStoreFrame.LeftDisplay, {alpha=0.3})
        mixin:HideTexture(AccountStoreFrameBg)

        mixin:SetNineSlice(AccountStoreFrame)
        mixin:SetScrollBar(AccountStoreFrame.CategoryList)
        mixin:SetInset(AccountStoreFrame.RightInset)
        mixin:SetInset(AccountStoreFrame.LeftInset)
    end
end











function WoWTools_PlusTextureMixin:Init_All_Frame()
    do
        Init(self)
        Blizzard_Communities(self)
    end
    Init=function()end
    Blizzard_Communities=function()end
end