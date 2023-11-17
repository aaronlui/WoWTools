local id, e = ...
--Blizzard_Deprecated/Deprecated_10_2_0.lua
e.WoWDate={}
e.tips=GameTooltip
e.LibDD=LibStub:GetLibrary("LibUIDropDownMenu-4.0", true)
e.call= securecall
e.LeftButtonDown = C_CVar.GetCVarBool("ActionButtonUseKeyDown") and 'LeftButtonDown' or 'LeftButtonUp'
e.RightButtonDown= C_CVar.GetCVarBool("ActionButtonUseKeyDown") and 'RightButtonDown' or 'RightButtonUp'
--e.onlyChinese= Save.onlyChinese or LOCALE_zhCN

e.itemSlotTable={
    ['INVTYPE_HEAD']=1,
    ['INVTYPE_NECK']=2,
    ['INVTYPE_SHOULDER']=3,
    ['INVTYPE_BODY']=4,
    ['INVTYPE_CHEST']=5,
    ['INVTYPE_WAIST']=6,
    ['INVTYPE_LEGS']=7,
    ['INVTYPE_FEET']=8,
    ['INVTYPE_WRIST']=9,
    ['INVTYPE_HAND']=10,
    ['INVTYPE_FINGER']=11,
    ['INVTYPE_TRINKET']=13,
    ['INVTYPE_WEAPON']=16,
    ['INVTYPE_SHIELD']=17,
    ['INVTYPE_RANGED']=16,
    ['INVTYPE_CLOAK']=15,
    ['INVTYPE_2HWEAPON']=16,
    ['INVTYPE_TABARD']=19,
    ['INVTYPE_ROBE']=5,
    ['INVTYPE_WEAPONMAINHAND']=16,
    ['INVTYPE_WEAPONOFFHAND']=16,
    ['INVTYPE_HOLDABLE']=17,
    ['INVTYPE_THROWN']=16,
    ['INVTYPE_RANGEDRIGHT']=16,
}
e.ExpansionLevel= GetExpansionLevel()--版本数据

local function GetWeek()--周数
    local region= GetCurrentRegion()
    local d = date("*t")
    local cd= region==1 and 2 or region==3 and 3 or 4--1US(includes Brazil and Oceania) 2Korea 3Europe (includes Russia) 4Taiwan 5China
    for d3=1,15 do
        if date('*t', time({year=d.year, month=1, day=d3})).wday == cd then
            cd=d3
            break
        end
    end
    local week=ceil(floor((time() - time({year= d.year, month= 1, day= cd})) / (24*60*60)) /7)
    if week==0 then
        week=52
    end
    return week
end


local battleTag= select(2, BNGetInfo())
local baseClass= UnitClassBase('player')
e.Player={
    realm= GetRealmName(),
    Realms= {},--多服务器
    name_realm= UnitName('player')..'-'..GetRealmName(),
    name= UnitName('player'),
    sex= UnitSex("player"),
    class= baseClass,
    r= GetClassColor(baseClass),
    g= select(2,GetClassColor(baseClass)),
    b= select(3, GetClassColor(baseClass)),
    col= '|c'..select(4, GetClassColor(baseClass)),
    cn= GetCurrentRegion()==5,
    region= GetCurrentRegion(),--1US (includes Brazil and Oceania) 2Korea 3Europe (includes Russia) 4Taiwan 5China
    --Lo= GetLocale(),
    week= GetWeek(),--周数
    guid= UnitGUID('player'),
    levelMax= UnitLevel('player')==MAX_PLAYER_LEVEL,--玩家是否最高等级
    level= UnitLevel('player'),--UnitEffectiveLevel('player')
    husandro= battleTag== '古月剑龙#5972' or battleTag=='SandroChina#2690' or battleTag=='Sandro126#2297' or battleTag=='Sandro163EU#2603',
    faction= UnitFactionGroup('player'),--玩家, 派系  "Alliance", "Horde", "Neutral"
    Layer= nil, --位面数字
    --useColor= nil,--使用颜色
    L={},--多语言，文本
}
e.Player.useColor= {r=e.Player.r, g=e.Player.g, b=e.Player.b, a=1, hex= e.Player.col}--使用颜色

 --MAX_PLAYER_LEVEL = GetMaxLevelForPlayerExpansion()
 --zh= LOCALE_zhCN or LOCALE_zhTW,--GetLocale()== ("zhCN" or 'zhTW'),
 --ver= select(4,GetBuildInfo())>=100100,--版本 100100
 --disabledLUA={},--禁用插件 {save='', text} e.DisabledLua=true
for k, v in pairs(GetAutoCompleteRealms()) do
    e.Player.Realms[v]=k
end


e.Icon={
    icon= 'orderhalltalents-done-glow',
    disabled='talents-button-reset',
    select='common-icon-checkmark',--'GarrMission_EncounterBar-CheckMark',--绿色√
    select2='|A:common-icon-checkmark:0:0|a',--绿色√
    --selectYellow='common-icon-checkmark-yellow',--黄色√
    X2='|A:common-icon-redx:0:0|a',
    O2='|A:talents-button-reset:0:0|a',--￠
    right='|A:newplayertutorial-icon-mouse-rightbutton:0:0|a',
    left='|A:newplayertutorial-icon-mouse-leftbutton:0:0|a',
    mid='|A:newplayertutorial-icon-mouse-middlebutton:0:0|a',
    map='poi-islands-table',
    map2='|A:poi-islands-table:0:0|a',
    wow=136235,
    wow2='|T136235:0|t',--'|A:Icon-WoW:0:0|a',--136235
    net2= BNet_GetClientEmbeddedTexture(-2, 32, 32),
    horde= 'charcreatetest-logo-horde',
    alliance='charcreatetest-logo-alliance',
    horde2='|A:charcreatetest-logo-horde:0:0|a',
    alliance2='|A:charcreatetest-logo-alliance:0:0|a',

    number='services-number-',
    number2='|A:services-number-%d:0:0|a',
    clock='socialqueuing-icon-clock',
    clock2='|A:socialqueuing-icon-clock:0:0|a',

    --player= e.GetUnitRaceInfo({unit='player', guid=nil , race=nil , sex=nil , reAtlas=false}),

    bank2='|A:Banker:0:0|a',
    bag='bag-main',
    bag2='|A:bag-main:0:0|a',
    bagEmpty='bag-reagent-border-empty',

    up2='|A:bags-greenarrow:0:0|a',--绿色向上, 红色向上 UI-HUD-Minimap-Arrow-Corpse， 金色 UI-HUD-Minimap-Arrow-Guard
    down2='|A:UI-HUD-MicroMenu-StreamDLRed-Up:0:0|a',--红色向下
    toLeft='common-icon-rotateleft',--向左
    toLeft2='|A:common-icon-rotateleft:0:0|a',
    toRight='common-icon-rotateright',--向右
    toRight2='|A:common-icon-rotateright:0:0|a',

    unlocked='tradeskills-icon-locked',--'Levelup-Icon-Lock',--没锁
    quest='AutoQuest-Badge-Campaign',--任务
    guild2='|A:UI-HUD-MicroMenu-GuildCommunities-Mouseover:0:0|a',--guild2='|A:communities-guildbanner-background:0:0|a',

    TANK='|A:UI-LFG-RoleIcon-Tank:0:0|a',
    HEALER='|A:UI-LFG-RoleIcon-Healer:0:0|a',
    DAMAGER='|A:UI-LFG-RoleIcon-DPS:0:0|a',
    NONE='|A:UI-LFG-RoleIcon-Pending:0:0|a',
    leader='|A:UI-HUD-UnitFrame-Player-Group-GuideIcon:0:0|a',--队长

    info2='|A:questlegendary:0:0|a',--黄色!
    star2='|A:auctionhouse-icon-favorite:0:0|a',--星星
}


C_Texture.GetTitleIconTexture(BNET_CLIENT_WOW, Enum.TitleIconVersion.Medium, function(success, texture)--FriendsFrame.lua BnetShared.lua    
    if success and texture then
        e.Icon.wow2= '|T'..texture..':0|t'
        e.Icon.wow= texture
        e.Icon.net2= e.Icon.wow2
    end
end)

--[[C_Texture.GetTitleIconTexture(BNET_CLIENT_CLNT, Enum.TitleIconVersion.Small, function(success, texture)
    if success and texture then
        e.Icon.net2= '|T'..texture..':0|t'
    end
end)]]

function e.LoadDate(tab)--e.LoadDate({id=, type=''})--加载 item quest spell, uiMapID
    if not tab.id then
        return
    end
    if tab.type=='quest' then
            C_QuestLog.RequestLoadQuestByID(tab.id)
            if not HaveQuestRewardData(tab.id) then
                C_TaskQuest.RequestPreloadRewardData(tab.id)
            end
    elseif tab.type=='spell' then
        local spellID= tab.id
        if type(tab.id)=='string' then
            spellID= select(7, GetSpellInfo(tab.id))
        end
        if spellID and not C_Spell.IsSpellDataCached(spellID) then C_Spell.RequestLoadSpellData(spellID) end
    elseif tab.type=='item' then
        if not C_Item.IsItemDataCachedByID(tab.id) then C_Item.RequestLoadItemDataByID(tab.id) end

    end
end

local itemLoadTab={--加载法术,或物品数据
        134020,--玩具,大厨的帽子
        6948,--炉石
        140192,--达拉然炉石
        110560,--要塞炉石
        5512,--治疗石
        8529,--诺格弗格药剂
        38682,--附魔纸
        179244,--[召唤司机]
        179245,
    }
local spellLoadTab={
        818,--火
    }
for _, itemID in pairs(itemLoadTab) do
    e.LoadDate({id=itemID, type='item'})
end
for _, spellID in pairs(spellLoadTab) do
    e.LoadDate({id=spellID, type='spell'})
end













function e.MK(number, bit)
    if not number then
        return
    end
    bit = bit or 1

    local text= ''
    if number>=1e6 then
        number= number/1e6
        text= 'm'
    elseif number>= 1e4 and e.onlyChinese then
        number= number/1e4
        text='w'
    elseif number>=1e3 then
        number= number/1e3
        text= 'k'
    end

    if bit==0 then
        return math.modf(number)..text
    else
        local num, point= math.modf(number)
        if point==0 then
            return num..text
        else
            point= point*(10^2)
            point= math.modf(point)
            return num..(point>0 and '.'..point or '')..text
        end
    end
end

function e.GetShowHide(sh, all)
    if all then
        return e.onlyChinese and '显示/隐藏' or (SHOW..'/'..HIDE)
    elseif sh then
		return '|cnGREEN_FONT_COLOR:'..(e.onlyChinese and '显示' or SHOW)..'|r'
	else
		return '|cnRED_FONT_COLOR:'..(e.onlyChinese and '隐藏' or HIDE)..'|r'
	end
end

function e.GetEnabeleDisable(ed)--启用或禁用字符
    if ed then
        return '|cnGREEN_FONT_COLOR:'..(e.onlyChinese and '启用' or ENABLE)..'|r'
    else
        return '|cnRED_FONT_COLOR:'..(e.onlyChinese and '禁用' or DISABLE)..'|r'
    end
end

function e.GetYesNo(yesno)
    if yesno then
        return '|cnGREEN_FONT_COLOR:'..(e.onlyChinese and '是' or YES)..'|r'
    else
        return '|cnRED_FONT_COLOR:'..(e.onlyChinese and '否' or NO)..'|r'
    end
end

--设置颜色
function e.Set_Label_Texture_Color(self, tab)--设置颜色
    if self and e.Player.useColor then
        tab= tab or {}
        local type= tab.type or type(self)
        local alpha= tab.alpha
        if type=='FontString' or type=='EditBox' then
            self:SetTextColor(e.Player.useColor.r, e.Player.useColor.g, e.Player.useColor.b, alpha or e.Player.useColor.a or 1)
        
        elseif type=='Texture' then
            self:SetVertexColor(e.Player.useColor.r, e.Player.useColor.g, e.Player.useColor.b, alpha or e.Player.useColor.a or 1)
        elseif type=='Button' then
            local texture= self:GetNormalTexture()
            if texture then
                texture:SetVertexColor(e.Player.useColor.r, e.Player.useColor.g, e.Player.useColor.b, alpha or e.Player.useColor.a or 1)
            end
        elseif type=='String' then
            return e.Player.useColor.hex..self
        end
    end
end

function e.Cstr(self, tab)
    tab= tab or {}
    self= self or UIParent
    local alpha= tab.alpha
    local font= tab.changeFont
    local layer= tab.layer or 'OVERLAY'
    local fontName= tab.fontName or 'GameFontNormal'
    local level= table.level or self:GetFrameLevel()+1
    local copyFont= tab.copyFont
    local size= tab.size
    local justifyH= tab.justifyH
    local notFlag= tab.notFlag
    local notShadow= tab.notShadow
    local color= tab.color
    local mouse= tab.mouse
    local wheel= tab.wheel
    font = font or self:CreateFontString(nil, layer, fontName, level)
    if copyFont then
        local fontName2, size2, fontFlag2 = copyFont:GetFont()
        font:SetFont(fontName2, size or size2, fontFlag2)
        font:SetTextColor(copyFont:GetTextColor())
        font:SetFontObject(copyFont:GetFontObject())
        font:SetShadowColor(copyFont:GetShadowColor())
        font:SetShadowOffset(copyFont:GetShadowOffset())
        if justifyH then font:SetJustifyH(justifyH) end
        if alpha then font:SetAlpha(alpha) end
    else
        if e.onlyChinese or size then--THICKOUTLINE
            local fontName2, size2, fontFlag2= font:GetFont()
            fontName2= 'Fonts\\ARHei.ttf'--黑体字
            font:SetFont(fontName2, size or size2, notFlag and fontFlag2 or 'OUTLINE')
        end
        
        font:SetJustifyH(justifyH or 'LEFT')
    end
    if not notShadow then
        font:SetShadowOffset(1, -1)
    end
    if color~=false then
        if color==true then--颜色
            e.Set_Label_Texture_Color(font, {type='FontString'})
        elseif type(color)=='table' then
            font:SetTextColor(color.r, color.g, color.b, color.a or 1)
        else
            font:SetTextColor(1, 0.82, 0, 1)
        end
    end
    if mouse then
        font:EnableMouse(true)
    end
    if wheel then
        font:EnableMouseWheel(true)
    end
    if alpha then
        font:SetAlpha(alpha)
    end
    return font
