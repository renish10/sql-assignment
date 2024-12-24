## 1. Create a table called employees with the following structure 
##  emp_id (integer, should not be NULL and should be a primary key) 
##  emp_name (text, should not be NULL) 
##  age (integer, should have a check constraint to ensure the age is at least 18) 
##  email (text, should be unique for each employee) 
##   salary (decimal, with a default value of 30,000). 
##  Write the SQL query to create the above table with all constraints.
## ans. 
create table employees(emp_id int primary key not null, 
emp_name varchar(30) not null, 
age int check(age >= 18), 
email char(40) unique, 
salary decimal default 30000);
select * from employees;

##2. Explain the purpose of constraints and how they help maintain data integrity in a database. Provide examples of common types of constraints.
## ans. 
## purpose of constraints :- constraints are rules that apply on columns on database to ensure about data entered is accurate and valid.
## how they help maintain data integrity in a database :- here are some points on which constraints helps to maintain data integrity in a database :
##  1. It prevents the invalid data entry
##  2. It helps to built relationships between tables
##  3. It improves data reliability
## Examples of common types of constraints :-  
## A.  Primary key :- 
use pw;
create table students
(stud_id int primary key , Name varchar(40));
## B. Unique key:- 
create table renish ( stud_id int unique , email varchar(50));
## C. Not Null constraint:- 
create table sohan ( Name varchar(50) not null, store_name varchar(50));
## default constraint :- 
create table accounts (acc_no int, acc_name varchar(50) default ('renish') );

## 3. .Why would you apply the NOT NULL constraint to a column? Can a primary key contain NULL values? Justify your answer.?
## ans. 
## Reason for applying not null constraint :- This function or keyword is used for justifying that the part of the data should not be null or should contain any inserted data,here are some points or reasons in which data should be null or empty.
##  Mandatory data :- In data some columns cannot be empty such as name,price,etc. 
##  Avoid logical errors :- In data , some columns cannot be empty value such as calculating average values , percentages , etc. 

## Can a primary key contain NULL values? :- Primary key, does not contain null values. 
## Justification :- A null value indicates 'unknown' or 'no value'. If a primary key allowed to accept null value, than it would violate behaviour of data.
## for e.g., 
create table sohan2(stud_id int, Name varchar(40));
insert into sohan2 values(1,null);
## in above query, it justifies, that name column should be empty.

## 4. Explain the steps and SQL commands used to add or remove constraints on an existing table. Provide an example for both adding and removing a constraint.?
## ans. Steps to add and remove constraints on an existing table is as follows :- 
##      A. adding not_null constraint :- alter table table_name modify column column_name data_type not null.. 
##      B. adding foreign key constraint :- alter table table_name add constraint column_name foriegn key data_type..
##		C. adding unique constraint :- alter table table_name add constraint column_name unique (name)..
##		D. dropping not null constraint :- alter table table_name modify column column_name data_type null...
##		E. dropping unique constraint :- alter table table_name drop index unique_name
##		F. dropping foreign key constraint :- alter table table_name drop foreign key column_name

## 		for e.g.,  Adding constraints :
##		adding not null constraint 
		alter table sohan2 modify column stud_id int not null;
## adding foreign key constraint :
		create table renish2 (id int primary key, name varchar(40));
        create table sohan3(n_id int primary key, s_id int, n_name varchar(40));
        alter table sohan3 add constraint fk_n_id foreign key(n_id) references renish2(id);
## adding unique constraint :
		alter table sohan2 add constraint unique_name unique(name);
## dropping not null constraint : 
		alter table sohan2 modify column stud_id int null;
## dropping unique constraint :
		alter table sohan2 drop index unique_name;
## dropping foreign key constraint :
		alter table sohan3 drop foreign key fk_n_id;

## 5. Explain the consequences of attempting to insert, update, or delete data in a way that violates constraints. Provide an example of an error message that might occur when violating a constraint.?
## ans. Here are some consequences with examples that violates the behaviour of data :
##      Primary key violation :
		insert into renish2 values (1,'renish');
        insert into renish2 values (1,'sohan');   ## 1 already exists
