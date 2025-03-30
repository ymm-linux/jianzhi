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

 Date: 29/03/2025 22:45:24
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for complaints_feedbacks
-- ----------------------------
DROP TABLE IF EXISTS `feedbacks`;
CREATE TABLE `feedbacks`  (
  `id` bigint(0) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `user_id` bigint(0) NOT NULL COMMENT '关联用户，可以是企业或学生',
  `user_type` varchar(2) NOT NULL COMMENT '0、企业hr，1、学生',
  `content` varchar(2000)  NOT NULL COMMENT '投诉或反馈内容',
  `status` varchar(2)  DEFAULT '0' COMMENT '处理状态 0、待处理，1、已处理',
  `send_time` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '发起时间',
  `reviewer_content` bigint(0) DEFAULT NULL COMMENT '反馈内容',
  `reviewer_id` bigint(0) DEFAULT NULL COMMENT '处理人ID，管理员',
  `reviewer_time` timestamp(0) null COMMENT '反馈时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1  COMMENT = '投诉与反馈表' ROW_FORMAT = Dynamic;

SET FOREIGN_KEY_CHECKS = 1;
