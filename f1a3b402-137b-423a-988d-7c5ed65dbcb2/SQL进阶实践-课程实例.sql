1. 层级菜单展示
a) 显示一级菜单。
mysql> select * from  tb_goods_category  where category_level=1;
+-------------+----------------+---------------+-------------------+
| category_id | category_level | category_name | upper_category_id |
+-------------+----------------+---------------+-------------------+
|           1 |              1 | 家居生活      |                 0 |
|           2 |              1 | 营养保健      |                 0 |
+-------------+----------------+---------------+-------------------+

b) 显示二级/三级菜单

mysql> select cate2.category_name,cate3.category_name from  tb_goods_category cate2,tb_goods_category cate3  where cate2.category_id = cate3.upper_category_id and cate2.category_level=2 and cate3.category_level=3 and cate2.upper_category_id=1;
+---------------+---------------+
| category_name | category_name |
+---------------+---------------+
| 洗护用品      | 洗发护发      |
| 洗护用品      | 沐浴          |
| 洗护用品      | 牙刷          |
+---------------+---------------+

mysql> select cate2.category_name,cate3.category_name from  tb_goods_category cate2 left join tb_goods_category cate3  on cate2.category_id = cate3.upper_category_id where cate2.category_level=2 and cate2.upper_category_id=1;
+---------------+---------------+
| category_name | category_name |
+---------------+---------------+
| 洗护用品      | 洗发护发      |
| 洗护用品      | 沐浴          |
| 洗护用品      | 牙刷          |
| 个人用品      | NULL          |
| 家居电器      | NULL          |
+---------------+---------------+

2. 按分类展示商品

mysql> select * from tb_goods where category_id=6;
+----------+--------------------------+-------------------+----------------+------------------------------------------------+----------+-------------+
| goods_id | goods_name               | pic_url           | store_quantity | goods_note                                     | producer | category_id |
+----------+--------------------------+-------------------+----------------+------------------------------------------------+----------+-------------+
|        1 | SHISEIDO高效滋润渗透发膜 | img.126.net/1.jpg |           5000 | SHISEIDO 资生堂 Fino 高效滋润渗透发膜 230克    | pro1     |           6 |
|        2 | Ryoe 吕 控油去屑洗发水   | img.126.net/2.jpg |           4500 | Ryoe 吕 控油去屑洗发水+护发素 500毫升/瓶 2瓶装 | pro2     |           6 |
|        3 | 袋鼠护发素               | img.126.net/3.jpg |           5500 | Aussie 袋鼠 控油丰盈蓬松护发素 400毫升         | pro3     |           6 |
+----------+--------------------------+-------------------+----------------+------------------------------------------------+----------+-------------+

select * from tb_goods where category_id=6 order by goods_name;
select goods_id,goods_name,pic_url,store_quantity,goods_note from tb_goods where category_id=6 and producer = 'pro1';
select goods_id,goods_name,pic_url,store_quantity,goods_note from tb_goods where category_id=6 and producer = 'pro1' and store_quantity>0 ;

3. 购买商品，创建订单
insert into tb_order(account_id,create_time,order_amount,order_state ,update_time ,order_ip,pay_method ,user_notes ) values(1,now(),2000,1,now(),'127.0.0.1','paypal','测试订单');
select last_insert_id();
insert into tb_order_item(order_id,goods_id ,goods_quantity,goods_amount) values(1,1,4,800);
insert into tb_order_item(order_id,goods_id ,goods_quantity,goods_amount) values(1,2,3,1200);


4. 查看我的订单
select * from tb_order where account_id=1 order by create_time  desc ;

select o.order_id,max(o.order_state) order_state,group_concat(g.goods_name ) goods_list from tb_order o,tb_order_item oi,tb_goods g  where o.order_
id=oi.order_id and oi.goods_id = g.goods_id  and o.account_id=1 group by o.order_id,o.order_state  order by o.create_time  desc ;
+----------+-------------+-------------+-------------------------------------------------+
| order_id | order_state | order_state | group_concat(g.goods_name )                     |
+----------+-------------+-------------+-------------------------------------------------+
|        2 |           1 |           1 | SHISEIDO高效滋润渗透发膜,Ryoe 吕 控油去屑洗发水 |
|        1 |           1 |           1 | SHISEIDO高效滋润渗透发膜,Ryoe 吕 控油去屑洗发水 |
+----------+-------------+-------------+-------------------------------------------------+

