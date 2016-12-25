-- ----------------------------
-- Table structure for `song_list`
-- ----------------------------
DROP TABLE IF EXISTS `song_list`;
CREATE TABLE `song_list` (
  `id` bigint(20) NOT NULL COMMENT '主键',
  `song_name` varchar(255) NOT NULL COMMENT '歌曲名',
  `artist` varchar(255) NOT NULL COMMENT '艺术家',
  `createtime` bigint(20) DEFAULT '0' COMMENT '歌曲创建时间',
  `updatetime` bigint(20) DEFAULT '0' COMMENT '歌曲更新时间',
  `album` varchar(255) DEFAULT NULL COMMENT '专辑',
  `playcount` int(11) DEFAULT '0' COMMENT '点播次数',
  `status` int(11) DEFAULT '0' COMMENT '状态,是否删除',
  PRIMARY KEY (`id`),
  KEY `IDX_artist` (`artist`),
  KEY `IDX_album` (`album`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='歌曲列表';

show create table song_list;

INSERT INTO song_list VALUES ('1', 'Good Lovin\' Gone Bad', 'Bad Company', '0', '0', 'Straight Shooter', '453', '0');
INSERT INTO song_list VALUES ('2', 'Weep No More', 'Bad Company', '0', '0', 'Straight Shooter', '280', '0');
INSERT INTO song_list VALUES ('3', 'Shooting Star', 'Bad Company', '0', '0', 'Straight Shooter', '530', '0');
INSERT INTO song_list VALUES ('4', '大象', '李志', '0', '0', '1701', '560', '0');
INSERT INTO song_list VALUES ('5', '定西', '李志', '0', '0', '1701', '1023', '0');
INSERT INTO song_list VALUES ('6', '红雪莲', '洪启', '0', '0', '红雪莲', '220', '0');
INSERT INTO song_list VALUES ('7', '风柜来的人', '李宗盛', '0', '0', '作品李宗盛', '566', '0');

SELECT * from song_list;

use netease;
select album, sum(playcount), avg(playcount) from song_list group by album;

select max(playcount), min(playcount) from song_list;

# SELECT playcount, max(playcount) from song_list;  # 错误查法
select song_name, playcount from song_list order by playcount desc limit 1;  # 正确查法：找出最大播放次数的歌曲名

SELECT album, group_concat(song_name) song_names from song_list GROUP BY album;

show GLOBAL VARIABLES like '%concat%';


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

select * from tbl_test1;

SELECT user,
  max(case when `key`='age' then `value` else null end) age,
  max(case `key` when 'sex' then value end) sex,
  max(case when `key`='dep' then value end) dep
from tbl_test1
group by user;

SELECT substring('abcdef', 3);
SELECT substring('abcdef', -1);
SELECT substring('abcdef', 3, 2);

SELECT LOCATE('bar', 'footbar');
SELECT LOCATE('xbar', 'footbar');
SELECT LOCATE('bar', 'footbarbar', 6);

SELECT curdate();
SELECT current_time();
SELECT NOW();
SELECT unix_timestamp();

select DATE_FORMAT('2016-12-25 22:49:12', '%H:%i:%s');
select DATE_FORMAT('2016-12-25 22:49:12', '%W %M %Y');

SELECT NOW() + INTERVAL 1 MONTh;
SELECT NOW() - INTERVAL 1 WEEK;
SELECT NOW() - INTERVAL 1 WEEK + INTERVAL 2 day;
SELECT NOW() + INTERVAL 1 year - INTERVAL 1 WEEK + INTERVAL 2 day;

select * from play_list where (createtime between 1427791323 and 1430383307) and userid in (1,3,5);

SELECT rand();
SELECT rand();
SELECT rand();

SELECT 1+ ceil(rand()*4);  # 得到一个1-5之间的随机整数
SELECT 1+ ceil(rand()*4);