end

function e.Cbtn(self, tab)--type, icon(atlas, texture), name, size, pushe, button='ItemButton', notWheel, setID, text
    tab=tab or {}
    local template= tab.type==false and 'UIPanelButtonTemplate' or tab.type==true and 'SecureActionButtonTemplate' or tab.type
    --[[ SecureTemplates
    SecureActionButtonTemplate	Button	Perform protected actions.
    SecureUnitButtonTemplate	Button	Unit frames.
    SecureAuraHeaderTemplate	Frame	Managing buffs and debuffs.
    SecureGroupHeaderTemplate	Frame	Managing group members.
    SecurePartyHeaderTemplate	Frame	Managing party members.
    SecureRaidGroupHeaderTemplate	Frame	Managing raid group members.
    SecureGroupPetHeaderTemplate	Frame	Managing group pets.
    SecurePartyPetHeaderTemplate	Frame	Managing party pets.
    SecureRaidPetHeaderTemplate
]]
    local btn= CreateFrame(tab.button or 'Button', tab.name, self or UIParent, template, tab.setID)
    btn:RegisterForClicks(e.LeftButtonDown, e.RightButtonDown)
    if not tab.notWheel then
        btn:EnableMouseWheel(true)
    end
    if tab.size then--大小
        btn:SetSize(tab.size[1], tab.size[2])
    elseif tab.button=='ItemButton' then
        btn:SetSize(34, 34)
    end
    if tab.type~=false then
        if tab.pushe then
            btn:SetHighlightAtlas('bag-border')
            btn:SetPushedAtlas('bag-border-highlight')
        else
            btn:SetHighlightAtlas('Forge-ColorSwatchSelection')
            btn:SetPushedAtlas('UI-HUD-MicroMenu-Highlightalert')
        end
        if tab.icon~='hide' then
            if tab.texture then
                btn:SetNormalTexture(tab.texture)
            elseif tab.atlas then
                btn:SetNormalAtlas(tab.atlas)
            elseif tab.icon==true then
                btn:SetNormalAtlas(e.Icon.icon)
            else
                btn:SetNormalAtlas(e.Icon.disabled)
            end
        end
    end
    if tab.text then
        btn:SetText(tab.text)
    end
    return btn, template
end


function e.Cedit(tab)--frame, name, size={}
    local x, y= tab.size[1], tab.size[2]--310, 135
    local level= tab.frame:GetFrameLevel()

    local scroll= CreateFrame('ScrollFrame', tab.name, tab.frame, 'MacroFrameScrollFrameTemplate')
    scroll:SetSize(tab.size[1], tab.size[2])
    scroll:SetFrameLevel(level+ 1)

    scroll.edit= CreateFrame('EditBox', nil, scroll)
    scroll.edit:SetSize(x, y)
    scroll.edit:SetPoint('RIGHT', scroll, 'LEFT')
    scroll.edit:SetAutoFocus(false)
    scroll.edit:SetMultiLine(true)
    scroll.edit:SetFontObject("ChatFontNormal")

    scroll.background= CreateFrame('Frame', nil, scroll, 'TooltipBackdropTemplate')
    scroll.background:SetSize(x+10, y+10)
    scroll.background:SetPoint('CENTER')
    scroll.background:SetFrameLevel(level)

    scroll:SetScrollChild(scroll.edit)
    return scroll
end

function e.Ccool(self, start, duration, modRate, HideCountdownNumbers, Reverse, SwipeTexture, hideDrawBling)--冷却条
    if not self then
        return
    elseif not duration or duration<=0 then
        if self.cooldown then
            self.cooldown:Clear()
        end
        return
    end
    if not self.cooldown then
        self.cooldown= CreateFrame("Cooldown", nil, self, 'CooldownFrameTemplate')
        self.cooldown:Raise()
        self.cooldown:SetUseCircularEdge(true)--设置边缘纹理是否应该遵循圆形图案而不是方形编辑框
        self.cooldown:SetDrawBling(not hideDrawBling)--闪光
        self.cooldown:SetDrawEdge(true)--冷却动画的移动边缘绘制亮线
        self.cooldown:SetHideCountdownNumbers(HideCountdownNumbers)--隐藏数字
        self.cooldown:SetReverse(Reverse)--控制冷却动画的方向
        self.cooldown:SetEdgeTexture("Interface\\Cooldown\\edge");
        if SwipeTexture then
            self.cooldown:SetSwipeTexture('Interface\\CHARACTERFRAME\\TempPortraitAlphaMask')--圆框架
        end
        self:HookScript('OnHide', function(self2)
            if self2.cooldown then
                self2.cooldown:Clear()
            end
        end)
    end
    start=start or GetTime()
    self.cooldown:SetCooldown(start, duration, modRate)
end

function e.SetItemSpellCool(tab)--{frame=, item=, spell=, type=} type=true圆形，false方形
    if tab.frame then
        if tab.item then
            local startTime, duration = GetItemCooldown(tab.item)
            e.Ccool(tab.frame, startTime, duration, nil, true, nil, not tab.type)
        elseif tab.spell then
            local start, duration, _, modRate = GetSpellCooldown(tab.spell)
            e.Ccool(tab.frame, start, duration, modRate, true, nil, not tab.type)--冷却条
        elseif tab.frame.cooldown then
            tab.frame.cooldown:Clear()
        end
    end
end

function e.GetSpellItemCooldown(spellID, itemID)--法术冷却
    local startTime, duration, enable
    if spellID then
        startTime, duration, enable = GetSpellCooldown(spellID)
    elseif itemID then
        startTime, duration, enable = GetItemCooldown(itemID)
    end
    if duration and duration>0 and enable==1 then
        local t=GetTime()
        if startTime>t then t=t+86400 end
        t=t-startTime
        t=duration-t
        return '|cnRED_FONT_COLOR:'..SecondsToTime(t)..'|r'
    elseif enable==0 then
        return '|cnRED_FONT_COLOR:'..SPELL_RECAST_TIME_INSTANT..'|r'
    end
end
--[[
e.WA_GetUnitAura = function(unit, spell, filter)--AuraEnvironment.lua
  for i = 1, 255 do
    --local name, _, _, _, _, _, _, _, _, spellId = UnitAura(unit, i, filter)
    local spellID = select(10, UnitAura(unit, i, filter))
    if not spellID then
        return
    elseif spell == spellID then
      return UnitAura(unit, i, filter)
    end
  end
end
]]

function e.WA_GetUnitBuff(unit, spell, filter)--HELPFUL HARMFUL
    for i = 1, 40 do
        local spellID = select(10, UnitBuff(unit, i, filter))
        if not spellID then
            return
        elseif spell == spellID then
          return UnitBuff(unit, i, filter)
        end
    end
end

function e.WA_GetUnitDebuff(unit, spell, filter, spellTab)
    spellTab= spellTab or {}
    for i = 1, 40 do
        local spellID = select(10, UnitDebuff(unit, i, filter))
        if not spellID then
            return
        elseif spellTab[spellID] or spell== spellID then
            return UnitDebuff(unit, i, filter)
        end
    end
end

function e.WA_Utf8Sub(input, size, letterSize, lower)
    local output = ""
    if type(input) ~= "string" then
      return output or ''
    end
    local i = 1

    if letterSize and input:find('%w')  then--英文
        size=letterSize
    end

    while (size > 0) do
      local byte = input:byte(i)
      if not byte then
        return output
      end
      if byte < 128 then
        -- ASCII byte
        output = output .. input:sub(i, i)
        size = size - 1
      elseif byte < 192 then
        -- Continuation bytes
        output = output .. input:sub(i, i)
      elseif byte < 244 then
        -- Start bytes
        output = output .. input:sub(i, i)
        size = size - 1
      end
      i = i + 1
    end
    while (true) do
      local byte = input:byte(i)
      if byte and byte >= 128 and byte < 192 then
        output = output .. input:sub(i, i)
      else
        break
      end
      i = i + 1
    end
    return lower and strlower(output) or output
end
--[[
e.HEX=function(r, g, b, a)
    a=a or 1
    r = r <= 1 and r >= 0 and r or 0
    g = g <= 1 and g >= 0 and g or 0
    b = b <= 1 and b >= 0 and b or 0
    a = a <= 1 and a >= 0 and a or 0
    return string.format("%02x%02x%02x%02x",a*255, r*255, g*255, b*255)
end]]

function e.SecondsToClock(seconds, displayZeroHours)--TimeUtil.lua
    if seconds and seconds>=0 then
        local units = ConvertSecondsToUnits(seconds);
        if units.hours > 0 or displayZeroHours then
            return format('%.2d:%.2d:%.2d', units.hours, units.minutes, units.seconds);
        else
            return format('%.2d:%.2d', units.minutes, units.seconds);
        end
    end
end

function e.Chat(text, name, sendChat)
    if text then
        if name then
            SendChatMessage(text, 'WHISPER', nil, name)
        elseif sendChat then
            if not e.call('ChatEdit_InsertLink', text) then
                e.call('ChatFrame_OpenChat', text)
            end
            --[[if ChatEdit_GetActiveWindow() then
                e.call('ChatEdit_InsertLink', text)
            else
                e.call('ChatFrame_OpenChat', text)
            end]]
        else
            local isNotDead= not UnitIsDeadOrGhost('player')
            local isInInstance= IsInInstance()
            if isInInstance and isNotDead then-- and C_CVar.GetCVarBool("chatBubbles") then
                SendChatMessage(text, 'YELL')

            elseif isInInstance and IsInGroup(LE_PARTY_CATEGORY_INSTANCE) then
                SendChatMessage(text, 'INSTANCE_CHAT')

            elseif IsInRaid() then
                SendChatMessage(text, 'RAID')

            elseif IsInGroup() then--and C_CVar.GetCVarBool("chatBubblesParty") then
                SendChatMessage(text, 'PARTY')
                --elseif isNotDead and IsOutdoors() and not UnitAffectingCombat('player') then
                    --SendChatMessage(text, 'YELL')
                -- elseif setPrint then
            else
                print(text)
            end
        end
    end
end

function e.Say(type, name, wow, text)
    local chat= SELECTED_DOCK_FRAME
    local msg = chat.editBox:GetText() or ''
    if text and text==msg then
        text=''
    else
        text= text or ''
    end
    if msg:find('/') then msg='' end
    msg=' '..msg
    if name then
        if wow then
            ChatFrame_SendBNetTell(name..msg..(text or ''))
        else
            ChatFrame_OpenChat("/w " ..name..msg..(text or ''), chat);
        end
    elseif type then
        ChatFrame_OpenChat(type..msg..(text or ''), chat)
    end
end

function e.Reload()
    local bat= UnitAffectingCombat('player') and e.IsEncouter_Start
    if not bat or not IsInInstance() then
        C_UI.Reload()
    else
        print(id, '|cnRED_FONT_COLOR:'..(e.onlyChinese and '战斗中' or HUD_EDIT_MODE_SETTING_ACTION_BAR_VISIBLE_SETTING_IN_COMBAT))
    end
end

function e.Magic(text)
    local tab= {'%.', '%(','%)','%+', '%-', '%*', '%?', '%[', '%^'}
    for _,v in pairs(tab) do
        text= text:gsub(v,'%%'..v)
    end
    tab={
        ['%%%d%$s']= '%(%.%-%)',
        ['%%s']= '%(%.%-%)',
        ['%%%d%$d']= '%(%%d%+%)',
        ['%%d']= '%(%%d%+%)',
    }
    local find
    for k,v in pairs(tab) do
        text= text:gsub(k,v)
        find=true
    end
    if find then
        tab={'%$'}
    else
        tab={'%%','%$'}
    end
    for _, v in pairs(tab) do
        text= text:gsub(v,'%%'..v)
    end
    return text
end
--[[
local LibRangeCheck = LibStub("LibRangeCheck-2.0", true)
function e.GetRange(unit, checkVisible)--WA Prototypes.lua
    return LibRangeCheck:GetRange(unit, checkVisible);
end

function e.CheckRange(unit, range, operator)
    local min, max= LibRangeCheck:GetRange(unit, true);
    if (operator == "<=") then
        return (max or 999) <= range;
    else
        return (min or 0) >= range;
    end
end]]

function e.Set_HelpTips(tab)--e.Set_HelpTips({frame=, topoint=, point='left', size={40,40}, color={r=1,g=0,b=0,a=1}, onlyOne=nil, show=})--设置，提示
    if tab.show and not tab.frame.HelpTips then
        tab.frame.HelpTips= e.Cbtn(tab.frame, {layer='OVERLAY',size=tab.size and {tab.size[1], tab.size[2]} or {40,40}})-- button:CreateTexture(nil, 'OVERLAY')
        if tab.point=='right' then
            tab.frame.HelpTips:SetPoint('BOTTOMLEFT', tab.topoint or tab.frame, 'BOTTOMRIGHT',0,-10)
            tab.frame.HelpTips:SetNormalAtlas(tab.atlas or e.Icon.toLeft)
        else--left
            tab.frame.HelpTips:SetPoint('BOTTOMRIGHT', tab.topoint or tab.frame, 'BOTTOMLEFT',0,-10)
            tab.frame.HelpTips:SetNormalAtlas(tab.atlas or e.Icon.toRight)
        end
        if tab.color then
            SetItemButtonNormalTextureVertexColor(tab.frame.HelpTips, tab.color.r, tab.color.g, tab.color.b, tab.color.a or 1);
        end
        tab.frame.HelpTips:SetScript('OnUpdate', function(self, elapsed)
            self.elapsed= (self.elapsed or 0.5) + elapsed
            if self.elapsed>0.5 then
                self.elapsed=0
                self:SetScale(self:GetScale()==1 and 0.5 or 1)
            end
        end)
        tab.frame.HelpTips:SetScript('OnEnter', function(self) self:SetShown(false) end)
        if tab.onlyOne then
            tab.frame.HelpTips.onlyOne=true
        end
    end
    if tab.frame.HelpTips and not tab.frame.HelpTips.onlyOne then
        tab.frame.HelpTips:SetShown(tab.show)
    end
