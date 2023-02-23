
local id, e= ...
local addName= STAT_CATEGORY_ATTRIBUTES--PaperDollFrame.lua
local panel= CreateFrame('Frame')
local button, Role, PrimaryStat
local Save={
    redColor= '|cffff8200',
    greenColor='|cff00ff00',
    tab={
        ['CRITCHANCE']= {r=0.99, g=0.35, b=0.31},
        ['HASTE']= {r=0.66, g=1, b=0.4},
        ['MASTERY']= {r=0.82, g=0.28, b=0.82},
        ['VERSATILITY']= {r=0, g=0.77, b=1},
        ['LIFESTEAL']= {r=1, g=0.33, b=0.5},
        ['AVOIDANCE']= {r=1, g=0.79, b=0},--'闪避'

        ["DODGE"]= {r=1, g=0.51, b=1},--躲闪
        ["PARRY"]= {r=0.59, g=0.85, b=1},
        ["BLOCK"]= {r=0.75, g=0.53, b=0.78},
        ["STAGGER"]= {r=0.38, g=1, b=0.62},
        ["SPEED"]= {r=1, g=0.82, b=0},--移动
    },
    --toLeft=true--数值,放左边
    --bar=true,--进度条
    --barTexture2,--样式2
    scale= 1.1,--缩放
    vertical=3,--上下，间隔
    horizontal=8,--左右， 间隔
}

local Tabs
local function set_Tabs()
    local spec= GetSpecialization()
    Role= GetSpecializationRole(spec)--DAMAGER, TANK, HEALER
    local icon, _
    icon, _, PrimaryStat= select(4, GetSpecializationInfo(spec, nil, nil, nil, e.Player.sex))
    SetPortraitToTexture(button.texture, icon or 0)
    Tabs={
        {name='STATUS', r=e.Player.r, g=e.Player.g, b=e.Player.b, a=1},

        {name= 'CRITCHANCE', text= e.onlyChinse and '爆击' or STAT_CRITICAL_STRIKE, bar=true},
        {name= 'HASTE', text= e.onlyChinse and '急速' or STAT_HASTE, bar=true},
        {name= 'MASTERY', text= e.onlyChinse and '精通' or STAT_MASTERY, bar=true},
        {name= 'VERSATILITY', text= e.onlyChinse and '全能' or STAT_VERSATILITY, bar=true},--5

        {name= 'LIFESTEAL', text= e.onlyChinse and '吸血' or STAT_LIFESTEAL, bar=true},--6
        {name= 'AVOIDANCE', text= e.onlyChinse and '闪避' or STAT_AVOIDANCE, bar=true},--7

        {name= 'DODGE', text= e.onlyChinse and '躲闪' or STAT_DODGE, bar=true},--8
        {name= 'PARRY', text= e.onlyChinse and '招架' or STAT_PARRY, bar=true},--9
        {name= 'BLOCK', text= e.onlyChinse and '格挡' or STAT_BLOCK, bar=true},--10
        {name= 'STAGGER', text= e.onlyChinse and '醉拳' or STAT_STAGGER, bar=true},--11

        {name= 'SPEED', text= e.onlyChinse and '移动' or NPE_MOVE},--12
    }

    if PrimaryStat==LE_UNIT_STAT_STRENGTH then
        Tabs[1].text= e.onlyChinse and '力量' or SPEC_FRAME_PRIMARY_STAT_STRENGTH
    elseif PrimaryStat==LE_UNIT_STAT_AGILITY then
        Tabs[1].text= e.onlyChinse and '敏捷' or SPEC_FRAME_PRIMARY_STAT_AGILITY
    else
        Tabs[1].text= e.onlyChinse and '智力' or SPEC_FRAME_PRIMARY_STAT_INTELLECT
    end

    for index, info in pairs(Tabs) do
        if not Save.tab[info.name]then
            Save.tab[info.name]={name= info.name}
        end
        Tabs[index].r= index==1 and e.Player.r or Save.tab[info.name].r or 1
        Tabs[index].g= index==1 and e.Player.g or Save.tab[info.name].g or 0.82
        Tabs[index].b= index==1 and e.Player.b or Save.tab[info.name].b or 0
        Tabs[index].a= index==1 and 1 or Save.tab[info.name].a or 1
        if info.name=='VERSATILITY' then
            Tabs[index].damage= Save.tab[info.name].damage
        elseif info.name=='SPEED' then
            Tabs[index].current= Save.tab[info.name].current
        end
        if index>=6 and index<=11 then--坦克
            if Role~='TANK' then
                Tabs[index].hide= true
            elseif info.name=='STAGGER' and e.Player.class~='MONK' then--武僧
                Tabs[index].hide= true
            else
                Tabs[index].hide= Save.tab[info.name].hide
            end
        else
            Tabs[index].hide= Save.tab[info.name].hide
        end
    end
end


--#####
--主属性
--#####
local function set_Stat_Text(frame)
    if PrimaryStat then
        local value= UnitStat('player', PrimaryStat)
        local text
        if not frame.value or frame.value== value then
            text= e.MK(value, 3)
        elseif frame.value< value then
            text= Save.greenColor..e.MK(value, 3)..'|r'
        else
            text= Save.redColor..e.MK(value, 3)..'|r'
        end
        frame.text:SetText(text)
        return value
    end
end
local function set_Stat_Tooltip(self)
    if not PrimaryStat then
        return
    end
    local frame= self:GetParent()
    e.tips:SetOwner(self, "ANCHOR_LEFT")
    e.tips:ClearLines()
    local stat, effectiveStat, posBuff, negBuff = UnitStat('player', PrimaryStat);
    local effectiveStatDisplay = BreakUpLargeNumbers(effectiveStat);
    local tooltipText = effectiveStatDisplay
    if posBuff~=0 and negBuff~=0 then
        tooltipText = effectiveStatDisplay;
        if ( posBuff > 0 or negBuff < 0 ) then
            tooltipText = tooltipText.." ("..BreakUpLargeNumbers(stat - posBuff - negBuff)
        end
        if ( posBuff > 0 ) then
            tooltipText = tooltipText..GREEN_FONT_COLOR_CODE.."+"..BreakUpLargeNumbers(posBuff)..FONT_COLOR_CODE_CLOSE;
        end
        if ( negBuff < 0 ) then
            tooltipText = tooltipText..RED_FONT_COLOR_CODE.." "..BreakUpLargeNumbers(negBuff)..FONT_COLOR_CODE_CLOSE;
        end
        if ( posBuff > 0 or negBuff < 0 ) then
            tooltipText = tooltipText..")"
        end
    end
    e.tips:AddDoubleLine(frame.nametext, tooltipText)
    local role = GetSpecializationRole(GetSpecialization())
    if PrimaryStat==LE_UNIT_STAT_STRENGTH then-- Strength
        local text= ''
        local attackPower = GetAttackPowerForStat(frame.index, effectiveStat);
        if (HasAPEffectsSpellPower()) then
            text= e.onlyChinse and '提高你的攻击和技能强度' or STAT_TOOLTIP_BONUS_AP_SP
        end
        text= text..' '.. BreakUpLargeNumbers(attackPower)
        if role == "TANK" then
            local increasedParryChance = GetParryChanceFromAttribute();
            if ( increasedParryChance > 0 ) then
                CR_PARRY_BASE_STAT_TOOLTIP = "招架几率提高%.2f%%|n|cff888888（在效果递减之前）|r"
                text= text..'\n'..format(e.onlyChinse and '"招架几率提高%.2f%%|n|cff888888（在效果递减之前）|r"' or CR_PARRY_BASE_STAT_TOOLTIP, increasedParryChance);
            end
        end
        e.tips:AddDoubleLine(text,nil,nil,nil,true)

    elseif PrimaryStat==LE_UNIT_STAT_AGILITY then-- Agility
        local text=''
        if HasAPEffectsSpellPower() then
            text= e.onlyChinse and '提高你的攻击和技能强度' or  STAT_TOOLTIP_BONUS_AP_SP
        else
            text= e.onlyChinse and '提高你的攻击和技能强度' or STAT_TOOLTIP_BONUS_AP
        end

        if role == "TANK" then
            local increasedDodgeChance = GetDodgeChanceFromAttribute();
            if increasedDodgeChance > 0 then
                text= text .."|n"..format(e.onlyChinse and '躲闪几率提高%.2f%%|n|cff888888（在效果递减之前）|r' or CR_DODGE_BASE_STAT_TOOLTIP, increasedDodgeChance);
            end
        end
        e.tips:AddDoubleLine(text,nil,nil,nil,true)

    elseif PrimaryStat==LE_UNIT_STAT_INTELLECT then
        local text
        if HasAPEffectsSpellPower() then
            text= e.onlyChinse and "|cff808080该属性不能使你获益|r" or STAT_NO_BENEFIT_TOOLTIP
        elseif HasSPEffectsAttackPower() then
            text= e.onlyChinse and '提高你的攻击和技能强度' or  STAT_TOOLTIP_BONUS_AP_SP
        else
            text= (e.onlyChinse and '提高你的法术强度' or DEFAULT_STAT4_TOOLTIP).. effectiveStat
        end
        e.tips:AddDoubleLine(text,nil,nil,nil,true)
    end
    if frame.value and frame.value~=stat then
        e.tips:AddLine(' ')
        local text
        if frame.value< stat then
            text= Save.greenColor..'+ '..format('%s', e.MK(stat- frame.value,3))
        else
            text= Save.redColor..'- '..format('%s', e.MK(3, frame.value- stat))
        end
        e.tips:AddDoubleLine(format('%i', frame.value), text)
    end
    e.tips:Show()
