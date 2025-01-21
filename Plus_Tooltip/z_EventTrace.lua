local e= select(2, ...)




local function Init()

    hooksecurefunc(EventTraceLogEventButtonMixin, 'OnEnter', function()
        EventTraceTooltip:AddLine(' ')
        EventTraceTooltip:AddDoubleLine(
            (e.onlyChinese and '双倍' or BUFFER_DOUBLE)..e.Icon.left..'|cnGREEN_FONT_COLOR:'..(e.onlyChinese and '搜索' or SEARCH),
            e.Icon.right..(e.onlyChinese and '复制' or CALENDAR_COPY_EVENT)
        )
        EventTraceTooltip:Show()
    end)

    WoWTools_TooltipMixin.AddOn.Blizzard_EventTrace=nil
end





function WoWTools_TooltipMixin.AddOn.Blizzard_EventTrace()
    Init()
end