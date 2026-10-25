/* 1.
Create a table called Orders with columns: order_id, user_name, total_amount, and order_date.
 Insert 5 sample rows with different users and order amounts, including at least one NULL value for total_amount.*/
 
 use tops;
 
 create table orders(
 order_id int primary key,
 user_name varchar(100),
 total_amount int,
 order_date date
 )
 select * from orders;
 
 insert into orders
 (order_id,user_name,total_amount,order_date)
 values
(1, 'Rahul Sharma', 1500, '2026-01-10'),
(2, 'Priya Patel', NULL, '2026-01-12'),
(3, NULL, 2500, '2026-01-15'),
(4, 'Amit Verma', 1800, NULL),
(5, NULL, NULL, '2026-02-01'),
(6, 'Neha Singh', 3200, '2026-02-05'),
(7, 'Karan Shah', NULL, NULL),
(8, NULL, 900, '2026-02-15'),
(9, 'Sneha Joshi', 2100, NULL),
(10, NULL, NULL, NULL);
 
 INSERT INTO orders (order_id, user_name, total_amount, order_date)
VALUES
(11, 'Rahul Sharma', 2200, '2026-03-01'),
(12, 'Priya Patel', 1800, '2026-03-02'),
(13, 'Rahul Sharma', 950, '2026-03-05'),
(14, 'Amit Verma', 3100, '2026-03-07'),
(15, 'Neha Singh', 1200, '2026-03-09'),
(16, 'Priya Patel', 2600, '2026-03-12'),
(17, 'Karan Shah', 4500, '2026-03-15'),
(18, 'Rahul Sharma', 1750, '2026-03-18'),
(19, 'Amit Verma', 900, '2026-03-20'),
(20, 'Sneha Joshi', 3400, '2026-03-22');
 select 
 sum(total_amount) as sum_of_total_amount 
 from orders;
 
 
/*
2.
Write a SQL query to count how many orders were placed by each user in the Orders table,
displaying user_name and the number of orders as order_count.*/
 select * from orders;
 
 select
 user_name,
 count(*) as count_of_orders
 from orders
 group by user_name;

/* 
3.
Write a SQL query to calculate the average total_amount of all orders in the Orders table,
 making sure to ignore any NULL values. */

select 
avg(total_amount) as average 
from orders;


/* 4.
Suppose you are building a Flipkart-style dashboard: Write a SQL query to find the highest and lowest order amounts 
(MAX and MIN) from the Orders table, and display both values in a single result row
*/
select
min(total_amount) as minimum_amount,
max(total_amount) as maximum_amount
from orders;

/* 5.
Write a SQL query to calculate the total sales (SUM of total_amount) for all orders,
 but only include orders where total_amount is not NULL. Use a WHERE clause to filter out NULL values before applying the SUM function.</em>
*/
SELECT SUM(total_amount) AS total_sales
FROM orders
WHERE total_amount IS NOT NULL;