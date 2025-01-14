--专业训练师
WoWTools_MoveMixin.ADDON_LOADED['Blizzard_TrainerUI']= function()
    WoWTools_MoveMixin:Setup(ClassTrainerFrame, {minW=328, minH=197, setSize=true, initFunc=function(btn)
        ClassTrainerFrameSkillStepButton:SetPoint('RIGHT', -12, 0)
        ClassTrainerFrameBottomInset:SetPoint('BOTTOMRIGHT', -4, 28)
        hooksecurefunc('ClassTrainerFrame_Update', function()--Blizzard_TrainerUI.lua
            ClassTrainerFrame.ScrollBox:SetPoint('BOTTOMRIGHT', -26, 34)
        end)
        btn.target.ScrollBox:ClearAllPoints()
    end, sizeRestFunc=function(self)
        self.target:SetSize(338, 424)
    end})
end

--小时图，时间
WoWTools_MoveMixin.ADDON_LOADED['Blizzard_TimeManager']= function()
    WoWTools_MoveMixin:Setup(TimeManagerFrame, {save=true})
end

--黑市
WoWTools_MoveMixin.ADDON_LOADED['Blizzard_BlackMarketUI']= function()
    WoWTools_MoveMixin:Setup(BlackMarketFrame)
end

--日历
WoWTools_MoveMixin.ADDON_LOADED['Blizzard_Calendar']= function()
    WoWTools_MoveMixin:Setup(CalendarFrame)
    WoWTools_MoveMixin:Setup(CalendarEventPickerFrame, {frame=CalendarFrame})
    WoWTools_MoveMixin:Setup(CalendarTexturePickerFrame, {frame=CalendarFrame})
    WoWTools_MoveMixin:Setup(CalendarMassInviteFrame, {frame=CalendarFrame})
    WoWTools_MoveMixin:Setup(CalendarCreateEventFrame, {frame=CalendarFrame})
    WoWTools_MoveMixin:Setup(CalendarViewEventFrame, {frame=CalendarFrame})
    WoWTools_MoveMixin:Setup(CalendarViewHolidayFrame, {frame=CalendarFrame})
    WoWTools_MoveMixin:Setup(CalendarViewRaidFrame, {frame=CalendarFrame})
end

--要塞
WoWTools_MoveMixin.ADDON_LOADED['Blizzard_GarrisonUI']= function()
    WoWTools_MoveMixin:Setup(GarrisonShipyardFrame)--海军行动
    WoWTools_MoveMixin:Setup(GarrisonMissionFrame)--要塞任务
    WoWTools_MoveMixin:Setup(GarrisonCapacitiveDisplayFrame)--要塞订单
    WoWTools_MoveMixin:Setup(GarrisonLandingPage)--要塞报告
    WoWTools_MoveMixin:Setup(OrderHallMissionFrame)
end

--任务选择
WoWTools_MoveMixin.ADDON_LOADED['Blizzard_PlayerChoice']= function()
    WoWTools_MoveMixin:Setup(PlayerChoiceFrame, {notZoom=true, notSave=true})
end

--公会银行
WoWTools_MoveMixin.ADDON_LOADED['Blizzard_GuildBankUI']= function()
    WoWTools_MoveMixin:Setup(GuildBankFrame)
end

--飞行地图
WoWTools_MoveMixin.ADDON_LOADED['Blizzard_FlightMap']= function()
    WoWTools_MoveMixin:Setup(FlightMapFrame)
end


WoWTools_MoveMixin.ADDON_LOADED['Blizzard_OrderHallUI']= function()
    WoWTools_MoveMixin:Setup(OrderHallTalentFrame)
end


WoWTools_MoveMixin.ADDON_LOADED['Blizzard_GenericTraitUI']= function()
    WoWTools_MoveMixin:Setup(GenericTraitFrame)
    WoWTools_MoveMixin:Setup(GenericTraitFrame.ButtonsParent, {frame=GenericTraitFrame})
end

--周奖励面板
WoWTools_MoveMixin.ADDON_LOADED['Blizzard_WeeklyRewards']= function()
    WoWTools_MoveMixin:Setup(WeeklyRewardsFrame)
    WoWTools_MoveMixin:Setup(WeeklyRewardsFrame.Blackout, {frame=WeeklyRewardsFrame})
end

--镶嵌宝石，界面
WoWTools_MoveMixin.ADDON_LOADED['Blizzard_ItemSocketingUI']= function()
    C_Timer.After(2, function()
        WoWTools_MoveMixin:Setup(ItemSocketingFrame)
        WoWTools_MoveMixin:Setup(ItemSocketingScrollChild, {frame=ItemSocketingFrame})
    end)
end

--装备升级,界面
WoWTools_MoveMixin.ADDON_LOADED['Blizzard_ItemUpgradeUI']= function()
    WoWTools_MoveMixin:Setup(ItemUpgradeFrame)
