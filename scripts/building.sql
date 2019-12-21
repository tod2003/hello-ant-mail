/*
 Navicat MariaDB Data Transfer

 Source Server         : test
 Source Server Type    : MariaDB
 Source Server Version : 100407
 Source Host           : localhost:3306
 Source Schema         : building

 Target Server Type    : MariaDB
 Target Server Version : 100407
 File Encoding         : 65001

 Date: 24/08/2019 17:16:53
*/

SET NAMES utf8;
SET FOREIGN_KEY_CHECKS = 0;


DROP DATABASE building;
CREATE DATABASE building;

-- ----------------------------
-- Table structure for tb_auths
-- ----------------------------
DROP TABLE IF EXISTS `tb_auths`;
CREATE TABLE `tb_auths` (
  `id` int(11) PRIMARY KEY AUTO_INCREMENT,
  `type` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for tb_bills
-- ----------------------------
DROP TABLE IF EXISTS `tb_bills`;
CREATE TABLE `tb_bills` (
  `id` int(11) PRIMARY KEY AUTO_INCREMENT,
  `price` decimal(10,2) DEFAULT NULL,
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for tb_dicts
-- ----------------------------
DROP TABLE IF EXISTS `tb_dicts`;
CREATE TABLE `tb_dicts` (
  `id` int(11) PRIMARY KEY AUTO_INCREMENT,
  `type` varchar(255) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for tb_goods
-- ----------------------------
DROP TABLE IF EXISTS `tb_goods`;
CREATE TABLE `tb_goods` (
  `id` int(11) PRIMARY KEY AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for tb_stores
-- ----------------------------
DROP TABLE IF EXISTS `tb_stores`;
CREATE TABLE `tb_stores` (
  `id` int(11) PRIMARY KEY AUTO_INCREMENT,
  `type` varchar(255) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `num` int(11) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for tb_users
-- ----------------------------
DROP TABLE IF EXISTS `tb_users`;
CREATE TABLE `tb_users` (
  `id` int(11) AUTO_INCREMENT,
  `type` varchar(255) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tb_users
-- ----------------------------
BEGIN;
--INSERT INTO `tb_users` VALUES ('admin', 'wangwei');
COMMIT;

-- ----------------------------
-- Table structure for tb_workflows
-- ----------------------------
DROP TABLE IF EXISTS `tb_workflows`;
CREATE TABLE `tb_workflows` (
  `id` int(11) PRIMARY KEY AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

SET FOREIGN_KEY_CHECKS = 1;
