						--05 : COMPANY DATABASE:

--DEPARTMENT:

create table department
( Dno int not NULL UNIQUE,
Dname varchar(35) not NULL,
 mgrssn int,
 mgrstartdate date not NULL,
 constraint pkydept primary key(Dno))engine='innodb';

--EMPLOYEE:

create table employee
(fname varchar(35) not NULL,
 minit varchar(35),
 lname varchar(35),
 ssn int not NULL UNIQUE,
 bdate date NOT NULL,
 Address varchar(35) not NULL,
 sex varchar(2) not NULL,
 salary int not NULL,
 superssn int,
 Dno int,
 constraint pkyemp primary key(ssn),
 constraint fkyemp foreign key(Dno) references department(Dno))engine='innodb';

--DLOCATION:

create table dlocation
(dno int NOT NULL,
 dloc varchar(35) NOT NULL,
 constraint pkydl primary key(dno,dloc),
 constraint fkydl foreign key(dno) references department(dno))engine='innodb';

--PROJECT:

create table project
(pname varchar(35) NOT NULL,
 pno int NOT NULL UNIQUE,
 plocation varchar(35) NOT NULL,
 dno int NOT NULL,
 constraint pkypt primary key(pno),
 constraint fkypt foreign key(dno) references department(dno))engine='innodb';

--WORKS_ON:

create table works_on
(ssn int NOT NULL,
 pno int NOT NULL,
 hours real NOT NULL,
 constraint pkywk primary key(ssn,pno),
 constraint fkywk foreign key(ssn) references employee(ssn),
 constraint fkywk1 foreign key(pno) references project(pno))engine='innodb';

--DEPENDENT:

create table dependent 
(essn int NOT NULL,
 dependent_name varchar(35) NOT NULL,
 sex varchar(2) NOT NULL,
 bdate date NOT NULL,
 relationship varchar(35) NOT NULL,
 constraint pkydp primary key(essn,dependent_name),
 constraint fkydp foreign key(essn) references employee(ssn))engine='innodb';



--ALTERING TABLES:
 
alter table employee add constraint fkyemp1 foreign key(superssn) references employee(ssn);

alter table department add constraint fkydept foreign key(mgrssn) references employee(ssn);


--INSERTING INTO TABLES:

--DEPARTMENT:


insert into department values(5,'Research',NULL,19880522);
insert into department values(4,'Administration',NULL,19950101);
insert into department values(1,'Headquaters',NULL,19810619);

select * from department;

--EMPLOYEE

insert into employee values('John','B','Smith',123456789,'1965-01-09','731 fondren,houston,tx','m',30000,NULL,5);
insert into employee values('Franklin','T','Wong',333445555,'1955-12-08','638 voss,houston,tx','m',40000,NULL,5);
insert into employee values('Alicia','J','Zelaya',999887777,'1968-01-19',"3321 castle,spring,tx","f",25000,NULL,4);
insert into employee values('Jennifer','S','Wallace',987654321,'1941-06-20','291 berry,bellaire,tx','f',43000,NULL,4);
insert into employee values('Ramesh','K','Narayan',666884444,'1962-09-15','975 fire oak,humble,tx','m',38000,NULL,5);
insert into employee values('Joyce','A','English',453453453,'1972-07-31','5631 rice,houston,tx','f',25000,NULL,5);
insert into employee values('Ahmad','V','Jabbar',987987987,'1969-03-29','980 dallas,houston,tx','m',25000,NULL,4);
insert into employee values('James','E','Borg',888665555,'1937-11-10','450 stone,houston,tx','m',55000,NULL,1);

select * from employee;

--UPDATING VALUES:
--EMPLOYEE:

update employee set superssn=333445555 where ssn=123456789;
update employee set superssn=888665555 where ssn=333445555;
update employee set superssn=987654321 where ssn=999887777;
update employee set superssn=888665555 where ssn=987654321;
update employee set superssn=333445555 where ssn=666884444;
update employee set superssn=333445555 where ssn=453453453;
update employee set superssn=987654321 where ssn=987987987;

