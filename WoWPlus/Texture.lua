local id, e= ...
local addName= TEXTURES_SUBHEADER
local Save={
    --disabledTexture= true,
    --disabledColor=true,

    --disabledAlpha= not e.Player.husandro,
    alpha= 0.5,

    --disabledChatBubble=true,--禁用，聊天泡泡
    chatBubbleAlpha= 0.5,--聊天泡泡
    chatBubbleSacal= 0.85,

    classPowerNum= e.Player.husandro,--职业，显示数字
    classPowerNumSize= 12,
    --disabledMainMenu= not e.Player.husandro, --主菜单，颜色，透明度
}
local panel=CreateFrame("Frame")


local function hide_Texture(self, notClear)
    if self then
        if self:GetObjectType()=='Texture' then
            if not notClear then
                self:SetTexture(0)
            end
        end
        self:SetShown(false)
    end
end

local function set_Alpha_Color(self, notAlpha, notColor, alpha)
    if not self or (notColor and notAlpha) or Save.disabledAlpha then
        return
    end
    local type= self:GetObjectType()
    if Save.disabledAlpha or notAlpha then
        alpha=nil
    else
        alpha= alpha or Save.alpha
    end
    e.Set_Label_Texture_Color(self, {type=type, alpha= alpha})
end

local function set_Button_Alpha(btn, tab)
    if Save.disabledAlpha or not btn then
        return
    end
    local alpha= tab and tab.alpha or Save.alpha
    alpha= alpha<0.3 and 0.3 or alpha
    e.Set_Label_Texture_Color(btn, {type='Button', alpha= alpha})
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

--透明度, 颜色, frame, 子材质 set_Alpha_Frame_Texture(frame, {index=nil, notAlpha=nil, notColor=nil})
local function set_Alpha_Frame_Texture(frame, tab)
    if frame and not (Save.disabledColor and Save.disabledAlpha) then
        tab=tab or {}
        local indexTexture= tab.index
        local notColor= tab.notColor
        --local notAlpha= tab.notAlpha
        local alpha
        if (not Save.disabledAlpha and not tab.notAlpha) then
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
end















































