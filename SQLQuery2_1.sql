create database ��Ʒ
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
use ��Ʒ
go
create table ��Ʒ
(
��Ʒ��� char(3) primary key,
��Ʒ���� char(20) not null,
�۸� numeric(8,2)check(�۸� between 0 and 20),
��Ʒ���� char(10),
��Ʒ������ char(12)
)
create table �˿�
(
�˿ͱ�� char(10)primary key,
�˿����� char(12)not null,
�˿͵�ַ varchar(50)
)
create table ����
(
��Ʒ��� char(3),
�˿ͱ�� char(10),
�������� int,
primary key(��Ʒ���,�˿ͱ��),
foreign key(��Ʒ���) references ��Ʒ(��Ʒ���),
foreign key(�˿ͱ��) references �˿�(�˿ͱ��)
)

insert into ��Ʒ
values
('M01','�ѽ�ʿ',8.00,'����','����'),
('M02','��¶��',6.50,'����','����'),
('M03','��ŵ',5.00,'����','��������'),
('M04','�����',3.00,'����','����'),
('M05','��ʿ��',5.00,'����','��������'),
('M06','����',2.50,'ϴ�·�','�ɰ�˹'),
('M07','�л�',3.50,'����','��������'),
('M08','̭��',3.00,'ϴ�·�','����'),
('M09','����',4.00,'ϴ�·�','����');

insert into �˿�
values
('C01','Dennis','����'),
('C02','John','����'),
('C03','Tom','����'),
('C04','Jenny','����'),
('C05','Rick','����');

insert into ����(�˿ͱ��,��Ʒ���,��������)
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

--��1�������˹�Ӧ��"����"��Ʒ�����й˿ͣ�
use ��Ʒ
go
select distinct �˿�.�˿ͱ��,�˿�.�˿�����,�˿�.�˿͵�ַ from �˿�,����,��Ʒ
where ����.��Ʒ���=��Ʒ.��Ʒ��� and ����.�˿ͱ��=�˿�.�˿ͱ�� and
      ��Ʒ������='����';

select �˿ͱ��,�˿�����,�˿͵�ַ from �˿�
where �˿ͱ�� in (select �˿ͱ�� from ����
                   where ��Ʒ��� in (select ��Ʒ���  from ��Ʒ  
                                      where ��Ʒ������='����'));
                                      
select distinct �˿�.�˿ͱ��,�˿�.�˿�����,�˿�.�˿͵�ַ 
from (�˿� inner join ���� on ����.�˿ͱ��=�˿�.�˿ͱ��)inner join ��Ʒ on ����.��Ʒ���=��Ʒ.��Ʒ���
where ��Ʒ������='����';
 

--��2�������й���ϴ�·���Ʒ�Ĺ˿͵�סַ��
select distinct �˿�.�˿͵�ַ from �˿�,����,��Ʒ
where ����.��Ʒ���=��Ʒ.��Ʒ��� and ����.�˿ͱ��=�˿�.�˿ͱ�� and
      ��Ʒ����='ϴ�·�';

--��3�������Ӧ���������������������������������
select ��Ʒ.��Ʒ������,SUM(��������) as ��������
from ����,��Ʒ
where ����.��Ʒ���=��Ʒ.��Ʒ��� and 
      ��Ʒ����='����'
group by ��Ʒ.��Ʒ������
order by �������� desc

--��4�������е�������Ʒ��������10%��
update ��Ʒ set �۸�=�۸�*1.1
where ��Ʒ����='����';

--��5�����δ�����������Ʒ
select * from ��Ʒ
where ��Ʒ��� not in (select ��Ʒ��� from ����);

--��6����Dennis������һ������Ʒ�Ĺ˿ͺš��˿���
select �˿ͱ��,�˿����� from �˿�
where �˿ͱ�� in  (select   �˿ͱ��  from  ���� 
                     where ��Ʒ��� in (select ��Ʒ��� from ����
                                         where �˿ͱ��=(select �˿ͱ�� from �˿�
                                                         where  �˿�����='Dennis')));
select distinct �˿�.�˿ͱ��,�˿�.�˿����� from �˿�,����
where ����.�˿ͱ��=�˿�.�˿ͱ�� and
      ��Ʒ��� in (select ��Ʒ��� from ����,�˿�
                  where ����.�˿ͱ��=�˿�.�˿ͱ�� and
                        �˿�����='Dennis');
                   


--(1)����������Ʒ��Ϊ��M01���Ĺ˿ͺź͹˿�����
select �˿ͱ��,�˿����� from �˿�
where �˿ͱ�� in (select �˿ͱ�� from ����
                   where ��Ʒ���='M01');
                   
--(2)����������Ʒ��Ϊ��M01����M02���Ĺ˿ͺš�
select �˿ͱ�� from �˿�
where �˿ͱ�� in (select �˿ͱ�� from ����
                   where ��Ʒ��� in ('M01','M02'));
                   
