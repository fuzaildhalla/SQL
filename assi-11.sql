
CREATE TABLE Restaurants (
    restaurant_id INT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    city VARCHAR(50) NOT NULL,
    rating DECIMAL(2, 1) NOT NULL
);

INSERT INTO Restaurants (restaurant_id, name, city, rating) VALUES
(1, 'Spice Garden', 'Mumbai', 4.5),
(2, 'Ocean Breeze', 'Mumbai', 3.8),
(3, 'Tandoori Nights', 'Mumbai', 4.2),
(4, 'Curry Leaf', 'Delhi', 4.6),
(5, 'Dhaba Express', 'Delhi', 3.5);


CREATE TABLE Users (
    user_id INT PRIMARY KEY,
    name VARCHAR(100) NOT NULL
);

CREATE TABLE Orders (
    order_id INT PRIMARY KEY,
    user_id INT NOT NULL,
    order_date DATE NOT NULL,
    FOREIGN KEY (user_id) REFERENCES Users(user_id)
);

INSERT INTO Users (user_id, name) VALUES
(1, 'Aarav Sharma'),
(2, 'Diya Patel'),
(3, 'Rohan Mehta');

INSERT INTO Orders (order_id, user_id, order_date) VALUES
(101, 1, '2026-01-10'),
(102, 1, '2026-02-14'),
(103, 1, '2026-03-01'),
(104, 2, '2026-02-20');

-- Tables for Question 3: Movies & Reviews
CREATE TABLE Movies (
    movie_id INT PRIMARY KEY,
    title VARCHAR(100) NOT NULL
);

CREATE TABLE Reviews (
    review_id INT PRIMARY KEY,
    movie_id INT NOT NULL,
    rating INT NOT NULL,
    FOREIGN KEY (movie_id) REFERENCES Movies(movie_id)
);

INSERT INTO Movies (movie_id, title) VALUES
(1, 'Inception'),
(2, 'Interstellar'),
(3, 'The Matrix'),
(4, 'Tenet');

INSERT INTO Reviews (review_id, movie_id, rating) VALUES
(201, 1, 5),
(202, 1, 4),
(203, 2, 5),
(204, 3, 3),
(205, 4, 2);

-- Tables for Question 4: Sellers, Categories, Products & Order_Items
CREATE TABLE Sellers (
    seller_id INT PRIMARY KEY,
    name VARCHAR(100) NOT NULL
);

CREATE TABLE Categories (
    category_id INT PRIMARY KEY,
    category_name VARCHAR(50) NOT NULL
);

CREATE TABLE Products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100) NOT NULL,
    category_id INT NOT NULL,
    FOREIGN KEY (category_id) REFERENCES Categories(category_id)
);

CREATE TABLE Order_Items (
    item_id INT PRIMARY KEY,
    seller_id INT NOT NULL,
    product_id INT NOT NULL,
    FOREIGN KEY (seller_id) REFERENCES Sellers(seller_id),
    FOREIGN KEY (product_id) REFERENCES Products(product_id)
);

INSERT INTO Sellers (seller_id, name) VALUES
(1, 'OmniRetail India'),
(2, 'ElectroWorld'),
(3, 'StyleHub');

INSERT INTO Categories (category_id, category_name) VALUES
(1, 'Electronics'),
(2, 'Fashion'),
(3, 'Home & Kitchen');

INSERT INTO Products (product_id, product_name, category_id) VALUES
(10, 'Smartphone', 1),
(20, 'Denim Jacket', 2),
(30, 'Blender', 3);

-- Seller 1 has sold products in all 3 categories (Electronics, Fashion, Home & Kitchen)
INSERT INTO Order_Items (item_id, seller_id, product_id) VALUES
(1, 1, 10),
(2, 1, 20),
(3, 1, 30),
-- Seller 2 has sold only in Electronics
(4, 2, 10),
-- Seller 3 has sold only in Fashion
(5, 3, 20);


-- =============================================================================
-- SOLUTIONS
-- =============================================================================

-- Question 1:
-- Create a SQL query using a subquery in the WHERE clause to find all restaurants 
-- from a 'Restaurants' table whose average rating is higher than the average 
-- rating of all restaurants in the city.

SELECT 
    r1.restaurant_id,
    r1.name,
    r1.city,
    r1.rating
FROM Restaurants r1
WHERE r1.rating > (
    SELECT AVG(r2.rating)
    FROM Restaurants r2
    WHERE r2.city = r1.city
);


-- Question 2:
-- Write a SQL query that uses a subquery in the SELECT statement to display each 
-- user's name from a 'Users' table along with the total number of orders they have 
-- placed from an 'Orders' table, like a summary you might see in a Zomato user profile.

SELECT 
    u.name,
    (
        SELECT COUNT(*)
        FROM Orders o
        WHERE o.user_id = u.user_id
    ) AS total_orders
FROM Users u;


-- Question 3:
-- Given a 'Movies' table and a 'Reviews' table, write a SQL query using IN with a 
-- subquery to list all movies that have at least one review with a rating of 5 stars, 
-- as seen in BookMyShow's top-rated section.

SELECT 
    movie_id,
    title
FROM Movies
WHERE movie_id IN (
    SELECT movie_id
    FROM Reviews
    WHERE rating = 5
);


-- Question 4:
-- Write a nested SQL query to find the names of all sellers from a 'Sellers' table 
-- on a Flipkart-style platform who have sold products in every category listed in 
-- a 'Categories' table.

SELECT s.name
FROM Sellers s
WHERE NOT EXISTS (
    SELECT c.category_id
    FROM Categories c
    WHERE NOT EXISTS (
        SELECT 1
        FROM Order_Items oi
        JOIN Products p ON oi.product_id = p.product_id
        WHERE oi.seller_id = s.seller_id
          AND p.category_id = c.category_id
    )
);