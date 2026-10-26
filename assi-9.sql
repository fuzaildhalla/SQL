-- Create two tables in your database: 'restaurants' (id, name, city) and 'dishes' (id, restaurant_id, dish_name, price). Insert at least 3 restaurants and 2-3 dishes for each restaurant.

CREATE DATABASE Joins;
USE Joins;

CREATE TABLE restaurants (
    id INT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    city VARCHAR(50) NOT NULL
);

INSERT INTO restaurants (id, name, city)
VALUES
(1, 'Spice Garden', 'Pune'),
(2, 'Food Junction', 'Mumbai'),
(3, 'Green Leaf', 'Ahmedabad');

SELECT * FROM restaurants;

CREATE TABLE dishes (
    id INT PRIMARY KEY,
    restaurant_id INT,
    dish_name VARCHAR(100) NOT NULL,
    price DECIMAL(10, 2),
    FOREIGN KEY (restaurant_id) REFERENCES restaurants(id)
);

INSERT INTO dishes (id, restaurant_id, dish_name, price)
VALUES
(101, 1, 'Paneer Tikka', 250.00),
(102, 1, 'Veg Biryani', 180.00),
(103, 1, 'Dal Makhani', 200.00),
(104, 2, 'Masala Dosa', 120.00),
(105, 2, 'Pav Bhaji', 150.00),
(106, 2, 'Veg Fried Rice', 190.00),
(107, 3, 'Gujarati Thali', 220.00),
(108, 3, 'Handvo', 100.00),
(109, 3, 'Sev Tameta', 160.00);

SELECT * FROM dishes;

INSERT INTO restaurants (id, name, city)
VALUES
(4, 'Royal Bites', 'Jaipur');

SELECT * FROM restaurants;


-- Write an SQL INNER JOIN query to display each dish along with its restaurant name and city, similar to how Zomato shows dish details with the restaurant info.

USE Joins;

SELECT 
	d.dish_name,
    r.name,
    r.city
FROM restaurants AS r
INNER JOIN dishes AS d
	ON r.id = d.restaurant_id;


    -- Write an SQL LEFT JOIN query to list all restaurants and their dishes, showing restaurants even if they currently have no dishes on the menu.<br><br><em><strong>Hint:</strong> Use LEFT JOIN so restaurants without dishes still appear in the results with NULL for dish columns.</em>

USE Joins;
    
SELECT 
	r.name,
	d.dish_name
FROM restaurants as r
LEFT JOIN dishes as d
	ON r.id = d.restaurant_id;
        
-- Write an SQL RIGHT JOIN query to display all dishes and their restaurant names, including any dishes that might not be linked to a restaurant (simulate a data error where a dish has a restaurant_id that doesn't match any restaurant).

USE Joins;

SELECT 
	d.dish_name,
    r.name
FROM dishes as d
RIGHT JOIN restaurants as r
	ON d.dish_name = r.name;


-- Given this scenario: You want to show a list of all playlists and the songs inside them, like Spotify. Explain which JOIN type (INNER, LEFT, or RIGHT) you would use to show all playlists, even if some are empty, and write the SQL query for it.

USE Joins;

CREATE TABLE users (
    user_id INT PRIMARY KEY,
    user_name VARCHAR(100) NOT NULL,
    city VARCHAR(50)
);

INSERT INTO users VALUES
(1, 'Rahul', 'Mumbai'),
(2, 'Priya', 'Pune'),
(3, 'Amit', 'Delhi'),
(4, 'Sneha', 'Ahmedabad'),
(5, 'Rohan', 'Jaipur');

CREATE TABLE playlists (
    playlist_id INT PRIMARY KEY,
    playlist_name VARCHAR(100) NOT NULL,
    user_id INT,
    created_date DATE,
    FOREIGN KEY (user_id) REFERENCES users(user_id)
);

INSERT INTO playlists VALUES
(101, 'My Favorites', 1, '2026-01-10'),
(102, 'Workout Mix', 1, '2026-02-15'),
(103, 'Romantic Songs', 2, '2026-03-01'),
(104, 'Party Hits', 3, '2026-03-10'),
(105, 'Chill Vibes', 4, '2026-04-05'),
(106, 'Study Music', 2, '2026-04-12'),
(107, 'Travel Songs', 5, '2026-05-01'),
(108, 'Empty Playlist', 3, '2026-05-15');


CREATE TABLE songs (
    song_id INT PRIMARY KEY,
    song_name VARCHAR(100) NOT NULL,
    artist VARCHAR(100),
    genre VARCHAR(50),
    duration_seconds INT
);

INSERT INTO songs VALUES
(201, 'Kesariya', 'Arijit Singh', 'Romantic', 268),
(202, 'Blinding Lights', 'The Weeknd', 'Pop', 200),
(203, 'Perfect', 'Ed Sheeran', 'Romantic', 263),
(204, 'Believer', 'Imagine Dragons', 'Rock', 204),
(205, 'Tum Hi Ho', 'Arijit Singh', 'Romantic', 262),
(206, 'Levitating', 'Dua Lipa', 'Pop', 203),
(207, 'Apna Bana Le', 'Arijit Singh', 'Romantic', 261),
(208, 'Thunder', 'Imagine Dragons', 'Rock', 187),
(209, 'Shape of You', 'Ed Sheeran', 'Pop', 234),
(210, 'Naatu Naatu', 'Rahul Sipligunj', 'Dance', 225),
(211, 'Heeriye', 'Jasleen Royal', 'Pop', 194),
(212, 'Heat Waves', 'Glass Animals', 'Indie', 238);


CREATE TABLE playlist_songs (
    playlist_id INT,
    song_id INT,
    added_date DATE,
    PRIMARY KEY (playlist_id, song_id),
    FOREIGN KEY (playlist_id) REFERENCES playlists(playlist_id),
    FOREIGN KEY (song_id) REFERENCES songs(song_id)
);

INSERT INTO playlist_songs VALUES
(101, 201, '2026-01-11'),
(101, 202, '2026-01-12'),
(101, 203, '2026-01-13'),
(101, 205, '2026-01-14'),
(102, 204, '2026-02-16'),
(102, 208, '2026-02-17'),
(102, 210, '2026-02-18'),
(103, 201, '2026-03-02'),
(103, 203, '2026-03-03'),
(103, 205, '2026-03-04'),
(103, 207, '2026-03-05'),
(104, 202, '2026-03-11'),
(104, 206, '2026-03-12'),
(104, 209, '2026-03-13'),
(104, 210, '2026-03-14'),
(105, 212, '2026-04-06'),
(105, 203, '2026-04-07'),
(106, 202, '2026-04-13'),
(106, 212, '2026-04-14'),
(107, 206, '2026-05-02'),
(107, 209, '2026-05-03');

SELECT * FROM users;
SELECT * FROM playlists;
SELECT * FROM songs;
SELECT * FROM playlist_songs;


SELECT 
	p.playlist_name as playlists,
    s.song_name as songs
FROM playlists as p
LEFT JOIN playlist_songs as ps
	ON p.playlist_id = ps.playlist_id
LEFT JOIN songs as s
	ON ps.song_id = s.song_id;
