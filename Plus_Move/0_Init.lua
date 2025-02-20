local id, e = ...
WoWTools_MoveMixin={
Save={
    --disabledMove=true,--禁用移动
    point={},--移动
    SavePoint= e.Player.husandro,--保存窗口,位置
    moveToScreenFuori=e.Player.husandro,--可以移到屏幕外

    --disabledZoom=true,--禁用缩放
    scale={--缩放
        ['UIWidgetPowerBarContainerFrame']= e.Player.husandro and 0.85 or 1,
        ['ZoneAbilityFrame']= e.Player.husandro and 0.75 or 1,
    },
    size={},
    disabledSize={},--['CharacterFrame']= true

    --notMoveAlpha=true,--是否设置，移动时，设置透明度
    alpha=0.5,
    disabledAlpha={},
},
ADDON_LOADED={}
}

local function Save()
    return WoWTools_MoveMixin.Save
end





local function Setup(name)
    local func= WoWTools_MoveMixin.ADDON_LOADED[name]
    if not func then
        return
    end
    do
        func()
    end
    WoWTools_MoveMixin.ADDON_LOADED[name]=nil
end




local function Init()
    WoWTools_MoveMixin:Init_Communities()--公会和社区
    WoWTools_MoveMixin:Init_WorldMapFrame()--世界地图
    WoWTools_MoveMixin:Init_CharacterFrame()--角色
    WoWTools_MoveMixin:Init_FriendsFrame()--好友列表
    WoWTools_MoveMixin:Init_PVEFrame()--地下城和团队副本
    WoWTools_MoveMixin:Init_QuestFrame()--任务
    WoWTools_MoveMixin:Init_AddButton()--添加，移动/缩放，按钮
    WoWTools_MoveMixin:Init_Other()
    WoWTools_MoveMixin:Init_Class_Power()--职业，能量条

    for name in pairs(WoWTools_MoveMixin.ADDON_LOADED) do
        if C_AddOns.IsAddOnLoaded(name) then
            Setup(name)
        end
    end
end



EventRegistry:RegisterFrameEventAndCallback("ADDON_LOADED", function(owner, arg1)
    if arg1==id then

        WoWTools_MoveMixin.Save= WoWToolsSave['Plus_Move'] or WoWTools_MoveMixin.Save
        WoWTools_MoveMixin.addName= '|TInterface\\Cursor\\UI-Cursor-Move:0|t'..(e.onlyChinese and '移动' or NPE_MOVE)
        WoWTools_MoveMixin:Init_Options()

        if Save().disabled then
            EventRegistry:UnregisterCallback('ADDON_LOADED', owner)
        else
            Init()--初始, 移动
        end
    else
        Setup(arg1)
    end
end)

EventRegistry:RegisterFrameEventAndCallback("PLAYER_LOGOUT", function()
    if not e.ClearAllSave then
        WoWToolsSave['Plus_Move']= WoWTools_MoveMixin.Save
    end
end)