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

 Date: 29/03/2025 22:46:00
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for work_salaries
-- ----------------------------
DROP TABLE IF EXISTS `work_salaries`;
CREATE TABLE `work_salaries`  (
  `id` bigint(0) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `user_id` bigint(0) NOT NULL COMMENT '关联学生',
  `position_id` bigint(0) NOT NULL COMMENT '关联岗位',
  `hr_id` bigint(0) NOT NULL COMMENT '关联企业',
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

SET FOREIGN_KEY_CHECKS = 1;