end

function e.Get_CVar_Tooltips(info)--取得CVar信息 e.Get_CVar_Tooltips({name= ,msg=, value=})
    return (info.msg and info.msg..'|n' or '')..info.name..'|n'
    ..(info.value and C_CVar.GetCVar(info.name)== info.value and e.Icon.select2 or '')
    ..(info.value and (e.onlyChinese and '设置' or SETTINGS)..info.value..' ' or '')
    ..'('..(e.onlyChinese and '当前' or REFORGE_CURRENT)..'|cnGREEN_FONT_COLOR:'..C_CVar.GetCVar(info.name)..'|r |r'
    ..(e.onlyChinese and '默认' or DEFAULT)..'|cffff00ff'..C_CVar.GetCVarDefault(info.name)..')|r'
end

function e.set_CVar(name, value)-- e.set_CVar()--设置 Cvar
    if value~= nil then
        C_CVar.SetCVar(name, value and '1' or '0')
    end
end

function e.SetButtonKey(self, set, key, click)--设置清除快捷键
    if set then
        SetOverrideBindingClick(self, true, key, self:GetName(), click or 'LeftButton')
    else
        ClearOverrideBindings(self)
    end
end















function e.Get_Week_Rewards_Text(type)--得到，周奖励，信息
    local text
    for _, activities in pairs(C_WeeklyRewards.GetActivities(type) or {}) do--本周完成 Enum.WeeklyRewardChestThresholdType.MythicPlus 1
        if activities.level and activities.level>=0 and activities.type==type then--and activities.threshold and activities.threshold>0 and activities.type==1 then
            text= (text and text..'/' or '')..activities.level
        end
    end
    return text~='0/0/0' and text or nil
end



--周奖励，提示
function e.Get_Weekly_Rewards_Activities(settings)--{frame=Frame, point={'TOPLEFT', nil, 'BOTTOMLEFT', 0, -2}, anchor='ANCHOR_RIGHT'}
    local R = {}
    for  _ , info in pairs( C_WeeklyRewards.GetActivities() or {}) do
        if info.type and info.type>= 1 and info.type<= 3 and info.level then
            local head
            local difficultyText
            if info.type == 1 then--1 Enum.WeeklyRewardChestThresholdType.MythicPlus
                head= e.onlyChinese and '史诗地下城' or MYTHIC_DUNGEONS
                difficultyText= string.format(e.onlyChinese and '史诗 %d' or WEEKLY_REWARDS_MYTHIC, info.level)

            elseif info.type == 2 then--2 Enum.WeeklyRewardChestThresholdType.RankedPvP
                head= e.onlyChinese and 'PvP' or PVP
                if e.onlyChinese then
                    local tab={
                        [0]= "休闲者",
                        [1]= "争斗者 I",
                        [2]= "挑战者 I",
                        [3]= "竞争者 I",
                        [4]= "决斗者",
                        [5]= "精锐",
                        [6]= "争斗者 II",
                        [7]= "挑战者 II",
                        [8]= "竞争者 II",
                    }
                    difficultyText=tab[info.level]
                end
                difficultyText=  difficultyText or PVPUtil.GetTierName(info.level)-- _G["PVP_RANK_"..tierEnum.."_NAME"] PVPUtil.lua

            elseif info.type == 3 then--3 Enum.WeeklyRewardChestThresholdType.Raid
                head= e.onlyChinese and '团队副本' or RAIDS
                difficultyText=  DifficultyUtil.GetDifficultyName(info.level)
            end
            if head then
                R[head]= R[head] or {}
                R[head][info.index] = {
                    level = info.level,
                    difficulty = difficultyText or (e.onlyChinese and '休闲者' or PVP_RANK_0_NAME),
                    progress = info.progress,
                    threshold = info.threshold,
                    unlocked = info.progress>=info.threshold,
                    id= info.id,
                    type= info.type,
                    itemDBID= info.rewards and info.rewards.itemDBID or nil,
                }
            end
        end
    end

    local last
    settings.frame.WeekRewards= settings.frame.WeekRewards or {}
    for head, tab in pairs(R) do
        local label= settings.frame.WeekRewards['rewardChestHead'..head]
        if not label then
            label= e.Cstr(settings.frame)
            if last then
                label:SetPoint('TOPLEFT', last, 'BOTTOMLEFT',0,-4)
            elseif settings.point then
                label:SetPoint(settings.point[1], settings.point[2] or settings.frame, settings.point[3], settings.point[4], settings.point[5])
            end
            settings.frame.WeekRewards['rewardChestHead'..head]= label
        end
        label:SetText(e.Icon.toRight2..head)
        last= label

        for index, info in pairs(tab) do
            label= settings.frame.WeekRewards['rewardChestSub'..head..index]
            if not label then
                label= e.Cstr(settings.frame, {mouse= true})
                label:SetPoint('TOPLEFT', last, 'BOTTOMLEFT')
                label:SetScript('OnLeave', function(self2) e.tips:Hide() self2:SetAlpha(1) end)
                label:SetScript('OnEnter', function(self2)
                    e.tips:SetOwner(self2,  self2.anchor or "ANCHOR_LEFT")
                    e.tips:ClearLines()
                    local link= self2:Get_ItemLink()
                    if link then
                        e.tips:SetHyperlink(link)
                    else
                        e.tips:AddDoubleLine(format(e.onlyChinese and '仅限%s' or LFG_LIST_CROSS_FACTION,e.onlyChinese and '物品等级' or STAT_AVERAGE_ITEM_LEVEL ),e.onlyChinese and '无' or NONE)
                        e.tips:AddLine(' ')
                        e.tips:AddDoubleLine('Activities Type '..self2.type, 'id '..self2.id)
                    end
                    e.tips:Show()
                    self2:SetAlpha(0.5)
                end)
                function label:Get_ItemLink()
                    local link
                    if self.itemDBID then
                        link= C_WeeklyRewards.GetItemHyperlink(self.itemDBID)
                    elseif self.id then
                        link= C_WeeklyRewards.GetExampleRewardItemHyperlinks(self.id)
                    end
                    if link and link~='' then
                        e.LoadDate({id=link, type='item'})
                        return link
                    end
                end
                settings.frame.WeekRewards['rewardChestSub'..head..index]= label
            end
            label.id= info.id
            label.type= info.type
            label.itemDBID= info.itemDBID
            label.anchor= settings.anchor
            last= label

            local text
            local itemLink= label:Get_ItemLink()
            if itemLink then
                local texture= C_Item.GetItemIconByID(itemLink)
                local itemLevel= GetDetailedItemLevelInfo(itemLink)
                text= '    '..index..') '..(texture and '|T'..texture..':0|t' or itemLink)
                text= text..((itemLevel and itemLevel>0) and itemLevel or '')..e.Icon.select2..(info.level or '')
            else
                if info.unlocked then
                    text='   '..index..') '..info.difficulty..e.Icon.select2..(info.level or '')--.. ' '..(e.onlyChinese and '完成' or COMPLETE)
                else
                    text='    |cff828282'..index..') '
                        ..info.difficulty
                        .. ' '..(info.progress>0 and '|cnGREEN_FONT_COLOR:'..info.progress..'|r' or info.progress)
                        .."/"..info.threshold..'|r'
                end
            end
            label:SetText(text or '')
        end
    end
    return last
end







--物品升级界面，挑战界面，物品，货币提示
function e.ItemCurrencyLabel(settings)--settings={frame, point={}, showName=true, showAll=true}
    if not settings.frame then return end
    local itemS= {--数量提示
    --{type='item', id=204196},--魔龙的暗影烈焰纹章10.1
    --{type='item', id=204195},--幼龙的暗影烈焰纹章
    --{type='item', id=204194},--守护巨龙的暗影烈焰纹章
    --{type='item', id=204193},--雏龙的暗影烈焰纹章

    {type='currency', id=2709},--守护巨龙的酣梦纹章 10.1.5
    {type='currency', id=2708},--魔龙的酣梦纹章
    {type='currency', id=2707},--幼龙的酣梦纹章
    {type='currency', id=2706},--雏龙的酣梦纹章
    {type='currency', id=2245},--飞珑石
    {type='currency', id=2796, show=true},--苏生奇梦 10.2
    --{type='currency', id=2533},--苏生暗影烈焰10.10
    {type='currency', id=1602, line=true},--征服点数
    {type='currency', id=1191},--勇气点数
}

    settings.frame.tipsLabels= settings.frame.tipsLabels or {}

    local index=0
    local last
    for _, tab in pairs(itemS) do
        local text=''
        if tab.type=='currency' then
            local info=C_CurrencyInfo.GetCurrencyInfo(tab.id)
            if info and info.quantity and info.maxQuantity
                and (tab.show or (info.discovered and info.quantity>0))
            then
                if info.maxQuantity>0  then
                    if info.quantity==info.maxQuantity then
                        text=text..'|cnRED_FONT_COLOR:'..info.quantity.. '/'..info.maxQuantity..'|r '
                    else
                        text=text..info.quantity.. '/'..info.maxQuantity..' '
                    end
                    if info.useTotalEarnedForMaxQty then--本周还可获取                        
                        local q
                        q= info.maxQuantity - info.totalEarned
                        if q>0 then
                            q='|cnGREEN_FONT_COLOR:+'..q..'|r'
                        else
                            q='|cnGREEN_FONT_COLOR:+0|r'
                        end
                        text=text..' ('..q..') '
                    end
                else
                    if info.maxQuantity==0 then
                        text=text..info.quantity..'/'.. (e.onlyChinese and '无限制' or UNLIMITED)..' '
                    else
                        if info.quantity==info.maxQuantity then
                            text=text..'|cnRED_FONT_COLOR:'..info.quantity.. '/'..info.maxQuantity..'|r '
                        else
                            text=text..info.quantity..'/'..info.maxQuantity..' '
                        end
                    end
                end
                text= (info.iconFileID and '|T'..info.iconFileID..':0|t' or '')
                    ..((settings.showName and info.name) and info.name..' ' or '')
                    ..text
            end
        elseif tab.type=='item' then
            e.LoadDate({id=tab.id, type='item'})
            local num= GetItemCount(tab.id, true)
            local itemQuality= C_Item.GetItemQualityByID(tab.id)
            if (tab.show or num>0) and itemQuality>=1 then
                e.LoadDate({id=tab.id, type='item'})
                local icon= C_Item.GetItemIconByID(tab.id)
                local name=settings.showName and C_Item.GetItemNameByID(tab.id)
                text= ((icon and icon>0) and '|T'..icon..':0|t' or id '')
                    ..(name and name..' |cnGREEN_FONT_COLOR:x|r' or '')
                    ..num
            end
        end
        if text~='' then
            index= index +1
            local lable= settings.frame.tipsLabels[index]
            if not lable then
                lable=e.Cstr(settings.frame, {mouse=true})
                if last then
                    lable:SetPoint('TOPLEFT', last, 'BOTTOMLEFT',0, tab.line and -6 or -2)
                elseif settings.point then
                    lable:SetPoint(settings.point[1], settings.point[2] or settings.frame, settings.point[3], settings.point[4], settings.point[5])
                end
                lable:SetScript("OnEnter",function(self)
                    e.tips:SetOwner(self, "ANCHOR_RIGHT")
                    e.tips:ClearLines()
                    if self.type=='currency' then
                        e.tips:SetCurrencyByID(self.id)
                    elseif self.type=='item' then
                        e.tips:SetItemByID(self.id)
                    end
                    e.tips:Show()
                    self:SetAlpha(0.5)
                end)
                lable:SetScript("OnLeave",function(self)
                    e.tips:Hide()
                    self:SetAlpha(1)
                end)
                settings.frame.tipsLabels[index]= lable
                last= lable
            end
            lable.id= tab.id
            lable.type= tab.type
            lable:SetText(text)
        end
    end

    for i= index+1, #settings.frame.tipsLabels do
        local lable= settings.frame.tipsLabels[i]
        if lable then
            lable:SetText("")
        end
    end
end



--显示, 宝石, 属性
local AndStr = COVENANT_RENOWN_TOAST_REWARD_COMBINER:format('(.-)','(.+)')--"%s 和 %s";
function e.Get_Gem_Stats(tab, itemLink, self)
    local dateInfo= e.GetTooltipData({bag=tab.bag, merchant=tab.merchant, guidBank=tab.guidBank, hyperLink=itemLink, text={'(%+%d+ .+)', }})--物品提示，信息
    local text= dateInfo.text['(%+%d+ .+)']
    local leftText, bottomLeftText
    if text and text:find('%+') then
        local str2, str3
        if text:find(', ') then
            str2, str3= text:match('(.-), (.+)')
        elseif text:find('，') then
            str2, str3= text:match('(.-)，(.+)')
        else
            str2, str3= text:match(AndStr)
        end
        str2= str2 or text:match('%+%d+ .+')
        if str2 then
            str2= str2:match('%+%d+ (.+)')
            leftText= e.WA_Utf8Sub(str2,1,3, true)
            leftText= leftText and '|cffffffff'..leftText..'|r'
            if str3 then
                str3= str3:match('%+%d+ (.+)')
                bottomLeftText= e.WA_Utf8Sub(str3,1,3, true)
                bottomLeftText= bottomLeftText and '|cffffffff'..bottomLeftText..'|r'
            end
        end
    end
    if self then
        if leftText and not self.leftText then
            self.leftText= e.Cstr(self, {size=10})
            self.leftText:SetPoint('LEFT')
        end
        if self.leftText then
            self.leftText:SetText(leftText or '')
        end
        if bottomLeftText and not self.bottomLeftText then
            self.bottomLeftText= e.Cstr(self, {size=10})
            self.bottomLeftText:SetPoint('BOTTOMLEFT')
        end
        if self.bottomLeftText then
            self.bottomLeftText:SetText(bottomLeftText or '')
        end
    end
    return leftText, bottomLeftText
end





