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

 Date: 29/03/2025 23:27:48
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

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

SET FOREIGN_KEY_CHECKS = 1;
