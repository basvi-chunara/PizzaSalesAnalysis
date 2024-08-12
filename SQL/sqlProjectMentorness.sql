#create table customer_info(id integer auto_increment, first_name varchar(25), last_name varchar(25), salary integer, primary key(id)); 
#update query
#update customer_info set dob='2005' where id=4;
#delete query
#delete from customer_info where id=10;
#alter queries
# to add a column to existing table
#alter table customer_info add email varchar(25);
#alter table customer_info add dob date;
#alter table using modify
#ALTER TABLE customer_info MODIFY dob year;
#alter table customer_info drop column email;

use customer;
create table student(
ID INT NOT NULL,
first_name VARCHAR(25) NOT NULL,
last_name VARCHAR(25) NOT NULL,
age INT
);

create table person(
id int not null,
first_name varchar(25) not null,
last_name varchar(25) not null,
age int not null,
unique(id));
insert into person values(2, 'basvi', 'C',19);
alter table person add unique(first_name);
select * from person;
alter table person
add constraint uc_person unique(age, first_name);

alter table person
drop index uc_person;
desc person;

#primary key
create table person3(
id int not null,
first_name varchar(25) not null,
last_name varchar(25),
age int,
constraint pk_person primary key(id,last_name));

alter table person3
add primary key(id);
desc person3;

#primary key and more
use customer;
drop table person;
create table person(
id int not null, 
first_name varchar(25) not null,
last_name varchar(25) not null,
age int);

alter table person add primary key(id);
desc person;
drop table person;

#foreign key
create table person(
id int not null, 
first_name varchar(25) not null,
last_name varchar(25) not null,
age int,
salary int,
primary key(id));
desc person;
create table department(
id int not null,
department_id int not null,
department_name varchar(25) not null,
primary key(department_id)
);

alter table department 
add foreign key(id) references person(id);
desc department;
drop table department;
drop table person;

# CHECK CONSTRAINTS
create table person(
id int not null, 
first_name varchar(25) not null,
last_name varchar(25) not null,
age int,
salary int,
primary key(id),
check(salary<50000)
);

insert into person values(1,'Krish','Naik',31, 9000);
select * from person; 

# DEFAULT CONSTRAINT
drop table person;
create table person(
id int not null, 
first_name varchar(25) not null,
last_name varchar(25) not null,
city_name varchar(25) default 'Bangalore');
desc person;
alter table person
alter city_name drop default;
desc person;
drop table student;

# SQL INDEXES (CREATE INDEX query)

create table student(
id int not null,
first_name varchar(25) not null,
last_name varchar(25) not null,
age int);

desc student;

# using view
drop table student;
use customer;
create table student(
studentid int auto_increment,
first_name varchar(25) not null,
last_name varchar(25) not null,
age int,
primary key(studentid));

insert into student values(1,'Krish','Naik',31),
(2,'Ram','Gupta',31),
(3,'Sam','Joe',31);

create table department(
student_id int auto_increment,
department_name varchar(25) not null,
foreign key(student_id) references student(studentid));
desc department;


select * from student;
select * from department;

create table department(
student_id int auto_increment,
department_name varchar(25) not null,
foreign key(student_id) references student(studentid));
insert into department(department_name) values('Computer Science'),
('Electronics'),('Mechanical');

insert into student values(4,'Ankit','Kumar',20),
(5,'Ramesh','Singh',24);


## INNER JOIN
select student.first_name,student.last_name,student.age,department.department_name
from student inner join department
on student.studentid=department.student_id;

## LEFT JOIN
select student.first_name,student.last_name,student.age,department.department_name
from student left join department
on student.studentid=department.student_id;

## RIGHT JOIN
select student.first_name,student.last_name,student.age,department.department_name
from student right join department
on student.studentid=department.student_id;

## FULL JOIN
select student.first_name,student.last_name,student.age,department.department_name
from student left join department
on student.studentid=department.student_id
union
select student.first_name,student.last_name,student.age,department.department_name
from student right join department
on student.studentid=department.student_id;

# STORED PROCEDUCRES

call student_info(@record);
select @record as TotalRecords;


create database pizza;
use pizza;
#Q1: The total number of order place
SELECT COUNT(*) AS Total_orders FROM ORDERS;

#Q2 Find the total revenue generated from pizza sales
SELECT ROUND(SUM(O.QUANTITY*P.PRICE),1) AS Total_revenue FROM 
ORDER_DETAILS O JOIN PIZZAS P ON O.PIZZA_ID=P.PIZZA_ID;

#Q3 Identify the highest priced pizza.
SELECT PT.NAME, P.PRICE FROM 
PIZZA_TYPES PT JOIN PIZZAS P ON 
PT.PIZZA_TYPE_ID=P.PIZZA_TYPE_ID
WHERE P.PRICE=(SELECT MAX(PRICE) FROM PIZZAS);

#Q4 Find the most common pizza size ordered.
SELECT P.SIZE, COUNT(O.QUANTITY) AS 'NO. OF ORDERS' FROM
PIZZAS P JOIN ORDER_DETAILS O ON
P.PIZZA_ID = O.PIZZA_ID
GROUP BY P.SIZE ORDER BY MAX(O.QUANTITY) DESC;