--###############
--初始化, 隐藏材质
--###############
local function Init_HideTexture()
    if Save.disabledTexture then
        return
    end

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

    if MainMenuBar and MainMenuBar.EndCaps then hide_Texture(MainMenuBar.EndCaps.LeftEndCap) end
    if MainMenuBar and MainMenuBar.EndCaps then hide_Texture(MainMenuBar.EndCaps.RightEndCap) end

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

    hooksecurefunc(HelpTip,'Show', function(self, parent, info, relativeRegion)--隐藏所有HelpTip HelpTip.lua
        HelpTip:HideAll(parent)
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
                print(id, addName, '|cffff00ff'..content)
            end)
        end
    end)

    if MainMenuBar and MainMenuBar.BorderArt then--主动作条
        hide_Texture(MainMenuBar.BorderArt.TopEdge)
        hide_Texture(MainMenuBar.BorderArt.BottomEdge)
        hide_Texture(MainMenuBar.BorderArt.LeftEdge)
        hide_Texture(MainMenuBar.BorderArt.RightEdge)
        hide_Texture(MainMenuBar.BorderArt.TopLeftCorner)
        hide_Texture(MainMenuBar.BorderArt.BottomLeftCorner)
        hide_Texture(MainMenuBar.BorderArt.TopRightCorner)
        hide_Texture(MainMenuBar.BorderArt.BottomRightCorner)
    end
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

    --######
    --动作条
    --######
    local KEY_BUTTON_Tab={
        [KEY_BUTTON1]= 'ML',--鼠标左键";
        [KEY_BUTTON3]= 'MR',--鼠标中键";
        [KEY_BUTTON2]= 'MM',--鼠标右键";
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
    local function hideButtonText(self)
        if self then
            hide_Texture(self.SlotArt)
            hide_Texture(self.SlotBackground)--背景，
            hide_Texture(self.NormalTexture)--外框，方块
            if self.RightDivider and self.BottomDivider then
                self.RightDivider:SetShown(false)--frame
                self.BottomDivider:SetShown(false)
                hide_Texture(self.RightDivider.TopEdge)
                hide_Texture(self.RightDivider.BottomEdge)
                hide_Texture(self.RightDivider.Center)
            end
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
                --self.cooldown:SetBlingTexture('Interface\\Cooldown\\star4')--闪光
                --self.cooldown:SetEdgeTexture("Interface\\Cooldown\\edge", 1,0,0,1);
                self.cooldown:SetCountdownFont('NumberFontNormal')
            end
        end
    end
    hooksecurefunc('CooldownFrame_Set', function(self, start, duration, enable, forceShowDrawEdge, modRate)
        if enable and enable ~= 0 and start > 0 and duration > 0 then
            self:SetDrawEdge(true)--冷却动画的移动边缘绘制亮线
        end
    end)
    C_Timer.After(2, function()
        for i=1, 12 do
            hideButtonText(_G['ActionButton'..i])--主动作条
            hideButtonText(_G['MultiBarBottomLeftButton'..i])--作条2
            hideButtonText(_G['MultiBarBottomRightButton'..i])--作条3
            hideButtonText(_G['MultiBarLeftButton'..i])--作条4
            hideButtonText(_G['MultiBarRightButton'..i])--作条5
            for index=5, 7 do
                hideButtonText(_G['MultiBar'..index..'Button'..i])--作条6, 7, 8
            end
        end
        MainMenuBar.Background:SetShown(false)
    end)
end










































local function set_HideTexture_Event(arg1)
    if Save.disabledTexture then
        return
    end

    if arg1=='Blizzard_WeeklyRewards' then--周奖励提示
        hooksecurefunc(WeeklyRewardsFrame,'UpdateOverlay', function(self)--Blizzard_WeeklyRewards.lua
            if self.Overlay and self.Overlay:IsShown() then--未提取,提示
                self.Overlay:SetScale(0.4)
                self.Overlay:ClearAllPoints()
                self.Overlay:SetPoint('TOPLEFT', 80,-60)
            end
        end)
        if WeeklyRewardExpirationWarningDialog and WeeklyRewardExpirationWarningDialog:IsShown() then
            if WeeklyRewardExpirationWarningDialog.Description then
                print(id, addName, '|cffff00ff'..WeeklyRewardExpirationWarningDialog.Description:GetText())
                WeeklyRewardExpirationWarningDialog:Hide()
            else
                C_Timer.After(5, function()
                    WeeklyRewardExpirationWarningDialog:Hide()
                end)
            end
        end
    end
end





































--###########
--初始化, 透明
--###########
local function Init_Set_AlphaAndColor()
    if Save.disabledAlpha then
        return
    end


    set_Alpha_Color(PlayerCastingBarFrame.Border)
    set_Alpha_Color(PlayerCastingBarFrame.Background)
    set_Alpha_Color(PlayerCastingBarFrame.TextBorder)
    set_Alpha_Color(PlayerCastingBarFrame.Shine)

    --角色，界面
    set_Alpha_Color(CharacterFrameBg)
    hide_Texture(CharacterFrameInset.Bg)
    set_Alpha_Color(CharacterFrame.NineSlice.TopEdge)
    set_Alpha_Color(CharacterFrame.NineSlice.BottomEdge)
    set_Alpha_Color(CharacterFrame.NineSlice.LeftEdge)
    set_Alpha_Color(CharacterFrame.NineSlice.RightEdge)

    set_Alpha_Color(CharacterFrame.NineSlice.TopRightCorner)
    set_Alpha_Color(CharacterFrame.NineSlice.TopLeftCorner)
    set_Alpha_Color(CharacterFrame.NineSlice.BottomRightCorner)
    set_Alpha_Color(CharacterFrame.NineSlice.BottomLeftCorner)

    hide_Texture(CharacterFrameInsetRight.Bg)
    set_Alpha_Color(CharacterStatsPane.ClassBackground)
    set_Alpha_Color(CharacterStatsPane.EnhancementsCategory.Background)
    set_Alpha_Color(CharacterStatsPane.AttributesCategory.Background)
    set_Alpha_Color(CharacterStatsPane.ItemLevelCategory.Background)
    hooksecurefunc('PaperDollTitlesPane_UpdateScrollBox', function()--PaperDollFrame.lua
        for _, button in pairs(PaperDollFrame.TitleManagerPane.ScrollBox:GetFrames()) do
            hide_Texture(button.BgMiddle)
        end
    end)
    hide_Texture(PaperDollFrame.TitleManagerPane.ScrollBar.Backplate)
    hooksecurefunc('PaperDollEquipmentManagerPane_Update', function()--PaperDollFrame.lua
        for _, button in pairs(PaperDollFrame.EquipmentManagerPane.ScrollBox:GetFrames()) do
            hide_Texture(button.BgMiddle)
        end
    end)
    hide_Texture(PaperDollFrame.EquipmentManagerPane.ScrollBar.Backplate)
    hide_Texture(ReputationFrame.ScrollBar.Backplate)
    hide_Texture(TokenFrame.ScrollBar.Backplate)

    hide_Texture(CharacterModelFrameBackgroundTopLeft)--角色3D背景
    hide_Texture(CharacterModelFrameBackgroundTopRight)
    hide_Texture(CharacterModelFrameBackgroundBotLeft)
    hide_Texture(CharacterModelFrameBackgroundBotRight)
    hide_Texture(CharacterModelFrameBackgroundOverlay)

    --法术书
    set_Alpha_Color(SpellBookFrame.NineSlice.TopLeftCorner)
    set_Alpha_Color(SpellBookFrame.NineSlice.TopEdge)
    set_Alpha_Color(SpellBookFrame.NineSlice.TopRightCorner)
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

    set_Alpha_Frame_Texture(SpellBookFrameTabButton1, {alpha=Save.alpha<0.3 and 0.3})
    set_Alpha_Frame_Texture(SpellBookFrameTabButton2, {alpha=Save.alpha<0.3 and 0.3})
    set_Alpha_Frame_Texture(SpellBookFrameTabButton3, {alpha=Save.alpha<0.3 and 0.3})


    --世界地图
    set_Alpha_Color(WorldMapFrame.BorderFrame.NineSlice.TopLeftCorner)
    set_Alpha_Color(WorldMapFrame.BorderFrame.NineSlice.TopEdge)
    set_Alpha_Color(WorldMapFrame.BorderFrame.NineSlice.TopRightCorner)
    set_Alpha_Color(WorldMapFrameBg)
    set_Alpha_Color(QuestMapFrame.Background)
    WorldMapFrame.NavBar:DisableDrawLayer('BACKGROUND')

    --地下城和团队副本
    set_Alpha_Color(PVEFrame.NineSlice.TopLeftCorner)
    set_Alpha_Color(PVEFrame.NineSlice.TopEdge)
    set_Alpha_Color(PVEFrame.NineSlice.TopRightCorner)
    set_Alpha_Color(LFGListFrame.CategorySelection.Inset.CustomBG)
    hide_Texture(LFGListFrame.CategorySelection.Inset.Bg)
    set_Alpha_Color(LFGListFrame.SearchPanel.SearchBox.Middle)
    set_Alpha_Color(LFGListFrame.SearchPanel.SearchBox.Left)
    set_Alpha_Color(LFGListFrame.SearchPanel.SearchBox.Right)
    set_Alpha_Color(LFGListFrame.SearchPanel.ScrollBar.Backplate)
    set_Alpha_Color(LFGListFrame.EntryCreation.Inset.CustomBG)
    set_Alpha_Color(LFGListFrame.EntryCreation.Inset.Bg)
    set_Alpha_Color(LFGListFrameMiddleMiddle)
    set_Alpha_Color(LFGListFrameMiddleLeft)
    set_Alpha_Color(LFGListFrameMiddleRight)
    set_Alpha_Color(LFGListFrameBottomMiddle)
    set_Alpha_Color(LFGListFrameTopMiddle)
    set_Alpha_Color(LFGListFrameTopLeft)
    set_Alpha_Color(LFGListFrameBottomLeft)
    set_Alpha_Color(LFGListFrameTopRight)
    set_Alpha_Color(LFGListFrameBottomRight)
    set_Alpha_Color(RaidFinderFrameBottomInset.Bg)
    set_Alpha_Color(RaidFinderQueueFrameBackground)
    set_Alpha_Color(RaidFinderQueueFrameSelectionDropDownMiddle)
    set_Alpha_Color(RaidFinderQueueFrameSelectionDropDownLeft)
    set_Alpha_Color(RaidFinderQueueFrameSelectionDropDownRight)
    set_Alpha_Color(RaidFinderFrameRoleBackground, nil, true)
    set_Alpha_Color(RaidFinderFrameRoleInset.Bg)

    hide_Texture(PVEFrameBg)--左边
    hide_Texture(PVEFrameBlueBg)
    set_Alpha_Color(PVEFrameLeftInset.Bg)

    set_Alpha_Color(LFDQueueFrameBackground)
    set_Alpha_Color(LFDQueueFrameTypeDropDownMiddle)
    set_Alpha_Color(LFDQueueFrameTypeDropDownRight)
    set_Alpha_Color(LFDQueueFrameTypeDropDownLeft)

    set_Alpha_Color(LFDParentFrameInset.Bg)
    set_Alpha_Color(LFDParentFrameRoleBackground)


    set_Alpha_Color(GossipFrame.NineSlice.TopEdge)
    set_Alpha_Color(GossipFrame.NineSlice.TopLeftCorner)
    set_Alpha_Color(GossipFrame.NineSlice.TopRightCorner)
    set_Alpha_Color(GossipFrameBg)
    hide_Texture(GossipFrameInset.Bg)
    hide_Texture(GossipFrame.GreetingPanel.ScrollBar.Backplate)

    set_Alpha_Frame_Texture(PVEFrameTab1, {alpha=Save.alpha<0.3 and 0.3})
    set_Alpha_Frame_Texture(PVEFrameTab2, {alpha=Save.alpha<0.3 and 0.3})
    set_Alpha_Frame_Texture(PVEFrameTab3, {alpha=Save.alpha<0.3 and 0.3})

    if PetStableFrame then--猎人，宠物
        set_Alpha_Color(PetStableFrame.NineSlice.TopEdge)
        set_Alpha_Color(PetStableFrame.NineSlice.TopLeftCorner)
        set_Alpha_Color(PetStableFrame.NineSlice.TopRightCorner)
        --set_Alpha_Color(PetStableFrame.NineSlice)
        set_Alpha_Color(PetStableFrameModelBg)
        hide_Texture(PetStableFrameInset.Bg)
        set_Alpha_Color(PetStableFrameBg)
        set_Alpha_Color(PetStableFrameStableBg)
        set_Alpha_Color(PetStableActiveBg)
        for i=1, NUM_PET_STABLE_SLOTS do--NUM_PET_STABLE_PAGES * NUM_PET_STABLE_SLOTS do
            if i<=5 then
                hide_Texture(_G['PetStableActivePet'..i..'Background'])
                set_Alpha_Color(_G['PetStableActivePet'..i..'Border'])
            end
            set_Alpha_Color(_G['PetStableStabledPet'..i..'Background'])
        end
    end



    set_Alpha_Color(MerchantFrameLootFilterMiddle)
    set_Alpha_Color(MerchantFrameLootFilterLeft)
    set_Alpha_Color(MerchantFrameLootFilterRight)
    set_Alpha_Color(MerchantFrameBottomLeftBorder)
    set_Alpha_Frame_Texture(MerchantFrameTab1)
    set_Alpha_Frame_Texture(MerchantFrameTab2)

    --银行
    set_Alpha_Color(BankFrame.NineSlice.TopEdge)
    set_Alpha_Color(BankFrame.NineSlice.TopLeftCorner)
    set_Alpha_Color(BankFrame.NineSlice.TopRightCorner)

    hide_Texture(BankFrameMoneyFrameInset.Bg)
    hide_Texture(BankFrameMoneyFrameBorderMiddle)
    hide_Texture(BankFrameMoneyFrameBorderRight)
    hide_Texture(BankFrameMoneyFrameBorderLeft)
    hide_Texture(BankFrameMoneyFrameInset.NineSlice)

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
    set_Alpha_Color(BankFrameTab1.LeftActive)
    set_Alpha_Color(BankFrameTab1.MiddleActive)
    set_Alpha_Color(BankFrameTab1.RightActive)
    set_Alpha_Color(BankFrameTab1.Left)
    set_Alpha_Color(BankFrameTab1.Middle)
    set_Alpha_Color(BankFrameTab1.Right)
    set_Alpha_Color(BankFrameTab2.LeftActive)
    set_Alpha_Color(BankFrameTab2.MiddleActive)
    set_Alpha_Color(BankFrameTab2.RightActive)
    set_Alpha_Color(BankFrameTab2.Left)
    set_Alpha_Color(BankFrameTab2.Middle)
    set_Alpha_Color(BankFrameTab2.Right)

    --背包
    if ContainerFrameCombinedBags and ContainerFrameCombinedBags.NineSlice then
        set_Alpha_Color(ContainerFrameCombinedBags.NineSlice.TopEdge)
        set_Alpha_Color(ContainerFrameCombinedBags.NineSlice.LeftEdge)
        set_Alpha_Color(ContainerFrameCombinedBags.NineSlice.RightEdge)

        set_Alpha_Color(ContainerFrameCombinedBags.NineSlice.BottomEdge)

        set_Alpha_Color(ContainerFrameCombinedBags.NineSlice.TopLeftCorner)
        set_Alpha_Color(ContainerFrameCombinedBags.NineSlice.TopRightCorner)
        set_Alpha_Color(ContainerFrameCombinedBags.NineSlice.BottomRightCorner)
        set_Alpha_Color(ContainerFrameCombinedBags.NineSlice.BottomLeftCorner)
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
            set_Alpha_Color(frame.NineSlice.TopEdge)
            set_Alpha_Color(frame.NineSlice.TopLeftCorner)
            set_Alpha_Color(frame.NineSlice.TopRightCorner)
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

    set_Alpha_Frame_Texture(CharacterFrameTab1, {alpha=Save.alpha<0.3 and 0.3})
    set_Alpha_Frame_Texture(CharacterFrameTab2, {alpha=Save.alpha<0.3 and 0.3})
    set_Alpha_Frame_Texture(CharacterFrameTab3, {alpha=Save.alpha<0.3 and 0.3})

    --好友列表
    set_Alpha_Color(FriendsFrame.NineSlice.TopEdge)
    set_Alpha_Color(FriendsFrame.NineSlice.TopLeftCorner)
    set_Alpha_Color(FriendsFrame.NineSlice.TopRightCorner)
    set_Alpha_Color(FriendsFrameBg)
    --hide_Texture(FriendsFrameInset.Bg)
    hide_Texture(FriendsListFrame.ScrollBar.Backplate)
    hide_Texture(IgnoreListFrame.ScrollBar.Backplate)
    if RecruitAFriendFrame and RecruitAFriendFrame.RecruitList then
        hide_Texture(RecruitAFriendFrame.RecruitList.ScrollBar.Backplate)
        set_Alpha_Color(RecruitAFriendFrame.RecruitList.ScrollFrameInset.Bg)
    end
    hide_Texture(WhoFrameListInset.Bg)
    hide_Texture(WhoFrame.ScrollBar.Backplate)
    set_Alpha_Color(WhoFrameDropDownMiddle)
    set_Alpha_Color(WhoFrameDropDownLeft)
    set_Alpha_Color(WhoFrameDropDownRight)
    hide_Texture(WhoFrameEditBoxInset.Bg)
    hide_Texture(QuickJoinFrame.ScrollBar.Backplate)

    set_Alpha_Frame_Texture(FriendsFrameTab1, {alpha=Save.alpha<0.3 and 0.3})
    set_Alpha_Frame_Texture(FriendsFrameTab2, {alpha=Save.alpha<0.3 and 0.3})
    set_Alpha_Frame_Texture(FriendsFrameTab3, {alpha=Save.alpha<0.3 and 0.3})
    set_Alpha_Frame_Texture(FriendsFrameTab4, {alpha=Save.alpha<0.3 and 0.3})

    --聊天设置
    set_Alpha_Color(ChannelFrame.NineSlice.TopEdge)
    set_Alpha_Color(ChannelFrame.NineSlice.TopLeftCorner)
    set_Alpha_Color(ChannelFrame.NineSlice.TopRightCorner)
    set_Alpha_Color(ChannelFrameBg)
    hide_Texture(ChannelFrameInset.Bg)
    hide_Texture(ChannelFrame.RightInset.Bg)
    hide_Texture(ChannelFrame.LeftInset.Bg)
    hide_Texture(ChannelFrame.ChannelRoster.ScrollBar.Backplate)

    --任务
    set_Alpha_Color(QuestFrame.NineSlice.TopEdge)
    set_Alpha_Color(QuestFrame.NineSlice.TopLeftCorner)
    set_Alpha_Color(QuestFrame.NineSlice.TopRightCorner)
    set_Alpha_Color(QuestFrameBg)
    hide_Texture(QuestFrameInset.Bg)

    --信箱
    set_Alpha_Color(MailFrame.NineSlice.TopEdge)
    set_Alpha_Color(MailFrame.NineSlice.TopLeftCorner)
    set_Alpha_Color(MailFrame.NineSlice.TopRightCorner)
    set_Alpha_Color(MailFrameBg)
    hide_Texture(InboxFrameBg)
    hide_Texture(MailFrameInset.Bg)
    set_Alpha_Color(OpenMailFrame.NineSlice)
    set_Alpha_Color(OpenMailFrameBg)
    set_Alpha_Color(OpenMailFrameInset.Bg)

    set_Alpha_Frame_Texture(MailFrameTab1)
    set_Alpha_Frame_Texture(MailFrameTab2)

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

    set_Alpha_Color(SendMailMoneyBgMiddle)
    set_Alpha_Color(SendMailMoneyBgRight)
    set_Alpha_Color(SendMailMoneyBgLeft)
    hide_Texture(SendMailMoneyInset.Bg)
    set_Alpha_Color(MailFrame.NineSlice.LeftEdge)
    set_Alpha_Color(MailFrame.NineSlice.RightEdge)
    set_Alpha_Color(MailFrame.NineSlice.BottomRightCorner)
    set_Alpha_Color(MailFrame.NineSlice.BottomLeftCorner)
    set_Alpha_Color(MailFrame.NineSlice.BottomEdge)
    set_Alpha_Color(MailFrameInset.NineSlice.LeftEdge)


    --拾取, 历史
    set_Alpha_Color(GroupLootHistoryFrame.NineSlice.TopRightCorner)
    set_Alpha_Color(GroupLootHistoryFrame.NineSlice.TopEdge)
    set_Alpha_Color(GroupLootHistoryFrame.NineSlice.TopLeftCorner)
    set_Alpha_Color(GroupLootHistoryFrame.NineSlice.RightEdge)
    set_Alpha_Color(GroupLootHistoryFrame.NineSlice.LeftEdge)
    set_Alpha_Color(GroupLootHistoryFrame.NineSlice.BottomLeftCorner)
    set_Alpha_Color(GroupLootHistoryFrame.NineSlice.BottomRightCorner)
    set_Alpha_Color(GroupLootHistoryFrame.NineSlice.BottomEdge)
    set_Alpha_Color(GroupLootHistoryFrameBg)
    set_Alpha_Color(GroupLootHistoryFrame.ScrollBar.Track.Middle)
    set_Alpha_Color(GroupLootHistoryFrame.ScrollBar.Track.Begin)
    set_Alpha_Color(GroupLootHistoryFrame.ScrollBar.Track.End)

    set_Alpha_Color(GroupLootHistoryFrameMiddle)
    set_Alpha_Color(GroupLootHistoryFrameLeft)
    set_Alpha_Color(GroupLootHistoryFrameRight)
    set_Alpha_Color()




    --频道, 设置
    hide_Texture(ChatConfigCategoryFrame.NineSlice.Center)
    hide_Texture(ChatConfigBackgroundFrame.NineSlice.Center)
    hide_Texture(ChatConfigChatSettingsLeft.NineSlice.Center)

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
    set_Alpha_Color(AddonList.NineSlice.TopEdge)
    set_Alpha_Color(AddonList.NineSlice.TopLeftCorner)
    set_Alpha_Color(AddonList.NineSlice.TopRightCorner)
    set_Alpha_Color(AddonListBg)
    set_Alpha_Color(AddonListInset.Bg)
    hide_Texture(AddonList.ScrollBar.Backplate)
    set_Alpha_Color(AddonCharacterDropDownMiddle)
    set_Alpha_Color(AddonCharacterDropDownLeft)
    set_Alpha_Color(AddonCharacterDropDownRight)

    --场景 Blizzard_ScenarioObjectiveTracker.lua
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
    hide_Frame_Texture(AddonCompartmentFrame, {alpha= Save.alpha<=0.3 and 0.3})
    set_Alpha_Color(AddonCompartmentFrame.Text, nil, nil, Save.alpha<=0.3 and 0.3)
    C_Timer.After(2, function()
        AddonCompartmentFrame:HookScript('OnEnter', function(self)
            self.Text:SetAlpha(1)
        end)
        AddonCompartmentFrame:HookScript('OnLeave', function(self)
            set_Alpha_Color(self.Text, nil, nil, Save.alpha<=0.3 and 0.3)
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
    set_Button_Alpha(MinimapCluster.Tracking.Button, {alpha= Save.alpha<=0.3 and 0.3})

    --小队，背景
    set_Alpha_Frame_Texture(PartyFrame.Background, {})

    --任务，追踪柆
    hooksecurefunc('ObjectiveTracker_Initialize', function(self)
        for _, module in ipairs(self.MODULES) do
            set_Alpha_Color(module.Header.Background)
        end
    end)

    --社交，按钮
    
    set_Alpha_Color(QuickJoinToastButton.FriendsButton, nil, nil, Save.alpha<=0.3 and 0.3)
    --set_Alpha_Color(QuickJoinToastButton.QueueButton, nil, nil, Save.alpha<=0.3 and 0.3)
    set_Alpha_Frame_Texture(ChatFrameChannelButton, {alpha= Save.alpha<=0.3 and 0.3})
    set_Alpha_Frame_Texture(ChatFrameMenuButton, {alpha= Save.alpha<=0.3 and 0.3})
    --[[hooksecurefunc('ObjectiveTracker_UpdateOpacity', function()
        --for _, module in ipairs(ObjectiveTrackerBlocksFrame.MODULES) do
          --  set_Alpha_Color(module.Header.Background)
        --end
    end)]]






    --商人
    set_Alpha_Color(MerchantFrame.NineSlice.TopEdge)
    set_Alpha_Color(MerchantFrame.NineSlice.TopLeftCorner)
    set_Alpha_Color(MerchantFrame.NineSlice.TopRightCorner)
    set_Alpha_Color(MerchantFrameBg)
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

        --秒表
        --Blizzard_TimeManager.lua
        hide_Texture(StopwatchFrameBackgroundLeft)
        if StopwatchFrame then
            hide_Texture(select(2, StopwatchFrame:GetRegions()))
            hide_Texture(StopwatchTabFrameMiddle)
            hide_Texture(StopwatchTabFrameRight)
            hide_Texture(StopwatchTabFrameLeft)
        end
    end)
end

















































--#########
--事件, 透明
--#########
local function set_Alpha_Event(arg1)
    if Save.disabledAlpha then
        return
    end
    if arg1=='Blizzard_TrainerUI' then--专业训练师
        set_Alpha_Color(ClassTrainerFrame.NineSlice.TopEdge)
        set_Alpha_Color(ClassTrainerFrame.NineSlice.TopLeftCorner)
        set_Alpha_Color(ClassTrainerFrame.NineSlice.TopRightCorner)
        hide_Texture(ClassTrainerFrameInset.Bg)
        hide_Texture(ClassTrainerFrameBg)

        hide_Texture(ClassTrainerFrameBottomInset.Bg)
        set_Alpha_Color(ClassTrainerFrameFilterDropDownMiddle)
        set_Alpha_Color(ClassTrainerFrameFilterDropDownLeft)
        set_Alpha_Color(ClassTrainerFrameFilterDropDownRight)
        hide_Texture(ClassTrainerFrame.ScrollBar.Backplate)

    elseif arg1=='Blizzard_TimeManager' then--小时图，时间
        set_Alpha_Color(TimeManagerFrame.NineSlice.TopLeftCorner)
        set_Alpha_Color(TimeManagerFrame.NineSlice.TopEdge)
        set_Alpha_Color(TimeManagerFrame.NineSlice.TopRightCorner)
        set_Alpha_Color(TimeManagerFrameBg)
        hide_Texture(TimeManagerFrameInset.Bg)
        set_Alpha_Color(TimeManagerAlarmMessageEditBox.Middle)
        set_Alpha_Color(TimeManagerAlarmMessageEditBox.Left)
        set_Alpha_Color(TimeManagerAlarmMessageEditBox.Right)
        e.Set_Label_Texture_Color(TimeManagerClockTicker, {type='FontString', alpha=1})--设置颜色
        --[[if e.Player.useColor then
            TimeManagerClockTicker:SetTextColor(e.Player.useColor.r, e.Player.useColor.g, e.Player.useColor.b)
        end]]


    elseif arg1=='Blizzard_ClassTalentUI' and not Save.disabledAlpha then--天赋
        set_Alpha_Color(ClassTalentFrame.TalentsTab.BottomBar)--下面
        set_Alpha_Color(ClassTalentFrame.NineSlice.TopLeftCorner)--顶部
        set_Alpha_Color(ClassTalentFrame.NineSlice.TopEdge)--顶部
        set_Alpha_Color(ClassTalentFrame.NineSlice.TopRightCorner)--顶部
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
        set_Alpha_Color(ClassTalentFrame.TalentsTab.SearchBox.Middle)
        set_Alpha_Color(ClassTalentFrame.TalentsTab.SearchBox.Left)
        set_Alpha_Color(ClassTalentFrame.TalentsTab.SearchBox.Right)

        --TabSystemOwner.lua
        for _, tabID in pairs(ClassTalentFrame:GetTabSet() or {}) do
            local btn= ClassTalentFrame:GetTabButton(tabID)
            set_Alpha_Frame_Texture(btn, {alpha=Save.alpha<0.3 and 0.3})
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

        hide_Texture(AchievementFrame.SearchBox.Middle)
        hide_Texture(AchievementFrame.SearchBox.Left)
        hide_Texture(AchievementFrame.SearchBox.Right)

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
        hide_Texture(AchievementFrameAchievements.ScrollBar.Backplate)
        hide_Texture(AchievementFrameStats.ScrollBar.Backplate)
        hide_Texture(AchievementFrameCategories.ScrollBar.Backplate)
        set_Alpha_Frame_Texture(AchievementFrameTab1, {alpha=Save.alpha<0.3 and 0.3})
        set_Alpha_Frame_Texture(AchievementFrameTab2, {alpha=Save.alpha<0.3 and 0.3})
        set_Alpha_Frame_Texture(AchievementFrameTab3, {alpha=Save.alpha<0.3 and 0.3})

    elseif arg1=='Blizzard_Communities' then--公会和社区
        set_Alpha_Color(CommunitiesFrame.NineSlice.TopEdge)
        set_Alpha_Color(CommunitiesFrame.NineSlice.TopLeftCorner)
        set_Alpha_Color(CommunitiesFrame.NineSlice.TopRightCorner)

        set_Alpha_Color(CommunitiesFrame.NineSlice.BottomEdge)
        set_Alpha_Color(CommunitiesFrame.NineSlice.BottomLeftCorner)
        set_Alpha_Color(CommunitiesFrame.NineSlice.BottomRightCorner)

        set_Alpha_Color(CommunitiesFrameBg)
        set_Alpha_Color(CommunitiesFrame.MemberList.ColumnDisplay.Background)
        set_Alpha_Color(CommunitiesFrameCommunitiesList.Bg)
        set_Alpha_Color(CommunitiesFrameInset.Bg)
        CommunitiesFrame.GuildBenefitsFrame.Perks:DisableDrawLayer('BACKGROUND')
        CommunitiesFrameGuildDetailsFrameInfo:DisableDrawLayer('BACKGROUND')
        CommunitiesFrameGuildDetailsFrameNews:DisableDrawLayer('BACKGROUND')

        hide_Texture(CommunitiesFrameCommunitiesList.ScrollBar.Backplate)
        hide_Texture(CommunitiesFrameCommunitiesList.ScrollBar.Background)
        hide_Texture(CommunitiesFrame.MemberList.ScrollBar.Backplate)
        hide_Texture(CommunitiesFrame.MemberList.ScrollBar.Background)

        set_Alpha_Color(CommunitiesFrame.ChatEditBox.Mid)
        set_Alpha_Color(CommunitiesFrame.ChatEditBox.Left)
        set_Alpha_Color(CommunitiesFrame.ChatEditBox.Right)
        set_Alpha_Color(CommunitiesFrameMiddle)

        hide_Texture(CommunitiesFrame.GuildBenefitsFrame.Rewards.Bg)

        hooksecurefunc(CommunitiesFrameCommunitiesList,'UpdateCommunitiesList',function(self)
            C_Timer.After(0.3, function()
                for _, button in pairs(CommunitiesFrameCommunitiesList.ScrollBox:GetFrames()) do
                set_Alpha_Color(button.Background)
                end
            end)
        end)

        set_Alpha_Color(ClubFinderCommunityAndGuildFinderFrame.InsetFrame.Bg)
        hide_Texture(ClubFinderCommunityAndGuildFinderFrame.CommunityCards.ScrollBar.Backplate)
        hide_Texture(CommunitiesFrame.GuildBenefitsFrame.Rewards.ScrollBar.Backplate)
        hide_Texture(CommunitiesFrameGuildDetailsFrameNews.ScrollBar.Backplate)
        hide_Texture(CommunitiesFrameGuildDetailsFrameNews.ScrollBar.Background)

        hide_Frame_Texture(CommunitiesFrame.ChatTab, {index=1})
        hide_Frame_Texture(CommunitiesFrame.RosterTab, {index=1})
        hide_Frame_Texture(CommunitiesFrame.GuildBenefitsTab, {index=1})
        hide_Frame_Texture(CommunitiesFrame.GuildInfoTab, {index=1})
        hide_Frame_Texture(ClubFinderCommunityAndGuildFinderFrame.ClubFinderSearchTab, {index=1})
        hide_Frame_Texture(ClubFinderCommunityAndGuildFinderFrame.ClubFinderPendingTab, {index=1})

        set_Alpha_Color(ClubFinderGuildFinderFrame.InsetFrame.Bg)


    elseif arg1=='Blizzard_PVPUI' then--地下城和团队副本, PVP
        hide_Texture(HonorFrame.Inset.Bg)
        set_Alpha_Color(HonorFrame.BonusFrame.WorldBattlesTexture)
        hide_Texture(HonorFrame.ConquestBar.Background)
        set_Alpha_Color(ConquestFrame.Inset.Bg)
        set_Alpha_Color(ConquestFrame.RatedBGTexture)
        PVPQueueFrame.HonorInset:DisableDrawLayer('BACKGROUND')
        set_Alpha_Color(PVPQueueFrame.HonorInset.CasualPanel.HonorLevelDisplay.Background)
        set_Alpha_Color(HonorFrameTypeDropDownMiddle)
        set_Alpha_Color(HonorFrameTypeDropDownLeft)
        set_Alpha_Color(HonorFrameTypeDropDownRight)
        hide_Texture(ConquestFrame.RatedBGTexture)
        hide_Texture(LFDQueueFrameSpecific.ScrollBar.Backplate)

    elseif arg1=='Blizzard_EncounterJournal' then--冒险指南
        set_Alpha_Color(EncounterJournal.NineSlice.TopLeftEdge)
        set_Alpha_Color(EncounterJournal.NineSlice.TopEdge)
        set_Alpha_Color(EncounterJournal.NineSlice.TopRightEdge)
        set_Alpha_Color(EncounterJournal.NineSlice.TopRightCorner)
        set_Alpha_Color(EncounterJournal.NineSlice.TopLeftCorner)

        hide_Texture(EncounterJournalBg)
        hide_Texture(EncounterJournalInset.Bg)


        set_Alpha_Color(EncounterJournalInstanceSelectBG)
        --set_Alpha_Color(EncounterJournalEncounterFrameInfoBG)
        set_Alpha_Color(EncounterJournalEncounterFrameInfoModelFrameDungeonBG)
        EncounterJournalNavBar:DisableDrawLayer('BACKGROUND')

        set_Alpha_Color(EncounterJournalInstanceSelectTierDropDownMiddle)
        set_Alpha_Color(EncounterJournalInstanceSelectTierDropDownLeft)
        set_Alpha_Color(EncounterJournalInstanceSelectTierDropDownRight)

        C_Timer.After(0.3, function()
            if EncounterJournalMonthlyActivitiesFrame then
                set_Alpha_Color(EncounterJournalMonthlyActivitiesFrame.Bg)
            end
        end)

        set_Alpha_Frame_Texture(EncounterJournalSuggestTab, {alpha=Save.alpha<0.3 and 0.3})
        set_Alpha_Frame_Texture(EncounterJournalMonthlyActivitiesTab, {alpha=Save.alpha<0.3 and 0.3})
        set_Alpha_Frame_Texture(EncounterJournalDungeonTab, {alpha=Save.alpha<0.3 and 0.3})
        set_Alpha_Frame_Texture(EncounterJournalRaidTab, {alpha=Save.alpha<0.3 and 0.3})
        set_Alpha_Frame_Texture(EncounterJournalLootJournalTab, {alpha=Save.alpha<0.3 and 0.3})

    elseif arg1=="Blizzard_GuildBankUI" then--公会银行
        set_Alpha_Color(GuildBankFrame.BlackBG)
        hide_Texture(GuildBankFrame.TitleBg)
        hide_Texture(GuildBankFrame.RedMarbleBG)
        set_Alpha_Color(GuildBankFrame.MoneyFrameBG)

        set_Alpha_Color(GuildBankFrame.TabLimitBG)
        set_Alpha_Color(GuildBankFrame.TabLimitBGLeft)
        set_Alpha_Color(GuildBankFrame.TabLimitBGRight)
        set_Alpha_Color(GuildItemSearchBox.Middle)
        set_Alpha_Color(GuildItemSearchBox.Left)
        set_Alpha_Color(GuildItemSearchBox.Right)
        set_Alpha_Color(GuildBankFrame.TabTitleBG)
        set_Alpha_Color(GuildBankFrame.TabTitleBGLeft)
        set_Alpha_Color(GuildBankFrame.TabTitleBGRight)

        for i=1, 7 do
            local frame= GuildBankFrame['Column'..i]
            if frame then
                hide_Texture(frame.Background)
            end
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


    elseif arg1=='Blizzard_AuctionHouseUI' then--拍卖行
        set_Alpha_Color(AuctionHouseFrame.NineSlice.TopLeftCorner)
        set_Alpha_Color(AuctionHouseFrame.NineSlice.TopEdge)
        set_Alpha_Color(AuctionHouseFrame.NineSlice.TopRightCorner)
        set_Alpha_Color(AuctionHouseFrameBg)
        set_Alpha_Color(AuctionHouseFrame.CategoriesList.Background)

        set_Alpha_Color(AuctionHouseFrame.SearchBar.SearchBox.Middle)
        set_Alpha_Color(AuctionHouseFrame.SearchBar.SearchBox.Left)
        set_Alpha_Color(AuctionHouseFrame.SearchBar.SearchBox.Right)
        set_Alpha_Color(AuctionHouseFrameMiddleMiddle)
        set_Alpha_Color(AuctionHouseFrameMiddleLeft)
        set_Alpha_Color(AuctionHouseFrameMiddleRight)
        set_Alpha_Color(AuctionHouseFrameBottomMiddle)
        set_Alpha_Color(AuctionHouseFrameBottomLeft)
        set_Alpha_Color(AuctionHouseFrameBottomRight)

        hide_Texture(AuctionHouseFrame.CategoriesList.ScrollBar.Backplate)
        hide_Texture(AuctionHouseFrame.BrowseResultsFrame.ItemList.ScrollBar.Backplate)
        set_Alpha_Color(AuctionHouseFrameMiddle)
        set_Alpha_Color(AuctionHouseFrameLeft)
        set_Alpha_Color(AuctionHouseFrameRight)
        hide_Texture(AuctionHouseFrame.MoneyFrameInset.Bg)

        set_Alpha_Color(AuctionHouseFrame.ItemSellFrame.Background)--出售
        set_Alpha_Color(AuctionHouseFrame.ItemSellList.Background)
        hide_Texture(AuctionHouseFrame.ItemSellList.ScrollBar.Backplate)

        hide_Texture(AuctionHouseFrameAuctionsFrame.SummaryList.ScrollBar.Backplate)
        hide_Texture(AuctionHouseFrameAuctionsFrame.AllAuctionsList.ScrollBar.Backplate)

        set_Alpha_Color(AuctionHouseFrameAuctionsFrame.SummaryList.Background)
        set_Alpha_Color(AuctionHouseFrameAuctionsFrame.AllAuctionsList.Background)

    elseif arg1=='Blizzard_ProfessionsCustomerOrders' then--专业定制
        set_Alpha_Color(ProfessionsCustomerOrdersFrame.NineSlice.TopLeftCorner)
        set_Alpha_Color(ProfessionsCustomerOrdersFrame.NineSlice.TopEdge)
        set_Alpha_Color(ProfessionsCustomerOrdersFrame.NineSlice.TopRightCorner)
        set_Alpha_Color(ProfessionsCustomerOrdersFrameBg)
        set_Alpha_Color(ProfessionsCustomerOrdersFrame.BrowseOrders.SearchBar.SearchBox.Middle)
        set_Alpha_Color(ProfessionsCustomerOrdersFrame.BrowseOrders.SearchBar.SearchBox.Left)
        set_Alpha_Color(ProfessionsCustomerOrdersFrame.BrowseOrders.SearchBar.SearchBox.Right)

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

    elseif arg1=='Blizzard_BlackMarketUI' then--黑市
        set_Alpha_Color(BlackMarketFrameTitleBg)
        set_Alpha_Color(BlackMarketFrameBg)
        set_Alpha_Color(BlackMarketFrame.LeftBorder)
        set_Alpha_Color(BlackMarketFrame.RightBorder)
        set_Alpha_Color(BlackMarketFrame.BottomBorder)
        set_Alpha_Color(BlackMarketFrame.ScrollBar.Backplate)

    elseif arg1=='Blizzard_Collections' then--收藏
        set_Alpha_Color(CollectionsJournal.NineSlice.TopEdge)
        set_Alpha_Color(CollectionsJournal.NineSlice.TopLeftCorner)
        set_Alpha_Color(CollectionsJournal.NineSlice.TopRightCorner)
        set_Alpha_Color(CollectionsJournalBg)

        hide_Texture(MountJournal.LeftInset.Bg)
        set_Alpha_Color(MountJournal.MountDisplay.YesMountsTex)
        hide_Texture(MountJournal.RightInset.Bg)
        set_Alpha_Color(MountJournal.BottomLeftInset.Background)
        hide_Texture(MountJournal.BottomLeftInset.Bg)

        hide_Texture(MountJournal.ScrollBar.Backplate)
        set_Alpha_Color(MountJournalSearchBox.Middle)
        set_Alpha_Color(MountJournalSearchBox.Right)
        set_Alpha_Color(MountJournalSearchBox.Left)

        hide_Texture(PetJournalPetCardBG)
        set_Alpha_Color(PetJournalPetCardInset.Bg)
        set_Alpha_Color(PetJournalRightInset.Bg)
        hide_Texture(PetJournalLoadoutPet1BG)
        hide_Texture(PetJournalLoadoutPet2BG)
        hide_Texture(PetJournalLoadoutPet3BG)
        set_Alpha_Color(PetJournalLoadoutBorderSlotHeaderBG)
        hide_Texture(PetJournalLeftInset.Bg)

        hide_Texture(PetJournal.ScrollBar.Backplate)
        set_Alpha_Color(PetJournalSearchBox.Middle)
        set_Alpha_Color(PetJournalSearchBox.Right)
        set_Alpha_Color(PetJournalSearchBox.Left)
        set_Alpha_Color(PetJournal.PetCount.BorderTopMiddle)
        set_Alpha_Color(PetJournal.PetCount.Bg)
        set_Alpha_Color(PetJournal.PetCount.BorderBottomMiddle)
        set_Alpha_Color(PetJournal.PetCount.BorderTopRightMiddle)
        set_Alpha_Color(PetJournal.PetCount.BorderTopLeftMiddle)
        set_Alpha_Color(PetJournal.PetCount.BorderBottomLeft)
        set_Alpha_Color(PetJournal.PetCount.BorderTopLeft)
        set_Alpha_Color(PetJournal.PetCount.BorderBottomRight)
        set_Alpha_Color(PetJournal.PetCount.BorderTopRight)

        hide_Texture(ToyBox.iconsFrame.BackgroundTile)
        hide_Texture(ToyBox.iconsFrame.Bg)
        set_Alpha_Color(ToyBox.searchBox.Middle)
        set_Alpha_Color(ToyBox.searchBox.Right)
        set_Alpha_Color(ToyBox.searchBox.Left)
        ToyBox.progressBar:DisableDrawLayer('BACKGROUND')

        hide_Texture(HeirloomsJournal.iconsFrame.BackgroundTile)
        hide_Texture(HeirloomsJournal.iconsFrame.Bg)
        set_Alpha_Color(HeirloomsJournalSearchBox.Middle)
        set_Alpha_Color(HeirloomsJournalSearchBox.Right)
        set_Alpha_Color(HeirloomsJournalSearchBox.Left)
        set_Alpha_Color(HeirloomsJournalClassDropDownMiddle)
        set_Alpha_Color(HeirloomsJournalClassDropDownLeft)
        set_Alpha_Color(HeirloomsJournalClassDropDownRight)
        set_Alpha_Color(HeirloomsJournalMiddleMiddle)
        set_Alpha_Color(HeirloomsJournalMiddleLeft)
        set_Alpha_Color(HeirloomsJournalMiddleRight)
        set_Alpha_Color(HeirloomsJournalBottomMiddle)
        set_Alpha_Color(HeirloomsJournalTopMiddle)
        set_Alpha_Color(HeirloomsJournalBottomLeft)
        set_Alpha_Color(HeirloomsJournalBottomRight)
        set_Alpha_Color(HeirloomsJournalTopLeft)
        set_Alpha_Color(HeirloomsJournalTopRight)

        hide_Texture(WardrobeCollectionFrame.ItemsCollectionFrame.BackgroundTile)
        hide_Texture(WardrobeCollectionFrame.ItemsCollectionFrame.Bg)
        hide_Texture(WardrobeCollectionFrame.ItemsCollectionFrame.ShadowLineTop)

        hide_Texture(WardrobeCollectionFrame.SetsCollectionFrame.RightInset.BackgroundTile)
        hide_Texture(WardrobeCollectionFrame.SetsCollectionFrame.RightInset.Bg)
        hide_Texture(WardrobeCollectionFrame.SetsCollectionFrame.LeftInset.Bg)
        hide_Texture(WardrobeCollectionFrame.SetsCollectionFrame.ListContainer.ScrollBar.Backplate)
        hide_Texture(WardrobeCollectionFrame.SetsCollectionFrame.RightInset.ShadowLineTop)
        hide_Texture(WardrobeCollectionFrame.SetsCollectionFrame.RightInset.BGCornerBottomRight)
        hide_Texture(WardrobeCollectionFrame.SetsCollectionFrame.RightInset.BGCornerBottomLeft)

        set_Alpha_Color(WardrobeCollectionFrameSearchBox.Middle)
        set_Alpha_Color(WardrobeCollectionFrameSearchBox.Left)
        set_Alpha_Color(WardrobeCollectionFrameSearchBox.Right)
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

        set_Alpha_Color(WardrobeSetsCollectionVariantSetsButtonMiddleMiddle)
        set_Alpha_Color(WardrobeSetsCollectionVariantSetsButtonBottomMiddle)
        set_Alpha_Color(WardrobeSetsCollectionVariantSetsButtonTopMiddle)
        set_Alpha_Color(WardrobeSetsCollectionVariantSetsButtonMiddleLeft)
        set_Alpha_Color(WardrobeSetsCollectionVariantSetsButtonMiddleRight)
        set_Alpha_Color(WardrobeSetsCollectionVariantSetsButtonTopLeft)
        set_Alpha_Color(WardrobeSetsCollectionVariantSetsButtonBottomLeft)
        set_Alpha_Color(WardrobeSetsCollectionVariantSetsButtonTopRight)
        set_Alpha_Color(WardrobeSetsCollectionVariantSetsButtonBottomRight)
        hide_Texture(WardrobeCollectionFrame.SetsCollectionFrame.DetailsFrame.ModelFadeTexture)
        --[[hooksecurefunc(WardrobeSetsScrollFrameButtonMixin, 'Init', function(button, displayData)--外观列表
            set_Alpha_Color(button.Background)
        end)]]

        --试衣间
        set_Alpha_Color(WardrobeFrame.NineSlice.TopLeftCorner)
        set_Alpha_Color(WardrobeFrame.NineSlice.TopEdge)
        set_Alpha_Color(WardrobeFrame.NineSlice.TopRightCorner)
        hide_Texture(WardrobeFrameBg)
        hide_Texture(WardrobeTransmogFrame.Inset.Bg)
        set_Alpha_Color(WardrobeTransmogFrame.Inset.BG)
        hide_Texture(WardrobeCollectionFrame.SetsTransmogFrame.BackgroundTile)
        set_Alpha_Color(WardrobeCollectionFrame.SetsTransmogFrame.Bg)
        set_Alpha_Color(WardrobeOutfitDropDownMiddle)
        set_Alpha_Color(WardrobeOutfitDropDownLeft)
        set_Alpha_Color(WardrobeOutfitDropDownRight)
        set_Alpha_Color(WardrobeTransmogFrame.MoneyMiddle)
        set_Alpha_Color(WardrobeTransmogFrame.MoneyLeft)
        set_Alpha_Color(WardrobeTransmogFrame.MoneyRight)
        --[[for v=1,6 do--物品,幻化, 背景
            for h= 1, 3 do
                local button= WardrobeCollectionFrame.ItemsCollectionFrame['ModelR'..h..'C'..v]
                if button then
                    button:DisableDrawLayer('BACKGROUND')
                end
            end
        end]]
        for v=1,4 do
            for h= 1, 2 do
                local button= WardrobeCollectionFrame.SetsTransmogFrame['ModelR'..h..'C'..v]
                if button then
                    button:DisableDrawLayer('BACKGROUND')
                end
            end
        end
        WardrobeCollectionFrame.progressBar:DisableDrawLayer('BACKGROUND')
        set_Alpha_Color(WardrobeCollectionFrameWeaponDropDownMiddle)
        set_Alpha_Color(WardrobeCollectionFrameWeaponDropDownLeft)
        set_Alpha_Color(WardrobeCollectionFrameWeaponDropDownRight)

        set_Alpha_Frame_Texture(CollectionsJournalTab1, {alpha=Save.alpha<0.3 and 0.3})
        set_Alpha_Frame_Texture(CollectionsJournalTab2, {alpha=Save.alpha<0.3 and 0.3})
        set_Alpha_Frame_Texture(CollectionsJournalTab3, {alpha=Save.alpha<0.3 and 0.3})
        set_Alpha_Frame_Texture(CollectionsJournalTab4, {alpha=Save.alpha<0.3 and 0.3})
        set_Alpha_Frame_Texture(CollectionsJournalTab5, {alpha=Save.alpha<0.3 and 0.3})
        set_Alpha_Frame_Texture(_G['CollectionsJournalTab6'], {alpha=Save.alpha<0.3 and 0.3})
        set_Alpha_Frame_Texture(_G['CollectionsJournalTab7'], {alpha=Save.alpha<0.3 and 0.3})

        if RematchJournal then
            set_Alpha_Color(RematchJournal.NineSlice.TopEdge)
            set_Alpha_Color(RematchJournal.NineSlice.TopRightCorner)
            set_Alpha_Color(RematchJournal.NineSlice.TopLeftCorner)
            set_Alpha_Color(RematchJournalBg)
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
        set_Alpha_Color(FlightMapFrame.BorderFrame.NineSlice.TopLeftCorner)
        set_Alpha_Color(FlightMapFrame.BorderFrame.NineSlice.TopEdge)
        set_Alpha_Color(FlightMapFrame.BorderFrame.NineSlice.TopRightCorner)

        hide_Texture(FlightMapFrame.ScrollContainer.Child.TiledBackground)
        hide_Texture(FlightMapFrameBg)
    elseif arg1=='Blizzard_ItemSocketingUI' then--镶嵌宝石，界面
        set_Alpha_Color(ItemSocketingFrame.NineSlice.TopLeftCorner)
        set_Alpha_Color(ItemSocketingFrame.NineSlice.TopEdge)
        set_Alpha_Color(ItemSocketingFrame.NineSlice.TopRightCorner)
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
        set_Alpha_Color(ItemSocketingScrollFrameMiddle)
        set_Alpha_Color(ItemSocketingScrollFrameTop)
        set_Alpha_Color(ItemSocketingScrollFrameBottom)

    elseif arg1=='Blizzard_ChallengesUI' then--挑战, 钥匙插入， 界面
        set_Alpha_Color(ChallengesFrameInset.Bg)

        hooksecurefunc(ChallengesKeystoneFrame, 'Reset', function(self2)--钥匙插入， 界面
            set_Alpha_Frame_Texture(self2, {index=1})
            hide_Texture(self2.InstructionBackground)
        end)

    elseif arg1=='Blizzard_WeeklyRewards' then--周奖励提示
        set_Alpha_Color(WeeklyRewardsFrame.BackgroundTile)
        set_Alpha_Color(WeeklyRewardsFrame.HeaderFrame.Middle)
        set_Alpha_Color(WeeklyRewardsFrame.HeaderFrame.Left)
        set_Alpha_Color(WeeklyRewardsFrame.HeaderFrame.Right)
        set_Alpha_Color(WeeklyRewardsFrame.RaidFrame.Background)
        set_Alpha_Color(WeeklyRewardsFrame.MythicFrame.Background)
        set_Alpha_Color(WeeklyRewardsFrame.PVPFrame.Background)
        hooksecurefunc(WeeklyRewardsFrame,'UpdateSelection', function(self2)
            for _, frame in ipairs(self2.Activities) do
                set_Alpha_Color(frame.Background)
            end
        end)

    elseif arg1=='Blizzard_ItemInteractionUI' then--套装, 转换        
        set_Alpha_Color(ItemInteractionFrame.NineSlice.TopLeftCorner)
        set_Alpha_Color(ItemInteractionFrame.NineSlice.TopEdge)
        set_Alpha_Color(ItemInteractionFrame.NineSlice.TopRightCorner)
        set_Alpha_Color(ItemInteractionFrameBg)
        set_Alpha_Color(ItemInteractionFrame.Inset.Bg)
        set_Alpha_Color(ItemInteractionFrameMiddle)

        set_Alpha_Color(ItemInteractionFrameRight)
        set_Alpha_Color(ItemInteractionFrameLeft)

        hide_Texture(ItemInteractionFrame.ButtonFrame.BlackBorder)

    elseif arg1=='Blizzard_InspectUI' then--玩家, 观察角色, 界面
        set_Alpha_Color(InspectFrame.NineSlice.TopLeftCorner)
        set_Alpha_Color(InspectFrame.NineSlice.TopEdge)
        set_Alpha_Color(InspectFrame.NineSlice.TopRightCorner)
        set_Alpha_Color(InspectFrameBg)
        hide_Texture(InspectFrameInset.Bg)
        hide_Texture(InspectPVPFrame.BG)
        hide_Texture(InspectGuildFrameBG)

    elseif arg1=='Blizzard_ItemUpgradeUI' then--装备升级,界面        
        set_Alpha_Color(ItemUpgradeFrame.NineSlice.TopLeftCorner)
        set_Alpha_Color(ItemUpgradeFrame.NineSlice.TopEdge)
        set_Alpha_Color(ItemUpgradeFrame.NineSlice.TopRightCorner)
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
        set_Alpha_Color(MacroFrame.NineSlice.TopLeftCorner)
        set_Alpha_Color(MacroFrame.NineSlice.TopEdge)
        set_Alpha_Color(MacroFrame.NineSlice.TopRightCorner)
        hide_Texture(MacroFrameBg)
        set_Alpha_Color(MacroFrameInset.Bg)
        hide_Texture(MacroFrame.MacroSelector.ScrollBar.Backplate)
        hide_Texture(MacroFrameSelectedMacroBackground)
    elseif arg1=='Blizzard_GarrisonUI' then--要塞
        --[[
        Move(GarrisonShipyardFrame,{})--海军行动
        Move(GarrisonMissionFrame, {})--要塞任务
        
        Move(GarrisonLandingPage, {})--要塞报告
        Move(OrderHallMissionFrame, {})
        ]]
        if GarrisonCapacitiveDisplayFrame then--要塞订单
            set_Alpha_Color(GarrisonCapacitiveDisplayFrame.NineSlice.TopLeftCorner)
            set_Alpha_Color(GarrisonCapacitiveDisplayFrame.NineSlice.TopEdge)
            set_Alpha_Color(GarrisonCapacitiveDisplayFrame.NineSlice.TopRightCorner)
            set_Alpha_Color(GarrisonCapacitiveDisplayFrameBg)
            hide_Texture(GarrisonCapacitiveDisplayFrame.TopTileStreaks)
            hide_Texture(GarrisonCapacitiveDisplayFrameInset.Bg)
        end

    elseif arg1=='Blizzard_GenericTraitUI' then--欲龙术
        set_Alpha_Color(GenericTraitFrame.Background)
        set_Alpha_Color(GenericTraitFrame.NineSlice.RightEdge)
        set_Alpha_Color(GenericTraitFrame.NineSlice.LeftEdge)
        set_Alpha_Color(GenericTraitFrame.NineSlice.TopEdge)
        set_Alpha_Color(GenericTraitFrame.NineSlice.BottomEdge)
        set_Alpha_Color(GenericTraitFrame.NineSlice.TopRightCorner)
        set_Alpha_Color(GenericTraitFrame.NineSlice.TopLeftCorner)
        set_Alpha_Color(GenericTraitFrame.NineSlice.BottomLeftCorner)
        set_Alpha_Color(GenericTraitFrame.NineSlice.BottomRightCorner)

    elseif arg1=='Blizzard_PlayerChoice' then----任务选择
        --[[sPlayerChoiceFrame:HookScript('OnShow', function(self)
            et_Alpha_Color(PlayerChoiceFrame.Header)
            if self.NineSlice then
                hide_Texture(self.NineSlice.TopLeftCorner)
                hide_Texture(self.NineSlice.TopEdge)
                hide_Texture(self.NineSlice.TopRightCorner)
                hide_Texture(self.NineSlice.BottomLeftCorner)
                hide_Texture(self.NineSlice.BottomEdge)
                hide_Texture(self.NineSlice.BottomRightCorner)
                hide_Texture(self.NineSlice.RightEdge)
                hide_Texture(self.NineSlice.LeftEdge)
            end
            if self.Title then
                set_Alpha_Color(self.Title.Middle)
                set_Alpha_Color(self.Title.Left)
                set_Alpha_Color(self.Title.Right)
            end
            if self.Background then
              hide_Texture(self.Background.BackgroundTile or self.Background)
            end
        end)]]
        hooksecurefunc(PlayerChoiceFrame, 'SetupFrame', function(self)
            if self.Background then
                hide_Texture(self.Background.BackgroundTile)
                hide_Texture(self.Background)
            end
            set_Alpha_Color(self.NineSlice)
            --set_Alpha_Color(self.Title)
            set_Alpha_Color(self.Header)
            set_Alpha_Color(self.Title.Left)
            set_Alpha_Color(self.Title.Middle)
            set_Alpha_Color(self.Title.Right)
        end)
    elseif arg1=='Blizzard_MajorFactions' then--派系声望
        set_Alpha_Color(MajorFactionRenownFrame.Background)

    elseif arg1=='Blizzard_Professions' then--专业, 初始化, 透明
        set_Alpha_Color(ProfessionsFrame.NineSlice.TopLeftCorner)
        set_Alpha_Color(ProfessionsFrame.NineSlice.TopEdge)
        set_Alpha_Color(ProfessionsFrame.NineSlice.TopRightCorner)
        set_Alpha_Color(ProfessionsFrameBg)
        set_Alpha_Color(ProfessionsFrame.CraftingPage.SchematicForm.Background)
        set_Alpha_Color(ProfessionsFrame.CraftingPage.RankBar.Background)

        set_Alpha_Color(ProfessionsFrame.CraftingPage.SchematicForm.Details.BackgroundTop)
        set_Alpha_Color(ProfessionsFrame.CraftingPage.SchematicForm.Details.BackgroundMiddle)
        set_Alpha_Color(ProfessionsFrame.CraftingPage.SchematicForm.Details.BackgroundBottom)

        hide_Texture(ProfessionsFrame.SpecPage.TreeView.Background)
        hide_Texture(ProfessionsFrame.SpecPage.DetailedView.Background)
        set_Alpha_Color(ProfessionsFrame.SpecPage.DetailedView.Path.DialBG)
        set_Alpha_Color(ProfessionsFrame.SpecPage.DetailedView.UnspentPoints.CurrencyBackground)

        set_Alpha_Color(InspectRecipeFrameBg)
        set_Alpha_Color(InspectRecipeFrame.SchematicForm.MinimalBackground)

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

local function set_MainMenu_Color(init)--主菜单
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
                            set_Alpha_Color(self2.Portrait or self2:GetNormalTexture(), nil, nil, Save.alpha<0.3 and 0.3 or Save.alpha)
                            if self.Background then
                                self.Background:SetAlpha(0.5)
                            end
                        end
                    end)
                end
                set_Alpha_Color(self.Portrait or self:GetNormalTexture(), nil, nil, Save.alpha<0.3 and 0.3 or Save.alpha)

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

    --提示，背包，总数
    MainMenuBarBackpackButton:HookScript('OnEnter', function()
        local num= 0
        local tab={}
        for i = BACKPACK_CONTAINER, NUM_TOTAL_EQUIPPED_BAG_SLOTS do
            local freeSlots, bagFamily = C_Container.GetContainerNumFreeSlots(i)
            local numSlots= C_Container.GetContainerNumSlots(i) or 0
            if bagFamily == 0 and numSlots>0 then
                num= num + numSlots
                table.insert(tab, (i+1)..') '..numSlots..'/|cnGREEN_FONT_COLOR:'..freeSlots)
            end
        end
        if num>0 then
            e.tips:AddLine(num..' '..(e.onlyChinese and '总计' or TOTAL))
            e.tips:AddLine(' ')
            for _, text in pairs(tab) do
                e.tips:AddLine(text)
            end
            e.tips:AddLine(id..'  '..addName)
            e.tips:Show()
        end
    end)



    if init then
         --材料包
        if CharacterReagentBag0Slot then
            set_Alpha_Color(CharacterReagentBag0SlotNormalTexture, nil, nil, Save.alpha<0.3 and 0.3)--外框

            local function set_Reagent_Bag_Alpha(show)
                if show then
                    CharacterReagentBag0SlotIconTexture:SetVertexColor(1,1,1,1)
                else
                    set_Alpha_Color(CharacterReagentBag0SlotIconTexture, nil, nil, Save.alpha<0.3 and 0.3 or Save.alpha)
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
                print(GetCVarBool("expandBagBar"))
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



--#######
--聊天泡泡
--#######
local function set_Chat_Bubbles_Event()
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
    if not Save.disabledChatBubble then
        FrameUtil.RegisterFrameForEvents(panel, chatBubblesEvents)
    else
        FrameUtil.UnregisterFrameForEvents(panel, chatBubblesEvents);
    end
end

local function set_Chat_Bubbles(init)
    for _, buble in pairs(C_ChatBubbles.GetAllChatBubbles() or {}) do
        if not buble.setAlphaOK or init then
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
                        --frame2:SetAlpha(Save.chatBubbleAlpha)
                        --frame2:SetVertexColor(e.Player.r, e.Player.g, e.Player.b)
                    end
                end
                buble.setAlphaOK= true
            end
        end
    end
end


































--###########
--添加控制面板
--###########
local Category, Layout= e.AddPanel_Sub_Category({name= '|A:AnimCreate_Icon_Texture:0:0|a'..(e.onlyChinese and '材质' or addName)})

local function options_Init()--初始，选项
    e.AddPanel_Header(Layout, e.onlyChinese and '选项' or OPTIONS)

    e.AddPanel_Check({
        name= e.onlyChinese and '隐藏材质' or format(CLUB_FINDER_LOOKING_FOR_CLASS_SPEC, HIDE, addName),
        tooltip= addName,
        category= Category,
        value= not Save.disabledTexture,
        func= function()
            Save.disabledTexture= not Save.disabledTexture and true or nil
            print(id, addName, e.onlyChinese and '需要重新加载' or REQUIRES_RELOAD)
        end
    })


    local initializer2= e.AddPanel_Check_Button({
        checkName= e.onlyChinese and '颜色' or COLOR,
        checkValue= not Save.disabledColor,
        checkFunc= function()
            Save.disabledColor= not Save.disabledColor and true or false
            print(id, addName, e.onlyChinese and '需要重新加载' or REQUIRES_RELOAD)
        end,
        buttonText= e.onlyChinese and '设置' or SETTINGS,
        buttonFunc= function()
            e.OpenPanelOpting((e.Player.useColor and e.Player.useColor.hex or '')..(e.onlyChinese and '颜色' or COLOR))
        end,
        tooltip= addName,
        layout= Layout,
        category= Category
    })


        local initializer= e.AddPanel_Check({
            name= e.onlyChinese and '主菜单' or MAINMENU_BUTTON,
            tooltip= addName,
            category= Category,
            value= not Save.disabledMainMenu,
            func= function()
                Save.disabledMainMenu= not Save.disabledMainMenu and true or nil
                set_MainMenu_Color()--主菜单，颜色，透明度
            end
        })
        initializer:SetParentInitializer(initializer2, function() return not Save.disabledColor end)


    e.AddPanel_Check_Sider({
        checkName= e.onlyChinese and '透明度' or 'Alpha',
        checkValue= not Save.disabledAlpha,
        checkTooltip= addName,
        checkFunc= function()
            Save.disabledAlpha= not Save.disabledAlpha and true or false
            print(id, addName, e.onlyChinese and '需要重新加载' or REQUIRES_RELOAD)
        end,
        sliderValue= Save.alpha or 0.5,
        sliderMinValue= 0,
        sliderMaxValue= 1,
        sliderStep= 0.1,
        siderName= nil,
        siderTooltip= nil,
        siderFunc= function(_, _, value2)
            local value3= e.GetFormatter1to10(value2, 0, 1)
            Save.alpha= value3
            print(id, addName, value3, e.onlyChinese and '需要重新加载' or REQUIRES_RELOAD)
        end,
        layout= Layout,
        category= Category,
    })

    initializer2= e.AddPanel_Check({
        name= e.onlyChinese and '聊天泡泡' or CHAT_BUBBLES_TEXT,
        tooltip= (e.onlyChinese and '在副本无效' or (INSTANCE..' ('..DISABLE..')'))
                ..'|n|n'..((e.onlyChinese and '说' or SAY)..' CVar: chatBubbles '.. e.GetShowHide(C_CVar.GetCVarBool("chatBubbles")))
                ..'|n'..((e.onlyChinese and '小队' or SAY)..' CVar: chatBubblesParty '.. e.GetShowHide(C_CVar.GetCVarBool("chatBubblesParty"))),
        category= Category,
        value= not Save.disabledChatBubble,
        func= function()
            Save.disabledChatBubble= not Save.disabledChatBubble and true or nil
            set_Chat_Bubbles_Event()
            if not Save.disabledChatBubble then
                set_Chat_Bubbles(true)
            else
                print(id, addName, e.onlyChinese and '需要重新加载' or REQUIRES_RELOAD)
            end
        end
    })

    initializer= e.AddPanelSider({
        name= e.onlyChinese and '透明度' or 'Alpha',
        value= Save.chatBubbleAlpha,
        minValue= 0,
        maxValue= 1,
        setp= 0.1,
        tooltip= addName,
        category= Category,
        func= function(_, _, value2)
            local value3= e.GetFormatter1to10(value2, 0, 1)
            Save.chatBubbleAlpha= value3
            set_Chat_Bubbles(true)
        end
    })
    initializer:SetParentInitializer(initializer2, function() return not Save.disabledChatBubble end)

    initializer= e.AddPanelSider({
        name= e.onlyChinese and '缩放' or UI_SCALE,
        value= Save.chatBubbleSacal,
        minValue= 0.3,
        maxValue= 1,
        setp= 0.1,
        tooltip= addName,
        category= Category,
        func= function(_, _, value2)
            local value3= e.GetFormatter1to10(value2, 0.3, 1)
            Save.chatBubbleSacal= value3
            set_Chat_Bubbles(true)
        end
    })
    initializer:SetParentInitializer(initializer2, function() return not Save.disabledChatBubble end)


    e.AddPanel_Check_Sider({
        checkName= (e.onlyChinese and '职业能量' or format(CLUB_FINDER_LOOKING_FOR_CLASS_SPEC, CLASS, ENERGY))..' 1 2 3',
        checkValue= Save.classPowerNum,
        checkTooltip= addName,
        checkFunc= function()
            Save.classPowerNum= not Save.classPowerNum and true or false
            print(id, addName, e.onlyChinese and '需要重新加载' or REQUIRES_RELOAD)
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
            print(id, addName,'|cnGREEN_FONT_COLOR:'.. value3..'|r', e.onlyChinese and '需要重新加载' or REQUIRES_RELOAD)
        end,
        layout= Layout,
        category= Category,
    })
end


































--###########
--加载保存数据
--###########
panel:RegisterEvent("ADDON_LOADED")

panel:SetScript("OnEvent", function(_, event, arg1)
    if event == "ADDON_LOADED" then
        if arg1== id then
            Save= WoWToolsSave[addName] or Save
            Save.classPowerNumSize= Save.classPowerNumSize or 12

            e.AddPanel_Check({
                name= e.onlyChinese and '启用' or ENABLE,
                tooltip= addName,
                category= Category,
                value= not Save.disabled,
                func= function()
                    Save.disabled= not Save.disabled and true or nil
                    print(id, addName, e.GetEnabeleDisable(not Save.disabled), e.onlyChinese and '需要重新加载' or REQUIRES_RELOAD)
                end
            })

            if Save.disabled then
                panel:UnregisterAllEvents()
            else
                options_Init()--初始，选项
                Init_HideTexture()
                Init_Set_AlphaAndColor()
                Init_Class_Power(true)--职业
                if not Save.disabledChatBubble then
                    set_Chat_Bubbles_Event()
                end
                C_Timer.After(2, function()
                    set_MainMenu_Color(true)--主菜单, 颜色
                end)

            end
            panel:RegisterEvent("PLAYER_LOGOUT")

        else
            set_HideTexture_Event(arg1)
            set_Alpha_Event(arg1)
        end

    elseif event == "PLAYER_LOGOUT" then
        if not e.ClearAllSave then

            WoWToolsSave[addName]=Save
        end

    else--ChatBubbles https://wago.io/yyX84OlOD
        C_Timer.After(0, set_Chat_Bubbles)

    end
end)