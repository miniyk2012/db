-- ----------------------------
-- Table structure for `stu`
-- ----------------------------
DROP TABLE IF EXISTS `stu`;
CREATE TABLE `stu` (
  `id` int(10) NOT NULL DEFAULT '0',
  `name` varchar(20) DEFAULT NULL,
  `age` int(10) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;





-- ----------------------------
-- Table structure for `tbl_proc_test`
-- ----------------------------
DROP TABLE IF EXISTS `tbl_proc_test`;
CREATE TABLE `tbl_proc_test` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `num` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=30 DEFAULT CHARSET=utf8;

  -- ----------------------------
-- Records of tbl_proc_test
-- ----------------------------
INSERT INTO tbl_proc_test VALUES ('11', '1');
INSERT INTO tbl_proc_test VALUES ('12', '2');
INSERT INTO tbl_proc_test VALUES ('13', '6');
INSERT INTO tbl_proc_test VALUES ('14', '24');
INSERT INTO tbl_proc_test VALUES ('15', '120');
INSERT INTO tbl_proc_test VALUES ('16', '720');
INSERT INTO tbl_proc_test VALUES ('17', '5040');
INSERT INTO tbl_proc_test VALUES ('18', '40320');
INSERT INTO tbl_proc_test VALUES ('19', '362880');
INSERT INTO tbl_proc_test VALUES ('20', '3628800');
INSERT INTO tbl_proc_test VALUES ('21', '1');
INSERT INTO tbl_proc_test VALUES ('22', '2');
INSERT INTO tbl_proc_test VALUES ('23', '6');
INSERT INTO tbl_proc_test VALUES ('24', '24');
INSERT INTO tbl_proc_test VALUES ('25', '1');
INSERT INTO tbl_proc_test VALUES ('26', '2');
INSERT INTO tbl_proc_test VALUES ('27', '6');
INSERT INTO tbl_proc_test VALUES ('28', '24');
INSERT INTO tbl_proc_test VALUES ('29', '120');

SELECT * from tbl_proc_test;


DROP TABLE IF EXISTS `A`;
create table A (
  id int(11) not null AUTO_INCREMENT,
  num int(11) DEFAULT NULL,
  PRIMARY KEY (id)
);

insert into A (num) values (20), (30), (40), (50);
SELECT * from A;

INSERT INTO A VALUES (2,99) ON DUPLICATE KEY UPDATE NUM=99;
SELECT * FROM A;

DROP TABLE IF EXISTS `B`;
create table B (
  id int(11) not null AUTO_INCREMENT,
  num int(11) DEFAULT NULL,
  name VARCHAR(255),
  PRIMARY KEY (id)
);
insert into B (num, name) values (71, 'yangkai'), (72, 'zhoumin');
SELECT *
FROM B;

UPDATE A,B set A.num=B.num where A.id=B.id;

# 连表delete
DELETE A from A,B where A.id=B.id and B.name='zhoumin';

# 一些高级的sql语句，尚未执行

-- ----------------------------
-- Table structure for `tbl_test1`
-- ----------------------------
DROP TABLE IF EXISTS `tbl_test1`;
CREATE TABLE `tbl_test1` (
  `user` varchar(255) NOT NULL COMMENT '主键',
  `key` varchar(255) NOT NULL,
  `value` varchar(255) NOT NULL,
  PRIMARY KEY (`user`,`key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='行列转换测试';

-- ----------------------------
-- Records of tbl_test1
-- ----------------------------
INSERT INTO tbl_test1 VALUES ('li', 'age', '18');
INSERT INTO tbl_test1 VALUES ('li', 'dep', '2');
INSERT INTO tbl_test1 VALUES ('li', 'sex', 'male');
INSERT INTO tbl_test1 VALUES ('sun', 'age', '44');
INSERT INTO tbl_test1 VALUES ('sun', 'dep', '3');
INSERT INTO tbl_test1 VALUES ('sun', 'sex', 'female');
INSERT INTO tbl_test1 VALUES ('wang', 'age', '20');
INSERT INTO tbl_test1 VALUES ('wang', 'dep', '3');
INSERT INTO tbl_test1 VALUES ('wang', 'sex', 'male');

use netease;
select * from tbl_proc_test;
-- ----------------------------
-- Procedure structure for `proc_test1`  存储过程
-- ----------------------------
DROP PROCEDURE IF EXISTS `proc_test1`;
DELIMITER ;;
CREATE DEFINER=root PROCEDURE `proc_test1`(IN total INT,OUT res INT)
BEGIN
    DECLARE i INT;
    SET i = 1;
    SET res = 1;
    IF total <= 0 THEN
        SET total = 1;
    END IF;
    WHILE i <= total DO
        SET res = res * i;
        INSERT INTO tbl_proc_test(num) VALUES (res);
        SET i = i + 1;
    END WHILE;
END
;;
DELIMITER ;

show PROCEDURE STATUS;

show CREATE PROCEDURE proc_test1;


set @total=5;
set @res=0;

# 定义变量，调用存储过程
SELECT @res, @total;

call proc_test1(@total,@res);

SELECT * from tbl_proc_test;

SELECT @res;
SELECT @total;


