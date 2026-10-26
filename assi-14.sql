-- Create a table called Orders with columns: order_id, user_id, order_date, and total_amount. Insert at least 7 sample rows representing different users and dates, similar to how food orders appear in Zomato or Swiggy.

CREATE DATABASE OrderPractice;
USE OrderPractice;

CREATE TABLE Orders (
    order_id INT PRIMARY KEY,
    user_id INT,
    order_date DATE,
    total_amount DECIMAL(10,2)
);

INSERT INTO Orders
    (order_id, user_id, order_date, total_amount)
VALUES
    (101, 1, '2026-10-01', 250.00),
    (102, 2, '2026-10-01', 180.00),
    (103, 1, '2026-10-03', 320.00),
    (104, 3, '2026-10-04', 450.00),
    (105, 2, '2026-10-05', 220.00),
    (106, 1, '2026-10-06', 150.00),
    (107, 3, '2026-10-07', 300.00),
    (108, 2, '2026-10-08', 400.00),
    (109, 1, '2026-10-09', 500.00),
    (110, 3, '2026-10-10', 200.00);
    
SELECT * FROM Orders;


-- Create a table called Orders with columns: order_id, user_id, order_date, and total_amount. Insert at least 7 sample rows representing different users and dates, similar to how food orders appear in Zomato or Swiggy.

CREATE DATABASE OrderPractice;
USE OrderPractice;

CREATE TABLE Orders (
    order_id INT PRIMARY KEY,
    user_id INT,
    order_date DATE,
    total_amount DECIMAL(10,2)
);

INSERT INTO Orders
    (order_id, user_id, order_date, total_amount)
VALUES
    (101, 1, '2026-10-01', 250.00),
    (102, 2, '2026-10-01', 180.00),
    (103, 1, '2026-10-03', 320.00),
    (104, 3, '2026-10-04', 450.00),
    (105, 2, '2026-10-05', 220.00),
    (106, 1, '2026-10-06', 150.00),
    (107, 3, '2026-10-07', 300.00),
    (108, 2, '2026-10-08', 400.00),
    (109, 1, '2026-10-09', 500.00),
    (110, 3, '2026-10-10', 200.00);
    
SELECT * FROM Orders;



-- Using the same Orders table, write a SQL query with the LEAD() function to display each order_id, order_date, and the next order's total_amount for the same user.

USE OrderPractice;

SELECT
    order_id,
    user_id,
    order_date,
    total_amount,
    LEAD(total_amount) OVER (
        PARTITION BY user_id
        ORDER BY order_date
    ) AS next_order_amount
FROM Orders
ORDER BY user_id, order_date;


-- Write a SQL query to calculate the running total of total_amount for each user, showing order_id, order_date, total_amount, and a column running_total that accumulates the sum as you move through each user's orders.<br><br><em><strong>Hint:</strong> Use SUM(total_amount) OVER (PARTITION BY user_id ORDER BY order_date ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW).</em>

USE OrderPractice;

SELECT
    order_id,
    user_id,
    order_date,
    total_amount,
    SUM(total_amount) OVER (
        PARTITION BY user_id
        ORDER BY order_date
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) AS running_total
FROM Orders
ORDER BY user_id, order_date;



-- Write a SQL query to calculate a 3-order moving average of total_amount for each user, showing order_id, order_date, total_amount, and moving_avg columns.<br><br><em><strong>Constraint:</strong> Use SUM() OVER() with ROWS BETWEEN 2 PRECEDING AND CURRENT ROW to compute the moving average.</em>

USE OrderPractice;

SELECT
    order_id,
    user_id,
    order_date,
    total_amount,
    SUM(total_amount) OVER (
        PARTITION BY user_id
        ORDER BY order_date
        ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
    )
    /
    COUNT(*) OVER (
        PARTITION BY user_id
        ORDER BY order_date
        ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
    ) AS moving_avg
FROM Orders
ORDER BY user_id, order_date;