##		Error Code: 1062. Duplicate entry '1' for key 'renish2.PRIMARY'	0.000 sec
##		Foreign key violation :
		insert into sohan3 values (2,1,'renish2');
##		Error Code: 1452. Cannot add or update a child row: a foreign key constraint fails (`pw`.`sohan3`, CONSTRAINT `fk_n_id` FOREIGN KEY (`n_id`) REFERENCES `renish2` (`id`))	0.000 sec
##		Unique constraint violation :
		alter table sohan2 drop  primary key;
        insert into sohan2 values (1,'renish');
        insert into sohan2 values (2,'renish');
##		Error Code: 1062. Duplicate entry 'renish' for key 'sohan2.unique_name'	0.000 sec
##		Delete violations on foreign key :
		drop table student;
		create table student (stud_id int,stud_name varchar(40) unique);
        create table students2 (id int,st_name varchar(40), foreign key (st_name) references student(stud_name));
		insert into student values (1,'renish');
        insert into students2 values (2,'sohan');	##	Error Code: 1452. Cannot add or update a child row: a foreign key constraint fails (`pw`.`students2`, CONSTRAINT `students2_ibfk_1` FOREIGN KEY (`st_name`) REFERENCES `student` (`stud_name`))	0.016 sec
        delete from students2 where st_name = 'sohan';    ##	0 row(s) affected	0.000 sec
## hence, above are some examples with error message in which it demonstrates the violation of constraints in adding and deleting columns data ..

## 6.  You created a products table without constraints as follows: 
##	CREATE TABLE products ( product_id INT, product_name VARCHAR(50), price DECIMAL(10, 2));
##	Now, you realise that,
##	The product_id should be a primary key. 
##	The price should have a default value of 50.00
## ans. 

	CREATE TABLE products ( product_id INT primary key, product_name VARCHAR(50), price DECIMAL(10, 2) default(50));
##    insert into products (product_id,product_name) values (1,'renish');
##    select * from products;

## 7. You have two tables :
create table Students (student_id int, student_name varchar(50), class_id int);
insert into students values (1,'alice',101);
insert into students values (2,'bob',102);
insert into students values (3,'charlie',101);
select * from students;
create table classes (class_id int, class_name varchar(50));
insert into classes values (101,'math');
insert into classes values (102,'science');
insert into classes values (103,'history');
select * from classes;

## Write a query to fetch the student_name and class_name for each student using an INNER JOIN.?
## ans. 
select students.student_name,classes.class_name from students inner join classes on students.class_id = classes.class_id;

## 8. Consider the following three tables :
use pw;
create table orders (order_id int, order_date date,customer_id int);
create table cutomers (customer_id int, customer_name varchar(50));
create table products (product_id int, product_name varchar(50), order_id int);
## Write a query that shows all order_id, customer_name, and product_name, ensuring that all products are listed even if they are not associated with an order..
## Hint: (use INNER JOIN and LEFT JOIN)
## ans. 
select products.product_id,products.product_name,orders.order_id,cutomers.customer_name from products 
left join orders on products.order_id = orders.order_id
left join cutomers on orders.customer_id = cutomers.customer_id;

## 9. Given the following tables:
create table sales (sales_id int, product_id int, amount int);
create table products2 (product_id int, product_name varchar(50));
## Write a query to find the total sales amount for each product using an INNER JOIN and the SUM() function.
## ans.
select products2.product_name, sum(sales.amount) as total_sales  from sales 
inner join products2 on sales.product_id = products2.product_id 
group by 
products2.product_name;
insert into sales values (1,101,500);
insert into sales values (2,102,300);
insert into sales values (3,101,700);

insert into products2 values (101,'laptop');
insert into products2 values (102,'phone');

## 10. You are given three tables:
create table order2 (order_id int, order_date date, customer_id int);
insert into order2 values (1, '2024-01-02',1);
insert into order2 values (2, '2024-01-05',2);

create table customers2 (customer_id int, customer_name varchar(50));
insert into customers2 values (1,'alice');
insert into customers2 values (2,'bob');

create table order_details (order_id int, product_id int, quantity int);
insert into order_details values (1,101,2);
insert into order_details values (1,102,1);
insert into order_details values (2,101,3);

