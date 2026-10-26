
-- ============================================================
-- QUESTION 1:
-- Display the total number of songs uploaded by each artist.
-- Show only artists who have uploaded more than 3 songs.
-- ============================================================

-- Create the songs table
CREATE TABLE songs (
    song_id INT PRIMARY KEY,
    artist_name VARCHAR(100),
    title VARCHAR(150)
);

-- Insert sample data
INSERT INTO songs (song_id, artist_name, title)
VALUES
(1, 'Arijit Singh', 'Tum Hi Ho'),
(2, 'Arijit Singh', 'Channa Mereya'),
(3, 'Arijit Singh', 'Kesariya'),
(4, 'Arijit Singh', 'Apna Bana Le'),
(5, 'Arijit Singh', 'Agar Tum Saath Ho'),
(6, 'Shreya Ghoshal', 'Teri Ore'),
(7, 'Shreya Ghoshal', 'Saans'),
(8, 'Shreya Ghoshal', 'Deewani Mastani'),
(9, 'Atif Aslam', 'Tera Hone Laga Hoon'),
(10, 'Atif Aslam', 'Jeene Laga Hoon');

-- Query
SELECT
    artist_name,
    COUNT(*) AS total_songs
FROM songs
GROUP BY artist_name
HAVING COUNT(*) > 3;


-- ============================================================
-- QUESTION 2:
-- Display each username along with their total order amount
-- using the orders and users tables.
-- ============================================================

-- Create the users table
CREATE TABLE users (
    user_id INT PRIMARY KEY,
    username VARCHAR(100)
);

-- Create the orders table
CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    user_id INT,
    amount DECIMAL(10, 2),
    FOREIGN KEY (user_id) REFERENCES users(user_id)
);

-- Insert sample users
INSERT INTO users (user_id, username)
VALUES
(1, 'Rahul'),
(2, 'Priya'),
(3, 'Amit'),
(4, 'Neha');

-- Insert sample orders
INSERT INTO orders (order_id, user_id, amount)
VALUES
(101, 1, 500.00),
(102, 1, 750.00),
(103, 2, 1200.00),
(104, 2, 300.00),
(105, 3, 900.00),
(106, 4, 450.00),
(107, 3, 600.00);

-- Query
SELECT
    u.username,
    SUM(o.amount) AS total_order_amount
FROM users AS u
JOIN orders AS o
    ON u.user_id = o.user_id
GROUP BY u.user_id, u.username
ORDER BY total_order_amount DESC;


-- ============================================================
-- QUESTION 3:
-- Find restaurants whose rating is higher than the average
-- rating of all restaurants using a subquery.
-- ============================================================

-- Create the restaurants table
CREATE TABLE restaurants (
    id INT PRIMARY KEY,
    name VARCHAR(100),
    rating DECIMAL(2, 1)
);

-- Insert sample restaurant data
INSERT INTO restaurants (id, name, rating)
VALUES
(1, 'Spice Garden', 4.5),
(2, 'Pizza Corner', 3.8),
(3, 'Dosa Delight', 4.7),
(4, 'Burger Hub', 3.9),
(5, 'Royal Biryani', 4.8);

-- Query
SELECT
    name,
    rating
FROM restaurants
WHERE rating > (
    SELECT AVG(rating)
    FROM restaurants
);


-- ============================================================
-- QUESTION 4:
-- Display each user's transaction amount and running total
-- ordered by transaction_date using a window function.
-- ============================================================

-- Create the transactions table
CREATE TABLE transactions (
    id INT PRIMARY KEY,
    user_id INT,
    amount DECIMAL(10, 2),
    transaction_date DATE
);

-- Insert sample transaction data
INSERT INTO transactions (id, user_id, amount, transaction_date)
VALUES
(1, 101, 500.00, '2026-10-01'),
(2, 101, 300.00, '2026-10-02'),
(3, 102, 700.00, '2026-10-02'),
(4, 101, 200.00, '2026-10-03'),
(5, 102, 400.00, '2026-10-04'),
(6, 103, 600.00, '2026-10-04'),
(7, 103, 250.00, '2026-10-05');

-- Query
SELECT
    id,
    user_id,
    amount,
    transaction_date,
    SUM(amount) OVER (
        PARTITION BY user_id
        ORDER BY transaction_date, id
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) AS running_total
FROM transactions
ORDER BY user_id, transaction_date, id;


-- ============================================================
-- QUESTION 5:
-- List two optimizations for a query filtering Flipkart
-- products by category and price.
-- ============================================================

-- Example table
CREATE TABLE flipkart_products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(150),
    category VARCHAR(100),
    price DECIMAL(10, 2)
);

-- Optimization 1: Create a composite index
CREATE INDEX idx_category_price
ON flipkart_products (category, price);

-- Optimization 2: Write a query that filters directly
-- on the indexed columns
SELECT
    product_id,
    product_name,
    category,
    price
FROM flipkart_products
WHERE category = 'Electronics'
  AND price BETWEEN 1000 AND 50000
ORDER BY price;