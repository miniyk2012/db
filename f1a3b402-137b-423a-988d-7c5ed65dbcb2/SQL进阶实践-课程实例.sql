1. �㼶�˵�չʾ
a) ��ʾһ���˵���
mysql> select * from  tb_goods_category  where category_level=1;
+-------------+----------------+---------------+-------------------+
| category_id | category_level | category_name | upper_category_id |
+-------------+----------------+---------------+-------------------+
|           1 |              1 | �Ҿ�����      |                 0 |
|           2 |              1 | Ӫ������      |                 0 |
+-------------+----------------+---------------+-------------------+

b) ��ʾ����/�����˵�

mysql> select cate2.category_name,cate3.category_name from  tb_goods_category cate2,tb_goods_category cate3  where cate2.category_id = cate3.upper_category_id and cate2.category_level=2 and cate3.category_level=3 and cate2.upper_category_id=1;
+---------------+---------------+
| category_name | category_name |
+---------------+---------------+
| ϴ����Ʒ      | ϴ������      |
| ϴ����Ʒ      | ��ԡ          |
| ϴ����Ʒ      | ��ˢ          |
+---------------+---------------+

mysql> select cate2.category_name,cate3.category_name from  tb_goods_category cate2 left join tb_goods_category cate3  on cate2.category_id = cate3.upper_category_id where cate2.category_level=2 and cate2.upper_category_id=1;
+---------------+---------------+
| category_name | category_name |
+---------------+---------------+
| ϴ����Ʒ      | ϴ������      |
| ϴ����Ʒ      | ��ԡ          |
| ϴ����Ʒ      | ��ˢ          |
| ������Ʒ      | NULL          |
| �Ҿӵ���      | NULL          |
+---------------+---------------+

2. ������չʾ��Ʒ

mysql> select * from tb_goods where category_id=6;
+----------+--------------------------+-------------------+----------------+------------------------------------------------+----------+-------------+
| goods_id | goods_name               | pic_url           | store_quantity | goods_note                                     | producer | category_id |
+----------+--------------------------+-------------------+----------------+------------------------------------------------+----------+-------------+
|        1 | SHISEIDO��Ч������͸��Ĥ | img.126.net/1.jpg |           5000 | SHISEIDO ������ Fino ��Ч������͸��Ĥ 230��    | pro1     |           6 |
|        2 | Ryoe �� ����ȥмϴ��ˮ   | img.126.net/2.jpg |           4500 | Ryoe �� ����ȥмϴ��ˮ+������ 500����/ƿ 2ƿװ | pro2     |           6 |
|        3 | ���󻤷���               | img.126.net/3.jpg |           5500 | Aussie ���� ���ͷ�ӯ���ɻ����� 400����         | pro3     |           6 |
+----------+--------------------------+-------------------+----------------+------------------------------------------------+----------+-------------+

select * from tb_goods where category_id=6 order by goods_name;
select goods_id,goods_name,pic_url,store_quantity,goods_note from tb_goods where category_id=6 and producer = 'pro1';
select goods_id,goods_name,pic_url,store_quantity,goods_note from tb_goods where category_id=6 and producer = 'pro1' and store_quantity>0 ;

3. ������Ʒ����������
insert into tb_order(account_id,create_time,order_amount,order_state ,update_time ,order_ip,pay_method ,user_notes ) values(1,now(),2000,1,now(),'127.0.0.1','paypal','���Զ���');
select last_insert_id();
insert into tb_order_item(order_id,goods_id ,goods_quantity,goods_amount) values(1,1,4,800);
insert into tb_order_item(order_id,goods_id ,goods_quantity,goods_amount) values(1,2,3,1200);


4. �鿴�ҵĶ���
select * from tb_order where account_id=1 order by create_time  desc ;

