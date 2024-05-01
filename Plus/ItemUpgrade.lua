local id, e= ...
local addName= ITEM_UPGRADE--物品升级
local Save= {
}
local Initializer



--####################
--添加一个按钮, 打开选项
--####################
local function add_Button_OpenOption(frame)
    if not frame then
        return
    end
    local btn= e.Cbtn(frame, {atlas='charactercreate-icon-customize-body-selected', size={40,40}})
    btn:SetPoint('TOPRIGHT',-5,-25)
    btn:SetScript('OnClick', function()
        ToggleCharacter("PaperDollFrame")
    end)
    btn:SetScript('OnEnter', function(self)
        e.tips:SetOwner(self, "ANCHOR_LEFT")
        e.tips:ClearLines()
        e.tips:AddDoubleLine(e.onlyChinese and '打开/关闭角色界面' or BINDING_NAME_TOGGLECHARACTER0, e.Icon.left)
        e.tips:AddLine(' ')
        e.tips:AddDoubleLine(id, Initializer:GetName())
        e.tips:Show()
    end)
    btn:SetScript('OnLeave', GameTooltip_Hide)
    if frame==ItemUpgradeFrameCloseButton then--装备升级, 界面
        --物品，货币提示
        e.ItemCurrencyLabel({frame=ItemUpgradeFrame, point={'TOPLEFT', nil, 'TOPLEFT', 2, -55}})
        btn:SetScript("OnEvent", function()
            --物品，货币提示
            e.ItemCurrencyLabel({frame=ItemUpgradeFrame, point={'TOPLEFT', nil, 'TOPLEFT', 2, -55}})
        end)
        btn:SetScript('OnShow', function(self)
            e.ItemCurrencyLabel({frame=ItemUpgradeFrame, point={'TOPLEFT', nil, 'TOPLEFT', 2, -55}})
            self:RegisterEvent('BAG_UPDATE_DELAYED')
            self:RegisterEvent('CURRENCY_DISPLAY_UPDATE')
        end)
        btn:SetScript('OnHide', function(self)
            self:UnregisterAllEvents()
        end)
    end
end







local function Init_ItemInteractionFrame()
    e.Set_Move_Frame(ItemInteractionFrame, {setSize=true, needSize=true, needMove=true, restSizeFunc=function(btn)

    end})
end

local panel= CreateFrame('Frame')
panel:RegisterEvent('PLAYER_LOGOUT')
panel:RegisterEvent('ADDON_LOADED')
panel:SetScript("OnEvent", function(self, event, arg1)
    if event == "ADDON_LOADED" then
        if arg1==id then
            Save= WoWToolsSave[addName] or Save
            
            --添加控制面板
            Initializer= e.AddPanel_Check({
                name= format('|A:Garr_UpgradeIcon:0:0|a%s', e.onlyChinese and '物品升级' or addName),
                tooltip= e.onlyChinese and '系统背包|n商人' or (BAGSLOT..'|n'..MERCHANT),--'Inventorian, Baggins', 'Bagnon'
                value= not Save.disabled,
                func= function()
                    if Save.disabled then
                        Save.disabled=nil
                        panel:UnregisterEvent('COMBAT_LOG_EVENT_UNFILTERED')
                    else
                        Save.disabled=true
                        panel:RegisterEvent('COMBAT_LOG_EVENT_UNFILTERED')
                    end
                    print(id, Initializer:GetName(), e.GetEnabeleDisable(Save.disabled))
                end
            })
            
            if Save.disabled then
                self:UnregisterEvent("ADDON_LOADED")
            end

        elseif arg1=='Blizzard_ItemInteractionUI' then--套装转换, 界面
            Init_ItemInteractionFrame()
            add_Button_OpenOption(ItemInteractionFrameCloseButton)--添加一个按钮, 打开选项

        elseif arg1=='Blizzard_ItemUpgradeUI' then--装备升级, 界面
            add_Button_OpenOption(ItemUpgradeFrameCloseButton)--添加一个按钮, 打开选项
        end
    elseif event == "PLAYER_LOGOUT" then
        if not e.ClearAllSave then
            WoWToolsSave[addName]=Save
        end
	end
end)