rename table PIZZAS to PIZZAS;

#Q5 Identify the top 5 most ordered pizza types along their quantities.
SELECT PT.NAME,SUM(O.QUANTITY) AS 'TOTAL QUANTITY'
FROM ORDER_DETAILS O JOIN PIZZAS P ON O.PIZZA_ID=P.PIZZA_ID 
JOIN PIZZA_TYPES PT ON P.PIZZA_TYPE_ID=PT.PIZZA_TYPE_ID
GROUP BY PT.NAME ORDER BY 'TOTAL QUANTITY' LIMIT 5;

#6 What is the quantity of each pizza categories ordered?
SELECT PT.CATEGORY,SUM(O.QUANTITY) AS 'TOTAL QUANTITY'
FROM ORDER_DETAILS O JOIN PIZZAS P ON O.PIZZA_ID=P.PIZZA_ID 
JOIN PIZZA_TYPES PT ON P.PIZZA_TYPE_ID=PT.PIZZA_TYPE_ID
GROUP BY PT.CATEGORY ORDER BY 'TOTAL QUANTITY';

#7 Identify the distribution of orders by hours of the day.
SELECT HOUR(TIME) AS 'HOUR OF THE DAY',
COUNT(ORDER_ID) AS 'NO. OF ORDERS' FROM ORDERS 
GROUP BY HOUR(TIME);

#8 Find the category-wise distribution of pizzas.
SELECT CATEGORY,COUNT(CATEGORY) AS 'NO. OF PIZZA' FROM PIZZA_TYPES 
GROUP BY CATEGORY;

#Q9 What is the average number of pizzas ordered per day?
SELECT ROUND(AVG(PERDAY_TOTAL.TOTAL_QUANTITY),0) AS 'AVG ORDERS PER DAY' 
FROM (SELECT O.DATE, SUM(OD.QUANTITY) AS TOTAL_QUANTITY FROM 
ORDER_DETAILS OD JOIN ORDERS O ON O.ORDER_ID = OD.ORDER_ID
GROUP BY O.DATE) AS PERDAY_TOTAL;

#Q10 Identify the top 3 most ordered pizza type base on revenue.
SELECT PT.NAME, SUM(O.QUANTITY*P.PRICE) AS TOTAL_REVENUE FROM ORDER_DETAILS O JOIN 
PIZZAS P ON O.PIZZA_ID=P.PIZZA_ID JOIN PIZZA_TYPES PT 
ON P.PIZZA_TYPE_ID = PT.PIZZA_TYPE_ID GROUP BY PT.NAME 
ORDER BY TOTAL_REVENUE DESC LIMIT 3;


#Q11 What is the percentage contribution of each pizza type to revenue?
SELECT PT.CATEGORY,ROUND((SUM(O.QUANTITY*P.PRICE)/(SELECT ROUND
(SUM(O.QUANTITY*P.PRICE),2) AS TOTAL_REV FROM ORDER_DETAILS O 
JOIN PIZZAS P ON P.PIZZA_ID=O.PIZZA_ID))*100,2) AS REV FROM 
PIZZA_TYPES PT JOIN PIZZAS P ON PT.PIZZA_TYPE_ID = P.PIZZA_TYPE_ID 
JOIN ORDER_DETAILS O ON O.PIZZA_ID=P.PIZZA_ID
GROUP BY PT.CATEGORY ORDER BY REV DESC;

#Q12 Identify the cumulative revenue generated over time.
SELECT O.DATE,ROUND(SUM(OD.QUANTITY*P.PRICE),2) 
AS DAILY_REVENUE,ROUND(SUM(SUM(OD.QUANTITY*P.PRICE)) 
OVER (ORDER BY O.DATE),2) AS CUMULATIVE_REVENUE
FROM ORDERS O JOIN ORDER_DETAILS OD ON 
O.ORDER_ID=OD.ORDER_ID JOIN PIZZAS P ON 
P.PIZZA_ID = OD.PIZZA_ID 
GROUP BY O.DATE ORDER BY O.DATE;

#Q13 Find the top 3 most ordered pizza type based on revenue for each pizza category.
SELECT CATEGORY,NAME,REVENUE FROM(
SELECT PT.CATEGORY,PT.NAME,ROUND(SUM(OD.QUANTITY*P.PRICE),2) AS REVENUE, 
RANK() OVER (PARTITION BY PT.CATEGORY ORDER BY SUM(OD.QUANTITY*P.PRICE)DESC)
AS ranks FROM ORDER_DETAILS OD JOIN PIZZAS P ON OD.PIZZA_ID=
P.PIZZA_ID JOIN PIZZA_TYPES PT ON P.PIZZA_TYPE_ID=PT.PIZZA_TYPE_ID 
GROUP BY PT.CATEGORY,PT.NAME) RANKED_PIZZAS WHERE ranks<=3 
ORDER BY CATEGORY,ranks;