## Write a query to display the order_id, customer_name, and the quantity of products ordered by each customer using an INNER JOIN between all three tables.

## ans. 
select order2.order_id ,customers2.customer_name, sum(order_details.quantity) as total_quantity from order2 
inner join customers2 on order2.customer_id = customers2.customer_id 
inner join order_details on order2.order_id = order_details.order_id
group by 
order2.order_id , customers2.customer_name;


## SQL Commands

## 1. Identify the primary keys and foreign keys in maven movies db. Discuss the differences.?
## ans. 
use mavenmovies;



## 2.  List all details of actors.?
## ans. 
select * from actor;

## 3. -List all customer information from DB.?
## ans. 
select * from customer;

## 4. List different countries.?
## ans. 
select * from country;

## 5. Display all active customers. ?
## ans. 
select * from customer where active = 1;

## 6. -List of all rental IDs for customer with ID 1.?
## ans. 
select * from rental where customer_id = 1;

## 7. - Display all the films whose rental duration is greater than 5 .?
## ans. 
select * from film where rental_duration > 5;

## 8. List the total number of films whose replacement cost is greater than $15 and less than $20.?
## ans. 
select * from film where replacement_cost between 15 and 20;

## 9. Display the count of unique first names of actors.?
## ans. 
select * from actor;
select count(first_name) from  actor;

## 10. Display the first 10 records from the customer table?
## ans. 
select * from customer limit 10;

## 11.  Display the first 3 records from the customer table whose first name starts with ‘b’?
## ans. 
select * from customer;
select * from customer where first_name like 'b%' limit 3;

## 12. Display the names of the first 5 movies which are rated as ‘G’.?
## ans. 
select * from film where rating like 'G' limit 5;

## 13. -Find all customers whose first name starts with "a".?
## ans. 
select * from customer;
select * from customer where first_name like 'a%';

## 14.  Find all customers whose first name ends with "a"?
## ans. 
select * from customer;
select * from customer where first_name like '%a';

## 15.  Display the list of first 4 cities which start and end with ‘a’ .?
## ans. 
select* from city;
select * from city where city like 'a%a' limit 4;

## 16. Find all customers whose first name have "NI" in any position ?
## ans. 
select * from customer;
select * from customer where first_name like '%NI%';

## 17. Find all customers whose first name have "r" in the second position ?
## ans. 
select * from customer;
select * from customer where first_name like '_r%';

## 18.  Find all customers whose first name starts with "a" and are at least 5 characters in length?
## ans. 
select * from customer;
select * from customer where first_name like 'a%' and length(first_name) >= 5;

## 19. Find all customers whose first name starts with "a" and ends with "o".?
## ans. 
select * from customer;
select * from customer where first_name like 'a%o';

## 20. Get the films with pg and pg-13 rating using IN operator.?
## ans. 
select * from film;
select * from film where rating in('PG','PG-13');

## 21. Get the films with length between 50 to 100 using between operator.?
## ans. 
select * from film;
select * from film where length between 50 and 100;

## 22. Get the top 50 actors using limit operator.?
## ans. 
select * from actor;
select * from actor limit 50;

## 23.  Get the distinct film ids from inventory table.?
## ans. 
select * from inventory;
select distinct film_id from inventory;


## Functions

## Basic Aggregate Functions:
## Question 1: 
## Retrieve the total number of rentals made in the Sakila database. Hint: Use the COUNT() function.
## ans. 
select * from rental;
select count(rental_date) from rental;

## 2. Find the average rental duration (in days) of movies rented from the Sakila database. Hint: Utilize the AVG() function.
## ans. 

select * from film;
select avg(rental_duration) as avg_rental from film;

## String Functions:
## 3. Display the first name and last name of customers in uppercase. Hint: Use the UPPER () function.?
## ans. 
select * from customer;
select upper(first_name) as up_first_name , upper(last_name) as up_last_name from customer;

## 4. Extract the month from the rental date and display it alongside the rental ID. Hint: Employ the MONTH() function.?
## ans. 
select * from rental;
select month(rental_date) as rental_month , rental_id from rental;

## GROUP BY:
## 5. Retrieve the count of rentals for each customer (display customer ID and the count of rentals). Hint: Use COUNT () in conjunction with GROUP BY.?
## ans. 
select * from rental;
select customer_id, count(rental_id) as count_rental from rental group by customer_id;

