-- Create two tables: Influencers (id, name) and Collaborations (id, influencer1_id, influencer2_id, collab_date). Write a SQL FULL JOIN query to list all influencers and show their collaboration partner names if any, including influencers with no collaborations.

USE Joins;

CREATE TABLE Influencers (
    id INT PRIMARY KEY,
    name VARCHAR(100) NOT NULL
);

INSERT INTO Influencers (id, name)
VALUES
(1, 'Rahul'),
(2, 'Priya'),
(3, 'Amit'),
(4, 'Sneha'),
(5, 'Neha');

CREATE TABLE Collaborations (
    id INT PRIMARY KEY,
    influencer1_id INT,
    influencer2_id INT,
    collab_date DATE,

    FOREIGN KEY (influencer1_id) REFERENCES Influencers(id),
    FOREIGN KEY (influencer2_id) REFERENCES Influencers(id)
);

INSERT INTO Collaborations (id, influencer1_id, influencer2_id, collab_date)
VALUES
(101, 1, 2, '2026-01-10'),
(102, 2, 3, '2026-01-15'),
(103, 1, 4, '2026-02-01'),
(104, 3, 5, '2026-02-10'),
(105, 2, 4, '2026-02-20');

SELECT * FROM Influencers;
SELECT * FROM Collaborations;

-- SELECT 
-- 	i.name as influencers,
--     c.influencer1_id as collaboration_partner
-- FROM influencers as i
-- LEFT JOIN collaborations as c
-- 	ON i.id = influencer1_id
-- LEFT JOIN influencers as i
-- 	ON i.id = influencer2_id

-- UNION 

-- SELECT 
-- 	i.name as influencers,
--     c.influencer2_id as collaboration_partner
-- FROM influencers as i
-- JOIN collaborations as c
-- 	ON i.id = influencer2_id
-- LEFT JOIN influencers as i
-- 	ON i.id = influencer1_id;

SELECT
    i.name AS influencer_name,
    partner.name AS collaboration_partner
FROM Influencers AS i
LEFT JOIN Collaborations AS c
    ON i.id = c.influencer1_id
LEFT JOIN Influencers AS partner
    ON c.influencer2_id = partner.id

UNION

SELECT
    i.name AS influencer_name,
    partner.name AS collaboration_partner
FROM Influencers AS i
LEFT JOIN Collaborations AS c
    ON i.id = c.influencer2_id
JOIN Influencers AS partner
    ON c.influencer1_id = partner.id;
    

-- Using a SELF JOIN, write a query on a table called Playlists (id, user_id, playlist_name, parent_playlist_id) to display each playlist alongside its parent playlist name, similar to how Spotify shows nested playlists.<br><br><em><strong>Hint:</strong> Join Playlists with itself on parent_playlist_id = id.</em>

USE Joins;

CREATE TABLE Playlist (
    id INT PRIMARY KEY,
    user_id INT,
    playlist_name VARCHAR(100),
    parent_playlist_id INT,
    FOREIGN KEY (parent_playlist_id) REFERENCES Playlist(id)
);

INSERT INTO Playlist (id, user_id, playlist_name, parent_playlist_id)
VALUES
    (1, 101, 'Rock', NULL),
    (2, 101, 'Classic Rock', 1),
    (3, 102, 'Pop', NULL),
    (4, 101, 'Hard Rock', 1),
    (5, 102, 'K-Pop', 3);
    
SELECT * FROM Playlist;
    
SELECT 
	p1.playlist_name,
	p2.playlist_name as parent_playlist_name
FROM playlist as p1
LEFT JOIN playlist as p2
	ON p1.id = p2.parent_playlist_id;



    -- Given three tables: Users (id, username), Orders (id, user_id, order_date), and Payments (id, order_id, amount), write a SQL query using multiple JOINs to display each username, their order date, and payment amount, showing all users even if they have no orders or payments.

USE Joins;

CREATE TABLE Orders (
    id INT PRIMARY KEY,
    user_id INT,
    order_date DATE
);

INSERT INTO Orders (id, user_id, order_date)
VALUES
    (101, 1, '2026-01-10'),
    (102, 1, '2026-01-15'),
    (103, 2, '2026-02-05'),
    (104, 4, '2026-02-20'),
    (105, 5, '2026-03-01');
    
    
CREATE TABLE Payments (
    id INT PRIMARY KEY,
    order_id INT,
    amount DECIMAL(10, 2)
);

INSERT INTO Payments (id, order_id, amount)
VALUES
    (201, 101, 150.00),
    (202, 102, 250.50),
    (203, 104, 500.00),
    (204, 105, 120.75);
    

ALTER TABLE Users
ADD COLUMN order_id INT;

ALTER TABLE Users
ADD CONSTRAINT fk_users_orders
FOREIGN KEY (order_id)
REFERENCES Orders(id);

