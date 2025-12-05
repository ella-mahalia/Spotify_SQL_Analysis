SELECT * FROM public.spotify
LIMIT 100

SELECT COUNT(*) FROM spotify;
SELECT COUNT(DISTINCT artist) FROM spotify;
SELECT DISTINCT album_type FROM spotify;
SELECT DISTINCT channel FROM spotify;
SELECT DISTINCT most_played_on FROM spotify;
SELECT MAX(duration_min) FROM spotify;

-- Inconsistencies 
SELECT MIN(duration_min) FROM spotify;

-- Finding where the duration = 0
SELECT * FROM spotify
WHERE duration_min = 0

-- Actually removing it from our records using DELETE function
DELETE FROM spotify
WHERE duration_min = 0;




-- Business Case Part 1

-- Streams that have a count of more than 1 billion
SELECT * FROM spotify
WHERE stream > 1000000000
ORDER BY stream DESC;

-- All abums with their respective artists
SELECT 
	DISTINCT album, artist
FROM spotify
ORDER BY 1;

-- The total number of comments for tracks where licensed = TRUE 
SELECT 
	SUM(comments) AS total_comments
FROM spotify 
WHERE licensed = true;

-- All tracks that belong to the album type single
SELECT *
FROM spotify
WHERE album_type ILIKE 'single';

-- The Total number of tracks by each artist
SELECT 
	artist,
	COUNT(*) as total_number_of_songs
FROM spotify 
GROUP BY artist
ORDER BY total_number_of_songs DESC


-- If I wanted to rank the Top 5 Overall Streamed Tracks 
SELECT *
FROM (
    SELECT
        artist,
        SUM(stream) AS total_streams,
        RANK() OVER (ORDER BY SUM(stream) DESC) AS rank
    FROM spotify
    GROUP BY artist
) ranked_artists
WHERE rank <= 5
ORDER BY rank;

