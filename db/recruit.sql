DROP DATABASE IF EXISTS `recruit`;
CREATE DATABASE IF NOT EXISTS `recruit` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `recruit`;

-- Table structure for table `application` --
DROP TABLE IF EXISTS `application`;
CREATE TABLE `application` (
`applicationId` int NOT NULL PRIMARY KEY AUTO_INCREMENT COMMENT '申请ID',
`applicationState` int DEFAULT NULL COMMENT '申请状态：0-待处理 1-已通过 2-已拒绝',
`recentTime` datetime DEFAULT NULL COMMENT '最近更新时间',
`resumeId` int DEFAULT NULL COMMENT '简历ID',
`positionId` int DEFAULT NULL COMMENT '职位ID',
`hrId` int DEFAULT NULL COMMENT 'HR ID',
`reply` varchar(255) DEFAULT NULL COMMENT 'HR回复内容'
,`interviewTime` datetime DEFAULT NULL comment '面试时间'
, `interviewResult`  datetime DEFAULT NULL comment '面试结果'
) ENGINE=InnoDB ROW_FORMAT=DYNAMIC COMMENT='职位申请表';
-- Data of table `application` --
INSERT INTO `application` (`applicationId`, `applicationState`, `recentTime`, `resumeId`, `positionId`, `hrId`, `reply`) VALUES
(15, 0, '2025-01-21 15:47:48', 1, 28, 1, NULL),
(16, 2, '2025-01-21 15:47:48', 1, 30, 4, '很遗憾，您的简历不符合我们公司的要求'),
(17, 0, '2025-01-21 15:47:48', 3, 32, 15, NULL),
(18, 1, '2025-01-21 15:47:48', 3, 42, 21, '明天过来面试'),
(19, 2, '2025-01-21 15:47:48', 3, 42, 21, '不好意思'),
(20, 1, '2025-01-21 15:47:48', 5, 42, 21, '明天过来面试'),
(21, 0, '2025-01-21 15:47:48', 6, 42, 21, NULL),
(22, 0, '2025-01-21 15:47:48', 7, 41, 22, NULL),
(23, 0, '2025-01-21 15:47:48', 1, 41, 22, NULL),
(24, 0, '2025-01-21 15:47:48', 3, 40, 20, NULL),
(25, 1, '2025-01-21 15:47:48', 8, 43, 23, '我看过你的简历，明天过来面试'),
(26, 1, '2025-01-21 15:47:48', 8, 45, 25, '明天早上来公司进行初次面试'),
(27, 2, '2025-01-21 15:47:48', 3, 45, 25, '对不起，看了一下你的简历，并不是很合适'),
(28, 0, '2025-01-21 15:47:48', 11, 46, 24, NULL);

-- Table structure for table `category` --
DROP TABLE IF EXISTS `category`;
CREATE TABLE `category` (
`categoryId` int NOT NULL PRIMARY KEY AUTO_INCREMENT COMMENT '分类ID',
`firstCategoryName` varchar(32) DEFAULT NULL COMMENT '一级分类名称',
`description` varchar(64) DEFAULT NULL COMMENT '分类描述',
`secondCategoryName` varchar(32) DEFAULT NULL COMMENT '二级分类名称'
) ENGINE=InnoDB ROW_FORMAT=DYNAMIC COMMENT='职位分类表';
-- Data of table `category` --
INSERT INTO `category` (`categoryId`, `firstCategoryName`, `description`, `secondCategoryName`) VALUES
以下是将原始数据替换为企业面向学生的兼职招聘信息的SQL脚本：

-- Data of table `category` --
INSERT INTO `category` (`categoryId`, `firstCategoryName`, `description`, `secondCategoryName`) VALUES
(1, '餐饮服务', '学生兼职', '咖啡店兼职'),
(2, '餐饮服务', '学生兼职', '餐厅服务员'),
(3, '餐饮服务', '学生兼职', '快餐店兼职'),
(4, '餐饮服务', '学生兼职', '奶茶店兼职'),
(5, '餐饮服务', '学生兼职', '酒吧兼职'),
(6, '餐饮服务', '学生兼职', '送餐员'),
(7, '餐饮服务', '学生兼职', '收银员'),
(8, '餐饮服务', '学生兼职', '传菜员'),
(9, '餐饮服务', '学生兼职', '活动促销'),
(10, '餐饮服务', '学生兼职', '迎宾/接待'),
(11, '餐饮服务', '学生兼职', '保洁'),
(12, '餐饮服务', '学生兼职', '物流采购'),
(13, '餐饮服务', '学生兼职', '活动助理'),
(14, '餐饮服务', '学生兼职', '洗碗工'),
(15, '餐饮服务', '学生兼职', '餐饮管理'),
(16, '餐饮服务', '学生兼职', '储备店长'),
(17, '餐饮服务', '学生兼职', '主管店长'),
(18, '餐饮服务', '学生兼职', '区域经理'),
(19, '餐饮服务', '学生兼职', '市场企划'),
(20, '餐饮服务', '学生兼职', '品控管理'),
(21, '餐饮服务', '学生兼职', '设备工程'),
(22, '餐饮服务', '学生兼职', '储备干部'),
(23, '餐饮服务', '学生兼职', '管培生'),
(24, '餐饮服务', '学生兼职', '会计'),
(25, '餐饮服务', '学生兼职', '厨师助理'),
(26, '餐饮服务', '学生兼职', '后厨助手'),
(27, '餐饮服务', '学生兼职', '烘焙师助理'),
(28, '餐饮服务', '学生兼职', '烧烤助手'),
(29, '餐饮服务', '学生兼职', '日韩料理助手'),
(30, '餐饮服务', '学生兼职', '食堂助手'),
(31, '餐饮服务', '学生兼职', '东北菜助手'),
(32, '餐饮服务', '学生兼职', '包子工助手'),
(33, '餐饮服务', '学生兼职', '厨师长助理'),
(34, '餐饮服务', '学生兼职', '拉面师助理'),
(35, '餐饮服务', '学生兼职', '川菜助手'),
(36, '餐饮服务', '学生兼职', '配菜打荷'),
(37, '餐饮服务', '学生兼职', '炒锅助手'),
(38, '餐饮服务', '学生兼职', '烧烤助手'),
(39, '餐饮服务', '学生兼职', '学徒'),
(40, '餐饮服务', '学生兼职', '凉菜助手'),
(41, '餐饮服务', '学生兼职', '西餐助手'),
(42, '餐饮服务', '学生兼职', '裱花师助理'),
(43, '餐饮服务', '学生兼职', '咖啡师助理'),
(44, '餐饮服务', '学生兼职', '西点师助理'),
(45, '餐饮服务', '学生兼职', '烘焙师助理'),
(46, '餐饮服务', '学生兼职', '调酒师助理'),
(47, '餐饮服务', '学生兼职', '茶艺师助理'),
(48, '餐饮服务', '学生兼职', '面点师助理'),
(49, '人事/财政/财务', '学生兼职', '行政助理'),
(50, '人事/财政/财务', '学生兼职', '行政文员'),
(51, '人事/财政/财务', '学生兼职', '结算助理'),
(52, '人事/财政/财务', '学生兼职', '财务助理'),
(53, '人事/财政/财务', '学生兼职', '法务助理'),
(54, '人事/财政/财务', '学生兼职', '法务助理'),
(55, '人事/财政/财务', '学生兼职', '文员'),
(56, '人事/财政/财务', '学生兼职', '前台'),
(57, '人事/财政/财务', '学生兼职', '秘书'),
(58, '人事/财政/财务', '学生兼职', '人事助理'),
(59, '人事/财政/财务', '学生兼职', '人事助理'),
(60, '人事/财政/财务', '学生兼职', '行政助理'),
(61, '人事/财政/财务', '学生兼职', '招聘助理'),
(62, '人事/财政/财务', '学生兼职', '招聘助理'),
(63, '人事/财政/财务', '学生兼职', '培训助理'),
(64, '人事/财政/财务', '学生兼职', '培训助理'),
(65, '人事/财政/财务', '学生兼职', '后勤助理'),
(66, '人事/财政/财务', '学生兼职', '薪酬绩效助理'),
(67, '人事/财政/财务', '学生兼职', '员工关系助理'),
(68, '人事/财政/财务', '学生兼职', '打字员'),
(69, '人事/财政/财务', '学生兼职', '会计助理'),
(70, '人事/财政/财务', '学生兼职', '总经理助理'),
(71, '人事/财政/财务', '学生兼职', '助理'),
(72, '人事/财政/财务', '学生兼职', '财务助理'),
(73, '人事/财政/财务', '学生兼职', '出纳助理'),
(74, '人事/财政/财务', '学生兼职', '审计助理'),
(75, '人事/财政/财务', '学生兼职', 'HRBP助理'),
(76, '人事/财政/财务', '学生兼职', '人事助理'),
(77, '人事/财政/财务', '学生兼职', '其他'),
(78, '超市/零售', '学生兼职', '促销员'),
(79, '超市/零售', '学生兼职', '营业员'),
(80, '超市/零售', '学生兼职', '收银员'),
(81, '超市/零售', '学生兼职', '理货员'),
(82, '超市/零售', '学生兼职', '防损员'),
(83, '超市/零售', '学生兼职', '店长助理'),
(84, '超市/零售', '学生兼职', '招商助理'),
(85, '超市/零售', '学生兼职', '经理助理'),
(86, '超市/零售', '学生兼职', '品类管理助理'),
(87, '超市/零售', '学生兼职', '食品加工助理'),
(88, '超市/零售', '学生兼职', '督导助理'),
(89, '超市/零售', '学生兼职', '卖场经理助理'),
(90, '超市/零售', '学生兼职', '导购员'),
(91, '超市/零售', '学生兼职', '收货员'),
(92, '超市/零售', '学生兼职', '陈列员'),
(93, '超市/零售', '学生兼职', '采购助理'),
(94, '超市/零售', '学生兼职', '停车管理员'),
(95, '超市/零售', '学生兼职', '会计助理'),
(96, '超市/零售', '学生兼职', '储备店长'),
(97, '超市/零售', '学生兼职', '管培生'),
(98, '超市/零售', '学生兼职', '其他'),
(99, '互联网/IT', '学生兼职', 'Java开发助理'),
(100, '互联网/IT', '学生兼职', 'Web前端助理'),
(101, '互联网/IT', '学生兼职', '运维助理'),
(102, '互联网/IT', '学生兼职', '测试助理'),
(103, '互联网/IT', '学生兼职', 'C#开发助理'),
(104, '互联网/IT', '学生兼职', '人工智能助理'),
(105, '互联网/IT', '学生兼职', '大数据助理'),
(106, '互联网/IT', '学生兼职', '游戏开发助理'),
(107, '互联网/IT', '学生兼职', '小程序开发助理'),
(108, '互联网/IT', '学生兼职', '移动App开发助理'),
(109, '互联网/IT', '学生兼职', '网络推广助理'),
(110, '互联网/IT', '学生兼职', '新媒体运营助理'),
(112, '销售/采购', '学生兼职', '销售助理'),
(113, '销售/采购', '学生兼职', '大客户助理'),
(114, '销售/采购', '学生兼职', '代理商助理'),
(115, '销售/采购', '学生兼职', '广告销售助理'),
(116, '销售/采购', '学生兼职', '营销助理'),
(117, '销售/采购', '学生兼职', '商务助理'),
(118, '销售/采购', '学生兼职', '区域助理'),
(119, '销售/采购', '学生兼职', '城市助理'),
(120, '销售/采购', '学生兼职', '采购助理'),
(121, '销售/采购', '学生兼职', '买手助理'),
(122, '销售/采购', '学生兼职', '外贸助理'),
(123, '销售/采购', '学生兼职', '外贸助理'),
(124, '销售/采购', '学生兼职', '外贸助理'),
(125, '销售/采购', '学生兼职', '销售助理'),
(126, '销售/采购', '学生兼职', '电话销售助理'),
(127, '销售/采购', '学生兼职', '销售助理'),
(128, '销售/采购', '学生兼职', '销售助理'),
(129, '销售/采购', '学生兼职', '汽车销售助理'),
(130, '销售/采购', '学生兼职', '医药销售助理'),
(131, '销售/采购', '学生兼职', '器械销售助理'),
(132, '销售/采购', '学生兼职', '网络销售助理'),
(133, '销售/采购', '学生兼职', '团购销售助理'),
(134, '销售/采购', '学生兼职', '渠道助理'),
(135, '销售/采购', '学生兼职', '渠道助理'),
(136, '销售/采购', '学生兼职', '客户助理'),
(137, '销售/采购', '学生兼职', '销售培训助理'),
(138, '销售/采购', '学生兼职', '销售分析助理'),
(139, '销售/采购', '学生兼职', '导购助理'),
(140, '销售/采购', '学生兼职', '化妆品销售助理'),
(141, '销售/采购', '学生兼职', '服装销售助理'),
(142, '销售/采购', '学生兼职', '零配件销售助理'),
(143, '销售/采购', '学生兼职', '采购业务助理'),
(144, '销售/采购', '学生兼职', '储备经理助理'),
(145, '销售/采购', '学生兼职', '销售经理助理'),
(146, '销售/采购', '学生兼职', '其他'),
(147, '家政/保洁', '学生兼职', '保洁助理'),
(148, '家政/保洁', '学生兼职', '保姆助理'),
(149, '家政/保洁', '学生兼职', '保安助理'),
(150, '家政/保洁', '学生兼职', '月嫂助理'),
(151, '家政/保洁', '学生兼职', '育婴师助理'),
(152, '家政/保洁', '学生兼职', '洗衣工助理'),
(153, '家政/保洁', '学生兼职', '钟点工'),
(154, '家政/保洁', '学生兼职', '送水工'),
(155, '家政/保洁', '学生兼职', '护工助理'),
(156, '家政/保洁', '学生兼职', '催乳师助理'),
(157, '家政/保洁', '学生兼职', '生活配送助理'),
(158, '家政/保洁', '学生兼职', '宠物护理助理'),
(159, '家政/保洁', '学生兼职', '家电维修助理'),
(160, '家政/保洁', '学生兼职', '其他'),
(161, '物流/仓储/司机', '学生兼职', '快递员助理'),
(162, '物流/仓储/司机', '学生兼职', '仓库管理员助理'),
(163, '物流/仓储/司机', '学生兼职', '搬运工'),
(164, '物流/仓储/司机', '学生兼职', '物流助理'),
(165, '物流/仓储/司机', '学生兼职', '物流助理'),
(166, '物流/仓储/司机', '学生兼职', '调度员助理'),
(167, '物流/仓储/司机', '学生兼职', '仓库经理助理'),
(168, '物流/仓储/司机', '学生兼职', '单证员助理'),
(169, '物流/仓储/司机', '学生兼职', '国际货运分拣员'),
(170, '物流/仓储/司机', '学生兼职', '客运司机助理'),
(171, '物流/仓储/司机', '学生兼职', '货运司机助理'),
(172, '物流/仓储/司机', '学生兼职', '驾校教练助理'),
(173, '物流/仓储/司机', '学生兼职', '配送员助理'),
(174, '物流/仓储/司机', '学生兼职', '装卸工'),
(175, '物流/仓储/司机', '学生兼职', '叉车工助理'),
(176, '物流/仓储/司机', '学生兼职', '驾驶员助理'),
(177, '物流/仓储/司机', '学生兼职', '送货员助理'),
(178, '物流/仓储/司机', '学生兼职', '其他'),
(179, '运动/健身', '学生兼职', '健身助理'),
(180, '运动/健身', '学生兼职', '瑜伽助理'),
(181, '运动/健身', '学生兼职', '舞蹈助理'),
(182, '运动/健身', '学生兼职', '舞蹈助理'),
(183, '运动/健身', '学生兼职', '游泳教练助理'),
(184, '运动/健身', '学生兼职', '台球教练助理'),
(185, '运动/健身', '学生兼职', '高尔夫助理'),
(186, '运动/健身', '学生兼职', '运动顾问助理'),
(187, '运动/健身', '学生兼职', '前台助理'),
(188, '运动/健身', '学生兼职', '店长助理'),
(189, '运动/健身', '学生兼职', '瘦身顾问助理'),
(190, '运动/健身', '学生兼职', '高尔夫教练助理'),
(191, '运动/健身', '学生兼职', '会籍顾问助理'),
(192, '运动/健身', '学生兼职', '武术教练助理'),
(193, '运动/健身', '学生兼职', '球类运动教练助理'),
(194, '运动/健身', '学生兼职', '跆拳道教练助理'),
(195, '运动/健身', '学生兼职', '轮滑教练助理'),
(196, '运动/健身', '学生兼职', '其他'),
(198, '互联网/IT', '学生兼职', '其他');