## 6. Find the total revenue generated by each store. Hint: Combine SUM() and GROUP BY.?
## ans. 



## 7. Determine the total number of rentals for each category of movies. Hint: JOIN film_category, film, and rental tables, then use cOUNT () and GROUP BY.?
## ans.
select * from rental;
select * from category;
select * from inventory;
select * from film;
select * from film_category; 
select category.name as category_name, count(rental.rental_id) as total_rentals from rental
join inventory on rental.inventory_id = inventory.inventory_id
join film on inventory.film_id = film.film_id
join film_category on film.film_id = film_category.film_id
join category on film_category.category_id = category.category_id
group by category.name;

## 8. Find the average rental rate of movies in each language. Hint: JOIN film and language tables, then use AVG () and GROUP BY.?
## ans. 
select * from film;
select * from language;
select language.name as language_name,
avg(film.rental_rate) as avg_rental_rate 
from film 
join language on film.language_id = language.language_id
group by language.name;


## Joins:
## 9. Display the title of the movie, customer s first name, and last name who rented it. Hint: Use JOIN between the film, inventory, rental, and customer tables.?
## ans. 
select * from film;
select * from inventory;
select * from rental;
select * from customer;
select film.title as f_title , 
customer.first_name as first_name,
customer.last_name as last_name from rental 
join inventory on rental.inventory_id = inventory.inventory_id
join film on inventory.film_id = film.film_id
join customer on rental.customer_id = customer.customer_id ;

## 10. Retrieve the names of all actors who have appeared in the film "Gone with the Wind." Hint: Use JOIN between the film actor, film, and actor tables.?
## ans. 
select * from film_actor;
select * from film;
select * from actor;
select actor.first_name as first_name, actor.last_name as last_name from film
join film_actor on film.film_id = film_actor.film_id 
join actor on film_actor.actor_id = actor.actor_id
where 
film.title = 'Gone with the Wind';

## 11. Retrieve the customer names along with the total amount they've spent on rentals. Hint: JOIN customer, payment, and rental tables, then use SUM() 
##		and GROUP BY.?
## ans. 
select * from customer;
select * from payment;
select * from rental;
select customer.first_name as f_name,
customer.last_name as l_name , sum(payment.amount) as t_amount from customer
join payment on customer.customer_id = payment.customer_id
group by 
customer.first_name,customer.last_name,customer.customer_id;

## 12. List the titles of movies rented by each customer in a particular city (e.g., 'London'). 
##    Hint: JOIN customer, address, city, rental, inventory, and film tables, then use GROUP BY
## ans. 
select * from customer ;
select * from address ;
select * from city ;
select * from rental ;
select * from inventory ;
select * from film ;
select customer.first_name as f_name,customer.last_name as l_name,film.title as title from customer 
join 
address on customer.address_id = address.address_id 
join 
city on address.city_id = city.city_id
join 
rental on customer.customer_id = rental.customer_id 
join 
inventory on rental.inventory_id = inventory.inventory_id
join 
film on inventory.film_id = film.film_id 
where 
city.city = 'london'
group by 
customer.customer_id, film.title;

## Advanced Joins and GROUP BY:
## 13. Display the top 5 rented movies along with the number of times they've been rented. 
##     Hint: JOIN film, inventory, and rental tables, then use COUNT () and GROUP BY, and limit the results.
## ans . 
select film.title as f_title ,
count(rental.rental_id) as time_rented from film 
join 
inventory on film.film_id = inventory.film_id
join
rental on inventory.inventory_id = rental.inventory_id 
group by 
film.title
limit 5;

## 14. Determine the customers who have rented movies from both stores (store ID 1 and store ID 2). 
##     Hint: Use JOINS with rental, inventory, and customer tables and consider COUNT() and GROUP BY
## ans.
select customer.customer_id, customer.first_name as c_f_name , customer.last_name as c_l_name from customer
join 
rental on customer.customer_id = rental.customer_id 
join 
inventory on rental.inventory_id = inventory.inventory_id
where 
inventory.store_id in (1,2)
group by 
customer.customer_id,customer.first_name,customer.last_name
having 
count(distinct inventory.store_id) = 2;