select o.order_id,max(o.order_state) order_state,group_concat(g.goods_name ) goods_list from tb_order o,tb_order_item oi,tb_goods g  where o.order_
id=oi.order_id and oi.goods_id = g.goods_id  and o.account_id=1 group by o.order_id,o.order_state  order by o.create_time  desc ;
+----------+-------------+-------------+-------------------------------------------------+
| order_id | order_state | order_state | group_concat(g.goods_name )                     |
+----------+-------------+-------------+-------------------------------------------------+
|        2 |           1 |           1 | SHISEIDO��Ч������͸��Ĥ,Ryoe �� ����ȥмϴ��ˮ |
|        1 |           1 |           1 | SHISEIDO��Ч������͸��Ĥ,Ryoe �� ����ȥмϴ��ˮ |
+----------+-------------+-------------+-------------------------------------------------+

5. �鿴��Ʒ��������
 select g.goods_id ,max(g.goods_name) goods_name,sum(oi.goods_quantity ) from tb_order_item oi,tb_goods g  where  oi.goods_id = g.goods_id
group by g.goods_id ,g.goods_name order by sum(oi.goods_quantity ) desc ;
+----------+--------------------------+-------------------------+
| goods_id | goods_name               | sum(oi.goods_quantity ) |
+----------+--------------------------+-------------------------+
|        1 | SHISEIDO��Ч������͸��Ĥ | 12                      |
|        2 | Ryoe �� ����ȥмϴ��ˮ   | 9                       |
+----------+--------------------------+-------------------------+

6. �鿴�����۶�
select sum(oi.goods_quantity ),sum(oi.goods_amount) from 
tb_order_item oi  ;
+-------------------------+----------------------+
| sum(oi.goods_quantity ) | sum(oi.goods_amount) |
+-------------------------+----------------------+
| 21                      | 6000.00              |
+-------------------------+----------------------+

����Ʒ���鿴���۶�

select gc.category_name,sum(oi.goods_quantity ),sum(oi.goods_amount)
 from tb_order_item oi,tb_goods g, tb_goods_category gc where oi.goods_id = g.goods_id and g.category_id = gc.category_id
 group by gc.category_name;

+---------------+-------------------------+----------------------+
| category_name | sum(oi.goods_quantity ) | sum(oi.goods_amount) |
+---------------+-------------------------+----------------------+
| �Ҿӵ���      | 1                       | 800.00               |
| ϴ������      | 21                      | 6000.00              |
+---------------+-------------------------+----------------------+

7. �����Ʒ��������5���ַ������ƺ�����...����

 select case when CHAR_LENGTH(goods_name)<5 then goods_name else concat(SUBSTRING(goods_name,1,5) ,'...') end goods_name from tb_goods ;

+---------------+
| goods_name    |
+---------------+
| SHISE...      |
| Ryoe ...      |
| ���󻤷���... |
| Sharp...      |
+---------------+
4 rows in set

8. �鿴30�����ڵĶ����嵥

select * from tb_order where create_time>(now()-interval 30 day);
+----------+------------+---------------------+--------------+-------------+---------------------+-----------+------------+------------+
| order_id | account_id | create_time         | order_amount | order_state | update_time         | order_ip  | pay_method | user_notes |
+----------+------------+---------------------+--------------+-------------+---------------------+-----------+------------+------------+
|        1 |          1 | 2016-03-12 22:12:45 | 2000         |           1 | 2016-03-12 22:12:45 | 127.0.0.1 | paypal     | ���Զ���   |
|        2 |          1 | 2016-03-12 22:24:28 | 4000         |           1 | 2016-03-12 22:24:28 | 127.0.0.1 | paypal     | ���Զ���   |
|        3 |          2 | 2016-03-29 19:44:25 | 800          |           1 | 2016-03-29 19:44:38 | 127.0.0.1 | epay       | ���Զ���   |
+----------+------------+---------------------+--------------+-------------+---------------------+-----------+------------+------------+

9. ��������ʱ��Ӧ��ȥ��棬�������Ѿ�����0�򲻸��¡�

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
  SIGNAL SQLSTATE 'HY000' SET MESSAGE_TEXT = '��治��';
 END IF;
END;//
delimiter ; 



�κ���
1.�鿴�û����û������Ʒ����
2.�鿴һ������������������۶