end



--####
--爆击
--####
local function set_Crit_Text(frame)
    local critChance
	local spellCrit = frame.minCrit or 0
	local rangedCrit = GetRangedCritChance();
	local meleeCrit = GetCritChance();
	if (spellCrit >= rangedCrit and spellCrit >= meleeCrit) then
		critChance = spellCrit
	elseif (rangedCrit >= meleeCrit) then
		critChance = rangedCrit
	else
		critChance = meleeCrit
	end
    if not frame.value or frame.value== critChance then
        frame.text:SetFormattedText('%d%%', critChance + 0.5)
    elseif frame.value< critChance then
        frame.text:SetFormattedText(Save.greenColor..'%d%%', critChance + 0.5)
    else
        frame.text:SetFormattedText(Save.redColor..'%d%%', critChance + 0.5)
    end
    if frame.bar then
        frame.bar:SetValue(critChance)
    end
    return critChance
end
local function set_Crit_Tooltip(self)
    local frame= self:GetParent()
    e.tips:SetOwner(self, "ANCHOR_LEFT")
    e.tips:ClearLines()
    local spellCrit = frame.minCrit or 0
	local rangedCrit = GetRangedCritChance();
	local meleeCrit = GetCritChance();
    local critChance, rating
	if (spellCrit >= rangedCrit and spellCrit >= meleeCrit) then
		critChance = spellCrit;
		rating = CR_CRIT_SPELL;
	elseif (rangedCrit >= meleeCrit) then
		critChance = rangedCrit;
		rating = CR_CRIT_RANGED;
	else
		critChance = meleeCrit;
		rating = CR_CRIT_MELEE;
	end
    e.tips:AddDoubleLine(frame.nametext, format('%.2f%%', critChance + 0.5))

	local extraCritChance = GetCombatRatingBonus(rating);
	local extraCritRating = GetCombatRating(rating);
	if (GetCritChanceProvidesParryEffect()) then
        if e.onlyChinse then
            e.tips:AddLine(format("攻击和法术造成额外效果的几率。\n爆击：%s [+%.2f%%]\n招架几率提高%.2f%%。", BreakUpLargeNumbers(extraCritRating), extraCritChance, GetCombatRatingBonusForCombatRatingValue(CR_PARRY, extraCritRating)), nil,nil,nil,true)
        else
            e.tips:AddLine(format(CR_CRIT_PARRY_RATING_TOOLTIP, BreakUpLargeNumbers(extraCritRating), extraCritChance, GetCombatRatingBonusForCombatRatingValue(CR_PARRY, extraCritRating)), nil,nil,nil,true)
        end
	else
        if e.onlyChinse then
		    e.tips:AddLine(format( "攻击和法术造成额外效果的几率。\n爆击：%s [+%.2f%%]", BreakUpLargeNumbers(extraCritRating), extraCritChance), nil,nil,nil,true)
        else
            e.tips:AddLine(format(CR_CRIT_TOOLTIP, BreakUpLargeNumbers(extraCritRating), extraCritChance), nil,nil,nil,true)
        end
	end
    if frame.value and frame.value~=critChance then
        e.tips:AddLine(' ')
        local text
        if frame.value< critChance then
            text= Save.greenColor..'+ '..format('%.2f%%', critChance- frame.value)
        else
            text= Save.redColor..'- '..format('%.2f%%', frame.value- critChance)
        end
        e.tips:AddDoubleLine(format('%.2f%%', frame.value + 0.5), text)
    end
    e.tips:Show()
end

--####
--急速
--####
local function set_Haste_Text(frame)
	local haste = GetHaste()
    if not frame.value or frame.value== haste then
        frame.text:SetFormattedText('%d%%', haste + 0.5)
    elseif frame.value< haste then
        frame.text:SetFormattedText(Save.greenColor..'%d%%', haste + 0.5)
    else
        frame.text:SetFormattedText(Save.redColor..'%d%%', haste + 0.5)
    end
    if frame.bar then
        frame.bar:SetValue(haste)
    end
    return haste
end
local function set_Haste_Tooltip(self)
    local frame= self:GetParent()
    e.tips:SetOwner(self, "ANCHOR_LEFT")
    e.tips:ClearLines()

    local haste = GetHaste();
	local rating = CR_HASTE_MELEE;

	local hasteFormatString;
	if (haste < 0 and not GetPVPGearStatRules()) then
		hasteFormatString = RED_FONT_COLOR_CODE.."%s"..FONT_COLOR_CODE_CLOSE;
	else
		hasteFormatString = "%s";
	end
	e.tips:AddDoubleLine(frame.nametext, format(hasteFormatString, format("%0.2f%%", haste + 0.5)))
	e.tips:AddLine(_G["STAT_HASTE_"..e.Player.class.."_TOOLTIP"] or (e.onlyChinse and '提高攻击速度和施法速度。' or STAT_HASTE_TOOLTIP), nil, nil,nil,true)
	e.tips:AddDoubleLine(format(e.onlyChinse and '急速：%s [+%.2f%%]' or STAT_HASTE_BASE_TOOLTIP, BreakUpLargeNumbers(GetCombatRating(rating)), GetCombatRatingBonus(rating)))
    if frame.value and frame.value~=haste then
        e.tips:AddLine(' ')
        local text
        if frame.value< haste then
            text= Save.greenColor..'+ '..format('%.2f%%', haste- frame.value)
        else
            text= Save.redColor..'- '..format('%.2f%%', frame.value- haste)
        end
        e.tips:AddDoubleLine(format('%.2f%%', frame.value + 0.5), text)
    end
    e.tips:Show()
end

--####
--精通
--####
local function set_Mastery_Text(frame)
	local mastery = GetMasteryEffect();
    if not frame.value or frame.value== mastery then
        frame.text:SetFormattedText('%d%%', mastery + 0.5)
    elseif frame.value< mastery then
        frame.text:SetFormattedText(Save.greenColor..'%d%%', mastery + 0.5)
    else
        frame.text:SetFormattedText(Save.redColor..'%d%%', mastery + 0.5)
    end
    if frame.bar then
        frame.bar:SetValue(mastery)
    end
    return mastery
end