function e.Get_Item_Stats(link)--物品，次属性，表
    if not link then
        return {}
    end
    local num, tab= 0, {}
    local info= GetItemStats(link) or {}
    if info['ITEM_MOD_CRIT_RATING_SHORT'] then
        table.insert(tab, {text=e.onlyChinese and '爆' or e.WA_Utf8Sub(STAT_CRITICAL_STRIKE, 1, 2, true), value=info['ITEM_MOD_CRIT_RATING_SHORT'] or 1, index=1})
        num= num +1
    end
    if info['ITEM_MOD_HASTE_RATING_SHORT'] then
        table.insert(tab, {text=e.onlyChinese and '急' or e.WA_Utf8Sub(STAT_HASTE, 1, 2, true), value=info['ITEM_MOD_HASTE_RATING_SHORT'] or 1, index=1})
        num= num +1
    end
    if info['ITEM_MOD_MASTERY_RATING_SHORT'] then
        table.insert(tab, {text=e.onlyChinese and '精' or e.WA_Utf8Sub(STAT_MASTERY, 1, 2, true), value=info['ITEM_MOD_MASTERY_RATING_SHORT'] or 1, index=1})
        num= num +1
    end
    if info['ITEM_MOD_VERSATILITY'] then
        table.insert(tab, {text=e.onlyChinese and '全' or e.WA_Utf8Sub(STAT_VERSATILITY, 1, 2, true), value=info['ITEM_MOD_VERSATILITY'] or 1, index=1})
        num= num +1
    end
    if num<4 and info['ITEM_MOD_CR_AVOIDANCE_SHORT'] then
        table.insert(tab, {text=e.onlyChinese and '闪' or e.WA_Utf8Sub(ITEM_MOD_CR_AVOIDANCE_SHORT, 1, 2, true), value=info['ITEM_MOD_CR_AVOIDANCE_SHORT'], index=2})
        num= num +1
    end
    if num<4 and info['ITEM_MOD_CR_LIFESTEAL_SHORT'] then
        table.insert(tab, {text=e.onlyChinese and '吸' or e.WA_Utf8Sub(ITEM_MOD_CR_LIFESTEAL_SHORT, 1, 2, true), value=info['ITEM_MOD_CR_LIFESTEAL_SHORT'] or 1, index=2})
        num= num +1
    end
    --[[if num<4 and info['ITEM_MOD_CR_AVOIDANCE_SHORT'] then
        table.insert(tab, {text=e.onlyChinese and '溅' or e.WA_Utf8Sub(ITEM_MOD_CR_MULTISTRIKE_SHORT, 1,2,true), value=info['ITEM_MOD_CR_MULTISTRIKE_SHORT'] or 1, index=2})
        num= num +1
    end]]
    if num<4 and info['ITEM_MOD_CR_SPEED_SHORT'] then
        table.insert(tab, {text=e.onlyChinese and '速' or e.WA_Utf8Sub(ITEM_MOD_CR_SPEED_SHORT, 1,2,true), value=info['ITEM_MOD_CR_SPEED_SHORT'] or 1, index=2})
        num= num +1
    end
    return tab
end

--e.Set_Item_Stats(self, itemLink, {point=self.icon, itemID=nil, hideSet=false, hideLevel=false, hideStats=false})--设置，物品，4个次属性，套装，装等，
function e.Set_Item_Stats(self, link, setting) --setting= setting or {}
    if not self then
        return
    end
    local setID, itemLevel

    if link then
        if not setting.hideSet then
            setID= select(16 , GetItemInfo(link))--套装
            if setID and not self.itemSet then
                self.itemSet= self:CreateTexture()
                self.itemSet:SetAtlas('UI-HUD-MicroMenu-Highlightalert')--services-icon-goldborder
                self.itemSet:SetVertexColor(0, 1, 0, 0.8)
                self.itemSet:SetAllPoints(setting.point or self)
            end
        end

        if not setting.hideLevel then--物品, 装等
            local quality = C_Item.GetItemQualityByID(link)--颜色
            if quality==7 then
                local itemLevelStr=ITEM_LEVEL:gsub('%%d', '%(%%d%+%)')--"物品等级：%d"
                local dataInfo= e.GetTooltipData({hyperLink=link, itemID= setting.itemID or GetItemInfoInstant(link), text={itemLevelStr}, onlyText=true})--物品提示，信息
                itemLevel= tonumber(dataInfo.text[itemLevelStr])
            end
            itemLevel= itemLevel or GetDetailedItemLevelInfo(link)
            if itemLevel and itemLevel<3 then
                itemLevel=nil
            end
            local avgItemLevel= itemLevel and select(2, GetAverageItemLevel())--已装备, 装等
            if itemLevel and avgItemLevel then
                local lv = itemLevel- avgItemLevel
                --if lv>=7 then
                  --  itemLevel= GREEN_FONT_COLOR_CODE..itemLevel..'|r'
                --elseif quality and quality<= 6 then
                    if lv <= -6  then
                        itemLevel =RED_FONT_COLOR_CODE..itemLevel..'|r'
                    elseif lv>=7 then
                        itemLevel= GREEN_FONT_COLOR_CODE..itemLevel..'|r'
                    else
                        itemLevel='|cffffffff'..itemLevel..'|r'
                        --[[local hexColor= quality and select(4, GetItemQualityColor(quality))
                        if hexColor then
                            itemLevel='|c'..hexColor..itemLevel..'|r'
                        end]]
                    end
                --end
            end
            if not self.itemLevel and itemLevel then
                self.itemLevel= e.Cstr(self, {justifyH='CENTER'})--nil, nil, nil,nil,nil, 'CENTER')
                self.itemLevel:SetShadowOffset(2,-2)
                self.itemLevel:SetPoint('CENTER', setting.point)
            end
        end
    end
    if self.itemSet then self.itemSet:SetShown(setID) end--套装
    if self.itemLevel then self.itemLevel:SetText(itemLevel or '') end--装等

    local tab= not setting.hideStats and e.Get_Item_Stats(link) or {}--物品，次属性，表
    table.sort(tab, function(a,b) return a.value>b.value and a.index== b.index end)
    for index=1 ,4 do
        local text=self['statText'..index]
        if tab[index] then
            if not text then
                text= e.Cstr(self, {justifyH= (index==2 or index==4) and 'RIGHT'})
                if index==1 then
                    text:SetPoint('BOTTOMLEFT', setting.point or self, 'BOTTOMLEFT')
                elseif index==2 then
                    text:SetPoint('BOTTOMRIGHT', setting.point or self, 'BOTTOMRIGHT', 4,0)
                elseif index==3 then
                    text:SetPoint('TOPLEFT', setting.point or self, 'TOPLEFT')
                else
                    text:SetPoint('TOPRIGHT', setting.point or self, 'TOPRIGHT',4,0)
                end
                self['statText'..index]=text
            end
            text:SetText(tab[index].text)
        elseif text then
            text:SetText('')
        end
    end
end



























local function GetPlayerNameRemoveRealm(name, realm)--玩家名称, 去服务器为*
    if not name then
        return
    end
    local reName= name:match('(.+)%-') or name
    local reRealm= name:match('%-(.+)') or realm
    if not reName or reRealm=='' or reRealm==e.Player.realm then
        return reName
    elseif e.Player.Realms[reRealm] then
        return reName..'|cnGREEN_FONT_COLOR:*|r'
    elseif reRealm then
        return reName..'*'
    end
    return reName
end

function e.GetUnitName(name, unit, guid)--取得全名
    if name and name:gsub(' ','')~='' then
        if not name:find('%-') then
            name= name..'-'..e.Player.realm
        end
        return name
    elseif guid then
        local name2, realm = select(6, GetPlayerInfoByGUID(guid))
        if name2 then
            if not realm or realm=='' then
                realm= e.Player.realm
            end
            return name2..'-'..realm
        end
    elseif unit then
        local name2, realm= UnitName(unit)
        if name2 then
            if not realm or realm=='' then
                realm= e.Player.realm
            end
            return name2..'-'..realm
        end
    end
end

function e.GetUnitRaceInfo(tab)--e.GetUnitRaceInfo({unit=nil, guid=nil, race=nil, sex=nil, reAtlas=false})--玩家种族图标
    local race =tab.race or tab.unit and select(2,UnitRace(tab.unit))
    local sex= tab.sex
    if not (race or sex) and tab.guid then
        race, sex = select(4, GetPlayerInfoByGUID(tab.guid))
    end
    sex=sex or tab.unit and UnitSex(tab.unit)
    sex= sex==2 and 'male' or sex==3 and 'female'
    if sex and race then
        if race=='Scourge' then
            race='Undead'
        elseif race=='HighmountainTauren' then
            race='highmountain'
        elseif race=='ZandalariTroll' then
            race='zandalari'
        elseif race=='LightforgedDraenei' then
            race='lightforged'
        elseif race=='Dracthyr' then
            race='dracthyrvisage'
        end
        if tab.reAtlas then
            return 'raceicon128-'..race..'-'..sex
        else
            return '|A:raceicon128-'..race..'-'..sex..':0:0|a'
        end
    end
end
e.Icon.player= e.GetUnitRaceInfo({unit='player', guid=nil , race=nil , sex=nil , reAtlas=false})



function e.Class(unit, class, reAltlas)--职业图标 groupfinder-icon-emptyslot'
    class= unit and select(2, UnitClass(unit)) or class
    if class then
        if class=='EVOKER' then
            class='classicon-evoker'
        else
            class= 'groupfinder-icon-class-'..class
        end
        if reAltlas then
            return class
        else
            return '|A:'..class ..':0:0|a'
        end
    end
end

function e.GetGUID(unit, name)--从名字,名unit, 获取GUID
    if unit then
        return UnitGUID(unit)

    elseif name then
        local info=C_FriendList.GetFriendInfo(name:gsub('%-'..e.Player.realm, ''))--好友
        if info then
            return info.guid
        end

        name= e.GetUnitName(name)
        if e.GroupGuid[name] then--队友
            return e.GroupGuid[name].guid

        elseif e.WoWGUID[name] then--战网
            return e.WoWGUID[name].guid

        elseif name==e.Player.name then
            return e.Player.guid

        elseif UnitIsPlayer('target') and e.GetUnitName(nil, 'target')==name then--目标
            return UnitGUID('target')
        end
    end
end

function e.GetFriend(name, guid, unit)--检测, 是否好友
    if guid or unit then
        guid= guid or e.GetGUID(unit, name)
        if guid and guid~=e.Player.guid then
            if C_BattleNet.GetGameAccountInfoByGUID(guid) then--C_BattleNet.GetAccountInfoByGUID(guid)
                return e.Icon.net2
            elseif C_FriendList.IsFriend(guid) then
                return '|A:groupfinder-icon-friend:0:0|a'--好友
            elseif IsGuildMember(guid) then
                return '|A:UI-HUD-MicroMenu-GuildCommunities-Mouseover:0:0|a'--公会
            end
        end
    elseif name then
        if C_FriendList.GetFriendInfo(name:gsub('%-'..e.Player.realm, ''))  then
            return '|A:groupfinder-icon-friend:0:0|a'--好友
        end
        if e.WoWGUID[e.GetUnitName(name)] then
            return e.Icon.net2
        end
    end
end

function e.GetUnitFaction(unit, faction, all)--检查, 是否同一阵营
    if not faction and unit then
        faction= UnitFactionGroup(unit)
    end
    if faction and (faction~= e.Player.faction or all) then
        return faction=='Horde' and e.Icon.horde2 or faction=='Alliance' and e.Icon.alliance2 or '|A:nameplates-icon-flag-neutral:0:0|a'
    end
end


function e.PlayerLink(name, guid, onlyLink) --玩家超链接
    guid= guid or e.GetGUID(nil, name)
    if guid==e.Player.guid then--自已
        return (not onlyLink and e.Icon.player)..'|Hplayer:'..e.Player.name_realm..'|h['..e.Player.col..COMBATLOG_FILTER_STRING_ME..'|r'..']|h'
    end
    if guid then
        local _, class, _, race, sex, name2, realm = GetPlayerInfoByGUID(guid)
        if name2 then
            local showName= GetPlayerNameRemoveRealm(name2, realm)
            if class then
                showName= '|c'..select(4,GetClassColor(class))..showName..'|r'
            end
            return (not onlyLink and e.GetUnitRaceInfo({unit=nil, guid=guid , race=race , sex=sex , reAtlas=false}) or '')..'|Hplayer:'..name2..((realm and realm~='') and '-'..realm or '')..'|h['..showName..']|h'
        end
    elseif name then
        return '|Hplayer:'..name..'|h['..GetPlayerNameRemoveRealm(name)..']|h'
    end
    return ''
end

function e.GetPlayerInfo(tab)--e.GetPlayerInfo({unit=nil, guid=nil, name=nil, faction=nil, reName=true, reLink=false, reRealm=false, reNotRegion=false})
    local guid= tab.guid or e.GetGUID(tab.unit, tab.name)
    if guid==e.Player.guid then
        return e.Icon.player..((tab.reName or tab.reLink) and e.Player.col..(e.onlyChinese and '我' or COMBATLOG_FILTER_STRING_ME)..'|r' or '')..e.Icon.star2
    elseif tab.reLink then
        return e.PlayerLink(tab.name, guid, true) --玩家超链接
    elseif guid and C_PlayerInfo.GUIDIsPlayer(guid) then
        local _, englishClass, _, englishRace, sex, name, realm = GetPlayerInfoByGUID(guid)
        local unit= tab.unit
        if guid and (not tab.faction or unit) then
            if e.GroupGuid[guid] then
                unit = unit or e.GroupGuid[guid].unit
                tab.faction= tab.faction or e.GroupGuid[guid].faction
            end
        end

        local friend= e.GetFriend(nil, guid, nil)--检测, 是否好友
        local groupInfo= e.GroupGuid[guid] or {}--队伍成员
        local server= not tab.reNotRegion and e.Get_Region(realm)--服务器，EU， US {col=, text=, realm=}

        local text= (server and server.col or '')
                    ..(friend or '')
                    ..(e.GetUnitFaction(unit, tab.faction) or '')--检查, 是否同一阵营
                    ..(e.GetUnitRaceInfo({unit=unit, guid=guid , race=englishRace, sex=sex, reAtlas=false}) or '')
                    ..(e.Class(unit, englishClass) or '')

        if groupInfo.combatRole=='HEALER' or groupInfo.combatRole=='TANK' then--职业图标
            text= text..e.Icon[groupInfo.combatRole]..(groupInfo.subgroup or '')
        end
        if tab.reName and name then
            if tab.reRealm then
                if not realm or realm=='' or realm==e.Player.realm then
                    text= text..name
                else
                    text= text..name..'-'..realm
                end
            else
                text= text..GetPlayerNameRemoveRealm(name, realm)
            end
            text= '|c'..select(4,GetClassColor(englishClass))..text..'|r'
        end
        return text

    elseif tab.name then
        if tab.reLink then
            return e.PlayerLink(tab.name, nil, true) --玩家超链接

        elseif tab.reName then
            local name=tab.name
            if not tab.reRealm then
                name= GetPlayerNameRemoveRealm(name)
            end
            return name
        end
    end

    return ''
