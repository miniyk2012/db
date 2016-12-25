grant select on *.* to 'thomas_young'@'localhost' IDENTIFIED by '123456' with grant option;


use netease;
show tables;
-- Table structure for table `tb_account`
--

DROP TABLE IF EXISTS `tb_account`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tb_account` (
  `account_id` int(11) NOT NULL AUTO_INCREMENT,
  `nick_name` varchar(20) DEFAULT NULL,
  `true_name` varchar(20) DEFAULT NULL,
  `sex` char(1) DEFAULT NULL,
  `mail_address` varchar(50) DEFAULT NULL,
  `phone1` varchar(20) NOT NULL,
  `phone2` varchar(20) DEFAULT NULL,
  `password` varchar(30) NOT NULL,
  `create_time` datetime DEFAULT NULL,
  `account_state` tinyint(4) DEFAULT NULL,
  `last_login_time` datetime DEFAULT NULL,
  `last_login_ip` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`account_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

show tables;
--
-- Table structure for table `tb_goods`
--

DROP TABLE IF EXISTS `tb_goods`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tb_goods` (
  `goods_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `goods_name` varchar(100) NOT NULL,
  `pic_url` varchar(500) NOT NULL,
  `store_quantity` int(11) NOT NULL,
  `goods_note` varchar(800) DEFAULT NULL,
  `producer` varchar(500) DEFAULT NULL,
  `category_id` int(11) NOT NULL,
  PRIMARY KEY (`goods_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

show tables;

--
-- Table structure for table `tb_goods_category`
--

DROP TABLE IF EXISTS `tb_goods_category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tb_goods_category` (
  `category_id` int(11) NOT NULL AUTO_INCREMENT,
  `category_level` smallint(6) NOT NULL,
  `category_name` varchar(500) DEFAULT NULL,
  `upper_category_id` int(11) NOT NULL,
  PRIMARY KEY (`category_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

show CREATE TABLE tb_goods_category;
--
-- Table structure for table `tb_order`
--

DROP TABLE IF EXISTS `tb_order`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tb_order` (
  `order_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `account_id` int(11) NOT NULL,
  `create_time` datetime DEFAULT NULL,
  `order_amount` decimal(12,2) DEFAULT NULL,
  `order_state` tinyint(4) DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  `order_ip` varchar(20) DEFAULT NULL,
  `pay_method` varchar(20) DEFAULT NULL,
  `user_notes` varchar(500) DEFAULT NULL,
  PRIMARY KEY (`order_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tb_order_item`
--

DROP TABLE IF EXISTS `tb_order_item`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tb_order_item` (
  `order_item_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `order_id` bigint(20) NOT NULL,
  `goods_id` bigint(20) NOT NULL,
  `goods_quantity` int(11) NOT NULL,
  `goods_amount` decimal(12,2) DEFAULT NULL,
  PRIMARY KEY (`order_item_id`),
  UNIQUE KEY `uk_order_goods` (`order_id`,`goods_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;