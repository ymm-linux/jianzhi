/*
 Navicat Premium Data Transfer

 Source Server         : 8.133.244.26-mysql8
 Source Server Type    : MySQL
 Source Server Version : 80041
 Source Host           : 8.133.244.26:17777
 Source Schema         : chestnut_cms

 Target Server Type    : MySQL
 Target Server Version : 80041
 File Encoding         : 65001

 Date: 30/03/2025 11:53:22
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for sys_dict_data
-- ----------------------------
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

SET FOREIGN_KEY_CHECKS = 1;
