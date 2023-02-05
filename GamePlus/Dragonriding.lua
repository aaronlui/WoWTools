local id, e= ...

if e.Player.level~=MAX_PLAYER_LEVEL then
    return
end

local addName= MOUNT_JOURNAL_FILTER_DRAGONRIDING..SPEED
local Save= {}
local panel= CreateFrame("Frame")

local lastX, lastY, lastT = 0, 0, 0
local function get_Speed()
    local time = GetTime()
    local dt = time - lastT
    local uiMapID = C_Map.GetBestMapForUnit('player')
    if uiMapID then
        local position = C_Map.GetPlayerMapPosition(uiMapID, "player")
        if position then
            local x, y = position.x, position.y
            local w, h = C_Map.GetMapWorldSize(uiMapID)
            x = x * w
            y = y * h
            local dx = x - lastX
            local dy = y - lastY

            local groundSpeed = math.sqrt(dx * dx + dy * dy) / dt
            if groundSpeed > 0 then
                local cosTheta = math.cos(math.abs(0))
                if cosTheta > 0 then
                    lastX = x
                    lastY = y
                    lastT = time
                    return groundSpeed / cosTheta
                end
            end
        end
    end
    lastX, lastY, lastT = 0, 0, 0
end

local timeElapsed = 0
local speedTextFactor = 100 / BASE_MOVEMENT_SPEED
panel:SetScript('OnUpdate', function(self, elapsed)
    timeElapsed = timeElapsed + elapsed
    if timeElapsed > 0.3 then
        local speed= get_Speed()
        if speed and speed>6 then
            speed= speed * speedTextFactor
            if speed>=1000 then
                self.text:SetFormattedText('|cffff0000%.0f%%', speed)
                self.statusBar:SetStatusBarColor(1, 0, 0)
            elseif speed>=800 then
                self.text:SetFormattedText('|cff00ff00%.0f%%', speed)
                self.statusBar:SetStatusBarColor(0, 1, 0)
            elseif speed>=600 then
                self.text:SetFormattedText('|cffff00ff%.0f%%', speed)
                self.statusBar:SetStatusBarColor(1, 0, 1)
            else
                self.text:SetFormattedText('%.0f%%', speed)
                self.statusBar:SetStatusBarColor(0.8, 0.8, 0)
            end
            self.statusBar:SetValue(speed>1000 and 1000 or speed)
        else
            self.text:SetText('')
            self.statusBar:SetValue(0)
        end
        timeElapsed = 0
    end
end)


local function set_Shown()
    if IsMounted() then
        for _, mountID in ipairs(C_MountJournal.GetCollectedDragonridingMounts()) do
            if select(4, C_MountJournal.GetMountInfoByID(mountID)) then
                panel:SetShown(true)
                return
            end
        end
    end
    panel:SetShown(false)
end


local function set_Events()
    if not IsInInstance() then
        panel:RegisterEvent('PLAYER_MOUNT_DISPLAY_CHANGED')
        panel:RegisterEvent('MOUNT_JOURNAL_USABILITY_CHANGED')
        panel:RegisterEvent('LEARNED_SPELL_IN_TAB')
        panel:RegisterUnitEvent('UNIT_SPELLCAST_SUCCEEDED','player')
        panel:RegisterEvent('VEHICLE_ANGLE_UPDATE')
        panel:RegisterEvent('UPDATE_UI_WIDGET')
        panel:SetShown(true)
    else
        panel:UnregisterEvent('PLAYER_MOUNT_DISPLAY_CHANGED')
        panel:UnregisterEvent('MOUNT_JOURNAL_USABILITY_CHANGED')
        panel:UnregisterEvent('LEARNED_SPELL_IN_TAB')
        panel:UnregisterEvent('UNIT_SPELLCAST_SUCCEEDED')
        panel:UnregisterEvent('VEHICLE_ANGLE_UPDATE')
        panel:UnregisterEvent('UPDATE_UI_WIDGET')
        panel:SetShown(false)
    end
end

panel:RegisterEvent('ADDON_LOADED')
panel:RegisterEvent('PLAYER_ENTERING_WORLD')


--####
--初始
--####
local function Init()
    panel.text= e.Cstr(panel, 16)
    panel.text:SetPoint('BOTTOM', UIWidgetPowerBarContainerFrame, 'TOP',0, 3)

    panel.statusBar= CreateFrame('StatusBar', nil, panel)
    panel.statusBar:SetStatusBarTexture('UI-HUD-UnitFrame-Player-PortraitOn-Bar-Health-Status')
    panel.statusBar:SetStatusBarColor(0.8, 0.8, 0)
    panel.statusBar:SetPoint('BOTTOM', UIWidgetPowerBarContainerFrame, 'TOP')
    panel.statusBar:SetMinMaxValues(0, 1000)
    panel.statusBar:SetSize(150, 3)
    panel.statusBar:SetValue(0)

    panel:SetScript('OnHide', function(self)
        lastX, lastY, lastT = 0, 0, 0
        self.text:SetText('')
        self.statusBar:SetValue(0)
        self.statusBar:SetShown(false)
    end)
    panel:SetScript('OnShow', function(self)
        self.statusBar:SetShown(true)
    end)
end

panel:SetScript("OnEvent", function(self, event, arg1)
    if event == "ADDON_LOADED" and arg1==id then
        Save= WoWToolsSave and WoWToolsSave[addName] or Save

        --添加控制面板        
        local sel=e.CPanel((e.onlyChinse and '驭龙术速度' or addName)..'|A:dragonriding_vigor_decor:0:0|a', not Save.disabled, true)
        sel:SetScript('OnMouseDown', function()
            Save.disabled = not Save.disabled and true or nil
            print(id, addName, e.GetEnabeleDisable(not Save.disabled), e.onlyChinse and '重新加载UI' or RELOADUI)
        end)
        sel:SetScript('OnEnter', function(self2)
            e.tips:SetOwner(self2, "ANCHOR_LEFT")
            e.tips:ClearLines()
            if e.onlyChinse then
                e.tips:AddDoubleLine('仅限: 不在副本', '等级: '..MAX_PLAYER_LEVEL)
            else
                e.tips:AddDoubleLine(format(LFG_LIST_CROSS_FACTION, BUG_CATEGORY2), LEVEL..': '..MAX_PLAYER_LEVEL)

            end
            e.tips:Show()
        end)
        sel:SetScript('OnLeave', function() e.tips:Hide() end)

        if Save.disabled then
            panel:UnregisterAllEvents()
        else
            Init()
        end
        panel:RegisterEvent("PLAYER_LOGOUT")
        panel:UnregisterEvent('ADDON_LOADED')

    elseif event=='PLAYER_LOGOUT' then
        if not e.ClearAllSave then
            if not WoWToolsSave then WoWToolsSave={} end
            WoWToolsSave[addName]=Save
        end

    elseif event=='PLAYER_ENTERING_WORLD' then
        set_Events()

    else
        set_Shown()
    end
end)
--https://wago.io/KIIAJSKl1