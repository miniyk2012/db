show DATABASES;
create table t (a int(11) ZEROFILL, b int(21) ZEROFILL);
insert into t VALUES (1,1);
select * from t;

drop TABLE t;

create table t (a int(11) , b int(21));

insert into t VALUES (1,1);
select * from t;


drop TABLE t;

# 精度丢失问题, double和float都是非精确的数据类型，因此不适用于工资、股票等，
# 建议用decimal类型，它的存储空间是动态的，精度越高空间越大

create TABLE t (a VARCHAR(256));

CREATE TABLE test (a DATETIME, b TIMESTAMP);
show CREATE TABLE test;
SELECT NOW();
INSERT INTO TEST VALUES (NOW(), NOW());
SELECT * FROM test;
SET TIME_ZONE = '+00:00';
SELECT * FROM test;

SET TIME_ZONE = '+08:00';
SELECT * FROM test;

SELECT FROM_UNIXTIME(1481774453);
SELECT UNIX_TIMESTAMP(NOW());

# help create index;
# help alter table;

CREATE TABLE `order` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `orderid` int(10) unsigned NOT NULL,
  `bookid` int(10) unsigned NOT NULL DEFAULT '0',
  `userid` int(10) unsigned NOT NULL DEFAULT '0',
  `number` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `address` varchar(128) NOT NULL DEFAULT '',
  `postcode` varchar(128) NOT NULL DEFAULT '',
  `orderdate` datetime NOT NULL DEFAULT '1000-01-01
00:00:00.000000',
  `status` tinyint(3) unsigned zerofill DEFAULT '000',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_orderid` (`orderid`),
  UNIQUE KEY `idx_uid_orderid` (`userid`, `orderid`),
  KEY `bookid` (`bookid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

use test;
# show create table `order`\G
alter table `order` add primary key (id);
alter table `order` add unique key idx_uk_orderid (orderid);
alter table `order` add CONSTRAINT constraint_uid FOREIGN KEY(userid) REFERENCES user(userid);

create view order_view as select * from `order` where status=1;