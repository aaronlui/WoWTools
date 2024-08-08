local e= select(2, ...)

WoWToolsFrameMixin= {}

function e.ShowTextFrame(data)
    if not data then
        return
    end

    local frame= _G['WoWTools_EditBoxFrame']
    if not frame then
        frame= WoWToolsFrameMixin:CreateFrame('WoWTools_EditBoxFrame')
    end

    local text
    if type(data)=='table' then
        for _, str in pairs(data) do
            text= text and text..'\n' or ''
            text= text.. str
        end
    else
        text= data
    end
end




--[[
WoWToolsEditBoxFrameMixin:CreateFrame(name, {
    size={w, h} or numeri,
    parentFrame= frame or UIParent,
    setID=numeri, --SetID(1)
    strata='HIGH', BACKGROUND LOW MEDIUM HIGH DIALOG FULLSCREEN FULLSCREEN_DIALOG TOOLTIP

    minW=numeri or 370,
    mniH=numeri or 240

    sizeRestFunc=function(btn) btn:SetSize() end)
}

frame.Header:Setup(text)

--]]

local index= 0
function WoWToolsFrameMixin:CreateFrame(name, tab)
    if not name then
        name= 'WoWTools_EditBoxFrame'..index
    end

    tab= tab or {}
    local w, h= 580, 370
    if tab.size then
        if type(tab.size)=='table' then
            w=tab.size[1]
            h=tab.size[2]
        else
            w,h= tab.size, tab.size
        end
    end

    local frame= CreateFrame('Frame', name, tab.parent or UIParent, tab.template, tab.setID)

    frame:SetSize(w,h)
    frame:SetFrameStrata(tab.strata or 'HIGH')
    frame:SetPoint('CENTER')


    frame.Border= CreateFrame('Frame', nil, frame,'DialogBorderTemplate')
    frame.Header= CreateFrame('Frame', nil, frame, 'DialogHeaderTemplate')--DialogHeaderMixin
    local CloseButton=CreateFrame('Button', nil, frame, 'UIPanelCloseButton')
    CloseButton:SetPoint('TOPRIGHT')

    e.Set_Alpha_Frame_Texture(frame.Border, {alpha=0.5})
    e.Set_Alpha_Frame_Texture(frame.Header, {alpha=0.7})

    frame.width= w
    frame.height= h
    e.Set_Move_Frame(frame, {
        needMove=true,
        minW=tab.minW or 370,
        minH=tab.minH or 240,
        notFuori=true,
        setSize=true,
        sizeRestFunc= tab.sizeRestFunc or function(btn)
            btn.target:SetSize(btn.target.width or 580, btn.target.height or 370)
        end,
    })

    index= index+1
    return frame
end
