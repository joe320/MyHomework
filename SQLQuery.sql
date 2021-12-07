create database S_T on primary
(
name='S_T',
filename='D:\AAAA\db\S_T.mdf',
size=5mb,
maxsize=100mb,
filegrowth=5%
)
log on
(
name='S_T_log',
filename='D:\AAAA\db\S_T_log.ldf',
size=2mb,
filegrowth=1mb
)
use S_T
go
create table Student
(Sno char(9) primary key,
Sname char(20) unique,
Ssex char(2),
Sage int,
Sdept char(20)
);
go
create table Course
(Cno char(4) primary key,
Cname char(40) not null,
Cpno char(4),
Ccredit int,
foreign key(Cpno) references Course(Cno)
);
go
create table SC
(Sno char(9),
Cno char(4),
Grade int,
primary key(Sno,Cno),
foreign key(Sno) references Student(Sno),
foreign key(Cno) references Course(Cno)
);
go
alter table Student add S_entrance date;
go
alter table Student drop column S_entrance;
go
alter table Course add unique(Cname);
go
create unique index Stusno on Student(Sno);
create unique index Coucno on Course(Cno);
create unique index SCno on SC(Sno ASC,Cno DESC);
go
insert into Student values('200215121','����','��','20','CS');
insert into Student values('200215122','����','Ů','19','CS');
insert into Student values('200215123','����','Ů','18','MA');
insert into Student values('200215124','����','��','19','IS');
go
update Student set Sno=200215125 where Sno='200215124';
go
insert into Course(Cno,Cname,Ccredit) values('2','��ѧ','2');
insert into Course(Cno,Cname,Ccredit) values('6','���ݴ���','2');
insert into Course values('7','PASCAL����','6','4');
insert into Course values('5','���ݽṹ','7','4');
insert into Course values('1','���ݿ�','5','4');
insert into Course values('3','��Ϣϵͳ','1','4');
insert into Course values('4','����ϵͳ','6','3');
go
insert into SC values('200215121','1','92');
insert into SC values('200215121','2','85');
insert into SC values('200215121','3','88');
insert into SC values('200215122','2','90');
insert into SC values('200215122','3','80');
go
--1.��ѯȫ��ѧ����ѧ�ź�����
select Sno,Sname from Student;
--2.��ѯȫ��ѧ����������ѧ�š�����ϵ
select Sname,Sno,Sdept from Student;
--3.��ѯȫ��ѧ������ϸ��¼
select * from Student;
--4.��ѯȫ��ѧ�����������������ݣ��Գ�������и�����ΪBirthYear��
select Sname,2021-Sage BirthYear from Student;
--5.��ѯȫ��ѧ����������������ݺ�����Ժϵ��Ҫ����Сд��ĸ��ʾ����ϵ��
select Sname,2021-Sage BirthYear,LOWER(Sdept) Department from Student;
--6.��ѯѡ���˿γ̵�ѧ��ѧ��
select distinct Sno from SC;
--7.��ѯ�������ѧϵȫ��ѧ��������
select Sname from Student where Sdept='CS';
--8.��ѯ����������20�����µ�ѧ����������������
select Sname,Sage from Student where Sage<20;
--9.��ѯ���Գɼ��в������ѧ����ѧ��
select distinct Sno from SC where Grade<60;
--10.��ѯ������20��30��֮�䣨����20���30�꣩��ѧ��������ϵ�������
select Sname,Sdept,Sage from Student where Sage between 20 and 30;
--11.��ѯ���䲻��20��30��֮���ѧ��������ϵ�������
select Sname,Sdept,Sage from Student where Sage not between 20 and 30;
--12.��ѯ�������ѧϵ����ѧϵ����Ϣϵѧ�����������Ա�
select Sname,Ssex from Student where Sdept in ('CS','MA','IS');
--13.��ѯ�Ȳ��Ǽ������ѧϵ����ѧϵ��Ҳ������Ϣϵ��ѧ�����������Ա�
select Sname,Ssex from Student where Sdept not in ('CS','MA','IS');
--14.��ѯѧ��Ϊ200215121��ѧ������ϸ���
select * from Student where Sno='200215121';
--15.��ѯ����������ѧ����������ѧ�ź��Ա�
select Sname,Sno,Ssex from Student where Sname like '��%';
--16.��ѯ�ա�ŷ������ȫ��Ϊ3�����ֵ�ѧ��������
select Sname from Student where Sname like 'ŷ��_';
--17.��ѯ�����еڶ�����Ϊ�������ֵ�ѧ����������ѧ��
select Sname,Sno from Student where Sname like '_��%';
--18.��ѯ���в�������ѧ������
select Sname,Sno,Ssex from Student where Sname not like '��%';
--19.��ѯDB_Design�γ̵Ŀγ̺ź�ѧ��
select Cno,Ccredit from Course where Cname like 'DB\_Design' escape '\';
--20.��ѯ�ԡ�DB_����ͷ���ҵ����������ַ�Ϊi�Ŀγ̵���ϸ���
select * from Course where Cname like 'DB\_%i__' escape '\';
--21.��ѯȱ�ٳɼ���ѧ����ѧ�ź���Ӧ�Ŀγ̺�
select Sno,Cno from SC where Grade is null;
--22.��ѯ�����гɼ���ѧ��ѧ�źͿγ̺�
select Sno,Cno from SC where Grade is not null;
--23.��ѯ�������ѧϵ������20�����µ�ѧ������
select Sname from Student where Sdept='CS' and Sage<20;
--24.��ѯѡ����3�ſγ̵�ѧ����ѧ�ż���ɼ�����ѯ����������Ľ�������
select Sno,Grade from SC where Cno='3' order by Grade desc;
--25.��ѯȫ��ѧ���������ѯ���������ϵ��ϵ���������У�ͬһϵ�е�ѧ�������併������
select * from Student order by Sdept,Sage desc;
--26.��ѯѧ��������
select COUNT(*) from Student;
--27.��ѯѡ���˿γ̵�ѧ������
select COUNT(distinct Sno) from SC;
--28.����1�ſγ̵�ѧ��ƽ���ɼ�
select AVG(Grade) from SC where Cno='1';
--29.��ѯѡ����1�ſγ̵�ѧ����߷�
select MAX(Grade) from SC where Cno='1';
--30.��ѯѧ��200215122ѡ�޿γ̵���ѧ����
select SUM(Ccredit) from SC,Course where Sno='200215122' and SC.Cno=Course.Cno;
--31.������γ̺ż���Ӧ��ѡ������
select Cno,COUNT(Sno) from SC group by Cno;
--32.��ѯѡ����3�ſ����Ͽγ̵�ѧ��ѧ��
select Sno from SC group by Sno having COUNT(*)>3;
--33.��ѯÿ��ѧ������ѡ�޿γ̵����
select Student.*,SC.* from Student,SC where Student.Sno=SC.Sno;
--34.��33������Ȼ�������
select Student.Sno,Sname,Ssex,Sage,Sdept,Cno,Grade from Student,SC where Student.Sno=SC.Sno;
--35.��ѯÿһ�ſεļ�����޿�
select first.Cno,second.Cpno from Course first,Course second where first.Cpno=second.Cno;
--36.�������Ӳ�ѯÿ��ѧ������ѡ�����
select Student.Sno,Sname,Ssex,Sage,Sdept,Cno,Grade from Student left outer join SC on (Student.Sno=SC.Sno);
--37.��ѯѡ��2�ſγ��ҳɼ���90�����ϵ�����ѧ��
select Student.Sno,Sname from Student,SC where Student.Sno=SC.Sno and SC.Cno='2' and SC.Grade>90;
--38.��ѯÿ��ѧ����ѧ�š�������ѡ�޵Ŀγ̼��ɼ�
select Student.Sno,Sname,Cname,Grade from Student,SC,Course where Student.Sno=SC.Sno and SC.Cno=Course.Cno;
--39.��ѯ�롰��������ͬһ��ϵѧϰ��ѧ��
select Sno,Sname,Sdept from Student where Sdept in(select Sdept from Student where Sname='����');
--40.��ѯѡ���˿γ���Ϊ����Ϣϵͳ����ѧ��ѧ�ź�����
select Student.Sno,Sname from Student,SC,Course where Student.Sno=SC.Sno and SC.Cno=Course.Cno and Course.Cname='��Ϣϵͳ';
--41.�ҳ�ÿ��ѧ��������ѡ�޿γ�ƽ���ɼ��Ŀγ̺�
select Sno,Cno from SC x where Grade>=(select AVG(Grade) from SC y where y.Sno=x.Sno);
--42.��ѯ����ϵ�бȼ����ϵĳһѧ������С��ѧ������������
select Sname,Sage from Student where Sage<any (select Sage from Student where Sdept='CS') and Sdept <> 'CS';
--43.��ѯ����ϵ�бȼ������ѧϵ����ѧ�����䶼С��ѧ������������
select Sname,Sage from Student where Sage<all (select Sage from Student where Sdept='CS') and Sdept <> 'CS';
--44.��ѯ����ѡ����1�ſγ̵�ѧ������
select Sname from Student where exists (select * from SC where Sno=Student.Sno and Cno='1');
--45.��ѯû��ѡ��1�ſγ̵�ѧ������
select Sname from Student where not exists (select * from SC where Sno=Student.Sno and Cno='1');
--46.��ѯѡ����ȫ���γ̵�ѧ������
select Sname from Student where not exists (select * from Course where not exists (select * from SC where Sno=Student.Sno and Cno=Course.Cno));
--47.��ѯ����ѡ����ѧ��200215122ѡ�޵�ȫ���γ̵�ѧ������
select distinct Sno from SC SCX where not exists (select * from SC SCY where SCY.Sno='200215122' and not exists (select * from SC SCZ where SCZ.Sno=SCX.Sno and SCZ.Cno=SCY.Cno));
--48.��ѯ�������ѧϵ��ѧ�������䲻����19���ѧ��
select * from Student where Sdept='CS' union select * from Student where Sage<=19;
--49.��ѯѡ���˿γ�1����ѡ���˿γ�2��ѧ��
select Sno from SC where Cno='1' union select Sno from SC where Cno='2';
--50.��ѯ�������ѧϵ��ѧ�������䲻����19���ѧ���Ľ���
select * from Student where Sdept='CS' intersect select * from Student where Sage<=19;
--51.��ѯ��ѡ���˿γ�1��ѡ���˿γ�2��ѧ��
select Sno from SC where Cno='1' intersect select Sno from SC where Cno='2';
--52.��ѯ�������ѧϵ��ѧ�������䲻����19���ѧ���Ĳ
select Sno from SC where Cno='1' and Sno in (select Sno from SC where Cno='2');
--53.����һ��ѡ�μ�¼����200212128��,��1����
insert into SC(Sno,Cno) values('200212128','1');
--54.��ѧ��200215121�������Ϊ22��
update Student set Sage=22 where Sno='200215121';
--55.������ѧ������������1��

