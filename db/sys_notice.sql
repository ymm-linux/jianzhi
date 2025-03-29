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

 Date: 30/03/2025 00:26:09
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for sys_notice
-- ----------------------------
DROP TABLE IF EXISTS `sys_notice`;
CREATE TABLE `sys_notice`  (
  `notice_id` bigint(0) NOT NULL COMMENT '公告ID',
  `notice_title` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '公告标题',
  `notice_type` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `notice_content` longblob COMMENT '公告内容',
  `status` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime(0) DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime(0) DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`notice_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '公告管理' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_notice
-- ----------------------------
INSERT INTO `sys_notice` VALUES (1, '测试', '1', 0x3C6F6C3E3C6C693E3C7374726F6E673E3C656D3E3C753EE998BFE5A4A7E5A3B0E981933C2F753E3C2F656D3E3C2F7374726F6E673E3C2F6C693E3C2F6F6C3E, '0', 'admin', '2023-02-14 16:01:11', 'admin', '2023-02-15 12:13:22', NULL);
INSERT INTO `sys_notice` VALUES (2, '通知', '0', 0x3C6F6C3E3C6C693E3C7374726F6E673E3C656D3E3C753EE998BFE5A4A7E5A3B0E981933C2F753E3C2F656D3E3C2F7374726F6E673E3C2F6C693E3C2F6F6C3E, '0', 'admin', '2023-02-14 16:01:11', 'admin', '2023-02-15 12:13:22', NULL);

SET FOREIGN_KEY_CHECKS = 1;
