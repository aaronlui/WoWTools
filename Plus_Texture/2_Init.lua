local id, e = ...

WoWTools_TextureMixin.Save={
    --disabled=true,
    --disabledTexture=true,
    alpha= 0.5,

    --disabledChatBubble=true,--禁用，聊天泡泡
    chatBubbleAlpha= 0.5,--聊天泡泡
    chatBubbleSacal= 0.85,

    classPowerNum= e.Player.husandro,--职业，显示数字
    classPowerNumSize= 12,

    --disabledMainMenu= not e.Player.husandro, --主菜单，颜色，透明度
    --disabledHelpTip=true,--隐藏所有教程

    HideTalentsBG=true,--隐藏，天赋，背景
}

local function Save()
    return WoWTools_TextureMixin.Save
end










local function Init()
    WoWTools_TextureMixin:Init_Class_Power()--职业
    WoWTools_TextureMixin:Init_Chat_Bubbles()--聊天泡泡
    WoWTools_TextureMixin:Init_HelpTip()--隐藏教程
    WoWTools_TextureMixin:Init_Action_Button()

    if not Save().disabledTexture then
        WoWTools_TextureMixin:Init_All_Frame()
        WoWTools_TextureMixin:Init_Event()

        hooksecurefunc(DropdownTextMixin, 'OnLoad', function(self)
            WoWTools_TextureMixin:SetMenu(self)
        end)
        hooksecurefunc(DropdownButtonMixin, 'SetupMenu', function(self)
            WoWTools_TextureMixin:SetMenu(self)
        end)
    end
end





local panel= CreateFrame("Frame")
panel:RegisterEvent("ADDON_LOADED")
panel:RegisterEvent("PLAYER_LOGOUT")
panel:SetScript("OnEvent", function(self, event, arg1)
    if event == "ADDON_LOADED" then
        if arg1== id then
            WoWTools_TextureMixin.Save= WoWToolsSave['Plus_Texture'] or Save()

            local addName= '|A:AnimCreate_Icon_Texture:0:0|a'..(e.onlyChinese and '材质' or TEXTURES_SUBHEADER)
            WoWTools_TextureMixin.addName= addName

            WoWTools_TextureMixin:Init_Options()

            if Save().disabled then
                self:UnregisterEvent(event)
            else
                Init()
                if Save().disabledTexture then
                    self:UnregisterEvent(event)
                end
            end

        else
            WoWTools_TextureMixin:Set_Event(arg1)
        end

    elseif event == "PLAYER_LOGOUT" then
        if not e.ClearAllSave then
            WoWToolsSave['Plus_Texture']=Save()
        end
    end
end)