--(3)�������ٶ�����Ʒ��Ϊ��M01���͡�M08���Ĺ˿ͺš�(�ý��ķ���)  
select �˿ͱ�� from ����
where ��Ʒ���='M01'
intersect
select �˿ͱ�� from ����
where ��Ʒ���='M08';
                 
                   
--(4)�������ٶ�����Ʒ��Ϊ��M01���͡�M08���Ĺ˿ͺš�(���Ա����ӷ���)
select x.�˿ͱ�� from ���� x ,���� y
where x.�˿ͱ��=y.�˿ͱ�� and x.��Ʒ���='M01' and y.��Ʒ���='M08';

--(5)����û������Ʒ�Ĺ˿ͺź͹˿�����
select �˿ͱ��,�˿����� from �˿�
where �˿ͱ�� not in (select �˿ͱ�� from ����);

--(6)����һ�ζ�����Ʒ�š�M01����Ʒ�������Ĺ˿ͺź͹˿�����
select �˿ͱ��,�˿����� from �˿�
where �˿ͱ��  in (select �˿ͱ�� from ����
                    where ��������=(select MAX(��������) from ����
                                    where ��Ʒ���='M01') and
                    ��Ʒ���='M01');

--(7)���������ǡ��˿͵�������
select COUNT(*) as ���ǹ˿���
from �˿�
where �˿͵�ַ='����';

--(8)�������ٶ�����1����Ʒ�Ĺ˿�����
select COUNT(distinct �˿ͱ��) as �˿���
from ����;

--(9)������������Ʒ���˴�����
select COUNT(*) as �˿���
from ����;


--(10)�����˿�Dennis������Ʒ����������ÿ�ι��������������������֮�  
select sum(��������) as ��������, MAX(��������)-MIN(��������) ������ from ����,�˿�
where ����.�˿ͱ�� = �˿�.�˿ͱ�� and
      �˿�����='Dennis';
      
--(11)�������ٶ�����3����Ʒ�Ĺ˿ͺź͹˿��������Ƕ�������Ʒ��������Ʒ��������������Ʒ��������������
select �˿�.�˿ͱ��,�˿�.�˿�����,COUNT(*) as ��������, SUM(��������) as ��Ʒ������ from �˿�,����
where �˿�.�˿ͱ��=����.�˿ͱ��
group by �˿�.�˿ͱ��,�˿�.�˿�����
having COUNT(*)>=3
order by ��Ʒ������ desc;


--(13)����һ����ͼGM���ֶΰ������˿ͺţ��˿����Ͷ�������Ʒ���������=����*���ۣ���ָ���������ӷ�ʽ����
go
create view GM as
select �˿�.�˿ͱ��,�˿�����,��Ʒ����,��������*�۸� as ��� 
from  (�˿� inner join ���� on ����.�˿ͱ��=�˿�.�˿ͱ��)inner join ��Ʒ on ����.��Ʒ���=��Ʒ.��Ʒ���

--(14)�����������Ʒ�ĵ���������һ�θ��ڻ����5�Ĺ˿ͺź͹˿�����  
select distinct �˿�.�˿ͱ��,�˿����� 
from (�˿� inner join ���� on ����.�˿ͱ��=�˿�.�˿ͱ��)inner join ��Ʒ on ����.��Ʒ���=��Ʒ.��Ʒ���
where �۸�>=5;

--(15)��������Ĺ���۶����ڻ����5�Ĺ˿ͺź͹˿�����
select �˿ͱ��,�˿����� from �˿�
where �˿ͱ�� not in (select distinct �˿ͱ�� from ����,��Ʒ
                       where ����.��Ʒ���=��Ʒ.��Ʒ��� and
                              ��Ʒ.�۸�<5)
      and �˿ͱ�� in (select �˿ͱ�� from ����);
--(16)���������ǡ��˿͹������Ʒ�ţ���Ʒ���������ϼơ�
select ����.��Ʒ���,��Ʒ.��Ʒ����,SUM(����.��������) as �����ϼ� 
from �˿�,����,��Ʒ
where �˿�.�˿ͱ��=����.�˿ͱ��  and ����.��Ʒ���=��Ʒ.��Ʒ���  and
      �˿�.�˿͵�ַ='����'
group by  ����.��Ʒ���,��Ʒ.��Ʒ����;

--(17)�������еĹ˿ͺź͹˿����Լ��������������Ʒ�š�������û����Ʒ�Ĺ˿ͣ�

select �˿�.�˿ͱ��,�˿�.�˿�����,����.��Ʒ��� 
from �˿� left outer join ���� on (�˿�.�˿ͱ��=����.�˿ͱ��);

--(18)�������۳��������ܺϳ���10������Ʒ����Ϊԭ�۵�95%��
update ��Ʒ set �۸�=�۸�*0.95
where ��Ʒ��� in (select ��Ʒ��� from ����
                   group by ��Ʒ���
                   having SUM(��������)>=10);
								