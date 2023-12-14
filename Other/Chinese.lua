local id, e= ...
if LOCALE_zhCN or LOCALE_zhTW then
    return
end


local addName= BUG_CATEGORY15
local Save={
    disabled= not e.Player.husandro
}
local panel= CreateFrame("Frame")



local function set(self, text)
    if not self or not text or self:IsForbidden() then--CanAccessObject(self) then
        if e.Player.husandro and self:IsForbidden() then
            print(id, addName, self:IsForbidden() and '危险，出错', text)
        end
        return
    end
    self:SetText(text)
end



local function Init()
    --角色
    set(CharacterFrameTab1, '角色')
    set(CharacterFrameTab2, '声望')
    set(CharacterFrameTab3, '货币')
    set(CharacterStatsPane.ItemLevelCategory.Title, '物品等级')
    set(CharacterStatsPane.AttributesCategory.Title, '属性')
    set(CharacterStatsPane.EnhancementsCategory.Title, '强化属性')

    set(PaperDollFrameEquipSetText, '装备')
    set(PaperDollFrameSaveSetText , '保存')

    set(GearManagerPopupFrame.BorderBox.EditBoxHeaderText, '输入方案名称（最多16个字符）：')
    set(GearManagerPopupFrame.BorderBox.IconSelectionText, '选择一个图标：')
    set(GearManagerPopupFrame.BorderBox.OkayButton, '确认')
    set(GearManagerPopupFrame.BorderBox.CancelButton, '取消')
    GearManagerPopupFrame:HookScript('OnShow', function(self)
        set(self.BorderBox.SelectedIconArea.SelectedIconText.SelectedIconHeader, '当前已选择')
        set(self.BorderBox.SelectedIconArea.SelectedIconText.SelectedIconDescription, '点击在列表中浏览')
    end)

    --法术
    set(SpellBookFrameTabButton1, '法术')
    set(SpellBookFrameTabButton2, '专业')
    set(SpellBookFrameTabButton3, '宠物')
end


