local id, e = ...
local Save={
    --clickToMove= e.Player.husandro,--禁用, 点击移动
    clickToMoveButton= e.Player.husandro,--点击移动，按钮
}
local addName= PET_BATTLE_COMBAT_LOG


local TrackButton
local EnemyFrame--对方, 技能提示， 框











--#################
--宠物战斗界面收集数
--#################
local function set_PetBattleUnitFrame_UpdateDisplay(self)--Blizzard_PetBattleUI.lua
    local petOwner = self.petOwner
    local petIndex = self.petIndex
    local t
    if petOwner and petIndex then
        if C_PetBattles.IsWildBattle() and petIndex <= C_PetBattles.GetNumPets(petOwner) then
            local speciesID = C_PetBattles.GetPetSpeciesID(petOwner, petIndex)
            if speciesID then
                local CollectedNum, CollectedText= select(2, e.GetPetCollectedNum(speciesID))--总收集数量， 25 25 25， 已收集3/3
                t= CollectedNum or CollectedText
                local speed = C_PetBattles.GetSpeed(petOwner, petIndex)
                local power = C_PetBattles.GetPower(petOwner, petIndex)
                if speed and power then
                    t=t and t..'|n' or ''
                    t=t..power..'|n'..speed
                    --t=t..'|A:Soulbinds_Tree_Conduit_Icon_Attack:0:0|a'..power..'|n'..'|A:Soulbinds_Tree_Conduit_Icon_Utility:0:0|a'..speed
                end
            end
        end
    end
    if not self.text and t then
        self.text=e.Cstr(self, {justifyH='RIGHT'})--12 ,nil, nil, nil, nil, 'RIGHT')
        self.text:SetPoint('TOPRIGHT', self.Icon, 'TOPRIGHT', 6, 2)
    end
    if self.text then
        self.text:SetText(t or'')
    end
end













--###################
--宠物 frme 技能, 提示
--###################
local function set_PetBattleUnitTooltip_UpdateForUnit(self, petOwner, petIndex)
    if ( petOwner ~= Enum.BattlePetOwner.Ally and not C_PetBattles.IsPlayerNPC(petOwner) ) or Save.disabled then--Blizzard_PetBattleUI.lua
         return
    end
    for i=1, NUM_BATTLE_PET_ABILITIES do
        local abilityID,name, icon, maxCooldown, _, numTurns, petType= C_PetBattles.GetAbilityInfo(petOwner, petIndex, i);
        local abilityName = self["AbilityName"..i];
        if ( abilityID and name and abilityName ) then
            local t='';
            if type and PET_TYPE_SUFFIX[petType] then
                t=t..'|TInterface\\TargetingFrame\\PetBadge-'..PET_TYPE_SUFFIX[petType]..':0|t'
            end
            if icon then
                t=t..'|T'..icon..':0|t'
            end
            t=t..name..(numTurns and numTurns>0 and '|cnGREEN_FONT_COLOR:'..numTurns..'|r' or '')..(maxCooldown and maxCooldown>1 and '/|cnRED_FONT_COLOR:'..maxCooldown..'|r' or '')--' '..abilityID;

            abilityName:SetText(t);
        end
    end
end















--#############################
--显示当前宠物, 速度指示, 力量数据
--#############################
local function set_PetBattleFrame_UpdateSpeedIndicators(self)--Blizzard_PetBattleUIPetBattle-StatIconsI.lua
    local ally=self.ActiveAlly.PetType
    local enemy=self.ActiveEnemy.PetType

    local allyActive = C_PetBattles.GetActivePet(Enum.BattlePetOwner.Ally);
	local allySpeed = C_PetBattles.GetSpeed(Enum.BattlePetOwner.Ally, allyActive);
    local allyPower = C_PetBattles.GetPower(Enum.BattlePetOwner.Ally, allyActive)

    local enemyActive = C_PetBattles.GetActivePet(Enum.BattlePetOwner.Enemy);
	local enemySpeed = C_PetBattles.GetSpeed(Enum.BattlePetOwner.Enemy, enemyActive);
    local enemyPower = C_PetBattles.GetPower(Enum.BattlePetOwner.Enemy, enemyActive)

    if not ally.speed then
        ally.speed=ally:CreateTexture()
        ally.speed:SetTexture('Interface\\PetBattles\\PetBattle-StatIcons')
        ally.speed:SetSize(16,16)
        ally.speed:SetPoint('BOTTOMLEFT', ally, 'BOTTOMRIGHT' )
        ally.speed:SetTexCoord(0.0,0.5,0.5, 1.0)

        ally.power=ally:CreateTexture()
        ally.power:SetTexture('Interface\\PetBattles\\PetBattle-StatIcons')
        ally.power:SetSize(16,16)
        ally.power:SetPoint('BOTTOM', ally.speed , 'TOP' )
        ally.power:SetTexCoord(0.0, 0.5, 0.0, 0.5)
        ally.power.text=e.Cstr(self)
        ally.power.text:SetPoint('LEFT', ally.power, 'RIGHT')

        enemy.speed=enemy:CreateTexture()
        enemy.speed:SetTexture('Interface\\PetBattles\\PetBattle-StatIcons')
        enemy.speed:SetSize(16,16)
        enemy.speed:SetPoint('BOTTOMRIGHT', enemy, 'BOTTOMLEFT' )
        enemy.speed:SetTexCoord(0.0,0.5,0.5, 1.0)
        enemy.speed:SetRotation(60)

        enemy.power=enemy:CreateTexture()
        enemy.power:SetTexture('Interface\\PetBattles\\PetBattle-StatIcons')
        enemy.power:SetSize(16,16)
        enemy.power:SetPoint('BOTTOM', enemy.speed , 'TOP' )
        enemy.power:SetTexCoord(0.0, 0.5, 0.0, 0.5)
        enemy.power.text=e.Cstr(self)
        enemy.power.text:SetPoint('RIGHT', enemy.power, 'LEFT')
    end

    ally.speed:SetShown(allySpeed>=enemySpeed)
    enemy.speed:SetShown(enemySpeed>=allySpeed)
    ally.power.text:SetText(allyPower)
    enemy.power.text:SetText(enemyPower)

     C_Timer.After(2.5, function()
        if PetHasActionBar() and not UnitAffectingCombat('player') then--宠物动作条， 显示，隐藏
            PetActionBar:SetShown(false)
        end
    end)
