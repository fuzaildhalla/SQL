/*1.)
Create a table called Orders with columns: order_id, user_id,
 payment_method, and amount. Insert at least 8 sample records representing 
 different users and payment methods (like UPI, Card, Wallet, COD). */

create table orders2(
order_id int  primary key,
user_id int ,
payment_method varchar(100),
amount int 
);

select * from orders2;

INSERT INTO orders2 (order_id, user_id, payment_method, amount)
VALUES
(1, 101, 'UPI', 1500),
(2, 102, 'Card', 2500),
(3, 103, 'Wallet', 800),
(4, 101, 'COD', 1200),
(5, 104, 'UPI', 3000),
(6, 105, 'Card', 1800),
(7, 102, 'Wallet', 950),
(8, 106, 'COD', 2200),
(9, 103, 'UPI', 1100),
(10, 104, 'Card', 4000);

select * from orders2;

/* 2.)
Write an SQL query to count how many orders were placed using each payment_method in the Orders table,
 similar to how Zomato shows payment breakdown in analytics.
*/

select 
payment_method,
count(*) as count
from orders2
group by payment_method;

/* 3.) Write an SQL query to find the total amount spent by each user_id in the Orders table. Display user_id and their total spend.
*/
select * from orders2;
select 
user_id,
sum(amount) as count
from orders2
group by user_id;
/* 4.
Write an SQL query to show only those payment methods where the average order amount is greater than 300, 
using GROUP BY and HAVING.<br><br><em><strong>Hint:</strong> Use AVG(amount) in your HAVING clause.</em>
*/


SELECT payment_method, AVG(amount) AS average_amount
FROM orders2
GROUP BY payment_method
HAVING AVG(amount) > 300;


/* 5.
Explain the difference between WHERE and HAVING by giving one example query for each, 
using the Orders table. Your examples should show a scenario where WHERE and HAVING filter different things.
*/


-- The main difference is:
-- WHERE filters individual rows before grouping.
-- HAVING filters groups after using GROUP BY.

			--  WHERE — Filter individual orders

SELECT *
FROM orders
WHERE total_amount > 2000;


			-- HAVING — Filter groups of orders
            
SELECT user_name, SUM(total_amount) AS total_spent
FROM orders
GROUP BY user_name
HAVING SUM(total_amount) > 3000;