--####
--全能, 5
--####
local function set_Versatility_Text(frame)
    local versatilityDamageBonus = GetCombatRatingBonus(CR_VERSATILITY_DAMAGE_DONE) + GetVersatilityBonus(CR_VERSATILITY_DAMAGE_DONE)
    local text= format('%d', versatilityDamageBonus + 0.5)
    if frame.damage then
        local versatilityDamageTakenReduction = GetCombatRatingBonus(CR_VERSATILITY_DAMAGE_TAKEN) + GetVersatilityBonus(CR_VERSATILITY_DAMAGE_TAKEN);
        text= text..'/'..format('%d', versatilityDamageTakenReduction + 0.5)
    end
    text= text..'%'
    if not frame.value or frame.value== versatilityDamageBonus then
        frame.text:SetText(text)
    elseif frame.value< versatilityDamageBonus then
        frame.text:SetText(Save.greenColor..text)
    else
        frame.text:SetText(Save.redColor..text)
    end
    if frame.bar then
        frame.bar:SetValue(versatilityDamageBonus)
    end
    return versatilityDamageBonus
end
local function set_Versatility_Tooltip(self)
    local frame= self:GetParent()
    e.tips:SetOwner(self, "ANCHOR_LEFT")
    e.tips:ClearLines()
    local versatility = GetCombatRating(CR_VERSATILITY_DAMAGE_DONE);
	local versatilityDamageBonus = GetCombatRatingBonus(CR_VERSATILITY_DAMAGE_DONE) + GetVersatilityBonus(CR_VERSATILITY_DAMAGE_DONE);
	local versatilityDamageTakenReduction = GetCombatRatingBonus(CR_VERSATILITY_DAMAGE_TAKEN) + GetVersatilityBonus(CR_VERSATILITY_DAMAGE_TAKEN);
    e.tips:AddDoubleLine(frame.nametext, format('%.2f%%',  versatilityDamageBonus))
	e.tips:AddLine(format(e.onlyChinse and "造成的伤害值和治疗量提高%.2f%%，\n受到的伤害降低%.2f%%。\n全能：%s [%.2f%%/%.2f%%]" or CR_VERSATILITY_TOOLTIP, versatilityDamageBonus, versatilityDamageTakenReduction, BreakUpLargeNumbers(versatility), versatilityDamageBonus, versatilityDamageTakenReduction), nil,nil,nil,true)
    if frame.value and frame.value~=versatilityDamageBonus then
        e.tips:AddLine(' ')
        local text
        if frame.value< versatilityDamageBonus then
            text= Save.greenColor..'+ '..format('%.2f%%', versatilityDamageBonus- frame.value)
        else
            text= Save.redColor..'- '..format('%.2f%%', frame.value- versatilityDamageBonus)
        end
        e.tips:AddDoubleLine(format('%.2f%%', frame.value + 0.5), text)
    end
    e.tips:Show()
end

--####
--吸血, 6
--####
local function set_Lifesteal_Text(frame)
    local lifesteal = GetLifesteal();
    if not frame.value or frame.value== lifesteal then
        frame.text:SetFormattedText('%d%%', lifesteal + 0.5)
    elseif frame.value< lifesteal then
        frame.text:SetFormattedText(Save.greenColor..'%d%%', lifesteal + 0.5)
    else
        frame.text:SetFormattedText(Save.redColor..'%d%%', lifesteal + 0.5)
    end
    if frame.bar then
        frame.bar:SetValue(lifesteal)
    end
    return lifesteal
end
local function set_Lifesteal_Tooltip(self)
    local frame= self:GetParent()
    e.tips:SetOwner(self, "ANCHOR_LEFT")
    e.tips:ClearLines()

    local lifesteal = GetLifesteal();
	e.tips:AddDoubleLine(frame.nametext,  format("%0.2f%%", lifesteal))
    e.tips:AddLine(format(e.onlyChinse and '你所造成伤害和治疗的一部分将转而治疗你。\n\n吸血：%s [+%.2f%%]' or CR_LIFESTEAL_TOOLTIP, BreakUpLargeNumbers(GetCombatRating(CR_LIFESTEAL)), GetCombatRatingBonus(CR_LIFESTEAL)), nil,nil,nil,true)
    if frame.value and frame.value~=lifesteal then
        e.tips:AddLine(' ')
        local text
        if frame.value< lifesteal then
            text= Save.greenColor..'+ '..format('%.2f%%', lifesteal- frame.value)
        else
            text= Save.redColor..'- '..format('%.2f%%', frame.value- lifesteal)
        end
        e.tips:AddDoubleLine(format('%.2f%%', frame.value + 0.5), text)
    end
    e.tips:Show()
end

--####
--闪避, 7
--####
local function set_Avoidance_Text(frame)
    local Avoidance = GetAvoidance();
    if not frame.value or frame.value== Avoidance then
        frame.text:SetFormattedText('%d%%', Avoidance + 0.5)
    elseif frame.value< Avoidance then
        frame.text:SetFormattedText(Save.greenColor..'%d%%', Avoidance + 0.5)
    else
        frame.text:SetFormattedText(Save.redColor..'%d%%', Avoidance + 0.5)
    end
    if frame.bar then
        frame.bar:SetValue(Avoidance)
    end
    return Avoidance
end
local function set_Avoidance_Tooltip(self)
    local frame= self:GetParent()
    e.tips:SetOwner(self, "ANCHOR_LEFT")
    e.tips:ClearLines()

    local Avoidance = GetAvoidance();
	e.tips:AddDoubleLine(frame.nametext,  format("%0.2f%%", Avoidance))
    e.tips:AddLine(format(e.onlyChinse and '范围效果法术的伤害降低。\n\n闪避：%s [+%.2f%%' or CR_AVOIDANCE_TOOLTIP , BreakUpLargeNumbers(GetCombatRating(CR_AVOIDANCE)), GetCombatRatingBonus(CR_AVOIDANCE)), nil,nil,nil,true)
    if frame.value and frame.value~=Avoidance then
        e.tips:AddLine(' ')
        local text
        if frame.value< Avoidance then
            text= Save.greenColor..'+ '..format('%.2f%%', Avoidance- frame.value)
        else
            text= Save.redColor..'- '..format('%.2f%%', frame.value- Avoidance)
        end
        e.tips:AddDoubleLine(format('%.2f%%', frame.value + 0.5), text)
    end
    e.tips:Show()
end

--####
--躲闪, 8
--####
local function set_Dodge_Text(frame)
    local chance = GetDodgeChance();
    if not frame.value or frame.value== chance then
        frame.text:SetFormattedText('%d%%', chance + 0.5)
    elseif frame.value< chance then
        frame.text:SetFormattedText(Save.greenColor..'%d%%', chance + 0.5)
    else
        frame.text:SetFormattedText(Save.redColor..'%d%%', chance + 0.5)
    end
    if frame.bar then
        frame.bar:SetValue(chance)
    end
    return chance
end
local function set_Dodge_Tooltip(self)
    local frame= self:GetParent()
    e.tips:SetOwner(self, "ANCHOR_LEFT")
    e.tips:ClearLines()

    local chance = GetDodgeChance();
	e.tips:AddDoubleLine(frame.nametext,  format("%0.2f%%", chance))
    e.tips:AddLine( format(e.onlyChinse and '%d点躲闪可使躲闪几率提高%.2f%%\n|cff888888（在效果递减之前）|r' or CR_DODGE_TOOLTIP, GetCombatRating(CR_DODGE), GetCombatRatingBonus(CR_DODGE)), nil,nil,nil,true)
    if frame.value and frame.value~=chance then
        e.tips:AddLine(' ')
        local text
        if frame.value< chance then
            text= Save.greenColor..'+ '..format('%.2f%%', chance- frame.value)
        else
            text= Save.redColor..'- '..format('%.2f%%', frame.value- chance)
        end
        e.tips:AddDoubleLine(format('%.2f%%', frame.value + 0.5), chance)
    end
    e.tips:Show()
end

--####
--招架, 9
--####
local function set_Parry_Text(frame)
    local chance = GetParryChance();
    if not frame.value or frame.value== chance then
        frame.text:SetFormattedText('%d%%', chance + 0.5)
    elseif frame.value< chance then
        frame.text:SetFormattedText(Save.greenColor..'%d%%', chance + 0.5)
    else
        frame.text:SetFormattedText(Save.redColor..'%d%%', chance + 0.5)
    end
    if frame.bar then
        frame.bar:SetValue(chance)
    end
    return chance