end


function e.PlayerOnlineInfo(unit)--单位，状态信息
    if unit and UnitExists(unit) then
        if not UnitIsConnected(unit) then
            return format("\124T%s.tga:0\124t", FRIENDS_TEXTURE_DND), e.onlyChinese and '离线' or PLAYER_OFFLINE
        elseif UnitIsAFK(unit) then
            return format("\124T%s.tga:0\124t", FRIENDS_TEXTURE_AFK), e.onlyChinese and '离开' or AFK
        elseif UnitIsGhost(unit) then
            return '|A:poi-soulspiritghost:0:0|a', e.onlyChinese and '幽灵' or DEAD
        elseif UnitIsDead(unit) then
            return '|A:deathrecap-icon-tombstone:0:0|a', e.onlyChinese and '死亡' or DEAD
        end
    end
end

function e.GetNpcID(unit)--NPC ID
    if UnitExists(unit) then
        local guid=UnitGUID(unit)
        if guid then
            return select(6,  strsplit("-", guid));
        end
    end
end

function e.GetUnitMapName(unit)--单位, 地图名称
    local text
    local uiMapID= C_Map.GetBestMapForUnit(unit)
    if unit=='player' and IsInInstance() then
        local name, _, _, difficultyName= GetInstanceInfo()
        if name then
            text= name .. ((difficultyName and difficultyName~='') and '('..difficultyName..')' or '')
        else
            text=GetMinimapZoneText()
        end
    elseif uiMapID then
        local info = C_Map.GetMapInfo(uiMapID)
        if info and info.name then
            text=info.name
        end
    end
    return text, uiMapID
end








































--[[
[Enum.StatusBarColorTintValue.Black] = BLACK_FONT_COLOR,
[Enum.StatusBarColorTintValue.White] = WHITE_FONT_COLOR,
[Enum.StatusBarColorTintValue.Red] = RED_FONT_COLOR,
[Enum.StatusBarColorTintValue.Yellow] = YELLOW_FONT_COLOR,
[Enum.StatusBarColorTintValue.Orange] = ORANGE_FONT_COLOR,
[Enum.StatusBarColorTintValue.Purple] = EPIC_PURPLE_COLOR,
[Enum.StatusBarColorTintValue.Green] = GREEN_FONT_COLOR,
[Enum.StatusBarColorTintValue.Blue] = RARE_BLUE_COLOR,
]]
function e.GetQestColor(text, questID)
    local color={
        Day={r=0.10, g=0.72, b=1, hex='|cff1ab8ff'},--日常
        Week={r=0.02, g=1, b=0.66, hex='|cff05ffa8'},--周长
        Legendary={r=1, g=0.49, b=0, hex='|cffff7d00'},--传说, 战役
        Calling={r=1, g=0, b=0.9, hex='|cffff00e6'},--使命

        Trivial={r=0.53, g=0.53, b=0.53, hex='|cff878787'},--0 难度 Difficulty
        Easy={r=0.63, g=1, b=0.61, hex='|cffa1ff9c'},--1
        Difficult={r=1, g=0.43, b=0.42, hex='|cffff6e6b'},--3
        Impossible={r=1, g=0, b=0.08, hex='|cffff0014'},--4

        Story={r=0.09, g=0.78, b=0.39, a=1.00, hex='|cff17c864'},
        Complete={r=0.10, g=1.00, b=0.10, a=1.00, hex='|cff19ff19'},
        Failed={r=1.00, g=0.00, b=0.00, a=1.00, hex='|cffff0000'},
        Horde={r=1.00, g=0.38, b=0.38, a=1.00, hex='|cffff6161'},
        Alliance={r=0.00, g=0.68, b=0.94, a=1.00, hex='|cff00adf0'},
        WoW={r=0.00, g=0.80, b=1.00, a=1.00, hex='|cff00ccff'},
        PvP={r=0.80, g=0.30, b=0.22, a=1.00, hex='|cffcc4d38'},
    }
    if text then
        return color[text]
    elseif questID and UnitEffectiveLevel('player')== e.Player.level then
        local difficulty= C_PlayerInfo.GetContentDifficultyQuestForPlayer(questID)
        if difficulty then
            if difficulty== 0 then--Trivial    
                return color.Trivial
            elseif difficulty== 1 then--Easy
                return color.Easy
            elseif difficulty==3 then--Difficult    
                return color.Difficult
            elseif difficulty==4 then--Impossible    
                return color.Impossible
            end
        end
    end
end

--任务图标，颜色
function e.QuestLogQuests_GetBestTagID(questID, info, tagInfo, isComplete)--QuestMapFrame.lua QuestUtils.lua
    questID= questID or (info and info.questID)

    if not info and questID then
       local questLogIndex= C_QuestLog.GetLogIndexForQuestID(questID)
       info = questLogIndex and C_QuestLog.GetInfo(questLogIndex)
    end

    tagInfo =  tagInfo or C_QuestLog.GetQuestTagInfo(questID) or {};
    if not questID or not info then
        return
    end

    if isComplete==nil then
        isComplete= C_QuestLog.IsComplete(questID)
    end

    local tagID, color, atlas
    if isComplete then
        if tagInfo.tagID == Enum.QuestTag.Legendary then
            tagID, color, atlas= "COMPLETED_LEGENDARY", e.GetQestColor('Complete'), nil
        else
            tagID, color, atlas=  nil, e.GetQestColor('Complete'), e.Icon.select2--"COMPLETED", e.GetQestColor('Complete')
        end
    elseif C_QuestLog.IsFailed(questID) then
        tagID, color, atlas= "FAILED", e.GetQestColor('Failed'), nil

    elseif tagInfo.tagID==267 or tagInfo.tagName==TRADE_SKILLS then--专业
        tagID, color, atlas= nil, e.GetQestColor('Week'), '|A:Professions-Icon-Quality-Mixed-Small:0:0|a'

    elseif info.isCalling then
        local secondsRemaining = C_TaskQuest.GetQuestTimeLeftSeconds(questID);
        if secondsRemaining then
            if secondsRemaining < 3600 then -- 1 hour
                tagID, color, atlas= "EXPIRING_SOON", e.GetQestColor('Calling'), nil
            elseif secondsRemaining < 18000 then -- 5 hours
                tagID, color, atlas= "EXPIRING", e.GetQestColor('Calling'), nil
            end
        end

    elseif tagInfo.tagID == Enum.QuestTag.Account then
        local factionGroup = GetQuestFactionGroup(questID);
        if factionGroup==LE_QUEST_FACTION_HORDE then--部落
            tagID, color, atlas= 'HORDE', e.GetQestColor('Horde'), nil
        elseif factionGroup==LE_QUEST_FACTION_ALLIANCE then
            tagID, color, atlas= "ALLIANCE", e.GetQestColor('Alliance'), nil--联盟
        else
            tagID, color, atlas= Enum.QuestTag.Account,e.GetQestColor('WoW'), nil--帐户
        end

    elseif info.frequency == Enum.QuestFrequency.Daily then--日常
        tagID, color, atlas= "DAILY", e.GetQestColor('Day'), nil

    elseif info.frequency == Enum.QuestFrequency.Weekly then--周常
        tagID, color, atlas= "WEEKLY", e.GetQestColor('Week'), nil

    else
        tagID, color, atlas= tagInfo.tagID, nil, nil
    end
    if not atlas and tagID then
        local tagAtlas = QuestUtils_GetQuestTagAtlas(tagID)
        if tagAtlas then
            atlas= '|A:'..tagAtlas..':0:0|a'
        end
    end
    if tagInfo.tagID==41 and not color then
        color=e.GetQestColor('PvP')
    end
    return atlas, color
end

--副本，难道，颜色
function e.GetDifficultyColor(string, difficultyID)--DifficultyUtil.lua
    local colorRe, name
    if difficultyID and difficultyID>0 then
        local color= {
            ['经典']= {name= e.onlyChinese and '经典' or LEGACY_RAID_DIFFICULTY, hex='|cff9d9d9d', r=0.62, g=0.62, b=0.62},
            ['场景']= {name= e.onlyChinese and '场景' or PLAYER_DIFFICULTY3, hex='|cffc6ffc9', r=0.78, g=1, b=0.79},
            ['随机']= {name= e.onlyChinese and '随机' or PLAYER_DIFFICULTY3, hex='|cff1eff00', r=0.12, g=1, b=0},
            ['普通']= {name= e.onlyChinese and '普通' or PLAYER_DIFFICULTY1, hex='|cffffffff', r=1, g=1, b=1},
            ['英雄']= {name= e.onlyChinese and '英雄' or PLAYER_DIFFICULTY2, hex='|cff0070dd', r=0, g=0.44, b=0.87},
            ['史诗']= {name= e.onlyChinese and '史诗' or PLAYER_DIFFICULTY6, hex='|cffff00ff', r=1, g=0, b=1},
            ['挑战']= {name= e.onlyChinese and '挑战' or PLAYER_DIFFICULTY5,  hex='|cffff8200', r=1, g=0.51, b=0},
            ['漫游']= {name= e.onlyChinese and '漫游' or PLAYER_DIFFICULTY_TIMEWALKER, hex='|cff00ffff', r=0, g=1, b=1},
            ['pvp']= {name= 'PvP', hex='|cffff0000', r=1, g=0, b=0},
        } or {}
        local type={
            [1]= '普通',--DifficultyUtil.ID.DungeonNormal
            [2]='英雄',--DifficultyUtil.ID.DungeonHeroic
            [3]='普通',--DifficultyUtil.ID.Raid10Normal
            [4]='普通',--DifficultyUtil.ID.Raid25Normal
            [5]='英雄',--DifficultyUtil.ID.Raid10Heroic
            [6]='英雄',--DifficultyUtil.ID.Raid25Heroic
            [7]='随机',--DifficultyUtil.ID.RaidLFR
            [8]='挑战',--DifficultyUtil.ID.DungeonChallenge Mythic Keystone
            [9]='经典',--DifficultyUtil.ID.Raid40 40 Player

            [11]= '英雄',--场景 Heroic Scenario
            [12]= '普通',--场景 Normal Scenario

            [14]='普通',--DifficultyUtil.ID.PrimaryRaidNormal 突袭
            [15]='英雄',--DifficultyUtil.ID.PrimaryRaidHeroic 突袭
            [16]='史诗',--DifficultyUtil.ID.PrimaryRaidMythic 突袭
            [17]='随机',--DifficultyUtil.ID.PrimaryRaidLFR 突袭

            [19]='普通',--场景 Event party
            [20]='普通',--场景 Event Scenario scenario
            [23]='史诗',--DifficultyUtil.ID.DungeonMythic
            [24]='漫游',--DifficultyUtil.ID.DungeonTimewalker
            [25]='pvp',--World PvP Scenario	scenario
            [29]='pvp',--PvEvP Scenario	pvp	
            [30]='普通',--Event	scenario	
            [32]='pvp',--World PvP Scenario	scenario	
            [33]='漫游',--DifficultyUtil.ID.RaidTimewalker	Timewalking	raid	
            [34]='pvp',--PvP pvp	
            [38]='普通',--Normal	scenario	
            [39]='英雄',--Heroic	scenario	displayHeroic
            [40]='史诗',--Mythic	scenario	displayMythic
            [45]='pvp',--PvP	scenario	displayHeroic
            [147]='普通',--Normal	scenario	Warfronts
            [149]='英雄',--Heroic	scenario	displayHeroic Warfronts
            [150]='普通',--Normal	party	
            [151]='漫游',--Looking For Raid	raid	Timewalking
            [152]='普通',--Visions of N'Zoth	scenario	
            [153]='英雄',--Teeming Island	scenario	displayHeroic
            [167]='普通',--Torghast	scenario	
            [168]='普通',--Path of Ascension: Courage	scenario	
            [169]='普通',--Path of Ascension: Loyalty	scenario	
            [170]='普通',--Path of Ascension: Wisdom	scenario	
            [171]='普通',--Path of Ascension: Humility	scenario
        }
        name= type[difficultyID]
        if name then
            local tab=color[name]
            string= string or tab.name or GetDifficultyInfo(difficultyID)
            string= tab.hex..string..'|r'
            colorRe= tab
        end
    end
    return  string,
            colorRe or (e.Player.useColor or {r=e.Player.r, g=e.Player.g, b=e.Player.b, hex=e.Player.col}
                    ),
            e.onlyChinese and name or GetDifficultyInfo(difficultyID)
end






























