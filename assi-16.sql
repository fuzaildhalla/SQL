CREATE DATABASE food_delivery_db;

USE food_delivery_db;


CREATE TABLE FoodOrders (
    order_id INT PRIMARY KEY,
    restaurant_name VARCHAR(100),
    customer_name VARCHAR(100),
    order_amount DECIMAL(10, 2),
    order_date DATE
);


SELECT *
FROM FoodOrders;


-- Q.2)



CREATE TABLE TopSongs (
    song_id INT PRIMARY KEY,
    song_title VARCHAR(150),
    artist VARCHAR(100),
    streams BIGINT,
    release_date DATE
);

INSERT INTO TopSongs
    (song_id, song_title, artist, streams, release_date)
VALUES
    (1, 'Blinding Lights', 'The Weeknd', 4500000000, '2019-11-29'),
    (2, 'Shape of You', 'Ed Sheeran', 4000000000, '2017-01-06'),
    (3, 'As It Was', 'Harry Styles', 3500000000, '2022-04-01'),
    (4, 'Starboy', 'The Weeknd', 3000000000, '2016-09-22'),
    (5, 'Perfect', 'Ed Sheeran', 2800000000, '2017-03-03');
    
    
    
    
    SELECT *
FROM TopSongs;



-- Q3)


SELECT
    customer_name,
    SUM(order_amount) AS total_spent
FROM FoodOrders
GROUP BY customer_name
ORDER BY total_spent DESC
LIMIT 3;


-- 4)

SELECT
    restaurant_name,
    COUNT(order_id) AS total_orders,
    SUM(order_amount) AS total_order_amount
FROM FoodOrders
GROUP BY restaurant_name
ORDER BY total_order_amount DESC;




-- 5)

SELECT
    'Average Order Amount' AS kpi_name,
    ROUND(AVG(order_amount), 2) AS kpi_value
FROM FoodOrders

UNION ALL

SELECT
    'Unique Customers' AS kpi_name,
    COUNT(DISTINCT customer_name) AS kpi_value
FROM FoodOrders;

