## Windows Function:
## 1. Rank the customers based on the total amount they've spent on rentals.?
## ans. 
select customer.customer_id,customer.first_name,customer.last_name ,sum(payment.amount) as total_spent,
rank() over (order by sum(payment.amount) desc) as Rank_of_customer from customer
join 
payment on customer.customer_id = payment.customer_id
group by 
customer.customer_id,customer.first_name,customer.last_name
order by 
Rank_of_customer;

## 2.  Calculate the cumulative revenue generated by each film over time.?
## ans. 
select film.title as film_title ,
payment.payment_date as payment_date ,
sum(payment.amount) over (partition by film.film_id order by payment.payment_date) as cum_revenue from payment
join 
rental on payment.rental_id = rental.rental_id
join 
inventory on rental.inventory_id = inventory.inventory_id 
join 
film on inventory.film_id = film.film_id 
order by 
film.title,payment.payment_date;

## 3. Determine the average rental duration for each film, considering films with similar lengths.?
## ans. 
select film.length as film_length, 
avg(rental.return_date - rental.rental_date) as avg_rental_duration from rental 
join 
inventory on rental.inventory_id = inventory.inventory_id
join
film on inventory.film_id = film.film_id 
where 
rental.return_date is not null
group by 
film.length 
order by 
film.length;

## 4. Identify the top 3 films in each category based on their rental counts?
## ans. 




## 5.  Calculate the difference in rental counts between each customer's total rentals and the average rentals across all customers.?
## ans. 
select customer.customer_id, 
customer.first_name as first_name,
customer.last_name as last_name, 
count(rental.rental_id) as total_rentals,
avg(count(rental.rental_id)) over () as avg_rentals,
count(rental.rental_id) - avg(count(rental.rental_id)) over()  as rental_diff from customer 
join 
rental on customer.customer_id = rental.customer_id 
group by 
customer.customer_id , customer.first_name,customer.last_name
order by 
rental_diff desc;

## 6.  Calculate the difference in rental counts between each customer's total rentals and the average rentals across all customers.?
## ans. 
select customer.customer_id , customer.first_name as f_name, customer.last_name as l_name, count(rental.rental_id) as total_rentals, 
( select avg(rental_count) from (select count(rental.rental_id) as rental_count from rental group by rental.customer_id) as avg_rentals) as average_rentals,
count(rental.rental_id)-(select avg(rental_count)from (select count(rental.rental_id) as rental_count from rental group by rental.customer_id) as avg_rentals) as rental_diff from customer
join rental on customer.customer_id = rental.customer_id
group by 
customer.customer_id,customer.first_name,customer.last_name
order by 
rental_diff desc;

## 7.  Identify the customers whose total spending on rentals falls within the top 20% of all customers.?
## ans. 
with customerspending as 
( select customer.customer_id, customer.first_name,customer.last_name,sum(payment.amount) as total_spending from customer
join 
payment on customer.customer_id = payment.customer_id 
group by
customer.customer_id,customer.first_name,customer.last_name)
select customer_id,first_name,last_name,total_spending from (select customer_id,first_name,last_name,total_spending, percent_rank() 
over (order by total_spending desc) as rank_cust
from customerspending) as Ranked_customers
where rank_cust <=0.20 
order by total_spending desc;

## 8. . Calculate the running total of rentals per category, ordered by rental count.?
## ans. 
with rental_counts as (
select category.name as category_name, 
count(rental.rental_id) as rental_count
from category
join 
film_category on category.category_id = film_category.category_id
join
film on film_category.film_id = film.film_id
join
inventory on film.film_id = inventory.film_id
join 
rental on inventory.inventory_id = rental.inventory_id
group by 
category.name
)
select 
category_name,
rental_count,
sum(rental_count) over (order by rental_count desc) as running_total 
from 
rental_counts
order by 
rental_count desc; 