function e.Cbtn2(tab)
--[[
    e.Cbtn2({
        name=nil, 
        parent=,
        click=true,-- right left
        notSecureActionButton=nil,
        notTexture=nil,
        showTexture=true,
        size=nil,
        alpha=1,
        
    })
]]
    local button= CreateFrame("Button", tab.name, tab.parent or UIParent, not tab.notSecureActionButton and "SecureActionButtonTemplate" or nil)
    button:SetSize(tab.size or 30, tab.size or 30)
    if tab.click==true then
        button:RegisterForClicks(e.LeftButtonDown, e.RightButtonDown)
    elseif tab.click=='right' then
        button:RegisterForClicks(e.RightButtonDown)
    elseif tab.click=='left' then
        button:RegisterForClicks(e.LeftButtonDown)
    end
    button:EnableMouseWheel(true)

    button:SetHighlightAtlas('bag-border')
    button:SetPushedAtlas('bag-border-highlight')

    button.mask= button:CreateMaskTexture()
    button.mask:SetTexture('Interface\\CHARACTERFRAME\\TempPortraitAlphaMask')
    button.mask:SetPoint("TOPLEFT", button, "TOPLEFT", 4, -4);
    button.mask:SetPoint("BOTTOMRIGHT", button, "BOTTOMRIGHT", -6, 6);

    button.background=button:CreateTexture(nil,'BACKGROUND')
    button.background:SetAllPoints(button)
    button.background:SetAtlas(e.Icon.bagEmpty)
    button.background:SetAlpha(tab.alpha or 0.5)

    button.background:AddMaskTexture(button.mask)

    if not tab.notTexture then
        button.texture=button:CreateTexture(nil, 'BORDER')
        button.texture:SetPoint("TOPLEFT", button, "TOPLEFT", 4, -4);
        button.texture:SetPoint("BOTTOMRIGHT", button, "BOTTOMRIGHT", -6, 6);
        button.texture:AddMaskTexture(button.mask)
        button.texture:SetShown(tab.showTexture)
    end
    button.border=button:CreateTexture(nil, 'ARTWORK')
    button.border:SetAllPoints(button)
    button.border:SetAtlas('bag-reagent-border')
    
    e.Set_Label_Texture_Color(button.border, {type='Texture', alpha=0.5})

    return button
end

e.toolsFrame=CreateFrame('Frame')--TOOLS 框架
e.toolsFrame:SetSize(1,1)
e.toolsFrame:SetShown(false)
e.toolsFrame.last=e.toolsFrame
e.toolsFrame.line=1
e.toolsFrame.index=0

function e.ToolsSetButtonPoint(self, line, unoLine)--设置位置
    self:SetSize(30, 30)
    if (not unoLine and e.toolsFrame.index>0 and select(2, math.modf(e.toolsFrame.index / 10))==0) or line then
        local x= - (e.toolsFrame.line * 30)
        self:SetPoint('BOTTOMRIGHT', e.toolsFrame , 'TOPRIGHT', x, 0)
        e.toolsFrame.line=e.toolsFrame.line + 1
        if line then
            e.toolsFrame.index=0
        end
    else
        self:SetPoint('BOTTOMRIGHT', e.toolsFrame.last , 'TOPRIGHT')
    end
    e.toolsFrame.last=self
    e.toolsFrame.index=e.toolsFrame.index+1
end



function e.GetDurabiliy(reTexture)--耐久度
    local cur, max= 0, 0
    for i= 1, 18 do
        local cur2, max2 = GetInventoryItemDurability(i)
        if cur2 and max2 and max2>0 then
            cur= cur +cur2
            max= max +max2
        end
    end
    local text, value= nil, 100
    if max>0 then
        if cur==max then
            text= '100%'
        else
            value = cur/max * 100
            if value<30 then
                text= format('|cnRED_FONT_COLOR:%i%%|r', value-0.5)
            elseif value<=60 then
                text= format('|cnYELLOW_FONT_COLOR:%i%%|r', value-0.5)
            elseif value<=90 then
                text= format('|cnGREEN_FONT_COLOR:%i%%|r', value-0.5)
            else
                text= format('%i%%', value-0.5)
            end
        end
        if reTexture then
            text= '|T132281:0|t'..text
        end
    end
    return text, value
end

function e.GetKeystoneScorsoColor(score, texture, overall)--地下城史诗, 分数, 颜色 C_ChallengeMode.GetOverallDungeonScore()
    if not score or score==0 or score=='0' then
        return ''
    else
        score= type(score)~='number' and tonumber(score) or score
        local color= not overall and C_ChallengeMode.GetDungeonScoreRarityColor(score) or C_ChallengeMode.GetSpecificDungeonOverallScoreRarityColor(score)
        if color  then
            score= color:WrapTextInColorCode(score)
        end
        if texture then
            score= '|T4352494:0|t'..score
        end
        return score, color
    end
end

function e.GetTimeInfo(value, chat, time, expirationTime)
    if value and value>0 then
        time= time or GetTime()
        time= time < value and time + 86400 or time
        time= time - value;
        if chat then
            return e.SecondsToClock(time), time;
        else
            return SecondsToTime(time), time;
        end
    elseif expirationTime and expirationTime>0 then
        time= time or GetTime()
        expirationTime= time > expirationTime and expirationTime + 86400 or expirationTime
        time= expirationTime- time;
        if chat then
            return e.SecondsToClock(time), time;
        else
            return SecondsToTime(time), time;
        end
    else
        if chat then
            return e.SecondsToClock(0), 0;
        else
            return SecondsToTime(0), 0;
        end
    end
end

--[[function e.GetSetsCollectedNum(setID)--套装 , 收集数量, 返回: 图标, 数量, 最大数, 文本
    local info= setID and C_TransmogSets.GetSetPrimaryAppearances(setID)
    local numCollected, numAll=0,0
    if info then
        for _,v in pairs(info) do
            numAll=numAll+1
            if v.collected then
                numCollected=numCollected + 1
            end
        end
    end
    if numAll>0 then
        if numCollected==numAll then
            return '|A:transmog-icon-checkmark:0:0|a', numCollected, numAll, '|cnGREEN_FONT_COLOR:'..(e.onlyChinese and '已收集' or COLLECTED)..'|r'
        elseif numCollected==0 then
            return '|cnRED_FONT_COLOR:'..numAll-numCollected..'|r ', numCollected, numAll, '|cnRED_FONT_COLOR:'..(e.onlyChinese and '未收集' or NOT_COLLECTED)..'|r'
        else
            return ' |cnYELLOW_FONT_COLOR:'..numAll-numCollected..'|r ', numCollected, numAll, '|cnYELLOW_FONT_COLOR:'..numCollected..'/'..numAll..' '..(e.onlyChinese and '未收集' or NOT_COLLECTED)..'|r'
        end
    end
end]]

function e.GetItemCollected(link, sourceID, icon)--物品是否收集
    sourceID= sourceID or link and select(2, C_TransmogCollection.GetItemInfo(link))
    local sourceInfo = sourceID and C_TransmogCollection.GetSourceInfo(sourceID)
    if sourceInfo then
        --local hasData, canCollect= C_TransmogCollection.PlayerCanCollectSource(sourceID)
        local isSelf= select(2, C_TransmogCollection.PlayerCanCollectSource(sourceID))
        if sourceInfo.isCollected then
            if icon then
                if isSelf then
                    return e.Icon.select2, sourceInfo.isCollected, isSelf
                else
                    return '|A:Adventures-Checkmark:0:0|a', sourceInfo.isCollected, isSelf--黄色√
                end
            else
                return '|cnGREEN_FONT_COLOR:'..(e.onlyChinese and '已收集' or COLLECTED)..'|r', sourceInfo.isCollected, isSelf
            end
        else
            if icon then
                if isSelf then
                    return '|T132288:0|t', sourceInfo.isCollected, isSelf
                else
                    return  '|A:transmog-icon-hidden:0:0|a', sourceInfo.isCollected, isSelf--e.Icon.star2,
                end
            else
                return '|cnRED_FONT_COLOR:'..(e.onlyChinese and '未收集' or NOT_COLLECTED)..'|r', sourceInfo.isCollected, isSelf
            end
        end
    end
end

function e.GetPetCollectedNum(speciesID, itemID, onlyNum)--总收集数量， 25 25 25， 3/3
    if not speciesID and itemID then--宠物物品
        speciesID= select(13, C_PetJournal.GetPetInfoByItemID(itemID))
    end
    if not speciesID then
        return
    end
    local numCollected, limit = C_PetJournal.GetNumCollectedInfo(speciesID)
    if numCollected and limit then
        local AllCollected, CollectedNum, CollectedText
        if not onlyNum then--返回所有，数据
            local numPets, numOwned = C_PetJournal.GetNumPets()
            if numPets and numOwned and numPets>0 then
                if numPets<numOwned or numPets<3 then
                    AllCollected= e.MK(numOwned, 3)
                else
                    AllCollected= e.MK(numOwned,3)..'/'..e.MK(numPets,3).. (' %i%%'):format(numOwned/numPets*100)
                end
            end
            if numCollected and limit and limit>0 then
                if numCollected>0 then
                    local text2
                    for index= 1 ,numOwned do
                        local petID, speciesID2, _, _, level = C_PetJournal.GetPetInfoByIndex(index)
                        if speciesID2==speciesID and petID and level then
                            local rarity = select(5, C_PetJournal.GetPetStats(petID))
                            local col= rarity and select(4, GetItemQualityColor(rarity-1))
                            if col then
                                text2= text2 and text2..' ' or ''
                                text2= text2..'|c'..col..level..'|r'
                            end
                        end
                    end
                    CollectedNum= text2
                end
            end
        end
        if numCollected==0 then
            CollectedText='|cnRED_FONT_COLOR:'..numCollected..'|r/'..limit
        elseif limit and numCollected==limit and limit>0 then
            CollectedText= '|cnGREEN_FONT_COLOR:'..numCollected..'/'..limit..'|r'
        else
            CollectedText= numCollected..'/'..limit
        end
        return AllCollected, CollectedNum, CollectedText
    end
end

--取得对战宠物, 强弱 SharedPetBattleTemplates.lua
function e.GetPetStrongWeakHints(petType)
    local strongTexture,weakHintsTexture, stringIndex, weakHintsIndex
    for i=1, C_PetJournal.GetNumPetTypes() do
        local modifier = C_PetBattles.GetAttackModifier(petType, i);
        if ( modifier > 1 ) then
            strongTexture='Interface\\TargetingFrame\\PetBadge-'..PET_TYPE_SUFFIX[i]--"Interface\\PetBattles\\PetIcon-"..PET_TYPE_SUFFIX[i]
            weakHintsIndex=i
        elseif ( modifier < 1 ) then
            weakHintsTexture='Interface\\TargetingFrame\\PetBadge-'..PET_TYPE_SUFFIX[i]
            weakHintsIndex=i
        end
    end
    return strongTexture,weakHintsTexture, stringIndex, weakHintsIndex ----_G["BATTLE_PET_NAME_"..petType]
end


function e.GetPet9Item(itemID, find)--宠物兑换, wow9.0
    if itemID==11406 or itemID==11944 or itemID==25402 then--[黄晶珠蜒]
        if find then
            return true
        else
            return '|T3856129:0|t'..(C_PetJournal.GetNumCollectedInfo(3106) or 0)
                ..' = '
                ..'|T134357:0|t'..GetItemCount(11406, true)
                ..'|T132540:0|t'..GetItemCount(11944, true)
                ..'|T133053:0|t'..GetItemCount(25402, true)
        end

    elseif itemID==3300 or itemID==3670 or itemID==6150 then--[绿松石珠蜒]
        if find then
            return true
        else
            return '|T3856129:0|t'..(C_PetJournal.GetNumCollectedInfo(3105) or 0)
                    ..' = '
                    ..'|T132936:0|t'..GetItemCount(3300, true)
                    ..'|T133718:0|t'..GetItemCount(3670, true)
                    ..'|T133676:0|t'..GetItemCount(6150, true)
        end

    elseif itemID==36812 or itemID==62072 or itemID==67410 then--[红宝石珠蜒]
        if find then
            return true
        else
            return '|T3856131:0|t'..(C_PetJournal.GetNumCollectedInfo(3104) or 0)
                    ..' = '
                    ..'|T134063:0|t'..GetItemCount(36812, true)
                    ..'|T135148:0|t'..GetItemCount(62072, true)
                    ..'|T135239:0|t'..GetItemCount(67410, true)
        end
    end
end

function e.GetMountCollected(mountID, itemID)--坐骑, 收集数量
    if not mountID and itemID then
        mountID= C_MountJournal.GetMountFromItem(itemID)
    end
    if mountID then
        if select(11, C_MountJournal.GetMountInfoByID(mountID)) then
            return '|cnGREEN_FONT_COLOR:'..(e.onlyChinese and '已收集' or COLLECTED)..'|r', true
        else
            return '|cnRED_FONT_COLOR:'..(e.onlyChinese and '未收集' or NOT_COLLECTED)..'|r', false
        end
    end
end

function e.GetToyCollected(itemID)--玩具,是否收集
    if C_ToyBox.GetToyInfo(itemID) then
        if PlayerHasToy(itemID) then
            return '|cnGREEN_FONT_COLOR:'..(e.onlyChinese and '已收集' or COLLECTED)..'|r', true
        else
            return '|cnRED_FONT_COLOR:'..(e.onlyChinese and '未收集' or NOT_COLLECTED)..'|r', false
        end
    end
end


function e.GetExpansionText(expacID, questID)--版本数据
    expacID= expacID or questID and GetQuestExpansion(questID)
    if expacID and _G['EXPANSION_NAME'..expacID] then
        if e.ExpansionLevel==expacID then
            return _G['EXPANSION_NAME'..expacID], (e.onlyChinese and '版本' or GAME_VERSION_LABEL)..' '..(expacID+1)
        else
            return '|cff828282'.._G['EXPANSION_NAME'..expacID]..'|r', '|cff828282'..(e.onlyChinese and '版本' or GAME_VERSION_LABEL)..' '..(expacID+1)..'|r'
        end
    end
end