SET SQL_SAFE_UPDATES = 0;

UPDATE Users
SET order_id = CASE
    WHEN user_id = 1 THEN 101
    WHEN user_id = 2 THEN 103
    WHEN user_id = 3 THEN NULL
    WHEN user_id = 4 THEN 104
    WHEN user_id = 5 THEN 105
END;
    
SELECT * FROM users;
SELECT * FROM payments;
SELECT * FROM orders;

SELECT
	u.user_name,
    o.order_date,
    p.amount as payment_amount
FROM users as u
LEFT JOIN orders as o
	ON u.user_id = o.user_id
LEFT JOIN payments as p
	ON u.order_id = p.order_id;
    
	-- You notice that your JOIN query between Zomato's Restaurants and Reviews tables is returning duplicate rows for some restaurants. Modify your query to eliminate duplicates and explain in one line why the duplicates were happening.<br><br><em><strong>Hint:</strong> Use DISTINCT or GROUP BY and consider the relationship between restaurants and reviews.</em>

USE Joins;

CREATE TABLE Restaurant (
    restaurant_id INT PRIMARY KEY,
    restaurant_name VARCHAR(100),
    city VARCHAR(50),
    cuisine VARCHAR(50)
);

INSERT INTO Restaurant VALUES
(1, 'Spice Garden', 'Ahmedabad', 'Indian'),
(2, 'Pizza House', 'Mumbai', 'Italian'),
(3, 'Sushi World', 'Pune', 'Japanese'),
(4, 'Burger Hub', 'Delhi', 'Fast Food'),
(5, 'Curry Corner', 'Ahmedabad', 'Indian');

CREATE TABLE Reviews (
    review_id INT PRIMARY KEY,
    restaurant_id INT,
    customer_name VARCHAR(100),
    rating DECIMAL(2,1),
    FOREIGN KEY (restaurant_id)
        REFERENCES Restaurant(restaurant_id)
);

INSERT INTO Reviews VALUES
(101, 1, 'Amit', 4.5),
(102, 1, 'Priya', 4.0),
(103, 1, 'Rahul', 3.5),
(104, 2, 'Neha', 4.2),
(105, 2, 'Karan', 3.8),
(106, 3, 'Riya', 4.7),
(107, 4, 'Vikas', 3.9),
(108, 4, 'Anjali', 4.1),
(109, 5, 'Meera', 4.4);

SELECT * FROM Restaurant;
SELECT * FROM Reviews;

SELECT DISTINCT
	r.restaurant_name
FROM restaurant as r
LEFT JOIN reviews as rev
	ON r.restaurant_id = rev.restaurant_id;
-- GROUP BY r.restaurant_name

-- The duplicates happen because one restaurant can have multiple reviews, so the LEFT JOIN returns one row per review.



-- Write two different JOIN queries on a Products and Categories table (like Flipkart) to list all products with their category names, but use different join conditions in each. Briefly explain which join condition is more efficient and why.

USE Joins;

CREATE TABLE Categories (
    category_id INT PRIMARY KEY,
    category_name VARCHAR(100)
);

INSERT INTO Categories VALUES
(1, 'Electronics'),
(2, 'Clothing'),
(3, 'Books'),
(4, 'Home Appliances'),
(5, 'Footwear');

CREATE TABLE Products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100),
    price DECIMAL(10,2),
    category_id INT,
    FOREIGN KEY (category_id)
        REFERENCES Categories(category_id)
);

INSERT INTO Products VALUES
(101, 'Laptop', 55000.00, 1),
(102, 'T-Shirt', 599.00, 2),
(103, 'SQL Programming Book', 450.00, 3),
(104, 'Washing Machine', 22000.00, 4),
(105, 'Running Shoes', 2499.00, 5),
(106, 'Smartphone', 30000.00, 1),
(107, 'Jeans', 1299.00, 2),
(108, 'Headphones', 1999.00, 1);

SELECT * FROM Categories;
SELECT * FROM Products;

-- SELECT 
-- 	p.product_name,
--     c.category_name
-- FROM Products as p
-- RIGHT JOIN Categories as c
-- 	ON p.category_id = c.category_id;
    

SELECT 
	p.product_name,
    c.category_name
FROM Products as p
LEFT JOIN Categories as c
	ON p.category_id = c.category_id;
    
    
-- SELECT 
-- 	p.product_name,
--     c.category_name
-- FROM Categories as c
-- LEFT JOIN Products as p
-- 	ON p.category_id = c.category_id;
    
-- SELECT
-- 	c.category_name
-- FROM Categories as c
-- LEFT JOIN Products as p
-- 	ON p.category_id = c.category_id;
    
-- SELECT 
--     c.category_name
-- FROM Products as p
-- LEFT JOIN Categories as c
-- 	ON p.category_id = c.category_id;