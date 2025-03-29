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

 Date: 29/03/2025 22:44:35
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for messages
-- ----------------------------
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

SET FOREIGN_KEY_CHECKS = 1;
