-- Create a table named Playlists with columns: id, user_id, playlist_name, and total_likes. Insert at least 8 sample rows with different users and playlists, making sure some playlists have the same user_id.

CREATE DATABASE PlaylistPractice;
USE PlaylistPractice;

CREATE TABLE Playlists (
    id INT PRIMARY KEY,
    user_id INT,
    playlist_name VARCHAR(100),
    total_likes INT
);

INSERT INTO Playlists
    (id, user_id, playlist_name, total_likes)
VALUES
    (1, 101, 'Bollywood Hits', 500),
    (2, 101, 'Workout Mix', 300),
    (3, 101, 'Chill Vibes', 300),
    (4, 102, 'Party Anthems', 700),
    (5, 102, 'Romantic Songs', 450),
    (6, 102, 'Old Classics', 200),
    (7, 103, 'Lo-Fi Beats', 500),
    (8, 103, 'Study Focus', 400),
    (9, 103, 'Night Drive', 400),
    (10, 104, 'Rock Legends', 600),
    (11, 104, 'Acoustic Cafe', 350),
    (12, 104, 'Morning Energy', 150);
    


-- Write a SQL query using ROW_NUMBER() and the OVER() clause to assign a unique row number to each playlist, ordered by total_likes in descending order.

USE PlaylistPractice;

SELECT * FROM Playlists;

SELECT
    playlist_name,
    user_id,
    total_likes,
    ROW_NUMBER() OVER (
        ORDER BY total_likes DESC, id
    ) AS row_num
FROM Playlists;




-- Use the RANK() function with the OVER() clause to rank all playlists by total_likes, and display the playlist_name, user_id, total_likes, and their rank.

USE PlaylistPractice;

SELECT
    playlist_name,
    user_id,
    total_likes,
    RANK() OVER (
        ORDER BY total_likes DESC
    ) AS playlist_rank
FROM Playlists;



-- Write a SQL query using DENSE_RANK() and PARTITION BY user_id to rank each user's playlists by total_likes, showing playlist_name, user_id, total_likes, and dense rank.<br><br><em><strong>Hint:</strong> This will show how popular each playlist is within each user's account, similar to how Spotify might rank your top playlists.</em>

USE PlaylistPractice;

SELECT
    playlist_name,
    user_id,
    total_likes,
    DENSE_RANK() OVER (
        PARTITION BY user_id
        ORDER BY total_likes DESC
    ) AS dense_ranks
FROM Playlists;


-- Imagine you want to show the top 2 playlists per user based on total_likes, like Spotify's 'Your Top Playlists' feature. Write a query using a window function to select only the top 2 playlists for each user.

USE PlaylistPractice;

WITH RankedPlaylists AS (
    SELECT
        playlist_name,
        user_id,
        total_likes,
        ROW_NUMBER() OVER (
            PARTITION BY user_id
            ORDER BY total_likes DESC, id
        ) AS row_num
    FROM Playlists
)
SELECT
    playlist_name,
    user_id,
    total_likes,
    row_num
FROM RankedPlaylists
WHERE row_num <= 2
ORDER BY user_id, row_num;
