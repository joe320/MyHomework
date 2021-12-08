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
insert into Student values('200215121','李勇','男','20','CS');
insert into Student values('200215122','刘晨','女','19','CS');
insert into Student values('200215123','王敏','女','18','MA');
insert into Student values('200215124','张立','男','19','IS');
go
update Student set Sno=200215125 where Sno='200215124';
go
insert into Course(Cno,Cname,Ccredit) values('2','数学','2');
insert into Course(Cno,Cname,Ccredit) values('6','数据处理','2');
insert into Course values('7','PASCAL语言','6','4');
insert into Course values('5','数据结构','7','4');
insert into Course values('1','数据库','5','4');
insert into Course values('3','信息系统','1','4');
insert into Course values('4','操作系统','6','3');
go
insert into SC values('200215121','1','92');
insert into SC values('200215121','2','85');
insert into SC values('200215121','3','88');
insert into SC values('200215122','2','90');
insert into SC values('200215122','3','80');
go
--1.查询全体学生的学号和姓名
select Sno,Sname from Student;
--2.查询全体学生的姓名、学号、所在系
select Sname,Sno,Sdept from Student;
--3.查询全体学生的详细记录
select * from Student;
--4.查询全体学生的姓名及其出生年份（对出生年份列赋别名为BirthYear）
select Sname,2021-Sage BirthYear from Student;
--5.查询全体学生的姓名、出生年份和所在院系，要求用小写字母表示所有系名
select Sname,2021-Sage BirthYear,LOWER(Sdept) Department from Student;
--6.查询选修了课程的学生学号
select distinct Sno from SC;
--7.查询计算机科学系全体学生的名单
select Sname from Student where Sdept='CS';
--8.查询所有年龄在20岁以下的学生的姓名及其年龄
select Sname,Sage from Student where Sage<20;
--9.查询考试成绩有不及格的学生的学号
select distinct Sno from SC where Grade<60;
--10.查询年龄在20～30岁之间（包括20随和30岁）的学生姓名、系别和年龄
select Sname,Sdept,Sage from Student where Sage between 20 and 30;
--11.查询年龄不在20～30岁之间的学生姓名、系别和年龄
select Sname,Sdept,Sage from Student where Sage not between 20 and 30;
--12.查询计算机科学系、数学系和信息系学生的姓名和性别
select Sname,Ssex from Student where Sdept in ('CS','MA','IS');
--13.查询既不是计算机科学系、数学系，也不是信息系的学生的姓名和性别
select Sname,Ssex from Student where Sdept not in ('CS','MA','IS');
--14.查询学号为200215121的学生的详细情况
select * from Student where Sno='200215121';
--15.查询所有姓刘的学生的姓名、学号和性别
select Sname,Sno,Ssex from Student where Sname like '刘%';
--16.查询姓“欧阳”且全名为3个汉字的学生的姓名
select Sname from Student where Sname like '欧阳_';
--17.查询名字中第二个字为“阳”字的学生的姓名和学号
select Sname,Sno from Student where Sname like '_阳%';
--18.查询所有不姓刘的学生姓名
select Sname,Sno,Ssex from Student where Sname not like '刘%';
--19.查询DB_Design课程的课程号和学分
select Cno,Ccredit from Course where Cname like 'DB\_Design' escape '\';
--20.查询以“DB_”开头，且倒数第三个字符为i的课程的详细情况
select * from Course where Cname like 'DB\_%i__' escape '\';
--21.查询缺少成绩的学生的学号和相应的课程号
select Sno,Cno from SC where Grade is null;
--22.查询所有有成绩的学生学号和课程号
select Sno,Cno from SC where Grade is not null;
--23.查询计算机科学系年龄在20岁以下的学生姓名
select Sname from Student where Sdept='CS' and Sage<20;
--24.查询选修了3号课程的学生的学号及其成绩，查询结果按分数的降序排列
select Sno,Grade from SC where Cno='3' order by Grade desc;
--25.查询全体学生情况，查询结果按所在系的系号升序配列，同一系中的学生按年龄降序排列
select * from Student order by Sdept,Sage desc;
--26.查询学生总人数
select COUNT(*) from Student;
--27.查询选修了课程的学生人数
select COUNT(distinct Sno) from SC;
--28.计算1号课程的学生平均成绩
select AVG(Grade) from SC where Cno='1';
--29.查询选修了1号课程的学生最高分
select MAX(Grade) from SC where Cno='1';
--30.查询学生200215122选修课程的总学分数
select SUM(Ccredit) from SC,Course where Sno='200215122' and SC.Cno=Course.Cno;
--31.求各个课程号及相应的选课人数
select Cno,COUNT(Sno) from SC group by Cno;
--32.查询选修了3门课以上课程的学生学号
select Sno from SC group by Sno having COUNT(*)>3;
--33.查询每个学生及其选修课程的情况
select Student.*,SC.* from Student,SC where Student.Sno=SC.Sno;
--34.对33题用自然连接完成
select Student.Sno,Sname,Ssex,Sage,Sdept,Cno,Grade from Student,SC where Student.Sno=SC.Sno;
--35.查询每一门课的间接先修课
select first.Cno,second.Cpno from Course first,Course second where first.Cpno=second.Cno;
--36.用外连接查询每个学生及其选课情况
select Student.Sno,Sname,Ssex,Sage,Sdept,Cno,Grade from Student left outer join SC on (Student.Sno=SC.Sno);
--37.查询选修2号课程且成绩在90分以上的所有学生
select Student.Sno,Sname from Student,SC where Student.Sno=SC.Sno and SC.Cno='2' and SC.Grade>90;
--38.查询每个学生的学号、姓名、选修的课程及成绩
select Student.Sno,Sname,Cname,Grade from Student,SC,Course where Student.Sno=SC.Sno and SC.Cno=Course.Cno;
--39.查询与“刘晨”在同一个系学习的学生
select Sno,Sname,Sdept from Student where Sdept in(select Sdept from Student where Sname='刘晨');
--40.查询选修了课程名为“信息系统”的学生学号和姓名
select Student.Sno,Sname from Student,SC,Course where Student.Sno=SC.Sno and SC.Cno=Course.Cno and Course.Cname='信息系统';
--41.找出每个学生超过他选修课程平均成绩的课程号
select Sno,Cno from SC x where Grade>=(select AVG(Grade) from SC y where y.Sno=x.Sno);
--42.查询其他系中比计算机系某一学生年龄小的学生姓名和年龄
select Sname,Sage from Student where Sage<any (select Sage from Student where Sdept='CS') and Sdept <> 'CS';
--43.查询其他系中比计算机科学系所有学生年龄都小的学生姓名及年龄
select Sname,Sage from Student where Sage<all (select Sage from Student where Sdept='CS') and Sdept <> 'CS';
--44.查询所有选修了1号课程的学生姓名
select Sname from Student where exists (select * from SC where Sno=Student.Sno and Cno='1');
--45.查询没有选修1号课程的学生姓名
select Sname from Student where not exists (select * from SC where Sno=Student.Sno and Cno='1');
--46.查询选修了全部课程的学生姓名
select Sname from Student where not exists (select * from Course where not exists (select * from SC where Sno=Student.Sno and Cno=Course.Cno));
--47.查询至少选修了学生200215122选修的全部课程的学生号码
select distinct Sno from SC SCX where not exists (select * from SC SCY where SCY.Sno='200215122' and not exists (select * from SC SCZ where SCZ.Sno=SCX.Sno and SCZ.Cno=SCY.Cno));
--48.查询计算机科学系的学生及年龄不大于19岁的学生
select * from Student where Sdept='CS' union select * from Student where Sage<=19;
--49.查询选修了课程1或者选修了课程2的学生
select Sno from SC where Cno='1' union select Sno from SC where Cno='2';
--50.查询计算机科学系的学生与年龄不大于19岁的学生的交集
select * from Student where Sdept='CS' intersect select * from Student where Sage<=19;
--51.查询既选修了课程1又选修了课程2的学生
select Sno from SC where Cno='1' intersect select Sno from SC where Cno='2';
--52.查询计算机科学系的学生与年龄不大于19岁的学生的差集
select Sno from SC where Cno='1' and Sno in (select Sno from SC where Cno='2');
--53.插入一条选课记录（’200212128’,’1’）
insert into SC(Sno,Cno) values('200212128','1');
--54.将学生200215121的年龄改为22岁
update Student set Sage=22 where Sno='200215121';
--55.将所有学生的年龄增加1岁
update Student set Sage=Sage+1;
--56.将计算机科学系全体学生的成绩置为零
update SC set Grade=0 where Sno in (select Sno from Student where Sdept='CS');
--57.删除所有的学生的选课记录
delete from SC;
--58.删除计算机科学系所有学生的选课记录
delete from SC where Sno in (select Sno from Student where Sdept='CS');
--59.建立信息系学生的视图
create view IS_Student as select Sno,Sname,Sage from Student where Sdept='IS';
--60.建立信息系学生视图，并要求进行修改和插入操作时仍需要保证该视图只有信息系的学生
create view IS_Student as select Sno,Sname,Sage from Student where Sdept='IS' with check option;
--61.建立信息系选修了1号课程的学生的视图
create view IS_S1(Sno,Sname,Grade) as select Student.Sno,Sname,Grade from Student,SC where Sdept='IS' and Student.Sno=SC.Sno and SC.Cno='1';
--62.建立信息系选修了1号课程且成绩在90分以上的学生的视图
create view IS_S2 as select Sno,Sname,Grade from IS_S1 where Grade>=90;
--63.定义一个反映学生出生年份的视图
create view BT_S(Sno,Sname,Sbirth) as select Sno,Sname,2014-Sage from Student;
--64.将学生的学号及他的平均成绩定义为一个视图
create view S_G(Sno,Gavg) as select Sno,AVG(Grade) from SC group by Sno;
--65.将student表中所有女生记录定义为一个视图
create view F_Student(F_sno,name,sex,age,dept) as select * from Student where Ssex='女';
--66.在信息系学生的视图中找出年龄小于20岁的学生
select Sno,Sage from IS_Student where Sage<20;
--67.查询选修了1号课程的信息系学生（用视图和多表连接分别实现）
select IS_Student.Sno,Sname from IS_Student,SC where IS_Student.Sno=SC.Sno and SC.Cno='1';
--68.利用64题的视图查询平均成绩在90分以上的学生学号和平均成绩
select * from S_G where Gavg>=90;
--69.将信息系学生视图中的学号为200215122的学生姓名改为“刘辰”
update IS_Student set Sname='刘辰' where Sno='200215122';
--70.向信息系学生视图中插入一个新的学生记录，其中学号为200215129，姓名为赵新，年龄为20岁
insert into IS_Student values('200215129','赵新','20');
--71.删除信息系学生视图中学号为200215129的记录
delete from IS_Student where Sno='200215129';
