                  --04:COLLEGE DATABASE
                                       
        --_____________TABLE CREATION____________   

    
create table student
(usn varchar(15), sname varchar(50),address varchar(50),phone varchar(10),gender char,
constraint pkystudent primary key (usn))engine='innodb';

create table semsec
(ssid int,sem int, section char,
constraint pkysection primary key (ssid))engine='innodb';

create table class
(usn varchar(15),ssid int,
constraint pkyclass primary key (usn),
constraint fkyclass1 foreign key (ssid) references semsec (ssid),
constraint fkyclass2 foreign key (usn) references student (usn))engine='innodb';

create table subject
(subcode varchar(10),title varchar(35),sem int, credits int,  
constraint pkysubject primary key (subcode))engine='innodb';

create table iamarks
(usn varchar(15),subcode varchar(10),ssid int,test1 int,test2 int,test3 int,finalia int,
constraint pkyiamarks primary key (usn,subcode,ssid),
constraint fkyiamarks1 foreign key (usn) references student (usn),
constraint fkyiamarks2 foreign key (subcode) references subject (subcode),
constraint fkyiamarks3 foreign key (ssid) references semsec (ssid))engine='innodb';

   
-- _________________INSERTING VALUES___________________


insert into student values('4NN15CS001','Ankitha','Vijayanagar','9880067777','f');
insert into student values('4NN15CS002','Anil','Vijayanagar','9880067778','m');
insert into student values('4NN15CS003','Deepika','Jayanagar','9880067779','f');
insert into student values('4NN15CS004','Rajesh','Kuvempunagar','9880067775','m');
insert into student values('4NN15CS005','Sanvi','Srinagar','9880067774','f');
insert into student values('4NN15CS006','Shravya','Yadavgiri','9880067773','f');
insert into student values('4NN15CS007','Shruthi','Yadavgiri','9880067772','f');
insert into student values('4NN15CS008','Mahesh','Yadavgiri','9880067771','m');
insert into student values('4NN15CS009','Amit','Jayanagar','9880067770','m');
insert into student values('4NN15CS010','Aditya','Jayanagar','9880067771','m');


insert into semsec values(11,4,'A');
insert into semsec values(12,4,'B');
insert into semsec values(13,4,'C');
insert into semsec values(14,8,'A');
insert into semsec values(15,8,'C');
insert into semsec values(16,8,'B');


insert into class values('4NN15CS001',11);
insert into class values('4NN15CS002',13);
insert into class values('4NN15CS003',15);
insert into class values('4NN15CS004',14);
insert into class values('4NN15CS005',15);
insert into class values('4NN15CS006',16);
insert into class values('4NN15CS007',11);
insert into class values('4NN15CS008',11);
insert into class values('4NN15CS009',14);
insert into class values('4NN15CS010',13);



insert into subject values('15CS41','Maths',4,4);
insert into subject values('15CS42','USP',4,4);
insert into subject values('15CS43','DMS',4,4);
insert into subject values('15CS61','SMS',8,3);
insert into subject values('15CS62','INS',8,3);
insert into subject values('15CS63','aDHOC',8,3);
insert into subject values('15CS81','SMS',8,3);
insert into subject values('15CS82','INS',8,3);
insert into subject values('15CS83','aDHOC',8,3);

insert into iamarks values('4NN15CS001','15CS41',11,14,15,16,null);
insert into iamarks values('4NN15CS001','15CS42',11,13,15,16,null);
insert into iamarks values('4NN15CS001','15CS43',11,14,20,16,null);

insert into iamarks values('4NN15CS002','15CS41',13,14,15,16,null);
insert into iamarks values('4NN15CS002','15CS42',13,14,18,16,null);
insert into iamarks values('4NN15CS002','15CS43',13,14,15,17,null);

insert into iamarks values('4NN15CS003','15CS81',15,14,15,16,null);
insert into iamarks values('4NN15CS003','15CS82',15,15,16,16,null);
insert into iamarks values('4NN15CS003','15CS83',15,18,15,16,null);

insert into iamarks values('4NN15CS004','15CS81',14,16,15,16,null);
insert into iamarks values('4NN15CS004','15CS82',14,17,17,16,null);
insert into iamarks values('4NN15CS004','15CS83',14,18,15,20,null);

insert into iamarks values('4NN15CS005','15CS81',15,14,15,16,null);
insert into iamarks values('4NN15CS005','15CS82',15,17,14,16,null);
insert into iamarks values('4NN15CS005','15CS83',15,19,15,20,null);

insert into iamarks values('4NN15CS006','15CS81',16,19,15,14,null);
insert into iamarks values('4NN15CS006','15CS82',16,17,18,16,null);
insert into iamarks values('4NN15CS006','15CS83',16,19,12,20,null);

insert into iamarks values('4NN15CS007','15CS41',11,16,15,16,null);
insert into iamarks values('4NN15CS007','15CS42',11,12,15,16,null);
insert into iamarks values('4NN15CS007','15CS43',11,14,20,16,null);

