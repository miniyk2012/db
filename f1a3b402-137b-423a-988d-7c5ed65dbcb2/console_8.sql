use netease;
show collation;

show VARIABLES like '%char%';
set names utf8;
set CHARACTER_SET_SERVER=utf8;
create table `stu1`(
`name` varchar(50) not null default '',
`course` varchar(50) default null,
`score` int(11) default null,
primary key(`name`)
) engine=innodb default charset=latin1;



alter table stu1 convert to character set utf8;

insert into stu1 values('pw','你好',44);

select * from stu1;

create table `stu2`(
`name` varchar(50) not null default '',
`course` varchar(50) default null,
`score` int(11) default null,
primary key(`name`)
) engine=innodb default charset=utf8;

insert into stu2 values('pw','你好',33);

select * from stu2;

set names gbk;
show VARIABLES like '%char%';
show CREATE TABLE stu2;

insert into stu2 values('pw7','你好吗',33);
insert into stu2 values('pw6','你好',33);

select * from stu2;
set names utf8;

set names gbk;

insert into stu2 values('pw3','你好',33);

select * from stu2;
select length(course) from stu2;

create table `tb1`(
`name` varchar(50) not null
) engine=innodb default charset=gbk;
set names gbk;

insert into tb1 values('你好');
set names utf8;
insert into tb1 values('你好啊');

select * from tb1;


set character_set_database=utf8;
show VARIABLES like '%char%';

load data infile '/usr/local/mysql/data/a.txt' into table tb1;

SELECT * from tb1;