end















--#################
--主面板,主技能, 提示
--#################
local function set_PetBattleAbilityButton_UpdateBetterIcon(self)
    local typeTexture, Cooldown, strongTexture, weakHintsTexture
    if self.BetterIcon then
        local activePet = C_PetBattles.GetActivePet(Enum.BattlePetOwner.Ally);
        if activePet then
            local _, _, _, maxCooldown, _, _, petType, noStrongWeakHints = C_PetBattles.GetAbilityInfo(Enum.BattlePetOwner.Ally, activePet, self:GetID());
            Cooldown=maxCooldown
            if petType and PET_TYPE_SUFFIX[petType] then
                typeTexture='Interface\\TargetingFrame\\PetBadge-'..PET_TYPE_SUFFIX[petType]--"Interface\\PetBattles\\PetIcon-"..PET_TYPE_SUFFIX[petType]
                if not noStrongWeakHints then
                    strongTexture, weakHintsTexture= e.GetPetStrongWeakHints(petType)--取得对战宠物, 强弱
                end
                if not self.petType then
                    self.strong= self:CreateTexture(nil, 'OVERLAY')
                    self.strong:SetPoint('TOPLEFT', self,-4, 2)
                    self.strong:SetSize(15,15)


                    self.up=self:CreateTexture(nil, 'OVERLAY')
                    self.up:SetPoint('TOP', self.strong,'BOTTOM',0, 4)
                    self.up:SetSize(10,10)
                    self.up:SetTexture('Interface\\PetBattles\\BattleBar-AbilityBadge-Strong')

                    
                  

                    self.petType= self:CreateTexture(nil, 'OVERLAY')
                    self.petType:SetPoint('LEFT', self, -4, 0)
                    self.petType:SetSize(15,15)

                    self.down=self:CreateTexture(nil, 'OVERLAY')
                    self.down:SetPoint('TOP', self.petType, 'BOTTOM', 0, 3)
                    self.down:SetSize(10,10)
                    self.down:SetTexture('Interface\\PetBattles\\BattleBar-AbilityBadge-Weak')


                    self.weakHints= self:CreateTexture(nil, 'OVERLAY')
                    self.weakHints:SetPoint('BOTTOMLEFT',-4,-2)
                    self.weakHints:SetSize(15,15)

                    self.text=e.Cstr(self, {color={r=1,g=0,b=0}, justifyH='RIGHT'})--nil, nil, nil,{1,0,0}, 'OVERLAY', 'RIGHT')
                    self.text:SetPoint('RIGHT',-6,-6)
                end
            end
        end
    end
    if self.petType then
        self.weakHints:SetTexture(weakHintsTexture or 0)
        self.petType:SetTexture(typeTexture or 0)
        self.strong:SetTexture(strongTexture or 0)
        self.up:SetShown(weakHintsTexture and typeTexture and strongTexture)
        self.down:SetShown(weakHintsTexture and typeTexture and strongTexture)
        self.text:SetText(Cooldown and Cooldown>0 and Cooldown or '')
        
    end
end