## 9.  Find the films that have been rented less than the average rental count for their respective categories.?
## ans. 
with category_avg as 
(select 
category.name ,
film_category.film_id,
avg(film_rentals.rental_count) as avg_rental_count
from category
join 
film_category on category.category_id = film_category.category_id
join 
(select 
inventory.film_id,count(rental.rental_id) as rental_count
from rental 
join 
inventory on rental.inventory_id = inventory.inventory_id
group by 
inventory.film_id) as film_rentals
on 
film_category.film_id = film_rentals.film_id )
select film.title as film_title,
category.name,
film_rentals.rental_count as rentalcount,
category.avg_rental_count
from film
join 
(select inventory.film_id,count(rental.rental_id) as rental_count from rental 
join 
inventory on rental.inventory_id = inventory.inventory_id
group by 
inventory.film_id) as film_rentals
on 
film.film_id = film_rentals.film_id
join 
category_avg on film.film_id = category.film_id
where 
film_rentals.rental_count < category.avg_rental_count
order by 
category.name, film_rentals.rental_count;
select * from category;

## 10. Identify the top 5 months with the highest revenue and display the revenue generated in each month.?
## ans. 
select 
date_format(payment.payment_date,'%Y-%m') as month,
sum(payment.amount) as Total_revenue
from payment
group by 
date_format(payment.payment_date,'%Y-%m') 
order by 
Total_revenue desc
limit 5; 

## Normalisation & CTE:
## 1. First Normal Form (1NF):               
##   Identify a table in the Sakila database that violates 1NF. 
##   Explain how you would normalize it to achieve 1NF.
## ans. 
	## Identify a table in the Sakila database that violates 1NF.
  select table_name ,column_name, data_type from information_schema.columns where table_schema = 'sakila' and (data_type like '%array%' or data_type like '%set%');
  use mavenmovies;
  select * from film;
  select distinct special_features_2 from film;
  ## Explain how you would normalize it to achieve 1NF.
## hence ,, it is identified that in database table named film , column named special_features_2 violates 1NF because, it contains two words values, and to normalise , 
##  it should be splitted and should be seperated by column.

## 2.  Choose a table in Sakila and describe how you would determine whether it is in 2NF.             
##     If it violates 2NF, explain the steps to normalize it.
## ans. 
##  Choose a table in Sakila and describe how you would determine whether it is in 2NF.
## 
select table_name, column_name from information_schema.key_column_usage where table_schema = 'sakila' and table_name = 'actor' and constraint_name = 'primary';
## I selected table named actor, in which it violates 2NF, in this table column named actor_id violates 2NF, because this column depends on only one column named actor_name,
## hence, it is a violation on not depending fully on entire primary key..
## Here are some steps to achieve 2NF.. :- 
## A. To resolve this 2NF, we can split 2 tables, like Actor table for primary key, and Film_actor table for foreign key.. 

## 3. Identify a table in Sakila that violates 3NF. Describe the transitive dependencies                
##		present and outline the steps to normalize the table to 3NF.
## ans. 
select table_name as payment,column_name,constraint_name,referenced_table_name,referenced_column_name from information_schema.key_column_usage 
where table_schema = 'mavenmovies' and table_name = 'payment';

## Transitive dependencies :- Here customer_payment depends upon customer_id, in which it internally depends upon payment_id via foreign key.
## So, hereby, this is a transitive dependency, because, customer_payment does not directly depend on payment_id..
## thus this table table 3NF..

##  Steps to normalise this table :-
## create a table named customer, and move customer_id column to this table, and remove this column on payment table, and add column named customer_payments..

## 4.  Take a specific table in Sakila and guide through the process of normalizing it from the initial              
## 		unnormalized form up to at least 2NF.?
## ans. 
select table_name ,column_name, data_type from information_schema.columns where table_schema = 'sakila' and (data_type like '%array%' or data_type like '%set%');
select * from film;
## lets identify firstly 1NF table in sakilla databse which is film table, under film table column name special_features is violating 1NF. 
## It means this column is carrying 2 words or values at a time.. 
## To normalize this table this column to be splitted into two columns by using split function. and therefore , this table is being normalized..

## to normalize 2NF, ensure that this table is in 1NF. 
## hence, film table is in 1NF. 
## To normalize 2NF, firstly we should identify, tables primary keys and should be seperated to another new table. 
## the primary keys of film table is :- (film_id,actor_id,category_name)..
## lets create two tables named :- film_table,film_details.
## in film_details we put thre primary keys columns i.e., (film_id,actor_id,category_name)  and on another table we put rest of columns which are of film table..
## hence, upto 2NF , this steps are useful to normalize the tables..