local function Init_Loaded(arg1)
    if arg1=='Blizzard_AuctionHouseUI' then
        local strText={
            [AUCTION_CATEGORY_WEAPONS] = "武器",
                [AUCTION_SUBCATEGORY_ONE_HANDED] = "单手",
                    [GetItemSubClassInfo(2, 0)]= "单手斧",
                    [GetItemSubClassInfo(2, 4)]= "单手锤",
                    [GetItemSubClassInfo(2, 7)]= "单手剑",
                    [GetItemSubClassInfo(2, 9)]= "战刃",
                    [GetItemSubClassInfo(2, 15)]= "匕首",
                    [GetItemSubClassInfo(2, 13)]= "拳套",
                    [GetItemSubClassInfo(2, 19)]= "魔杖",
                [AUCTION_SUBCATEGORY_TWO_HANDED] = "双手",
                    [GetItemSubClassInfo(2, 1)]= "双手斧",
                    [GetItemSubClassInfo(2, 5)]= "双手锤",
                    [GetItemSubClassInfo(2, 8)]= "双手剑",
                    [GetItemSubClassInfo(2, 6)]= "长柄武器",
                    [GetItemSubClassInfo(2, 10)]= "法杖",
                [AUCTION_SUBCATEGORY_RANGED] = "远程",
                    [GetItemSubClassInfo(2, 2)]= "弓",
                    [GetItemSubClassInfo(2, 18)]= "弩",
                    [GetItemSubClassInfo(2, 3)]= "枪械",
                    [GetItemSubClassInfo(2, 16)]= "投掷武器",
                [AUCTION_SUBCATEGORY_MISCELLANEOUS] = "杂项",
                    [GetItemSubClassInfo(2, 20)]= "鱼竿",
                    [AUCTION_SUBCATEGORY_OTHER] = "其他",
            [AUCTION_CATEGORY_ARMOR] = "护甲",
                [RUNEFORGE_LEGENDARY_CRAFTING_FRAME_TITLE] = "符文铭刻",
                [GetItemSubClassInfo(4, 4)]= "板甲",
                [GetItemSubClassInfo(4, 3)]= "锁甲",
                [GetItemSubClassInfo(4, 2)]= "皮甲",
                [GetItemSubClassInfo(4, 1)]= "布甲",
                [ITEM_COSMETIC] = "装饰品",
            [AUCTION_CATEGORY_CONTAINERS] = "容器",
                [GetItemSubClassInfo(1, 0)]= "容器",
                [GetItemSubClassInfo(1, 2)]= "草药",
                [GetItemSubClassInfo(1, 3)]= "附魔",
                [GetItemSubClassInfo(1, 4)]= "工程",
                [GetItemSubClassInfo(1, 5)]= "宝石",
                [GetItemSubClassInfo(1, 6)]= "矿石",
                [GetItemSubClassInfo(1, 7)]= "制皮",
                [GetItemSubClassInfo(1, 8)]= "铭文",
                [GetItemSubClassInfo(1, 9)]= "钓鱼",
                [GetItemSubClassInfo(1, 10)]= "烹饪",
                [GetItemSubClassInfo(1, 11)]= "材料",
            [AUCTION_CATEGORY_GEMS] = "宝石",
                [GetItemSubClassInfo(3, 11)]= "神器圣物",
                [GetItemSubClassInfo(3, 0)]= "智力",
                [GetItemSubClassInfo(3, 1)]= "敏捷",
                [GetItemSubClassInfo(3, 2)]= "力量",
                [GetItemSubClassInfo(3, 3)]= "耐力",
                [GetItemSubClassInfo(3, 5)]= "爆机",
                [GetItemSubClassInfo(3, 6)]= "精通",
                [GetItemSubClassInfo(3, 7)]= "急速",
                [GetItemSubClassInfo(3, 8)]= "全能",
                [GetItemSubClassInfo(3, 10)]= "复合属性",
            [AUCTION_CATEGORY_ITEM_ENHANCEMENT] = "物品强化",
                [GetItemSubClassInfo(8, 0)] = "头部",
                [GetItemSubClassInfo(8, 1)] = "颈部",
                [GetItemSubClassInfo(8, 2)] = "肩部",
                [GetItemSubClassInfo(8, 3)] = "披风",
                [GetItemSubClassInfo(8, 4)] = "胸部",
                [GetItemSubClassInfo(8, 5)] = "手腕",
                [GetItemSubClassInfo(8, 6)] = "手部",
                [GetItemSubClassInfo(8, 7)] = "腰部",
                [GetItemSubClassInfo(8, 8)] = "腿部",
                [GetItemSubClassInfo(8, 9)] = "脚部",
                [GetItemSubClassInfo(8, 10)] = "手指",
                [GetItemSubClassInfo(8, 11)] = "武器",
                [GetItemSubClassInfo(8, 12)] = "双手武器",
                [GetItemSubClassInfo(8, 13)] = "盾牌/副手",
            [AUCTION_CATEGORY_CONSUMABLES] = "消耗品",
                [GetItemSubClassInfo(0, 0)] = "爆炸物和装置",
                [GetItemSubClassInfo(0, 1)] = "药水",
                [GetItemSubClassInfo(0, 2)] = "药剂",
                [GetItemSubClassInfo(0, 3)] = "合剂和瓶剂",
                [GetItemSubClassInfo(0, 5)] = "食物和饮水",
                [GetItemSubClassInfo(0, 7)] = "绷带",
                [GetItemSubClassInfo(0, 9)] = "凡图斯符文",
            [AUCTION_CATEGORY_GLYPHS] = "雕文",
            [AUCTION_CATEGORY_TRADE_GOODS] = "杂货",
                [GetItemSubClassInfo(7, 5)] = "布料",
                [GetItemSubClassInfo(7, 6)] = "皮料",
                [GetItemSubClassInfo(7, 7)] = "金属和矿石",
                [GetItemSubClassInfo(7, 8)] = "烹饪",

                [GetItemSubClassInfo(7, 9)] = "草药",
                [GetItemSubClassInfo(7, 12)] = "附魔材料",
                [GetItemSubClassInfo(7, 16)] = "铭文",
                [GetItemSubClassInfo(7, 4)] = "珠宝加工",
                [GetItemSubClassInfo(7, 1)] = "零件",
                [GetItemSubClassInfo(7, 10)] = "元素",

                [GetItemSubClassInfo(7, 18)] = "附加材料",
                [GetItemSubClassInfo(7, 19)] = "成器材料",
            [AUCTION_CATEGORY_RECIPES] = "配方",
                [GetItemSubClassInfo(9, 1)] = "制皮",
                [GetItemSubClassInfo(9, 2)] = "裁缝",
                [GetItemSubClassInfo(9, 3)] = "工程",
                [GetItemSubClassInfo(9, 4)] = "锻造",
                [GetItemSubClassInfo(9, 6)] = "炼金术",
                [GetItemSubClassInfo(9, 8)] = "附魔",
                [GetItemSubClassInfo(9, 10)] = "珠宝加工",
                [GetItemSubClassInfo(9, 11)] = "铭文",
                [GetItemSubClassInfo(9, 5)] = "烹饪",
                [GetItemSubClassInfo(9, 7)] = "急救",
                [GetItemSubClassInfo(9, 9)] = "钓鱼",
                [GetItemSubClassInfo(9, 0)] = "书籍",
            [AUCTION_CATEGORY_PROFESSION_EQUIPMENT] = "专业装备",
                [GetItemSubClassInfo(19, 5)] = "采矿",
                [GetItemSubClassInfo(19, 3)] = "草药学",
                [GetItemSubClassInfo(19, 10)] = "剥皮",
            [AUCTION_CATEGORY_BATTLE_PETS] = "战斗宠物",
                [GetItemSubClassInfo(17, 0)] = "人形",
                [GetItemSubClassInfo(17, 1)] = "龙类",
                [GetItemSubClassInfo(17, 2)] = "飞行",
                [GetItemSubClassInfo(17, 3)] = "亡灵",
                [GetItemSubClassInfo(17, 4)] = "小动物",
                [GetItemSubClassInfo(17, 5)] = "魔法",
                [GetItemSubClassInfo(17, 6)] = "元素",
                [GetItemSubClassInfo(17, 7)] = "野兽",
                [GetItemSubClassInfo(17, 8)] = "水栖",
                [GetItemSubClassInfo(17, 9)] = "机械",
            [AUCTION_CATEGORY_QUEST_ITEMS] = "任务物品",
            [AUCTION_CATEGORY_MISCELLANEOUS] = "杂项",
                [GetItemSubClassInfo(15, 0)] = "垃圾",
                [GetItemSubClassInfo(15, 1)] = "材料",
                [GetItemSubClassInfo(15, 3)] = "节日",
                [GetItemSubClassInfo(15, 5)] = "坐骑",
                [GetItemSubClassInfo(15, 6)] = "坐骑装备",
            [AUCTION_SUBCATEGORY_PROFESSION_ACCESSORIES] = "配饰",
            [AUCTION_SUBCATEGORY_PROFESSION_TOOLS] = "工具",
            [GetItemSubClassInfo(18, 0)] = "时光徽章",
        }

        hooksecurefunc('AuctionHouseFilterButton_SetUp', function(btn, info)
            set(btn, strText[info.name])
        end)
    end