--########################
--对方, 我方， 技能提示， 框
--########################
--local EnemyFrame--对方, 技能提示， 框
local function set_PetBattleFrame_UpdateAllActionButtons(self)--Blizzard_PetBattleUI.lua
    if not EnemyFrame then
        EnemyFrame=CreateFrame('Frame', nil, PetBattleFrame.BottomFrame)
        function EnemyFrame:set_point()
            if Save.EnemyFramePoint then
                self:SetPoint(Save.EnemyFramePoint[1], UIParent, Save.EnemyFramePoint[3], Save.EnemyFramePoint[4], Save.EnemyFramePoint[5])
            else
                self:SetPoint('BOTTOMLEFT', PetBattleFrame.BottomFrame , 'TOPLEFT',60,250)
            end
        end
        EnemyFrame:set_point()

        EnemyFrame:SetSize(150, 50)
        EnemyFrame:SetClampedToScreen(true)
        EnemyFrame:SetMovable(true)
        EnemyFrame:RegisterForDrag('LeftButton', 'RightButton')
        EnemyFrame:SetScript('OnDragStart', function(self2,d) if not IsModifierKeyDown() then self2:StartMoving() end end)
        EnemyFrame:SetScript('OnDragStop', function(self2)
            ResetCursor();
            self2:StopMovingOrSizing();
            Save.EnemyFramePoint={self2:GetPoint(1)}
            Save.EnemyFramePoint[2]=nil
            print(id, addName,'Alt+' ..e.Icon.right,TRANSMOGRIFY_TOOLTIP_REVERT)
            self2:Raise()
        end)
        EnemyFrame:SetScript('OnMouseDown', function(self2, d)
            if d=='RightButton' and IsAltKeyDown() then
                Save.EnemyFramePoint=nil
                self2:ClearAllPoints()
                self2:SetPoint('BOTTOMLEFT', PetBattleFrame.BottomFrame , 'TOPLEFT',40,40)
            else
                SetCursor('UI_MOVE_CURSOR')
            end
        end)
        EnemyFrame:SetScript('OnMouseUp', function() ResetCursor() end)
        EnemyFrame:SetScript('OnEnter', function(self2)
            e.tips:SetOwner(self2, "ANCHOR_LEFT")
            e.tips:ClearLines()
            e.tips:AddDoubleLine(id, addName)
            e.tips:AddLine(' ')
            e.tips:AddDoubleLine(NPE_MOVE, e.Icon.left)
            e.tips:Show()
            self2.textrue:SetAlpha(1)
        end)
        EnemyFrame:SetScript('OnLeave', function(self2)
            e.tips:Hide()
            self2.textrue:SetAlpha(0.5)
        end)
        EnemyFrame.textrue=EnemyFrame:CreateTexture(nil, 'BACKGROUND')
        EnemyFrame.textrue:SetAllPoints(EnemyFrame)
        EnemyFrame.textrue:SetAtlas('Adventures-Missions-Shadow')
        EnemyFrame.textrue:SetAlpha(0.5)

        for index=1, NUM_BATTLE_PETS_IN_BATTLE +2 do
            local frame
            local allyIndex
            if index==1 then
                frame=EnemyFrame
            elseif index<=NUM_BATTLE_PETS_IN_BATTLE then
                frame=PetBattleFrame['Enemy'..index]
            else
                allyIndex=(index-NUM_BATTLE_PETS_IN_BATTLE)+1
                frame=PetBattleFrame['Ally'..allyIndex]
            end
            for i = 1, NUM_BATTLE_PET_ABILITIES do
                if frame and not frame[i] then
                    frame[i]=e.Cbtn(frame, {icon='hide', size={40,40}})--nil, true)
                    frame[i]:SetSize(40,40)
                    if i==1 then
                        if index==1 then
                            frame[i]:SetPoint('LEFT',5, 0)
                        else
                            if allyIndex then
                                frame[i]:SetPoint('RIGHT', frame, 'LEFT',-20,0)
                            else
                                frame[i]:SetPoint('LEFT', frame, 'RIGHT',20,0)
                            end
                        end
                    else
                        if allyIndex then
                            frame[i]:SetPoint('RIGHT', frame[i-1], 'LEFT', -5, 0)
                        else
                            frame[i]:SetPoint('LEFT', frame[i-1], 'RIGHT', 5, 0)
                        end
                    end
                    frame[i]:SetScript('OnEnter', function(self2)
                        if self2.abilityID then
                            --if ( self2.requiredLevel ) then
                              --  PetBattleAbilityTooltip_SetAbilityByID(self2.petOwner, self2.petIndex, self2.abilityID, format(PET_ABILITY_REQUIRES_LEVEL, self2.requiredLevel));
                            PetBattleAbilityTooltip_SetAbilityByID(self2.petOwner, self2.petIndex, self2.abilityID);
                            
                            PetBattleAbilityTooltip_Show("BOTTOMLEFT", self2, "TOPLEFT");
                        end
                    end)
                    frame[i]:SetScript('OnLeave', function() PetBattlePrimaryAbilityTooltip:Hide() end)

                    frame[i].icon= frame[i]:CreateTexture(nil,'BACKGROUND')
                    frame[i].icon:SetAllPoints(frame[i])

                    frame[i].storngORweak=frame[i]:CreateTexture(nil,'BORDER')
                    frame[i].storngORweak:SetPoint('BOTTOMRIGHT', 10, -10)
                    frame[i].storngORweak:SetSize(30,30)

                    frame[i].strong=frame[i]:CreateTexture(nil,'BORDER')
                    frame[i].strong:SetPoint('TOPLEFT', -4, 2)
                    frame[i].strong:SetSize(15,15)

                    frame[i].up=frame[i]:CreateTexture(nil,'ARTWORK')
                    frame[i].up:SetPoint('TOP', frame[i].strong,'BOTTOM',0, 5)
                    frame[i].up:SetSize(8,8)
                    frame[i].up:SetTexture('Interface\\PetBattles\\BattleBar-AbilityBadge-Strong')

                    
                    frame[i].petTypeTexture=frame[i]:CreateTexture(nil,'BORDER', nil, 1)
                    frame[i].petTypeTexture:SetPoint('LEFT', -4, 0)
                    frame[i].petTypeTexture:SetSize(15,15)

                    frame[i].down=frame[i]:CreateTexture(nil,'ARTWORK')
                    frame[i].down:SetPoint('TOP', frame[i].petTypeTexture,'BOTTOM',0,5)
                    frame[i].down:SetSize(8,8)
                    frame[i].down:SetTexture('Interface\\PetBattles\\BattleBar-AbilityBadge-Weak')

                    frame[i].weakHints=frame[i]:CreateTexture(nil,'BORDER')
                    frame[i].weakHints:SetPoint('BOTTOMLEFT', -4, -2)
                    frame[i].weakHints:SetSize(15,15)
                end
            end
        end
    end


    --local activeEnemy = C_PetBattles.GetActivePet(target);
    for index=1, NUM_BATTLE_PETS_IN_BATTLE +2 do
        local frame,petIndex
        local allyIndex,target= nil, Enum.BattlePetOwner.Enemy
        if index==1 then
            frame=EnemyFrame
            petIndex=C_PetBattles.GetActivePet(target)
        elseif index<=NUM_BATTLE_PETS_IN_BATTLE then
            frame=PetBattleFrame['Enemy'..index]
            petIndex=frame.petIndex
        else
            allyIndex=(index-NUM_BATTLE_PETS_IN_BATTLE)+1
            frame=PetBattleFrame['Ally'..allyIndex]
            target=Enum.BattlePetOwner.Ally
            petIndex=frame.petIndex
        end

        for i = 1, NUM_BATTLE_PET_ABILITIES do
            local abilityID, _, icon, _, _, _, petType, noStrongWeakHints = C_PetBattles.GetAbilityInfo(target, petIndex, i);
            
            if abilityID and icon and petType then
                --local speciesID = C_PetBattles.GetPetSpeciesID(target, petIndex)
                --local abilities = speciesID and C_PetJournal.GetPetAbilityListTable(speciesID)
                frame[i].abilityID=abilityID
                frame[i].petOwner=target
                frame[i].petIndex=petIndex--提示用

                frame[i].icon:SetTexture(icon)--设置图标
                frame[i].petTypeTexture:SetTexture('Interface\\TargetingFrame\\PetBadge-'..PET_TYPE_SUFFIX[petType])--设置类型
                
                local strong, weakhints
                if not noStrongWeakHints then
                    strong, weakhints= e.GetPetStrongWeakHints(petType)
                end
                frame[i].strong:SetTexture(strong or 0)
                frame[i].weakHints:SetTexture(weakhints or 0)


                local target2= target==Enum.BattlePetOwner.Ally and Enum.BattlePetOwner.Enemy or Enum.BattlePetOwner.Ally
                local texture
                if abilityID and icon and petType and not noStrongWeakHints then
                    local playerPetSlot = C_PetBattles.GetActivePet(target2);
                    local playerType = playerPetSlot and C_PetBattles.GetPetType(target2, playerPetSlot);
                    local modifier = playerType and C_PetBattles.GetAttackModifier(petType, playerType);
                    if modifier then
                        if (modifier > 1) then
                            texture= "Interface\\PetBattles\\BattleBar-AbilityBadge-Strong"
                        elseif (modifier < 1) then
                            texture="Interface\\PetBattles\\BattleBar-AbilityBadge-Weak"
                        end
                    end
                end
                frame[i].storngORweak:SetTexture(texture or 0)

                frame[i].up:SetShown(not noStrongWeakHints)
                frame[i].down:SetShown(not noStrongWeakHints)

                frame[i]:SetShown(true)
            else
                frame[i]:SetShown(false)
            end
        end
    end