## 5. Write a query using a CTE to retrieve the distinct list of actor names and the number of films they                 
##		have acted in from the actor and film_actor tables.?
## ans. 
select * from actor;
select * from film_actor;
with dist_act as (
select actor.actor_id, concat(actor.first_name,'',actor.last_name) as actor_name, count(film_actor.film_id) as film_count
from actor  
join 
film_actor  
on 
actor.actor_id = film_actor.actor_id 
group by
actor.actor_id, actor.first_name,actor.last_name)
select actor_name,film_count from dist_act order by film_count desc , actor_name;

## 6. . Create a CTE that combines information from the film and language tables to display the film title,                  
##		language name, and rental rate.
## ans. 
with info as (
select film.film_id,
film.title as film_title, 
language.name as lang_name,
film.rental_rate  from film
join 
language on 
film.language_id = language.language_id)
select film_title,lang_name,rental_rate from info order by film_title;

## 7. Write a query using a CTE to find the total revenue generated by each customer (sum of payments)                 
#		from the customer and payment tables.?
## ans. 
with cust_rev as (
select 
customer.customer_id , concat(customer.first_name,'',customer.last_name) as cust_name, sum(payment.amount) as total_rev
from customer
join 
payment
on customer.customer_id = payment.customer_id
group by 
customer.customer_id , customer.first_name,customer.last_name) 
select cust_name,total_rev from cust_rev order by total_rev desc, cust_name;

## 8.  Utilize a CTE with a window function to rank films based on their rental duration from the film table.?
## ans. 
use mavenmovies;
with film_rank as (select title as film_title,rental_duration,RANK() over (order by rental_duration desc, title asc) AS rank from film)
select rank,film_title,rental_duration from film_rank order by rank; 
select * from film;

## 9. . Create a CTE to list customers who have made more than two rentals, and then join this CTE with the             
##		customer table to retrieve additional customer details.?
## ans. 
with cust_rentals as ( select customer_id, count(*) as rental_count from rental group by customer_id having count(*) >2)
select customer.customer_id, customer.first_name,customer.last_name,customer.email,cust_rentals.rental_count from customer join cust_rentals on customer.customer_id = cust_rentals.customer_id;

## 10. Write a query using a CTE to find the total number of rentals made each month, considering the rental_date from the rental table.?
# ans. 
with mon_rentals as (select date_format(rental_date, '%Y-%m') as rental_month , count(*) as total_results
from rental group by date_format(rental_date, '%Y-%m')) select rental_month, total_results from mon_rentals order by rental_month;

## 11.  Create a CTE to generate a report showing pairs of actors who have appeared in the same film together, using the film_actor table.
## ans. 
with act_pair as ( 
select fa1.actor_id as actor_id_1,
fa2.actor_id as actor_id_2,
fa1.film_id 
from film_actor fa1
join 
film_actor fa2
on 
fa1.film_id = fa2.film_id and fa1.actor_id < fa2.actor_id )
select 
ap.film_id, 
a1.actor_id as actor_id_1,
a1.first_name as actor1_first_name,
a1.last_name as actor1_last_name,
a2.actor_id as actor_id_2,
a2.first_name as actor2_first_name,
a2.last_name as actor2_last_name from 
act_pair ap
join actor a1 
on 
ap.actor_id_1 = a1.actor_id
join 
actor a2 
on 
ap.actor_id_2 = a2.actor_id
order by 
ap.film_id,a1.actor_id,a2.actor_id;

## 12.  Implement a recursive CTE to find all employees in the staff table who report to a specific manager, considering the reports_to column.?
# ans. 
select * from staff;
with recursive staff_h as ( select staff_id,first_name,last_name,last_update from staff 
where staff_id  = 1
union all 
select 
s.staff_id,
s.first_name,
s.last_name,
s.last_update 
from staff s 
join 
staff_h sh 
on s.email = sh.staff_id )
select staff_id,
first_name,
last_name,
last_update 
from 
staff_h 
order by 
last_update,staff_id;