--e.GetTooltipData({bag={bag=nil, slot=nil}, guidBank={tab=nil, slot=nil}, merchant={slot, buyBack=true}, inventory=nil, hyperLink=nil, itemID=nil, text={}, onlyText=nil, wow=nil, onlyWoW=nil, red=nil, onlyRed=nil})--物品提示，信息
function e.GetTooltipData(tab)
    local tooltipData
    if tab.itemID and C_Heirloom.IsItemHeirloom(tab.itemID) then
        tooltipData= C_TooltipInfo.GetHeirloomByItemID(tab.itemID)
    elseif tab.bag then
        tooltipData= C_TooltipInfo.GetBagItem(tab.bag.bag, tab.bag.slot)
    elseif tab.guidBank then-- guidBank then
        tooltipData= C_TooltipInfo.GetGuildBankItem(tab.guidBank.tab, tab.guidBank.slot)
    elseif tab.merchant then
        if tab.merchant.buyBack then
            tooltipData= C_TooltipInfo.GetBuybackItem(tab.merchant.slot)
        else
            tooltipData= C_TooltipInfo.GetMerchantItem(tab.merchant.slot)--slot
        end
    elseif tab.inventory then
        tooltipData= C_TooltipInfo.GetInventoryItem('player', tab.inventory)
    end
    tooltipData= tooltipData or tab.hyperLink and C_TooltipInfo.GetHyperlink(tab.hyperLink)
    local data={
        red=false,
        wow=false,
        text={},
    }
    if tooltipData and tooltipData.lines then
        local numText= tab.text and #tab.text or 0
        local findText= numText>0 or tab.wow
        local numFind=0
        for _, line in ipairs(tooltipData.lines) do--是否
           -- TooltipUtil.SurfaceArgs(line)
            if tab.red and not data.red then
                local leftHex=line.leftColor and line.leftColor:GenerateHexColor()
                local rightHex=line.rightColor and line.rightColor:GenerateHexColor()
                if leftHex == 'ffff2020' or leftHex=='fefe1f1f' or rightHex== 'ffff2020' or rightHex=='fefe1f1f' then-- or hex=='fefe7f3f' then
                    data.red=true
                    if tab.onlyRed then
                        break
                    end
                end
            end
            if line.leftText and findText then
                if tab.text then
                    for _, text in pairs(tab.text) do
                        if text and (line.leftText:find(text) or line.leftText==text) then
                            data.text[text]= line.leftText:match(text) or line.leftText
                            numFind= numFind +1
                            if tab.onlyText and numFind==numText then
                                break
                            end
                        end
                    end
                end
                if tab.wow and not data.wow and (line.leftText==ITEM_BNETACCOUNTBOUND or line.leftText==ITEM_ACCOUNTBOUND) then--暴雪游戏通行证绑定, 账号绑定
                    data.wow=true
                    if tab.onlyWoW then
                        break
                    end
                end
            end
        end
    end
    return data
end

function e.PlaySound(soundKitID, setPlayerSound)--播放, 声音 SoundKitConstants.lua e.PlaySound()--播放, 声音
    if not C_CVar.GetCVarBool('Sound_EnableAllSound') or C_CVar.GetCVar('Sound_MasterVolume')=='0' or (not setPlayerSound and not e.setPlayerSound) then
        return
    end
    local channel

    if C_CVar.GetCVarBool('Sound_EnableDialog') and C_CVar.GetCVar("Sound_DialogVolume")~='0' then
        channel= 'Dialog'
    elseif C_CVar.GetCVarBool('Sound_EnableAmbience') and C_CVar.GetCVar("Sound_AmbienceVolume")~='0' then
        channel= 'Ambience'
    elseif C_CVar.GetCVarBool('Sound_EnableSFX') and C_CVar.GetCVar("Sound_SFXVolume")~='0' then
        channel= 'SFX'
    elseif C_CVar.GetCVarBool('Sound_EnableMusic') and C_CVar.GetCVar("Sound_MusicVolume")~='0' then
        channel= 'Music'
    else
        channel= 'Master'
    end
    local success, voHandle= PlaySound(soundKitID or SOUNDKIT.GS_CHARACTER_SELECTION_ENTER_WORLD, channel)--SOUNDKIT.READY_CHECK SOUNDKIT.LFG_ROLE_CHECK SOUNDKIT.LFG_ROLE_CHECK SOUNDKIT.IG_PLAYER_INVITE
    return success, voHandle
end




















local function set_Frame_Color(self, setR, setG, setB, setA, setHex)
    if self then
        local type= self:GetObjectType()
        if type=='FontString' then
            self:SetTextColor(setR, setG, setB,setA)
        elseif type=='Texture' then
            self:SetColorTexture(setR, setG, setB,setA)
        end
        self.r, self.g, self.b, self.a, self.hex= setR, setG, setB, setA, '|c'..setHex
    end
end
function e.RGB_to_HEX(setR, setG, setB, setA, self)--RGB转HEX
    setA= setA or 1
	setR = setR <= 1 and setR >= 0 and setR or 0
	setG = setG <= 1 and setG >= 0 and setG or 0
	setB = setA <= 1 and setB >= 0 and setB or 0
	setA = setA <= 1 and setA >= 0 and setA or 0
    local hex=format("%02x%02x%02x%02x", setA*255, setR*255, setG*255, setB*255)
    set_Frame_Color(self, setR, setG, setB, setA, hex)
	return hex
end

function e.HEX_to_RGB(hexColor, self)--HEX转RGB -- ColorUtil.lua
	if hexColor then
		hexColor= hexColor:match('|c(.+)') or hexColor
        hexColor= hexColor:gsub('#', '')
		hexColor= hexColor:gsub(' ','')
        local len= #hexColor
		if len == 8 then
            local colorA= tonumber(hexColor:sub(1, 2), 16)
            local colorR= tonumber(hexColor:sub(3, 4), 16)
            local colorG= tonumber(hexColor:sub(5, 6), 16)
            local colorB= tonumber(hexColor:sub(7, 8), 16)
            if colorA and colorR and colorG and colorB then
                colorA, colorR, colorG, colorB= colorA/255, colorR/255, colorG/255, colorB/255
                set_Frame_Color(self, colorR, colorG, colorB, colorA, hexColor)
                return colorR, colorG, colorB, colorA
            end
        elseif len==6 then
            local colorR= tonumber(hexColor:sub(1, 2), 16)
            local colorG= tonumber(hexColor:sub(3, 4), 16)
            local colorB= tonumber(hexColor:sub(5, 6), 16)
            if colorR and colorG and colorB then
                colorR, colorG, colorB= colorR/255, colorG/255, colorB/255
                hexColor= 'ff'..hexColor
                set_Frame_Color(self, colorR, colorG, colorB, 1, hexColor)
                return colorR, colorG, colorB, 1
            end
		end
	end
end

function e.Get_ColorFrame_RGBA()--取得, ColorFrame, 颜色
	local a= OpacitySliderFrame:IsShown() and OpacitySliderFrame:GetValue() or 0
	local r, g, b = ColorPickerFrame:GetColorRGB()
	return r, g, b, 1-a
end

function e.ShowColorPicker(valueR, valueG, valueB, valueA, func, cancelFunc)
    ColorPickerFrame:SetShown(false); -- Need to run the OnShow handler.
    valueR= valueR or 1
    valueG= valueG or 0.8
    valueB= valueB or 0
    valueA= valueA or 1
    --valueA= 1- valueA
    ColorPickerFrame.hasOpacity= true
    --ColorPickerFrame.previousValues = {valueR, valueG , valueB , valueA}
    ColorPickerFrame.func= func
    ColorPickerFrame.opacityFunc= func
    ColorPickerFrame.cancelFunc = cancelFunc or func
    ColorPickerFrame:SetColorRGB(valueR, valueG, valueB)
    ColorPickerFrame.opacity = 1- valueA;
    ColorPickerFrame:SetShown(true)
end















local Realms={}
if e.Player.region==3 then--EU 
    Realms = {--3 EU
        ["Aegwynn"]="deDE", ["Alexstrasza"]="deDE", ["Alleria"]="deDE", ["Aman’Thul"]="deDE", ["Aman'Thul"]="deDE", ["Ambossar"]="deDE",
        ["Anetheron"]="deDE", ["Antonidas"]="deDE", ["Anub'arak"]="deDE", ["Area52"]="deDE", ["Arthas"]="deDE",
        ["Arygos"]="deDE", ["Azshara"]="deDE", ["Baelgun"]="deDE", ["Blackhand"]="deDE", ["Blackmoore"]="deDE",
        ["Blackrock"]="deDE", ["Blutkessel"]="deDE", ["Dalvengyr"]="deDE", ["DasKonsortium"]="deDE",
        ["DasSyndikat"]="deDE", ["DerMithrilorden"]="deDE", ["DerRatvonDalaran"]="deDE",
        ["DerAbyssischeRat"]="deDE", ["Destromath"]="deDE", ["Dethecus"]="deDE", ["DieAldor"]="deDE",
        ["DieArguswacht"]="deDE", ["DieNachtwache"]="deDE", ["DieSilberneHand"]="deDE", ["DieTodeskrallen"]="deDE",
        ["DieewigeWacht"]="deDE", ["DunMorogh"]="deDE", ["Durotan"]="deDE", ["Echsenkessel"]="deDE", ["Eredar"]="deDE",
        ["FestungderStürme"]="deDE", ["Forscherliga"]="deDE", ["Frostmourne"]="deDE", ["Frostwolf"]="deDE",
        ["Garrosh"]="deDE", ["Gilneas"]="deDE", ["Gorgonnash"]="deDE", ["Gul'dan"]="deDE", ["Kargath"]="deDE", ["Kel'Thuzad"]="deDE",
        ["Khaz'goroth"]="deDE", ["Kil'jaeden"]="deDE", ["Krag'jin"]="deDE", ["KultderVerdammten"]="deDE", ["Lordaeron"]="deDE",
        ["Lothar"]="deDE", ["Madmortem"]="deDE", ["Mal'Ganis"]="deDE", ["Malfurion"]="deDE", ["Malorne"]="deDE", ["Malygos"]="deDE", ["Mannoroth"]="deDE",
        ["Mug'thol"]="deDE", ["Nathrezim"]="deDE", ["Nazjatar"]="deDE", ["Nefarian"]="deDE", ["Nera'thor"]="deDE", ["Nethersturm"]="deDE",
        ["Norgannon"]="deDE", ["Nozdormu"]="deDE", ["Onyxia"]="deDE", ["Perenolde"]="deDE", ["Proudmoore"]="deDE", ["Rajaxx"]="deDE", ["Rexxar"]="deDE",
        ["Sen'jin"]="deDE", ["Shattrath"]="deDE", ["Taerar"]="deDE", ["Teldrassil"]="deDE", ["Terrordar"]="deDE", ["Theradras"]="deDE", ["Thrall"]="deDE",
        ["Tichondrius"]="deDE", ["Tirion"]="deDE", ["Todeswache"]="deDE", ["Ulduar"]="deDE", ["Un'Goro"]="deDE", ["Vek'lor"]="deDE", ["Wrathbringer"]="deDE",
        ["Ysera"]="deDE", ["ZirkeldesCenarius"]="deDE", ["Zuluhed"]="deDE",

        ["Arakarahm"]="frFR", ["Arathi"]="frFR", ["Archimonde"]="frFR", ["Chantséternels"]="frFR", ["Cho’gall"]="frFR", ["Cho'gall"]="frFR",
        ["ConfrérieduThorium"]="frFR", ["ConseildesOmbres"]="frFR", ["Dalaran"]="frFR", ["Drek’Thar"]="frFR", ["Drek'Thar"]="frFR",
        ["Eitrigg"]="frFR", ["Eldre’Thalas"]="frFR", ["Eldre'Thalas"]="frFR", ["Elune"]="frFR", ["Garona"]="frFR", ["Hyjal"]="frFR", ["Illidan"]="frFR",
        ["Kael’thas"]="frFR", ["Kael'thas"]="frFR", ["KhazModan"]="frFR", ["KirinTor"]="frFR", ["Krasus"]="frFR", ["LaCroisadeécarlate"]="frFR",
        ["LesClairvoyants"]="frFR", ["LesSentinelles"]="frFR", ["MarécagedeZangar"]="frFR", ["Medivh"]="frFR", ["Naxxramas"]="frFR",
        ["Ner’zhul"]="frFR", ["Ner'zhul"]="frFR", ["Rashgarroth"]="frFR", ["Sargeras"]="frFR", ["Sinstralis"]="frFR", ["Suramar"]="frFR",
        ["Templenoir"]="frFR", ["Throk’Feroth"]="frFR", ["Throk'Feroth"]="frFR", ["Uldaman"]="frFR", ["Varimathras"]="frFR", ["Vol’jin"]="frFR",
        ["Vol'jin"]="frFR", ["Ysondre"]="frFR",

        ["AeriePeak"]="enGB", ["Agamaggan"]="enGB", ["Aggramar"]="enGB", ["Ahn'Qiraj"]="enGB", ["Al'Akir"]="enGB", ["Alonsus"]="enGB", ["Anachronos"]="enGB",
        ["Arathor"]="enGB", ["ArenaPass"]="enGB", ["ArenaPass1"]="enGB", ["ArgentDawn"]="enGB", ["Aszune"]="enGB", ["Auchindoun"]="enGB", ["AzjolNerub"]="enGB",
        ["Azuremyst"]="enGB", ["Balnazzar"]="enGB", ["Blade'sEdge"]="enGB", ["Bladefist"]="enGB", ["Bloodfeather"]="enGB", ["Bloodhoof"]="enGB", ["Bloodscalp"]="enGB",
        ["Boulderfist"]="enGB", ["BronzeDragonflight"]="enGB", ["Bronzebeard"]="enGB", ["BurningBlade"]="enGB", ["BurningLegion"]="enGB", ["BurningSteppes"]="enGB",
        ["C'Thun"]="enGB", ["ChamberofAspects"]="enGB", ["Chromaggus"]="enGB", ["ColinasPardas"]="enGB", ["Crushridge"]="enGB", ["CultedelaRivenoire"]="enGB",
        ["Daggerspine"]="enGB", ["DarkmoonFaire"]="enGB", ["Darksorrow"]="enGB", ["Darkspear"]="enGB", ["Deathwing"]="enGB", ["DefiasBrotherhood"]="enGB",
        ["Dentarg"]="enGB", ["Doomhammer"]="enGB", ["Draenor"]="enGB", ["Dragonblight"]="enGB", ["Dragonmaw"]="enGB", ["Drak'thul"]="enGB", ["Dunemaul"]="enGB",
        ["EarthenRing"]="enGB", ["EmeraldDream"]="enGB", ["Emeriss"]="enGB", ["Eonar"]="enGB", ["Executus"]="enGB", ["Frostmane"]="enGB", ["Frostwhisper"]="enGB",
        ["Genjuros"]="enGB", ["Ghostlands"]="enGB", ["GrimBatol"]="enGB", ["Hakkar"]="enGB", ["Haomarush"]="enGB", ["Hellfire"]="enGB", ["Hellscream"]="enGB",
        ["Jaedenar"]="enGB", ["Karazhan"]="enGB", ["Kazzak"]="enGB", ["Khadgar"]="enGB", ["Kilrogg"]="enGB", ["Kor'gall"]="enGB", ["KulTiras"]="enGB", ["LaughingSkull"]="enGB",
        ["Lightbringer"]="enGB", ["Lightning'sBlade"]="enGB", ["Magtheridon"]="enGB", ["Mazrigos"]="enGB", ["Moonglade"]="enGB", ["Nagrand"]="enGB",
        ["Neptulon"]="enGB", ["Nordrassil"]="enGB", ["Outland"]="enGB", ["Quel'Thalas"]="enGB", ["Ragnaros"]="enGB", ["Ravencrest"]="enGB", ["Ravenholdt"]="enGB",
        ["Runetotem"]="enGB", ["Saurfang"]="enGB", ["ScarshieldLegion"]="enGB", ["Shadowsong"]="enGB", ["ShatteredHalls"]="enGB", ["ShatteredHand"]="enGB",
        ["Silvermoon"]="enGB", ["Skullcrusher"]="enGB", ["Spinebreaker"]="enGB", ["Sporeggar"]="enGB", ["SteamwheedleCartel"]="enGB", ["Stormrage"]="enGB",
        ["Stormreaver"]="enGB", ["Stormscale"]="enGB", ["Sunstrider"]="enGB", ["Sylvanas"]="enGB", ["Talnivarr"]="enGB", ["TarrenMill"]="enGB", ["Terenas"]="enGB",
        ["Terokkar"]="enGB", ["TheMaelstrom"]="enGB", ["TheSha'tar"]="enGB", ["TheVentureCo"]="enGB", ["Thunderhorn"]="enGB", ["Trollbane"]="enGB", ["Turalyon"]="enGB",
        ["Twilight'sHammer"]="enGB", ["TwistingNether"]="enGB", ["Vashj"]="enGB", ["Vek'nilash"]="enGB", ["Wildhammer"]="enGB", ["Xavius"]="enGB", ["Zenedar"]="enGB",

        ["Nemesis"]="itIT", ["Pozzodell'Eternità"]="itIT",

        ["DunModr"]="esES", ["EuskalEncounter"]="esES", ["Exodar"]="esES", ["LosErrantes"]="esES",
        ["Minahonda"]="esES", ["Sanguino"]="esES", ["Shen'dralar"]="esES",
        ["Tyrande"]="esES", ["Uldum"]="esES", ["Zul'jin"]="esES",

        ["Азурегос"]="ruRU", ["Борейскаятундра"]="ruRU", ["ВечнаяПесня"]="ruRU", ["Галакронд"]="ruRU", ["Голдринн"]="ruRU",
        ["Гордунни"]="ruRU", ["Гром"]="ruRU", ["Дракономор"]="ruRU", ["Корольлич"]="ruRU", ["Пиратскаябухта"]="ruRU", ["Подземье"]="ruRU", ["ПропускнаАрену1"]="ruRU",
        ["Разувий"]="ruRU", ["Ревущийфьорд"]="ruRU", ["СвежевательДуш"]="ruRU", ["Седогрив"]="ruRU", ["СтражСмерти"]="ruRU", ["Термоштепсель"]="ruRU",
        ["ТкачСмерти"]="ruRU", ["ЧерныйШрам"]="ruRU", ["Ясеневыйлес"]="ruRU",

        ["Aggra(Português)"]="ptBR",
    }