end

--对方，技能， 冷却
local function set_PetBattleActionButton_UpdateState()
    if not EnemyFrame then
        return
    end
    local activeEnemy = C_PetBattles.GetActivePet(Enum.BattlePetOwner.Enemy);
    for i = 1, NUM_BATTLE_PET_ABILITIES do
        local frame= EnemyFrame--PetBattleFrame.BottomFrame.EnemyFrame
        if frame and frame[i] then
            local text, isUsable, currentCooldown, currentLockdown
            local abilityID, name = C_PetBattles.GetAbilityInfo(Enum.BattlePetOwner.Enemy, activeEnemy, i);
            if name and abilityID then
                isUsable, currentCooldown, currentLockdown = C_PetBattles.GetAbilityState(Enum.BattlePetOwner.Enemy, activeEnemy, i)
                
                if currentCooldown and currentCooldown>0 then
                    text=currentCooldown
                elseif currentLockdown and currentCooldown>0 then
                    text= currentLockdown
                end
                
            end
            if text and not frame[i].cooldownText then
                frame[i].cooldownText=e.Cstr(frame[i], {size=22, color={r=1,g=0,b=0}})
                frame[i].cooldownText:SetPoint('CENTER')
                text=currentCooldown
            end
            if frame[i].cooldownText then
                frame[i].cooldownText:SetText(text or '')
            end
            frame[i].icon:SetDesaturated(not isUsable)
            
            if currentCooldown and currentCooldown>0 then        
                frame[i].icon:SetVertexColor(0.62, 0.62, 0.62)
            elseif currentLockdown and currentLockdown>0 then
                frame[i].icon:SetVertexColor(1, 0, 0)
            else
                frame[i].icon:SetVertexColor(1, 1, 1)
            end
        end
    end