insert into iamarks values('4NN15CS008','15CS41',11,16,15,16,null);
insert into iamarks values('4NN15CS008','15CS42',11,13,15,16,null);
insert into iamarks values('4NN15CS008','15CS43',11,18,20,16,null);

insert into iamarks values('4NN15CS009','15CS81',14,15,15,16,null);
insert into iamarks values('4NN15CS009','15CS82',14,17,17,18,null);
insert into iamarks values('4NN15CS009','15CS83',14,18,14,20,null);

insert into iamarks values('4NN15CS010','15CS41',13,14,15,16,null);
insert into iamarks values('4NN15CS010','15CS42',13,14,18,16,null);
insert into iamarks values('4NN15CS010','15CS43',13,14,15,17,null);


          --             __________________query_________________________

--1) List all the student details studying in fourth semester ‘C’ section. 

----------------Using natural join----------------------------------
--(i)
select * 
  from student natural join class natural join semsec
  where sem=4 and section='C';

--OR

--(ii)
select s.usn,sname,address,phone,gender,ss.ssid,sem,section 
   from student s,class c,semsec ss
   where s.usn=c.usn
   and c.ssid=ss.ssid
   and sem=4 and ss.section='C';


--2) Compute the total number of male and female students in each semester and in each section. 

  select gender,sem,section,count(*) as num_of_students 
  from student natural join class natural join semsec
  group by gender,sem,section;
  

--3) Create a view of Test1 marks of student USN ‘1BI15CS101’ in all subjects. 
  
--(i)
create view test1_marks as
  (select usn,subcode,title,test1 as test1_marks
   from iamarks natural join subject 
   where usn='4NN15CS001');

select * from test1_marks;

--OR

--(ii)
create view test1_marks as
  (select usn,s.subcode,title,test1 as test1_marks
   from iamarks i,subject s
   where i.subcode=s.subcode
   and usn='4NN15CS001');

select * from test1_marks;

--4) Calculate the FinalIA (average of best two test marks) and update the corresponding table for all students.  

---Using Stored Procedure

delimiter $$
drop procedure if exists avgmarks $$
create procedure avgmarks()
begin
declare avgmarks float default 0.0;
declare finished int default 0;
declare student_usn varchar(15);
declare student_subcode varchar(10);
declare avgmarks_cursor cursor for
select usn,subcode,((test1+test2+test3)-least(test1,test2,test3))/2 as avg from iamarks;
declare continue handler
for not found set finished=1;
open avgmarks_cursor;
get_avgmarks: loop
fetch avgmarks_cursor into student_usn ,student_subcode,avgmarks ;
if finished=1 then
leave get_avgmarks;
else
 update iamarks set finalia= avgmarks where usn = student_usn and subcode=student_subcode;
end if;
end loop get_avgmarks;
close avgmarks_cursor ;
end$$
delimiter ;	

----To call the stored procedure-------------------

Call avgmarks();

Select * from iamarks;


------stored procedure with comment lines-------
--change the delimiter to $$
delimiter $$

--drop the procedure if it already exists
drop procedure if exists avgmarks $$

--create the stored procedure avgmarks
create procedure avgmarks()
begin

declare avgmarks float default 0.0;
declare finished int default 0;
declare student_usn varchar(15);
declare student_subcode varchar(10);

--declare cursor for computing average marks
declare avgmarks_cursor cursor for
select usn,subcode,((test1+test2+test3)-least(test1,test2,test3))/2 as avg from iamarks;

--declare not found handler
declare continue handler
for not found set finished=1;

--open cursor
open avgmarks_cursor;

--loop through the resultset
get_avgmarks: loop

--iterate through the rows of the resultset
fetch avgmarks_cursor into student_usn ,student_subcode,avgmarks ;

--if no more rows, then exit from the loop
if finished=1 then
leave get_avgmarks;

--otherwise update the finalia
else
 update iamarks set finalia= avgmarks where usn = student_usn and subcode=student_subcode;
end if;

end loop get_avgmarks;

--close the cursor
close avgmarks_cursor ;

--end of the procedure
end$$

--change the delimiter back to ;
delimiter ;


----To call the stored procedure-------------------

Call avgmarks();

Select * from iamarks;

--[OR]

------------------------Without using stored  procedure-------------------

update iamarks set finalia=(select ((test1+test2+test3)-least(test1,test2,test3))/2 from iamarks);

--5) 
Categorize students based on the following criterion: 
If FinalIA = 17 to 20 then CAT = ‘Outstanding’ 
If FinalIA = 12 to 16 then CAT = ‘Average’ 
If FinalIA< 12 then CAT = ‘Weak’ 
Give these details only for 8th semester A, B, and C section students. 

select  s.usn,s.sname,s.address,s.phone,s.gender,
(case
when ia.finalia between 17 and 20 then 'OUTSTANDING'
when ia.finalia between 12 and 16 then 'AVERAGE'
else 'WEAK'
end) as category
from student s, semsec ss, iamarks ia, subject sub
where s.usn = ia.usn and
ss.ssid = ia.ssid and
sub.subcode = ia.subcode and
sub.sem = 8;

