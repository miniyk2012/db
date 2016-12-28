/*
Navicat MySQL Data Transfer

Target Server Type    : MYSQL
Target Server Version : 50520
File Encoding         : 65001

Date: 2016-04-25 09:12:49
*/
USE netease;
SET FOREIGN_KEY_CHECKS=0;
-- ----------------------------
-- Table structure for `tb_account`
-- ----------------------------
DROP TABLE IF EXISTS `tb_account`;
CREATE TABLE `tb_account` (
`account_id`  int(11) NOT NULL AUTO_INCREMENT ,
`nick_name`  varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL ,
`true_name`  varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL ,
`mail_address`  varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL ,
`phone1`  varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL ,
`phone2`  varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL ,
`password`  varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL ,
`create_time`  datetime NULL DEFAULT NULL ,
`account_state`  tinyint(4) NULL DEFAULT NULL ,
`last_login_time`  datetime NULL DEFAULT NULL ,
`last_login_ip`  varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL ,
PRIMARY KEY (`account_id`)
)
ENGINE=InnoDB
DEFAULT CHARACTER SET=utf8 COLLATE=utf8_general_ci
AUTO_INCREMENT=4

;

-- ----------------------------
-- Records of tb_account
-- ----------------------------
BEGIN;
INSERT INTO tb_account VALUES ('1', 'tom', 'tom', 'tom@163.com', '1231', null, '', '2016-03-28 19:43:39', '1', '2016-03-29 19:43:25', '127.0.0.1'), ('2', 'abble', 'abble', 'abble@163.com', '1232', null, '', '2016-03-29 19:46:44', '1', '2016-03-29 19:46:50', '127.0.0.1'), ('3', 'li', 'li', 'li@163.com', '1233', null, '', '2016-03-29 19:47:11', '1', '2016-03-29 19:47:14', '127.0.0.1');
COMMIT;

-- ----------------------------
-- Table structure for `tb_goods`
-- ----------------------------
DROP TABLE IF EXISTS `tb_goods`;
CREATE TABLE `tb_goods` (
`goods_id`  bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键id' ,
`goods_name`  varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '商品名称' ,
`pic_url`  varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '图片url' ,
`store_quantity`  int(11) NOT NULL COMMENT '库存' ,
`goods_note`  varchar(4096) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '商品简介' ,
`producer`  varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '供货商' ,
`category_id`  int(11) NOT NULL COMMENT '商品种类' ,
PRIMARY KEY (`goods_id`)
)
ENGINE=InnoDB
DEFAULT CHARACTER SET=utf8 COLLATE=utf8_general_ci
AUTO_INCREMENT=5

;

-- ----------------------------
-- Records of tb_goods
-- ----------------------------
BEGIN;
INSERT INTO tb_goods VALUES ('1', 'SHISEIDO高效滋润渗透发膜', 'img.126.net/1.jpg', '5000', 'SHISEIDO 资生堂 Fino 高效滋润渗透发膜 230克', 'pro1', '6'), ('2', 'Ryoe 吕 控油去屑洗发水', 'img.126.net/2.jpg', '4428', 'Ryoe 吕 控油去屑洗发水+护发素 500毫升/瓶 2瓶装', 'pro2', '6'), ('3', '袋鼠护发素', 'img.126.net/3.jpg', '5500', 'Aussie 袋鼠 控油丰盈蓬松护发素 400毫升', 'pro3', '6'), ('4', 'Sharp 夏普 等离子发生器车载空气净化器 IG-FC15-B', 'img.126.net/4.jpg', '60000', 'Sharp 夏普 等离子发生器车载空气净化器 IG-FC15-B', 'pro1', '5');
COMMIT;

-- ----------------------------
-- Table structure for `tb_goods_category`
-- ----------------------------
DROP TABLE IF EXISTS `tb_goods_category`;
CREATE TABLE `tb_goods_category` (
`category_id`  int(11) NOT NULL AUTO_INCREMENT COMMENT '主键id' ,
`category_level`  smallint(6) NOT NULL COMMENT '种类层级' ,
`category_name`  varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '种类名称' ,
`upper_category_id`  int(11) NOT NULL COMMENT '父级种类id' ,
PRIMARY KEY (`category_id`)
)
ENGINE=InnoDB
DEFAULT CHARACTER SET=utf8 COLLATE=utf8_general_ci
AUTO_INCREMENT=9

;

-- ----------------------------
-- Records of tb_goods_category
-- ----------------------------
BEGIN;
INSERT INTO tb_goods_category VALUES ('1', '1', '家居生活', '0'), ('2', '1', '营养保健', '0'), ('3', '2', '洗护用品', '1'), ('4', '2', '个人用品', '1'), ('5', '2', '家居电器', '1'), ('6', '3', '洗发护发', '3'), ('7', '3', '沐浴', '3'), ('8', '3', '牙刷', '3');
COMMIT;