end











--#####################
--宠物， 类型，强弱，提示
--#####################
local function get_Strong_WeakHints(petType, strong)
    for i=1, C_PetJournal.GetNumPetTypes() do
        local modifier = C_PetBattles.GetAttackModifier(petType, i);
        if modifier then
            if strong then
                if modifier > 1  then
                    return 'Interface\\TargetingFrame\\PetBadge-'..PET_TYPE_SUFFIX[i], i--"Interface\\PetBattles\\PetIcon-"..PET_TYPE_SUFFIX[i]
                end
            else
                if modifier < 1 then
                    return 'Interface\\TargetingFrame\\PetBadge-'..PET_TYPE_SUFFIX[i], i
                end
            end
        end
    end
end
local PetTypeAbility={
    [1]=238,
    [2]=245,
    [3]=239,
    [4]=424,
    [5]=236,
    [6]=243,
    [7]=241,
    [8]=237,
    [9]=240,
    [10]=244,
}
local function show_FloatingPetBattleAbilityTooltip(frame)
    frame:SetScript('OnMouseDown', function(self)
        if self.typeID then
            SetCollectionsJournalShown(true, 2)
            --C_PetJournal.SetFilterChecked(LE_PET_JOURNAL_FILTER_COLLECTED, true)
            for index=1,C_PetJournal.GetNumPetTypes() do
                C_PetJournal.SetPetTypeFilter(index, index==self.typeID)
            end
        end
    end)
    frame:SetScript('OnEnter', function(self)
        if self.abilityID then
            FloatingPetBattleAbilityTooltip:ClearAllPoints()
            FloatingPetBattleAbilityTooltip:SetPoint("BOTTOMRIGHT", self, "TOPLEFT");
            FloatingPetBattleAbility_Show(self.abilityID)
        end
    end)
    frame:SetScript('OnLeave', function()
        FloatingPetBattleAbilityTooltip:Hide()
    end)
end


local function set_Pet_Type(show)--提示,类型,
    TrackButton:SetShown(show)--提示,类型,
    if TrackButton.setFrame or not show or Save.setFrameHide then
        if TrackButton.setFrame then
            TrackButton.setFrame:SetShown(not Save.setFrameHide)
        end
        return
    end


    TrackButton.setFrame=CreateFrame("Frame", nil, TrackButton)
    TrackButton.setFrame:SetSize(1,1)
    TrackButton.setFrame:SetPoint('RIGHT')

    local last=TrackButton.setFrame
    for i=1, C_PetJournal.GetNumPetTypes() do
        local texture= e.Cbtn(TrackButton.setFrame, {icon='hide',size={25,25}, pushe=true})
        texture:SetSize(25, 25)
        texture:SetPoint('LEFT', last, 'RIGHT')
        texture:SetNormalTexture('Interface\\TargetingFrame\\PetBadge-'..PET_TYPE_SUFFIX[i])
        texture.abilityID= PetTypeAbility[i]
        texture.typeID=i
        texture:EnableMouse(true)
        show_FloatingPetBattleAbilityTooltip(texture)

        local strong, index=get_Strong_WeakHints(i, true)--强
        if strong then
            texture.indicatoUp=TrackButton.setFrame:CreateTexture()
            texture.indicatoUp:SetAtlas('bags-greenarrow')
            texture.indicatoUp:SetSize(10,10)
            texture.indicatoUp:SetPoint('BOTTOM', texture,'TOP')

            texture.strong= e.Cbtn(TrackButton.setFrame, {icon='hide',size={25,25}, pushe=true})
            texture.strong:SetPoint('BOTTOM', texture.indicatoUp, 'TOP')
            texture.strong:SetNormalTexture(strong)
            texture.strong.abilityID= PetTypeAbility[index]
            texture.strong.typeID=index
            texture.strong:EnableMouse(true)
            show_FloatingPetBattleAbilityTooltip(texture.strong)
        end
        local weakHints, index2=get_Strong_WeakHints(i)--弱
        if weakHints then
            texture.indicatoDown=TrackButton.setFrame:CreateTexture()
            texture.indicatoDown:SetAtlas('UI-HUD-MicroMenu-StreamDLRed-Up')
            texture.indicatoDown:SetSize(10,10)
            texture.indicatoDown:SetPoint('TOP', texture,'BOTTOM')

            texture.weakHints= e.Cbtn(TrackButton.setFrame, {icon='hide', size={25,25}, pushe=true})
            texture.weakHints:SetPoint('TOP', texture.indicatoDown, 'BOTTOM')
            texture.weakHints:SetNormalTexture(weakHints)
            texture.weakHints.abilityID= PetTypeAbility[index2]
            texture.weakHints.typeID=index2
            texture.weakHints:EnableMouse(true)
            show_FloatingPetBattleAbilityTooltip(texture.weakHints)
        end

        last=texture
    end
   
end





