/*
56.���������ѧϵȫ��ѧ���ĳɼ���Ϊ��
57.ɾ�����е�ѧ����ѡ�μ�¼
58.ɾ���������ѧϵ����ѧ����ѡ�μ�¼
59.������Ϣϵѧ������ͼ
60.������Ϣϵѧ����ͼ����Ҫ������޸ĺͲ������ʱ����Ҫ��֤����ͼֻ����Ϣϵ��ѧ��
61.������Ϣϵѡ����1�ſγ̵�ѧ������ͼ
62.������Ϣϵѡ����1�ſγ��ҳɼ���90�����ϵ�ѧ������ͼ
63.����һ����ӳѧ��������ݵ���ͼ
64.��ѧ����ѧ�ż�����ƽ���ɼ�����Ϊһ����ͼ
65.��student��������Ů����¼����Ϊһ����ͼ
66.����Ϣϵѧ������ͼ���ҳ�����С��20���ѧ��
67.��ѯѡ����1�ſγ̵���Ϣϵѧ��������ͼ�Ͷ�����ӷֱ�ʵ�֣�
68.����64�����ͼ��ѯƽ���ɼ���90�����ϵ�ѧ��ѧ�ź�ƽ���ɼ�
69.����Ϣϵѧ����ͼ�е�ѧ��Ϊ200215122��ѧ��������Ϊ��������
70.����Ϣϵѧ����ͼ�в���һ���µ�ѧ����¼������ѧ��Ϊ200215129������Ϊ���£�����Ϊ20��
71.ɾ����Ϣϵѧ����ͼ��ѧ��Ϊ200215129�ļ�¼
*/