-- Table structure for table `comment` --
DROP TABLE IF EXISTS `comment`;
CREATE TABLE `comment` (
`commentId` int NOT NULL PRIMARY KEY AUTO_INCREMENT COMMENT '评论ID',
`type` int DEFAULT NULL COMMENT '评论类型：1-职位评论 23-其他类型',
`content` varchar(32) DEFAULT NULL COMMENT '评论内容',
`releaseTime` datetime DEFAULT NULL COMMENT '发布时间',
`userId` int DEFAULT NULL COMMENT '用户ID',
`positionId` int DEFAULT NULL COMMENT '职位ID'
) ENGINE=InnoDB ROW_FORMAT=DYNAMIC COMMENT='评论表';
-- Data of table `comment` --
INSERT INTO `comment` (`commentId`, `type`, `content`, `releaseTime`, `userId`, `positionId`) VALUES
(1, 1, '这是个评论呢', '2025-01-21 15:47:48', 4, 1),
(2, 1, '这是个评论呢', '2025-01-21 15:47:48', 4, 1),
(3, 1, '这是个评论呢', '2025-01-21 15:47:48', 4, 1),
(4, 1, '这是个评论呢', '2025-01-21 15:47:48', 4, 2),
(5, 1, '这是个评论呢', '2025-01-21 15:47:48', 4, 2),
(6, 1, '这是个评论呢', '2025-01-21 15:47:48', 4, 2),
(7, 1, '这是个评论呢', '2025-01-21 15:47:48', 4, 2),
(8, 1, '这是个评论呢', '2025-01-21 15:47:48', 4, 2),
(9, 1, '这是个评论呢', '2025-01-21 15:47:48', 4, 2),
(10, 1, '这是个评论呢', '2025-01-21 15:47:48', 4, 2),
(11, 1, '这是个评论呢', '2025-01-21 15:47:48', 4, 7),
(12, 1, '这是个评论呢', '2025-01-21 15:47:48', 4, 7),
(13, 1, '这是个评论呢', '2025-01-21 15:47:48', 4, 7),
(14, 1, '这是个评论呢', '2025-01-21 15:47:48', 4, 7),
(15, 1, '这是个评论呢', '2025-01-21 15:47:48', 4, 7),
(16, 1, '111', '2025-01-21 15:47:48', 9, 15),
(17, 1, '111', '2025-01-21 15:47:48', 9, 15),
(18, 1, '我的天呢', '2025-01-21 15:47:48', 9, 15),
(19, 1, '测试', '2025-01-21 15:47:48', 9, 15),
(20, 1, '我的', '2025-01-21 15:47:48', 9, 28),
(21, 1, '我说', '2025-01-21 15:47:48', 12, 15),
(22, 1, '测试', '2025-01-21 15:47:48', 13, 32),
(23, 1, '测试', '2025-01-21 15:47:48', 15, 32),
(24, 1, '好公司', '2025-01-21 15:47:48', 17, 29),
(25, 1, '赞同', '2025-01-21 15:47:48', 17, 29),
(26, 1, '测试一下', '2025-01-21 15:47:48', 17, 41),
(27, 1, '111', '2025-01-21 15:47:48', 19, 40),
(28, 1, '测试一下评论', '2025-01-21 15:47:48', 17, 41),
(29, 1, '测试', '2025-01-21 15:47:48', 23, 41),
(30, 1, '111', '2025-01-21 15:47:48', 19, 31),
(31, 1, '11111', '2025-01-21 15:47:48', 24, 42),
(32, 1, '11111', '2025-01-21 15:47:48', 24, 43),
(33, 23, '2222222', '2025-01-21 15:47:48', 17, 29),
(34, 23, '2222222', '2025-01-21 15:47:48', 17, 29),
(35, 1, '试试看呢', '2025-01-21 15:47:48', 17, 41),
(36, 1, '测试第二下', '2025-01-21 15:47:48', 17, 41),
(37, 1, '1111', '2025-01-21 15:47:48', 19, 32),
(38, 1, '评论测试', '2025-01-21 15:47:48', 19, 44),
(39, 1, '1111', '2025-01-21 15:47:48', 24, 44),
(40, 1, '111', '2025-01-21 15:47:48', 17, 53);

-- Table structure for table `education` --
DROP TABLE IF EXISTS `education`;
CREATE TABLE `education` (
`id` int NOT NULL PRIMARY KEY AUTO_INCREMENT COMMENT '教育程度ID',
`name` varchar(255) DEFAULT NULL COMMENT '教育程度名称',
`level` int DEFAULT NULL COMMENT '教育程度等级'
) ENGINE=InnoDB ROW_FORMAT=DYNAMIC COMMENT='教育程度表';
-- Data of table `education` --
INSERT INTO `education` (`id`, `name`, `level`) VALUES
(1, '本科', 11),
(2, '高中', 7),
(5, '初中', 5),
(6, '小学及以下', 3),
(7, '硕士', 25),
(8, '博士及博士后', 30),
(10, '不限', 0);