--宠物手册，增加按钮
local function set_Button_setFrame_PetJournal()
    if not TrackButton then
        return
    end
    TrackButton.btn= e.Cbtn(RematchJournal or PetJournal, {icon='hide', size={22, 22}})
    if _G['MoveZoomInButtonPerCollectionsJournal'] then
        TrackButton.btn:SetPoint('LEFT', _G['MoveZoomInButtonPerCollectionsJournal'], 'RIGHT')
    else
        TrackButton.btn:SetPoint('TOPLEFT', RematchJournal or PetJournal,'TOPRIGHT',3,-29)
    end
    TrackButton.btn:SetAlpha(0.5)
    TrackButton.btn:SetFrameLevel(CollectionsJournal.TitleContainer:GetFrameLevel()+1)
    TrackButton.btn:SetScript('OnClick', function(self)
        if TrackButton.setFrame then
            set_Pet_Type(not TrackButton:IsShown() and true or false)
        else
            set_Pet_Type(true)

        end
        self:set_texture()
    end)
    
    TrackButton.btn:SetScript('OnEnter', function(self)
        e.tips:SetOwner(self, "ANCHOR_LEFT")
        e.tips:ClearLines()
        e.tips:AddDoubleLine(e.onlyChinese and '宠物类型' or PET_FAMILIES, e.Icon.left)
        e.tips:AddLine(' ')
        e.tips:AddDoubleLine(id, addName)
        e.tips:Show()
        self:SetAlpha(1)
    end)
    TrackButton.btn:SetScript('OnLeave', function(self) e.tips:Hide() self:SetAlpha(0.5) end)
    function TrackButton.btn:set_texture()
        local show= TrackButton:IsShown()
        self:SetNormalAtlas(show and e.Icon.icon or 'talents-button-reset')
    end
end



















--########
--点击移动
--########
local function set_Click_To_Move()
    TrackButton:UnregisterEvent('PLAYER_LEVEL_UP')
    if not Save.clickToMove or Save.disabled then
        return
    end
    local value= C_CVar.GetCVarBool("autoInteract")
    if e.Player.levelMax then
        if not value then
            C_CVar.SetCVar("autoInteract", '1')
            print(id, addName, e.onlyChinese and '点击移动' or CLICK_TO_MOVE, e.GetEnabeleDisable(C_CVar.GetCVarBool("autoInteract")))
        end
    else
        if value then
            C_CVar.SetCVar("autoInteract", '0')
            print(id, addName, e.onlyChinese and '点击移动' or CLICK_TO_MOVE, e.GetEnabeleDisable(C_CVar.GetCVarBool("autoInteract")))
        end
        TrackButton:RegisterEvent('PLAYER_LEVEL_UP')
    end
end

local function add_Click_To_Move_Button()--点击移动，按钮
    local btn=PlayerFrame.ClickToMoveButton
    if not Save.clickToMoveButton then
        if btn then
            btn:UnregisterAllEvents()
            btn:SetShown(false)
        end
        return
    end

    if not btn then
        btn= e.Cbtn2({
            name=nil,
            parent=PlayerFrame,
            click=true,-- right left
            notSecureActionButton=true,
            notTexture=nil,
            showTexture=true,
            sizi=20,
            alpha=1,
        })
        btn:SetPoint('RIGHT', PlayerFrame.PlayerFrameContainer.PlayerPortrait, 'LEFT', 2,-8)
        btn:Raise()
        btn:SetSize(20,20)
        btn:SetNormalAtlas('transmog-nav-slot-feet')
        btn:SetScript('OnClick', function(self, d)
            if d=='LeftButton' then
                if not UnitAffectingCombat('player') then
                    C_CVar.SetCVar("autoInteract", C_CVar.GetCVarBool("autoInteract") and '0' or '1')
                    self:set_Tooltips()
                end
            else
                e.OpenPanelOpting('|A:transmog-nav-slot-feet:0:0|a'..(e.onlyChinese and '添加按钮' or format(CLUB_FINDER_LOOKING_FOR_CLASS_SPEC, ADD, 'Button')))
            end
        end)
        function btn:set_State()
            if C_CVar.GetCVarBool("autoInteract") then
                self:UnlockHighlight()
                self:SetAlpha(0.3)
            else
                self:LockHighlight()
                self:SetAlpha(1)
            end
        end
        btn:SetScript('OnEvent', function(self, _, arg1)
            if arg1=='autoInteract' then
                self:set_State()
            end
        end)
        function btn:set_Tooltips()
            e.tips:SetOwner(self, "ANCHOR_LEFT")
            e.tips:ClearLines()
            e.tips:AddDoubleLine(id, addName)
            e.tips:AddLine(' ')
            e.tips:AddDoubleLine((UnitAffectingCombat('player') and '|cff606060' or '')..(e.onlyChinese and '点击移动' or CLICK_TO_MOVE)..': '..e.GetEnabeleDisable(C_CVar.GetCVarBool("autoInteract")), e.Icon.left)
            e.tips:AddDoubleLine(e.onlyChinese and '选项' or OPTIONS, e.Icon.right)
            e.tips:AddLine(' ')
            e.tips:AddLine(e.Get_CVar_Tooltips({name='autoInteract'}))
            e.tips:Show()
            self:SetAlpha(1)
        end
        btn:SetScript('OnLeave', function(self) e.tips:Hide() self:set_State() end)
        btn:SetScript('OnEnter', btn.set_Tooltips)
        btn:SetScript('OnMouseUp', btn.set_Tooltips)

        PlayerFrame.ClickToMoveButton= btn
    end
    btn:set_State()
    btn:RegisterEvent('CVAR_UPDATE')
    btn:SetShown(true)