-- ----------------------------
-- Table structure for `tb_order`
-- ----------------------------
DROP TABLE IF EXISTS `tb_order`;
CREATE TABLE `tb_order` (
`order_id`  bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键id' ,
`account_id`  int(11) NOT NULL COMMENT '用户id' ,
`create_time`  datetime NULL DEFAULT NULL COMMENT '创建时间' ,
`order_amount`  decimal(12,2) NULL DEFAULT NULL COMMENT '购买金额' ,
`order_state`  tinyint(4) NULL DEFAULT NULL COMMENT '订单状态' ,
`update_time`  datetime NULL DEFAULT NULL COMMENT '更新时间' ,
`order_ip`  varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '用户ip' ,
`pay_method`  varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '付款方式' ,
`user_notes`  varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '用户备注' ,
PRIMARY KEY (`order_id`)
)
ENGINE=InnoDB
DEFAULT CHARACTER SET=utf8 COLLATE=utf8_general_ci
AUTO_INCREMENT=4

;

-- ----------------------------
-- Records of tb_order
-- ----------------------------
BEGIN;
INSERT INTO tb_order VALUES ('1', '1', '2016-03-12 22:12:45', '2000.00', '1', '2016-03-12 22:12:45', '127.0.0.1', 'paypal', '测试订单'), ('2', '1', '2016-03-12 22:24:28', '4000.00', '1', '2016-03-12 22:24:28', '127.0.0.1', 'paypal', '测试订单'), ('3', '2', '2016-03-29 19:44:25', '800.00', '1', '2016-03-29 19:44:38', '127.0.0.1', 'epay', '测试订单');
COMMIT;

-- ----------------------------
-- Table structure for `tb_order_item`
-- ----------------------------
DROP TABLE IF EXISTS `tb_order_item`;
CREATE TABLE `tb_order_item` (
`order_item_id`  bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键id' ,
`order_id`  bigint(20) NOT NULL COMMENT '订单id' ,
`goods_id`  bigint(20) NOT NULL COMMENT '商品id' ,
`goods_quantity`  int(11) NOT NULL COMMENT '商品数量' ,
`goods_amount`  decimal(12,2) NULL DEFAULT NULL COMMENT '商品总额' ,
PRIMARY KEY (`order_item_id`)
)
ENGINE=InnoDB
DEFAULT CHARACTER SET=utf8 COLLATE=utf8_general_ci
AUTO_INCREMENT=20

;

-- ----------------------------
-- Records of tb_order_item
-- ----------------------------
BEGIN;
INSERT INTO tb_order_item VALUES ('1', '1', '1', '4', '800.00'), ('2', '1', '2', '3', '1200.00'), ('3', '2', '1', '8', '1600.00'), ('4', '2', '2', '6', '2400.00'), ('5', '3', '4', '1', '800.00'), ('15', '8', '2', '3', '1200.00'), ('19', '7', '2', '3', '1200.00');
COMMIT;

-- ----------------------------
-- Auto increment value for `tb_account`
-- ----------------------------
ALTER TABLE `tb_account` AUTO_INCREMENT=4;

-- ----------------------------
-- Auto increment value for `tb_goods`
-- ----------------------------
ALTER TABLE `tb_goods` AUTO_INCREMENT=5;

-- ----------------------------
-- Auto increment value for `tb_goods_category`
-- ----------------------------
ALTER TABLE `tb_goods_category` AUTO_INCREMENT=9;

-- ----------------------------
-- Auto increment value for `tb_order`
-- ----------------------------
ALTER TABLE `tb_order` AUTO_INCREMENT=4;

-- ----------------------------
-- Indexes structure for table `tb_order_item`
-- ----------------------------
CREATE UNIQUE INDEX `uk_order_goods` ON `tb_order_item`(`order_id`, `goods_id`) USING BTREE ;
DELIMITER ;;
CREATE TRIGGER `trg_ins_tb_order_item` BEFORE INSERT ON `tb_order_item` FOR EACH ROW BEGIN 
	DECLARE i INT;  
	SET i = 0; 
	select store_quantity into i from tb_goods where goods_id=NEW.goods_id ;
	IF i-NEW.goods_quantity > 0 THEN 
		UPDATE tb_goods set store_quantity=store_quantity-NEW.goods_quantity where goods_id=NEW.goods_id ;
	ELSE
		SIGNAL SQLSTATE 'HY000' SET MESSAGE_TEXT = '库存不足';
	END IF; 
END
;;
DELIMITER ;

-- ----------------------------
-- Auto increment value for `tb_order_item`
-- ----------------------------
ALTER TABLE `tb_order_item` AUTO_INCREMENT=20;
