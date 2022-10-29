						--03:MOVIE DATABASE

              --_____________TABLE CREATION____________    

create table actor
(actor_id int,actor_name varchar(40),actor_gender char,
constraint pkyactor primary key (actor_id))engine='innodb';

create table director
(director_id int,director_name varchar(40),director_phone varchar(10),
constraint pkydirector primary key (director_id))engine='innodb';

create table movies
(movie_id int,movie_title varchar(40),movie_year int,movie_language varchar(15),director_id int, constraint pkymovie primary key(movie_id),
constraint fkymovie foreign key (director_id) references director(director_id))engine='innodb';

create table movie_cast
(actor_id int,movie_id int,role varchar(50),
constraint pkymcast primary key (actor_id,movie_id),
constraint fkymcast1 foreign key (actor_id) references actor(actor_id),
constraint fkymcast2 foreign key (movie_id) references movies(movie_id))engine='innodb';

create table rating
(movie_id int,rev_stars int,
constraint pkyrating primary key (movie_id),
conStraint fkyrating foreign key (movie_id) references movies(movie_id))engine='innodb';


--_________________INSERTING VALUES_____________________

insert into actor values(101,'Amitabh bachan','m');
insert into actor values(102,'Allu arjun','m');
insert into actor values(103,'Priyanka chopra','f');
insert into actor values(104,'Rakshith shetty','m');
insert into actor values(105,'Meera Jasmine','f');
insert into actor values(106,'Thamanna','f');
insert into actor values(107,'Anushka sharma','f');
insert into actor values(108,'Anushka shetty','f');


insert into director values(1,'Yash Chopra','9880066666');
insert into director values(2,'Yograj Bhatt','9880066667');
insert into director values(3,'Ramakrishna','9880066668');
insert into director values(4,'Chopra','9880066669');
insert into director values(5,'Ravi Chandran','9880066665');
insert into director values(6,'Steven Spielberg','9880066664');


insert into movies values (11,'Kirik Party',2016,'Kannada',2);
insert into movies values (12,'Kabhi kushi kabhi gum',1999,'Hindi',1);
insert into movies values (13,'Sholey',1990,'Hindi',4);
insert into movies values (14,'Aarya',1999,'Telugu',3);
insert into movies values (15,'DJ',2017,'Telugu',3);
insert into movies values (16,'Dostaana',2012,'Hindi',3);
insert into movies values (17,'Ekangi',2000,'Kannada',5);
insert into movies values (18,'Speed',2000,'English',6);
insert into movies values (19,'Arasu',2011,'Kannada',2);
insert into movies values (20,'Sultan',2016,'Hindi',1);
insert into movies values (21,'Bahubali 2',2017,'Telugu',4);
insert into movies values (22,'Terminator',2000,'English',6);

insert into movie_cast values(101,12,'Lead Role');
insert into movie_cast values(102,14,'Hero');
insert into movie_cast values(102,15,'Hero');
insert into movie_cast values(103,16,'Heroine');
insert into movie_cast values(102,16,'Hero');
insert into movie_cast values(104,11,'Hero');
insert into movie_cast values(101,13,'Hero');
insert into movie_cast values(105,19,'Heroine');
insert into movie_cast values(108,21,'Heroine');
insert into movie_cast values(107,20,'Heroine');


insert into rating values(11,5);
insert into rating values(12,3);
insert into rating values(13,5);
insert into rating values(14,5);
insert into rating values(15,4);
insert into rating values(16,3);
insert into rating values(17,2);
insert into rating values(18,4);
insert into rating values(19,3);
insert into rating values(20,3);
insert into rating values(21,5);
insert into rating values(22,3);


select * from actor;
select * from director;
select * from movies;
select * from movie_cast;
select * from rating;

                            -- _______________________query__________________

--1)List the titles of all movies directed by ‘Hitchcock’. 
  
select movie_title,director_name
from movies m,director d
where m.director_id=d.director_id
and director_name like 'Yash chopra';

--OR

select movie_title,director_name
from movies m join director d
on m.director_id=d.director_id
and director_name like 'Yash chopra';



--2)Find the movie names where one or more actors acted in two or more movies. 

select movie_title
from movies m , movie_cast mv
where m.movie_id=mv.movie_id and actor_id in (select actor_id
from movie_cast
group by actor_id
having count(actor_id)>1)
group by movie_title
having count(*)>1;

--3) List all actors who acted in a movie before 2000 and also in a movie after 2015 (use JOIN operation). 


 select actor_id,actor_name
 from actor 
 where actor_id in(select actor_id 
 from movie_cast c join movies m
 on c.movie_id=m.movie_id
 where movie_year<2000)
 and actor_id in(select actor_id 
 from movie_cast c join movies m
 on c.movie_id=m.movie_id
 where movie_year>2015);


--4)Find the title of movies and number of stars for each movie that has at least one rating and find the highest number of stars that movie received. Sort the result by movie title. 

select movie_title,max(rev_stars)
from movies m,rating r
where m.movie_id=r.movie_id
group by movie_title
having max(rev_stars)>0
order by movie_title;

--5) Update rating of all movies directed by ‘Steven Spielberg’ to 5 

update rating
set rev_stars=5
where movie_id in(select movie_id from movies m,director d
where m.director_id=d.director_id
and director_name like 'Steven Spielberg');
select * from rating;
			
-----------------------------------------------------------------------------------------------
