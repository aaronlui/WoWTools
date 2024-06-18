local id, e = ...
if e.Player.region~=3 and not e.Is_PTR then-- LOCALE_zhCN or LOCALE_zhTW 
    return
end



--https://wago.tools/db2/JournalEncounterCreature?build=11.0.0.55120&locale=zhCN
--['Name_lang']= {JournalEncounterID, OrderIndex},
local bossTab={    
['格拉布托克']= {89, 0},
['赫利克斯·破甲']= {90, 0},
['死神5000']= {91, 0},
['撕心狼将军']= {92, 0},
['“船长”曲奇']= {93, 0},
['梵妮莎·范克里夫']= {95, 0},
['灰葬男爵']= {96, 0},
['席瓦莱恩男爵']= {97, 0},
['指挥官斯普林瓦尔']= {98, 0},
['沃登勋爵']= {99, 0},
['高弗雷勋爵']= {100, 0},
['纳兹夏尔女士']= {101, 0},
['指挥官乌尔索克']= {102, 0},
['蛊心魔古厄夏']= {103, 0},
['厄祖玛特']= {104, 0},
['摧骨者罗姆欧格']= {105, 0},
['柯尔拉，暮光之兆']= {106, 0},
['卡尔什·断钢']= {107, 0},
['如花']= {108, 0},
['升腾者领主奥西迪斯']= {109, 0},
['克伯鲁斯']= {110, 0},
['岩皮']= {111, 0},
['欧泽鲁克']= {112, 0},
['高阶女祭司艾苏尔']= {113, 0},
['大宰相埃尔坦']= {114, 0},
['阿尔泰鲁斯']= {115, 0},
['阿萨德']= {116, 0},
['胡辛姆将军']= {117, 0},
['奥弗']= {118, 1},
['锁喉']= {118, 0},
['高阶预言者巴林姆']= {119, 0},
['希亚玛特']= {122, 0},
['神殿守护者安努尔']= {124, 0},
['地怒者塔赫']= {125, 0},
['安拉斐特']= {126, 0},
['伊希斯特']= {127, 0},
['阿穆纳伊']= {128, 0},
['塞特斯']= {129, 0},
['拉夏']= {130, 0},
['乌比斯将军']= {131, 0},
['铸炉之主索朗格斯']= {132, 0},
['达加·燃影者']= {133, 0},
['瓦里昂娜']= {133, 1},
['埃鲁达克']= {134, 0},
['阿尔加洛斯']= {139, 0},
['欧库塔尔']= {140, 0},
['尼希尔']= {154, 1},
['安舍尔']= {154, 0},
['洛哈西']= {154, 2},
['奥拉基尔']= {155, 0},
['哈尔弗斯·碎龙者']= {156, 0},
--['瓦里昂娜']= {157, 1},
['瑟纳利昂']= {157, 0},
['泰拉斯卓']= {158, 3},
['源质畸体']= {158, 4},
['伊格纳休斯']= {158, 1},
['费伦迪乌斯']= {158, 0},
['艾里昂']= {158, 2},
['古加尔']= {167, 0},
['希奈丝特拉']= {168, 0},
['电荷金刚']= {169, 2},
['剧毒金刚']= {169, 3},
['熔岩金刚']= {169, 0},
['奥能金刚']= {169, 1},
['熔喉']= {170, 0},
['艾卓曼德斯']= {171, 0},
['奇美隆']= {172, 0},
['马洛拉克']= {173, 0},
--['奥妮克希亚']= {174, 1},
--['奈法利安']= {174, 0},
['高阶祭司温诺希斯']= {175, 0},
['血领主曼多基尔']= {176, 0},
['格里雷克']= {177, 0},
['哈扎拉尔']= {178, 0},
['雷纳塔基']= {179, 0},
['乌苏雷']= {180, 0},
['高阶祭司基尔娜拉']= {181, 0},
['赞吉尔']= {184, 0},
['碎神者金度']= {185, 0},
['埃基尔松']= {186, 0},
['纳洛拉克']= {187, 0},
['加亚莱']= {188, 0},
['哈尔拉兹']= {189, 0},
['妖术领主玛拉卡斯']= {190, 0},
['达卡拉']= {191, 0},
['贝丝缇拉克']= {192, 0},
['雷奥利斯领主']= {193, 0},
['奥利瑟拉佐尔']= {194, 0},
['沙恩诺克斯']= {195, 0},
['管理者鹿盔']= {197, 0},
--['拉格纳罗斯']= {198, 0},
['伐木场巨怪']= {90, 1},
['贝尔洛克']= {196, 0},
['泰兰德的残影']= {283, 0},
['姆诺兹多']= {289, 0},
--['死亡之翼']= {318, 0},
['缚风者哈格拉']= {317, 0},
['阿奎里恩']= {322, 0},
['希尔瓦娜斯的残影']= {323, 0},
--['艾萨拉女王']= {291, 0},
['督军佐诺兹']= {324, 0},
['奥卓克希昂']= {331, 0},
['不眠的约萨希']= {325, 0},
['战争大师黑角']= {332, 0},
['莫卓克']= {311, 0},
['佩罗萨恩']= {290, 0},
['阿丽萨巴尔']= {339, 0},
['大主教本尼迪塔斯']= {341, 0},
['贝恩的残影']= {340, 0},
['吉安娜的残影']= {285, 0},
['埃希拉·黎明克星']= {342, 0},
['死亡之翼']= {333, 0},
--['玛诺洛斯']= {292, 0},
['禁卫队长瓦罗森']= {292, 1},
['审讯官格斯塔恩']= {369, 0},
['洛考尔']= {370, 0},
['驯犬者格雷布玛尔']= {371, 0},
['控火师罗格雷恩']= {373, 0},
['伊森迪奥斯']= {374, 0},
['典狱官斯迪尔基斯']= {375, 0},
['弗诺斯·达克维尔']= {376, 0},
['贝尔加']= {377, 0},
['怒炉将军']= {378, 0},
['傀儡统帅阿格曼奇']= {379, 0},
['霍尔雷·黑须']= {380, 0},
['法拉克斯']= {381, 0},
['普拉格']= {383, 0},
['弗莱拉斯大使']= {384, 0},
['玛格姆斯']= {386, 0},
['达格兰·索瑞森大帝']= {387, 0},
['欧莫克大王']= {388, 0},
['暗影猎手沃什加斯']= {389, 0},
['指挥官沃恩']= {390, 0},
['烟网蛛后']= {391, 0},
['尤洛克·暗嚎']= {392, 0},
['军需官兹格雷斯']= {393, 0},
['哈雷肯']= {394, 0},
['奴役者基兹鲁尔']= {395, 0},
['维姆萨拉克']= {396, 0},
['瑟雷姆·刺蹄']= {402, 0},
['海多斯博恩']= {403, 0},
['蕾瑟塔蒂丝']= {404, 0},
['荒野变形者奥兹恩']= {405, 0},
['特迪斯·扭木']= {406, 0},
['伊琳娜·暗木']= {407, 0},
['卡雷迪斯镇长']= {408, 0},
['伊莫塔尔']= {409, 0},
['托塞德林王子']= {410, 0},
['卫兵摩尔达']= {411, 0},
['践踏者克雷格']= {412, 0},
['卫兵芬古斯']= {413, 0},
['卫兵斯里基克']= {414, 0},
['克罗卡斯']= {415, 0},
['观察者克鲁什']= {416, 0},
['戈多克大王']= {417, 0},
['群体打击者9-60']= {418, 0},
['格鲁比斯']= {419, 0},
['电刑器6000型']= {421, 0},
['机械师瑟玛普拉格']= {422, 0},
['诺克赛恩']= {423, 0},
['锐刺鞭笞者']= {424, 0},
['工匠吉兹洛克']= {425, 0},
['维利塔恩']= {427, 0},
['被诅咒的塞雷布拉斯']= {428, 0},
['兰斯利德']= {429, 0},
['洛特格里普']= {430, 0},
['瑟莱德丝公主']= {431, 0},
['弗雷斯特恩']= {443, 0},
['阿库麦尔']= {444, 0},
['悲惨的提米']= {445, 0},
['希望破坏者威利']= {446, 0},
['档案管理员加尔福特']= {448, 0},
['巴纳扎尔']= {449, 0},
['不可宽恕者']= {450, 0},
['安娜丝塔丽男爵夫人']= {451, 0},
['奈鲁布恩坎']= {452, 0},
['苍白的玛勒基']= {453, 0},
['巴瑟拉斯镇长']= {454, 0},
['吞咽者拉姆斯登']= {455, 0},
['奥里克斯·瑞文戴尔领主']= {456, 0},
['哈卡的化身']= {457, 0},
['预言者迦玛兰']= {458, 0},
['德姆塞卡尔']= {459, 0},
['伊兰尼库斯的阴影']= {463, 0},
['霍格']= {464, 0},
['灼热勋爵']= {465, 0},
['兰多菲·摩洛克']= {466, 0},
['鲁维罗什']= {467, 0},
--['迅捷的埃瑞克']= {468, 1},
--['奥拉夫']= {468, 2},
--['巴尔洛戈']= {468, 0},
['艾隆纳亚']= {469, 0},
['远古巨石卫士']= {470, 0},
['加加恩·火锤']= {471, 0},
['格瑞姆洛克']= {472, 0},
['阿扎达斯']= {473, 0},
['安娜科德拉']= {474, 0},
['考布莱恩']= {475, 0},
['皮萨斯']= {476, 0},
['克雷什']= {477, 0},
['斯卡姆']= {478, 0},
['瑟芬迪斯']= {479, 0},
['永生者沃尔丹']= {480, 0},
['吞噬者穆坦努斯']= {481, 0},
['加兹瑞拉']= {483, 0},
['安图苏尔']= {484, 0},
['殉教者塞卡']= {485, 0},
['巫医祖穆拉恩']= {486, 0},
['耐克鲁姆']= {487, 0},
['杜姆雷尔']= {385, 0},
['乌克兹·沙顶']= {489, 0},
['死亡观察者希尔拉克']= {523, 0},
['大主教玛拉达尔']= {524, 0},
['巡视者加戈玛']= {527, 0},
['无疤者奥摩尔']= {528, 0},
['传令官瓦兹德']= {529, 0},
['塞林·火心']= {530, 0},
['维萨鲁斯']= {531, 0},
['女祭司德莉希亚']= {532, 0},
--['凯尔萨斯·逐日者']= {533, 0},
['潘德莫努斯']= {534, 0},
['塔瓦洛克']= {535, 0},
['尤尔']= {536, 0},
['节点亲王沙法尔']= {537, 0},
['德拉克中尉']= {538, 0},
['斯卡洛克上尉']= {539, 0},
['时空猎手']= {540, 0},
['黑暗编织者塞斯']= {541, 0},
['安苏']= {542, 0},
['利爪之王艾吉斯']= {543, 0},
['赫尔默大使']= {544, 0},
['煽动者布莱卡特']= {545, 0},
['沃匹尔大师']= {546, 0},
['摩摩尔']= {547, 0},
['自由的瑟雷凯斯']= {548, 0},
['末日预言者达尔莉安']= {549, 0},
['天怒预言者苏克拉底']= {550, 0},
['预言者斯克瑞斯']= {551, 0},
['时空领主德亚']= {552, 0},
['坦普卢斯']= {553, 0},
['埃欧努斯']= {554, 0},
['制造者']= {555, 0},
['布洛戈克']= {556, 0},
['击碎者克里丹']= {557, 0},
['指挥官萨拉妮丝']= {558, 0},
['高级植物学家弗雷温']= {559, 0},
['看管者索恩格林']= {560, 0},
['拉伊']= {561, 0},
['迁跃扭木']= {562, 0},
['机械领主卡帕西图斯']= {563, 0},
['灵术师塞比瑟蕾']= {564, 0},
['计算者帕萨雷恩']= {565, 0},
['高阶术士奈瑟库斯']= {566, 0},
['战争使者沃姆罗格']= {568, 0},
['酋长卡加斯·刃拳']= {569, 0},
['背叛者门努']= {570, 0},
['巨钳鲁克玛尔']= {571, 0},
['夸格米拉']= {572, 0},
['水术师瑟丝比娅']= {573, 0},
['机械师斯蒂里格']= {574, 0},
['督军卡利瑟里斯']= {575, 0},
['霍加尔芬']= {576, 0},
['加兹安']= {577, 0},
['沼地领主穆塞雷克']= {578, 0},
['黑色阔步者']= {579, 0},
['纳多克斯长老']= {580, 0},
--['塔达拉姆王子']= {581, 0},
['耶戈达·觅影者']= {582, 0},
['埃曼尼塔']= {583, 0},
['看门者克里克希尔']= {585, 0},
['哈多诺克斯']= {586, 0},
['托尔戈']= {588, 0},
['召唤者诺沃斯']= {589, 0},
['暴龙之王爵德']= {590, 0},
['斯拉德兰']= {592, 0},
['达卡莱巨像']= {593, 0},
['莫拉比']= {594, 0},
['凶残的伊克']= {595, 0},
['迦尔达拉']= {596, 0},
['比亚格里将军']= {597, 0},
['沃尔坎']= {598, 0},
['艾欧纳尔']= {599, 0},
['洛肯']= {600, 0},
['法瑞克']= {601, 0},
['玛维恩']= {602, 0},
--['巫妖王']= {603, 0},
['克莱斯塔卢斯']= {604, 0},
['悲伤圣女']= {605, 0},
['塑铁者斯约尼尔']= {607, 0},
['熔炉之主加弗斯特']= {608, 0},
['伊克']= {609, 1},
['科瑞克']= {609, 0},
['天灾领主泰兰努斯']= {610, 0},
['肉钩']= {611, 0},
['塑血者沙尔拉姆']= {612, 0},
['时光领主埃博克']= {613, 0},
--['玛尔加尼斯']= {614, 0},
['布隆亚姆']= {615, 0},
['噬魂者']= {616, 0},
['指挥官斯托比德']= {617, 0},
['大魔导师泰蕾丝塔']= {618, 0},
['阿诺玛鲁斯']= {619, 0},
['塑树者奥莫洛克']= {620, 0},
['克莉斯塔萨']= {621, 0},
['审讯者达库斯']= {622, 0},
['瓦尔洛斯·云击']= {623, 0},
['法师领主伊洛姆']= {624, 0},
['魔网守护者埃雷苟斯']= {625, 0},
['埃雷克姆']= {626, 0},
['摩拉格']= {627, 0},
['艾库隆']= {628, 0},
['谢沃兹']= {629, 0},
['拉文索尔']= {630, 0},
['湮灭者祖拉玛特']= {631, 0},
['塞安妮苟萨']= {632, 0},
['碎颅者莫克拉']= {634, 0},
['祖尔托']= {634, 3},
['埃蕾希·晨歌']= {634, 1},
['鲁诺克·蛮鬃']= {634, 2},
['死亡猎手维赛里']= {634, 4},
['纯洁者耶德瑞克']= {635, 0},
['银色神官帕尔崔丝']= {636, 0},
['黑骑士']= {637, 0},
--['凯雷塞斯王子']= {638, 0},
['建筑师斯卡瓦尔德']= {639, 0},
['控制者达尔隆']= {639, 1},
['掠夺者因格瓦尔']= {640, 0},
['席瓦拉·索格蕾']= {641, 0},
['戈托克·苍蹄']= {642, 0},
['狂野的犀牛']= {642, 1},
['巨型冰虫']= {642, 3},
['狂乱的狼人']= {642, 2},
['贪婪的熊怪']= {642, 4},
['残忍的斯卡迪']= {643, 0},
['伊米隆国王']= {644, 0},
['裁决者格里斯通']= {372, 0},
['粘性辐射尘']= {420, 0},
['复生的火枪手']= {446, 1},
['暗影祭司塞瑟斯']= {487, 1},
['莱公']= {649, 0},
['武器大师哈兰']= {654, 0},
['雪流大师']= {657, 0},
['刘·焰心']= {658, 0},
['指导者寒心']= {659, 0},
['詹迪斯·巴罗夫']= {663, 0},
['血骨傀儡']= {665, 0},
['莉莉安·沃斯']= {666, 0},
['跳跳大王']= {669, 0},
['科洛夫修士']= {671, 0},
['指挥官杜兰德']= {674, 1},
['大检察官怀特迈恩']= {674, 0},
['秦希']= {677, 1},
['剑曦']= {677, 0},
['缚灵者戈拉亚']= {682, 0},
['祝踏岚']= {686, 0},
['无情之齐昂']= {687, 1},
['暴虐之蒙恩']= {687, 0},
['迅弓之速不台']= {687, 2},
['裂魂者萨尔诺斯']= {688, 0},
['受诅者魔封']= {689, 0},
['杰翰']= {690, 0},
['怒之煞']= {691, 0},
['黑暗萨满柯兰萨']= {695, 0},
['驯犬者布兰恩']= {660, 0},
['力冠三军库乌艾']= {708, 0},
['鬼谋神算冥谷子']= {708, 1},
['势不可挡哈伊岩']= {708, 2},
['传令官沃拉兹']= {584, 0},
--['阿努巴拉克']= {587, 0},
['布莱恩·铜须']= {606, 0},
['阿达罗格']= {694, 0},
['焰喉']= {696, 0},
['熔岩守卫戈多斯']= {697, 0},
['哈扎斯']= {459, 3},
['德拉维沃尔']= {459, 1},
['摩弗拉斯']= {459, 2},
['伊拉贡']= {726, 0},
['头领萨莱斯']= {725, 1},
['炮舰']= {725, 0},
['黑暗院长加丁']= {684, 0},
['血卫士伯鲁恩']= {728, 0},
['琥珀塑形者昂舒克']= {737, 0},
['琥珀畸怪']= {737, 1},
['古·穿云']= {673, 0},
['碧空翔龙']= {673, 1},
['织焰者孔格勒']= {656, 0},
['加拉隆']= {713, 0},
['指挥官沃加克']= {738, 0},
['雷施']= {729, 0},
['大女皇夏柯希尔']= {743, 0},
['皇家宰相佐尔洛克']= {745, 0},
['破坏者吉普提拉克']= {655, 0},
['黑曜石哨兵']= {748, 0},
['指挥官玛洛尔']= {749, 0},
['永影之提安']= {687, 3},
['突袭者加杜卡']= {675, 0},
['指挥官瑞魔克']= {676, 0},
['乌克乌克']= {668, 0},
['破桶而出的炎诛']= {670, 0},
['贤者马里']= {672, 0},
['游学者石步']= {664, 0},
['疑之煞']= {335, 0},
['武器大师席恩']= {698, 0},
['宰相金巴卡']= {693, 0},
--['烛龙']= {742, 0},
['烛龙']= {742, 1},
['翼虫首领尼诺洛克']= {727, 0},
['紫晶守护者']= {679, 0},
['红玉守护者']= {679, 3},
['蓝晶守护者']= {679, 1},
['青玉守护者']= {679, 2},
['长老阿萨尼']= {683, 2},
['长老睿盖尔']= {683, 1},
['守护者考兰']= {683, 0},
['风领主梅尔加拉克']= {741, 0},
['狂之煞']= {685, 0},
['莉莉安的灵魂']= {666, 1},
['先知萨隆亚']= {591, 0},
['将军帕瓦拉克']= {692, 0},
['刀锋领主塔亚克']= {744, 0},
['惧之煞']= {709, 0},
['纳拉克']= {814, 0},
['铁穹']= {817, 0},
['罗沙克']= {817, 1},
['魁兹扎尔']= {817, 2},
['玳刃']= {817, 3},
['杜鲁姆']= {818, 0},
['普利莫修斯']= {820, 0},
['沙行者苏尔']= {816, 1},
['霜王玛拉克']= {816, 2},
['卡兹拉金']= {816, 0},
['赫利东']= {819, 0},
['黑暗意志']= {824, 0},
['托多斯']= {825, 0},
['乌达斯塔']= {826, 0},
['击碎者金罗克']= {827, 0},
['露琳']= {829, 0},
['雷神']= {832, 0},
['季鹍']= {828, 0},
['指挥官库鲁尔格']= {833, 0},
['雅克布·奥勒留斯元帅']= {834, 0},
['克罗索斯']= {834, 4},
['安布罗斯·雷钉']= {834, 1},
['拉娜·硬锤']= {834, 3},
['娅琳·永歌']= {834, 2},
--['莱登']= {831, 0},
['夙娥']= {829, 1},
['高阶祭司玛尔里']= {816, 3},
['毒素之头']= {821, 1},
['火焰之头']= {821, 0},
['冰霜之头']= {821, 2},
['马尔考罗克']= {846, 0},
['禾·软足']= {849, 1},
['鲁克·石趾']= {849, 0},
['孙·柔心']= {849, 2},
['纳兹戈林将军']= {850, 0},
['库卡隆狱卒']= {851, 1},
['嗜血的索克']= {851, 0},
['伊墨苏斯']= {852, 0},
['碎地者哈洛姆']= {856, 0},
['缚潮者卡德里斯']= {856, 1},
['赤精']= {857, 0},
['玉珑']= {858, 0},
['砮皂']= {859, 0},
['雪怒']= {860, 0},
['斡耳朵斯']= {861, 0},
['钢铁战蝎']= {864, 0},
['诺鲁什']= {866, 0},
['傲之煞']= {867, 0},
--['迦拉卡斯']= {868, 0},
['加尔鲁什·地狱咆哮']= {869, 0},
['觅血者斯基尔']= {853, 0},
['虫群卫士希赛克']= {853, 1},
['暴食蝗卡诺兹']= {853, 2},
['至尊者柯尔凡']= {853, 3},
['操纵者卡兹提克']= {853, 4},
['毒心者夏克里尔']= {853, 5},
['切割者里卡尔']= {853, 6},
['明澈者伊约库克']= {853, 7},
['掠风者克尔鲁克']= {853, 8},
['腐蚀混合物']= {866, 1},
['攻城匠师黑索']= {865, 0},
['秘藏的潘达利亚战利品']= {870, 0},
--['迦拉卡斯']= {881, 0},
['玛格莫拉图斯']= {893, 1},
['锻造大师戈杜哈']= {893, 0},
['盲眼猎手']= {900, 0},
['熔岩恶火水晶']= {901, 2},
['卡尔加·刺肋']= {901, 0},
['剧毒倾泻水晶']= {901, 3},
['潮汐风暴水晶']= {901, 1},
['督军拉姆塔斯']= {899, 0},
['亡语者贾格巴']= {899, 1},
['阿格姆']= {899, 2},
['剃刀沼泽野兽追踪者']= {895, 3},
['剃刀沼泽剑卫']= {895, 1},
['剃刀沼泽狩猎大师']= {895, 2},
['鲁古格']= {895, 0},
['猎手布塔斯克']= {896, 0},
['鸦人拜日狂信徒']= {968, 1},
['鸦人防护构装体']= {968, 2},
['屠夫']= {971, 0},
['兰吉特']= {965, 0},
['阿拉卡纳斯']= {966, 0},
['高阶贤者维里克斯']= {968, 0},
['鸦人炎阳构装体雏形']= {966, 1},
['守奴人库鲁斯托']= {888, 0},
['恐翼']= {1122, 2},
['兽王达玛克']= {1122, 0},
['碎铁']= {1122, 3},
['弗特莱']= {1122, 4},
['虐牙']= {1122, 1},
['缚火者卡格拉兹']= {1123, 0},
['啸天者托瓦拉']= {1133, 0},
['卡加斯·刃拳']= {1128, 0},
['莎达娜·血怒']= {1139, 0},
['加摩拉']= {368, 0},
['多米尼娜']= {436, 0},
['征服者克鲁尔']= {426, 0},
['深渊守护者']= {447, 0},
['暮光领主巴赛尔']= {437, 0},
['刽子手戈尔']= {1144, 0},
['苏克']= {1145, 0},
['主管索戈尔']= {1147, 0},
['费莫斯']= {1148, 1},
['普尔']= {1148, 0},
['熔炉工程师']= {1154, 2},
['山脉之心']= {1154, 7},
['鼓风者']= {1154, 3},
['熔渣元素']= {1154, 6},
['保安']= {1154, 1},
['元素尊者']= {1154, 4},
['召火者']= {1154, 5},
['监工长石']= {1154, 0},
['弗兰佐克']= {1155, 0},
['汉斯加尔']= {1155, 1},
['耐奥祖']= {1160, 0},
['格鲁尔']= {1161, 0},
['黑石突击队火炮']= {1163, 1},
['尼托格·雷塔']= {1163, 0},
['罗托尔']= {887, 0},
['戈洛克']= {889, 0},
['警戒者凯萨尔']= {1185, 0},
['缚魂者尼娅米']= {1186, 0},
['吞噬者奥尔高格']= {1202, 0},
['真菌食肉者']= {1196, 1},
['执行者苏卡']= {1203, 1},
['血腥的玛拉卡']= {1203, 2},
['加安上将']= {1203, 0},
['烈焰欺诈者']= {1216, 3},
['尖啸纵火魔']= {1216, 1},
--['恶魔卫士']= {1216, 2},
['阿扎凯尔']= {1216, 0},
['塔隆戈尔']= {1225, 0},
['折铁者高尔山']= {1226, 0},
['畸形龙人']= {1227, 1},
['奇拉克']= {1227, 0},
['指挥官萨贝克']= {1228, 0},
['铁钩碎天兽']= {1228, 1},
['黑铁卫士']= {1228, 2},
['怒翼雏龙']= {1229, 1},
['狂野的怒翼']= {1229, 0},
['督军扎伊拉']= {1234, 0},
['佐格什']= {1238, 1},
['斯古洛克']= {1238, 0},
['科拉玛尔']= {1238, 2},
['惧牙']= {1235, 1},
['血肉撕裂者诺格加尔']= {1235, 0},
['马考格·烬刃']= {1236, 1},
['阿里奥克·杜古']= {1236, 0},
['妮莎·诺克斯']= {1236, 2},
['奥舍尔']= {1237, 0},
['大法师索尔']= {1208, 0},
['鲁克玛']= {1262, 0},
['鲁克兰']= {967, 0},
['铁路主管箭火']= {1138, 0},
['野蛮的波尔卡']= {1138, 1},
['太阳耀斑']= {967, 1},
['布兰肯斯波']= {1196, 0},
['枯木']= {1214, 0},
['塑地者特鲁']= {1207, 1},
['生命守卫高拉']= {1207, 2},
['艾里塔克']= {1209, 0},
['雅努']= {1210, 0},
['永恒的塔尔纳']= {1211, 0},
['泰克图斯']= {1195, 0},
['克罗莫格']= {1162, 0},
['黑手']= {959, 0},
['杜尔胡']= {1207, 0},
['毁灭者多弗']= {1291, 0},
['狂乱奔行者']= {1291, 1},
['元首马尔高克']= {1197, 0},
['克拉戈']= {1153, 0},
['烬狼']= {1123, 2},
['艾克诺·钢铁使者']= {1123, 1},
['巨型鞭笞者']= {1211, 2},
['不羁妖花']= {1211, 1},
['阿鲁克斯']= {1142, 0},
['麦什伦']= {1143, 0},
['亡语者布莱克松']= {1146, 0},
['寒冰之王亚门纳尔']= {1141, 0},
['仪式枯骨']= {1160, 1},
--['食腐蛆虫']= {1140, 1},
['骨喉']= {1140, 0},
['纳利什']= {1168, 0},
['火眼莫德雷斯']= {433, 0},
['考莫克']= {1392, 0},
['暴君维哈里']= {1394, 0},
['玛诺洛斯']= {1395, 0},
['基尔罗格·死眼']= {1396, 0},
['邪影守望者']= {1433, 2},
['腐化的泰罗克祭司']= {1433, 3},
['暗影领主艾斯卡']= {1433, 0},
['流亡者幻影']= {1433, 4},
['邪能渡鸦']= {1433, 1},
--['古尔图格·血沸']= {1432, 0},
['剑圣朱倍尔索斯']= {1432, 1},
['迪亚·暗语']= {1432, 2},
['钢铁掠夺者']= {1425, 0},
['地狱火炮']= {1426, 1},
['攻城大师玛塔克']= {1426, 0},
['霸主卡扎克']= {1452, 0},
--['阿克蒙德']= {1438, 0},
['邪能领主扎昆']= {1391, 0},
['血魔']= {1372, 0},
['缚魂构装体']= {1427, 0},
['祖霍拉克']= {1447, 0},
['残余能量']= {1391, 1},
['督军帕杰什']= {1480, 0},
['积怨碎壳者']= {1480, 1},
['积怨踏浪者']= {1480, 2},
['瑟芬崔斯克']= {1479, 0},
['烈焰多头蛇子嗣']= {1479, 1},
['奥术多头蛇子嗣']= {1479, 2},
['艾萨拉之怒']= {1492, 0},
['阿什高姆']= {1468, 0},
['堕落君王伊米隆']= {1502, 0},
['哈布隆']= {1512, 0},
['鲁西弗隆']= {1519, 0},
['玛格曼达']= {1520, 0},
['基赫纳斯']= {1521, 0},
['加尔']= {1522, 0},
['沙斯拉尔']= {1523, 0},
['迦顿男爵']= {1524, 0},
['火妖祭司']= {1525, 1},
['萨弗隆先驱者']= {1525, 0},
['焚化者古雷曼格']= {1526, 0},
['管理者埃克索图斯']= {1527, 0},
['火妖医师']= {1527, 1},
['火妖精英']= {1527, 2},
['拉格纳罗斯']= {1528, 0},
['狂野的拉佐格尔']= {1529, 0},
['堕落的瓦拉斯塔兹']= {1530, 0},
['勒什雷尔']= {1531, 0},
['费尔默']= {1532, 0},
['埃博诺克']= {1533, 0},
['弗莱格尔']= {1534, 0},
['克洛玛古斯']= {1535, 0},
['奈法利安']= {1536, 0},
['库林纳克斯']= {1537, 0},
['拉贾克斯将军']= {1538, 0},
['莫阿姆']= {1539, 0},
['吞咽者布鲁']= {1540, 0},
['狩猎者阿亚米斯']= {1541, 0},
['无疤者奥斯里安']= {1542, 0},
['预言者斯克拉姆']= {1543, 0},
['沙尔图拉']= {1544, 0},
['沙尔图拉的皇家卫兵']= {1544, 1},
['顽强的范克瑞斯']= {1545, 0},
['哈霍兰公主']= {1546, 0},
['亚尔基公主']= {1547, 2},
['维姆']= {1547, 1},
['克里勋爵']= {1547, 0},
['维希度斯']= {1548, 0},
['维克洛尔大帝']= {1549, 0},
['维克尼拉斯大帝']= {1549, 1},
['奥罗']= {1550, 0},
['克苏恩']= {1551, 0},
['滑翔者沙德基斯']= {1552, 1},
['潜伏者希亚其斯']= {1552, 2},
['蹂躏者洛卡德']= {1552, 0},
--['午夜']= {1553, 1},
--['猎手阿图门']= {1553, 0},
--['莫罗斯']= {1554, 0},
--['贞节圣女']= {1555, 0},
['大灰狼']= {1556, 0},
['巫婆']= {1556, 3},
['罗密欧']= {1556, 1},
['朱丽叶']= {1556, 2},
--['馆长']= {1557, 0},
['埃兰之影']= {1559, 0},
['特雷斯坦·邪蹄']= {1560, 0},
['虚空幽龙']= {1561, 0},
--['麦迪文的回音']= {1562, 0},
['玛克扎尔王子']= {1563, 0},
['莫加尔大王']= {1564, 0},
['克洛什·火拳']= {1564, 4},
['疯狂的基戈尔']= {1564, 1},
['盲眼先知']= {1564, 2},
['召唤者沃尔姆']= {1564, 3},
['屠龙者格鲁尔']= {1565, 0},
['地狱火导魔者']= {1566, 1},
['玛瑟里顿']= {1566, 0},
['不稳定的海度斯']= {1567, 0},
['鱼斯拉']= {1568, 0},
['莱欧瑟拉斯之影']= {1569, 1},
['盲眼者莱欧瑟拉斯']= {1569, 0},
['深水卫士沙克基斯']= {1570, 1},
['深水卫士卡莉蒂丝']= {1570, 3},
['深水卫士泰达维斯']= {1570, 2},
['深水领主卡拉瑟雷斯']= {1570, 0},
['莫洛格里·踏潮者']= {1571, 0},
['瓦丝琪']= {1572, 0},
['奥']= {1573, 0},
['空灵机甲']= {1574, 0},
['大星术师索兰莉安']= {1575, 0},
['星术师卡波妮娅']= {1576, 3},
['萨古纳尔男爵']= {1576, 2},
['首席技师塔隆尼库斯']= {1576, 4},
--['凯尔萨斯·逐日者']= {1576, 0},
['亵渎者萨拉德雷']= {1576, 1},
['雷基·冬寒']= {1577, 0},
['安纳塞隆']= {1578, 0},
['卡兹洛加']= {1579, 0},
['阿兹加洛']= {1580, 0},
['阿克蒙德']= {1581, 0},
['高阶督军纳因图斯']= {1582, 0},
['苏普雷姆斯']= {1583, 0},
['阿卡玛之影']= {1584, 0},
['古尔图格·血沸']= {1586, 0},
['愤怒精华']= {1587, 2},
['欲望精华']= {1587, 1},
['痛苦精华']= {1587, 0},
['莎赫拉丝主母']= {1588, 0},
['击碎者加西奥斯']= {1589, 0},
['维尔莱斯·深影']= {1589, 3},
['高阶灵术师塞勒沃尔']= {1589, 1},
['女公爵玛兰德']= {1589, 2},
['伊利丹·怒风']= {1590, 0},
['卡雷苟斯']= {1591, 0},
['腐蚀者萨索瓦尔']= {1591, 1},
--['布鲁塔卢斯']= {1592, 0},
['菲米丝']= {1593, 0},
['萨洛拉丝女王']= {1594, 1},
['高阶术士奥蕾塞丝']= {1594, 0},
['穆鲁']= {1595, 0},
['熵魔']= {1595, 1},
--['基尔加丹']= {1596, 0},
['塔隆·血魔']= {1585, 0},
['岩石看守者阿尔卡冯']= {1597, 0},
['明叶长老']= {1646, 1},
['风暴看守者埃玛尔隆']= {1598, 0},
['火焰看守者科拉隆']= {1599, 0},
['寒冰看守者图拉旺']= {1600, 0},
['阿努布雷坎']= {1601, 0},
['黑女巫法琳娜']= {1602, 0},
['迈克斯纳']= {1603, 0},
['药剂师诺斯']= {1604, 0},
['肮脏的希尔盖']= {1605, 0},
['洛欧塞布']= {1606, 0},
['死亡骑士学员']= {1607, 1},
['教官拉苏维奥斯']= {1607, 0},
['收割者戈提克']= {1608, 0},
['女公爵布劳缪克丝']= {1609, 2},
['瑞文戴尔男爵']= {1609, 0},
['瑟里耶克爵士']= {1609, 3},
['库尔塔兹领主']= {1609, 1},
['帕奇维克']= {1610, 0},
['格罗布鲁斯']= {1611, 0},
['格拉斯']= {1612, 0},
['塔迪乌斯']= {1613, 0},
['萨菲隆']= {1614, 0},
--['克尔苏加德']= {1615, 0},
['沙德隆']= {1616, 2},
['塔尼布隆']= {1616, 1},
['维斯匹隆']= {1616, 3},
['萨塔里奥']= {1616, 0},
['玛里苟斯']= {1617, 0},
['酸喉和恐鳞']= {1618, 1},
['穿刺者戈莫克']= {1618, 0},
['冰吼']= {1618, 2},
['威尔弗雷德·菲兹班']= {1619, 1},
['加拉克苏斯大王']= {1619, 0},
['索库尔']= {1620, 7},
['安塔尔·缮炉者']= {1620, 1},
['塞瑞莎·术轮']= {1620, 6},
['伊锐丝·影踪']= {1620, 3},
['泰利乌斯·达斯布雷德']= {1620, 8},
['努兹尔·啸钉']= {1620, 5},
['麦拉多·深谷游者']= {1620, 4},
['圣光使者巴尔诺']= {1620, 2},
['阿莱希娅·月行者']= {1620, 0},
['严肃的凯普斯']= {1621, 2},
['断钢者纳霍克']= {1621, 7},
['凋零者吉塞尔']= {1621, 3},
['玛兹迪娜']= {1621, 6},
['戈瑞姆·影斩']= {1621, 4},
['暗语者维维尼']= {1621, 9},
['德拉克道格']= {1621, 5},
['比莱纳·雷蹄']= {1621, 0},
['布罗恩·粗角']= {1621, 1},
['鲁姬卡']= {1621, 8},
['黑暗邪使艾蒂丝']= {1622, 1},
['光明邪使菲奥拉']= {1622, 0},
['阿努巴拉克']= {1623, 0},
['玛洛加尔领主']= {1624, 0},
['亡语者女士']= {1625, 0},
['萨鲁法尔大王']= {1626, 0},
['穆拉丁·铜须']= {1627, 0},
['死亡使者萨鲁法尔']= {1628, 0},
['烂肠']= {1629, 0},
['腐面']= {1630, 0},
['普崔塞德教授']= {1631, 0},
['塔达拉姆王子']= {1632, 2},
['瓦拉纳王子']= {1632, 0},
['凯雷塞斯王子']= {1632, 1},
['鲜血女王兰娜瑟尔']= {1633, 0},
['踏梦者瓦莉瑟瑞娅']= {1634, 0},
['辛达苟萨']= {1635, 0},
['巫妖王']= {1636, 0},
['烈焰巨兽']= {1637, 0},
['掌炉者伊格尼斯']= {1638, 0},
['锋鳞']= {1639, 0},
['XT-002拆解者']= {1640, 0},
['唤雷者布隆迪尔']= {1641, 2},
['断钢者']= {1641, 0},
['符文大师莫尔基姆']= {1641, 1},
['科隆加恩']= {1642, 0},
['欧尔莉亚']= {1643, 0},
['霍迪尔']= {1644, 0},
['西芙']= {1645, 1},
['托里姆']= {1645, 0},
['石树长老']= {1646, 3},
['弗蕾亚']= {1646, 0},
['铁枝长老']= {1646, 2},
['米米尔隆']= {1647, 0},
['维扎克斯将军']= {1648, 0},
['尤格-萨隆']= {1649, 0},
['观察者奥尔加隆']= {1650, 0},
['奥妮克希亚']= {1651, 0},
['海里昂']= {1652, 0},
['洛克莫拉']= {1662, 0},
--['海拉']= {1663, 0},
['科达娜']= {1470, 0},
['乌拉罗格·塑山']= {1665, 0},
['乌索克']= {1667, 0},
['梦魇蛋']= {1656, 1},
['纳拉萨斯']= {1673, 0},
['夺心者卡什']= {1686, 0},
['达古尔']= {1687, 0},
--['米尔菲丝·法力风暴']= {1688, 0},
['溃面']= {1693, 0},
['赛尔奥隆']= {1697, 0},
['相位蜘蛛']= {1697, 1},
['鲜血公主萨安娜']= {1702, 0},
['尼珊德拉']= {1703, 0},
['泰拉尔']= {1704, 3},
['艾莫莉丝']= {1704, 1},
['伊森德雷']= {1704, 0},
['莱索恩']= {1704, 2},
['邪能领主贝图格']= {1711, 0},
['萨维斯']= {1726, 0},
['腐蚀恐魔']= {1726, 1},
['崔利艾克斯']= {1731, 0},
['橡树之心']= {1655, 0},
['古尔丹']= {1737, 0},
['超凡恐魔']= {1726, 2},
['潜伏恐魔']= {1726, 3},
['梦魇触须']= {1726, 4},
--['艾利桑德']= {1743, 0},
['尼索格']= {1749, 0},
['塞纳留斯']= {1750, 0},
['玛法里奥·怒风']= {1750, 1},
['烈焰魔灵']= {1751, 2},
['寒冰魔灵']= {1751, 1},
['奥术魔灵']= {1751, 3},
['魔剑士奥鲁瑞尔']= {1751, 0},
['库塔洛斯·拉文凯斯']= {1672, 0},
['可恨的斯麦斯帕']= {1664, 0},
['伊莉萨娜·拉文凯斯']= {1653, 0},
['融合之魂']= {1518, 0},
['顾问麦兰杜斯']= {1720, 0},
['塔丽克萨·火冠']= {1719, 0},
['巡逻队长加多']= {1718, 0},
['萨维斯之影']= {1657, 0},
['德萨隆']= {1656, 0},
['深须国王']= {1491, 0},
['积怨夫人']= {1490, 0},
--['奥丁']= {1489, 0},
['神王斯科瓦尔德']= {1488, 0},
['芬雷尔']= {1487, 0},
['赫娅']= {1486, 0},
['海姆达尔']= {1485, 0},
['顾问凡多斯']= {1501, 0},
['纳尔提拉']= {1500, 0},
['萨卡尔将军']= {1499, 0},
['科蒂拉克斯']= {1498, 0},
['伊凡尔']= {1497, 0},
['阿努贝斯特']= {1696, 0},
['颤栗之喉']= {1694, 0},
['审判官托蒙托鲁姆']= {1695, 0},
['格雷泽']= {1469, 0},
['提拉宋·萨瑟利尔']= {1467, 0},
['艾乐瑞瑟·雷弗拉尔']= {1744, 0},
--['伊格诺斯']= {1738, 0},
['时空畸体']= {1725, 0},
['克洛苏斯']= {1713, 0},
['斯考匹隆']= {1706, 0},
['占星师艾塔乌斯']= {1732, 0},
['梦魇恐魔']= {1738, 1},
['支配触须']= {1738, 4},
['死光触须']= {1738, 3},
['梦魇脓液']= {1738, 5},
['腐蚀触须']= {1738, 2},
['沙索斯']= {1763, 0},
['麦迪文的回音']= {1764, 0},
['卡拉米尔']= {1774, 0},
['梦魇畸兽']= {1654, 1},
['魔王纳扎克']= {1783, 0},
['提克迪奥斯']= {1762, 0},
['高级植物学家特尔安']= {1761, 0},
['自然学家特尔安']= {1761, 1},
['日心学者特尔安']= {1761, 2},
['怨嗣雏龙']= {1656, 2},
['鬼母阿娜']= {1790, 0},
['冷血的杜贡']= {1789, 0},
['掠夺者多恩']= {1756, 2},
['捕魂者麦芙拉']= {1756, 0},
['赫林船长']= {1756, 1},
['邪能魔灵']= {1751, 4},
['恐惧憎恶']= {1726, 5},
['凋零者吉姆']= {1796, 0},
['胡墨格里斯']= {1770, 0},
['勒凡图斯']= {1769, 0},
['毁灭触须']= {1663, 2},
['贪食触须']= {1663, 1},
['浮骸']= {1795, 0},
['麦迪文之影']= {1817, 0},
['奥丁']= {1819, 0},
['魔力吞噬者']= {1818, 0},
['艾尔菲拉']= {1820, 0},
['嘉琳黛尔']= {1820, 1},
['飞猴助手']= {1820, 2},
['贞节圣女']= {1825, 0},
['玛吉亚']= {1826, 1},
['托尼']= {1826, 0},
['考德隆夫人']= {1827, 2},
['库格斯顿']= {1827, 0},
['鲁米诺尔']= {1827, 1},
['巴布丽特']= {1827, 3},
['海拉']= {1829, 0},
['奥术师特尔安']= {1761, 3},
['高姆']= {1830, 0},
--['递归元素']= {1743, 1},
--['加速元素']= {1743, 2},
['破碎时间粒子']= {1725, 2},
['衰减时间粒子']= {1725, 1},
['大德鲁伊格兰达里斯']= {1654, 0},
['猎手阿图门']= {1835, 0},
['午夜']= {1835, 1},
['莫罗斯']= {1837, 0},
['监视者维兹艾德姆']= {1838, 0},
['哈亚坦']= {1856, 0},
['馆长']= {1836, 0},
['主母萨丝琳']= {1861, 0},
['阿提甘']= {1867, 0},
['贝拉克']= {1867, 1},
['递归元素']= {1872, 1},
['加速元素']= {1872, 2},
['艾利桑德']= {1872, 0},
['堕落的化身']= {1873, 0},
['勇气侍女']= {1873, 1},
['锋颚角斗士']= {1856, 2},
['暗鳞监工']= {1856, 3},
['锋颚波浪医师']= {1856, 1},
['孟菲斯托斯']= {1878, 0},
['布鲁塔卢斯']= {1883, 0},
['马利费库斯']= {1884, 0},
['丝瓦什']= {1885, 0},
['格罗斯']= {1862, 0},
['戒卫侍女']= {1897, 0},
['灵魂引擎']= {1896, 0},
['灵魂女王德雅娜']= {1896, 1},
['女猎手卡丝帕莲']= {1903, 0},
['女祭司月葬']= {1903, 2},
['亚萨·袭月上尉']= {1903, 1},
['阿格洛诺克斯']= {1905, 0},
['轻蔑的萨什比特']= {1906, 0},
['绝望的聚合体']= {1896, 2},
['阿波克隆']= {1956, 0},
['月爪']= {1903, 3},
['多玛塔克斯']= {1904, 0},
['基尔加丹']= {1898, 0},
['瓦里玛萨斯']= {1983, 0},
['阿格拉玛']= {1984, 0},
['奥萨拉，黑夜之母']= {1986, 1},
['蒂玛，幽影之母']= {1986, 2},
['诺拉，烈焰之母']= {1986, 0},
['加洛西灭世者']= {1992, 0},
['法尔格']= {1987, 0},
['沙图格']= {1987, 1},
['鲁拉']= {1982, 0},
['海军上将斯芙拉克丝']= {1997, 0},
['首席工程师伊什卡']= {1997, 1},
['晋升者祖拉尔']= {1979, 0},
['总督奈扎尔']= {1981, 0},
['黯牙']= {1980, 1},
['萨普瑞什']= {1980, 0},
['加洛西破坏者']= {2004, 3},
['加洛西歼灭者']= {2004, 1},
['加洛西屠戮者']= {2004, 2},
['传送门守护者哈萨贝尔']= {1985, 0},
['主母芙努娜']= {2010, 0},
['妖女奥露拉黛儿']= {2011, 0},
['审判官梅托']= {2012, 0},
['奥库拉鲁斯']= {2013, 0},
['大型裂隙守护者']= {1982, 1},
['消逝虚空']= {1982, 2},
['金加洛斯']= {2004, 0},
['影翼鳐']= {1980, 2},
['苏拉雅，宇宙之母']= {1986, 3},
['埃洛杜斯将军']= {1997, 2},
['索塔纳索尔']= {2014, 0},
['深渊领主维尔姆斯']= {2015, 0},
['猎魂者伊墨纳尔']= {2009, 0},
['艾欧娜尔的精华']= {2025, 0},
['黑暗畸体']= {1979, 1},
['寂灭者阿古斯']= {2031, 0},
['女祭司阿伦扎']= {2082, 0},
['莱赞']= {2083, 0},
['上古之骨']= {2083, 1},
['尤朵拉船长']= {2093, 0},
['乔里船长']= {2093, 1},
['哈兰·斯威提']= {2095, 0},
['沃卡尔']= {2036, 0},
['亚兹玛']= {2030, 0},
['天空上尉库拉格']= {2102, 0},
['鲨鱼饵']= {2102, 1},
['恶魔卫士']= {2025, 1},
['邪能领主']= {2025, 5},
['邪能干扰器']= {2025, 2},
['恶魔犬']= {2025, 4},
['注邪毁灭者']= {2025, 6},
['飞翔的科拉佩特隆']= {2025, 3},
['鲨鱼拳击手']= {2094, 0},
['泥沙女王']= {2097, 0},
['杰斯·豪里斯']= {2098, 0},
['骑士队长瓦莱莉']= {2099, 0},
['拉乌尔船长']= {2093, 2},
['孢子召唤师赞查']= {2130, 0},
['被感染的岩喉']= {2131, 0},
['女巫索林娜']= {2125, 2},
['女巫马拉迪']= {2125, 1},
['女巫布里亚']= {2125, 0},
['拜恩比吉中士']= {2133, 0},
['维克雷斯勋爵']= {2128, 0},
['维克雷斯夫人']= {2128, 1},
['魂缚巨像']= {2126, 0},
['哈达尔·黑渊']= {2134, 0},
['提赞']= {2139, 0},
['基阿拉克']= {2141, 0},
['基阿拉克幼龙']= {2141, 1},
['腐臭吞噬者']= {2146, 0},
['阿库希尔']= {2153, 0},
['唤风者菲伊']= {2154, 1},
['铁舟修士']= {2154, 0},
['斯托颂勋爵']= {2155, 0},
['低语者沃尔兹斯']= {2156, 0},
['长者莉娅克萨']= {2157, 0},
['阿德里斯']= {2142, 0},
['阿斯匹克斯']= {2142, 1},
['贪食的拉尔']= {2127, 0},
['大手大脚的仆从']= {2127, 1},
['米利克萨']= {2143, 0},
['喷毒盘蛇']= {2143, 1},
['加瓦兹特']= {2144, 0},
['亡触奴隶主']= {2129, 1},
['泽克沃兹']= {2169, 0},
['异种虫战士']= {2169, 1},
['蛛魔虚空编织者']= {2169, 2},
['腐蚀残迹']= {2167, 1},
['戈霍恩']= {2147, 0},
['心脏守卫']= {2145, 2},
['灾厄妖术师']= {2145, 1},
['塞塔里斯的化身']= {2145, 0},
['散疫触须']= {2147, 1},
['单眼恐魔']= {2147, 2},
['黑暗幼体']= {2147, 3},
['塔罗克']= {2168, 0},
['爆裂水滴']= {2168, 1},
['瘟疫博士']= {2145, 3},
['凝结之血']= {2168, 2},
['冰雹构造体']= {2197, 0},
['蔚索斯']= {2199, 0},
['雄狮持盾卫士']= {2212, 2},
['雄狮之吼']= {2212, 0},
['雄狮工程师']= {2212, 1},
['雄狮战争法师']= {2212, 3},
['末日之嚎']= {2213, 0},
['末日之嚎战争法师']= {2213, 3},
['末日之嚎工程师']= {2213, 1},
['末日之嚎恐惧护盾兵']= {2213, 2},
['食沙者克劳洛克']= {2210, 0},
['饥饿的球潮虫']= {2210, 1},
['艾泽洛克']= {2114, 0},
['投币式群体打击者']= {2109, 0},
['瑞克莎·流火']= {2115, 0},
['商业大亨拉兹敦克']= {2116, 0},
['嗜血的抱齿兽']= {2195, 3},
['祖尔']= {2195, 0},
['纳兹曼尼鲜血妖术师']= {2195, 2},
['纳兹曼尼碾压者']= {2195, 1},
['黄金风蛇']= {2165, 0},
['殓尸者姆沁巴']= {2171, 0},
['屠夫库拉']= {2170, 2},
['征服者阿卡阿里']= {2170, 0},
['智者扎纳扎尔']= {2170, 1},
['达萨大王']= {2172, 0},
['腐化血珠']= {2146, 1},
['“屠夫”血钩']= {2132, 0},
['恐怖船长洛克伍德']= {2173, 0},
['不羁畸变怪']= {2158, 0},
['科古斯狱长']= {2096, 0},
['高莱克·图尔']= {2129, 0},
['战争使者耶纳基兹']= {2198, 0},
['纯净圣母']= {2167, 0},
['维克提斯']= {2166, 0},
['拆解者米斯拉克斯']= {2194, 0},
['胆汁软泥怪']= {2127, 2},
['沙鳞突击者']= {2143, 2},
['耐受病菌']= {2167, 2},
['蔓延病毒']= {2167, 3},
['维克戈斯']= {2140, 0},
['格洛恩']= {2325, 0},
['猿猴折磨者3000型']= {2325, 2},
['森林之王伊弗斯']= {2329, 0},
['弗里达·铁吼']= {2333, 0},
['祝圣信徒']= {2333, 1},
['暗铸十字军']= {2333, 2},
['猎头者加尔瓦纳']= {2335, 3},
['破城者洛卡']= {2335, 4},
['邦桑迪']= {2335, 1},
['拉斯塔哈大王']= {2335, 0},
['拉斯塔利荣誉护卫']= {2335, 5},
['圣武士扎兰']= {2335, 2},
['约瑟夫修士']= {2337, 2},
['凯瑟琳修女']= {2337, 1},
['拉米纳利亚']= {2337, 0},
['还魂者格洛恩']= {2340, 0},
['死神之灵']= {2340, 1},
['莱赞尼信徒']= {2344, 1},
['拉瓦妮·卡奈']= {2344, 0},
['赞达拉十字军']= {2344, 2},
['朽木伊弗斯']= {2345, 0},
['乌纳特']= {2332, 0},
['惊悚者法索乌']= {2328, 1},
['代言人扎克萨奇']= {2328, 0},
['大工匠梅卡托克']= {2334, 0},
['火花机器人']= {2334, 1},
['自爆绵羊']= {2334, 2},
['吉安娜·普罗德摩尔']= {2343, 0},
['飞行的猿猴驭者']= {2325, 1},
['丰灵']= {2342, 0},
['曼赛罗伊·弗雷菲斯']= {2341, 0},
['玫斯特拉']= {2341, 1},
['玛拉·恐牙']= {2323, 0},
['阿纳索斯·召火者']= {2323, 1},
['帕库的化身']= {2330, 0},
['吉布尔的化身']= {2330, 2},
['阿昆达的化身']= {2330, 3},
['贡克的化身']= {2330, 1},
['扎库尔']= {2349, 0},
['奥戈佐亚']= {2351, 0},
['虚悯者']= {2351, 1},
['深渊指挥官西瓦拉']= {2352, 0},
['戈巴马克国王']= {2357, 0},
['屑骨清道夫']= {2357, 1},
['失窃的脉冲线圈']= {2357, 3},
['失窃的拳机']= {2357, 2},
['冈克']= {2358, 0},
['喷射机器人']= {2358, 1},
['麦卡贡国王']= {2331, 0},
['首席机械师闪流']= {2348, 0},
['白金拳手']= {2336, 0},
['仁慈侏儒4.U.型']= {2336, 1},
['狂犬K.U.-J.0.']= {2339, 0},
['炽情者希里瓦兹']= {2359, 0},
['狂热者帕什玛']= {2359, 1},
['赛兰努斯']= {2361, 2},
['艾瑟内尔']= {2361, 1},
['艾萨拉的虔信者']= {2361, 4},
['潮汐主母']= {2361, 6},
['狂热的巨兽']= {2361, 3},
--['艾萨拉女王']= {2361, 0},
['忠实的仆从']= {2361, 7},
['恐惧召唤者']= {2349, 1},
['惊魂幻象']= {2349, 2},
['不羁梦魇']= {2349, 3},
['首席奥术师塔莉萨']= {2349, 4},
['奥玛斯']= {2362, 0},
['月之女祭司莉亚拉']= {2362, 1},
['守护者塔宁']= {2362, 2},
['艾萨拉的不屈者']= {2361, 5},
['黑水巨鳗']= {2347, 0},
['艾萨拉之辉']= {2353, 0},
['艾什凡女勋爵']= {2354, 0},
['崔克茜·击电']= {2360, 0},
['耐诺·万坠']= {2360, 1},
['HK-8型空中压制单位']= {2355, 0},
['维科玛拉']= {2363, 0},
['维科玛拉之裔']= {2363, 1},
['艾萨亚雷女巫']= {2351, 3},
['积恐巨兽']= {2351, 4},
['赞齐尔愚忠者']= {2351, 2},
['机轮车']= {2360, 2},
['玛乌特']= {2365, 0},
['恩佐斯之怒']= {2366, 0},
['维克修娜']= {2370, 0},
['不祥的刻魂者']= {2370, 3},
['狂热的教徒']= {2370, 1},
['咒缚的祭师']= {2370, 2},
['虚空晋升者']= {2370, 5},
['泰克利斯']= {2372, 1},
['卡吉尔']= {2372, 0},
['亚基迅虫']= {2372, 2},
['亚基工虫']= {2372, 3},
['黑暗化身']= {2365, 1},
['先知斯基特拉']= {2369, 0},
['腐蚀者恩佐斯']= {2375, 0},
['艾萨拉女王']= {2377, 1},
['黑暗审判官夏奈什']= {2377, 0},
['无厌者夏德哈']= {2367, 0},
['尼奥罗萨之血']= {2374, 2},
['腐化器官']= {2374, 1},
['增生覆盖的触须']= {2366, 2},
['聚合增生']= {2366, 5},
['惊魂淤血']= {2366, 3},
['菌丝囊肿']= {2366, 6},
['梦魇抗原']= {2366, 4},
['疯狂凝视']= {2366, 1},
['亚基掠夺者']= {2372, 4},
['大女皇夏柯扎拉']= {2378, 0},
['扎拉提克虫群卫士']= {2378, 1},
['扎拉提克塑珀者']= {2378, 2},
['亚基甲虫']= {2381, 1},
['碎地者弗克拉兹']= {2381, 0},
['赦罪镜像']= {2369, 1},
['莱登']= {2364, 0},
['龟裂追踪者']= {2364, 1},
['德雷阿佳丝之喉']= {2373, 2},
['德雷阿佳丝之眼']= {2373, 3},
['德雷阿佳丝']= {2373, 0},
['德雷阿佳丝的触须']= {2373, 1},
['痛击触须']= {2366, 7},
['坚忍的执行者']= {2370, 4},
['拉希奥']= {2368, 0},
['伊格诺斯']= {2374, 0},
['贪食的克里克西斯']= {2388, 0},
['虚空猎手']= {2364, 2},
['库尔萨洛克']= {2389, 0},
['收割者阿玛厄斯']= {2391, 0},
['复生的法师']= {2391, 3},
['复生的战士']= {2391, 2},
['骨牙']= {2391, 1},
['缝肉的造物']= {2392, 1},
['疫毒者巴瑟兰']= {2397, 1},
['受诅者赛泽尔']= {2397, 2},
['斩首者德茜雅']= {2397, 0},
['无堕者哈夫']= {2390, 0},
['赛·艾柯莎']= {2398, 0},
['宗主奥法兰']= {2400, 1},
['英格拉·马洛克']= {2400, 0},
['斩血']= {2401, 0},
['阿祖勒斯']= {2399, 0},
['金-塔拉']= {2399, 1},
['伊库斯博士']= {2403, 0},
['斯特拉达玛侯爵']= {2404, 0},
['特雷德奥瓦']= {2405, 0},
['哈尔吉亚斯']= {2406, 0},
--['卡尔将军']= {2407, 0},
['夺灵者哈卡']= {2408, 0},
['米尔豪斯·法力风暴']= {2409, 1},
['米尔菲丝·法力风暴']= {2409, 0},
['高阶裁决官阿丽兹']= {2411, 0},
['阴森的教民']= {2411, 1},
['雯图纳柯丝']= {2416, 0},
['莫德蕾莎']= {2417, 0},
['艾谢朗']= {2387, 0},
--['圣物匠赛·墨克斯']= {2418, 0},
['瞬息具象']= {2415, 1},
['执行者塔沃德']= {2415, 0},
['酤团']= {2419, 0},
['零星软泥']= {2419, 1},
['灵魂灌注者']= {2422, 6},
['恶毒的神秘学者']= {2422, 5},
['缚石征服者']= {2422, 3},
['凯尔萨斯之影']= {2422, 1},
['凯尔萨斯·逐日者']= {2422, 0},
['多米娜·毒刃']= {2423, 0},
['德纳修斯大帝']= {2424, 0},
['复生的弩手']= {2391, 4},
['外科医生缝肉']= {2392, 0},
['赎罪容器']= {2411, 2},
['凋骨']= {2395, 0},
['食腐蛆虫']= {2395, 1},
['缚霜者纳尔佐']= {2396, 0},
['佐尔拉姆斯虹吸者']= {2396, 1},
['荒翼刺客']= {2422, 4},
['难缠的石精']= {2422, 7},
['高阶折磨官达利索斯']= {2422, 2},
['啸翼']= {2393, 0},
['赤红秘法师']= {2424, 2},
['卡尔将军']= {2425, 0},
['芙莱达女男爵']= {2426, 1},
['堡主尼克劳斯']= {2426, 0},
['斯塔夫罗斯勋爵']= {2426, 2},
['蕾茉妮雅']= {2424, 1},
['饥饿的毁灭者']= {2428, 0},
['穆厄扎拉']= {2410, 0},
['精英石卫']= {2426, 3},
['不情愿的侍者']= {2426, 4},
['泥拳']= {2394, 0},
['大学监贝律莉娅']= {2421, 0},
['奥莱芙莉安']= {2414, 0},
['德沃丝']= {2412, 0},
['宫务大臣']= {2413, 0},
['巢群刺客']= {2423, 1},
['渗漏的残躯']= {2401, 1},
['赫库提斯']= {2429, 3},
['巴加斯特']= {2429, 2},
['猎手阿尔迪莫']= {2429, 0},
['玛尔苟']= {2429, 1},
['伊涅瓦·暗脉女勋爵']= {2420, 0},
['粘稠的大杂烩']= {2419, 2},
['瓦里诺']= {2430, 0},
['莫塔尼斯']= {2431, 0},
['“长青之枝”奥拉诺莫诺斯']= {2432, 0},
['诺尔伽什·泥躯']= {2433, 0},
['顽石军团巨怪']= {2425, 3},
['顽石军团特种兵']= {2425, 2},
['唤雾者']= {2402, 0},
['格拉夏尔将军']= {2425, 1},
['塔拉格鲁']= {2435, 0},
['佐·菲克斯']= {2437, 0},
['希尔布兰德']= {2448, 0},
['时空船长钩尾']= {2449, 0},
['希尔瓦娜斯·风行者']= {2441, 0},
['尖刺铁球']= {2443, 1},
['阿喀琉忒']= {2454, 1},
['阿尔克鲁克斯']= {2454, 0},
['雯扎·金线']= {2454, 2},
['折磨宝珠']= {2444, 1},
['痛楚胸笼']= {2444, 4},
['恶毒护手']= {2444, 3},
['折磨头盔']= {2444, 2},
['痛楚工匠莱兹纳尔']= {2443, 0},
['裂魂者多尔玛赞']= {2445, 0},
['斯凯亚']= {2439, 2},
['席格妮']= {2439, 1},
['基拉']= {2439, 0},
['劫魂者']= {2440, 1},
['霜缚狂热者']= {2440, 2},
['克尔苏加德']= {2440, 0},
['势不可挡的憎恶']= {2440, 3},
['克尔苏加德的残迹']= {2440, 4},
['海盗船蛮兵']= {2449, 1},
['渊誓刑罚者']= {2445, 1},
['渊誓霸主']= {2445, 2},
['宝库净化者']= {2448, 1},
['索·莉亚']= {2455, 0},
['P.O.S.T.总管']= {2436, 0},
['佐·格伦']= {2452, 0},
['索·阿兹密']= {2451, 0},
['典狱长之眼']= {2442, 0},
['耐奥祖的残迹']= {2444, 0},
['初诞者的卫士']= {2446, 0},
['命运撰写师罗-卡洛']= {2447, 0},
['莫盖斯']= {2456, 0},
['逃逸之魂']= {2456, 2},
['灵魂牢笼']= {2456, 1},
['影铸余烬']= {2443, 2},
['命生畸体']= {2447, 2},
['命生巨怪']= {2447, 1},
['绿洲保安']= {2452, 3},
['打架的顾客']= {2452, 1},
['捣乱的顾客']= {2452, 2},
['命运之影']= {2447, 3},
['玛尔加尼斯']= {2457, 0},
['金泰莎']= {2457, 1},
['警戒卫士']= {2458, 0},
['预制哨兵']= {2458, 2},
['不稳定的素材']= {2458, 4},
['定点防御无人机']= {2458, 3},
['利许威姆']= {2461, 0},
['莱葛隆']= {2467, 0},
['安特洛斯']= {2468, 0},
['安度因·乌瑞恩']= {2469, 0},
['圣物匠赛·墨克斯']= {2470, 0},
['源生圣物']= {2470, 1},
['黑伦度斯']= {2463, 0},
['自动防御矩阵']= {2458, 1},
['典狱长']= {2464, 0},
['司垢莱克斯']= {2465, 0},
['道茜歌妮']= {2459, 0},
['赦罪原型体']= {2460, 3},
['征战原型体']= {2460, 0},
['新生原型体']= {2460, 2},
['恪职原型体']= {2460, 1},
['宇宙核心']= {2467, 4},
['坍缩的类星体']= {2467, 1},
['不稳定的反物质']= {2467, 3},
['不稳定的核心']= {2467, 5},
['不稳定的物质']= {2467, 2},
['防御矩阵自动体']= {2461, 4},
['征用自动体']= {2461, 3},
['护卫自动体']= {2461, 1},
['退化自动体']= {2461, 2},
['肠击']= {2472, 0},
['树口']= {2473, 0},
['迅捷的埃瑞克']= {2475, 1},
['巴尔洛戈']= {2475, 0},
['奥拉夫']= {2475, 2},
['艾拉诺格']= {2480, 0},
['焰鳞塔拉赛']= {2480, 1},
['瑟娜尔丝，冰冷之息']= {2482, 0},
['柯姬雅·焰蹄']= {2485, 0},
['炎缚火焰风暴']= {2485, 1},
['哨兵塔隆达丝']= {2484, 0},
['布罗马奇']= {2487, 0},
['梅莉杜莎·寒妆']= {2488, 0},
['石窟地占师']= {2487, 2},
['石窟伏击者']= {2487, 1},
['熔炉主管戈雷克']= {2489, 0},
['查尔加斯，龙鳞之灾']= {2490, 0},
['莱魔']= {2492, 0},
['巢穴守护者迪乌尔娜']= {2493, 0},
['岩浆之牙']= {2494, 0},
['克罗兹']= {2495, 0},
['库洛格·恐怖图腾']= {2491, 0},
['地壳粉碎者']= {2491, 1},
['冰冻毁灭者']= {2491, 2},
['炽焰魔']= {2491, 3},
['雷霆破坏者']= {2491, 4},
['巴拉卡可汗']= {2477, 0},
['诺库德风暴法师']= {2477, 1},
--['时空领主戴欧斯']= {2479, 0},
['马鲁克']= {2478, 1},
['提拉']= {2478, 0},
['狂怒风暴']= {2497, 0},
['格拉尼斯']= {2498, 0},
['莱萨杰丝，噬雷之龙']= {2499, 0},
['泰洛斯']= {2500, 0},
['原始火焰']= {2480, 3},
['腐朽的软泥']= {2473, 1},
['厄克哈特·风脉']= {2503, 1},
['基拉卡']= {2503, 0},
['督军莎尔佳']= {2501, 0},
['看护者伊里度斯']= {2504, 0},
['烂牙土狼']= {2472, 1},
['安布雷斯库']= {2508, 0},
['青刃']= {2505, 0},
['好奇的小龙蛙']= {2507, 1},
['艾博隆']= {2476, 0},
['不屈者卡金']= {2510, 0},
['原始海啸']= {2511, 0},
['泰拉什·灰翼']= {2483, 0},
['维克萨姆斯']= {2509, 0},
['觉醒的碎岩']= {2506, 1},
['巴斯律孔']= {2506, 0},
['狡诈图腾']= {2471, 2},
['伤齿']= {2471, 1},
['莉拉·劈爪']= {2471, 0},
['腐朽主母怒眼']= {2474, 0},
['屠龙者之矛']= {2498, 1},
['诺库德破坏者']= {2498, 2},
['茂林古树']= {2512, 0},
['古树树枝']= {2512, 1},
['多拉苟萨的回响']= {2514, 0},
['拜荒注能者']= {2511, 1},
['饥饿的鞭笞者']= {2512, 2},
['抑制装置']= {2504, 1},
['巴祖阿尔']= {2517, 0},
['利斯卡诺兹']= {2518, 0},
['地锻碎击者']= {2491, 5},
['晋升者达瑟雅']= {2502, 0},
['唤雷者']= {2502, 2},
['苛性小蜘蛛']= {2482, 2},
['霜息蜘蛛']= {2482, 1},
['动荡的注能者']= {2502, 1},
['霜锻统御者']= {2491, 6},
['焰锻根除者']= {2491, 7},
['雷锻掠夺者']= {2491, 8},
['斯图恩兰']= {2515, 0},
['恩巴尔·火途']= {2486, 3},
['乳石之牙']= {2486, 2},
['卡德罗斯·冰怒']= {2486, 0},
['达瑟雅·风鞭']= {2486, 1},
['吞喉巨蛙']= {2507, 0},
['焰鳞队长']= {2480, 2},
['注能龙崽']= {2488, 1},
['龙裔影像']= {2505, 2},
['龙裔幻象']= {2505, 1},
['涌电毁灭者']= {2499, 2},
['神誓先锋']= {2499, 3},
['逐风助战者']= {2499, 4},
['不稳定的火花']= {2499, 1},
['巨型风魔']= {2499, 5},
['龙兽折焰者']= {2493, 3},
['塔拉赛军团士兵']= {2493, 7},
['拜荒法师']= {2493, 6},
['幼年冰霜始祖龙']= {2493, 1},
['塔拉赛掠地者']= {2493, 2},
['龙人风暴使者']= {2493, 4},
['初生始祖龙']= {2493, 5},
['焰誓传令官']= {2499, 7},
['霜铸狂热者']= {2499, 6},
['鳞长萨卡雷斯']= {2520, 0},
['莱修克']= {2525, 0},
['永恒守护者提尔']= {2526, 0},
['玛格莫莱克斯']= {2527, 0},
['空洞往忆']= {2520, 1},
['空虚微光']= {2520, 2},
['永恒炽焰']= {2529, 1},
['暗影烈焰融合体']= {2529, 2},
['暗影精华']= {2529, 0},
['奈尔迪丝']= {2530, 0},
['里翁苏斯']= {2530, 2},
['萨德里奥']= {2530, 1},
['瓦坎']= {2531, 0},
['苟尔娜']= {2531, 1},
['兹斯卡恩']= {2532, 0},
['克罗妮卡']= {2521, 0},
['卡扎拉']= {2522, 0},
['迦拉克隆之荒']= {2535, 0},
['达扎克']= {2535, 3},
['昂佐恩']= {2535, 1},
['洛斯凯勒兹']= {2535, 2},
['督军卡格尼']= {2524, 0},
['扎卡利攀墙者']= {2524, 2},
['焰缚猎人']= {2524, 3},
['伊格纳拉']= {2524, 1},
['岩浆秘士']= {2524, 4},
['黑曜卫士']= {2524, 5},
['伊律迪孔']= {2537, 0},
['岩石造物']= {2537, 1},
['火光之龙菲莱克']= {2519, 0},
['龙火魔像']= {2532, 1},
['米罗克']= {2536, 0},
['扭曲的畸变怪']= {2523, 2},
['彼岸之声']= {2523, 1},
['奈萨里奥']= {2523, 0},
['时空错位的步兵']= {2538, 2},
['时空领主戴欧斯']= {2538, 0},
['永恒守护者']= {2538, 1},
['时间流具象']= {2528, 0},
['安度因·洛萨']= {2534, 0},
['格罗玛什·地狱咆哮']= {2533, 0},
['拉罗达尔，烈焰守护者']= {2553, 0},
['残虐者艾姬拉']= {2554, 0},
['艾尔雯']= {2555, 1},
['乌克托斯']= {2555, 0},
['匹普']= {2555, 2},
['尼穆威']= {2556, 0},
['火焰树人']= {2553, 2},
['沃尔科罗斯']= {2557, 0},
['灼烧之根']= {2553, 3},
['奥罗斯托']= {2562, 0},
['被烈焰折磨的古树']= {2564, 0},
--['丁达尔·迅贤']= {2565, 0},
--['丁达尔·迅贤']= {2565, 1},
--['丁达尔·迅贤']= {2565, 2},
['被污染的鞭笞者']= {2564, 1},
['丁达尔·迅贤']= {2565, 3},
['凯里欧斯']= {2566, 0},
['老蜡须']= {2569, 0},
['烛芯']= {2569, 1},
['焦尾']= {2557, 1},
['E.D.N.A.']= {2572, 0},
['Stormguard Gorren']= {2567, 0},
['被污染的树人']= {2564, 2},
['生命之种']= {2553, 1},
['斯莫德隆']= {2563, 0},
['凝结污泥']= {102, 1},
['蜡烛之王']= {2560, 0},
['高阶代言人艾里奇']= {2582, 0},
['纳兹夏尔荣誉守卫']= {101, 1},
['纳兹夏尔冰霜女巫']= {101, 2},
['轮回守望者']= {2556, 1},
['淤泥']= {104, 3},
['耐普图隆']= {104, 1},
['厄祖玛特污墨']= {104, 2},
['秽斑']= {104, 4},
['卡多雷精魂']= {2519, 1},
['燃烧的巨像']= {2519, 3},
['尖叫之魂']= {2519, 2},
['斯卡莫拉克']= {2579, 0},
['水晶碎片']= {2579, 1},
['口渴的主顾']= {2586, 1},
['酿造大师阿德里尔']= {2586, 0},
--['Orator Krix'vizk']= {2594, 0},
--['Vx']= {2595, 1},
--['Nx']= {2595, 0},
['大捻接师艾佐']= {2596, 0},
['戈尔迪·底爵']= {2589, 0},
['凝结聚合体']= {2600, 0},
['收割者吉卡塔尔']= {2585, 0},
--['Nexus-Princess Ky'veza']= {2601, 0},
['安苏雷克女王']= {2602, 0},
--['Rasha'nan']= {2609, 0},
['被感染的子嗣']= {2609, 1},
['酒滴']= {2587, 1},
['艾帕']= {2587, 0},
['贪婪之裔']= {2607, 1},
['噬灭者乌格拉克斯']= {2607, 0},
--[[['Blazikon']= {2559, 0},
['The Darkness']= {2561, 0},
['The Black Blood']= {2611, 0},
['Voracious Worm']= {2612, 2},
['Blood Parasite']= {2612, 3},]]
['虫巢扭曲者欧维纳克斯']= {2612, 0},
--[[['Colossal Spider']= {2612, 1},
['Summoned Acolyte']= {2602, 6},
['Gloom Hatchling']= {2602, 7},
['Rasha'nan']= {2593, 0},
['General Umbriss']= {2617, 0},
['Valiona']= {2618, 1},
['Dragha Shadowburner']= {2618, 0},]]
['被召唤的暗影烈焰之灵']= {2618, 2},
--[[['Erudax']= {2619, 0},
['Twilight Hatchling']= {2619, 1},
['Skeinspinner Takazj']= {2608, 1},
['Anub'arash']= {2608, 0},]]
['内室卫士']= {2602, 3},
['扬升虚空语者']= {2602, 1},
['腐蚀掠行者']= {2602, 5},
['虔诚的敬奉者']= {2602, 2},
['虚空石畸体']= {2568, 0},
--['Stormrider Vokmar']= {2568, 3},
--['Void Chunk']= {2568, 1},
['觉醒的虚空石']= {2568, 2},
--['Speaker Shadowcrown']= {2580, 0},
--['Benk Buzzbee']= {2588, 0},
--['Cindy']= {2588, 1},
['贪婪的燧烬蜂']= {2588, 2},
--['Avanoxx']= {2583, 0},
['内室驱逐者']= {2602, 4},
--[['Orta']= {2625, 0},
['Forgemaster Throngus']= {2627, 0},
['Arathi Neophyte']= {2573, 1},
['Prioress Murrpray']= {2573, 0},
['Elaena Emberlanz']= {2571, 1},
['Sergeant Shaynemail']= {2571, 2},
['Captain Dailcry']= {2571, 0},
['Taener Duelmal']= {2571, 3},
['Baron Braunpyke']= {2570, 0},
['Shattershell Scarab']= {2608, 2},
['Shurrai']= {2636, 0},
['Drowned Arathi']= {2636, 1},
['Anub'zekt']= {2584, 0},]]
['席克兰']= {2599, 0},
--['Speaker Dorlita']= {2590, 0},
--['Speaker Brokk']= {2590, 1},
--['Kordac']= {2637, 0},
['开裂的斯卡丁']= {2635, 1},
--[['Aggregation of Horrors']= {2635, 0},
['Anub'ikkaj']= {2581, 0},
['Lost Watcher']= {2611, 1},
['Blood Horror']= {2611, 3},
['Forgotten Harbinger']= {2611, 2},]]

}
    
    
    
    
    
    
    
    
    
    
    
    
    



--###########
--加载保存数据
--###########
local panel= CreateFrame("Frame")
panel:RegisterEvent("ADDON_LOADED")
panel:SetScript("OnEvent", function(self, _, arg1)
    if arg1==id then
        if not e.disbledCN then 
            do
                for boss, info in pairs(bossTab) do                    
                    local index= (info[2] or 0)+1
                    local journalInstanceID= info[1]
                    local name= select(2, EJ_GetCreatureInfo(index, journalInstanceID))
                    if name then
                        e.strText[name]= boss
                    end
                end
            end
            bossTab=nil
        else
            bossTab=nil
        end        
        self:UnregisterEvent('ADDON_LOADED')
    end
end)