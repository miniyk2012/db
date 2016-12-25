show databases;
use netease;
show TABLES ;

-- ----------------------------
-- Table structure for `play_fav`
-- ----------------------------
DROP TABLE IF EXISTS `play_fav`;
CREATE TABLE `play_fav` (
  `userid` bigint(20) NOT NULL COMMENT '收藏用户id',
  `play_id` bigint(20) NOT NULL COMMENT '歌单id',
  `createtime` bigint(20) NOT NULL COMMENT '收藏时间',
  `status` int(11) DEFAULT '0' COMMENT '状态，是否删除',
  PRIMARY KEY (`play_id`,`userid`),
  KEY `IDX_USERID` (`userid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='歌单收藏表';
show TABLES ;

-- ----------------------------
-- Records of play_fav
-- ----------------------------
INSERT INTO play_fav VALUES ('2', '0', '0', '0');
INSERT INTO play_fav VALUES ('116', '1', '1430223383', '0');
INSERT INTO play_fav VALUES ('143', '1', '0', '0');
INSERT INTO play_fav VALUES ('165', '2', '0', '0');
INSERT INTO play_fav VALUES ('170', '3', '0', '0');
INSERT INTO play_fav VALUES ('185', '3', '0', '0');
INSERT INTO play_fav VALUES ('170', '4', '0', '0');
INSERT INTO play_fav VALUES ('170', '5', '0', '0');

SELECT * from play_fav;

-- ----------------------------
-- Table structure for `play_list`
-- ----------------------------
DROP TABLE IF EXISTS `play_list`;
CREATE TABLE `play_list` (
  `id` bigint(20) NOT NULL COMMENT '主键',
  `play_name` varchar(255) DEFAULT NULL COMMENT '歌单名字',
  `userid` bigint(20) NOT NULL COMMENT '歌单作者账号id',
  `createtime` bigint(20) DEFAULT '0' COMMENT '歌单创建时间',
  `updatetime` bigint(20) DEFAULT '0' COMMENT '歌单更新时间',
  `bookedcount` bigint(20) DEFAULT '0' COMMENT '歌单订阅人数',
  `trackcount` int(11) DEFAULT '0' COMMENT '歌曲的数量',
  `status` int(11) DEFAULT '0' COMMENT '状态,是否删除',
  PRIMARY KEY (`id`),
  KEY `IDX_CreateTime` (`createtime`),
  KEY `IDX_UID_CTIME` (`userid`,`createtime`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='歌单';

-- ----------------------------
-- Records of play_list
-- ----------------------------
INSERT INTO play_list VALUES ('1', '老男孩', '1', '1430223383', '1430223383', '5', '6', '0');
INSERT INTO play_list VALUES ('2', '情歌王子', '3', '1430223384', '1430223384', '7', '3', '0');
INSERT INTO play_list VALUES ('3', '每日歌曲推荐', '5', '1430223385', '1430223385', '2', '4', '0');
INSERT INTO play_list VALUES ('4', '山河水', '2', '1430223386', '1430223386', '5', null, '0');
INSERT INTO play_list VALUES ('5', '李荣浩', '1', '1430223387', '1430223387', '1', '10', '0');
INSERT INTO play_list VALUES ('6', '情深深', '5', '1430223388', '1430223389', '0', '0', '1');

SELECT  * from play_list;






