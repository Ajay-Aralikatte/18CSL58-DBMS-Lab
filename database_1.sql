
--01:LIBRARY DATABASE
--TABLE CREATION

create table publisher
(name varchar(35),address varchar(50),phone varchar(10),
constraint pkypub primary key(name))engine='innodb';
   
create table book
(book_id int,title varchar(50),publisher_name varchar(35),pub_year int,
constraint pkybook primary key(book_id),
constraint fkybook foreign key(publisher_name) references publisher(name))engine='innodb';

create table book_authors 
(book_id int,author_name varchar(25),
constraint pkyauthor primary key(book_id,author_name),
constraint fkyauthor foreign key(book_id) references book(book_id)on delete cascade)engine='innodb';

create table library_branch
(branch_id int,branch_name varchar(25),address varchar(50),
constraint pkybranch primary key(branch_id))engine='innodb';

create table book_copies
(book_id int,branch_id int,no_of_copies int,
constraint pkycopies primary key(book_id,branch_id),
constraint fkycopies1 foreign key(book_id) references book(book_id)on delete cascade,
constraint fkycopies2 foreign key(branch_id) references library_branch(branch_id))engine='innodb';

create table book_lending
(book_id int,branch_id int,card_no int,date_out date,due_date date,
constraint pkylending primary key(book_id,branch_id,card_no),
constraint fkylending1 foreign key(book_id) references book(book_id)on delete cascade,
constraint fkylending2 foreign key(branch_id) references library_branch(branch_id))engine='innodb';


--INSERTING VALUES
insert into publisher values('PHI','India','9880066666');
insert into publisher values('Mc Graw Hill','India','9880066677');
insert into publisher values('Sapna','India','9880066688');
insert into publisher values('Andearson','India','9880066699');
insert into publisher values('Tata','India','9880066655');
insert into publisher values('Dreamtech','India','9880066644');

insert into book values(101,'Programming in C','PHI',2000);
insert into book values(102,'Programming in C#','MHI',2002);
insert into book values(103,'Computer Networks','Dreamtech',2006);
insert into book values(104,'Unix shell Programming','PHI',2000);
insert into book values(105,'Compiler Design','PHI',2010);
insert into book values(106,'Database Management Systems','PHI',2008);

insert into book_authors values(101,'Balaguruswamy');
insert into book_authors values(102,'Anderson');
insert into book_authors values(103,'Ferouzan');
insert into book_authors values(104,'Sumitabha das');
insert into book_authors values(105,'Kumar');
insert into book_authors values(106,'Tanenbaun');

insert into library_branch values(1,'Technical','Jayanagar');
insert into library_branch values(2,'Technical','Kuvempunagar');
insert into library_branch values(3,'Advanced Technology','Rajarajeshwarinagar');
insert into library_branch values(4,'Technical','Vijayanagar');
insert into library_branch values(5,'Advanced Technology','Vijayanagar');

insert into book_copies values(101,1,100);
insert into book_copies values(102,1,150);
insert into book_copies values(101,2,200);
insert into book_copies values(103,3,400);
insert into book_copies values(105,4,150);
insert into book_copies values(104,5,150);


insert into book_lending values(101,1,11,'2017-01-22','2017-02-07');
insert into book_lending values(102,2,22,'2017-01-22','2017-04-07');
insert into book_lending values(103,3,33,'2017-02-22','2017-04-07');
insert into book_lending values(104,5,44,'2017-01-22','2017-06-07');
insert into book_lending values(105,4,55,'2017-03-22','2017-05-07');
insert into book_lending values(101,2,66,'2017-04-22','2017-05-07');
insert into book_lending values(103,3,11,'2017-06-20','2017-07-07');
insert into book_lending values(104,5,11,'2017-03-12','2017-05-07');
insert into book_lending values(105,4,11,'2017-05-10','2017-05-07');

--querry

select * from book;
select * from book_authors;
select * from book_copies;
select * from book_lending;
select * from library_branch;
select * from publisher;


