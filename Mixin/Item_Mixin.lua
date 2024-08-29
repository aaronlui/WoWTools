WoWTools_ItemMixin={}

function WoWTools_ItemMixin:GetTooltip(tab)
    local tooltipData

    local bag= tab.bag--bag, slot
    local guidBank= tab.guidBank--tab, slot
    local merchant= tab.merchant--slot
    local inventory= tab.inventory
    local hyperLink= tab.hyperLink
    local itemKey= tab.itemKey

    local itemID= tab.itemID
    local quality= tab.quality

    local index= tab.index--取得，指定行，内容 leftText

    local text= tab.text--{内容1, 内容2}，取得指定内容，行
    local onlyText= tab.onlyText--仅查指定内容

    local wow= tab.wow--是否战网绑定,还回 atlas
    local onlyWoW= tab.onlyWoW--仅查战网绑定

    local red= tab.red--是否有红色字体，一般指 不可用
    local onlyRed= tab.onlyRed--仅查红色

    if bag then
        if bag.bag and bag.slot then
            tooltipData= C_TooltipInfo.GetBagItem(bag.bag, bag.slot)
        end

    elseif guidBank then-- guidBank then
        if guidBank.tab and guidBank.slot then
            tooltipData= C_TooltipInfo.GetGuildBankItem(guidBank.tab, guidBank.slot)
        end

    elseif merchant then
        if merchant.slot then
            if merchant.buyBack then
                tooltipData= C_TooltipInfo.GetBuybackItem(merchant.slot)
            else
                tooltipData= C_TooltipInfo.GetMerchantItem(merchant.slot)--slot
            end
        end

    elseif inventory then
        tooltipData= C_TooltipInfo.GetInventoryItem('player', inventory)

    elseif hyperLink then
        tooltipData=  C_TooltipInfo.GetHyperlink(hyperLink)
    elseif itemID then
        if C_Heirloom.IsItemHeirloom(itemID) then
            tooltipData= C_TooltipInfo.GetHeirloomByItemID(itemID)
        else
            tooltipData= C_TooltipInfo.GetItemByID(itemID, quality)
        end
    elseif itemKey then
        tooltipData= C_TooltipInfo.GetItemKey(itemKey.itemID, itemKey.itemLevel, itemKey.itemSuffix, itemKey.requiredLevel)
    end
    local data={
        red=false,
        wow=false,
        text={},
        indexText=nil,
    }
    if not tooltipData or not tooltipData.lines then
        return data

    elseif index then
        if tooltipData.lines[index] then
            data.indexText= tooltipData.lines[index].leftText
        end
        return data
    end

    local numText= text and #text or 0
    local findText= numText>0 or wow
    local numFind=0
    for _, line in ipairs(tooltipData.lines) do--是否 TooltipUtil.SurfaceArgs(line)
        if red and not data.red then
            local leftHex=line.leftColor and line.leftColor:GenerateHexColor()
            local rightHex=line.rightColor and line.rightColor:GenerateHexColor()
            if leftHex == 'ffff2020' or leftHex=='fefe1f1f' then-- or hex=='fefe7f3f' then
                data.red= line.leftText
            elseif rightHex== 'ffff2020' or rightHex=='fefe1f1f' then
                data.red= line.rightText
            end
            if onlyRed and data.red then
                break
            end
        end
        if line.leftText and findText then
            if text then
                for _, t in pairs(text) do
                    if t and (line.leftText:find(t) or line.leftText==t) then
                        data.text[t]= line.leftText:match(t) or line.leftText
                        numFind= numFind +1
                        if onlyText and numFind==numText then
                            break
                        end
                    end
                end
            end
            if wow and not data.wow then
                if line.leftText==ITEM_ACCOUNTBOUND--战团绑定
                    or line.leftText==ITEM_BNETACCOUNTBOUND
                    or line.leftText==ITEM_BIND_TO_BNETACCOUNT
                    or line.leftText==ITEM_BIND_TO_ACCOUNT
                    or line.leftText==ITEM_BIND_TO_ACCOUNT_UNTIL_EQUIP--装备前战团绑定
                    or line.leftText==ITEM_ACCOUNTBOUND_UNTIL_EQUIP--装备前战团绑定
                then
                    data.wow='|A:questlog-questtypeicon-account:0:0:a'
                    if onlyWoW then
                        break
                    end
                end
            end
        end
    end
    return data
end