end
local function set_Parry_Tooltip(self)
    local frame= self:GetParent()
    e.tips:SetOwner(self, "ANCHOR_LEFT")
    e.tips:ClearLines()

    local chance = GetParryChance();
	e.tips:AddDoubleLine(frame.nametext,  format("%0.2f%%", chance))
    e.tips:AddLine(format(e.onlyChinse and '%d点招架可使招架几率提高%.2f%%\n|cff888888（在效果递减之前）|r' or CR_PARRY_TOOLTIP, GetCombatRating(CR_PARRY), GetCombatRatingBonus(CR_PARRY)), nil,nil,nil,true)
    if frame.value and frame.value~=chance then
        e.tips:AddLine(' ')
        local text
        if frame.value< chance then
            text= Save.greenColor..'+ '..format('%.2f%%', chance- frame.value)
        else
            text= Save.redColor..'- '..format('%.2f%%', frame.value- chance)
        end
        e.tips:AddDoubleLine(format('%.2f%%', frame.value + 0.5), chance)
    end
    e.tips:Show()
end

--####
--格挡, 10
--####
local function set_Block_Text(frame)
    local chance = GetBlockChance();
    if not frame.value or frame.value== chance then
        frame.text:SetFormattedText('%d%%', chance + 0.5)
    elseif frame.value< chance then
        frame.text:SetFormattedText(Save.greenColor..'%d%%', chance + 0.5)
    else
        frame.text:SetFormattedText(Save.redColor..'%d%%', chance + 0.5)
    end
    if frame.bar then
        frame.bar:SetValue(chance)
    end
    return chance
end
local function set_Block_Tooltip(self)
    local frame= self:GetParent()
    e.tips:SetOwner(self, "ANCHOR_LEFT")
    e.tips:ClearLines()

    local chance = GetBlockChance();
    e.tips:AddDoubleLine(frame.nametext,  format("%0.2f%%", chance))

	local shieldBlockArmor = GetShieldBlock();
	local blockArmorReduction = PaperDollFrame_GetArmorReduction(shieldBlockArmor, UnitEffectiveLevel('player'));
	local blockArmorReductionAgainstTarget = PaperDollFrame_GetArmorReductionAgainstTarget(shieldBlockArmor);

	e.tips:AddLine(format(e.onlyChinse and '格挡可使一次攻击的伤害降低%0.2f%%.\n|cff888888（对抗与你实力相当的敌人时）|r' or CR_BLOCK_TOOLTIP, blockArmorReduction), nil,nil,nil,true)
	if (blockArmorReductionAgainstTarget) then
		e.tips:AddLine(format(e.onlyChinse and '（对当前目标：%0.2f%%）' or STAT_BLOCK_TARGET_TOOLTIP, blockArmorReductionAgainstTarget), nil,nil,nil,true)
	end

    if frame.value and frame.value~=chance then
        e.tips:AddLine(' ')
        local text
        if frame.value< chance then
            text= Save.greenColor..'+ '..format('%.2f%%', chance- frame.value)
        else
            text= Save.redColor..'- '..format('%.2f%%', frame.value- chance)
        end
        e.tips:AddDoubleLine(format('%.2f%%', frame.value + 0.5), chance)
    end
    e.tips:Show()
end

--####
--醉拳
--####
local function set_Stagger_Text(frame)
    local stagger, staggerAgainstTarget = C_PaperDollInfo.GetStaggerPercentage('player')
    if stagger then
        local text= format('%d', stagger + 0.5)
        if staggerAgainstTarget then
            text= text..' '..format('%d', staggerAgainstTarget + 0.5)
        end
        text= text..'%'
        if not frame.value or frame.value== stagger then
            frame.text:SetText(text)
        elseif frame.value< stagger then
            frame.text:SetText(Save.greenColor..text)
        else
            frame.text:SetText(Save.redColor..text)
        end
    end
    if frame.bar then
        frame.bar:SetValue(stagger)
    end
    return stagger
end
local function set_Stagger_Tooltip(self)
    local stagger, staggerAgainstTarget = C_PaperDollInfo.GetStaggerPercentage('player');
    if not stagger then
        return
    end
    local frame= self:GetParent()
    e.tips:SetOwner(self, "ANCHOR_LEFT")
    e.tips:ClearLines()
    e.tips:AddDoubleLine(frame.nametext,  format("%0.2f%%", stagger))
	e.tips:AddLine(format(e.onlyChinse and '你的醉拳可化解%0.2f%%的伤害' or STAT_STAGGER_TOOLTIP, stagger), nil,nil,nil,true)
	if (staggerAgainstTarget) then
		e.tips:AddLine(format(e.onlyChinse and '（对当前目标比例%0.2f%%）' or STAT_STAGGER_TARGET_TOOLTIP, staggerAgainstTarget), nil,nil,nil,true)
	end

    if frame.value and frame.value~=stagger then
        e.tips:AddLine(' ')
        local text
        if frame.value< stagger then
            text= Save.greenColor..'+ '..format('%.2f%%', stagger- frame.value)
        else
            text= Save.redColor..'- '..format('%.2f%%', frame.value- stagger)
        end
        e.tips:AddDoubleLine(format('%.2f%%', frame.value), text)
    end
    e.tips:Show()
end

--####
--移动, 12
--####
local timeElapsed = 0
local function set_SPEED_Text(frame, elapsed)
    timeElapsed = timeElapsed + elapsed
    if timeElapsed > 0.3 then
        local unit= UnitExists('vehicle') and 'vehicle' or (frame.current or UnitOnTaxi('player')) and 'player'
        if unit then
            local currentSpeed = GetUnitSpeed(unit)
            if currentSpeed~=0 then
                frame.text:SetFormattedText('%.0f%%', currentSpeed*100/BASE_MOVEMENT_SPEED)
            else
                frame.text:SetText('')
            end
        else
            local _, runSpeed, flightSpeed, swimSpeed = GetUnitSpeed('player')
            local value
            value= IsFlying() and flightSpeed or IsSwimming() and swimSpeed or runSpeed
            if value~=0 then
                frame.text:SetFormattedText('%.0f%%', value*100/BASE_MOVEMENT_SPEED)
            else
                frame.text:SetText('')
            end
        end
        timeElapsed = 0
    end
end
local function set_SPEED_Tooltip(self)
    local frame= self:GetParent()
    e.tips:SetOwner(self, "ANCHOR_LEFT")
    e.tips:ClearLines()
    local currentSpeed, runSpeed, flightSpeed, swimSpeed = GetUnitSpeed('player')
    e.tips:AddDoubleLine(frame.nametext, 'player')
    e.tips:AddLine(format(e.onlyChinse and '提升移动速度。|n|n速度：%s [+%.2f%%]' or CR_SPEED_TOOLTIP, BreakUpLargeNumbers(GetCombatRating(CR_SPEED)), GetCombatRatingBonus(CR_SPEED)), nil,nil,nil, true)
    e.tips:AddLine(' ')
    e.tips:AddDoubleLine((e.onlyChinse and '当前' or REFORGE_CURRENT)..format(' %.0f%%', currentSpeed*100/BASE_MOVEMENT_SPEED), format('%.2f', currentSpeed))
    e.tips:AddDoubleLine((e.onlyChinse and '地面' or MOUNT_JOURNAL_FILTER_GROUND)..format(' %.0f%%', runSpeed*100/BASE_MOVEMENT_SPEED), format('%.2f', runSpeed))
    e.tips:AddDoubleLine((e.onlyChinse and '水栖' or MOUNT_JOURNAL_FILTER_AQUATIC )..format(' %.0f%%', swimSpeed*100/BASE_MOVEMENT_SPEED), format('%.2f', swimSpeed))
    e.tips:AddDoubleLine((e.onlyChinse and '飞行' or MOUNT_JOURNAL_FILTER_FLYING )..format(' %.0f%%', flightSpeed*100/BASE_MOVEMENT_SPEED), format('%.2f', flightSpeed))
    if UnitExists('vehicle') then
        currentSpeed = GetUnitSpeed('vehicle')
        e.tips:AddLine(' ')
        e.tips:AddDoubleLine((e.onlyChinse and '载具' or 'Vehicle')..format(' %.0f%%', currentSpeed*100/BASE_MOVEMENT_SPEED), format('%.2f', currentSpeed))
    end
    e.tips:Show()
