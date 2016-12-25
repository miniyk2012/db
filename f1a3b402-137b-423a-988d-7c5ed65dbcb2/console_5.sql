SET FOREIGN_KEY_CHECKS=0;
-- ----------------------------
-- Table structure for `stu`
-- ----------------------------
DROP TABLE IF EXISTS `stu`;
CREATE TABLE `stu` (
  `name` varchar(50) ,
  `course` varchar(50),
  `score` int(11),
  PRIMARY KEY (`name`)
) ENGINE=InnoDB ;


delimiter //  # 自定义的分割符
CREATE TRIGGER trg_upd_score
BEFORE UPDATE ON `stu`
FOR EACH ROW
BEGIN
    IF NEW.score < 0 THEN
        SET NEW.score = 0;
    ELSEIF NEW.score > 100 THEN
        SET NEW.score = 100;
    END IF;
END;//
delimiter ;


SELECT * from stu;
insert into stu VALUES ('yangkai', 'compute science', 50);
SELECT * from stu;
update stu set score=-10;
SELECT * from stu;
UPDATE stu set score=190;
SELECT * from stu;


-- ----------------------------
-- Procedure structure for `proc_test1`
-- ----------------------------
DROP PROCEDURE IF EXISTS `proc_test1`;
DELIMITER ;;
CREATE   PROCEDURE `proc_test1`(IN total INT,OUT res INT)
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