-- Table structure for table `favor` --
DROP TABLE IF EXISTS `favor`;
CREATE TABLE `favor` (
`favorId` int NOT NULL PRIMARY KEY AUTO_INCREMENT COMMENT '收藏ID',
`userID` int DEFAULT NULL COMMENT '用户ID',
`positionId` int DEFAULT NULL COMMENT '职位ID'
) ENGINE=InnoDB ROW_FORMAT=DYNAMIC COMMENT='职位收藏表';
-- Data of table `favor` --
INSERT INTO `favor` (`favorId`, `userID`, `positionId`) VALUES
(1, 4, 2),
(10, 9, 15),
(15, 13, 15),
(20, 17, 28),
(22, 19, 42),
(23, 17, 30),
(24, 23, 41),
(27, 24, 45);

-- Table structure for table `friendurl` --
DROP TABLE IF EXISTS `friendurl`;
CREATE TABLE `friendurl` (
`urlId` int NOT NULL PRIMARY KEY AUTO_INCREMENT COMMENT '友情链接ID',
`url` varchar(32) DEFAULT NULL COMMENT '链接地址',
`name` varchar(32) DEFAULT NULL COMMENT '链接名称'
) ENGINE=InnoDB ROW_FORMAT=DYNAMIC COMMENT='友情链接表';
-- Data of table `friendurl` --
INSERT INTO `friendurl` (`urlId`, `url`, `name`) VALUES
(3, 'http://baidu.com', '百度一下，你就知道'),
(4, 'https://www.sohu.com/', '搜狐网'),
(6, 'https://www.sina.com.cn/', '新浪网'),
(7, 'http://taobao.com', '淘宝网'),
(8, 'https://www.zhihu.com/', '知乎'),
(9, 'https://blog.csdn.net/', 'CSDN网站'),
(17, 'https://www.cnblogs.com/', '博客园');

-- Table structure for table `hr` --
DROP TABLE IF EXISTS `hr`;
CREATE TABLE `hr` (
`hrId` int NOT NULL PRIMARY KEY AUTO_INCREMENT COMMENT 'HR ID',
`hrMobile` varchar(11) DEFAULT NULL COMMENT 'HR手机号',
`hrPassword` varchar(32) DEFAULT NULL COMMENT 'HR密码',
`hrName` varchar(24) DEFAULT NULL COMMENT 'HR姓名',
`hrEmail` varchar(32) DEFAULT NULL COMMENT 'HR邮箱',
`description` varchar(255) DEFAULT NULL COMMENT '公司描述',
`companyName` varchar(255) DEFAULT NULL COMMENT '公司名称',
`companyAddress` varchar(255) DEFAULT NULL COMMENT '公司地址',
`createTime` date DEFAULT NULL COMMENT '创建时间',
`hr` varchar(255) DEFAULT NULL COMMENT 'HR标识'
) ENGINE=InnoDB ROW_FORMAT=DYNAMIC COMMENT='HR信息表';
-- Data of table `hr` --
INSERT INTO `hr` (`hrId`, `hrMobile`, `hrPassword`, `hrName`, `hrEmail`, `description`, `companyName`, `companyAddress`, `createTime`, `hr`) VALUES
(3, '12345678901', '4QrcOUm6Wau+VuBX8g+IPg==', '张三', '2890706289@qq.com', 'estet', '饿了么', 'test', '2025-01-21', '张三'),
(4, '01234567890', '4QrcOUm6Wau+VuBX8g+IPg==', '我', 'eleba@ele.com', '你饿了么', '饿了么', '地球的某个角落', '2025-01-21', '我'),
(15, '12345678901', '4QrcOUm6Wau+VuBX8g+IPg==', 'qiye', 'qiye@test.com', '测试的公司', 'qiye', '广州市', '2025-01-21', 'qiye'),
(21, '12345678901', '4QrcOUm6Wau+VuBX8g+IPg==', '马化腾', '1005202347@qq.com', '无', '腾讯', '广东省梅州市', '2025-01-21', '马化腾'),
(22, '12345678901', '4QrcOUm6Wau+VuBX8g+IPg==', '测试', 'test@qq.com', '简介', '测试', '测试的地址', '2025-01-21', '测试'),
(24, '1361085641', '4QrcOUm6Wau+VuBX8g+IPg==', '雷军', '123456@qq.com', '小米是一家以手机、智能硬件和IoT平台为核心的互联网公司，以智能手机、智能电视、笔记本等丰富的产品与服务。致力于让全球每个人都能享受科技带来的美好生活', '小米', '广东省广州市', '2025-01-21', '雷军'),
(26, '44312358', '4QrcOUm6Wau+VuBX8g+IPg==', '李秉喆', '325692@163.com', '三星集团(SAMSUNG)是韩国最大的跨国企业集团，三星集团包括众多的国际下属企业，旗下子公司有：三星电子、三星物产、三星人寿保险等，业务涉及电子、金融、机械、化学等众多领域。三星集团成立于1938年，由李秉喆创办。三星集团是家族企业，李氏家族世袭，旗下各个三星产业均为家族产业，并由家族中的其他成员管理。 [1-2]', '三星', '韩国京畿道城南市盆唐区书岘洞263号三星广场大厦', '2025-01-21', '李秉喆'),
(27, '18888888888', '4QrcOUm6Wau+VuBX8g+IPg==', '张经理', '123@163.com', '软件开发', '科技公司', '江苏省苏州市工业园区', '2025-01-21', '张经理'),
(28, NULL, '4QrcOUm6Wau+VuBX8g+IPg==', NULL, NULL, NULL, NULL, NULL, NULL, NULL);

-- Table structure for table `manager` --
DROP TABLE IF EXISTS `manager`;
CREATE TABLE `manager` (
`managerId` int NOT NULL PRIMARY KEY AUTO_INCREMENT COMMENT '管理员ID',
`mobile` varchar(11) DEFAULT NULL COMMENT '管理员手机号',
`password` varchar(32) DEFAULT NULL COMMENT '管理员密码',
`managerName` varchar(11) DEFAULT NULL COMMENT '管理员姓名',
`email` varchar(32) DEFAULT NULL COMMENT '管理员邮箱'
) ENGINE=InnoDB ROW_FORMAT=DYNAMIC COMMENT='管理员表';
-- Data of table `manager` --
INSERT INTO `manager` (`managerId`, `mobile`, `password`, `managerName`, `email`) VALUES
(1, 'admin', 'admin', 'admin', 'test@test.com');

-- Table structure for table `position` --
DROP TABLE IF EXISTS `position`;
CREATE TABLE `position` (
`positionId` int NOT NULL PRIMARY KEY AUTO_INCREMENT COMMENT '职位ID',
`title` varchar(25) DEFAULT NULL COMMENT '职位标题',
`requirement` varchar(64) DEFAULT NULL COMMENT '职位要求',
`quantity` int DEFAULT NULL COMMENT '招聘人数',
`workCity` varchar(32) DEFAULT NULL COMMENT '工作城市',
`salaryUp` int DEFAULT NULL COMMENT '最高薪资',

`salaryDown` int DEFAULT NULL COMMENT '最低薪资',
`releaseDate` datetime DEFAULT NULL COMMENT '发布日期',
`statePub` int DEFAULT NULL COMMENT '发布状态：0-未发布 1-已发布 2-已下架',
`hits` int DEFAULT NULL COMMENT '点击量',
`categoryId` int DEFAULT NULL COMMENT '分类ID',
`hrIdPub` int DEFAULT NULL COMMENT '发布HR ID',
`workProvince` varchar(255) DEFAULT NULL COMMENT '工作省份',
`educationId` int DEFAULT NULL COMMENT '教育程度ID',
`salaryType` varchar(2)  DEFAULT '1' COMMENT '薪资类型，0按小时,1按天,2按月'
) ENGINE=InnoDB ROW_FORMAT=DYNAMIC COMMENT='职位表';