end


local function set_Label_Value(frame)
    local  value
    if frame.name=='STATUS' then--主属性1
        value= set_Stat_Text(frame)

    elseif frame.name=='CRITCHANCE' then--爆击2
        local holySchool = 2;
        local minCrit = GetSpellCritChance(holySchool) or 0;
        local spellCrit;
        for i=(holySchool+1), MAX_SPELL_SCHOOLS do
            spellCrit = GetSpellCritChance(i);
            minCrit = min(minCrit, spellCrit);
        end
        frame.minCrit = minCrit
        value= set_Crit_Text(frame)

    elseif frame.name=='HASTE' then--急速3
        value= set_Haste_Text(frame)

    elseif frame.name=='MASTERY' then--精通4
        value= set_Mastery_Text(frame)

    elseif frame.name=='VERSATILITY' then--全能5
        value= set_Versatility_Text(frame)

    elseif frame.name=='LIFESTEAL' then--吸血6
        value= set_Lifesteal_Text(frame)

    elseif frame.name=='AVOIDANCE' then--闪避7
        value= set_Avoidance_Text(frame)

    elseif frame.name=='DODGE' then--躲闪
        value= set_Dodge_Text(frame)

    elseif frame.name=='PARRY' then--招架
        value= set_Parry_Text(frame)

    elseif frame.name=='BLOCK' then--格挡
        value= set_Block_Text(frame)

    elseif frame.name=='STAGGER' then--醉拳11
        value= set_Stagger_Text(frame)
    --elseif frame.name=='STAGGER' then--SPEED 速度12

    end
    if not frame.value or frame.value==0 or value==0 then
        frame.value= value
    end

    local text= Tabs[frame.index].text
    frame.nametext= text
    if Save.gsubText then--文本，截取
        text= e.WA_Utf8Sub(text, Save.gsubText)
    end
    frame.label:SetText(text or '')
end

local function set_Size(frame)--设置，大小
    frame:SetSize(Save.horizontal, 12+ (Save.vertical or 3))
end
local function create_Rest_Lable(rest)--初始， 或设置
    local last= button.frame
    for index, info in pairs(Tabs) do
        local frame, find= button[info.name], nil
        if not info.hide then
            if not frame then
                frame= CreateFrame('Frame', nil, button.frame)
                set_Size(frame)--设置，大小
                frame.label= e.Cstr(frame, nil, nil, nil, {info.r,info.g,info.b,info.a}, nil, Save.toLeft and 'LEFT' or 'RIGHT')
                frame.label:EnableMouse(true)
                frame.label:SetScript('OnLeave', function() e.tips:Hide() end)

                frame.text= e.Cstr(frame, nil, nil, nil, {1,1,1}, nil, Save.toLeft and 'RIGHT' or 'LEFT')
                frame.text:EnableMouse(true)
                frame.text:SetScript('OnLeave', function() e.tips:Hide() end)

                if info.bar and Save.bar then
                    frame.bar= CreateFrame('StatusBar', nil, frame)
                    frame.bar:SetSize(120, 12)
                    if Save.barTexture2 then
                        frame.bar:SetStatusBarTexture('Interface\\TargetingFrame\\UI-StatusBar')
                    else
                        frame.bar:SetStatusBarTexture('UI-HUD-UnitFrame-Player-PortraitOn-Bar-Health-Status')
                    end
                    frame.bar:SetMinMaxValues(0,100)
                    frame.bar:SetFrameLevel(frame:GetFrameLevel()-1)
                    frame.bar:SetStatusBarColor(info.r,info.g,info.b,info.a)
                end
                if Save.toLeft then
                    frame.label:SetPoint('TOPLEFT', frame, 'TOPRIGHT',-5,0)
                    frame.text:SetPoint('TOPRIGHT', frame, 'TOPLEFT', 5,0)
                    if frame.bar then
                        frame.bar:SetPoint('TOPRIGHT', frame.text,0,-2)
                        frame.bar:SetReverseFill(true)
                    end
                else
                    frame.label:SetPoint('TOPRIGHT', frame, 'TOPLEFT', 5,0)
                    frame.text:SetPoint('TOPLEFT', frame, 'TOPRIGHT',-5,0)
                    if frame.bar then
                        frame.bar:SetPoint('TOPLEFT', frame.text,0,-2)
                    end
                end

                if info.name=='STATUS' then--主属性1
                    frame:RegisterUnitEvent('UNIT_STATS', 'player')
                    frame:SetScript('OnEvent', set_Stat_Text)
                    frame.label:SetScript('OnEnter', set_Stat_Tooltip)
                    frame.text:SetScript('OnEnter', set_Stat_Tooltip)

                elseif info.name=='CRITCHANCE' then--爆击2
                    local holySchool = 2;
                    local minCrit = GetSpellCritChance(holySchool) or 0;
                    local spellCrit;
                    for i=(holySchool+1), MAX_SPELL_SCHOOLS do
                        spellCrit = GetSpellCritChance(i);
                        minCrit = min(minCrit, spellCrit);
                    end
                    frame.minCrit = minCrit
                    frame:RegisterUnitEvent('UNIT_DAMAGE', 'player')
                    frame:SetScript('OnEvent', set_Crit_Text)
                    frame.label:SetScript('OnEnter', set_Crit_Tooltip)
                    frame.text:SetScript('OnEnter', set_Crit_Tooltip)

                elseif info.name=='HASTE' then--急速3
                    frame:RegisterUnitEvent('UNIT_DAMAGE', 'player')
                    frame:SetScript('OnEvent', set_Haste_Text)
                    frame.label:SetScript('OnEnter', set_Haste_Tooltip)
                    frame.text:SetScript('OnEnter', set_Haste_Tooltip)

                elseif info.name=='MASTERY' then--精通4
                    frame:RegisterEvent('MASTERY_UPDATE')
                    frame.onEnterFunc = Mastery_OnEnter;
                    frame.label:SetScript('OnEnter', frame.onEnterFunc)--PaperDollFrame.lua
                    frame.text:SetScript('OnEnter', frame.onEnterFunc)

                elseif info.name=='VERSATILITY' then--全能5
                    frame:RegisterUnitEvent('UNIT_DAMAGE', 'player')
                    frame:SetScript('OnEvent', set_Versatility_Text)
                    frame.label:SetScript('OnEnter', set_Versatility_Tooltip)
                    frame.text:SetScript('OnEnter', set_Versatility_Tooltip)

                elseif info.name=='LIFESTEAL' then--吸血6
                    frame:RegisterEvent('LIFESTEAL_UPDATE')
                    button.frame:RegisterEvent('LIFESTEAL_UPDATE')
                    frame:SetScript('OnEvent', set_Lifesteal_Text)
                    frame.label:SetScript('OnEnter', set_Lifesteal_Tooltip)
                    frame.text:SetScript('OnEnter', set_Lifesteal_Tooltip)

                elseif info.name=='AVOIDANCE' then--闪避7
                    frame:RegisterEvent('AVOIDANCE_UPDATE')
                    button.frame:RegisterEvent('AVOIDANCE_UPDATE')
                    frame:SetScript('OnEvent', set_Avoidance_Text)
                    frame.label:SetScript('OnEnter', set_Avoidance_Tooltip)
                    frame.text:SetScript('OnEnter', set_Avoidance_Tooltip)

                elseif info.name=='DODGE' then--躲闪8
                    frame:RegisterUnitEvent('UNIT_DEFENSE', "player")
                    frame:RegisterUnitEvent('UNIT_DAMAGE', 'player')
                    frame:SetScript('OnEvent', set_Dodge_Text)
                    frame.label:SetScript('OnEnter', set_Dodge_Tooltip)
                    frame.text:SetScript('OnEnter', set_Dodge_Tooltip)

                elseif info.name=='PARRY' then--招架9
                    frame:RegisterUnitEvent('UNIT_DAMAGE', 'player')
                    frame:RegisterUnitEvent('UNIT_DEFENSE', "player")
                    frame:SetScript('OnEvent', set_Parry_Text)
                    frame.label:SetScript('OnEnter', set_Parry_Tooltip)
                    frame.text:SetScript('OnEnter', set_Parry_Tooltip)

                elseif info.name=='BLOCK' then--格挡10
                    frame:RegisterUnitEvent('UNIT_DEFENSE', "player")
                    frame:RegisterUnitEvent('UNIT_DAMAGE', 'player')
                    frame:SetScript('OnEvent', set_Block_Text)
                    frame.label:SetScript('OnEnter', set_Block_Tooltip)
                    frame.text:SetScript('OnEnter', set_Block_Tooltip)

                elseif info.name=='STAGGER' then--醉拳11
                    frame:RegisterUnitEvent('UNIT_DEFENSE', "player")
                    frame:RegisterUnitEvent('UNIT_DAMAGE', 'player')
                    frame:RegisterEvent('PLAYER_TARGET_CHANGED')
                    frame:SetScript('OnEvent', set_Stagger_Text)
                    frame.label:SetScript('OnEnter', set_Stagger_Tooltip)
                    frame.text:SetScript('OnEnter', set_Stagger_Tooltip)

                elseif info.name=='SPEED' then--移动12
                    frame:HookScript('OnUpdate', set_SPEED_Text)
                    frame.label:SetScript('OnEnter', set_SPEED_Tooltip)
                    frame.text:SetScript('OnEnter', set_SPEED_Tooltip)
                    hooksecurefunc(UIWidgetPowerBarContainerFrame, 'CreateWidget', function(self, widgetID)
                        if widgetID==4460 then
                            frame:SetShown(false)
                        end
                    end)
                    hooksecurefunc(UIWidgetPowerBarContainerFrame, 'RemoveWidget', function(self, widgetID)
                        if widgetID==4460 then
                            frame:SetShown(true)
                        end
                    end)
                end
                frame.name= info.name
                frame.index= index
                button[info.name]= frame
            end

            if rest then--重置
                frame.value=nil
            end

            if frame.name=='VERSATILITY' then--全能5, 双属性
                frame.damage= info.damage
            elseif frame.name=='SPEED' then--速度12, 当前属性
                frame.current= info.current
            end

            set_Label_Value(frame)

            find= (frame.value and frame.value>0) or info.name=='SPEED'
            if find then
                frame:ClearAllPoints()
                frame:SetPoint('TOP', last,'BOTTOM')
                --[[if Save.toLeft then
                    frame:SetPoint('TOPLEFT', last, 'BOTTOMLEFT')
                else
                    frame:SetPoint('TOPRIGHT', last, 'BOTTOMRIGHT')
                end]]
                last= frame
                frame:SetShown(true)
            end
        end
        if not find and frame then
            frame:SetShown(false)
        end
    end
