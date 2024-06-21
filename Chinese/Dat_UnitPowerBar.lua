
local id, e = ...
if (e.Player.region~=3 and not e.Is_PTR) or LOCALE_zhCN or LOCALE_zhTW then
    return
end
--[ID]= {'Name_lang', 'Cost_lang', 'OutOfError_lang', 'ToolTip_lang'},

local tab={


[9]= {'测试能量', '%d测试能量', '测试能量不足'},
[10]= {'测试能量', '%d测试能量', '测试能量不足'},
[18]= {'致命性指数'},
[23]= {'声音指数条', '声音', '你未被发现', '看你有多吵！'},
[24]= {'枯萎样本'},
[26]= {'消化酸液', nil, nil, '你正在被厄索拉斯的胃酸消化！|n|n胃酸的消化作用会随时间增强——在附近的大地之环萨满处寻求保护并治疗你自己！'},
[29]= {'种族进程', '这是什么意思？'},
[30]= {'进攻批次进程', '这是什么意思？'},
[32]= {'进攻批次进程', '这是什么意思？'},
[33]= {'进攻批次进程', '这是什么意思？'},
[34]= {'阿莱克丝塔萨的能量'},
[35]= {'进攻批次进程', '这是什么意思？'},
[36]= {'看守者斯蒂沃特', '这是什么意思？', nil, '看守者斯蒂沃特的剩余生命值。'},
[37]= {'堕落之血', '堕落之血', '你的血液是纯净的！', '造成：|n25% 腐蚀：加速。|n50% 腐蚀：疫病。|n75% 腐蚀：畸变。|n100% 腐蚀：绝对。'},
[39]= {'电荷充能', '电荷', nil, '奥妮克西亚当前的电荷充能等级。她会在完全充能之后爆炸。'},
[61]= {'真气', '%d点真气', '真气不足', '你的攻击将会为你存储能量。'},
[62]= {'完成援救', nil, nil, '靠近落单的德鲁伊！'},
[63]= {'完成仪式', nil, nil, '击败诺尔度之脊顶上的传送门附近的元素！'},
[64]= {'方向槽', '方向', nil, '这是雷奥利斯领主前进的方向。'},
[65]= {'专注', '专注', '失去专注。', '每次造成伤害或者治疗都能让你更加专注。当你被攻击或有害法术命中时会失去这些奖励。'},
[66]= {'防御反抗军营地', nil, nil, '帮助反抗军营地抵御巨魔的进攻！'},
[67]= {'防御格罗姆高营地', nil, nil, '帮助格罗姆高营地抵御巨魔的进攻！'},
[68]= {'保护萨尔', nil, nil, '击败那些想要撕碎萨尔的元素！'},
[69]= {'保护萨尔', nil, nil, '击败那些想要撕碎萨尔的元素！'},
[72]= {'保护萨尔', nil, nil, '击败威胁萨尔的暮光部队！'},
[78]= {'释放萨尔', nil, nil, '激活图腾来释放萨尔！'},
[80]= {'熔火之羽', '熔火之羽', '你没有携带熔火之羽！', '你收集的熔火之羽的数量。'},
[83]= {'打豺狼人', nil, nil, '用力砸！'},
[84]= {'射击场', nil, nil, '快速射击赢得高分！'},
[86]= {'蒸汽坦克大挑战', nil, nil, '油满，出发！'},
[87]= {'生命力', nil, nil, '在受伤的船员的生命力归零之前复活他们。'},
[88]= {'套圈圈挑战', nil, nil, '套圈'},
[89]= {'降落伞', nil, nil, '剩余降落伞'},
[90]= {'时之沙', '时之沙', '沙漏里的沙子已经用光了!', '沙漏还能倒转时光的次数。'},
[91]= {'为法杖充能', nil, nil, '杀死古代灵魂以为裴智之杖充能，并打断仪式！'},
[92]= {'平衡', '平衡', nil, '显示死亡之翼背脊上左侧和右侧玩家的平衡。当死亡之翼感到所有玩家都在同一侧时，他会进行翻滚。'},
[93]= {'冥想', nil, nil, '寻找你的内心。'},
[94]= {'通天桥', nil, nil, '在裴智进行仪式时保护他！'},
[95]= {'恶魔果汁（旧）', '恶魔果汁（旧）', '你的怒气不足！', '在恶魔变形状态下使用技能时消耗。'},
[97]= {'坚定意志', '坚定', '你的精神能量还没有恢复'},
[103]= {'泥水', nil, nil, '你获得的泥水数量。'},
[104]= {'进入梦境', '梦境', '你的心智还没有从上一次梦境的经历中恢复过来'},
[105]= {'反击测试'},
[106]= {'拳劲', nil, nil, '全力击打！'},
[107]= {'堕落熔岩', '堕落熔岩', nil, '死亡之翼的堕落熔岩会随着他生命值的降低而造成更高的火焰伤害。当生命值为15%、10%和5%的时候，死亡之翼会出血，产生双倍的堕落熔岩。'},
[110]= {'静电充能', '静电充能'},
[113]= {'憎恨', '憎恨', '憎恨为零。', '你的憎恨会随着时间推移提高。当你被恨之煞的技能命中后也会提高。'},
[114]= {'干扰猢狲聚会', '干扰猢狲聚会', '猢狲聚会正在倾情上演！', '被干扰的猢狲聚会者数量。|n|n干扰这场聚会将引起乌克乌克的愤怒！'},
[115]= {'不稳定的灰烬', '不稳定的灰烬', '你需要更多的不稳的灰烬', '不稳定的灰烬会强化你的下一次燃烧或灵魂之火。'},
[116]= {'热量等级', '热量', nil, '显示这只丑恶的融合怪吸收的堕落熔岩的数量。'},
[117]= {'射击场', nil, nil, '命中25次就能取胜!'},
[129]= {'蒸汽坦克大挑战', nil, nil, '尽可能多的命中敌人！'},
[133]= {'打豺狼人', nil, nil, '用力砸！'},
[134]= {'布兰琪的闪电陈酿', nil, nil, '保护酒桶，防止其起火，以帮助布兰琪酿造闪电陈酿。'},
[137]= {'生存之环：烈焰', nil, nil, '别死了。'},
[139]= {'生存计时器', nil, nil, '别死了。'},
[141]= {'灵魂转换倒数'},
[148]= {'矿车控制权', '矿车控制权', '失去控制权', '附近的联盟及部落玩家数量将决定矿车的控制权。'},
[149]= {'艾莎的冥想', nil, nil, '在艾莎冥想的时候保护她。'},
[151]= {'抓住鲨鱼', nil, nil, '抓紧鲨鱼！别让她把你甩下去！'},
[158]= {'治愈神真子', nil, nil, '救出治疗者并保护他们，直至神真子的伤口被治愈。'},
[165]= {'憎恨', nil, nil, '站在祥和之池中以控制你的仇恨！'},
[171]= {'唾液', nil, nil, '你获得的唾液数量。'},
[175]= {'真·至高能量', '真·至高能量', '你太虚弱了', '你在杀死煞魔后，可吸收原始煞能。'},
[176]= {'粘稠度', '粘稠度', '最低粘稠度', '随着树脂的硬化，粘稠度条会逐渐上升。跳跃可防止树脂硬化！'},
[177]= {'珀的丛林酒', nil, nil, '从岛上的猢狲海盗身上收集丛林酒。'},
[178]= {'意志力', '意志力', '意志力不足！', '你努力想要保住对新身体的控制权。一旦意志力耗尽，你将完全失去意识……'},
[179]= {'吴暮的阴影收集瓶', nil, nil, '你收集到的阴影数量。'},
[183]= {'冥思', nil, nil, '看清你的内心。'},
[195]= {'生存之环：刀剑', nil, nil, '别死了！'},
[199]= {'拳劲', nil, nil, '全力击打！'},
[203]= {'净化生命之池', nil, nil, '消灭生命之池周围的煞魔！'},
[204]= {'紫晶石化', '紫晶石化', '替代能量不足', '你被变成了紫晶！如果该过程完成，你将无法移动或行动。|n|n在此过程中，你的移动速度大幅降低，但受到的暗影伤害降低90%。'},
[205]= {'蓝晶石化', '蓝晶石化', '替代能量不足', '你被变成了蓝晶！如果该过程完成，你将无法移动或行动。|n|n在此过程中，你的移动速度大幅降低，但受到的冰霜伤害降低90%。'},
[206]= {'青玉石化', '青玉石化', '替代能量不足', '你被变成了青玉！如果该过程完成，你将无法移动或行动。|n|n在此过程中，你的移动速度大幅降低，但受到的自然伤害降低90%。'},
[207]= {'红玉石化', '红玉石化', '替代能量不足', '你被变成了红玉！如果该过程完成，你将无法移动或行动。|n|n在此过程中，你的移动速度大幅降低，但受到的火焰伤害降低90%。'},
[213]= {'锦鱼人防御工事', nil, nil, '建造进度'},
[214]= {'邪能', nil, nil, '杀死附近的恶魔，吸收邪能。'},
[216]= {'侏儒防御工事', nil, nil, '建造进度'},
[220]= {'矮人防御工事', nil, nil, '建造进度'},
[221]= {'熊猫人防御工事', nil, nil, '建造进度'},
[222]= {'异常位置的距离'},
[223]= {'暗夜精灵防御工事', nil, nil, '建造进度'},
[229]= {'射击场', nil, nil, '快速射击赢得高分！'},
[234]= {'电容能量'},
[237]= {'导管等级', nil, nil, '导管的能量等级。'},
[238]= {'导管能量', '导管能量', '导管能量', '当前雷神正在充能的导管的能量等级。'},
[240]= {'导管等级', nil, nil, '导管的能量等级。'},
[241]= {'导管等级', nil, nil, '导管的能量等级。'},
[242]= {'导管等级', nil, nil, '导管的能量等级。'},
[243]= {'雷电之王的藏宝库', nil, nil, '本次迄今为止从魔古族处偷得的金币数量。'},
[244]= {'充能等级', nil, nil, '延极锭正在附近的模具中充能。'},
[245]= {'锻造进度', nil, nil, '天界工匠锻造闪电长枪的进度。'},
[247]= {'收集遗物', nil, nil, '在繁盛矿洞中尽力收集遗物！'},
[248]= {'乌萨吉之盾', nil, nil, '乌萨吉有一面强大的护盾。你可以杀死次级元素生物来降低他的护盾能量。'},
[253]= {'怒气', nil, nil, '随着怒气的提升，战歌兽人会变得越来越危险。'},
[254]= {'侵略性', nil, nil, '侵略性的提升，会使黑石兽人的攻击性越来越强；反之，侵略性下降，黑石兽人就会趋于防守。'},
[257]= {'傲气值', '傲气值', '你是谦逊的。', '被傲气冲天击中时造成下列效果：|n傲气迸发（25点傲气值）。|n投影（50点傲气值）。 |n傲气光环（75点傲气值）。|n压制（100点傲气值）。'},
[258]= {'腐蚀值', '腐蚀值', '你被净化了。', '你被煞能腐化了。你需要降低自己的腐蚀等级以完成诺鲁什的试炼。'},
[259]= {'防御系统超控能量', '防御系统超控能量', '防御系统超控能量', '控制防御系统的能量值。'},
[263]= {'加尔鲁什的能量', '加尔鲁什的能量', '加尔鲁什的能量', '加尔鲁什正在吸收亚煞极之心的能量。'},
[266]= {'塔楼强度', nil, nil, '击败塔楼的守卫，以削减塔楼的强度。'},
[267]= {'防御系统超控能量', '防御系统超控能量', '防御系统超控能量', '控制防御系统的能量值。'},
[268]= {'腐蚀值', '腐蚀值', '你被净化了。', '你被煞能腐化了。你需要降低自己的腐蚀等级以完成诺鲁什的试炼。'},
[271]= {'钚晶核共振虚空引力机', nil, nil, '为仪器充满虚空能量，杀死附近的影月兽人。'},
[274]= {'获救的奴隶', nil, nil, '摆脱食人魔控制的奴隶数量。'},
[280]= {'艾萝娜的进度', nil, nil, '艾萝娜正在关闭钢铁加油器。保护好她！'},
[281]= {'蒸汽动力', '蒸汽动力', '燃料不足', '用来破坏岩石和墙体的能量。'},
[284]= {'热量等级', '燃料', '闷烧', '随着热量的增加，山脉之心会形成更多爆破。'},
[287]= {'怒气', '燃料', '闷烧'},
[290]= {'已收集木材', nil, nil, '在你的农夫收集木材时保护他们的安全。'},
[291]= {'胜利点数', nil, nil, '决定你的终极奖励。'},
[292]= {'预热阶段', '时间', '未预热', '为最后的轰炸序列充能。'},
[293]= {'士气', nil, nil, '因远离自己的独眼魔双胞胎兄弟而愤怒。|n|n急速提高。|n|n施法和引导速度提高。'},
[295]= {'蘑菇汁', nil, nil, '压榨血棘洞穴里多汁的蘑菇，在罐子里注满蘑菇汁。'},
[296]= {'卡拉的能量', '卡拉的能量', '卡拉的能量', '保护卡拉！'},
[297]= {'车辆耐久度'},
[298]= {'废灵壁垒'},
[299]= {'胜利得分', nil, nil, '决定你的终极奖励。'},
[300]= {'物资', nil, nil, '你的要塞每10分钟获得1点物资。'},
[303]= {'热血咆哮', '热血咆哮', '热血咆哮', '观众的呼喊声强化了你的攻击力。'},
[304]= {'废灵壁垒'},
[305]= {'废灵壁垒'},
[306]= {'黑索公司用户手册', '高热', nil, '感谢你购买BFC9000！|n|n警告：该烈焰喷射装置在使用过程中，会随着时间的延长而散发越来越多的热量。一旦该单位过热，则必须冷却至少10秒等后才能再次使用。|n|n售出概不退换！'},
[310]= {'突袭血槌食人魔', nil, nil, '消灭血槌食人魔，并从他们身上收集情报。'},
[312]= {'突袭黑潮栖木', nil, nil, '破坏钢铁部落征服黑潮栖木的双头飞龙的计划。'},
[313]= {'行动：斯克提斯废墟', nil, nil, '你当前救出的鸦人流亡者的总士气值。带着救出的流亡者与高阶鸦人战斗，然后将其安全护送到斯克提斯废墟外围的某位黑暗占卜师处，可推进你的行动：斯克提斯废墟的进度。'},
[314]= {'能量条'},
[317]= {'弹药', '弹药', '弹药耗尽！', '用来为钢铁部落机械提供动力的弹药。'},
[318]= {'虚空协调', nil, nil, '你在扭曲虚空中的时间十分有限。离开现实气泡的相对安全范围，会使你的调节力衰减。'},
[319]= {'仪式能量', nil, nil, '在鸦语者巢穴中，听从高阶鸦语者科卡的指示，使仪式顺利进行。'},
[320]= {'火焰精华', nil, nil, '火焰精华渐渐熄灭了。'},
[321]= {'马尔高克越来越无聊', nil, nil, '开始杀戮吧！'},
[322]= {'燃料', '高热', nil, '剩余燃料。'},
[325]= {'财宝地精', nil, nil, '目前为止，从财宝地精身上获取的金币量。'},
[326]= {'总时间', nil, nil, '当前种族消耗的总时间。'},
[329]= {'发报机能量', '发报机能量', '发报机能量', '吸收风暴幼龙的闪电攻击为发报机充能。'},
[330]= {'末日军团传送门', nil, nil, '击败恶魔部队以关闭传送门。'},
[331]= {'破除幻象', nil, nil, '驱散幻象。'},
[332]= {'击败灵魂', nil, nil, '消灭来袭的敌人，突破他们的阵线！'},
[335]= {'易爆废料', nil, nil, '从黑玫瑰号的残骸中收集易爆废料，装入密封装置。'},
[336]= {'邪能腐蚀', '邪能腐蚀', '邪能腐蚀', '当邪能腐蚀全满时，你将沦为燃烧军团的爪牙。'},
[337]= {'邪能腐蚀', '邪能腐蚀', '邪能腐蚀'},
[338]= {'摧毁恶魔物品', nil, nil, '已获得的斩魔点数！'},
[339]= {'保护天火号', nil, nil, '消灭被遗忘者部队，拆除天火号上的易爆炸弹。'},
[342]= {'狂乱', '狂乱', '你没有足够的狂乱值。', '狂乱值增长时将解锁更多技能。'},
[343]= {'能量池距离', nil, nil, '目前邪能玛戈隆最靠近暗影之池。'},
[344]= {'能量池距离', nil, nil, '目前邪能玛戈隆最靠近火焰之池。'},
[345]= {'能量池距离', nil, nil, '目前邪能玛戈隆最靠近邪能之池。'},
[346]= {'腐蚀能量', nil, nil, '消耗腐蚀能量，为强大的技能充能。'},
[347]= {'漩涡', '漩涡', '你需要更多漩涡值', '为你的技能提供能量。'},
[348]= {'风暴', '风暴', '你没有足够的风暴值。', '由闪电箭产生。用于施放你的许多法术。'},
[349]= {'血月之力', '血月之力', '血月之力', '找到枯竭的血水晶并对鲜血之月使用以削弱其力量！'},
[350]= {'袭击天火号', nil, nil, '消灭联盟成员并在天火号上放置易爆炸弹。'},
[351]= {'寻宝', nil, nil, '你与你的目标之间的距离。'},
[352]= {'占位符', '占位符', '占位符', '占位符'},
[353]= {'干扰猢狲聚会', '干扰猢狲聚会', '猢狲聚会正在倾情上演！', '被干扰的猢狲聚会者数量。|n|n干扰这场聚会将引起乌克乌克的愤怒！'},
[354]= {'梦魇腐蚀', '梦魇腐蚀', '梦魇腐蚀', '梦魇腐蚀扭曲了你的思想。'},
[355]= {'奥术充能', '奥术充能', '你需要更多奥术充能', '奥术充能由奥术冲击、奥术飞弹和魔爆术产生，并被奥术弹幕和唤醒消耗。'},
[358]= {'月光能量', '月光能量', '你需要更多月光能量', '为你的技能提供能量。'},
[361]= {'阿格拉玛之盾'},
[362]= {'魔网能量', nil, nil, '为自己灌注在鱼人浅滩找到的魔网能量。'},
[365]= {'血石', nil, nil, '必须用恶魔的鲜血来喂养血石。'},
[369]= {'腐蚀值', '腐蚀值', '你被净化了。', '加尼尔正在渗出黑暗能量。腐化程度过深时，你会立刻从翡翠梦境中苏醒！|n|n你的治疗法术可以减轻腐化程度。'},
[370]= {'时间流逝', nil, nil, '表示与正常时间不同的时间流逝速度。'},
[371]= {'不稳定的神圣能量', '神圣之怒', nil, '收集魔枢宝库内圣光之怒释放出的神圣能量。'},
[376]= {'不稳定的奥术能量', '"奥术能量 "', nil, '收集魔枢宝库内艾露尼斯释放出的奥术能量。'},
[377]= {'饥饿值', nil, '你饿得无法继续了。', '你需要进食才能生存。'},
[380]= {'酿酒状态', nil, nil, '在美猴王的指导下完成酿酒。'},
[381]= {'收集来的魔网能量', '魔网能量', nil, '当前魔网能量等级。跑下向一个魔网能量节点为你的魔刃豹充能。'},
[384]= {'恶魔变形', nil, nil, '恶魔变形的剩余时间。'},
[387]= {'迫击炮火力', nil, nil, '在能量耗尽之前迅速射击！'},
[388]= {'剩余时间', nil, nil, '抓紧时间发现矿洞！'},
[389]= {'剩余时间', nil, nil, '抓紧时间发现矿洞！'},
[390]= {'剩余时间', nil, nil, '抓紧时间发现矿洞！'},
[391]= {'剩余时间', nil, nil, '抓紧时间发现矿洞！'},
[392]= {'冥狱深渊之雾', nil, nil, '海拉的力量会不断增长，达到满值时会使用巨喉之怒。'},
[393]= {'剩余时间', nil, nil, '阻止瑟玛普拉格的剩余时间！'},
[394]= {'剩余时间', nil, nil, '阻止瑟玛普拉格的剩余时间！'},
[395]= {'折磨', '折磨', '零点折磨。', '你被燃烧军团的技能击中时，会增加你在对方手上的折磨点数。'},
[399]= {'奥术充能', nil, nil, '积累奥术能量，施放驱逐暗影。'},
[400]= {'邪能能量', nil, nil, '消耗邪能能量，对敌人造成伤害。'},
[401]= {'护盾之力', nil, nil, '强化萨格拉斯之墓的防御系统。'},
[404]= {'军团刺客目标', '军团威胁', '军团目前没有追踪你。', '你对军团的威胁等级。威胁等级越高，军团就会派遣刺客来暗杀你。'},
[405]= {'红龙精华', '红龙精华', nil, '已收集的死去红龙的精华。'},
[408]= {'虚空能量', '虚空能量', '能量为0。', '在这个世界中灌注的虚空能量。'},
[410]= {'黑索公司用户手册', '高热'},
[411]= {'黑索公司用户手册', '高热'},
[414]= {'显示时间', nil, nil, '好好利用！'},
[415]= {'点数', nil, nil, '进球越多越好。尽量花式进球以获得更高分数！'},
[416]= {'阿昆达之力', nil, nil, '吸收阿昆达的雷霆打击来获得他的力量。'},
[417]= {'击败灵魂', nil, nil, '消灭来袭的敌人，突破他们的阵线！'},
[421]= {'泰坦精华', '泰坦精华', '泰坦精华不足', '泰坦之力，可通过充当阿格拉玛的化身以吸收伤害来获得。'},
[424]= {'生命能量', '生命能量', nil, '击败敌人，为艾欧娜尔补充生命能量。|n|n生命能量达到100点时，她会施放生命之力。'},
[427]= {'安抚', '安抚', nil, '你在安抚一只狮鹫。槽全满后即可驯服这只凶猛的野兽！'},
[428]= {'竭心', '竭心', '你的心跳停止了！', '移动会使毒素流遍你全身的血管！'},
[430]= {'黑索公司用户手册', '瘟疫'},
[431]= {'立足', '立足', nil, '在帆桅上层站稳脚跟。把你的目标击落下去！'},
[432]= {'名字', nil, nil, '说明条'},
[433]= {'唤天者法杖能量', nil, nil, '积聚唤天者法杖的力量，对蛇人释放闪电！'},
[434]= {'能量等级', '能量', nil, '该生物会在充电时获得能量。当它达到最大能量时，会使用放电并获得一层电容。'},
[435]= {'能量等级', '能量', nil, '充电时你可获得能量。当你的能量等级达到最高时，你将无法再充电。'},
[436]= {'狮鹫抓握', nil, nil, '抓紧狮鹫！别让它把你甩下去！'},
[437]= {'能量等级', '能量', nil, '收集流动能量的同时躲避散落的火花。触碰散落的火花时会消耗你收集的一部分能量，离开散落火花范围时会驱散你收集的所有能量。'},
[438]= {'壁垒能量', '壁垒能量', '壁垒能量', '吸收闪电宝珠以重新填充沃里克的壁垒。'},
[439]= {'虚空之泉', '能量', nil, '消灭被虚空污染的敌人以收集虚空精华。'},
[440]= {'感染之血', '感染之血', '感染之血'},
[541]= {'压力', '压力', '达到极限', '这里的可怕之物会侵袭你的心灵……遗忘洞穴中的伤害技能会造成压力效果。如果压力值达到100，那就是考验你的决心的时候了……'},
[542]= {'艾泽拉斯的生命力', '能量', nil, '艾泽拉斯之心正在强化艾泽拉斯的世界之魂。'},
[543]= {'联合能量', '能量', nil, '随着战斗的进行，斗士的联合能量会逐渐积攒。当他们的联合能量达到阈值时，斗士们就会施放组合攻击。'},
[544]= {'腐臭能量', '腐臭能量', '腐臭能量不足！', '腐臭能量为憎恶激怒供能。使用啜食来消耗腐臭黏液并提升腐臭能量。'},
[545]= {'强能花粉', '强能花粉', '强能花粉不足！', '强能花粉可以为快速生长供能。使用来消耗林地孢子并增加强能花粉。'},
[546]= {'月光精华', '月光精华', '月光精华不足！', '必须要有月光精华才能施放宁静月光和平静干涉。通过对敌人施放月光喷吐和星击可以获得更多月光精华。'},
[547]= {'殒魂之殇', '殒魂之殇', '殒魂之殇不足！', '必须要有殒魂之殇才能释放死灵脉动和墓裔之力。对敌人施放致命嚎叫和坟墓爆发可以获得殒魂之殇。'},
[548]= {'充能花粉', '充能花粉', '充能花粉不足！', '充能花粉可为荆棘之心供能。使用翠绿长矛可以提升充能花粉。'},
[549]= {'鲜血', '鲜血', '鲜血不足！', '鲜血可以使鲜血女王飞行一小段时间。'},
[550]= {'混合能量', '混合能量', '混合能量不足！', '混合能量可以为纳米燃烧供能。使用机甲毁灭者可以提升混合能量。'},
[551]= {'与隐藏的地精小队的距离', nil, nil, '你与地精小队的一名成员的距离。'},
[552]= {'已收集的灵魂', '灵魂', nil, '收集灵魂喂食给萨拉塔斯以强化她。'},
[553]= {'艾泽里特抽取器', nil, nil, '此装置可以储存所有从附近的艾泽里特泥土中吸出的艾泽里特。|n|n因为制作不是很完善，所以艾泽里特有时候会流出来。'},
[554]= {'理智', '理智', '你已经疯了！', '幻象以及其中的居民会攻击你的理智。|n|n你的理智降为0以后，要想复活的话，只能依靠一名盟友用理智恢复宝珠或者泰坦撤离来将理智捐献给你。'},
[555]= {'永燃之油', nil, nil, '用炽热海岸的永燃之油灌满油箱。'},
[556]= {'暴风雪', '暴风雪', '能量不足', '玩家必须彼此靠近以避免受到冻结之血。|n|n暴风雪越猛烈，需要的玩家数量就越多。'},
[557]= {'德鲁斯特魔法', '德鲁斯特魔法', nil, '收集德鲁斯特魔法。'},
[558]= {'德鲁斯特魔法', '德鲁斯特魔法', nil, '收集德鲁斯特魔法。'},
[561]= {'追踪进度', '追踪进度', nil, '准确地追踪各种形状可以增加你的追踪进度。'},
[562]= {'引线计时器'},
[565]= {'NRG-100电池能量', 'NRG-100电池能量', 'NRG-100电池能量', '击败故障的机器人，吸取它们的电力。'},
[567]= {'指引之光', nil, nil, '指引之光会保护你，使你不受黑暗中的可怕幻象的侵扰。'},
[568]= {'冻结之血', '冻结之血', '你的血液冻结了！', '静止不动会使你的血液冻结。'},
[569]= {'漫毒之血', '漫毒之血', '毒素在你的血管里奔腾！', '移动会使你的血管里的毒素流动得更快。'},
[570]= {'平衡', nil, nil, '你需要在力量与魔法之间维持平衡。'},
[572]= {'废灵壁垒'},
[575]= {'引导的能量', nil, nil, '莱莉雅正在通过你来引导能量，进行仪式。'},
[576]= {'哽噎指示条', nil, nil, '食用香肠会提高你的哽噎程度，而饮酒可以降低哽噎程度。|n|n别吃太快，否则你会噎住的！'},
[577]= {'晶塔耐久度', nil, nil, '马蒂瓦斯的奥术陷阱正在试图让晶塔变得不稳定。使用它的防御机制来击败攻击者，阻止它被摧毁。'},
[578]= {'心能熔炉热量', '热量', nil, '从心能熔炉里散发的热量。'},
[579]= {'守护此处'},
[580]= {'压力', nil, nil, '忠诚的重量压到了你身上。'},
[581]= {'共鸣', '共鸣', '未共鸣', '与纯洁之钟共鸣的程度。'},
[582]= {'理智', nil, '你已经疯了！', '恩佐斯会在战斗中攻击你的理智。|n|n你的理智降为0以后，恩佐斯会完全入侵你的心灵，你会获得恩佐斯之赐，最终会成为恩佐斯的仆从。'},
[585]= {'盈利', '盈利', nil, '收割一次远古入侵的奖励。'},
[586]= {'软泥传送泵', nil, nil, '将凝聚的软泥从雷文德斯输送给掮灵。'},
[588]= {'距离隐藏的通灵哨卫的距离', nil, nil, '你距离某个隐藏的通灵哨卫有多远。'},
[591]= {'虹吸的心能', '虹吸的心能', '虹吸的心能', '消灭吞噬者以虹吸其心能。'},
[592]= {'心能贮藏', nil, nil, '显示你当前可以获得的心能数量。'},
[594]= {'符文之刃充能', nil, nil, '吸取敌人的心能，给你的符文剑充能。'},
[595]= {'心能充能', '心能充能'},
[596]= {'心能流汇', '心能充能', '心能流汇未充能。', '从通灵提取器吸取心能给心能流汇充能。'},
[599]= {'容器等级'},
[601]= {'道标石激活', nil, nil, '神秘的装置活了！'},
[602]= {'心能橡子', nil, nil, '一颗心能橡子里面的心能数量。|n|n填满它以获得装满的心能橡子。'},
[603]= {'距离失踪石精的距离。', nil, nil, '你距离距离失踪石精有多远。'},
[604]= {'充能', nil, nil, '为伯瓦尔的护符充能。在坩埚内消灭渊誓者即可吸取他们的精华。'},
[605]= {'心能流汇', '心能充能', '心能流汇未充能。', '从吞噬者和陨落的百心长处吸取心能，给心能流汇充能。'},
[606]= {'温顺度', nil, nil, '显示贪婪的吞噬者的温顺度。耗尽后，贪婪的吞噬者将会攻击。'},
[607]= {'心能', '心能', nil, '用心能灌注无生气的百心之核。'},
[608]= {'能量抑制模组', nil, nil, '储存的能量可以为战斗终结者07-X充能。'},
[609]= {'搜魂者水晶', nil, nil, '在祭仪密院里消灭敌人，给搜魂者水晶充能。'},
[610]= {'平静曲杖', '心能', '平静曲杖没被充能。', '安慰缺乏心能的野生动物，从而给平静曲杖充能。'},
[611]= {'实验性液体'},
[612]= {'心能', '心能', nil, '用心能灌注巨像之核。'},
[615]= {'折磨具象', nil, nil, '噬渊中受苦的灵魂凝聚的能量。'},
[616]= {'鼓掌', '鼓掌', '观众很不满意！', '别让观众失去兴致！'},
[619]= {'飞行能量'},
[622]= {'统御', nil, nil, '在大劫掠者达马里斯彻底统御你之前净化你自己。'},
[625]= {'和钥石反应物的距离', nil, nil, '你距离钥石反应物有多近。'},
[627]= {'自由意志'},
[630]= {'核心温度', nil, nil, '当此度量表达到满值时，警戒卫士会暴露其核心，使其温度降回来。'},
[631]= {'精力', '精力', nil, '驭空术技能会消耗精力。|n|n在地面时精力会缓慢地重新充能。'},
[632]= {'窒息', nil, nil, '虫巢释放的气体令你窒息。'},
[633]= {'调查目标'},
[636]= {'奥术屏障', '"奥术能量 "', nil, '卡德加的奥术屏障的剩余能量'},
[640]= {'捕获的能量', nil, nil, '从碧蓝档案馆里的生物身上收集的能量。'},
[643]= {'伊里度斯的能量核心', '调和', nil, '调和等级。'},
[650]= {'精力', '精力', nil, '雏龙的技能会消耗精力。'},
[653]= {'消失的蛋计时器', nil, nil, '快找出来！'},
[657]= {'与调谐物品的距离', nil, nil, '你距离一件调谐物品有多远。'},
[659]= {'与调谐物品的距离', nil, nil, '你距离一件调谐物品有多远。'},
[661]= {'运送酒桶', nil, nil, '把足够的酒运到匠人集市！'},
[670]= {'萨格里特碎片', nil, nil, '度量你与某个堕落者魔法之源的距离。'},
[689]= {'烛光', nil, nil, '移动会吸取烛光的力量。|n|n烛光降至0时，你将无法免疫黑暗。'},
[690]= {'能量检测器', nil, nil, '度量你与电池的距离……'},
[693]= {'风暴充能', nil, nil, '通过闪电箭积累。用于施放风暴冲击。'},
[694]= {'与躲藏孩童之间的距离', nil, nil, '你与躲藏的阿拉希孩童之间的距离。'},
[698]= {'烹饪剩余时间', nil, nil, '烹饪完成所需的时间。'},
[701]= {'nil', 'nil', '你不再和幻象调谐一致！', '你和艾泽拉斯的幻象调谐一致。|n|n击败敌人可以保持调谐，否则将被移出幻象。'},
}