end














--####
--初始
--####
local function Init()
    TrackButton= e.Cbtn(nil, {icon=true, size={20,20}, pushe=true})


    TrackButton:SetFrameStrata('DIALOG')
    TrackButton:RegisterForDrag("RightButton")
    TrackButton:SetMovable(true)
    TrackButton:SetClampedToScreen(true)

    TrackButton:SetScript("OnDragStart", function(self)
        self:StartMoving()
    end)
    TrackButton:SetScript("OnDragStop", function(self)
        ResetCursor()
        self:StopMovingOrSizing()
        Save.point={self:GetPoint(1)}
        Save.point[2]=nil
        self:Raise()
    end)
    TrackButton:SetScript("OnMouseUp", ResetCursor)
    TrackButton:SetScript("OnMouseDown", function(_, d)
        if d=='RightButton' then
            SetCursor('UI_MOVE_CURSOR')
        end
    end)
    TrackButton:SetScript("OnClick", function(self, d)
        if d=='LeftButton' then--显示，隐藏
            Save.setFrameHide= not Save.setFrameHide and true or nil
            self:set_texture()
            set_Pet_Type(true)
        end
    end)

    TrackButton:SetScript('OnMouseWheel',function(_, d)--打开，宠物手册
        if d==1 then
            if not PetJournal or not PetJournal:IsVisible() then
                ToggleCollectionsJournal(2)
            end
        elseif d==-1 then
            if PetJournal and PetJournal:IsVisible() then
                ToggleCollectionsJournal(2)
            end
        end
        --SetCollectionsJournalShown(true, 2)--UIParent.lua
    end)

    TrackButton:SetScript('OnLeave', GameTooltip_Hide)
    TrackButton:SetScript('OnEnter', function(self)
        e.tips:SetOwner(self, "ANCHOR_LEFT")
        e.tips:ClearLines()
        e.tips:AddDoubleLine(e.onlyChinese and '显示/隐藏' or SHOW..'/'..HIDE, e.Icon.left)
        e.tips:AddDoubleLine(e.onlyChinese and '宠物手册' or PET_JOURNAL, e.Icon.mid)
        e.tips:AddDoubleLine(e.onlyChinese and '移动' or NPE_MOVE, e.Icon.right)
        if not C_AddOns.IsAddOnLoaded('Rematch') then
            e.tips:AddDoubleLine(e.Icon.left..(e.onlyChinese and '图标' or EMBLEM_SYMBOL), e.onlyChinese and '过滤器: 宠物类型' or FILTER..": "..PET_FAMILIES)
        end
        e.tips:AddLine(' ')
        e.tips:AddDoubleLine(id, addName)
        e.tips:Show()
    end)



    TrackButton:RegisterEvent('PET_BATTLE_OPENING_DONE')--显示，隐藏
    TrackButton:RegisterEvent('PET_BATTLE_CLOSE')
    TrackButton:SetScript('OnEvent', function(_, event)
        if event== 'PLAYER_LEVEL_UP' then
            C_Timer.After(2, set_Click_To_Move)

        else--PET_BATTLE_OPENING_DONE PET_BATTLE_CLOSE
            set_Pet_Type(C_PetBattles.IsInBattle())

            if event=='PET_BATTLE_CLOSE' then
                if PetHasActionBar() and not UnitAffectingCombat('player') then--宠物动作条， 显示，隐藏
                    PetActionBar:SetShown(true)
                end
                if not UnitAffectingCombat('player') then--UIParent.lua
                    local duration = select(2, GetSpellCooldown(125439))
                    if duration and duration<=2  or not duration then
                        if (CollectionsJournal and not PetJournal:IsVisible()) or not CollectionsJournal then
                            ToggleCollectionsJournal(2)
                        end
                    end
                end
            end
        end
    end)

    TrackButton:SetScript("OnShow", function(self)
        if self.btn then
            self.btn:set_texture()--宠物手册，增加按钮
        end
    end)
    TrackButton:SetScript("OnHide", function(self)
        if self.btn then
            self.btn:set_texture()--宠物手册，增加按钮
        end
    end)

    function TrackButton:set_texture()
        self:SetNormalAtlas(Save.setFrameHide and 'talents-button-reset' or e.Icon.icon)
        self:SetAlpha(Save.setFrameHide and 0.5 or 1)
    end
    function TrackButton:set_point()
        if Save.point then
            self:SetPoint(Save.point[1],UIParent, Save.point[3], Save.point[4], Save.point[5])
        else
            self:SetPoint('RIGHT',-400, 200)
        end
    end

    TrackButton:set_point()
    TrackButton:set_texture()

    --宠物战斗界面收集数
    hooksecurefunc('PetBattleUnitFrame_UpdateDisplay',set_PetBattleUnitFrame_UpdateDisplay)

    --宠物 frme 技能, 提示
    hooksecurefunc('PetBattleUnitTooltip_UpdateForUnit', set_PetBattleUnitTooltip_UpdateForUnit)

    --显示当前宠物, 速度指示, 力量数据
    hooksecurefunc('PetBattleFrame_UpdateSpeedIndicators', set_PetBattleFrame_UpdateSpeedIndicators)

    --主面板,主技能, 提示
    hooksecurefunc('PetBattleAbilityButton_UpdateBetterIcon', set_PetBattleAbilityButton_UpdateBetterIcon)

    --对方, 我方， 技能提示， 框
    hooksecurefunc('PetBattleFrame_UpdateAllActionButtons', set_PetBattleFrame_UpdateAllActionButtons)

    --对方，技能， 冷却
    hooksecurefunc('PetBattleActionButton_UpdateState', set_PetBattleActionButton_UpdateState)

    set_Pet_Type(C_PetBattles.IsInBattle())

    --隐藏, 宠物, 动作条
    --[[hooksecurefunc(MainMenuBarVehicleLeaveButtonMixin,'Update', function(self)--MainMenuBar.lua
        if C_PetBattles.IsInBattle() and PetHasActionBar() then
			PetActionBar:SetShown(false)
		end
    end)]]

    add_Click_To_Move_Button()--点击移动，按钮
