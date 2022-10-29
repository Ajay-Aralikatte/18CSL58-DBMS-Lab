                           --02:ORDER DATABASE
                               
                -- _____________TABLE CREATION____________   

 
create table salesman
(salesman_id int,name varchar(50),city varchar(20), commission int,
constraint pkysales primary key(salesman_id))engine='innodb';
   
create table customer
(customer_id int,cust_name varchar(50),city varchar(35),grade int,salesman_id int,
constraint pkycust primary key(customer_id),
constraint fkycust foreign key(salesman_id) references salesman(salesman_id)on delete cascade);


//alter table customer drop foreign key fkycust
//alter table customer add constraint fkycust foreign key(salesman_id) references salesman(salesman_id) on delete cascade;

create table orders 
(order_no int,purchase_amt int,order_date smalldatetime,customer_id int,salesman_id int,
constraint pkyorders primary key(order_no),
constraint fkyorders1 foreign key(customer_id) references customer(customer_id),
constraint fkyorders2 foreign key(salesman_id) references salesman(salesman_id) on delete cascade) engine='innodb';

OR 

create table orders 
(order_no int,purchase_amt int,order_date datetime,customer_id int,salesman_id int,
constraint pkyorders primary key(order_no),
constraint fkyorders1 foreign key(customer_id) references customer(customer_id),
constraint fkyorders2 foreign key(salesman_id) references salesman(salesman_id) on delete cascade) engine='innodb';

alter table orders drop foreign key fkyorders2;
alter table orders add constraint fkyorders2 foreign key(salesman_id) references salesman(salesman_id) on delete cascade;

alter table orders drop foreign key fkyorders1;
alter table orders add constraint fkyorders1 foreign key(customer_id) references customer(customer_id) on delete cascade;



select * from salesman;
select * from customer;
select * from orders;
                                             
         --_________INSERTING VALUES________________   

insert into salesman values (11,'Anil Kumar','Bangalore',5000);  
insert into salesman values (12,'Manoj Kumar','Mysuru',3000);
insert into salesman values (13,'Aneesh','Bangalore',4000);  
insert into salesman values (14,'Aarya','Mysuru',3000);  
insert into salesman values (15,'Abhishek','Mangalore',4000);  
insert into salesman values (16,'Bhaskar','Pune',5000);  
insert into salesman values (17,'Rakesh','Belgaum',5000);  

insert into customer values(111,'Srikanth','Bangalore',50,11);
insert into customer values(121,'varshitha','Mysuru',70,12);
insert into customer values(131,'Veena','Bangalore',70,13);
insert into customer values(141,'Hrudya','Bangalore',50,11);
insert into customer values(151,'Akilesh','Mangalore',80,15);
insert into customer values(161,'Roopa','Pune',50,16);
insert into customer values(171,'Rekha','Pune',60,16);

insert into orders values(1,2000,'2017-07-06',111,11);
insert into orders values(2,4000,'2017-07-06',111,11);
insert into orders values(3,2000,'2017-07-06',121,12);
insert into orders values(4,4000,'2017-07-06',131,13);
insert into orders values(5,2000,'2017-07-05',111,11);
insert into orders values(6,6000,'2017-07-05',121,12);
insert into orders values(7,5000,'2017-07-05',121,12);

             --  _____________querry_____________


--(1)Count the customers with grades above Bangalore’s average. 

SELECT GRADE, COUNT (CUSTOMER_ID)as Num_of_cust
FROM CUSTOMER
GROUP BY GRADE
HAVING GRADE > (SELECT AVG(GRADE)
FROM CUSTOMER
WHERE CITY=’Bangalore’);

Select grade,count(customer_id)
From customer
Group by grade
Having grade > (select avg(grade)
From customer 
Where city like ‘Bangalore’);


--(2)Find the name and numbers of all salesmen who had more than one customer. 

select s.salesman_id,s.name from salesman s,customer c 
where s.salesman_id=c.salesman_id group by s.salesman_id, s.name having count(customer_id)>1;

--[OR]

select s.salesman_id,s.name
from salesman s join customer c
on s.salesman_id=c.salesman_id
group by s.salesman_id, s.name
having count(customer_id)>1;

--(3)List all salesmen and indicate those who have and don’t have customers in their cities (Use UNION operation.) 

(select s.salesman_id, name as salesman_name,cust_name,'Match'  as Matched_Or_NotMatched
from salesman s,customer c
where c.city=s.city and s.salesman_id=c.salesman_id)
union
(select s.salesman_id, name as salesman_name,cust_name,'No Match' as Matched_Or_NotMatched
from salesman s,customer c
where c.city <> s.city and s.salesman_id=c.salesman_id);

--(4)Create a view that finds the salesman who has the customer with the highest order of a day. 

create view max_order as
(select distinct s.salesman_id,s.name
from salesman s,orders o
where s.salesman_id=o.salesman_id
and o.customer_id =(select customer_id
                     from orders
                     where order_date='2017-07-06' 
                     group by customer_id
                     having count(order_no) =(select count(order_no)
                                             from orders
                                             where order_date='2017-07-06'
                                             group by customer_id
                                             order by count(order_no) desc limit 1))); //mysql

select * from max_order;

--OR

create view max_order as
(select distinct s.salesman_id,s.name
from salesman s,orders o
where s.salesman_id=o.salesman_id
and o.customer_id =(select customer_id
                     from orders
                     where order_date='2017-07-06' 
                     group by customer_id
                     having sum(purchase_amt) =(select sum(purchase_amt)
                                             from orders
                                             where order_date='2017-07-06'
                                             group by customer_id
                                             order by sum(purchase_amt) desc limit 1))); 

select * from max_order;


/*
--------- To check the query in parts---------------
(i)select customer_id,count(order_no)
from orders
where order_date='2017-07-06'        
group by customer_id ;

(ii)select count(order_no) as max,customer_id
from orders
where order_date='2017-07-06'
group by customer_id
order by count(order_no) desc limit 1;

(iii)select distinct s.salesman_id,s.name
from salesman s,orders o
where s.salesman_id=o.salesman_id
and o.customer_id=(select customer_id
                     from orders
                     where order_date='2017-07-06'
                     group by customer_id
                     having count(order_no)>=2);

(iv)select customer_id,count(order_no)
                     from orders
                     where order_date='2017-07-06' 
                     group by customer_id
                     having count(order_no) =(select count(order_no) as max
                                             from orders
                                             where order_date='2017-07-06'
                                             group by customer_id
                                             order by count(order_no) desc limit 1);

select * from max_order; */




--(5)Demonstrate the DELETE operation by removing salesman with id 1000. All his orders must also be deleted. 

--Before deletion
select * from salesman;
select * from customer;
select * from orders;

delete from salesman
where salesman_id=13;

--After deletion
select * from salesman;
select * from customer;
select * from orders;