--DEPARTMENT:

update department set mgrssn=333445555 where Dno=5;
update department set mgrssn=987654321 where Dno=4;
update department set mgrssn=888665555 where Dno=1;


--DLOCATION 

insert into dlocation values(1,'houston');
insert into dlocation values(4,'stafford');
insert into dlocation values(5,'bellaire');
insert into dlocation values(5,'sugarland');
insert into dlocation values(5,'houston');

select * from dlocation;

--PROJECT:

insert into project values('productx',1,'bellaire',5);
insert into project values('producty',2,'sugarland',5);
insert into project values('productz',3,'houston',5);
insert into project values('computerization',10,'stafford',4);
insert into project values('reorganization',20,'houston',1);
insert into project values('newbenefits',30,'stafford',1);

select * from project;

--WORKS_ON:

insert into works_on values(123456789,1,32.5);
insert into works_on values(123456789,2,7.5);
insert into works_on values(123456789,3,7.5);
insert into works_on values(666884444,3,40.0);
insert into works_on values(453453453,1,20.0);
insert into works_on values(453453453,2,20.0);
insert into works_on values(333445555,1,10.0);
insert into works_on values(333445555,2,10.0);
insert into works_on values(333445555,3,10.0);
insert into works_on values(333445555,10,10.0);
insert into works_on values(333445555,20,10.0);
insert into works_on values(999887777,30,30.0);
insert into works_on values(999887777,10,10.0);
insert into works_on values(987987987,10,35.0);
insert into works_on values(987987987,30,5.0);
insert into works_on values(987654321,30,20.0);
insert into works_on values(987654321,20,15.0);

select * from works_on;

--DEPENDENT:

insert into  dependent values(333445555,'Alice','f','1986-04-05','daughter');
insert into  dependent values(333445555,'Theodore','m','1983-10-25','son');
insert into  dependent values(333445555,'Joy','f','1958-05-03','spouse');
insert into  dependent values(987654321,'Abner','m','1942-02-28','spouse');
insert into  dependent values(123456789,'Michael','m','1986-01-04','son');
insert into  dependent values(123456789,'Alice','f','1988-12-30','daughter');
insert into  dependent values(123456789,'Elizabeth','f','1967-05-05','spouse');

select * from dependent;



--1. Make a list of all project numbers for projects that involve an employee whose last name is ‘Scott’, either as a worker or as a manager of the department that controls the project. 

(Select distinct p.pno,fname
From project p,department d,employee e
Where p.dno=d.dno and mgrssn=ssn and lname=’scott’)

Union

(Select distinct p.pno,fname
From project p,works_on w,employee e
Where p.pno=w.pno and w.ssn=e.ssn and lname=’scott’);


--2.Show the resulting salaries if every employee working on the ‘IoT’ project is given a 10 percent raise. 

Select fname,lname, 1.1*salary as increased_sal 
From employee e,works_on w,project p
Where e.ssn=w.ssn and p.pno=w.pno and pname=’iot';

--3.Find the sum of the salaries of all employees of the ‘Accounts’ department, as well as the maximum salary, the minimum salary, and the average salary in this department


Select sum(salary), max(salary), min(salary), avg(salary)
From employee e, department d
Where d.dno=e.dno and dname=’Accounts’;

--4.Retrieve the name of each employee who works on all the projects Controlled by department number 5 (use NOT EXISTS operator). 

--Using not exists

select e.fname,e.lname
From employee e
Where not exists(select * from project p
Where (p.pno in ( select pno from project where dno=5)
And not exists( select * from works_on w
Where e.ssn=ssn and w.pno=p.pno)));



--5.For each department that has more than five employees, retrieve the department number and the number of its employees who are making more than Rs. 6, 00,000. 

select dno,count(*)
from employee e
where salary>600000 and
dno in(select dno
from employee
group by dno
having count(*)>5)
group by dno;





                                                     