end

--玩家, 观察角色, 界面
WoWTools_MoveMixin.ADDON_LOADED['Blizzard_InspectUI']= function()
    if InspectFrame then
        WoWTools_MoveMixin:Setup(InspectFrame)
    end
end

--套装, 转换
WoWTools_MoveMixin.ADDON_LOADED['Blizzard_ItemInteractionUI']= function()
    C_Timer.After(2, function()
        WoWTools_MoveMixin:Setup(ItemInteractionFrame)
    end)
end

--专业书
WoWTools_MoveMixin.ADDON_LOADED['Blizzard_ProfessionsBook']= function()
    WoWTools_MoveMixin:Setup(ProfessionsBookFrame)
end

--虚空，仓库
WoWTools_MoveMixin.ADDON_LOADED['Blizzard_VoidStorageUI']= function()
    WoWTools_MoveMixin:Setup(VoidStorageFrame)
end

--时光漫游
WoWTools_MoveMixin.ADDON_LOADED['Blizzard_ChromieTimeUI']= function()
    WoWTools_MoveMixin:Setup(ChromieTimeFrame)
end

--侦查地图
WoWTools_MoveMixin.ADDON_LOADED['Blizzard_BFAMissionUI']= function()
    WoWTools_MoveMixin:Setup(BFAMissionFrame)
end

--宏
WoWTools_MoveMixin.ADDON_LOADED['Blizzard_MacroUI']= function()
    C_Timer.After(2, function()--给 Macro.lua 用
        WoWTools_MoveMixin:Setup(MacroFrame)
    end)
end

--派系声望
WoWTools_MoveMixin.ADDON_LOADED['Blizzard_MajorFactions']= function()
    WoWTools_MoveMixin:Setup(MajorFactionRenownFrame)
end

--ETRACE
WoWTools_MoveMixin.ADDON_LOADED['Blizzard_EventTrace']= function()
    EventTrace.Log.Bar.SearchBox:SetPoint('LEFT', EventTrace.Log.Bar.Label, 'RIGHT')
    EventTrace.Log.Bar.SearchBox:SetScript('OnEditFocusGained', function(self)
        self:HighlightText()
    end)
    WoWTools_MoveMixin:Setup(EventTrace)
end

--死亡
WoWTools_MoveMixin.ADDON_LOADED['Blizzard_DeathRecap']= function()
    WoWTools_MoveMixin:Setup(DeathRecapFrame, {save=true})
end

--点击，施法
WoWTools_MoveMixin.ADDON_LOADED['Blizzard_ClickBindingUI']= function()
    WoWTools_MoveMixin:Setup(ClickBindingFrame)
    WoWTools_MoveMixin:Setup(ClickBindingFrame.ScrollBox, {frame=ClickBindingFrame})
end


WoWTools_MoveMixin.ADDON_LOADED['Blizzard_ArchaeologyUI']= function()
    WoWTools_MoveMixin:Setup(ArchaeologyFrame)
end


WoWTools_MoveMixin.ADDON_LOADED['Blizzard_CovenantRenown']= function()
    WoWTools_MoveMixin:Setup(CovenantRenownFrame)
end


WoWTools_MoveMixin.ADDON_LOADED['Blizzard_ScrappingMachineUI']= function()
    WoWTools_MoveMixin:Setup(ScrappingMachineFrame)
end


WoWTools_MoveMixin.ADDON_LOADED['Blizzard_ArtifactUI']= function()
    WoWTools_MoveMixin:Setup(ArtifactFrame)
end


WoWTools_MoveMixin.ADDON_LOADED['Blizzard_DelvesDashboardUI']= function()
    WoWTools_MoveMixin:Setup(DelvesCompanionConfigurationFrame)
    WoWTools_MoveMixin:Setup(DelvesCompanionAbilityListFrame)
    WoWTools_MoveMixin:Setup(DelvesDashboardFrame, {frame=PVEFrame})
    WoWTools_MoveMixin:Setup(DelvesDashboardFrame.ButtonPanelLayoutFrame, {frame=PVEFrame})
    WoWTools_MoveMixin:Setup(DelvesDashboardFrame.ButtonPanelLayoutFrame.CompanionConfigButtonPanel, {frame=PVEFrame})
end


WoWTools_MoveMixin.ADDON_LOADED['Blizzard_HelpFrame']= function()
    WoWTools_MoveMixin:Setup(HelpFrame)
    WoWTools_MoveMixin:Setup(HelpFrame.TitleContainer, {frame=HelpFrame})
end


--[[邮箱，信件  Mail.lua，有操作
WoWTools_MoveMixin.ADDON_LOADED['MAIL_SHOW']= function()
    WoWTools_MoveMixin:Setup(MailFrame)
end]]