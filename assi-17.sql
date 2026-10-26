
-- =====================================================
-- QUESTION 1:
-- Create a Restaurant table and insert at least 5
-- sample restaurants representing popular Zomato venues.
-- =====================================================

CREATE DATABASE IF NOT EXISTS Zomato_Practice;
USE Zomato_Practice;

CREATE TABLE Restaurant (
    id INT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    cuisine VARCHAR(50),
    location VARCHAR(100),
    average_rating DECIMAL(2,1)
);

INSERT INTO Restaurant (id, name, cuisine, location, average_rating)
VALUES
(1, 'Spice Garden', 'Indian', 'Ahmedabad', 4.5),
(2, 'Pizza Corner', 'Italian', 'Mumbai', 4.2),
(3, 'Dosa Delight', 'South Indian', 'Ahmedabad', 4.6),
(4, 'Burger Hub', 'Fast Food', 'Delhi', 4.1),
(5, 'Royal Biryani', 'Indian', 'Hyderabad', 4.7),
(6, 'Pasta House', 'Italian', 'Pune', 4.3);

-- Display all restaurants
SELECT *
FROM Restaurant;


-- =====================================================
-- QUESTION 2:
-- Generate a report showing the number of restaurants
-- for each cuisine type, ordered by count descending.
-- =====================================================

SELECT
    cuisine,
    COUNT(*) AS total_restaurants
FROM Restaurant
GROUP BY cuisine
ORDER BY total_restaurants DESC;


-- =====================================================
-- QUESTION 3:
-- Create a Review table and insert at least 10 reviews,
-- linking each review to a restaurant using restaurant_id.
-- =====================================================

CREATE TABLE Review (
    id INT PRIMARY KEY,
    restaurant_id INT,
    user_name VARCHAR(100),
    rating DECIMAL(2,1),
    review_date DATE,

    FOREIGN KEY (restaurant_id)
        REFERENCES Restaurant(id)
);

INSERT INTO Review (id, restaurant_id, user_name, rating, review_date)
VALUES
(1, 1, 'Rahul', 4.5, '2026-09-01'),
(2, 1, 'Priya', 4.0, '2026-09-02'),
(3, 2, 'Amit', 4.2, '2026-09-03'),
(4, 2, 'Neha', 4.6, '2026-09-04'),
(5, 3, 'Karan', 4.8, '2026-09-05'),
(6, 3, 'Sneha', 4.4, '2026-09-06'),
(7, 4, 'Rohit', 3.9, '2026-09-07'),
(8, 4, 'Anjali', 4.3, '2026-09-08'),
(9, 5, 'Vikas', 4.9, '2026-09-09'),
(10, 5, 'Meera', 4.7, '2026-09-10'),
(11, 6, 'Arjun', 4.1, '2026-09-11'),
(12, 6, 'Pooja', 4.5, '2026-09-12');

-- Display all reviews
SELECT *
FROM Review;


-- =====================================================
-- QUESTION 4:
-- Use a JOIN to display each restaurant's name, cuisine,
-- and average review rating, ordered by highest average
-- review rating first.
-- =====================================================

SELECT
    r.name AS restaurant_name,
    r.cuisine,
    ROUND(AVG(rv.rating), 2) AS average_review_rating
FROM Restaurant AS r
JOIN Review AS rv
    ON r.id = rv.restaurant_id
GROUP BY r.id, r.name, r.cuisine
ORDER BY average_review_rating DESC;


-- =====================================================
-- QUESTION 5:
-- Rank restaurants by their average review rating
-- within each cuisine type using a window function.
-- Display restaurant name, cuisine, average rating, rank.
-- =====================================================

SELECT
    restaurant_name,
    cuisine,
    average_review_rating,
    RANK() OVER (
        PARTITION BY cuisine
        ORDER BY average_review_rating DESC
    ) AS restaurant_rank
FROM (
    SELECT
        r.id,
        r.name AS restaurant_name,
        r.cuisine,
        ROUND(AVG(rv.rating), 2) AS average_review_rating
    FROM Restaurant AS r
    JOIN Review AS rv
        ON r.id = rv.restaurant_id
    GROUP BY r.id, r.name, r.cuisine
) AS RestaurantRatings
ORDER BY cuisine, restaurant_rank;