end


--##########
--显示， 隐藏
--##########
local function set_Show_Hide()
    --[[if Save.hide then
        button:SetNormalAtlas('charactercreate-icon-customize-body-selected')
    else
        button:SetNormalTexture(0)--'charactercreate-icon-customize-body-selected')
    end]]
    button.frame:SetShown(not Save.hide)
    button:SetAlpha(Save.hide and 0.3 or 1)
end

--#########
--设置, 位置
--#########
local function set_Point()
    if Save.point then
        button:SetPoint(Save.point[1], UIParent, Save.point[3], Save.point[4], Save.point[5])
    else
        button:SetPoint('LEFT', 23, 180)
    end
end



--##########
--设置 panel
--##########
local function set_Panle_Setting()--设置 panel
    local last=CreateFrame('Button', nil, panel, 'UIPanelButtonTemplate')--重新加载UI
    last:SetPoint('TOPLEFT')
    last:SetText(e.onlyChinse and '重新加载UI' or RELOADUI)
    last:SetSize(120, 28)
    last:SetScript('OnMouseUp', function()
        ReloadUI()
    end)

    for index, info in pairs(Tabs) do
        if info.name=='DODGE' then
            local text= e.Cstr(panel)
            text:SetPoint('TOPLEFT', last, 'BOTTOMLEFT',0, -16)
            if e.onlyChinse then
                text:SetText("仅限坦克"..INLINE_TANK_ICON)
            else
                text:SetFormattedText(LFG_LIST_CROSS_FACTION , TANK..INLINE_TANK_ICON)
            end
            last= text
        end
        local r= info.r or 1
        local g= info.g or 0.82
        local b= info.b or 0
        local a= info.a or 1
        local text= e.Cstr(panel, nil, nil, nil, {r,g,b,a})
        if index==1 or info.name=='SPEED' then
            text:SetPoint('TOPLEFT', last, 'BOTTOMLEFT',0, -16)
        else
            text:SetPoint('TOPLEFT', last, 'BOTTOMLEFT',0, -4)
        end
        text:SetText(info.text)
        if index>1 then
            text:EnableMouse(true)
            text.r, text.g, text.b, text.a= r, g, b, a
            text.name= info.name
            text.text= info.text
            text:SetScript('OnMouseDown', function(self)
                e.ShowColorPicker(self.r, self.g, self.b,self.a, function(restore)
                    local newA, newR, newG, newB
                    if not restore then
                        newA, newR, newG, newB = OpacitySliderFrame:GetValue(), ColorPickerFrame:GetColorRGB()
                    else
                        newA, newR, newG, newB= self.a, self.r, self.g, self.b
                    end
                    Save.tab[self.name].r= newR
                    Save.tab[self.name].g= newG
                    Save.tab[self.name].b= newB
                    Save.tab[self.name].a= newA
                    self:SetTextColor(newR, newG, newB, newA)
                    if button[self.name] then
                        if button[self.name].label then
                            button[self.name].label:SetTextColor(newR, newG, newB, newA)
                        end
                        if button[self.name].bar then
                            button[self.name].bar:SetStatusBarColor(newR,newG,newB,newA)
                        end
                    end
                end)
            end)
            text:SetScript('OnEnter', function(self)
                local r2= Save.tab[self.name].r or 1
                local g2= Save.tab[self.name].g or 0.82
                local b2= Save.tab[self.name].b or 0
                local a2= Save.tab[self.name].a or 1
                e.tips:SetOwner(self, "ANCHOR_LEFT")
                e.tips:ClearLines()
                e.tips:AddDoubleLine(self.text, self.name, r2, g2, b2)
                e.tips:AddDoubleLine(e.onlyChinse and '设置' or SETTINGS, e.onlyChinse and '颜色' or COLOR)
                e.tips:AddLine(' ')
                e.tips:AddDoubleLine(format('r%.2f', r2)..format('  g%.2f', g2)..format('  b%.2f', b2), format('a%.2f', a2))
                e.tips:Show()
            end)
            text:SetScript('OnLeave', function() e.tips:Hide() end)
        end

        local check=CreateFrame("CheckButton", nil, panel, "InterfaceOptionsCheckButtonTemplate")
        check:SetChecked(not Save.tab[info.name].hide)
        check:SetPoint('LEFT', text, 'RIGHT',2,0)
        check.name= info.name
        check.text2= info.text
        check:SetScript('OnMouseUp',function(self)
            Save.tab[self.name].hide= not Save.tab[self.name].hide and true or nil
            set_Tabs()
            create_Rest_Lable(true)--初始， 或设置
           -- print(id, addName,e.GetShowHide(not Save.tab[self.name].hide), '|cnGREEN_FONT_COLOR:', e.onlyChinse and '需要重新加载' or REQUIRES_RELOAD)
        end)
        check:SetScript('OnEnter', function(self)
            e.tips:SetOwner(self, "ANCHOR_LEFT")
            e.tips:ClearLines()
            local value= button[self.name] and button[self.name].value
            e.tips:AddDoubleLine(self.text2, format('%.2f%%', value or 0))
            e.tips:AddLine(' ')
            e.tips:AddDoubleLine(e.GetShowHide(Save.tab[self.name].hide), '|cnGREEN_FONT_COLOR:0 = '..(e.onlyChinse and '隐藏' or HIDE))
            e.tips:Show()
        end)
        check:SetScript('OnLeave', function() e.tips:Hide() end)

        if info.name=='SPEED' then--速度, 当前速度, 选项
            local current= CreateFrame("CheckButton", nil, panel, "InterfaceOptionsCheckButtonTemplate")
            current:SetChecked(Save.tab[info.name].current)
            current:SetPoint('LEFT', check, 'RIGHT',2,0)
            current.text:SetText(e.onlyChinse and '当前' or 'REFORGE_CURRENT')
            current.name= info.name
            current:SetScript('OnMouseUp',function(self)
                Save.tab[self.name].current= not Save.tab[self.name].current and true or nil
                set_Tabs()
                create_Rest_Lable(true)--初始， 或设置
            end)
            current:SetScript('OnEnter', set_SPEED_Tooltip)
            current:SetScript('OnLeave', function() e.tips:Hide() end)

        elseif info.name=='VERSATILITY' then--全能5, 双属性 22/18%
            local damage=CreateFrame("CheckButton", nil, panel, "InterfaceOptionsCheckButtonTemplate")
            damage:SetChecked(Save.tab[info.name].damage)
            damage:SetPoint('LEFT', check, 'RIGHT',2,0)
            damage.text:SetText((e.onlyChinse and '防御' or DEFENSE)..' 22/18%')
            damage.name= info.name
            damage:SetScript('OnMouseDown', function(self)
                Save.tab[self.name].damage= not Save.tab[self.name].damage and true or nil
                set_Tabs()
                create_Rest_Lable()--初始， 或设置
            end)
            damage:SetScript('OnEnter', set_Versatility_Tooltip)
            damage:SetScript('OnLeave', function() e.tips:Hide() end)
        end
        last= text
    end

    local check= CreateFrame("CheckButton", nil, panel, "InterfaceOptionsCheckButtonTemplate")
    check:SetPoint("TOPLEFT", panel.check, 'BOTTOMLEFT', 0, -12)
    check.text:SetText((e.onlyChinse and '数值' or STATUS_TEXT_VALUE)..': '..(e.onlyChinse and '向左' or BINDING_NAME_STRAFELEFT)..e.Icon.toLeft2)
    check:SetChecked(Save.toLeft)
    check:SetScript('OnMouseDown', function()
        Save.toLeft= not Save.toLeft and true or nil
        print(id, addName, '|cnGREEN_FONT_COLOR:', e.onlyChinse and '需要重新加载' or REQUIRES_RELOAD)
    end)
    check:SetScript("OnEnter", function(self)
        e.tips:SetOwner(self, "ANCHOR_LEFT")
        e.tips:ClearLines()
        e.tips:AddLine('23% '..Tabs[2].text)
        e.tips:Show()
    end)
    check:SetScript('OnLeave', function() e.tips:Hide() end)

    local check2= CreateFrame("CheckButton", nil, panel, "InterfaceOptionsCheckButtonTemplate")--bar
    check2:SetPoint("TOPLEFT", check, 'BOTTOMLEFT')
    check2.text:SetText('Bar')
    check2:SetChecked(Save.bar)
    check2:SetScript('OnMouseDown', function()
        Save.bar= not Save.bar and true or nil
        print(id, addName, '|cnGREEN_FONT_COLOR:', e.onlyChinse and '需要重新加载' or REQUIRES_RELOAD)
    end)

    local check3= CreateFrame("CheckButton", nil, panel, "InterfaceOptionsCheckButtonTemplate")--bar，图片，样式2
    check3:SetPoint("LEFT", check2.text, 'RIGHT', 4, 0)
    check3.text:SetText((e.onlyChinse and '格式' or FORMATTING).. ' 2')
    check3:SetChecked(Save.barTexture2)
    check3:SetScript('OnMouseDown', function()
        Save.barTexture2= not Save.barTexture2 and true or nil
        --print(id, addName, '|cnGREEN_FONT_COLOR:', e.onlyChinse and '需要重新加载' or REQUIRES_RELOAD)
        for _, info in pairs(Tabs) do
            local frame= button[info.name]
            if frame and frame.bar then
                if Save.barTexture2 then
                    frame.bar:SetStatusBarTexture('Interface\\TargetingFrame\\UI-StatusBar')
                else
                    frame.bar:SetStatusBarTexture('UI-HUD-UnitFrame-Player-PortraitOn-Bar-Health-Status')
                end
            end
        end
    end)

    local function set_Size_panel()
        for _, info in pairs(Tabs) do
            local frame= button[info.name]
            if frame then
                set_Size(frame)--设置，大小
            end
        end
    end
    local slider= CreateFrame("Slider", nil, panel, 'OptionsSliderTemplate')--间隔，上下
    slider:SetPoint("TOPLEFT", check2, 'BOTTOMLEFT', 0,-12)
    --slider:SetOrientation('VERTICAL')--HORIZONTAL --slider.tooltipText=e.onlyChinse and '距离远近' or TRACKER_SORT_PROXIMITY
    slider:SetSize(200,20)
    slider:SetMinMaxValues(-5,10)
    slider:SetValue(Save.vertical)
    slider.Low:SetText('|T450907:0|t-5')
    slider.High:SetText('|T450905:0|t10')
    slider.Text:SetText(Save.vertical)
    slider:SetValueStep(0.1)
    slider:SetScript('OnValueChanged', function(self, value, userInput)
        value= tonumber(format('%.1f', value))
        self:SetValue(value)
        self.Text:SetText(value)
        Save.vertical=value
        set_Size_panel()
    end)

    local slider2= CreateFrame("Slider", nil, panel, 'OptionsSliderTemplate')--间隔，左右
    slider2:SetPoint("TOPLEFT", slider, 'BOTTOMLEFT', 0,-24)
    slider2:SetSize(200,20)
    slider2:SetMinMaxValues(0.1, 20)
    slider2:SetValue(Save.horizontal)
    slider2.Low:SetText('|T450908:0|t 0.1')
    slider2.High:SetText('|T450906:0|t 10')
    slider2.Text:SetText(Save.horizontal)
    slider2:SetValueStep(0.1)
    slider2:SetScript('OnValueChanged', function(self, value, userInput)
        value= tonumber(format('%.1f', value))
        self:SetValue(value)
        self.Text:SetText(value)
        Save.horizontal=value
        set_Size_panel()
    end)

    local slider3= CreateFrame("Slider", nil, panel, 'OptionsSliderTemplate')--文本，截取
    slider3:SetPoint("TOPLEFT", slider2, 'BOTTOMLEFT', 0,-24)
    slider3:SetSize(200,20)
    slider3:SetMinMaxValues(0, 20)
    slider3:SetValue(Save.gsubText or 0)
    slider3.Low:SetText(e.onlyChinse and '文本 0=否' or (LOCALE_TEXT_LABEL..' 0='..NO) )
    slider3.High:SetText((e.onlyChinse and '截取' or BINDING_NAME_SCREENSHOT).. ' 20')
    slider3.Text:SetText(Save.gsubText or '0')
    slider3:SetValueStep(1)
    slider3:SetScript('OnValueChanged', function(self, value, userInput)
        value= math.floor(value)
        self:SetValue(value)
        self.Text:SetText(value)
        Save.gsubText= value>0 and value or nil
        create_Rest_Lable()--初始， 或设置
    end)

    local slider4= CreateFrame("Slider", nil, panel, 'OptionsSliderTemplate')--缩放
    slider4:SetPoint("TOPLEFT", slider3, 'BOTTOMLEFT', 0,-24)
    slider4:SetSize(200,20)
    slider4:SetMinMaxValues(0.4, 3)
    slider4:SetValue(Save.scale or 1)
    slider4.Low:SetText((e.onlyChinse and '缩放' or UI_SCALE)..' 0.4')
    slider4.High:SetText('3')
    slider4.Text:SetText(Save.scale or 1)
    slider4:SetValueStep(0.1)
    slider4:SetScript('OnValueChanged', function(self, value, userInput)
        value= tonumber(format('%.1f', value))
        self:SetValue(value)
        self.Text:SetText(value)
        Save.scale=value
        set_Size_panel()
        button.frame:SetScale(value)
    end)
