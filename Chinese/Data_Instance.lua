local id, e = ...
if e.Player.region~=3 and not e.Is_PTR then-- LOCALE_zhCN or LOCALE_zhTW 
    return
end
--https://wago.tools/db2/JournalInstance?locale=zhCN
local tab={


    [63]= {'死亡矿井', '曾经有人称死亡矿井的黄金乃是暴风城国库储备的三分之一。在第一次大战的混乱中，矿井遭到了遗弃，闹鬼不断、无人问津，直到迪菲亚兄弟会的到来——他们曾经是一群工人，如今却成了强盗，他们将这迷宫变成了自己的行动基地，来实施对暴风城的破坏活动。'},
    [64]= {'影牙城堡', '在银松森林南部悬崖的焚木村上，影牙城堡犹如一道黑影矗立。从前这里是疯狂大法师阿鲁高狼人们的居所，如今它的废墟被罪恶的力量所占据。席瓦莱恩男爵阴魂不散，高弗雷勋爵和他的幕僚，往昔的吉尔尼斯贵族阴谋对付他们的敌人，无论对方是生者还是亡灵。'},
    [65]= {'潮汐王座', '在深渊之喉无底的广袤深处，座落着潮汐王座。在那里，伟大的元素领主，猎潮者耐普图隆坚守着他的水域。现在，蛇行的纳迦和凶残的无面者成了他的心腹大敌，威胁着他的统治，觊觎着他的王国，垂涎着其中的秘密。'},
    [66]= {'黑石岩窟', '谣传这些地下迷宫乃是死亡之翼本人的手笔，为的就是让暮光之锤能够秘密地将元素从海加尔山转移到黑石山。在这阴暗的通道网中，有一处重要的要冲，那就是黑石岩窟。邪教将炽热的熔炉安置于此，并且在这里进行着一些极其邪恶的实验，将教徒转变成暮光龙人就是其中之一。'},
    [67]= {'巨石之核', '在深岩之洲中深锁着大地神殿，巨石之核就位于那里。暮光之锤的邪教徒在这些洞穴里辛苦劳作，将源质甲片敲打在死亡之翼的身上，以维系这只堕落守护巨龙被诅咒的破碎身躯。重生后的死亡之翼冲破穹顶重返艾泽拉斯之际，世界之柱也裂成了碎片，整个深岩之洲随之变得摇摇欲坠。'},
    [68]= {'旋云之巅', '旋云之巅位于风元素位面的天空之墙中。其建筑群优雅无比、镶金注铜，矗立在座座平台之上，以空气为桥相互连接。然而在其光鲜的外表之中，驻扎着尼斐塞特的托维尔人，以及风元素领主奥拉基尔无情的元素军团。只要天空之墙和艾泽拉斯之间的障壁通畅无阻，恐惧将不断从天空中降临在奥丹姆之上。'},
    [69]= {'托维尔失落之城', '尼斐塞特是猫人托维尔的一支，血肉诅咒把他们岩石般的外皮变成了柔软的皮肤。于是他们效忠于死亡之翼，以期能够换得解药，把自己解脱出来。托维尔失落之城就是他们的要塞。当诅咒被解除之后，托维尔人立刻倒戈相向，叛变了他们的恩人，但由于他们所立下的黑暗誓言，他们仍然不可避免地遭到了扭曲，变得充满敌意。'},
    [70]= {'起源大厅', '起源大厅乃是伟大的泰坦所建，那里到处都是古代遗迹，由可怕的守护者所保护。谣传这座设施里还藏着一件毁天灭地的武器，能够重塑艾泽拉斯上所有的生命。死亡之翼试图通过其副手风元素领主奥拉基尔染指这可怕的装置。目前，设施里的讯通系统完全遭到了腐蚀，但里面的武器却尚未落入死亡之翼的手中。'},
    [71]= {'格瑞姆巴托', '别被格瑞姆巴托寒酸的外观所蒙蔽了，这座山中堡垒许多被亵渎的殿堂都深埋在暮光高地里。这里曾是蛮锤矮人的要塞，后来被兽人占领，当成了关押阿莱克丝塔萨的监狱。如今这座城池落在了暮光之锤邪教的手中。|n|n敢于深入要塞的英雄们，不但要面对死亡之翼的爪牙，还要铲除其中的邪恶势力。'},
    [72]= {'暮光堡垒', '暮光堡垒就像是一个黑暗的印记，它代表了上古之神在艾泽拉斯的新兴力量。暮光之锤视其为教派的圣地和大本营，他们的邪恶首领古加尔就隐藏在这座高耸入云的尖塔建筑的最深处。他和他那些暮光仆从们正图谋着实现上古之神的灭世预言，让艾泽拉斯断绝理智、希望与生命。'},
    [73]= {'黑翼血环', '奈法利安曾经妄图创造一支全新的龙族军团。他最终死于黑翼之巢，人们认为他的阴谋也遭到了挫败。但是传说其父死亡之翼复活了奈法利安，派他前往黑翼血环。相比起在那里所进行的血腥实验来，恐怕奈法利安以前天怒人怨的罪行根本不值一提。'},
    [74]= {'风神王座', '风神王座高高地漂浮在无尽的天空之墙里，这里是风元素领主奥拉基尔的老巢。如今，元素位面的壁障已被打破，奥拉基尔得以安逸地在艾泽拉斯的风中游走。他已经聚积起最剧烈的风暴，意图清洗奥丹姆的一切生命，并占领神秘的泰坦造物：起源大厅。'},
    [75]= {'巴拉丁监狱', '第二次大战后，位于托尔巴拉德离岛的巴拉丁堡垒被改建成了监狱，用来关押艾泽拉斯最为危险的囚犯。然而大灾变的毁灭冲击让这座曾经密不透风的监狱也出现了瑕疵。现在部落和联盟争夺着岛屿的霸权，而那些被人遗忘的恐惧囚犯也许不日就将逃出生天。'},
    [76]= {'祖尔格拉布', '丛林巨魔古拉巴什一度控制着南方的大片丛林，祖尔格拉布就是他们的首都。妖术师金度曾在这里将夺灵者哈卡召唤到了艾泽拉斯世界。近来，古拉巴什和赞达拉巨魔结成了同盟，为建立一个统一的巨魔帝国而挑起了新的战火。'},
    [77]= {'祖阿曼', '在阿曼尼部落曾经的首都祖阿曼，回响着不息的复仇之声。阿曼尼巨魔虽然响应了其督军的号召，但祖尔金却没能达成恢复帝国往日辉煌的目标。继承其遗志的乃是赞达拉部落。如若放任不管，统一的诸部将会收复他们的土地，并展开无情的报复。'},
    [78]= {'火焰之地', '火焰之地乃是泰坦所铸造的一个熔火领域，用来关押拉格纳罗斯和他那群无法无天的爪牙。随着死亡之翼在艾泽拉斯的重现，拉格纳罗斯率领着他的手下奴仆们在海加尔山蜂拥而出，最终却被圣山英勇的防御者们打退。如今，拉格纳罗斯正集结他的信徒们，准备抵御艾泽拉斯的英雄们进攻火焰之地。'},
    [184]= {'时光之末', '时间流错综交织，蕴藏着无限可能和玄机；其中一条时间流中的景象昭示，如果无法阻止死亡之翼，艾泽拉斯的命运注定是凄惨荒凉的。诺兹多姆在这条时间流中发现了一个强大的生物，它行为反常并且挡住了通往过去世界的时间入口——获取巨龙之魂的唯一希望。在这扭曲的时空之中，这个强大的生物只和过往世界的残影为伴。'},
    [185]= {'永恒之井', '远在一万年前，当时的暗夜精灵首都辛艾萨莉是一座欣欣向荣的富饶之城，宛如艾泽拉斯一颗闪烁着文明之光的夜明珠。然而，上层精灵贵族们却利用这座城市坐落于永恒之井边陲的地理优势，在这里打开了通往扭曲虚空的传送门，继而使得燃烧军团能够从这里入侵艾泽拉斯，生灵涂炭。在精灵女王艾萨拉的指挥下，上层精灵们正在将他们的能量注入传送门，准备迎接恶魔之神萨格拉斯的驾临，屈从于他恐怖的统治。'},
    [186]= {'暮光审判', '艾泽拉斯的英雄们从遥远的过去夺回了巨龙之魂，现在正斗志昂扬，准备迎接死亡之翼的最后挑战。远在诺森德的冰冻废土之上，他派遣的暮光大军正在对龙眠神殿的高塔展开进攻。虽然手持神器巨龙之魂，但是萨尔是否能够安然抵达龙眠神殿，最终挽救艾泽拉斯的命运呢？'},
    [187]= {'巨龙之魂', '死亡之翼于上古之战凝聚所有龙族神力铸造神器巨龙之魂，终究被毁于一旦。通过时光之穴，萨尔和其他龙族历经千险，在神器被摧毁前得到了它。现在，他们齐聚龙眠神殿，准备借助巨龙之魂的强大力量和它的创造者死亡之翼作殊死一搏。'},
    [226]= {'怒焰裂谷', '怒焰裂谷深入奥格瑞玛的地下。野蛮的穴居人和狡诈的燃刃信徒曾在这些熔岩洞穴中肆虐一时。但现在，这里又出现了新的威胁：黑暗萨满。虽然加尔鲁什·地狱咆哮酋长最近召集了一批萨满，准备以元素为武器来对付联盟，但洞中的这些新居民似乎都是变节者。报告表明，这些阴暗的家伙正在集结一支足以毁灭奥格瑞玛的灼热大军。'},
    [227]= {'黑暗深渊', '人们原本以为曾被奉献给暗夜精灵女神艾露恩的黑暗深渊已经在大分裂中被彻底摧毁并永远沉入了大海。数千年后，暮光之锤的邪教徒被邪恶的低语和梦境引入了神殿。在献祭了无数的无辜者之后，这个教派得到了一个新的任务：保护上古之神最珍视的生物之一，一头仍需喂养的宠物，直至它对世界释放出自己的黑暗力量。'},
    [228]= {'黑石深渊', '静静燃烧的黑石深渊是黑铁矮人和他们的皇帝，达格兰·索瑞森的家园。和他的前任一样，达格兰服从炎魔拉格纳罗斯的铁腕统治。这个残忍的生物是数个世纪前被召唤到这个世界的。混乱的元素活动将暮光之锤的邪教徒引到了这片山区。他们与拉格纳罗斯的仆人一起将矮人逼向毁灭的边缘，这最终也将导致全艾泽拉斯的毁灭。'},
    [229]= {'黑石塔下层', '这座雄伟的堡垒一直深入黑石山的熔火地心之中，几个世纪来一直代表着黑铁部落实力。最近，黑龙奈法利安和他的子嗣夺取的堡垒的上层高塔并对矮人们发动了残酷的战争。龙族大军与大酋长雷德·黑手及其伪部落结成了盟友。这支联军在塔中为所欲为，进行可怕的实验以扩充军队，试图一举覆灭多管闲事的黑铁矮人。'},
    [230]= {'厄运之槌', '数千年前，作为收藏卡多雷奥术秘密的殿堂，埃雷萨拉斯曾盛极一时。而如今，它已成为一片废墟，到处翻滚着诡异、扭曲的力量。许多势力都曾争夺过厄运之槌的堕落力量的控制权，但最终他们达成了脆弱的停战协议，在各自的实力范围内研究着当地的能量，而不再全面开战。'},
    [231]= {'诺莫瑞根', '建于丹莫罗群山深处的奇迹之城诺莫瑞根曾是侏儒智慧与工业技术的象征。但当主城遭到穴居人入侵时，侏儒大工匠却遭到了他的顾问，希科·瑟玛普拉格的背叛。最终，若莫瑞根遭辐射污染，大部分居民遇害。幸存的侏儒逃离了这里，但他们誓言将回到这里并重夺家园。'},
    [232]= {'玛拉顿', '传说，塞纳留斯之子，扎尔塔和土元素公主瑟莱德丝公主生下了野蛮的半人马种族。半人马诞生后不久，这些粗野的生物就谋杀了他们的父亲。据说，悲痛欲绝的瑟莱德丝将爱人的灵魂囚禁在玛拉顿中并腐化了这一地区。如今，邪恶的半人马鬼魂和扭曲的元素爪牙充斥着这座杂乱洞穴的每一个角落。'},
    [233]= {'剃刀高地', '传说，半神阿迦玛甘倒下时，他的鲜血催生出了巨大的荆棘藤蔓。最近，有斥候报告说发现有亡灵在该地区出没，令人不禁担心是不是恐怖的天灾军团打算来征服卡利姆多了。'},
    [234]= {'剃刀沼泽', '传说，半神阿迦玛甘倒下时，他的鲜血催生出了巨大的荆棘藤蔓。许多野猪人就居住在最大的一片荆棘丛，剃刀沼泽中。他们称这里是阿迦玛甘的安息之地。'},
    [236]= {'斯坦索姆', '斯坦索姆曾是北洛丹伦的一颗明珠，但如今的人们只会记得它那悲惨的衰亡史。阿尔萨斯王子就是在这里拒绝了高贵的圣骑士光明使者乌瑟尔的帮助，屠杀了无数据信感染了可怕的亡灵瘟疫的居民。从那时起，受到诅咒的斯坦索姆就被死亡、背叛和绝望彻底毁灭了。'},
    [237]= {'阿塔哈卡神庙', '数千年前，一支强大的牧师教派，阿塔莱试图在艾泽拉斯召唤出其血腥神灵，噬魂者哈卡的化身。这令古拉巴什帝国被陷入了内战。古拉巴什人民将阿塔莱流放到悲伤沼泽。阿塔莱牧师们就在这里建造了阿塔哈卡神庙。绿龙军团的守护巨龙伊瑟拉将神庙沉入了沼泽之下，并派出守卫以阻止任何人再次进行召唤仪式。'},
    [238]= {'监狱', '建于暴风城运河下方的暴风城监狱是一座守卫森严的监狱。典狱官塞尔沃特看守着这座监狱和那些以此为家的危险罪犯。最近，这里的囚犯发生了暴动，他们打倒守卫并使监狱陷入了混乱。'},
    [239]= {'奥达曼', '奥达曼是一座深埋地下的远古泰坦宝库。据说，泰坦们在那里封印了一个失败的实验，并开始了有关矮人起源的新实验。有关蕴藏伟大知识的宝藏的传说引诱着宝藏猎人来发掘奥达曼的秘密。但潜伏在这座失落之城中的岩石守卫、野蛮穴居人、黑铁入侵者以及其他威胁令这个任务变得危险重重。'},
    [240]= {'哀嚎洞穴', '几年前，著名的德鲁伊纳拉雷克斯及其追随者走进了阴暗的哀嚎洞穴。这座洞穴的裂隙中会喷出蒸汽，其声酷似悲伤的哭号。哀嚎洞穴因此而得名。纳拉雷克斯打算利用地下温泉使荒芜的贫瘠之地恢复生机。可进入翡翠梦境之后，他却发现自己的复兴计划变成了一个活生生的噩梦，至今仍在洞中作祟。'},
    [241]= {'祖尔法拉克', '祖尔法拉克曾是塔纳利斯沙漠中的一颗明珠，由狡诈的沙怒部族守护。尽管巨魔们顽强不屈，但这支孤立无援的部落还是在漫长的历史近程中逐渐丧失了大量领土。现在，祖尔法拉克的居民们似乎正在制造一支由巨魔亡灵组成的恐怖大军，试图靠它们征服周围的地区。还有一些令人不安的流言称，这座城市里沉睡着一头古老的生物。一旦它被唤醒，死亡和毁灭就会降临塔纳利斯。'},
    [246]= {'通灵学院', '想要驾驭亡者之力的学徒们都对通灵学院这个名字并不陌生，这是位于凯尔达隆地下黑暗恐怖墓穴中的一所专修亡灵之术的邪恶学院。近些年来，学院更换了几位导师，但教学制度仍在黑暗院长加丁的牢牢掌控之下，他是一位极其施虐成性、阴险狡诈的亡灵法术研习者。'},
    [247]= {'奥金尼地穴', '被流放到德拉诺的早期流亡者发现，死亡是生命痛苦而不幸的终结，于是德莱尼便把亡者藏在了名为奥金顿的地下墓穴城市之中，这是一座位于泰罗卡森林下方的迷宫般的建筑奇迹。'},
    [248]= {'地狱火城墙', '在外域贫瘠的地狱火半岛中央，矗立着地狱火堡垒，这是一座近乎坚不可摧的要塞，在第一次和第二次战争中充当着部落的作战基地。'},
    [249]= {'魔导师平台', '在风暴要塞里落败后，凯尔萨斯·逐日者公开宣布与凶残的燃烧军团结盟。为了召唤恶魔领主基尔加丹，凯尔萨斯已经返回奎尔丹纳斯岛，为他主人的到来做着最后的准备。'},
    [250]= {'法力陵墓', '被流放到德拉诺的早期流亡者发现，死亡是生命痛苦而不幸的终结，于是德莱尼便把亡者藏在了名为奥金顿的地下墓穴城市之中，这是一座位于泰罗卡森林下方的迷宫般的建筑奇迹。'},
    [251]= {'旧希尔斯布莱德丘陵', '在时光之穴深处，沉睡的巨龙诺兹多姆被唤醒了。自从世界诞生初期，铜龙军团就在守卫着这座蜿蜒的迷宫，监视着变幻莫测的时间之流，以确保微妙的时间平衡永远不被打破。'},
    [252]= {'塞泰克大厅', '被流放到德拉诺的早期流亡者发现，死亡是生命痛苦而不幸的终结，于是德莱尼便把亡者藏在了名为奥金顿的地下墓穴城市之中，这是一座位于泰罗卡森林下方的迷宫般的建筑奇迹。'},
    [253]= {'暗影迷宫', '被流放到德拉诺的早期流亡者发现，死亡是生命痛苦而不幸的终结，于是德莱尼便把亡者藏在了名为奥金顿的地下墓穴城市之中，这是一座位于泰罗卡森林下方的迷宫般的建筑奇迹。'},
    [254]= {'禁魔监狱', '强大的风暴要塞是由神秘的纳鲁建造的，这是一群充满纯净能量的自主个体，也是燃烧军团不共戴天的死敌。除了作为纳鲁的行动基地之外，这座建筑还具有可在不同位面中自由传送的高科技，可以在转瞬之间从一个位置移动到另一个位置。'},
    [255]= {'黑色沼泽', '在时光之穴深处，沉睡的巨龙诺兹多姆被唤醒了。自从世界诞生初期，铜龙军团就在守卫着这座蜿蜒的迷宫，监视着变幻莫测的时间之流，以确保微妙的时间平衡永远不被打破。'},
    [256]= {'鲜血熔炉', '在外域贫瘠的地狱火半岛中央，矗立着地狱火堡垒，这是一座近乎坚不可摧的要塞，在第一次和第二次战争中充当着部落的作战基地。'},
    [257]= {'生态船', '强大的风暴要塞是由神秘的纳鲁建造的，这是一群充满纯净能量的自主个体，也是燃烧军团不共戴天的死敌。除了作为纳鲁的行动基地之外，这座建筑还具有可在不同位面中自由传送的高科技，可以在转瞬之间从一个位置移动到另一个位置。'},
    [258]= {'能源舰', '强大的风暴要塞是由神秘的纳鲁建造的，这是一群充满纯净能量的自主个体，也是燃烧军团不共戴天的死敌。除了作为纳鲁的行动基地之外，这座建筑还具有可在不同位面中自由传送的高科技，可以在转瞬之间从一个位置移动到另一个位置。'},
    [259]= {'破碎大厅', '在外域贫瘠的地狱火半岛中央，矗立着地狱火堡垒，这是一座近乎坚不可摧的要塞，在第一次和第二次战争中充当着部落的作战基地。'},
    [260]= {'奴隶围栏', '盘牙水库是位于赞加沼泽水底深处的一座由纳迦控制的建筑。这座水库中的地形盘根错节，遍布管阀，似乎足以容纳千军万马——但当时建造的初衷却并非真正用于军事用途。'},
    [261]= {'蒸汽地窟', '盘牙水库是位于赞加沼泽水底深处的一座由纳迦控制的建筑。这座水库中的地形盘根错节，遍布管阀，似乎足以容纳千军万马——但当时建造的初衷却并非真正用于军事用途。'},
    [262]= {'幽暗沼泽', '盘牙水库是位于赞加沼泽水底深处的一座由纳迦控制的建筑。这座水库中的地形盘根错节，遍布管阀，似乎足以容纳千军万马——但当时建造的初衷却并非真正用于军事用途。'},
    [271]= {'安卡赫特：古代王国', '当巫妖王抵达诺森德时，艾卓-尼鲁布还是个强大的帝国。尽管做了殊死抵抗，天灾军团还是推翻了这地下王国的统治，大肆屠杀王国的住民——蛛魔。经年的战争与败亡令这片广袤的领域变得伤痕累累，如今在两条战线上硝烟不断。'},
    [272]= {'艾卓-尼鲁布', '当巫妖王抵达诺森德时，艾卓-尼鲁布还是个强大的帝国。尽管做了殊死抵抗，天灾军团还是推翻了这地下王国的统治，大肆屠杀王国的住民——蛛魔。经年的战争与败亡令这片广袤的领域变得伤痕累累，如今在两条战线上硝烟不断。'},
    [273]= {'达克萨隆要塞', '达克萨隆要塞原本是达卡莱巨魔位于王国祖达克边境的强大前哨，但最近天灾军团的入侵却使得这座要塞落入了巫妖王的手中。要塞里被腐化的防御者们现在都沦为了巫妖王的亡灵仆从，正在朝达卡莱王国的中心地区推进。'},
    [274]= {'古达克', '为了拯救没落的王国，祖达克的巨魔们只得求助古老的神灵。他们将这些狂野神明视作未经利用的力量之源，他们强大的血液则成了击退巫妖王爪牙的利器，能帮巨魔们夺回已被占据的领土。英雄们近来纷纷赶往这个饱受肆虐的地区，以打击野蛮的达卡莱和他们的疯狂先知。'},
    [275]= {'闪电大厅', '在离开艾泽拉斯时，泰坦将守护奥杜尔的责任交托给了忠诚的戍守者，这是一座位于风暴峭壁群山之间的神秘城市。洛肯是他族人当中地位最为尊贵的守卫，但由于泰坦城池之力已在自己手中，他竟投入了黑暗的怀抱，使这片地区沦入混沌。'},
    [276]= {'映像大厅', '多年以来，艾泽拉斯各个种族中的勇士们挺身对抗巫妖王，结果只落得惨遭杀戮或是为他的恐怖亡灵军团效命的下场。在竭力阻止巫妖王的过程中，银色北伐军的提里奥·弗丁与黑锋骑士团的达里安·莫格莱尼联起手来，指挥一支名为灰烬审判军的联军进攻冰冠堡垒。'},
    [277]= {'岩石大厅', '在离开艾泽拉斯时，泰坦将守护奥杜尔的责任交托给了忠诚的戍守者，这是一座位于风暴峭壁群山之间的神秘城市。洛肯是他族人当中地位最为尊贵的守卫，但由于泰坦城池之力已在自己手中，他竟投入了黑暗的怀抱，使这片地区沦入混沌。'},
    [278]= {'萨隆矿坑', '多年以来，艾泽拉斯各个种族中的勇士们挺身对抗巫妖王，结果只落得惨遭杀戮或是为他的恐怖亡灵军团效命的下场。在竭力阻止巫妖王的过程中，银色北伐军的提里奥·弗丁与黑锋骑士团的达里安·莫格莱尼联起手来，指挥一支名为灰烬审判军的联军进攻冰冠堡垒。'},
    [279]= {'净化斯坦索姆', '在时光之穴深处，沉睡的巨龙诺兹多姆被唤醒了。自从世界诞生初期，铜龙军团就在守卫着这座蜿蜒的迷宫，监视着变幻莫测的时间之流，以确保微妙的时间平衡永远不被打破。'},
    [280]= {'灵魂洪炉', '多年以来，艾泽拉斯各个种族中的勇士们挺身对抗巫妖王，结果只落得惨遭杀戮或是为他的恐怖亡灵军团效命的下场。在竭力阻止巫妖王的过程中，银色北伐军的提里奥·弗丁与黑锋骑士团的达里安·莫格莱尼联起手来，指挥一支名为灰烬审判军的联军进攻冰冠堡垒。'},
    [281]= {'魔枢', '为重建自己对法术的统御地位，蓝龙统帅玛里苟斯开始了无情的行动，以断绝凡人和遍及艾泽拉斯的奥术能量之间的联结。为达到这一目的，他麾下的蓝龙军团正在将世界各处的能量传输到魔枢——玛里苟斯那高耸的巢穴当中。'},
    [282]= {'魔环', '为重建自己对法术的统御地位，蓝龙统帅玛里苟斯开始了无情的行动，以断绝凡人和遍及艾泽拉斯的奥术能量之间的联结。为达到这一目的，他麾下的蓝龙军团正在将世界各处的能量传输到魔枢——玛里苟斯那高耸的巢穴当中。'},
    [283]= {'紫罗兰监狱', '在达拉然的华丽尖塔和神秘街区间，有一股黑暗力量正在紫罗兰监狱的坚固围墙内翻腾。在这座长期被用来隔绝城市威胁的高塔里，密密麻麻地关押着无数凶险的囚犯，由肯瑞托兢兢业业地看守着。但是，一场突如其来的攻击正在考验着这座监狱的稳固性，使监狱高墙之外的所有人全都身处险境。'},
    [284]= {'冠军的试炼', '冰冠冰川的天空中浓云滚滚，英雄们聚集在那久经战火的战旗下，准备迎接即将袭来的狂风暴雨。他们说，就算是在最黑暗的乌云中也会有光芒闪现。是希望在鼓舞着银色北伐军的男女将士们——希望光明能指引他们度过这段艰难时期，希望善终将战胜恶，希望能有一位深受圣光庇佑的英雄，能挺身而出，终结巫妖王的邪恶统治。'},
    [285]= {'乌特加德城堡', '长久以来，人们都以为乌特加德城堡荒弃没落了，这是位于嚎风峡湾中央峭壁间的一处失落文明遗迹。可近来却有东西唤醒了沉睡在要塞中的住民——维库人。'},
    [286]= {'乌特加德之巅', '长久以来，人们都以为乌特加德城堡荒弃没落了，这是位于嚎风峡湾中央峭壁间的一处失落文明遗迹。可近来却有东西唤醒了沉睡在要塞中的住民——维库人。'},
    [302]= {'风暴烈酒酿造厂', '当陈·风暴烈酒抵达四风谷时，他前往了这座与自己同姓的著名酒厂，希望能和亲戚们团聚。可他却发现先祖的家园已经变得面目全非。在高老伯的无能监管下，讨厌的兔妖和顽劣的猢狲都闯进了酿酒厂，还在那搞起了破坏性的狂欢，很快就会中断当地的美酒供应。'},
    [303]= {'残阳关', '历代以来，一道名为蟠龙脊的长城保护着潘达利亚的住民，使他们免受狂暴虫族生物——螳螂妖的定期侵袭。这个凶残的种族近来突然打破了入侵周期，提早发起了进攻，打得长城守卫们措手不及。螳螂妖军队中的精兵强将冲击着久经战火的大门，潘达利亚必须抵挡住这片土地有史以来最具破坏力军队的攻势。'},
    [311]= {'血色大厅', '十字军中最勇猛善战的战士们——那些在这黑暗时期仍坚守阵地、保卫修道院免受侵犯的勇者，正在血色大厅里迅速组成一支军队。这些士兵都与亡灵有着血海深仇，愿意为实现军团的正义事业献出自己的一切。'},
    [312]= {'影踪禅院', '战争席卷了潘达利亚，而部落和联盟之间的毁灭性冲突也使庄严的影踪禅院爆发了骚乱。在那里，三个邪恶的存在——狂之煞、恨之煞和怒之煞，已逃出牢笼。虽然怒之煞彻底逃出了这座遗世独立的禅院，其余的煞魔却开始迫害那些英勇的影踪派防御者。'},
    [313]= {'青龙寺', '青龙寺是一座耸立在潘达利亚东海岸上的寺院，是为纪念传说中的熊猫人皇帝少昊于数千年前大败疑之煞而建立的神圣古迹。不久前，在翡翠林爆发的一场灾难性冲突使煞魔得以逃脱，一些实体化的煞魔对寺院最为宝贵的智慧和知识宝库发起了攻击。'},
    [316]= {'血色修道院', '十字军的疯狂领袖们把信徒引进了位于血色修道院中心位置的血色大教堂。这个守卫森严的处所成为了十字军的总指挥部，一些最为狂热和偏执的十字军成员则徘徊在这曾经的神圣之地。'},
    [317]= {'魔古山宝库', '为本族的霸业而自傲的魔古族，在一座宏伟的宝库中珍藏着关于本族伟大成就的冗长纪要。这座巨型宝库的建筑时间早于熊猫人的任何书面记载，一直深藏在神秘的面纱之后。一度有传说称其中镇锁着一支强大的军队。因此，这座宝库也成了古代熊猫人起义军的首选目标。自从魔古帝国被推翻之后，这里就被尘封至今。'},
    [320]= {'永春台', '隐于高山之巅的永春台，是锦绣谷的神圣中心。据说这里宁静的喷泉具有治疗和返老还童的力量，可当惧之煞攻来时，这里的许多守卫者却因恐惧作祟而自相残杀。'},
    [321]= {'魔古山宫殿', '古老的魔古山宫殿是魔古族势力在潘达利亚大陆上的最后一座真正的堡垒。魔古族的三大部落近来集结在这座雄伟的宫殿中，觐见他们的王——武器大师席恩。这位强大的统治者已经酝酿出一个激进的计划，要将他散乱的臣民重新联合起来，夺回属于他们覆灭帝国的荣耀。眼下混乱正席卷着潘达利亚，席恩征服一切的远大梦想很可能会变为现实。'},
    [322]= {'潘达利亚', '自从世界于一万多年以前分崩离析之后，古老的潘达利亚大陆便隐匿在浓雾之中，免受战火的侵扰。在那茂盛的丛林和云雾缭绕的群山间存在着复杂的生态系统，充满极具地方特色的种族和奇异的生物。这里是神秘的熊猫人的故乡，即便是身陷古老威胁的重围之中，熊猫人们也不忘尽情享受人生。'},
    [324]= {'围攻砮皂寺', '在那道名为蟠龙脊的雄伟长城远方，有一座砮皂寺，延伸在两座防卫森严的岛屿上。多年以来，坚韧顽强的熊猫人防御者都在守卫着连接岛屿的狭窄桥梁，令任何意欲闯入的侵略者望而却步。然而就在不久前，螳螂妖造出了自己的桥——一段大树根——并出其不意地夺取了其中一座岛屿。现在，这些凶残的虫子又信誓旦旦地宣称要攻击砮皂其余的守卫者。'},
    [330]= {'恐惧之心', '惧之煞已经腐化了螳螂妖的大女皇。她日渐疯狂和怪诞的命令迫使卡拉克西——螳螂妖文化的戍守者——采取积极行动。由于自身人数不足，卡拉克西只得勉强接受来自外界的帮助，以消灭女皇，使受到煞能负面影响的族人得到净化。'},
    [362]= {'雷电王座', '在数千年前潘达利亚从卡利姆多分离之时，迷雾笼罩着这块新形成的大陆，使它不被外来者发现。迷雾同样遮蔽着这片大陆古老的邪恶：雷神的雷电王座。在雷神统治时期，他的王座就坐落在这座城堡之中。即使在他死后，强大而堕落的能量仍然在此萦绕不绝；而现在，复活的雷电之王和赞达拉巨魔企图再次驾驭那股能量，重建昔日帝国。'},
    [369]= {'决战奥格瑞玛', '随着锦绣谷遭到破坏，加尔鲁什·地狱咆哮的傲慢所引发的紧张局势终于达到了高潮。为了彻底推翻冷酷无情的酋长，联盟和部落的领袖们联手对地狱咆哮的都城发动了攻击。'},
    [385]= {'血槌炉渣矿井', '在靠近霜火岭北部的某座活火山里，血槌食人魔野蛮地开发着一个矿井。来自德拉诺各地的奴隶被源源不断地送进矿井，最后却没有一个人能活着出来。炉渣矿井盛产宝石和矿石，但据说开掘这些矿井的真正目的是发掘一件具有无穷力量的古代圣物。'},
    [457]= {'黑石铸造厂', '这座铸造厂曾是黑石兽人祖祖辈辈生活的家园。在这里，铁匠大师们熔炼锻造着以他们氏族命名的、坚硬得不可思议的矿石。现在，雷神氏族俘虏并驯服的魁梧巨人负责加热巨型熔炉，火刃氏族的缚火者们给矿石注入火焰的能量，工程师们则按照来自异界的图纸锻造着熔渣。督军黑手的铸造厂是钢铁部落军事力量的核心，正源源不断地生产出用于侵略艾泽拉斯的武器。'},
    [476]= {'通天峰', '在阿兰卡峰林的群山之巅，高耸入云的通天峰上坐落着鲁克玛信徒的宝座。掌握了先祖的埃匹希斯技术的鸦人们聚集在一起，准备将高度凝聚的太阳能量倾泻到他们的敌人头上。'},
    [477]= {'悬槌堡', '悬槌堡是高里亚帝国的权力核心。这个食人魔文明曾世代统治着德拉诺，直到德莱尼的出现。这座巨型城市完全推翻了食人魔野蛮愚笨的形象。在悬槌堡里，有熙熙攘攘的市集，富有的贵族，角斗场中观众巨大的欢呼声回荡在贫民窟的街道上。元首马尔高克的城堡投下长长的阴影，在城墙内的任何角落都能看到，昭示着他警惕的目光和残酷的铁腕。'},
    [536]= {'恐轨车站', '恐轨车站是钢铁部落这架战争机器的交通枢纽，源源不断地将军队和黑石铸造厂生产出的物资送往遍布德拉诺的战斗前线。车站得名于“恐轨”号列车，这辆巨型火车能够装下整整一个营的部队和火炮。如今，恐轨号已经装上了一座足以轰开沙塔斯城护盾的巨型轨道炮，即将离站……'},
    [537]= {'影月墓地', '影月氏族的传统墓地是无数代影月兽人先祖的最后安息之地。堕落的酋长耐奥祖为了追求力量，牺牲了整个氏族的灵魂。如今，先祖的灵魂被惊扰、折磨，并被用来为一个黑暗的仪式提供能量。如果耐奥祖得逞的话，整个德拉诺都将被虚空所吞噬。'},
    [547]= {'奥金顿', '奥金顿是德莱尼的神圣陵墓，死者的灵魂将在这座圣光的殿堂中安息。这座水晶建筑还能保护德莱尼的灵魂不受他们的宿敌——不断渴望着德莱尼灵魂的燃烧军团的侵扰。这使得它对急于为其恶魔主子卖命的古尔丹和他的暗影议会格外有吸引力。'},
    [556]= {'永茂林地', '在干扰了黑暗之门的开启后，肯瑞托意识到要想在钢铁部落的土地上与之作战，就需要一条增援的补给线。因此，他们在德拉诺各地建立了岗哨，并用魔法将其与艾泽拉斯相连接。不幸的是，在戈尔隆德有一处靠近黑石铸造厂的战略要地却位于木精的圣地，永茂林地内。岗哨很快就被攻陷，但它仍然能够通往暴风城的郊外……'},
    [557]= {'德拉诺', '德拉诺是一片蛮荒的土地，它是兽人的诞生之地，却得名于德莱尼数百年前的避难所。几代人以来，虽然时有冲突和领土争端发生，但兽人、德莱尼和高里亚食人魔帝国始终共存。古老而原始的造物与毁灭之力冲突激荡，通过暴力维持着平衡。加尔鲁什逃离艾泽拉斯之后，醒来时就来到了这样一个世界。而现在，由于钢铁部落和古尔丹的黑手，两个世界已经命悬一线。'},
    [558]= {'钢铁码头', '坐落于戈尔隆德北部海岸的钢铁码头，在钢铁部落海军力量中有着举足轻重的地位。由黑石铸造厂锻造和组装的巨型战舰和火炮正在这座巨港中整装待发。由钢铁部落驯养的、德拉诺最强大的野兽与精锐步兵组成的地面部队随时可以涌上陆地，击溃所有敢于反抗钢铁部落的敌人。'},
    [559]= {'黑石塔上层', '这座雄伟的堡垒有着漫长而复杂的历史。数个世纪前，黑铁氏族在黑石山熔岩沸腾的腹地建成了这座堡垒，最后却被黑龙奈法利安及其子嗣所占据。而黑石塔的上层则成为了铁军先锋的大本营。钢铁部落准备将黑石塔作为其全面入侵艾泽拉斯的桥头堡，为此他们制定了一个可怕的计划：在黑石山的中心架设一座足以毁灭世界的武器。'},
    [669]= {'地狱火堡垒', '当加尔鲁什推动格罗玛什建造了这座位于塔纳安丛林中心的巨型堡垒时，是打算将其作为入侵艾泽拉斯的桥头堡。就连地狱火这个来自另一个时空、另一片土地的名字，也是来自加尔鲁什的建议。他梦想在一片未经摧残的土地上看到高耸强大的兽人钢铁建筑，而不是他记忆中那片位于外域的废土。但虽然时代已经改变，这片土地却依然如故。'},
    [707]= {'守望者地窟', '这座隐秘的守望者要塞被阿苏纳的群山遮掩，同时还被施加了魔法的封印，一方面是为了杜绝闯入者，另一方面也是为了不让封锁在要塞中的恐怖生物逃离囚牢。守望者们将许多他们所遭遇过的最危险的敌人封印在地牢之中，但经历了科达娜的叛变与军团的攻击之后，那些生物现在可以在要塞的大厅中不受拘束地行动了。'},
    [716]= {'艾萨拉之眼', '在阿苏纳海岸附近的沙洲中，古老的能量之源就隐藏在海涛下面。很久以前，艾萨拉女王的威权统治着这里的土地，而今那些寻找高戈奈斯潮汐之石的纳迦仍然在遵循着她的指令。风起云涌，空气中散乱的能量噼啪作响，预示着即将到来的风暴，艾萨拉的追随者开始召唤她的怒火，想要将整片大陆化作废墟。'},
    [721]= {'英灵殿', '在风暴峡湾高空中的云层中，泰坦守护者奥丁召集了全艾泽拉斯最强大的维库战士，组成了他的瓦拉加尔军团。这些飞升的维库人在欢宴的大厅中和狩猎场上检验着他们的力量，准备迎接即将到来的大战。如果想要来到奥丁面前，获得阿格拉玛之盾，冒险者必须穿过这些大厅，证明自己的价值。'},
    [726]= {'魔法回廊', '苏拉玛城宏伟壮丽，城市地下的管道网络所覆盖的范围比城市更加广阔。夜之子的社会生活是建立在暗夜井能量的基础之上的，而将生命之血般的暗夜井水传递到城市各处的正是地下的魔法回廊。这些迷宫般的建筑已经有数千年的历史，它深埋在城市中高大的建筑地基之下，当今生活在城市中的居民们甚至完全不知道有什么东西潜藏在他们脚下的阴影之中……'},
    [727]= {'噬魂之喉', '最伟大的维库战士死去时，灵魂将会飞往金碧辉煌的英灵殿，获得永恒的荣耀；而那些被诅咒的罪人们则会堕入噬魂之喉。在重重迷雾之中，他们将等待纳格法尔的到来，这艘由骨肉建造而成的恐惧之船将会把他们悲惨的灵魂带往冥狱之渊，落入海拉的掌握。'},
    [740]= {'黑鸦堡垒', '黑鸦堡垒是古代的精灵石匠在瓦尔莎拉的山峦中雕砌而成的，在上古之战中它是抵抗燃烧军团的壁垒。这座坚不可摧的要塞同时也是伊利丹曾经的导师库塔洛斯·拉文凯斯领主家族的故园。然而在军团最近的一次攻击之后，一股诡异的黑暗能量不断从要塞中涌出，不眠的死者开始在附近的土地上肆虐。'},
    [741]= {'熔火之心'},
    [742]= {'黑翼之巢'},
    [743]= {'安其拉废墟'},
    [744]= {'安其拉神殿'},
    [745]= {'卡拉赞'},
    [746]= {'格鲁尔的巢穴'},
    [747]= {'玛瑟里顿的巢穴'},
    [748]= {'毒蛇神殿'},
    [749]= {'风暴要塞'},
    [750]= {'海加尔山之战'},
    [751]= {'黑暗神殿'},
    [752]= {'太阳之井高地'},
    [753]= {'阿尔卡冯的宝库'},
    [754]= {'纳克萨玛斯'},
    [755]= {'黑曜石圣殿'},
    [756]= {'永恒之眼'},
    [757]= {'十字军的试炼'},
    [758]= {'冰冠堡垒'},
    [759]= {'奥杜尔'},
    [760]= {'奥妮克希亚的巢穴'},
    [761]= {'红玉圣殿'},
    [762]= {'黑心林地', '在莎拉达希尔的荫影之中，梦魇一寸寸地渗透进了这片曾经繁茂的丛林。最年长最睿智的德鲁伊曾经在这里倾听树木的声音，在伟大的世界之树下冥想，而现在，腐化与疯狂统治了一切。在这片纠缠错乱的树丛深处，梦魇之主萨维斯正在试图让他最有价值的战利品屈从于他的意志。'},
    [767]= {'奈萨里奥的巢穴', '大地的守护者奈萨里奥曾将这些洞穴作为住处，后来以“死亡之翼”的名字为世人所知。在他陨落之后，曾经崇拜这头巨龙的卓格巴尔把这座古代巢穴当作了自己的都城。如今，卓格巴尔的酋长达古尔在这些坑道中聚集起了一支庞大的部队。如果没有人阻止他们，这支军队会在卡兹格罗斯之锤的加持下冲下山崖，毁灭至高岭乃至整个艾泽拉斯。'},
    [768]= {'翡翠梦魇', '翡翠梦境是泰坦所制造的，本意是作为艾泽拉斯的一份蓝图，一份青翠而完美的镜像，保留下自然在被所谓的文明沾染之前的本来面貌。许多年来，德鲁伊和最接近自然的守护者们渐渐发现，梦境之中出现了一些不稳定的存在。在军团与梦魇之主萨维斯的刺激下，蔓延的腐化现在喷涌而出，如果不能将它从源头上截断，整个艾泽拉斯都将被它包围。'},
    [777]= {'突袭紫罗兰监狱', '在经历了诺森德之战中蓝龙军团对达拉然监狱的袭击后，紫罗兰监狱进行了一番整修。此后，它的职能转变成了收押巫妖王手下最危险的奴仆。如今，达拉然飞到了破碎群岛上空，成为了对抗军团的旗舰，然而一股黑暗的力量再次试图从内部袭击肯瑞托。'},
    [786]= {'暗夜要塞', '暗夜要塞是破碎群岛最高大的建筑，也是艾泽拉斯最宏伟的建筑之一，至今仍然是夜之子文明用来证明自己成就的地标。数个世纪以来，暗夜井为苏拉玛城提供着赖以为生的奥术能量，而暗夜要塞正是以它为中心修建的，是一座远离俗世尘嚣的避风港。然而现在，邪能风暴从曾经的月神殿中翻涌而出，古尔丹本人将这座宫殿变成了自己的居所，这里不再是所有烦恼的终结之地，而成为了一切灾祸的源头。'},
    [800]= {'群星庭院', '即使燃烧军团的部队在街头上巡逻，让苏拉玛这座伟大的城市变得如同坟墓，夜之子的贵族阶层仍然维持着他们传统与习俗。在这个晴朗的夜晚，觥筹交错的声音回响在清冷的空气中，贵族区最宏伟的府邸打开了大门，迎接一场盛宴。据传言，大魔导师艾利桑德本人也会出席，以确保她最亲密的盟友在经历了最近时局的动荡以后仍然会与她保持一致的立场。'},
    [822]= {'破碎群岛', '以精灵都城苏拉玛为中心的这片区域曾经是精灵文明的摇篮，直到大分裂撕裂了大陆。暗夜井的力量让苏拉玛城幸免于难，但这场旷世浩劫仍然在周围的大地上留下了伤痕。如今，古尔丹唤醒了萨格拉斯之墓，从至高岭山巅的牛头人部落，到瓦尔莎拉德鲁伊居住的丛林，再到星罗棋布于风暴峡湾各处的维库人村落，整片群岛都笼罩在军团的阴影之下。'},
    [860]= {'重返卡拉赞', '从它神秘诞生的那一刻起，这座阴暗塔楼的作用就与艾泽拉斯对抗燃烧军团的强大壁垒——提瑞斯法守护者的历史交织在一起。现在，它作为麦迪文的故居而广为人知，他对艾泽拉斯的背叛导致了巨大的悲剧，并使守护者的传承断绝。这样的过往使卡拉赞受到燃烧军团的特别关注，军团已经派出大军，试图在这里开辟与艾泽拉斯居民作战的另一条战线。'},
    [861]= {'勇气试炼', '自从洛肯背叛之后，奥丁就被囚禁在英灵殿中。海拉更是在阴影中策划夺取他的瓦拉加尔勇士的灵魂。但最近，伟大的英雄们追踪燃烧军团的脚步来到了风暴峡湾。奥丁召集了这些勇士，对他们进行最后的考验，希望他们的力量和决心能够扭转局面，终结海拉的统治。'},
    [875]= {'萨格拉斯之墓', '艾格文用这座神圣的月神殿来封锁被击败的萨格拉斯化身。她希望这个深埋在地下的化身可以永远长眠下去。但是这力量一直不断吸引着邪恶的存在来到此处。古尔丹再度进入古墓时，破坏了艾格文的结界，打开了一条道路，让军团得以入侵。现在，邪能军团正在这座神殿里肆虐，希望夺回他们的主人的力量。'},
    [900]= {'永夜大教堂', '萨格拉斯之墓的上层区域曾经是祭祀艾露恩的圣所。自从燃烧军团入侵以后，恶魔爪牙不断扭曲腐化，霸占了这个神圣之地。现在，一场足以扭转局势的战斗即将在这里上演。抗魔联军与燃烧军团正面交锋的同时，一小队英雄潜入大教堂上层，希望能够及时将阿格拉玛之盾放回原来的位置。'},
    [945]= {'执政团之座', '执政团之座金碧辉煌的大厅曾是阿古斯的权力中枢——直到艾瑞达与萨格拉斯达成了一笔邪恶交易。由于对维伦的抗命和出逃暴怒不已，基尔加丹下令抛弃执政团之座，以此象征过去的无足轻重……因为军团才是未来。|n|n曾经金碧辉煌的大厅如今已堕入黑暗，执政团之座辐射出黑暗能量吸引来了一批虚空追随者，妄图驾驭虚空之力并将它倾泻到敌人头上。'},
    [946]= {'安托鲁斯，燃烧王座', '安托鲁斯，燃烧王座位于阿古斯的核心。正是在这象征着威权的王座上，萨格拉斯指挥着他的爪牙，跨越宇宙进行燃烧的远征。|n|n在王座近乎无法穿透的深处，有人正将原始的力量铸造为终极的毁灭兵器。一旦这些力量苏醒并向其主人效命，万物的最终时刻就会来临。'},
    [959]= {'侵入点', '在阿古斯的大本营中，军团建造了庞大的传送门阵列，让恶魔大军能像瘟疫一样横扫宇宙。无数个世界的资源惨遭掠夺，其居民要么被迫为黑暗泰坦效命，要么就在极度痛苦的折磨中缓慢死去。|n|n如果不能解放这些世界，燃烧的远征就会吞噬其触及的一切，让焦土遍布整个宇宙。'},
    [968]= {'阿塔达萨', '千万年来，赞达拉诸王都在穆贾巴山巅的阿塔达萨的陵墓中安眠。随着一位又一位统治者的逝去，因为需要修筑新的房间来安置他们庞大的财富，这些金字塔变得越来越复杂。但现在，曾经安静的厅堂已经被先知祖尔和他信赖的副官亚兹玛所腐蚀，后者希望扭曲先王的力量，以实行他们的黑暗阴谋。'},
    [1001]= {'自由镇', '自由镇一直是一座避风港，充斥着海盗、恶棍和希望远离库尔提拉斯控制，自由生活的人。现在，铁潮突袭队用铁腕统治着这里，强迫各色海盗都听命于他们。在海盗们集结的同时，一小队英雄必须潜入镇里，消灭他们的领袖，瓦解这支日渐猖獗的凶恶帮派。'},
    [1002]= {'托尔达戈', '托尔达戈曾经是座秩序井然的监狱，但后来被艾什凡公司收购运营。如今，只要有人胆敢反抗艾什凡贸易公司，就会被无限期地羁押在这里。'},
    [1012]= {'暴富矿区！！', '科赞岛因为卡亚罗火山爆发而破败不堪，如今却在萨格拉斯对艾泽拉斯的那一击之后冒出了大量艾泽里特。商业大亨拉兹敦克想要捞上一笔，为拿下贸易亲王的头衔积攒资金。他一门心思让风险投资公司利用艾泽里特来研发武器，好将成果卖给出价最高的买家。'},
    [1021]= {'维克雷斯庄园', '维克雷斯庄园一直是统治德鲁斯瓦的家族的宅邸，有如宫殿一般宏伟。但现在，自从勋爵和夫人闭门不出，这里就成了黑暗谣言的中心。坊间传闻这里在进行秽邪的仪式，夜里有人消失，庄园里还不断传出可怕的尖叫。从这些低语中只能确定一件事，就是维克雷斯家族的这座庄园里，有种邪恶的东西正生根发芽。'},
    [1022]= {'地渊孢林', '在纳兹米尔的沼泽深处，有一种腐化正在地底蔓延。如果不立刻清除，它就会像可怕的瘟疫一样扩散到全世界，只留下溃烂和腐败。'},
    [1023]= {'围攻伯拉勒斯', '艾什凡女勋爵趁着首都防御空虚，把她的怒火发泄到了这里。在伯拉勒斯陷入战火之际，一小队英雄必须镇压艾什凡制造的混乱，阻止她夺取这片地区的阴谋。'},
    [1028]= {'艾泽拉斯', '虽然大多数威胁艾泽拉斯和平的敌人都深藏在古代密室，或是高耸的堡垒中，但有些敌人却敢明目张胆地在光天化日之下为非作歹。聪明人可能会为求自保而远离这些可怕的怪物，但是荣耀只属于敢于挑战最强大的敌人，不断磨砺自己的英雄。'},
    [1030]= {'塞塔里斯神庙', '数个世纪之前，强大的蛇神塞塔里斯牺牲了自己，阻止了米斯拉克斯释放其主人的阴谋，拯救了艾泽拉斯。那一战之后，她虔诚的信徒将她的遗体转移到这里，并修建了一座神庙以静候她的重生。现在，有股黑暗的力量在这座神庙中兴风作浪，想要扭曲她的力量来达成邪恶的目的。'},
    [1031]= {'奥迪尔', '千万年前，泰坦为了理解其宿敌的本质，建造了这座复杂的地下设施，以便隔离样本并进行研究。他们希望通过研究束缚上古之神的虚空能量，并探索其弱点和反应，从而找出解决这种威胁的办法。但他们却因此铸成了大错。这座设施被封印了，里面的恐怖怪物本来再也没有机会重现艾泽拉斯。可如今，这些封印已经被破坏……'},
    [1036]= {'风暴神殿', '风暴神殿是斯托颂家族和海潮贤者的力量中心。他们在这里举行仪式，祝福库尔提拉斯舰队在战斗中所向披靡。但是，一股黑暗的力量腐化了神圣的殿堂，企图盗取这支舰队的永久控制权。'},
    [1041]= {'诸王之眠', '诸王之眠是全赞达拉最为神圣的地方。所有统治过赞达拉帝国的君王、征服者或者暴君都在这座宏伟的亡者之城安息，他们的肉体和灵魂在这里得到保护，受到祭拜。|n|n一直以来，这里只有赞达拉祭司和皇室才能进入，但如今，祖尔的黑暗魔法正在墓室间穿梭。你必须深入其中，阻止酝酿中的黑暗。'},
    [1176]= {'达萨罗之战', '达萨罗是雄伟的赞达拉帝国的中心，纵然已经古老得超出了历史的记忆，但却依然傲然屹立。城市的卫兵已经击退了无数次对拉斯塔哈大王的袭击，城市本身从古至今也经历了许多考验。但战火又一次蔓延到了祖达萨的海岸线上，联盟冒着极大的风险围攻这座金字塔，想要斩断赞达拉巨魔与部落的联系。'},
    [1177]= {'风暴熔炉', '潜藏已久的邪恶之力正在风暴神殿下方蠢蠢欲动。逼疯斯托颂勋爵的低语在深渊中回响，那是一首包含诡谲之力的海妖之歌。聆听并遵从这声音的人们正在准备进行黑暗的仪式以实现其主人的意志。不管他们狂热的行动是为了实现何种梦魇般的计划，有一件事是肯定的：必须阻止他们。'},
    [1178]= {'麦卡贡行动', '艾拉兹敏王子率领着一群神奇的盟友，孤注一掷地深入麦卡贡的心脏。他们必须争分夺秒地击溃麦卡贡国王的机械怪物组成的大军，并击败这个疯狂的天才，否则，他的末日装置将会把艾泽拉斯的所有有机生物全部消灭。'},
    [1179]= {'永恒王宫', '一万年前，海水涌入辛艾萨莉时，艾萨拉女王与恩佐斯进行了一笔黑暗的交易，将她忠实的臣民全都变成了阴险的纳迦。经过了几千年的残酷征伐，艾萨拉在古老的废墟上建立了一个崭新的帝国。曾经威胁要夺取她生命的深渊，如今已经是她的领域。她作为一名亲切的主人，盛情邀请联盟和部落进入她的永恒王宫，以见证她光荣的晋升……以及联盟和部落最终的陨落。'},
    [1180]= {'尼奥罗萨，觉醒之城', '沉睡之城尼奥罗萨已然觉醒。在恩佐斯的号令之下，黑暗帝国的大军即将吞没世界，并按主人的愿景将其重塑。如今，唯一的希望就是：使用已修复完成的泰坦熔炉，将腐蚀者一劳永逸地根除。但要将熔炉的力量对准恩佐斯，艾泽拉斯的勇士就必须深入这片可怕的领域，与这名上古之神进行最终的对决。'},
    [1182]= {'通灵战潮', '出于不可思议的原因，玛卓克萨斯这个以守护暗影界为己任的国度发生了叛乱，派出了军队入侵勇气神庙。他们劫掠着心能，将陨落的格里恩用于他们邪恶的计划。如果不加阻止，浮空城佐尔拉姆斯的通灵大军会把晋升堡垒夷为平地。'},
    [1183]= {'凋魂之殇', '在凋零密院的废墟下，掩藏着玛卓克萨斯的一种强大的毁灭之力。垂涎这份力量的人们争前恐后地在这片被魔药侵染的残骸中搜索着武器，希望能为自己所用。无论谁拿到了这份财宝，都能掌握暗影界的命运。'},
    [1184]= {'塞兹仙林的迷雾', '名为塞兹仙林的葱郁林地一直都由法夜精心保护着，因为这里是一处神圣的土地，保存了远古的秘密。据说，旅行者如果不小心，就会永远迷失在被迷雾所笼罩的无数岔路中。但心能的枯竭让炽蓝仙野的森林日渐枯萎，敌人也想要劫掠这片林地的强大魔法。即使是这个国度的原住民，也因为饥饿和绝望而开始吞噬寒冬女王所最珍视的东西。'},
    [1185]= {'赎罪大厅', '在指控者的号令之下，赎罪大厅曾经为雷文德斯的使命带来累累硕果。虽然大厅中回响着苦难和罪孽之声，但这一切都是为了救赎灵魂，使其不坠入噬渊。但最近掌权的宫务大臣却自私的将大厅用于收割心能。由于收割的心能过多，灵魂无法得到救赎。必须有人前来终结这里不断滋生的堕落行为。'},
    [1186]= {'晋升高塔', '晋升高塔飘浮在云端，体现着格里恩理念的巅峰，是执政官的权力宝座。她作为晋升堡垒的统治者，无数纪元里从未遭受质疑和挑战。她一直都是职责和奉献这些美德的化身。但心能枯竭和时局的不稳定让晋升者的信仰系统产生了裂痕，执政官的统治面临着无法想象的威胁，因为她最信任的一位追随者听信了最黑暗的魔鬼的谗言。'},
    [1187]= {'伤逝剧场', '在玛卓克萨斯，你必须不断面对考验，以证明自己是暗影界最强的守护者。而最能证明自己的地方就是伤逝剧场。如织的参赛者彼此对垒，想要挑战这里的勇士。凶狠！混乱！残暴！痛苦！只有最强大的人才能成为他们所属密院的勇士，这份殊荣独一无二。'},
    [1188]= {'彼界', '邦桑迪在暗影界有个隐秘的场所，他管这里叫彼界。死者被大量送往噬渊时，邦桑迪把其中一部分藏在了他的小小领域里，从而确保自己的巨魔追随者的安全。但这样做打破了他与穆厄扎拉的古老约定。如今，这个古老的洛阿神灵不仅前来收割这些灵魂，还要摧毁他们的守护者。邦桑迪需要人帮忙收集他的一些交易的成果，这样他才能在这场袭击中存活下来，并保护这里的灵魂。'},
    [1189]= {'赤红深渊', '赤红深渊隐藏在纳斯利亚堡的地下深处，这座监狱是用来关押德纳修斯大帝最关注的异见者的。这里的囚犯会被关押许多纪元，他们的心能会被抽出来用于研究。堕罪抵抗军知道这里有个特殊的囚犯，有了他，在与德纳修斯的战争中就能占据上风。他们希望有人能提供协助，把他救出来。'},
    [1190]= {'纳斯利亚堡', '长久以来，雷文德斯的居民一直从骄傲的灵魂身上收割着心能，而德纳修斯大帝一直统治着这些居民。但随着心能枯竭和恐惧在暗影界蔓延，德纳修斯的真正主人是谁也终于真相大白。为了反抗他从前的主宰者，高尚的雷纳索尔王子集结起剩余的盟友，发起了孤注一掷的行动，想要潜入纳斯利亚堡，将德纳修斯大帝从权利宝座上赶下台。'},
    [1192]= {'暗影界', '暗影界是位于凡人国度艾泽拉斯的彼岸的世界，生命死去时，亡魂会来到这里。拥有强大力量的仲裁官曾经可以指引这些灵魂前往无数个不同的亡者国度。但现在，所有灵魂都会被送到永恒折磨之地——噬渊。现在，暗影界的居民，从晋升堡垒平和的格里恩和炽蓝仙野的法夜，到雷文德斯狡诈的温西尔和玛卓克萨斯好战的通灵领主，都必须联合起来，纠正灵魂的流向。'},
    [1193]= {'统御圣所', '许多纪元以来，典狱长一直都被束缚在噬渊之内。如今，他已经集结了无尽的大军，还拓展了噬渊的边界，试图吞噬奥利波斯。毁灭即将降临之时，伯瓦尔引领着残存的盟友，对托加斯特的核心发起了进攻，想要在典狱长力量最为强大的地方与其对峙。'},
    [1194]= {'塔扎维什，帷纱集市', '无情的财团老板索·莉亚打算发起一场横跨诸界的大劫案，意图将元尊的奥秘据为己有。唯一与她作对的，就是声名狼藉的艾·达里尔和他临时召集的草台班子。他们必须在神秘莫测的帷纱集市中探寻一条明路，阻止索·莉亚染指禁忌的力量。'},
    [1195]= {'初诞者圣墓', '典狱长已经进入了暗影界的神秘心脏——初诞者圣墓。如果控制了其中的原始能量，他就能重塑宇宙，以死亡之力为尊。当佐瓦尔企图准备统御现实之际，艾泽拉斯的勇士们也在勇敢进军，希望能够阻止他的计划。谁的意志将最终胜出？'},
    [1196]= {'蕨皮山谷', '蕨皮山谷是巨龙群岛规模最大的豺狼人聚居地，隐藏着难以言喻的危险。腐朽正从山谷中渗出，蔓延到碧蓝林海的各个豺狼人部族之中，企图腐化所有生灵。山谷的中心居住着蕨皮领袖，也隐藏着她与扭曲的同胞欣然分享的知识。'},
    [1197]= {'奥达曼：提尔的遗产', '奥达曼是一座古老的泰坦设施，很久以前，英雄守护者提尔的盟友将诺甘农圆盘隐藏于此。|n|n回归巨龙群岛之后，阿莱克丝塔萨女王得知奥达曼中尘封着另一片圆盘……里面保存着提尔的记忆。阿莱克丝塔萨相信这些知识有助于恢复守护巨龙之力，她恳求她的凡人盟友们勇敢直面奥达曼的危险，恢复提尔的记忆，以此守护龙裔的未来。'},
    [1198]= {'诺库德阻击战', '在诺库德氏族囚禁上古鹰隼之魂后，氏族内战如野火燎原，在欧恩哈拉平原上蔓延开来。对其余氏族来说，欧恩哈拉不仅仅是一只鹰魂，更是他们的女神。拜荒者召唤出元素力量，通灵师则对半人马之魂发号施令。被敌人围攻的马鲁克氏族团结一心。远处诺库德的暴君居高临下，这位巴拉卡可汗正在高声指挥着自己的军队。在敌方部队溃败之前，他们都会无情地发起进攻。一场大战在即。'},
    [1199]= {'奈萨鲁斯', '黑曜堡垒的下方就是奈萨鲁斯，黑龙军团的珍宝和传奇铸工的秘密就藏在这里。当贾拉丁从沉眠中苏醒，他们将奈萨鲁斯选做了袭击的突破口。他们惊讶地发现此地荒废已久，并立即将深藏的秘密据为己有……还夺占了黑曜堡垒的其余部分。'},
    [1200]= {'化身巨龙牢窟', '拜荒者攻破了上万年来用以关押化身巨龙的泰坦牢窟。 莱萨杰丝则在牢窟里面举行了一个邪恶仪式，借此释放她的巨龙同胞。这样一来，所有化身巨龙就可以合力抹除泰坦对这个世界的影响。艾泽拉斯的勇士必须攻击这座坚不可摧的堡垒，冲破对方的防御攻势，结束这场威胁。纵使损兵折将在所难免，但如果战线溃败，所有王国都会陷入化身巨龙烈火血腥的统治之中。'},
    [1201]= {'艾杰斯亚学院', '很久以前，宏伟的艾杰斯亚学院是所有龙族接受高等教育之地。尽管学院和群岛上的其他地方一样陷入了沉眠，但最近已经重新开放，并在首席教师多拉苟萨的指导下走向正轨。学院迎来了一连串的可喜变化，目前正在寻找龙族及其他种族的新学生和志愿者，以此帮助这座教学殿堂恢复往日语笑喧哗的盛景。相信在学院操场上散步的人一定会学到些新东西。'},
    [1202]= {'红玉新生法池', '作为五大巨龙军团的先祖巢穴，红玉新生法池是一片神圣之地。红龙军团负责孕育所有的生命，他们保护着这些法池，也守护着所有龙族的未来。|n|n然而，莱萨杰丝和她的拜荒者们已经到来，他们试图盗走龙族的未来，并将自己的力量注入神圣的法池。只有阻止他们的疯狂行径，才能让龙族茁壮成长。'},
    [1203]= {'碧蓝魔馆', '很久以前，玛里苟斯创立了碧蓝魔馆，供辛达苟萨在此编目和存放他所找到的魔法神器。经过了上万年的封闭与废弃，魔馆早已年久失修，极易受到来自外部……以及内部的威胁。'},
    [1204]= {'注能大厅', '注能大厅深藏在提尔要塞下方。这座建筑位于一处远古水源之上，守护者提尔将这里的水源引向了红龙军团的新生法池。 随着巨龙群岛的苏醒，拜荒者部队入侵了这些大厅。他们是来摧毁这里……还是想要揭露提尔留下的秘密？'},
    [1205]= {'巨龙群岛', '曾经，五色巨龙军团统御着巨龙群岛的天空。但一万年前，巨龙军团离开了这里，前去抗击艾泽拉斯的敌人。但最近，群岛已经复苏，它呼唤着失落多年的管理者重归故土。但巨龙军团并不是唯一归来的龙群——四只原始的巨龙也来到了这里：巴斯律孔，掌控着土地与页岩；斯图恩兰，电能风暴的主宰者；巴祖阿尔，火焰的操纵者；以及利斯卡诺兹，坚冰与严寒之主。'},
    [1206]= {'诺库德的攻势', '平原打响了半人马之战。巴拉卡可汗背弃了他的人民，转而和拜荒者部队沆瀣一气，对其他半人马氏族和绿龙盟友倒戈相向。风暴法师在战场上召唤出了元素，而席卡尔的弩炮则击退了拜荒者始祖龙。暴虐无道的巴拉卡俘获了风之女神欧恩哈拉。如果能拿下可汗，解放风神，我们就能解放这片土地。'},
    [1207]= {'阿梅达希尔，梦境之愿', '阿梅达希尔一直在翡翠梦境中受到精心滋养，现在它做好了盛放的准备，即将进入艾泽拉斯。但艾泽拉斯的勇士们必须团结一致，直面菲莱克和他的烈焰盟友，阻止他吞噬阿梅达希尔之心并让世界陷入火海。唯有如此，才能最终让新生的世界之树实现它的命运。'},
    [1208]= {'亚贝鲁斯，焰影熔炉', '奈萨里奥在上万年前建立了亚贝鲁斯，这是座秘密的实验室，他在那里开展足以扭转世界的试验。最近，亚贝鲁斯重新进入了世人的目光，许多势力都对其发起了进攻，企图将大地守护者的遗产据为己有。艾泽拉斯的勇士们必须投身暗影之中，确保奈萨里奥的黑暗力量不会落入恶人之手。'},
    [1209]= {'永恒黎明', '一万年来，青铜神殿一直沉寂着，等待着青铜龙军团的回归。但青铜龙刚刚夺回自己的神殿，黑暗的力量就企图夺走它。永恒龙会控制时间流，并让姆诺兹多崛起吗？艾泽拉斯的勇士们必须在时光里冒险，确保艾泽拉斯拥有光明的未来。'},
    [1210]= {'暗焰裂口', '暗焰裂口曾是一处繁荣的土灵矿场，但最终还是日落西山。土灵机语者走了，不久之后，狗头人蜂拥而至。工人们很快就受到了暴君蜡烛之王的压迫。这个高大残忍的家伙比他臣民的块头大得多。显眼的财富很久之前就被榨干了。这里真正的良机是击败蜡烛之王仅存的凶残打手，解放其中受尽恐吓的狗头人。'},
    [1267]= {'圣焰隐修院', '圣焰隐修院是为狂热的信徒所建，供其在此研究帝皇幻象的奥秘。这里的信徒远离米雷达尔的人民，鄙视他们软弱的信仰。艾特娜·布雷兹修女正在寻求帮助，希望能够查清隐修院长穆普雷在内部密室中隐藏的秘密。'},
    [1268]= {'驭雷栖巢', '风暴之栖不仅是雷鸫的家园和栖息地，也是风暴护持贝尔格里姆和驭雷者的军营和总部。数千年来，风暴之栖从未被土灵的敌人攻破。可坚固的城堡总是从内部被攻破，驭雷栖巢的防御工事的情况也不容乐观。'},
    [1269]= {'矶石宝库', '矶石宝库是一处毗邻觉醒大厅的设施，由机语者负责维护。而后者的前任领袖高阶代言人艾里奇，最近因感染虚空腐化而被废黜。机械师们在劳作，拥护者们在巡逻，艾里奇则躲在他最狂热和腐败的追随者身后。他隔离在泰坦通道的后面，并经历了一次可怕的转变。为了确保他不会重新掌权，你必须迅速采取行动。'},
    [1270]= {'破晨号', '阿拉希人的旗舰破晨号已经建造完成。这艘全新的战舰拥有强大的火力，可以在对抗艾基-卡赫特的漫长战争中扭转战局。首航仪式即将开始，斯蒂泰克将军邀请了英勇的外来者来见证这一历史性的时刻。'},
    [1271]= {'艾拉-卡拉，回响之城', '艾拉-卡拉，回响之城就在千丝之城的下方，是后者被遗弃的前层废墟。安苏雷克的部队正在那里收割危险的材料，试图在必要的时候让所有蛛魔扬升——无论他们情愿与否。'},
    [1272]= {'燧酿酒庄', '老板换人了！燧酿酒庄曾经饱含无缚者土灵文化的精髓，在文布兰德的老派管理下酿造出了所有土灵都赞不绝口的烈性美酒。可如今，酒庄被一位地精老板戈尔迪·底爵恶意收购，走进了大批量生产燧酿的“新纪元”。'},
    [1273]= {'尼鲁巴尔王宫', '尼努巴尔王宫坐落于艾基-卡赫特王国深处，是安苏雷克女王的权力宝座。安苏雷克女王端坐在阴影中，施展自己的权术，逼迫她的苏雷吉追随者迈向黑暗的未来。她的偏执日渐增长，而密谋抗争的斩离之丝成员也发起了绝地反击，希望能够终结安苏雷克的统治。'},
    [1274]= {'千丝之城', '蜕躯工厂位于千丝之城的深处——这里曾经是蛛魔进化的神圣大厅，如今成为了“适格”蛛魔的扬升之地。纺丝者和宰相愿意不惜一切代价阻止其中的勾当，以防它将整个艾基-卡赫特吞噬殆尽。'},
    [1278]= {'卡兹阿加'},
    [1279]= {'真菌之愚'},
    [1280]= {'丝菌师洞穴'},
    [1281]= {'克莱格瓦之眠'},
    [1282]= {'水能堡'},
    [1283]= {'无底沉穴'},
    [1284]= {'塔克-雷桑深渊'},
    [1285]= {'夜幕圣所'},
    [1286]= {'幽暗要塞'},
    [1287]= {'地匍矿洞'},
    [1288]= {'恐惧陷坑'},
    [1289]= {'飞掠裂口'},
    [1290]= {'螺旋织纹'},
    [1291]= {'泽克维尔的巢穴'},
    --[1293]= {'The Underkeep'},
}







--###########
--加载保存数据
--###########
local panel= CreateFrame("Frame")
panel:RegisterEvent("ADDON_LOADED")
panel:SetScript("OnEvent", function(self, _, arg1)
    if arg1==id then
        if not e.disbledCN then 
            for journalInstanceID, info in pairs(tab) do
                local desc= info2
                local name= EJ_GetInstanceInfo(journalInstanceID)
                if name then
                    e.strText[name]= info[1]
                end
                tab[journalInstanceID]= desc
            end

        end
        self:UnregisterAllEvents()
    end
end)