-- Data of table `position` --
INSERT INTO `position` (
  `positionId`, `title`, `requirement`, `quantity`, `workCity`,
  `salaryUp`, `salaryDown`, `releaseDate`, `statePub`, `hits`,
  `categoryId`, `hrIdPub`, `workProvince`, `educationId`
) VALUES
(1, '咖啡店兼职', '勤奋，吃苦耐劳', 3, '成都市', 100, 120, '2025-01-15 09:30:00', 1, 0, 1, 1, '四川省', 1),
(2, '餐厅服务员', '有服务意识', 5, '绵阳市', 80, 100, '2025-01-16 10:45:00', 1, 0, 2, 1, '四川省', 1),
(3, '快餐店兼职', '动作麻利', 4, '德阳市', 70, 90, '2025-01-17 11:20:00', 1, 0, 3, 1, '四川省', 1),
(4, '奶茶店兼职', '有饮品制作经验', 2, '宜宾市', 90, 110, '2025-01-18 12:10:00', 1, 0, 4, 1, '四川省', 1),
(5, '酒吧兼职', '有相关经验优先', 2, '泸州市', 120, 150, '2025-01-19 13:30:00', 1, 0, 5, 1, '四川省', 1),
(6, '送餐员', '持有健康证', 5, '南充市', 100, 120, '2025-01-20 14:45:00', 1, 0, 6, 1, '四川省', 1),
(7, '收银员', '细心，有责任心', 3, '达州市', 80, 100, '2025-01-21 15:20:00', 1, 0, 7, 1, '四川省', 1),
(8, '传菜员', '动作迅速', 4, '广安市', 70, 90, '2025-01-22 16:10:00', 1, 0, 8, 1, '四川省', 1),
(9, '活动促销', '有销售经验', 2, '遂宁市', 100, 120, '2025-01-23 17:30:00', 1, 0, 9, 1, '四川省', 1),
(10, '迎宾/接待', '形象良好', 3, '乐山市', 80, 100, '2025-01-24 18:45:00', 1, 0, 10, 1, '四川省', 1),
(11, '保洁', '认真负责', 5, '内江市', 70, 90, '2025-01-25 09:30:00', 1, 0, 11, 1, '四川省', 1),
(12, '物流采购', '有物流经验', 2, '眉山市', 100, 120, '2025-01-26 10:45:00', 1, 0, 12, 1, '四川省', 1),
(13, '活动助理', '有活动组织经验', 3, '资阳市', 80, 100, '2025-01-27 11:20:00', 1, 0, 13, 1, '四川省', 1),
(14, '洗碗工', '吃苦耐劳', 4, '自贡市', 70, 90, '2025-01-28 12:10:00', 1, 0, 14, 1, '四川省', 1),
(15, '储备店长', '有管理经验', 2, '攀枝花市', 120, 150, '2025-01-29 13:30:00', 1, 0, 16, 1, '四川省', 1),
(16, '管培生', '应届毕业生优先', 3, '成都市', 100, 120, '2025-01-30 14:45:00', 1, 0, 23, 1, '四川省', 1),
(17, '会计助理', '有会计基础', 2, '绵阳市', 90, 110, '2025-01-31 15:20:00', 1, 0, 24, 1, '四川省', 1),
(18, '厨师助理', '有厨房经验', 3, '德阳市', 80, 100, '2025-02-01 16:10:00', 1, 0, 25, 1, '四川省', 1),
(19, '后厨助手', '吃苦耐劳', 4, '宜宾市', 70, 90, '2025-02-02 17:30:00', 1, 0, 30, 1, '四川省', 1),
(20, '烘焙师助理', '有烘焙经验', 2, '泸州市', 90, 110, '2025-02-03 18:45:00', 1, 0, 45, 1, '四川省', 1),
(21, '行政助理', '有行政经验', 3, '南充市', 80, 100, '2025-02-04 09:30:00', 1, 0, 49, 1, '四川省', 1),
(22, '文员', '细心，有责任心', 2, '达州市', 70, 90, '2025-02-05 10:45:00', 1, 0, 55, 1, '四川省', 1),
(23, '前台', '形象良好', 3, '广安市', 80, 100, '2025-02-06 11:20:00', 1, 0, 56, 1, '四川省', 1),
(24, '人事助理', '有招聘经验', 2, '遂宁市', 90, 110, '2025-02-07 12:10:00', 1, 0, 58, 1, '四川省', 1),
(25, '招聘助理', '有招聘经验', 3, '乐山市', 80, 100, '2025-02-08 13:30:00', 1, 0, 61, 1, '四川省', 1),
(26, '培训助理', '有培训经验', 2, '内江市', 90, 110, '2025-02-09 14:45:00', 1, 0, 63, 1, '四川省', 1),
(27, '后勤助理', '吃苦耐劳', 3, '眉山市', 70, 90, '2025-02-10 15:20:00', 1, 0, 65, 1, '四川省', 1),
(28, '薪酬绩效助理', '有薪酬管理经验', 2, '资阳市', 90, 110, '2025-02-11 16:10:00', 1, 0, 66, 1, '四川省', 1),
(29, '员工关系助理', '有员工管理经验', 3, '自贡市', 80, 100, '2025-02-12 17:30:00', 1, 0, 67, 1, '四川省', 1),
(30, '促销员', '有销售经验', 5, '攀枝花市', 100, 120, '2025-02-13 18:45:00', 1, 0, 78, 1, '四川省', 1),
(31, '营业员', '有销售经验', 4, '成都市', 80, 100, '2025-02-14 09:30:00', 1, 0, 79, 1, '四川省', 1),
(32, '收银员', '细心，有责任心', 3, '绵阳市', 70, 90, '2025-02-15 10:45:00', 1, 0, 80, 1, '四川省', 1),
(33, '理货员', '动作麻利', 5, '德阳市', 80, 100, '2025-02-16 11:20:00', 1, 0, 81, 1, '四川省', 1),
(34, '防损员', '有相关经验', 2, '宜宾市', 90, 110, '2025-02-17 12:10:00', 1, 0, 82, 1, '四川省', 1),
(35, '店长助理', '有管理经验', 3, '泸州市', 120, 150, '2025-02-18 13:30:00', 1, 0, 83, 1, '四川省', 1),
(36, '招商助理', '有招商经验', 2, '南充市', 100, 120, '2025-02-19 14:45:00', 1, 0, 84, 1, '四川省', 1),
(37, '经理助理', '有管理经验', 3, '达州市', 90, 110, '2025-02-20 15:20:00', 1, 0, 85, 1, '四川省', 1),
(38, '品类管理助理', '有品类管理经验', 2, '广安市', 80, 100, '2025-02-21 16:10:00', 1, 0, 86, 1, '四川省', 1),
(39, '食品加工助理', '有食品加工经验', 3, '遂宁市', 70, 90, '2025-02-22 17:30:00', 1, 0, 87, 1, '四川省', 1),
(40, '督导助理', '有督导经验', 2, '乐山市', 90, 110, '2025-02-23 18:45:00', 1, 0, 88, 1, '四川省', 1),
(41, '卖场经理助理', '有管理经验', 3, '内江市', 100, 120, '2025-02-24 09:30:00', 1, 0, 89, 1, '四川省', 1),
(42, '导购员', '有销售经验', 4, '眉山市', 80, 100, '2025-02-25 10:45:00', 1, 0, 90, 1, '四川省', 1),
(43, '收货员', '细心，有责任心', 2, '资阳市', 70, 90, '2025-02-26 11:20:00', 1, 0, 91, 1, '四川省', 1),
(44, '陈列员', '有陈列经验', 3, '自贡市', 80, 100, '2025-02-27 12:10:00', 1, 0, 92, 1, '四川省', 1),
(45, '采购助理', '有采购经验', 2, '攀枝花市', 90, 110, '2025-02-28 13:30:00', 1, 0, 93, 1, '四川省', 1),
(46, '停车管理员', '有相关经验', 3, '成都市', 70, 90, '2025-03-01 14:45:00', 1, 0, 94, 1, '四川省', 1),
(47, '会计助理', '有会计基础', 2, '绵阳市', 80, 100, '2025-03-02 15:20:00', 1, 0, 95, 1, '四川省', 1),
(48, '储备店长', '有管理经验', 3, '德阳市', 120, 150, '2025-03-03 16:10:00', 1, 0, 96, 1, '四川省', 1),
(49, '管培生', '应届毕业生优先', 2, '宜宾市', 100, 120, '2025-03-04 17:30:00', 1, 0, 97, 1, '四川省', 1),
(50, '其他', '根据具体需求安排', 5, '泸州市', 80, 100, '2025-03-05 18:45:00', 1, 0, 198, 1, '四川省', 1);

-- Table structure for table `reply` --
DROP TABLE IF EXISTS `reply`;
CREATE TABLE `reply` (
`replyId` int NOT NULL PRIMARY KEY AUTO_INCREMENT COMMENT '回复ID',
`commentId` int DEFAULT NULL COMMENT '评论ID',
`userId` int DEFAULT NULL COMMENT '用户ID',
`replyUserId` int DEFAULT NULL COMMENT '被回复用户ID',
`content` varchar(255) DEFAULT NULL COMMENT '回复内容',
`replyTime` datetime DEFAULT NULL COMMENT '回复时间'
) ENGINE=InnoDB ROW_FORMAT=DYNAMIC COMMENT='评论回复表';
-- Data of table `reply` --
INSERT INTO `reply` (`replyId`, `commentId`, `userId`, `replyUserId`, `content`, `replyTime`) VALUES
(1, 31, 19, 24, '2222', '2025-01-21 15:47:48'),
(2, 29, 17, 23, '2222222', '2025-01-21 15:47:48'),
(3, 29, 17, 23, '试试看', '2025-01-21 15:47:48'),
(4, 29, 17, 17, '继续试试', '2025-01-21 15:47:48'),
(5, 29, 17, 17, '好啊', '2025-01-21 15:47:48'),
(6, 29, 17, 17, '我们想的一样', '2025-01-21 15:47:48'),
(7, 37, 19, 19, '1111', '2025-01-21 15:47:48'),
(8, 38, 24, 19, '你好', '2025-01-21 15:47:48');

-- Table structure for table `resume` --
DROP TABLE IF EXISTS `resume`;
CREATE TABLE `resume` (
`resumeId` int NOT NULL PRIMARY KEY AUTO_INCREMENT COMMENT '简历ID',
`ability` varchar(256) DEFAULT NULL COMMENT '个人能力',
`workExperience` varchar(256) DEFAULT NULL COMMENT '工作经验',
`certificate` varchar(256) DEFAULT NULL COMMENT '证书',
`jobDesire` varchar(256) DEFAULT NULL COMMENT '求职意向',
`userId` int DEFAULT NULL COMMENT '用户ID',
`honour` varchar(256) DEFAULT NULL COMMENT '荣誉',
`selfAssessment` varchar(256) DEFAULT NULL COMMENT '自我评价',
`projectExperience` varchar(256) DEFAULT NULL COMMENT '项目经验',
`internshipExperience` varchar(256) DEFAULT NULL COMMENT '实习经验'
) ENGINE=InnoDB ROW_FORMAT=DYNAMIC COMMENT='简历表';
-- Data of table `resume` --
INSERT INTO `resume` (`resumeId`, `ability`, `workExperience`, `certificate`, `jobDesire`, `userId`, `honour`, `selfAssessment`, `projectExperience`, `internshipExperience`) VALUES
(1, 'JAVA，PYTHON，数据挖掘', '[{"time":["2019-3-1","2019-6-6"],"company":"广州得一公司","job":"运维岗","description":"负责产品的运维部署"}]', 'CET4，计算机二级', '项目助理', 17, '[{"time":"2021-4-5","reword":"学生会长","level":"校级"}]', '具有C,JAVA等语言基础，熟练使用python，熟练的Linux操作，部署LNMP架构的web服务能力，有一定开发能力。', '[{"time":["2021-4-5","2021-4-7"],"project":"目的：建立Galera集群实例，增加实践经验\n过程：yum源配置，带补丁mysql安装配置，iptables配置，集群搭建及测试等\n项目心得：通过实践增进对Galera数据库集群的了解，认识到数据库的高可用性。","job":"实验部署","description":"部署Galera集群，提供mysql数据服务及拓展性，保障数据的安全和可用性。"}]', '2019年春   广州得一公司'),
(2, NULL, NULL, NULL, NULL, 18, NULL, NULL, NULL, NULL),
(3, NULL, NULL, NULL, NULL, 19, NULL, NULL, NULL, NULL),
(4, NULL, NULL, NULL, NULL, 20, NULL, NULL, NULL, NULL),
(5, NULL, NULL, NULL, NULL, 21, NULL, NULL, NULL, NULL),
(6, NULL, NULL, NULL, NULL, 22, NULL, NULL, NULL, NULL),
(7, NULL, NULL, NULL, NULL, 23, NULL, NULL, NULL, NULL),
(8, NULL, NULL, NULL, NULL, 24, NULL, NULL, NULL, NULL),
(9, NULL, NULL, NULL, NULL, 25, NULL, NULL, NULL, NULL),
(10, NULL, NULL, NULL, NULL, 26, NULL, NULL, NULL, NULL),
(11, NULL, NULL, NULL, NULL, 27, NULL, NULL, NULL, NULL),
(12, NULL, NULL, NULL, NULL, 27, NULL, NULL, NULL, NULL),
(13, NULL, NULL, NULL, NULL, 27, NULL, NULL, NULL, NULL),
(14, NULL, NULL, NULL, NULL, 27, NULL, NULL, NULL, NULL),
(15, NULL, NULL, NULL, NULL, 27, NULL, NULL, NULL, NULL),
(16, NULL, NULL, NULL, NULL, 27, NULL, NULL, NULL, NULL),
(17, NULL, NULL, NULL, NULL, 33, NULL, NULL, NULL, NULL);

-- Table structure for table `user` --