end













--###########
--加载保存数据
--###########
local panel= CreateFrame('Frame')
panel:RegisterEvent("ADDON_LOADED")
panel:RegisterEvent("PLAYER_LOGOUT")

panel:SetScript("OnEvent", function(_, event, arg1)
    if event == "ADDON_LOADED" then
        if arg1==id then
            Save= WoWToolsSave[addName] or Save

            --添加控制面板
            --[[local initializer2= e.AddPanel_Check({
                name= '|A:WildBattlePetCapturable:0:0|a'..(e.onlyChinese and '宠物对战' or addName),
                tooltip= addName,
                value= not Save.disabled,
                func= function()
                    Save.disabled= not Save.disabled and true or nil
                    print(id, addName, e.GetEnabeleDisable(not Save.disabled), e.onlyChinese and '重新加载UI' or RELOADUI)
                end
            })]]

            --添加控制面板
            local initializer2= e.AddPanel_Check_Button({
                checkName= '|A:WildBattlePetCapturable:0:0|a'..(e.onlyChinese and '宠物对战' or addName),
                checkValue= not Save.disabled,
                checkFunc= function()
                    Save.disabled= not Save.disabled and true or nil
                    print(id, addName, e.GetEnabeleDisable(not Save.disabled), e.onlyChinese and '重新加载UI' or RELOADUI)
                end,
                buttonText= e.onlyChinese and '重置位置' or RESET_POSITION,
                buttonFunc= function()
                    Save.point=nil
                    if TrackButton then
                        TrackButton:ClearAllPoints()
                        TrackButton:set_point()
                    end
                    Save.EnemyFramePoint=nil--对方, 技能提示， 框
                    if EnemyFrame then
                        EnemyFrame:set_point()
                    end
                    print(id, addName, e.onlyChinese and '重置位置' or RESET_POSITION)
                end,
                tooltip= addName,
                layout= nil,
                category= nil,
            })

            local initializer= e.AddPanel_Check({
                name= e.Icon.right..(e.onlyChinese and '点击移动' or CLICK_TO_MOVE),
                tooltip= (not e.onlyChinese and CLICK_TO_MOVE..', '..REFORGE_CURRENT or '点击移动, 当前: ')..e.GetEnabeleDisable(C_CVar.GetCVarBool("autoInteract"))
                    ..'|n'..(e.onlyChinese and '等级' or LEVEL)..' < '..MAX_PLAYER_LEVEL..'  '..e.GetEnabeleDisable(false)
                    ..'|n'..(e.onlyChinese and '等级' or LEVEL)..' = '..MAX_PLAYER_LEVEL..'  '..e.GetEnabeleDisable(true),
                value= Save.clickToMove,
                func= function()
                    Save.clickToMove = not Save.clickToMove and true or nil
                    set_Click_To_Move()
                end
            })
            
            initializer:SetParentInitializer(initializer2, function() return not Save.disabled and TrackButton end)

            initializer= e.AddPanel_Check({
                name= '|A:transmog-nav-slot-feet:0:0|a'..(e.onlyChinese and '添加按钮' or format(CLUB_FINDER_LOOKING_FOR_CLASS_SPEC, ADD, 'Button')),
                tooltip= e.onlyChinese and '位置：玩家框体' or format(CLUB_FINDER_LOOKING_FOR_CLASS_SPEC, CHOOSE_LOCATION:gsub(CHOOSE, '')..': ', HUD_EDIT_MODE_PLAYER_FRAME_LABEL),
                value= Save.clickToMoveButton,
                func= function()
                    Save.clickToMoveButton = not Save.clickToMoveButton and true or nil
                    add_Click_To_Move_Button()
                end
            })
            initializer:SetParentInitializer(initializer2, function() return not Save.disabled end)

            
            if Save.disabled then
                panel:UnregisterEvent('ADDON_LOADED')
            else
                Init()
                add_Click_To_Move_Button()--点击移动，按钮
                set_Click_To_Move()
            end
        elseif arg1=='Blizzard_Collections' then
            set_Button_setFrame_PetJournal()--宠物手册，增加按钮
        end

    elseif event == "PLAYER_LOGOUT" then
        if not e.ClearAllSave then
            WoWToolsSave[addName]=Save
        end
    end
end)