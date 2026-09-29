 
 -- Install MySQL or PostgreSQL on your system and create a new database named 'music_streaming_app' using the command line or GUI tool of your choice.--


create database music_streaming_app;
use music_streaming_app;
 -- 2.Inside the 'music_streaming_app' database, create a table called 'playlists'
 -- with columns: playlist_id (integer, primary key), name (varchar), and created_by (varchar).
 
 create table playlists(
 playlist_id int primary key,
 playlist_name varchar(100) not null,
 created_by varchar(100) not null
 );
 
ALTER TABLE table_name
RENAME COLUMN song_name TO playlist_name;
 
 select * from playlists;
 
 -- 3.Insert three sample rows into the 'playlists' table representing playlists like 
 -- 'Bollywood Hits', 'Chill Vibes', and 'Workout Mix', each created by a different user.
 
 
 INSERT INTO playlists (playlist_id, song_name, created_by)
VALUES
(11, 'Bollywood Hits', 'Rahul'),
(12, 'Chill Vibes', 'Priya'),
(13, 'Workout Mix', 'Amit');



select * from playlists;

-- 4.Write an SQL SELECT query to display all playlists created by the user 
-- 'Amit' from the 'playlists' table.<br><br><em><strong>Hint:</strong> Use the WHERE clause to filter by the 'created_by' column.</em>

select * from playlists
where created_by = 'Rahul';

-- 5.Open ChatGPT or Copilot and ask it to explain the difference between a table,
-- a row, and a column in SQL using an example from a food delivery app like Zomato. Paste the explanation you receive into your assignment.

/*
In a food delivery app like Zomato, a table is used to store related information in the form of rows and columns. 
For example, an "orders" table can store information such as order_id, customer_name, restaurant, and amount.
 A row represents one complete record in the table, such as one customer's order,
 while a column represents one specific type or category of information,
 such as the customer's name or order amount. In simple terms,
 a table contains rows and columns, a row represents one complete record, and a column represents one type of information.
*/