end


local function cancel_all()
    Init=function() end
    Init_Loaded= function() end
    panel:UnregisterEvent('ADDON_LOADED')
end



--###########
--加载保存数据
--###########
panel:RegisterEvent("ADDON_LOADED")
panel:RegisterEvent('PLAYER_LOGOUT')
panel:SetScript("OnEvent", function(self, event, arg1)
    if event == "ADDON_LOADED" then
        if arg1==id then
            if not e.onlyChinese then
                cancel_all()
                return
            end

            Save= WoWToolsSave[addName] or Save

            --添加控制面板
            e.AddPanel_Check({
                name= e.onlyChinese and '语言翻译' or addName,
                tooltip= '仅限中文，|cnRED_FONT_COLOR:可能会出错|r|nChinese only',
                value= not Save.disabled,
                func= function()
                    Save.disabled = not Save.disabled and true or nil
                    print(id, addName, e.GetEnabeleDisable(not Save.disabled), e.onlyChinese and '需求重新加载' or REQUIRES_RELOAD)
                end
            })

            if Save.disabled then
                cancel_all()
            else
               Init()
            end
        else
            Init_Loaded(arg1)
        end

    elseif event == "PLAYER_LOGOUT" then
        if not e.ClearAllSave then
            WoWToolsSave[addName]=Save
        end
    end
end)