elseif e.Player.region==1 then
    Realms = {--1 US
        ["Aman'Thul"]="oce", ["Barthilas"]="oce", ["Caelestrasz"]="oce", ["Dath'Remar"]="oce", ["Dreadmaul"]="oce",
        ["Frostmourne"]="oce", ["Gundrak"]="oce", ["Jubei'Thos"]="oce", ["Khaz'goroth"]="oce", ["Nagrand"]="oce",
        ["Saurfang"]="oce", ["Thaurissan"]="oce",

        ["Aerie Peak"]="usp", ["Anvilmar"]="usp", ["Arathor"]="usp", ["Antonidas"]="usp", ["Azuremyst"]="usp",
        ["Baelgun"]="usp", ["Blade's Edge"]="usp", ["Bladefist"]="usp", ["Bronzebeard"]="usp", ["Cenarius"]="usp",
        ["Darrowmere"]="usp", ["Draenor"]="usp", ["Dragonblight"]="usp", ["Echo Isles"]="usp", ["Galakrond"]="usp",
        ["Gnomeregan"]="usp", ["Hyjal"]="usp", ["Kilrogg"]="usp", ["Korialstrasz"]="usp", ["Lightbringer"]="usp",
        ["Misha"]="usp", ["Moonrunner"]="usp", ["Nordrassil"]="usp", ["Proudmoore"]="usp", ["Shadowsong"]="usp",
        ["Shu'Halo"]="usp", ["Silvermoon"]="usp", ["Skywall"]="usp", ["Suramar"]="usp", ["Uldum"]="usp", ["Uther"]="usp",
        ["Velen"]="usp", ["Windrunner"]="usp", ["Blackrock"]="usp", ["Blackwing Lair"]="usp", ["Bonechewer"]="usp",
        ["Boulderfist"]="usp", ["Coilfang"]="usp", ["Crushridge"]="usp", ["Daggerspine"]="usp", ["Dark Iron"]="usp",
        ["Destromath"]="usp", ["Dethecus"]="usp", ["Dragonmaw"]="usp", ["Dunemaul"]="usp", ["Frostwolf"]="usp",
        ["Gorgonnash"]="usp", ["Gurubashi"]="usp", ["Kalecgos"]="usp", ["Kil'Jaeden"]="usp", ["Lethon"]="usp", ["Maiev"]="usp",
        ["Nazjatar"]="usp", ["Ner'zhul"]="usp", ["Onyxia"]="usp", ["Rivendare"]="usp", ["Shattered Halls"]="usp",
        ["Spinebreaker"]="usp", ["Spirestone"]="usp", ["Stonemaul"]="usp", ["Stormscale"]="usp", ["Tichondrius"]="usp",
        ["Ursin"]="usp", ["Vashj"]="usp", ["Blackwater Raiders"]="usp", ["Cenarion Circle"]="usp",
        ["Feathermoon"]="usp", ["Sentinels"]="usp", ["Silver Hand"]="usp", ["The Scryers"]="usp",
        ["Wyrmrest Accord"]="usp", ["The Venture Co"]="usp",

        ["Azjol-Nerub"]="usm", ["AzjolNerub"]="usm", ["Doomhammer"]="usm", ["Icecrown"]="usm", ["Perenolde"]="usm",
        ["Terenas"]="usm", ["Zangarmarsh"]="usm", ["Kel'Thuzad"]="usm", ["Darkspear"]="usm", ["Deathwing"]="usm",
        ["Bloodscalp"]="usm", ["Nathrezim"]="usm", ["Shadow Council"]="usm",

        ["Aegwynn"]="usc", ["Agamaggan"]="usc", ["Aggramar"]="usc", ["Akama"]="usc", ["Alexstrasza"]="usc", ["Alleria"]="usc",
        ["Archimonde"]="usc", ["Azgalor"]="usc", ["Azshara"]="usc", ["Balnazzar"]="usc", ["Blackhand"]="usc",
        ["Blood Furnace"]="usc", ["Borean Tundra"]="usc", ["Burning Legion"]="usc", ["Cairne"]="usc",
        ["Cho'gall"]="usc", ["Chromaggus"]="usc", ["Dawnbringer"]="usc", ["Dentarg"]="usc", ["Detheroc"]="usc",
        ["Drak'tharon"]="usc", ["Drak'thul"]="usc", ["Draka"]="usc", ["Eitrigg"]="usc", ["Emerald Dream"]="usc",
        ["Farstriders"]="usc", ["Fizzcrank"]="usc", ["Frostmane"]="usc", ["Garithos"]="usc", ["Garona"]="usc",
        ["Ghostlands"]="usc", ["Greymane"]="usc", ["Gul'dan"]="usc", ["Hakkar"]="usc",
        ["Hellscream"]="usc", ["Hydraxis"]="usc", ["Illidan"]="usc", ["Kael'thas"]="usc", ["Khaz Modan"]="usc",
        ["Kirin Tor"]="usc", ["Korgath"]="usc", ["Kul Tiras"]="usc", ["Laughing Skull"]="usc", ["Lightninghoof"]="usc",
        ["Madoran"]="usc", ["Maelstrom"]="usc", ["Mal'Ganis"]="usc", ["Malfurion"]="usc", ["Malorne"]="usc", ["Malygos"]="usc",
        ["Mok'Nathal"]="usc", ["Moon Guard"]="usc", ["Mug'thol"]="usc", ["Muradin"]="usc", ["Nesingwary"]="usc",
        ["Quel'Dorei"]="usc", ["Ravencrest"]="usc", ["Rexxar"]="usc", ["Runetotem"]="usc", ["Sargeras"]="usc",
        ["Scarlet Crusade"]="usc", ["Sen'Jin"]="usc", ["Sisters of Elune"]="usc", ["Staghelm"]="usc",
        ["Stormreaver"]="usc", ["Terokkar"]="usc", ["The Underbog"]="usc", ["Thorium Brotherhood"]="usc",
        ["Thunderhorn"]="usc", ["Thunderlord"]="usc", ["Twisting Nether"]="usc", ["Vek'nilash"]="usc",
        ["Whisperwind"]="usc", ["Wildhammer"]="usc", ["Winterhoof"]="usc",

        ["Altar of Storms"]="use", ["Alterac Mountains"]="use", ["Andorhal"]="use", ["Anetheron"]="use",
        ["Anub'arak"]="use", ["Area 52"]="use", ["Argent Dawn"]="use", ["Arthas"]="use", ["Arygos"]="use", ["Auchindoun"]="use",
        ["Black Dragonflight"]="use", ["Bleeding Hollow"]="use", ["Bloodhoof"]="use", ["Burning Blade"]="use",
        ["Dalaran"]="use", ["Dalvengyr"]="use", ["Demon Soul"]="use", ["Drenden"]="use", ["Durotan"]="use", ["Duskwood"]="use",
        ["Earthen Ring"]="use", ["Eldre'Thalas"]="use", ["Elune"]="use", ["Eonar"]="use", ["Eredar"]="use", ["Executus"]="use",
        ["Exodar"]="use", ["Fenris"]="use", ["Firetree"]="use", ["Garrosh"]="use", ["Gilneas"]="use", ["Gorefiend"]="use",
        ["Grizzly Hills"]="use", ["Haomarush"]="use", ["Jaedenar"]="use", ["Kargath"]="use", ["Khadgar"]="use",
        ["Lightning's Blade"]="use", ["Llane"]="use", ["Lothar"]="use", ["Magtheridon"]="use", ["Mannoroth"]="use",
        ["Medivh"]="use", ["Nazgrel"]="use", ["Norgannon"]="use", ["Ravenholdt"]="use", ["Scilla"]="use", ["Shadowmoon"]="use",
        ["Shandris"]="use", ["Shattered Hand"]="use", ["Skullcrusher"]="use", ["Smolderthorn"]="use",
        ["Steamwheedle Cartel"]="use", ["Stormrage"]="use", ["Tanaris"]="use", ["The Forgotten Coast"]="use",
        ["Thrall"]="use", ["Tortheldrin"]="use", ["Trollbane"]="use", ["Turalyon"]="use", ["Uldaman"]="use",
        ["Undermine"]="use", ["Warsong"]="use", ["Ysera"]="use", ["Ysondre"]="use", ["Zul'jin"]="use", ["Zuluhed"]="use",

        ["Drakkari"]="mex", ["Quel'Thalas"]="mex", ["Ragnaros"]="mex",

        ["Azralon"]="bzl", ["Gallywix"]="bzl", ["Goldrinn"]="bzl", ["Nemesis"]="bzl", ["Tol Barad"]="bzl",
    }
end
local regionColor = {--https://wago.io/6-GG3RMcC
    ["deDE"]= {col="|cFF00FF00DE|r", text='DE', realm="Germany"},
    ["frFR"]= {col="|cFF00FFFFFR|r", text='FR', realm="France"},
    ["enGB"]= {col="|cFFFF00FFGB|r", text='GB', realm="Great Britain"},
    ["itIT"]= {col="|cFFFFFF00IT|r", text='IT', realm="Italy"},
    ["esES"]= {col="|cFFFFBF00ES|r", text='ES', realm="Spain"},
    ["ruRU"]= {col="|cFFCCCCFFRU|r" ,text='RU', realm="Russia"},
    ["ptBR"]= {col="|cFF8fce00PT|r", text='PT', realm="Portuguese"},

    ["oce"]= {col="|cFF00FF00OCE|r", text='CE', realm="Oceanic"},
    ["usp"]= {col="|cFF00FFFFUSP|r", text='USP', realm="US Pacific"},
    ["usm"]= {col="|cFFFF00FFUSM|r", text='USM', realm="US Mountain"},
    ["usc"]= {col="|cFFFFFF00USC|r", text='USC', realm="US Central"},
    ["use"]= {col="|cFFFFBF00USE|r", text='USE', realm="US East"},
    ["mex"]= {col="|cFFCCCCFFMEX|r", text='MEX', realm="Mexico"},
    ["bzl"]= {col="|cFF8fce00BZL|r", text='BZL', realm="Brazil"},
}

function e.Get_Region(realm, guid, unit, disabled)--e.Get_Region(server, guid, unit)--服务器，EU， US {col=, text=, realm=}
    if disabled then
        regionColor={}
        Realms={}
    else
        realm= realm=='' and e.Player.realm
                or realm
                or unit and ((select(2, UnitName(unit)) or e.Player.realm))
                or guid and select(7, GetPlayerInfoByGUID(guid))
        return realm and Realms[realm] and regionColor[Realms[realm]]
    end
end