--(1)Retrieve details of all books in the library – id, title, name of publisher, authors, number of copies in each branch, etc.

select b.book_id,title,publisher_name,author_name,no_of_copies,branch_name
from book b,book_authors ba,book_copies bc,library_branch lb
where b.book_id=ba.book_id and
      b.book_id=bc.book_id and
      bc.branch_id=lb.branch_id;


--(2) Get the particulars of borrowers who have borrowed more than 3 books, but from Jan 2017 to Jun 2017. 

select book_id,branch_id,card_no,date_out,due_date
from book_lending
where date_out>='2017-01-22' and date_out<='2017-06-07'
and card_no in(select card_no 
from book_lending 
group by card_no 
having count(card_no)>3);


--(3) Delete a book in BOOK table. Update the contents of other tables to reflect this data manipulation operation. 


//Before deleting
select * from book;
select * from book_authors;
select * from book_copies;
select * from book_lending;

delete from book
where book_id=105;

//After deleting
select * from book;
select * from book_authors;
select * from book_copies;
select * from book_lending;


--(4)Partition the BOOK table based on year of publication. Demonstrate its working with a simple query. 

create table book2
(
book_id int, 
title varchar(50), 
publisher_name varchar(35), 
pub_year int,
constraint pkybook primary key(book_id, pub_year)
)
PARTITION BY RANGE (pub_year)
(
PARTITION p0 VALUES LESS THAN (2000),
PARTITION p1 VALUES LESS THAN (2005),
PARTITION p2 VALUES LESS THAN (2010),
PARTITION p3 VALUES LESS THAN (2015)
);

insert into book2 values(101, 'Programming in C', 'PHI', 1995);
insert into book2 values(102, '2 Programming in C', 'PHI', 1996);
insert into book2 values(103, '3 Programming in C', 'PHI', 1997);
insert into book2 values(104, '4 Programming in C', 'PHI', 1998);
insert into book2 values(105, '5 Programming in C', 'PHI', 1999);
insert into book2 values(106, '6 Programming in C', 'PHI', 2000);

insert into book2 values(201, 'Programming in C', 'PHI', 2001);
insert into book2 values(202, '2 Programming in C', 'PHI', 2002);
insert into book2 values(203, '3 Programming in C', 'PHI', 2003);
insert into book2 values(204, '4 Programming in C', 'PHI', 2004);
insert into book2 values(205, '5 Programming in C', 'PHI', 2005);

insert into book2 values(206, '6 Programming in C', 'PHI', 2006);
insert into book2 values(207, '6 Programming in C', 'PHI', 2007);
insert into book2 values(208, '6 Programming in C', 'PHI', 2008);
insert into book2 values(209, '6 Programming in C', 'PHI', 2009);
insert into book2 values(210, '6 Programming in C', 'PHI', 2010);

insert into book2 values(211, '6 Programming in C', 'PHI', 2011);
insert into book2 values(212, '6 Programming in C', 'PHI', 2012);
insert into book2 values(213, '6 Programming in C', 'PHI', 2013);
insert into book2 values(214, '6 Programming in C', 'PHI', 2014);
insert into book2 values(215, '6 Programming in C', 'PHI', 2015);
insert into book2 values(216, '6 Programming in C', 'PHI', 2017);

-------------- To add a new partition -------------------------
ALTER TABLE book2 ADD PARTITION (PARTITION p4 VALUES LESS THAN (2016));

----------------To view the partitions ---------------------------

SELECT * FROM INFORMATION_SCHEMA.PARTITIONS WHERE TABLE_NAME = ‘book2’;


--5)Create a view of all books and its number of copies that are currently available in the Library. 

create view book_details as
(select b.book_id, title,publisher_name,pub_year,author_name,lb.branch_id,no_of_copies
from book b,book_authors ba,book_copies bc,library_branch lb
where b.book_id=ba.book_id and
      b.book_id=bc.book_id and
      lb.branch_id=bc.branch_id);

select * from book_details;