end

--####
--初始
--####
local function Init()
    --e.Cbtn= function(self, Template, value, SecureAction, name, notTexture, size)
    button= e.Cbtn(nil, nil, nil, nil, nil, true, {18,18})
    button.texture= button:CreateTexture()
    button.texture:SetSize(14,14)
    button.texture:SetPoint('CENTER')
    button.texture:SetAlpha(0.3)

    set_Point()--设置, 位置

    button:RegisterForDrag("RightButton")
    button:SetMovable(true)
    button:SetClampedToScreen(true)

    button:SetScript("OnDragStart", function(self,d )
        if d=='RightButton' and not IsModifierKeyDown() then
            self:StartMoving()
        end
    end)
    button:SetScript("OnDragStop", function(self)
        ResetCursor()
        self:StopMovingOrSizing()
        Save.point={self:GetPoint(1)}
        Save.point[2]=nil
    end)
    button:SetScript("OnMouseDown", function(self,d)
        if d=='LeftButton' then--提示移动
            create_Rest_Lable(true)--初始， 或设置
            print(id, addName, '|cnGREEN_FONT_COLOR:'..(e.onlyChinse and '重置' or RESET)..'|r', e.onlyChinse and '数值' or STATUS_TEXT_VALUE)

        elseif d=='RightButton' then
            if not IsModifierKeyDown() then--移动光标
                SetCursor('UI_MOVE_CURSOR')
                print(id, addName, e.onlyChinse and '还原位置' or RESET_POSITION, 'Alt+'..e.Icon.right)

            elseif IsAltKeyDown then
                Save.point=nil
                self:ClearAllPoints()
                set_Point()--设置, 位置
            end
        end
    end)
    button:SetScript('OnMouseWheel', function(self, d)
        if d==1 then
            Save.hide= true
        elseif d==-1 then
            Save.hide= nil
        end
        set_Show_Hide()--显示， 隐藏
    end)
    button:SetScript('OnEnter', function(self)
        e.tips:SetOwner(self, "ANCHOR_LEFT")
        e.tips:ClearLines()
        e.tips:AddDoubleLine(e.onlyChinse and '重置' or RESET, e.Icon.left)
        e.tips:AddLine(' ')
        e.tips:AddDoubleLine(e.onlyChinse and '移动' or NPE_MOVE, e.Icon.right)
        e.tips:AddDoubleLine(e.GetShowHide(not Save.hide), e.Icon.mid)
        --e.tips:AddDoubleLine((e.onlyChinse and '缩放' or UI_SCALE)..': '..(Save.scale or 1), '|cnGREEN_FONT_COLOR:Alt+'..e.Icon.mid)
        e.tips:AddLine(' ')
        e.tips:AddDoubleLine(id, addName)
        e.tips:Show()
    end)
    button:SetScript("OnMouseUp", function() ResetCursor() end)
    button:SetScript("OnLeave",function() ResetCursor() e.tips:Hide() end)

    C_Timer.After(2, function()
        button.frame= CreateFrame("Frame",nil,button)
        button.frame:SetPoint('BOTTOM')
        button.frame:SetSize(1,1)
        if Save.scale and Save.scale~=1 then--缩放
            button.frame:SetScale(Save.scale)
        end
        --button.frame:RegisterEvent('PLAYER_ENTERING_WORLD')
        button.frame:RegisterEvent('PLAYER_AVG_ITEM_LEVEL_UPDATE')
        button.frame:RegisterEvent('PLAYER_EQUIPMENT_CHANGED')
        button.frame:RegisterEvent('PLAYER_SPECIALIZATION_CHANGED')
        button.frame:RegisterEvent('PLAYER_TALENT_UPDATE')
        button.frame:RegisterEvent('CHALLENGE_MODE_START')
        button.frame:SetScript("OnEvent", function(self, event)
            if event=='PLAYER_SPECIALIZATION_CHANGED' then
                set_Tabs()--设置, 内容
                create_Rest_Lable(true)--初始， 或设置
            elseif event=='AVOIDANCE_UPDATE' or event=='LIFESTEAL_UPDATE' then
                create_Rest_Lable()--初始， 或设置
            else
                create_Rest_Lable(true)--初始， 或设置
            end
        end)
        set_Show_Hide()--显示， 隐藏
        set_Tabs()--设置, 内容
        create_Rest_Lable()--初始， 或设置
        set_Panle_Setting()--设置 panel
    end)

    local restButton=CreateFrame('Button', nil, panel, 'UIPanelButtonTemplate')--全部重
    restButton:SetText('|cnRED_FONT_COLOR:'..(e.onlyChinse and '重置' or RESET)..'|r')
    restButton:SetPoint("TOPRIGHT")
    restButton:SetSize(60, 28)
    restButton:SetScript('OnMouseUp', function()
        StaticPopupDialogs[id..addName..'restAllSetup']={
            text =id..'  '..addName..'|n|n|cnRED_FONT_COLOR:'..(e.onlyChinse and '清除全部' or CLEAR_ALL)..'|r '..(e.onlyChinse and '保存' or SAVE)..'|n|n'..(e.onlyChinse and '重新加载UI' or RELOADUI)..' /reload',
            button1 = '|cnRED_FONT_COLOR:'..(e.onlyChinse and '重置' or RESET),
            button2 = e.onlyChinse and '取消' or CANCEL,
            whileDead=true,timeout=30,hideOnEscape = 1,
            OnAccept=function(self)
                Save=nil
                ReloadUI()
            end,
        }
        StaticPopup_Show(id..addName..'restAllSetup')
    end)
