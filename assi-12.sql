
CREATE DATABASE sql_cte_practice;

USE sql_cte_practice;

CREATE TABLE Products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100),
    brand VARCHAR(100),
    rating DECIMAL(2,1),
    price DECIMAL(10,2)
);

INSERT INTO Products (product_id, product_name, brand, rating, price)
VALUES
(1, 'Running Shoes', 'Nike', 4.8, 4500.00),
(2, 'Cotton T-Shirt', 'Puma', 4.3, 999.00),
(3, 'Denim Jeans', 'Levis', 4.6, 2499.00),
(4, 'Smart Watch', 'Samsung', 4.7, 5999.00),
(5, 'Casual Sneakers', 'Adidas', 4.2, 3200.00),
(6, 'Winter Jacket', 'H&M', 4.9, 3999.00),
(7, 'Backpack', 'Wildcraft', 4.5, 1499.00),
(8, 'Wireless Earbuds', 'Boat', 4.1, 1799.00);

CREATE TABLE Restaurants (
    restaurant_id INT PRIMARY KEY,
    restaurant_name VARCHAR(100),
    city VARCHAR(100),
    delivery_charge DECIMAL(6,2)
);


INSERT INTO Restaurants
(restaurant_id, restaurant_name, city, delivery_charge)
VALUES
(1, 'Spice Garden', 'Ahmedabad', 30.00),
(2, 'Pizza Corner', 'Ahmedabad', 45.00),
(3, 'Burger Hub', 'Ahmedabad', 60.00),
(4, 'Dosa Delight', 'Ahmedabad', 25.00),
(5, 'Dragon Wok', 'Mumbai', 40.00),
(6, 'Royal Biryani House', 'Ahmedabad', 50.00),
(7, 'Green Bowl Cafe', 'Pune', 35.00),
(8, 'Tandoori Nights', 'Ahmedabad', 20.00);



CREATE TABLE Users (
    user_id INT PRIMARY KEY,
    username VARCHAR(100),
    followers INT
);




INSERT INTO Users (user_id, username, followers)
VALUES
(1, 'rahul_travels', 15000),
(2, 'priya_fashion', 8500),
(3, 'tech_with_amit', 25000),
(4, 'foodie_neha', 1200),
(5, 'fitness_karan', 45000),
(6, 'sneha_photography', 950),
(7, 'daily_coding', 32000),
(8, 'the_movie_buff', 700);




CREATE TABLE Posts (
    post_id INT PRIMARY KEY,
    user_id INT,
    caption VARCHAR(255),
    likes INT,
    FOREIGN KEY (user_id) REFERENCES Users(user_id)
);

INSERT INTO Posts (post_id, user_id, caption, likes)
VALUES
(101, 1, 'My travel adventure', 2500),
(102, 2, 'Summer fashion trends', 4200),
(103, 3, 'Learn SQL in 30 days', 8500),
(104, 4, 'Best street food', 1800),
(105, 5, 'My fitness journey', 6500),
(106, 6, 'Sunset photography', 3200),
(107, 7, 'Python programming tips', 9200),
(108, 8, 'My favourite movies', 1100),
(109, 2, 'Outfit of the day', 5700),
(110, 3, 'Top programming tools', 7100);


/* 1.
Create a CTE using the WITH clause to select all products with a rating above 4.5 from a 
'Products' table, similar to how Flipkart or Myntra might highlight top-rated items.
*/


WITH Top_Rated_Products AS (
    SELECT *
    FROM Products
    WHERE rating > 4.5
)
SELECT *
FROM Top_Rated_Products;



/* Rewrite a query that finds all restaurants in 'Ahmedabad' with delivery charges under 50 from a '
Restaurants' table, first using a subquery and then using a CTE. Compare both queries for readability.
 Focus on making the CTE version cleaner and easier to understand.</em>
*/
SELECT *
FROM (
    SELECT *
    FROM Restaurants
    WHERE city = 'Ahmedabad'
) AS AhmedabadRestaurants
WHERE delivery_charge < 50;


/* 3.)
Using two CTEs in a single query, find the top 3 most-followed users and the top 3 most-liked posts from a
 'Users' and 'Posts' table (think Instagram-style data). Output both lists in the same result set.
*/
WITH TopUsers AS (
    SELECT user_id, username, followers
    FROM Users
    ORDER BY followers DESC
    LIMIT 3
),
TopPosts AS (
    SELECT post_id, caption, likes
    FROM Posts
    ORDER BY likes DESC
    LIMIT 3
)

SELECT
    'Top Users' AS category,
    username AS name,
    followers AS count
FROM TopUsers

UNION ALL

SELECT
    'Top Posts' AS category,
    caption AS name,
    likes AS count
FROM TopPosts;


/* 4.
Write a recursive CTE that generates a list of dates for the next 7 days starting from today,
 similar to how BookMyShow shows available dates for movie bookings. Use a base case for today and recursion to add one day at a time.
*/

WITH RECURSIVE DateList AS (
    -- Base case: start with today's date
    SELECT
        CURDATE() AS booking_date,
        1 AS day_number

    UNION ALL

    -- Recursive case: add one day
    SELECT
        DATE_ADD(booking_date, INTERVAL 1 DAY),
        day_number + 1
    FROM DateList
    WHERE day_number < 7
)
SELECT booking_date
FROM DateList;




/*Given a messy SQL query that finds all users with more than 1000 followers from a 
'Users' table, refactor it to use a CTE for better clarity and maintainability.
*/

SELECT user_id, username, followers
FROM Users
WHERE followers > 1000;

WITH UsersWithMoreThan1000Followers AS (
    SELECT user_id, username, followers
    FROM Users
    WHERE followers > 1000
)
SELECT *
FROM UsersWithMoreThan1000Followers;


