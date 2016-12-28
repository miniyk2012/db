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
`goods_id`  bigint(20) NOT NULL AUTO_INCREMENT COMMENT '����id' ,
`goods_name`  varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '��Ʒ����' ,
`pic_url`  varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT 'ͼƬurl' ,
`store_quantity`  int(11) NOT NULL COMMENT '���' ,
`goods_note`  varchar(4096) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '��Ʒ���' ,
`producer`  varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '������' ,
`category_id`  int(11) NOT NULL COMMENT '��Ʒ����' ,
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
INSERT INTO tb_goods VALUES ('1', 'SHISEIDO��Ч������͸��Ĥ', 'img.126.net/1.jpg', '5000', 'SHISEIDO ������ Fino ��Ч������͸��Ĥ 230��', 'pro1', '6'), ('2', 'Ryoe �� ����ȥмϴ��ˮ', 'img.126.net/2.jpg', '4428', 'Ryoe �� ����ȥмϴ��ˮ+������ 500����/ƿ 2ƿװ', 'pro2', '6'), ('3', '���󻤷���', 'img.126.net/3.jpg', '5500', 'Aussie ���� ���ͷ�ӯ���ɻ����� 400����', 'pro3', '6'), ('4', 'Sharp ���� �����ӷ��������ؿ��������� IG-FC15-B', 'img.126.net/4.jpg', '60000', 'Sharp ���� �����ӷ��������ؿ��������� IG-FC15-B', 'pro1', '5');
COMMIT;

-- ----------------------------
-- Table structure for `tb_goods_category`
-- ----------------------------
DROP TABLE IF EXISTS `tb_goods_category`;
CREATE TABLE `tb_goods_category` (
`category_id`  int(11) NOT NULL AUTO_INCREMENT COMMENT '����id' ,
`category_level`  smallint(6) NOT NULL COMMENT '����㼶' ,
`category_name`  varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '��������' ,
`upper_category_id`  int(11) NOT NULL COMMENT '��������id' ,
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
INSERT INTO tb_goods_category VALUES ('1', '1', '�Ҿ�����', '0'), ('2', '1', 'Ӫ������', '0'), ('3', '2', 'ϴ����Ʒ', '1'), ('4', '2', '������Ʒ', '1'), ('5', '2', '�Ҿӵ���', '1'), ('6', '3', 'ϴ������', '3'), ('7', '3', '��ԡ', '3'), ('8', '3', '��ˢ', '3');
COMMIT;

-- ----------------------------
-- Table structure for `tb_order`
-- ----------------------------
DROP TABLE IF EXISTS `tb_order`;
CREATE TABLE `tb_order` (
`order_id`  bigint(20) NOT NULL AUTO_INCREMENT COMMENT '����id' ,
`account_id`  int(11) NOT NULL COMMENT '�û�id' ,
`create_time`  datetime NULL DEFAULT NULL COMMENT '����ʱ��' ,
`order_amount`  decimal(12,2) NULL DEFAULT NULL COMMENT '������' ,
`order_state`  tinyint(4) NULL DEFAULT NULL COMMENT '����״̬' ,
`update_time`  datetime NULL DEFAULT NULL COMMENT '����ʱ��' ,
`order_ip`  varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '�û�ip' ,
`pay_method`  varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '���ʽ' ,
`user_notes`  varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '�û���ע' ,
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
INSERT INTO tb_order VALUES ('1', '1', '2016-03-12 22:12:45', '2000.00', '1', '2016-03-12 22:12:45', '127.0.0.1', 'paypal', '���Զ���'), ('2', '1', '2016-03-12 22:24:28', '4000.00', '1', '2016-03-12 22:24:28', '127.0.0.1', 'paypal', '���Զ���'), ('3', '2', '2016-03-29 19:44:25', '800.00', '1', '2016-03-29 19:44:38', '127.0.0.1', 'epay', '���Զ���');
COMMIT;

-- ----------------------------
-- Table structure for `tb_order_item`
-- ----------------------------
DROP TABLE IF EXISTS `tb_order_item`;
CREATE TABLE `tb_order_item` (
`order_item_id`  bigint(20) NOT NULL AUTO_INCREMENT COMMENT '����id' ,
`order_id`  bigint(20) NOT NULL COMMENT '����id' ,
`goods_id`  bigint(20) NOT NULL COMMENT '��Ʒid' ,
`goods_quantity`  int(11) NOT NULL COMMENT '��Ʒ����' ,
`goods_amount`  decimal(12,2) NULL DEFAULT NULL COMMENT '��Ʒ�ܶ�' ,
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
		SIGNAL SQLSTATE 'HY000' SET MESSAGE_TEXT = '��治��';
	END IF; 
END
;;
DELIMITER ;

-- ----------------------------
-- Auto increment value for `tb_order_item`
-- ----------------------------
ALTER TABLE `tb_order_item` AUTO_INCREMENT=20;