5. 查看商品购买数量
 select g.goods_id ,max(g.goods_name) goods_name,sum(oi.goods_quantity ) from tb_order_item oi,tb_goods g  where  oi.goods_id = g.goods_id
group by g.goods_id ,g.goods_name order by sum(oi.goods_quantity ) desc ;
+----------+--------------------------+-------------------------+
| goods_id | goods_name               | sum(oi.goods_quantity ) |
+----------+--------------------------+-------------------------+
|        1 | SHISEIDO高效滋润渗透发膜 | 12                      |
|        2 | Ryoe 吕 控油去屑洗发水   | 9                       |
+----------+--------------------------+-------------------------+

6. 查看总销售额
select sum(oi.goods_quantity ),sum(oi.goods_amount) from 
tb_order_item oi  ;
+-------------------------+----------------------+
| sum(oi.goods_quantity ) | sum(oi.goods_amount) |
+-------------------------+----------------------+
| 21                      | 6000.00              |
+-------------------------+----------------------+

按商品类别查看销售额

select gc.category_name,sum(oi.goods_quantity ),sum(oi.goods_amount)
 from tb_order_item oi,tb_goods g, tb_goods_category gc where oi.goods_id = g.goods_id and g.category_id = gc.category_id
 group by gc.category_name;

+---------------+-------------------------+----------------------+
| category_name | sum(oi.goods_quantity ) | sum(oi.goods_amount) |
+---------------+-------------------------+----------------------+
| 家居电器      | 1                       | 800.00               |
| 洗发护发      | 21                      | 6000.00              |
+---------------+-------------------------+----------------------+

7. 输出商品名，超过5个字符的名称后面用...代替

 select case when CHAR_LENGTH(goods_name)<5 then goods_name else concat(SUBSTRING(goods_name,1,5) ,'...') end goods_name from tb_goods ;

+---------------+
| goods_name    |
+---------------+
| SHISE...      |
| Ryoe ...      |
| 袋鼠护发素... |
| Sharp...      |
+---------------+
4 rows in set

8. 查看30天以内的订单清单

select * from tb_order where create_time>(now()-interval 30 day);
+----------+------------+---------------------+--------------+-------------+---------------------+-----------+------------+------------+
| order_id | account_id | create_time         | order_amount | order_state | update_time         | order_ip  | pay_method | user_notes |
+----------+------------+---------------------+--------------+-------------+---------------------+-----------+------------+------------+
|        1 |          1 | 2016-03-12 22:12:45 | 2000         |           1 | 2016-03-12 22:12:45 | 127.0.0.1 | paypal     | 测试订单   |
|        2 |          1 | 2016-03-12 22:24:28 | 4000         |           1 | 2016-03-12 22:24:28 | 127.0.0.1 | paypal     | 测试订单   |
|        3 |          2 | 2016-03-29 19:44:25 | 800          |           1 | 2016-03-29 19:44:38 | 127.0.0.1 | epay       | 测试订单   |
+----------+------------+---------------------+--------------+-------------+---------------------+-----------+------------+------------+

9. 新增订单时相应减去库存，如果库存已经降到0则不更新。

delimiter //  
DROP TRIGGER trg_ins_tb_order_item;//
CREATE TRIGGER trg_ins_tb_order_item
BEFORE INSERT ON `tb_order_item`
FOR EACH ROW
BEGIN
 DECLARE i INT;  
 SET i = 0;
 select store_quantity into i from tb_goods where goods_id=NEW.goods_id ;
 IF i-NEW.goods_quantity > 0 THEN
  UPDATE tb_goods set store_quantity=store_quantity-NEW.goods_quantity where goods_id=NEW.goods_id ;
 ELSE
  SIGNAL SQLSTATE 'HY000' SET MESSAGE_TEXT = '库存不足';
 END IF;
END;//
delimiter ; 



课后题
1.查看用户，用户购买产品数量
2.查看一级种类的销售量和销售额