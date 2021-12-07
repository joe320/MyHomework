create database 商品
on primary
(name=sd_root,
filename='D:\lu\db02\sd_root.mdf',
size=8MB,
maxsize=unlimited,
filegrowth=100kb),
(name=sd_data1,
filename='D:\lu\db02\sd_data1.ndf',
size=8MB,
maxsize=10mb,
filegrowth=100kb)
log on
(name=log_data1,
filename='D:\lu\db02\log_data1.ldf',
size=8MB,
maxsize=10mb,
filegrowth=100kb)
go
use 商品
go
create table 商品
(
商品编号 char(3) primary key,
商品名称 char(20) not null,
价格 numeric(8,2)check(价格 between 0 and 20),
商品类型 char(10),
商品生产商 char(12)
)
create table 顾客
(
顾客编号 char(10)primary key,
顾客姓名 char(12)not null,
顾客地址 varchar(50)
)
create table 购买
(
商品编号 char(3),
顾客编号 char(10),
购买数量 int,
primary key(商品编号,顾客编号),
foreign key(商品编号) references 商品(商品编号),
foreign key(顾客编号) references 顾客(顾客编号)
)

insert into 商品
values
('M01','佳洁士',8.00,'牙膏','宝洁'),
('M02','高露洁',6.50,'牙膏','宝洁'),
('M03','洁诺',5.00,'牙膏','联合利华'),
('M04','舒肤佳',3.00,'香皂','宝洁'),
('M05','夏士莲',5.00,'香皂','联合利华'),
('M06','雕牌',2.50,'洗衣粉','纳爱斯'),
('M07','中华',3.50,'牙膏','联合利华'),
('M08','汰渍',3.00,'洗衣粉','宝洁'),
('M09','碧浪',4.00,'洗衣粉','宝洁');

insert into 顾客
values
('C01','Dennis','海淀'),
('C02','John','朝阳'),
('C03','Tom','东城'),
('C04','Jenny','东城'),
('C05','Rick','西城');

insert into 购买(顾客编号,商品编号,购买数量)
values
('C01','M01',3),
('C01','M05',2),
('C01','M08',2),
('C02','M02',5),
('C02','M06',4),
('C03','M01',1),
('C03','M05',1),
('C03','M06',3),
('C03','M08',1),
('C04','M03',7),
('C04','M04',3),     
('C05','M06',2),
('C05','M07',8);

--（1）求购买了供应商"宝洁"产品的所有顾客；
use 商品
go
select distinct 顾客.顾客编号,顾客.顾客姓名,顾客.顾客地址 from 顾客,购买,商品
where 购买.商品编号=商品.商品编号 and 购买.顾客编号=顾客.顾客编号 and
      商品生产商='宝洁';

select 顾客编号,顾客姓名,顾客地址 from 顾客
where 顾客编号 in (select 顾客编号 from 购买
                   where 商品编号 in (select 商品编号  from 商品  
                                      where 商品生产商='宝洁'));
                                      
select distinct 顾客.顾客编号,顾客.顾客姓名,顾客.顾客地址 
from (顾客 inner join 购买 on 购买.顾客编号=顾客.顾客编号)inner join 商品 on 购买.商品编号=商品.商品编号
where 商品生产商='宝洁';
 

--（2）求所有购买洗衣粉商品的顾客的住址；
select distinct 顾客.顾客地址 from 顾客,购买,商品
where 购买.商品编号=商品.商品编号 and 购买.顾客编号=顾客.顾客编号 and
      商品类型='洗衣粉';

--（3）求各供应商卖出的牙膏数量，并按降序进行排序；
select 商品.商品生产商,SUM(购买数量) as 牙膏数量
from 购买,商品
where 购买.商品编号=商品.商品编号 and 
      商品类型='牙膏'
group by 商品.商品生产商
order by 牙膏数量 desc

--（4）将所有的牙膏商品单价增加10%。
update 商品 set 价格=价格*1.1
where 商品类型='牙膏';

--（5）求从未被购买过的商品
select * from 商品
where 商品编号 not in (select 商品编号 from 购买);

--（6）和Dennis购买了一样的商品的顾客号、顾客名
select 顾客编号,顾客姓名 from 顾客
where 顾客编号 in  (select   顾客编号  from  购买 
                     where 商品编号 in (select 商品编号 from 购买
                                         where 顾客编号=(select 顾客编号 from 顾客
                                                         where  顾客姓名='Dennis')));
select distinct 顾客.顾客编号,顾客.顾客姓名 from 顾客,购买
where 购买.顾客编号=顾客.顾客编号 and
      商品编号 in (select 商品编号 from 购买,顾客
                  where 购买.顾客编号=顾客.顾客编号 and
                        顾客姓名='Dennis');
                   