end


panel:RegisterEvent("ADDON_LOADED")
panel:RegisterEvent('PET_BATTLE_OPENING_DONE')
panel:RegisterEvent('PET_BATTLE_CLOSE')

panel:SetScript("OnEvent", function(self, event, arg1)
    if event == "ADDON_LOADED" then
        if arg1==id then
            Save= WoWToolsSave and WoWToolsSave[addName] or Save
            Save.vertical= Save.vertical or 3
            Save.horizontal= Save.horizontal or 8
            --添加控制面板
            panel.name = (e.onlyChinse and '属性' or STAT_CATEGORY_ATTRIBUTES)..'|A:charactercreate-icon-customize-body-selected:0:0|a'--添加新控制面板
            panel.parent =id
            InterfaceOptions_AddCategory(panel)

            panel.check=CreateFrame("CheckButton", nil, panel, "InterfaceOptionsCheckButtonTemplate")
            panel.check:SetChecked(not Save.disabled)
            panel.check:SetPoint('TOPLEFT', panel, 'TOP')
            panel.check.text:SetText(e.onlyChinse and '启用' or ENABLE)
            panel.check:SetScript('OnMouseDown', function()
                Save.disabled = not Save.disabled and true or nil
                print(id, addName, e.GetEnabeleDisable(not Save.disabled), e.onlyChinse and '需求重新加载' or REQUIRES_RELOAD)
                if not Save.disabled and not button then
                    Init()
                end
            end)
            panel.check:SetScript('OnEnter', function(self2)
                e.tips:SetOwner(self2, "ANCHOR_LEFT")
                e.tips:ClearLines()
                e.tips:AddLine(e.onlyChinse and '启用/禁用' or ENABLE..'/'..DISABLE)
                e.tips:Show()
            end)
            panel.check:SetScript('OnLeave', function() e.tips:Hide() end)

            if Save.disabled then
                panel:UnregisterAllEvents()
            else
                Init()
            end
            panel:RegisterEvent("PLAYER_LOGOUT")
        end

    elseif event == "PLAYER_LOGOUT" then
        if not e.ClearAllSave then
            if not WoWToolsSave then WoWToolsSave={} end
            WoWToolsSave[addName]=Save
        end

    elseif event=='PET_BATTLE_OPENING_DONE' then
        button:SetShown(false)

    elseif event=='PET_BATTLE_CLOSE' then
        button:SetShown(true)

    end
end)