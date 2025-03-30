/*
 Navicat Premium Data Transfer

 Source Server         : 8.133.244.26-mysql8
 Source Server Type    : MySQL
 Source Server Version : 80041
 Source Host           : 8.133.244.26:17777
 Source Schema         : recruit

 Target Server Type    : MySQL
 Target Server Version : 80041
 File Encoding         : 65001

 Date: 30/03/2025 11:51:33
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for user
-- ----------------------------
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

SET FOREIGN_KEY_CHECKS = 1;