--(1)检索定购商品号为‘M01’的顾客号和顾客名。
select 顾客编号,顾客姓名 from 顾客
where 顾客编号 in (select 顾客编号 from 购买
                   where 商品编号='M01');
                   
--(2)检索定购商品号为‘M01’或‘M02’的顾客号。
select 顾客编号 from 顾客
where 顾客编号 in (select 顾客编号 from 购买
                   where 商品编号 in ('M01','M02'));
                   
--(3)检索至少定购商品号为‘M01’和‘M08’的顾客号。(用交的方法)  
select 顾客编号 from 购买
where 商品编号='M01'
intersect
select 顾客编号 from 购买
where 商品编号='M08';
                 
                   
--(4)检索至少定购商品号为‘M01’和‘M08’的顾客号。(用自表连接方法)
select x.顾客编号 from 购买 x ,购买 y
where x.顾客编号=y.顾客编号 and x.商品编号='M01' and y.商品编号='M08';

--(5)检索没定购商品的顾客号和顾客名。
select 顾客编号,顾客姓名 from 顾客
where 顾客编号 not in (select 顾客编号 from 购买);

--(6)检索一次定购商品号‘M01’商品数量最多的顾客号和顾客名。
select 顾客编号,顾客姓名 from 顾客
where 顾客编号  in (select 顾客编号 from 购买
                    where 购买数量=(select MAX(购买数量) from 购买
                                    where 商品编号='M01') and
                    商品编号='M01');

--(7)检索‘东城’顾客的人数。
select COUNT(*) as 东城顾客数
from 顾客
where 顾客地址='东城';

--(8)检索至少订购了1种商品的顾客数。
select COUNT(distinct 顾客编号) as 顾客数
from 购买;

--(9)检索订购了商品的人次数。
select COUNT(*) as 顾客数
from 购买;


--(10)检索顾客Dennis订购商品的总数量及每次购买最多数量和最少数量之差。  
select sum(购买数量) as 购买总数, MAX(购买数量)-MIN(购买数量) 购买差额 from 购买,顾客
where 购买.顾客编号 = 顾客.顾客编号 and
      顾客姓名='Dennis';
      
--(11)检索至少订购了3单商品的顾客号和顾客名及他们定购的商品次数和商品总数量，并按商品总数量降序排序。
select 顾客.顾客编号,顾客.顾客姓名,COUNT(*) as 定购次数, SUM(购买数量) as 商品总数量 from 顾客,购买
where 顾客.顾客编号=购买.顾客编号
group by 顾客.顾客编号,顾客.顾客姓名
having COUNT(*)>=3
order by 商品总数量 desc;


--(13)创建一个视图GM，字段包括：顾客号，顾客名和定购的商品名，金额（金额=数量*单价）。指定用内连接方式做。
go
create view GM as
select 顾客.顾客编号,顾客姓名,商品名称,购买数量*价格 as 金额 
from  (顾客 inner join 购买 on 购买.顾客编号=顾客.顾客编号)inner join 商品 on 购买.商品编号=商品.商品编号

--(14)检索购买的商品的单价至少有一次高于或等于5的顾客号和顾客名。  
select distinct 顾客.顾客编号,顾客姓名 
from (顾客 inner join 购买 on 购买.顾客编号=顾客.顾客编号)inner join 商品 on 购买.商品编号=商品.商品编号
where 价格>=5;

--(15)检索购买的购买价都高于或等于5的顾客号和顾客名。
select 顾客编号,顾客姓名 from 顾客
where 顾客编号 not in (select distinct 顾客编号 from 购买,商品
                       where 购买.商品编号=商品.商品编号 and
                              商品.价格<5)
      and 顾客编号 in (select 顾客编号 from 购买);
--(16)检索‘东城’顾客购买的商品号，商品名和数量合计。
select 购买.商品编号,商品.商品名称,SUM(购买.购买数量) as 数量合计 
from 顾客,购买,商品
where 顾客.顾客编号=购买.顾客编号  and 购买.商品编号=商品.商品编号  and
      顾客.顾客地址='东城'
group by  购买.商品编号,商品.商品名称;

--(17)检索所有的顾客号和顾客名以及它们所购买的商品号。（包括没买商品的顾客）

select 顾客.顾客编号,顾客.顾客姓名,购买.商品编号 
from 顾客 left outer join 购买 on (顾客.顾客编号=购买.顾客编号);

--(18)降低已售出的数量总合超过10件的商品单价为原价的95%。
update 商品 set 价格=价格*0.95
where 商品编号 in (select 商品编号 from 购买
                   group by 商品编号
                   having SUM(购买数量)>=10);
								