DROP TABLE IF EXISTS `user`;
CREATE TABLE `user`  (
  `userId` int(0) NOT NULL AUTO_INCREMENT,
  `user` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `mobile` varchar(11) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `password` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `nickname` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `email` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `gender` int(0) DEFAULT NULL,
  `birthYear` int(0) DEFAULT NULL,
  `graduation` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `eduDegree` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `major` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `graduateYear` int(0) DEFAULT NULL,
  `dirDesire` float DEFAULT NULL,
  `province` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `city` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `avatar` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  PRIMARY KEY (`userId`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 29 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '用户表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES (17, 'admin', '01234567891', 'ISMvKXpXpadDiUoOSoAfww==', '张三', 'test@qq.com', 0, 1995, '中山大学', '本科', '程序员', 2019, 8000, '广东省', '广州', '17');
INSERT INTO `user` VALUES (19, 'wangwu', '12345678910', '4QrcOUm6Wau+VuBX8g+IPg==', '王五11', '1005202347@163.com', 1, 1998, '韶关学院', '本科', 'web前端工程师', 2019, 5000, '广东省', '梅州市', '19');
INSERT INTO `user` VALUES (24, 'xiaowu', '665116326', '4QrcOUm6Wau+VuBX8g+IPg==', '小吴', '136752446@163.com', 0, 1999, '广东财经大学', '本科', 'web前端工程师', 2017, 20000, '广东', '梅州', '24');
INSERT INTO `user` VALUES (27, '1119093673', '18051757735', '4QrcOUm6Wau+VuBX8g+IPg==', '施颂扬', '1119093673@qq.com', 0, 1999, '常熟理工学院', '本科', '程序员', 2021, 5000, '江苏', '苏州', '27');
INSERT INTO `user` VALUES (28, 'xs1', '12345678910', '4QrcOUm6Wau+VuBX8g+IPg==', '学生1', '1005202347@163.com', 0, 1999, '', '', '', 0, 8000, '四川', '攀枝花', '28');


-- ----------------------------
-- Table structure for sys_dict_type
-- ----------------------------
DROP TABLE IF EXISTS `sys_dict_type`;
CREATE TABLE `sys_dict_type`  (
  `dict_id` bigint(0) NOT NULL COMMENT '字典主键',
  `dict_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '字典名称',
  `dict_type` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '字典类型',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime(0) NOT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime(0) DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`dict_id`) USING BTREE,
  UNIQUE INDEX `dict_type`(`dict_type`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '字典类型表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_dict_type
-- ----------------------------
INSERT INTO `sys_dict_type` VALUES (126, '是/否', 'YesOrNo', '_system', '2023-02-16 18:48:43', '_system', '2023-02-16 18:48:43', NULL);
INSERT INTO `sys_dict_type` VALUES (128, '成功/失败', 'SuccessOrFail', '_system', '2023-02-16 18:50:04', '_system', '2023-02-16 18:50:04', NULL);
INSERT INTO `sys_dict_type` VALUES (133, '性别', 'Gender', '_system', '2023-02-17 14:28:06', '_system', '2023-02-17 14:28:06', NULL);
INSERT INTO `sys_dict_type` VALUES (134, '国际化语言标签', 'I18nDictType', '_system', '2023-02-17 14:28:06', '_system', '2023-02-17 14:28:06', NULL);
INSERT INTO `sys_dict_type` VALUES (135, '登录日志类型', 'LoginLogType', '_system', '2023-02-17 14:28:07', '_system', '2023-02-17 14:28:07', NULL);
INSERT INTO `sys_dict_type` VALUES (137, '通知状态', 'NoticeStatus', '_system', '2023-02-17 15:11:42', '_system', '2023-02-17 15:11:42', NULL);
INSERT INTO `sys_dict_type` VALUES (138, '通知类型', 'NoticeType', '_system', '2023-02-17 15:11:42', '_system', '2023-02-17 15:11:42', NULL);
INSERT INTO `sys_dict_type` VALUES (141, '后台用户状态', 'SysUserStatus', '_system', '2023-02-17 15:22:43', '_system', '2023-02-17 15:22:43', NULL);
INSERT INTO `sys_dict_type` VALUES (145, '密码重试策略', 'SecurityPasswordRetryStrategy', '_system', '2023-02-17 16:21:52', '_system', '2023-02-17 16:21:52', NULL);
INSERT INTO `sys_dict_type` VALUES (146, '密码校验规则', 'SecurityPasswordRule', '_system', '2023-02-17 16:21:53', '_system', '2023-02-17 16:21:53', NULL);
INSERT INTO `sys_dict_type` VALUES (147, '密码敏感信息', 'SecurityPasswordSensitive', '_system', '2023-02-17 16:21:53', '_system', '2023-02-17 16:21:53', NULL);
INSERT INTO `sys_dict_type` VALUES (152, '内容属性', 'CMSContentAttribute', '_system', '2023-02-19 00:11:56', '_system', '2023-02-19 00:11:56', NULL);
INSERT INTO `sys_dict_type` VALUES (153, '内容状态', 'CMSContentStatus', '_system', '2023-02-19 00:11:56', '_system', '2023-02-19 00:11:56', NULL);
INSERT INTO `sys_dict_type` VALUES (155, '静态文件类型', 'CMSStaticSuffix', '_system', '2023-02-19 00:11:56', '_system', '2023-02-19 00:11:56', NULL);
INSERT INTO `sys_dict_type` VALUES (156, '内容状态', 'CMSPageWidgetStatus', '_system', '2023-02-19 00:13:25', '_system', '2023-02-19 00:13:25', NULL);
INSERT INTO `sys_dict_type` VALUES (157, '元数据控件类型', 'MetaControlType', '_system', '2023-02-24 18:59:20', '_system', '2023-02-24 18:59:20', NULL);
INSERT INTO `sys_dict_type` VALUES (158, '元数据字段类型', 'MetaFieldType', '_system', '2023-02-24 18:59:20', '_system', '2023-02-24 18:59:20', NULL);
INSERT INTO `sys_dict_type` VALUES (159, '启用/禁用', 'EnableOrDisable', '_system', '2023-02-25 11:16:34', '_system', '2023-02-25 11:16:34', NULL);
INSERT INTO `sys_dict_type` VALUES (160, '自定义词库类型', 'SearchDictWordType', '__system', '2023-03-14 16:19:13', '__system', '2023-03-14 16:19:13', NULL);
INSERT INTO `sys_dict_type` VALUES (162, '会员用户状态', 'MemberStatus', '__system', '2023-03-21 16:17:30', '__system', '2023-03-21 16:24:07', NULL);
INSERT INTO `sys_dict_type` VALUES (163, '评论状态', 'CommentAuditStatus', '__system', '2023-03-25 21:49:27', '__system', '2023-03-25 21:49:27', NULL);
INSERT INTO `sys_dict_type` VALUES (165, '调查投票状态', 'VoteStatus', '__system', '2023-03-27 17:01:35', '__system', '2023-03-27 17:01:35', NULL);
INSERT INTO `sys_dict_type` VALUES (166, '调查投票主题类型', 'VoteSubjectType', '__system', '2023-03-27 17:01:35', '__system', '2023-03-27 17:01:35', NULL);
INSERT INTO `sys_dict_type` VALUES (167, '调查投票状态', 'VoteViewType', '__system', '2023-03-27 18:05:52', '__system', '2023-03-27 18:05:52', NULL);
INSERT INTO `sys_dict_type` VALUES (168, '自定义表单状态', 'CustomFormStatus', '__system', '2023-06-11 10:26:02', '__system', '2023-06-11 10:26:02', NULL);
INSERT INTO `sys_dict_type` VALUES (169, '扩展模型数据类型', 'ExtendModelDataType', '__system', '2023-06-15 11:52:51', '__system', '2023-06-15 11:52:51', NULL);
INSERT INTO `sys_dict_type` VALUES (170, 'DICT.CustomFormRule', 'CustomFormRule', '__system', '2023-06-15 20:47:34', '__system', '2023-06-15 20:47:34', NULL);
INSERT INTO `sys_dict_type` VALUES (654933657669701, '内容操作类型', 'CMSContentOpType', '__system', '2025-03-15 17:51:55', '__system', '2025-03-15 17:51:55', NULL);
INSERT INTO `sys_dict_type` VALUES (654933659521093, '索引分词方式', 'WordAnalyzeType', '__system', '2025-03-15 17:51:55', '__system', '2025-03-15 17:51:55', NULL);
INSERT INTO `sys_dict_type` VALUES (654933660151877, '发布通道页面类型', 'CMSSitemapPageType', '__system', '2025-03-15 17:51:55', '__system', '2025-03-15 17:51:55', NULL);
INSERT INTO `sys_dict_type` VALUES (656591192358981, '招聘岗位分类', 'position_category', 'admin', '2025-03-20 10:16:26', '', '2025-03-20 10:18:08', '招聘岗位分类');
INSERT INTO `sys_dict_type` VALUES (656594184523845, '薪资类型', 'salary_type', 'admin', '2025-03-20 10:28:37', '', NULL, NULL);
INSERT INTO `sys_dict_type` VALUES (656594336399429, '投诉处理状态', 'feedback_status', 'admin', '2025-03-20 10:29:14', '', NULL, NULL);
INSERT INTO `sys_dict_type` VALUES (656594411237445, '是否已读', 'read_flag', 'admin', '2025-03-20 10:29:32', '', NULL, NULL);
INSERT INTO `sys_dict_type` VALUES (656596412624965, '岗位申请状态', 'apply_status', 'admin', '2025-03-20 10:37:41', '', NULL, NULL);
INSERT INTO `sys_dict_type` VALUES (656596838924357, '招聘状态', 'recruitment_status', 'admin', '2025-03-20 10:39:25', '', NULL, NULL);


DROP TABLE IF EXISTS `sys_dict_data`;
CREATE TABLE `sys_dict_data`  (
  `dict_code` bigint(0) NOT NULL COMMENT '字典编码',
  `dict_sort` int(0) NOT NULL DEFAULT 0 COMMENT '字典排序',
  `dict_label` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '字典标签',
  `dict_value` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '字典键值',
  `dict_type` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '字典类型',
  `css_class` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '样式属性（其他样式扩展）',
  `list_class` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '表格回显样式',
  `is_default` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime(0) DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime(0) DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`dict_code`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '字典数据表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_dict_data
-- ----------------------------
INSERT INTO `sys_dict_data` VALUES (195, 1, '成功', '0', 'SuccessOrFail', NULL, NULL, 'N', '_system', '2023-02-16 19:13:14', '_system', '2023-02-16 19:13:14', NULL);
INSERT INTO `sys_dict_data` VALUES (196, 2, '失败', '1', 'SuccessOrFail', NULL, NULL, 'N', '_system', '2023-02-16 19:13:15', '_system', '2023-02-16 19:13:15', NULL);
INSERT INTO `sys_dict_data` VALUES (197, 1, '是', 'Y', 'YesOrNo', NULL, 'success', 'N', '_system', '2023-02-16 19:13:15', '_system', '2023-02-17 15:17:01', NULL);
INSERT INTO `sys_dict_data` VALUES (198, 2, '否', 'N', 'YesOrNo', NULL, 'warning', 'N', '_system', '2023-02-16 19:13:15', '_system', '2023-02-17 15:17:09', NULL);
INSERT INTO `sys_dict_data` VALUES (207, 1, '男', '0', 'Gender', NULL, NULL, 'N', '_system', '2023-02-17 14:28:06', '_system', '2023-02-17 14:28:06', NULL);
INSERT INTO `sys_dict_data` VALUES (208, 2, '女', '1', 'Gender', NULL, NULL, 'N', '_system', '2023-02-17 14:28:06', '_system', '2023-02-17 14:28:06', NULL);
INSERT INTO `sys_dict_data` VALUES (209, 3, '位置', '2', 'Gender', NULL, NULL, 'N', '_system', '2023-02-17 14:28:06', '_system', '2023-02-17 14:28:06', NULL);
INSERT INTO `sys_dict_data` VALUES (210, 1, '简体中文', 'zh-CN', 'I18nDictType', NULL, NULL, 'N', '_system', '2023-02-17 14:28:07', '_system', '2023-02-17 14:28:07', NULL);
INSERT INTO `sys_dict_data` VALUES (211, 2, '英文', 'en', 'I18nDictType', NULL, NULL, 'N', '_system', '2023-02-17 14:28:07', '_system', '2023-02-17 14:28:07', NULL);
INSERT INTO `sys_dict_data` VALUES (212, 1, '登录', '0', 'LoginLogType', NULL, NULL, 'N', '_system', '2023-02-17 14:28:07', '_system', '2023-02-17 14:28:07', NULL);
INSERT INTO `sys_dict_data` VALUES (213, 2, '登出', '1', 'LoginLogType', NULL, NULL, 'N', '_system', '2023-02-17 14:28:07', '_system', '2023-02-17 14:28:07', NULL);
INSERT INTO `sys_dict_data` VALUES (214, 3, '注册', '2', 'LoginLogType', NULL, NULL, 'N', '_system', '2023-02-17 14:28:07', '_system', '2023-02-17 14:28:07', NULL);
INSERT INTO `sys_dict_data` VALUES (216, 1, '正常', '0', 'NoticeStatus', NULL, NULL, 'N', '_system', '2023-02-17 15:11:42', '_system', '2023-02-17 15:11:42', NULL);
INSERT INTO `sys_dict_data` VALUES (217, 2, '关闭', '1', 'NoticeStatus', NULL, NULL, 'N', '_system', '2023-02-17 15:11:42', '_system', '2023-02-17 15:11:42', NULL);
INSERT INTO `sys_dict_data` VALUES (218, 1, '通知', '1', 'NoticeType', NULL, NULL, 'N', '_system', '2023-02-17 15:11:42', '_system', '2023-02-17 15:11:42', NULL);
INSERT INTO `sys_dict_data` VALUES (223, 1, '正常', '0', 'SysUserStatus', NULL, 'success', 'N', '_system', '2023-02-17 15:22:43', '_system', '2023-02-17 15:23:13', NULL);
INSERT INTO `sys_dict_data` VALUES (224, 2, '封禁', '1', 'SysUserStatus', NULL, 'danger', 'N', '_system', '2023-02-17 15:22:43', '_system', '2023-02-17 15:23:20', NULL);
INSERT INTO `sys_dict_data` VALUES (225, 3, '锁定', '2', 'SysUserStatus', NULL, 'warning', 'N', '_system', '2023-02-17 15:22:43', '_system', '2023-02-17 15:23:23', NULL);
INSERT INTO `sys_dict_data` VALUES (240, 1, '不处理', 'NONE', 'SecurityPasswordRetryStrategy', NULL, NULL, 'N', '_system', '2023-02-17 16:21:52', '_system', '2023-02-17 16:21:52', NULL);
INSERT INTO `sys_dict_data` VALUES (241, 2, '封禁账号', 'DISABLE', 'SecurityPasswordRetryStrategy', NULL, NULL, 'N', '_system', '2023-02-17 16:21:52', '_system', '2023-02-17 16:21:52', NULL);
INSERT INTO `sys_dict_data` VALUES (242, 3, '锁定账号，拒绝登录一段时间', 'LOCK', 'SecurityPasswordRetryStrategy', NULL, NULL, 'N', '_system', '2023-02-17 16:21:52', '_system', '2023-02-17 16:21:52', NULL);
INSERT INTO `sys_dict_data` VALUES (243, 1, '不校验', 'NONE', 'SecurityPasswordRule', NULL, NULL, 'N', '_system', '2023-02-17 16:21:53', '_system', '2023-02-17 16:21:53', '');
INSERT INTO `sys_dict_data` VALUES (244, 2, '必须包含字母、数字', 'LETTER_NUMBER', 'SecurityPasswordRule', NULL, NULL, 'N', '_system', '2023-02-17 16:21:53', '_system', '2023-02-17 16:21:53', '^(?=.*\\d+)(?=.*[A-Za-z]+)[A-Za-z\\d!@#$%^&*?()\\[\\]{}<>:;,.\'\"~·+=_-]+$');
INSERT INTO `sys_dict_data` VALUES (245, 3, '必须包含大小写字母、数字', 'UPPER_LOW_LETTER_NUMBER', 'SecurityPasswordRule', NULL, NULL, 'N', '_system', '2023-02-17 16:21:53', '_system', '2023-02-17 16:21:53', '^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)[A-Za-z\\d!@#$%^&*?()\\[\\]{}<>:;,.\'\"~·+=_-]+$');
INSERT INTO `sys_dict_data` VALUES (246, 4, '必须包含字母、数字、特殊字符', 'LETTER_NUMBER_SPECIAL', 'SecurityPasswordRule', NULL, NULL, 'N', '_system', '2023-02-17 16:21:53', '_system', '2023-02-17 16:21:53', '^(?=.*[A-Za-z])(?=.*\\d)(?=.*[!@#$%^&*?()\\[\\]{}<>:;,.\'\"~·+=_-])[A-Za-z\\d!@#$%^&*?()\\[\\]{}<>:;,.\'\"~·+=_-]+$');
INSERT INTO `sys_dict_data` VALUES (247, 5, '必须包含大小写字母、数字、特殊字符', 'UPPER_LOW_LETTER_NUMBER_SPECIAL', 'SecurityPasswordRule', NULL, NULL, 'N', '_system', '2023-02-17 16:21:53', '_system', '2023-02-17 16:21:53', '^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[!@#$%^&*?()\\[\\]{}<>:;,.\'\"~·+=_-])[A-Za-z\\d!@#$%^&*?()\\[\\]{}<>:;,.\'\"~·+=_-]+$');
INSERT INTO `sys_dict_data` VALUES (248, 1, '用户名', 'ACCOUNT', 'SecurityPasswordSensitive', NULL, NULL, 'N', '_system', '2023-02-17 16:21:53', '_system', '2023-02-17 16:21:53', NULL);
INSERT INTO `sys_dict_data` VALUES (249, 2, '手机号', 'PHONE_NUMBER', 'SecurityPasswordSensitive', NULL, NULL, 'N', '_system', '2023-02-17 16:21:53', '_system', '2023-02-17 16:21:53', NULL);
INSERT INTO `sys_dict_data` VALUES (250, 3, 'Email', 'EMAIL', 'SecurityPasswordSensitive', NULL, NULL, 'N', '_system', '2023-02-17 16:21:53', '_system', '2023-02-17 16:21:53', NULL);
INSERT INTO `sys_dict_data` VALUES (251, 4, '昵称全拼', 'NICK_NAME', 'SecurityPasswordSensitive', NULL, NULL, 'N', '_system', '2023-02-17 16:21:53', '_system', '2023-02-17 16:21:53', NULL);
INSERT INTO `sys_dict_data` VALUES (252, 5, '真实姓名全拼', 'REAL_NAME', 'SecurityPasswordSensitive', NULL, NULL, 'N', '_system', '2023-02-17 16:21:53', '_system', '2023-02-17 16:21:53', NULL);
INSERT INTO `sys_dict_data` VALUES (253, 6, '生日（yyyyMMdd）', 'BIRTHDAY', 'SecurityPasswordSensitive', NULL, NULL, 'N', '_system', '2023-02-17 16:21:53', '_system', '2023-02-17 16:21:53', NULL);
INSERT INTO `sys_dict_data` VALUES (294, 1, '图片', 'image', 'CMSContentAttribute', NULL, NULL, 'N', '_system', '2023-02-19 00:20:24', '_system', '2023-02-19 00:20:24', '1');
INSERT INTO `sys_dict_data` VALUES (295, 2, '视频', 'video', 'CMSContentAttribute', NULL, NULL, 'N', '_system', '2023-02-19 00:20:25', '_system', '2023-02-19 00:20:25', '2');
INSERT INTO `sys_dict_data` VALUES (296, 3, '附件', 'attach', 'CMSContentAttribute', NULL, NULL, 'N', '_system', '2023-02-19 00:20:25', '_system', '2023-02-19 00:20:25', '4');
INSERT INTO `sys_dict_data` VALUES (297, 4, '热点', 'hot', 'CMSContentAttribute', NULL, NULL, 'N', '_system', '2023-02-19 00:20:25', '_system', '2023-02-19 00:20:25', '8');
INSERT INTO `sys_dict_data` VALUES (298, 5, '推荐', 'recommend', 'CMSContentAttribute', NULL, NULL, 'N', '_system', '2023-02-19 00:20:25', '_system', '2023-02-19 00:20:25', '16');
INSERT INTO `sys_dict_data` VALUES (299, 1, '初稿', '0', 'CMSContentStatus', NULL, NULL, 'N', '_system', '2023-02-19 00:20:25', '_system', '2023-02-19 00:20:25', NULL);
INSERT INTO `sys_dict_data` VALUES (300, 2, '待发布', '20', 'CMSContentStatus', NULL, NULL, 'N', '_system', '2023-02-19 00:20:25', '_system', '2023-02-19 00:20:25', NULL);
INSERT INTO `sys_dict_data` VALUES (301, 3, '已发布', '30', 'CMSContentStatus', NULL, NULL, 'N', '_system', '2023-02-19 00:20:25', '_system', '2023-02-19 00:20:25', NULL);
INSERT INTO `sys_dict_data` VALUES (302, 4, '已下线', '40', 'CMSContentStatus', NULL, NULL, 'N', '_system', '2023-02-19 00:20:25', '_system', '2023-02-19 00:20:25', NULL);
INSERT INTO `sys_dict_data` VALUES (303, 5, '重新编辑', '60', 'CMSContentStatus', NULL, NULL, 'N', '_system', '2023-02-19 00:20:25', '_system', '2023-02-19 00:20:25', NULL);
INSERT INTO `sys_dict_data` VALUES (304, 1, '初稿', '0', 'CMSPageWidgetStatus', NULL, NULL, 'N', '_system', '2023-02-19 00:20:25', '_system', '2023-02-19 00:20:25', NULL);
INSERT INTO `sys_dict_data` VALUES (305, 2, '已发布', '30', 'CMSPageWidgetStatus', NULL, NULL, 'N', '_system', '2023-02-19 00:20:25', '_system', '2023-02-19 00:20:25', NULL);
INSERT INTO `sys_dict_data` VALUES (306, 3, '已下线', '40', 'CMSPageWidgetStatus', NULL, NULL, 'N', '_system', '2023-02-19 00:20:25', '_system', '2023-02-19 00:20:25', NULL);
INSERT INTO `sys_dict_data` VALUES (307, 4, '重新编辑', '60', 'CMSPageWidgetStatus', NULL, NULL, 'N', '_system', '2023-02-19 00:20:25', '_system', '2023-02-19 00:20:25', NULL);
INSERT INTO `sys_dict_data` VALUES (308, 1, 'shtml', 'shtml', 'CMSStaticSuffix', NULL, NULL, 'N', '_system', '2023-02-19 00:20:25', '_system', '2023-02-19 00:20:25', NULL);
INSERT INTO `sys_dict_data` VALUES (309, 2, 'html', 'html', 'CMSStaticSuffix', NULL, NULL, 'N', '_system', '2023-02-19 00:20:25', '_system', '2023-02-19 00:20:25', NULL);
INSERT INTO `sys_dict_data` VALUES (310, 3, 'xml', 'xml', 'CMSStaticSuffix', NULL, NULL, 'N', '_system', '2023-02-19 00:20:25', '_system', '2023-02-19 00:20:25', NULL);
INSERT INTO `sys_dict_data` VALUES (311, 4, 'json', 'json', 'CMSStaticSuffix', NULL, NULL, 'N', '_system', '2023-02-19 00:20:25', '_system', '2023-02-19 00:20:25', NULL);
INSERT INTO `sys_dict_data` VALUES (312, 1, '单行输入框', 'input', 'MetaControlType', NULL, NULL, 'N', '_system', '2023-02-24 18:59:20', '_system', '2023-02-24 18:59:20', NULL);
INSERT INTO `sys_dict_data` VALUES (313, 2, '多行输入框', 'textarea', 'MetaControlType', NULL, NULL, 'N', '_system', '2023-02-24 18:59:20', '_system', '2023-02-24 18:59:20', NULL);
INSERT INTO `sys_dict_data` VALUES (314, 3, '单选框', 'radio', 'MetaControlType', NULL, NULL, 'N', '_system', '2023-02-24 18:59:20', '_system', '2023-02-24 18:59:20', NULL);
INSERT INTO `sys_dict_data` VALUES (315, 4, '多选框', 'checkbox', 'MetaControlType', NULL, NULL, 'N', '_system', '2023-02-24 18:59:20', '_system', '2023-02-24 18:59:20', NULL);
INSERT INTO `sys_dict_data` VALUES (316, 5, '下拉框', 'select', 'MetaControlType', NULL, NULL, 'N', '_system', '2023-02-24 18:59:20', '_system', '2023-02-24 18:59:20', NULL);
INSERT INTO `sys_dict_data` VALUES (317, 6, '日期选择框', 'date', 'MetaControlType', NULL, NULL, 'N', '_system', '2023-02-24 18:59:20', '_system', '2023-02-24 18:59:20', NULL);
INSERT INTO `sys_dict_data` VALUES (318, 7, '时间选择框', 'datetime', 'MetaControlType', NULL, NULL, 'N', '_system', '2023-02-24 18:59:20', '_system', '2023-02-24 18:59:20', NULL);
INSERT INTO `sys_dict_data` VALUES (319, 1, 'VARCHAR(50)', 'short_text', 'MetaFieldType', NULL, NULL, 'N', '_system', '2023-02-24 18:59:20', '_system', '2023-02-24 18:59:20', '25');
INSERT INTO `sys_dict_data` VALUES (320, 2, 'VARCHAR(200)', 'medium_text', 'MetaFieldType', NULL, NULL, 'N', '_system', '2023-02-24 18:59:20', '_system', '2023-02-24 18:59:20', '25');
INSERT INTO `sys_dict_data` VALUES (321, 3, 'VARCHAR(2000)', 'large_text', 'MetaFieldType', NULL, NULL, 'N', '_system', '2023-02-24 18:59:20', '_system', '2023-02-24 18:59:20', '4');
INSERT INTO `sys_dict_data` VALUES (322, 4, 'MEDIUMTEXT', 'clob_text', 'MetaFieldType', NULL, NULL, 'N', '_system', '2023-02-24 18:59:20', '_system', '2023-04-16 18:27:24', '1');
INSERT INTO `sys_dict_data` VALUES (323, 5, 'LONG', 'long', 'MetaFieldType', NULL, NULL, 'N', '_system', '2023-02-24 18:59:20', '_system', '2023-04-16 18:27:31', '10');
INSERT INTO `sys_dict_data` VALUES (324, 6, 'DOUBLE', 'double', 'MetaFieldType', NULL, NULL, 'N', '_system', '2023-02-24 18:59:20', '_system', '2023-04-16 18:27:38', '10');
INSERT INTO `sys_dict_data` VALUES (325, 7, 'DATETIME', 'datetime', 'MetaFieldType', NULL, NULL, 'N', '_system', '2023-02-24 18:59:20', '_system', '2023-04-16 18:27:44', '10');
INSERT INTO `sys_dict_data` VALUES (326, 1, '启用', '0', 'EnableOrDisable', NULL, 'success', 'N', '_system', '2023-02-25 11:16:34', '_system', '2023-05-07 15:57:02', NULL);
INSERT INTO `sys_dict_data` VALUES (327, 2, '禁用', '1', 'EnableOrDisable', NULL, 'warning', 'N', '_system', '2023-02-25 11:16:34', '_system', '2023-05-07 15:57:10', NULL);
INSERT INTO `sys_dict_data` VALUES (328, 1, '扩展词', 'WORD', 'SearchDictWordType', NULL, 'success', 'N', '__system', '2023-03-14 16:19:13', '__system', '2023-03-14 16:29:29', NULL);
INSERT INTO `sys_dict_data` VALUES (329, 2, '停止词', 'STOP', 'SearchDictWordType', NULL, 'warning', 'N', '__system', '2023-03-14 16:19:13', '__system', '2023-03-14 16:29:39', NULL);
INSERT INTO `sys_dict_data` VALUES (332, 1, 'DICT.MemberStatus.0', '0', 'MemberStatus', NULL, 'success', 'N', '__system', '2023-03-21 16:17:30', '__system', '2023-03-21 16:24:15', NULL);
INSERT INTO `sys_dict_data` VALUES (333, 2, 'DICT.MemberStatus.1', '1', 'MemberStatus', NULL, 'danger', 'N', '__system', '2023-03-21 16:17:30', '__system', '2023-03-21 16:24:20', NULL);
INSERT INTO `sys_dict_data` VALUES (334, 3, 'DICT.MemberStatus.2', '2', 'MemberStatus', NULL, 'warning', 'N', '__system', '2023-03-21 16:17:30', '__system', '2023-03-21 16:24:24', NULL);
INSERT INTO `sys_dict_data` VALUES (335, 1, '待审核', '0', 'CommentAuditStatus', NULL, 'primary', 'N', '__system', '2023-03-25 21:49:27', '__system', '2023-03-25 23:22:02', NULL);
INSERT INTO `sys_dict_data` VALUES (336, 2, '审核通过', '1', 'CommentAuditStatus', NULL, 'success', 'N', '__system', '2023-03-25 21:49:27', '__system', '2023-03-25 23:22:06', NULL);
INSERT INTO `sys_dict_data` VALUES (337, 3, '审核未通过', '2', 'CommentAuditStatus', NULL, 'warning', 'N', '__system', '2023-03-25 21:49:27', '__system', '2023-03-25 23:22:10', NULL);
INSERT INTO `sys_dict_data` VALUES (341, 1, '正常', '0', 'VoteStatus', NULL, NULL, 'N', '__system', '2023-03-27 17:01:35', '__system', '2023-03-27 17:01:35', NULL);
INSERT INTO `sys_dict_data` VALUES (342, 2, '停用', '1', 'VoteStatus', NULL, NULL, 'N', '__system', '2023-03-27 17:01:35', '__system', '2023-03-27 17:01:35', NULL);
INSERT INTO `sys_dict_data` VALUES (343, 3, '关闭', '2', 'VoteStatus', NULL, NULL, 'N', '__system', '2023-03-27 17:01:35', '__system', '2023-03-27 17:01:35', NULL);
INSERT INTO `sys_dict_data` VALUES (347, 1, '不可查看', '0', 'VoteViewType', NULL, NULL, 'N', '__system', '2023-03-27 18:05:52', '__system', '2023-03-27 18:05:52', NULL);
INSERT INTO `sys_dict_data` VALUES (348, 2, '投票后可看', '1', 'VoteViewType', NULL, NULL, 'N', '__system', '2023-03-27 18:05:52', '__system', '2023-03-27 18:05:52', NULL);
INSERT INTO `sys_dict_data` VALUES (349, 3, '不限制', '2', 'VoteViewType', NULL, NULL, 'N', '__system', '2023-03-27 18:05:52', '__system', '2023-03-27 18:05:52', NULL);
INSERT INTO `sys_dict_data` VALUES (350, 1, '单选', 'radio', 'VoteSubjectType', NULL, NULL, 'N', '__system', '2023-03-27 18:29:11', '__system', '2023-03-27 18:29:11', NULL);
INSERT INTO `sys_dict_data` VALUES (351, 2, '多选', 'checkbox', 'VoteSubjectType', NULL, NULL, 'N', '__system', '2023-03-27 18:29:11', '__system', '2023-03-27 18:29:11', NULL);
INSERT INTO `sys_dict_data` VALUES (352, 3, '输入', 'input', 'VoteSubjectType', NULL, NULL, 'N', '__system', '2023-03-27 18:29:11', '__system', '2023-03-27 18:29:11', NULL);
INSERT INTO `sys_dict_data` VALUES (353, 1, '草稿', '0', 'CustomFormStatus', NULL, NULL, 'N', '__system', '2023-06-11 10:26:02', '__system', '2023-06-11 10:26:02', NULL);
INSERT INTO `sys_dict_data` VALUES (354, 2, '已发布', '10', 'CustomFormStatus', NULL, 'success', 'N', '__system', '2023-06-11 10:26:02', '__system', '2023-06-11 10:35:54', NULL);
INSERT INTO `sys_dict_data` VALUES (355, 3, '已下线', '20', 'CustomFormStatus', NULL, 'warning', 'N', '__system', '2023-06-11 10:26:02', '__system', '2023-06-11 10:35:58', NULL);
INSERT INTO `sys_dict_data` VALUES (356, 1, '站点', 'site', 'ExtendModelDataType', NULL, NULL, 'N', '__system', '2023-06-15 11:52:51', '__system', '2023-06-15 11:52:51', NULL);
INSERT INTO `sys_dict_data` VALUES (357, 2, '栏目', 'catalog', 'ExtendModelDataType', NULL, NULL, 'N', '__system', '2023-06-15 11:52:51', '__system', '2023-06-15 11:52:51', NULL);
INSERT INTO `sys_dict_data` VALUES (358, 3, '内容', 'content', 'ExtendModelDataType', NULL, NULL, 'N', '__system', '2023-06-15 11:52:51', '__system', '2023-06-15 11:52:51', NULL);
INSERT INTO `sys_dict_data` VALUES (359, 1, 'DICT.CustomFormRule.0', '0', 'CustomFormRule', NULL, NULL, 'N', '__system', '2023-06-15 20:47:34', '__system', '2023-06-15 20:47:34', NULL);
INSERT INTO `sys_dict_data` VALUES (360, 2, 'DICT.CustomFormRule.1', '1', 'CustomFormRule', NULL, NULL, 'N', '__system', '2023-06-15 20:47:35', '__system', '2023-06-15 20:47:35', NULL);
INSERT INTO `sys_dict_data` VALUES (361, 3, 'DICT.CustomFormRule.2', '2', 'CustomFormRule', NULL, NULL, 'N', '__system', '2023-06-15 20:47:35', '__system', '2023-06-15 20:47:35', NULL);
INSERT INTO `sys_dict_data` VALUES (654933657223237, 3, '繁體中文', 'zh-TW', 'I18nDictType', NULL, NULL, NULL, '__system', '2025-03-15 17:51:54', '__system', '2025-03-15 17:51:54', NULL);
INSERT INTO `sys_dict_data` VALUES (654933657804869, 1, '新建', 'ADD', 'CMSContentOpType', NULL, NULL, NULL, '__system', '2025-03-15 17:51:55', '__system', '2025-03-15 17:51:55', NULL);
INSERT INTO `sys_dict_data` VALUES (654933657944133, 1, '修改', 'UPDATE', 'CMSContentOpType', NULL, NULL, NULL, '__system', '2025-03-15 17:51:55', '__system', '2025-03-15 17:51:55', NULL);
INSERT INTO `sys_dict_data` VALUES (654933658075205, 1, '删除', 'DELETE', 'CMSContentOpType', NULL, NULL, NULL, '__system', '2025-03-15 17:51:55', '__system', '2025-03-15 17:51:55', NULL);
INSERT INTO `sys_dict_data` VALUES (654933658214469, 1, '锁定', 'LOCK', 'CMSContentOpType', NULL, NULL, NULL, '__system', '2025-03-15 17:51:55', '__system', '2025-03-15 17:51:55', NULL);
INSERT INTO `sys_dict_data` VALUES (654933658349637, 1, '解锁', 'UNLOCK', 'CMSContentOpType', NULL, NULL, NULL, '__system', '2025-03-15 17:51:55', '__system', '2025-03-15 17:51:55', NULL);
INSERT INTO `sys_dict_data` VALUES (654933658484805, 1, '待发布', 'TO_PUBLISH', 'CMSContentOpType', NULL, NULL, NULL, '__system', '2025-03-15 17:51:55', '__system', '2025-03-15 17:51:55', NULL);
INSERT INTO `sys_dict_data` VALUES (654933658619973, 1, '发布', 'PUBLISH', 'CMSContentOpType', NULL, NULL, NULL, '__system', '2025-03-15 17:51:55', '__system', '2025-03-15 17:51:55', NULL);
INSERT INTO `sys_dict_data` VALUES (654933658746949, 1, '下线', 'OFFLINE', 'CMSContentOpType', NULL, NULL, NULL, '__system', '2025-03-15 17:51:55', '__system', '2025-03-15 17:51:55', NULL);
INSERT INTO `sys_dict_data` VALUES (654933658873925, 1, '排序', 'SORT', 'CMSContentOpType', NULL, NULL, NULL, '__system', '2025-03-15 17:51:55', '__system', '2025-03-15 17:51:55', NULL);
INSERT INTO `sys_dict_data` VALUES (654933659009093, 1, '置顶', 'TOP', 'CMSContentOpType', NULL, NULL, NULL, '__system', '2025-03-15 17:51:55', '__system', '2025-03-15 17:51:55', NULL);
INSERT INTO `sys_dict_data` VALUES (654933659148357, 1, '取消置顶', 'CANCEL_TOP', 'CMSContentOpType', NULL, NULL, NULL, '__system', '2025-03-15 17:51:55', '__system', '2025-03-15 17:51:55', NULL);
INSERT INTO `sys_dict_data` VALUES (654933659660357, 1, '最少切分', 'ik_smart', 'WordAnalyzeType', NULL, NULL, NULL, '__system', '2025-03-15 17:51:55', '__system', '2025-03-15 17:51:55', NULL);
INSERT INTO `sys_dict_data` VALUES (654933659807813, 2, '最细粒度划分', 'ik_max_word', 'WordAnalyzeType', NULL, NULL, NULL, '__system', '2025-03-15 17:51:55', '__system', '2025-03-15 17:51:55', NULL);
INSERT INTO `sys_dict_data` VALUES (654933660282949, 1, 'PC端', 'pc', 'CMSSitemapPageType', NULL, NULL, NULL, '__system', '2025-03-15 17:51:55', '__system', '2025-03-15 17:51:55', NULL);
INSERT INTO `sys_dict_data` VALUES (654933660414021, 2, '移动端', 'mobile', 'CMSSitemapPageType', NULL, NULL, NULL, '__system', '2025-03-15 17:51:55', '__system', '2025-03-15 17:51:55', NULL);
INSERT INTO `sys_dict_data` VALUES (654933660545093, 3, '自适应', 'pc,mobile', 'CMSSitemapPageType', NULL, NULL, NULL, '__system', '2025-03-15 17:51:55', '__system', '2025-03-15 17:51:55', NULL);
INSERT INTO `sys_dict_data` VALUES (656592259444805, 0, 'Java岗', 'java', 'position_category', NULL, 'success', NULL, 'admin', '2025-03-20 10:20:47', '', '2025-03-20 10:23:07', NULL);
INSERT INTO `sys_dict_data` VALUES (656592376406085, 1, 'python岗', 'python', 'position_category', NULL, 'success', NULL, 'admin', '2025-03-20 10:21:15', '', '2025-03-20 10:23:36', NULL);
INSERT INTO `sys_dict_data` VALUES (656592442617925, 2, '服务岗', 'fw', 'position_category', NULL, 'primary', NULL, 'admin', '2025-03-20 10:21:31', '', '2025-03-20 10:23:30', NULL);
INSERT INTO `sys_dict_data` VALUES (656592712237125, 4, '保安岗', 'baoan', 'position_category', NULL, 'primary', NULL, 'admin', '2025-03-20 10:22:37', '', '2025-03-20 10:24:02', NULL);
INSERT INTO `sys_dict_data` VALUES (656594590601285, 0, '否', '0', 'read_flag', NULL, 'default', NULL, 'admin', '2025-03-20 10:30:16', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (656594615877701, 0, '是', '1', 'read_flag', NULL, 'default', NULL, 'admin', '2025-03-20 10:30:22', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (656595372617797, 0, '时薪', 'Hourly', 'salary_type', NULL, 'primary', NULL, 'admin', '2025-03-20 10:33:27', '', '2025-03-20 10:34:34', NULL);
INSERT INTO `sys_dict_data` VALUES (656595470573637, 2, '日薪', 'Daily', 'salary_type', NULL, 'primary', NULL, 'admin', '2025-03-20 10:33:51', '', '2025-03-20 10:34:26', NULL);
INSERT INTO `sys_dict_data` VALUES (656595562623045, 0, '月薪', 'monthly', 'salary_type', NULL, 'primary', NULL, 'admin', '2025-03-20 10:34:13', '', '2025-03-20 10:34:30', NULL);
INSERT INTO `sys_dict_data` VALUES (656596076597317, 0, '待处理', '0', 'feedback_status', NULL, 'danger', NULL, 'admin', '2025-03-20 10:36:19', '', '2025-03-20 10:36:25', NULL);
INSERT INTO `sys_dict_data` VALUES (656596158099525, 1, '已处理', '1', 'feedback_status', NULL, 'success', NULL, 'admin', '2025-03-20 10:36:38', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (656596575301701, 0, '待审核', '0', 'apply_status', NULL, 'primary', NULL, 'admin', '2025-03-20 10:38:20', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (656596642881605, 0, '已通过', '1', 'apply_status', NULL, 'success', NULL, 'admin', '2025-03-20 10:38:37', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (656596689559621, 0, '已拒绝', '2', 'apply_status', NULL, 'danger', NULL, 'admin', '2025-03-20 10:38:48', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (656596933062725, 0, '开放', '0', 'recruitment_status', NULL, 'primary', NULL, 'admin', '2025-03-20 10:39:48', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (656596985471045, 0, '招满', '1', 'recruitment_status', NULL, 'info', NULL, 'admin', '2025-03-20 10:40:00', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (656597043478597, 0, '延期', '2', 'recruitment_status', NULL, 'warning', NULL, 'admin', '2025-03-20 10:40:15', '', NULL, NULL);

DROP TABLE IF EXISTS `messages`;
CREATE TABLE `messages`  (
  `id` bigint(0) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `sender_id` bigint(0) NOT NULL COMMENT '发送者ID',
  `receiver_id` bigint(0) NOT NULL COMMENT '接收者ID',
  `content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '消息内容',
  `read_flag` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT '0' COMMENT '是否已读',
  `created_by` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '创建人',
  `modified_by` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '修改人',
  `created_at` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `modified_at` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '修改时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `sender_id`(`sender_id`) USING BTREE,
  INDEX `receiver_id`(`receiver_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '在线交流表' ROW_FORMAT = Dynamic;



DROP TABLE IF EXISTS `work_salaries`;
CREATE TABLE `work_salaries`  (
  `id` bigint(0) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `student_id` bigint(0) NOT NULL COMMENT '关联学生',
  `position_id` bigint(0) NOT NULL COMMENT '关联岗位',
  `enter_id` bigint(0) NOT NULL COMMENT '关联企业',
  `work_status` varchar(2) DEFAULT NULL COMMENT '在岗状态 0、离职；1、在岗',
  `start_date` date NOT NULL COMMENT '上岗日期',
  `end_date` date DEFAULT NULL COMMENT '离岗日期',
  `work_hours` decimal(10, 2) NOT NULL COMMENT '工作时长',
  `salary_type` varchar(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT '0' COMMENT '薪资类型，0按小时,1按天,2按月',
  `salary` decimal(10, 2) NOT NULL COMMENT '薪资',
  `salary_sum` decimal(10, 2) NOT NULL COMMENT '薪资总额',
  `created_by` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '创建人',
  `modified_by` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '修改人',
  `created_at` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `modified_at` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '修改时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '工时薪资表' ROW_FORMAT = Dynamic;

