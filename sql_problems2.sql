-- Business Case Part 2 

-- Calcualte the avg danceability of tracks in each album
SELECT 
	album,
	AVG(danceability) as avg_danceability
FROM spotify
GROUP BY album
ORDER BY avg_danceability ASC

-- Top 5 tracks with the highest energy values
SELECT 
    track,
    MAX(energy) AS max_energy
FROM spotify
GROUP BY track
ORDER BY max_energy DESC
LIMIT 5;

-- List all tracks along with their views and likes where offical_video = TRUE

SELECT 
	track,
	SUM(views) as total_views,
	SUM(likes) as total_likes
FROM spotify
WHERE official_video = 'true'
GROUP BY track
ORDER BY total_views DESC

-- For each album, calculate the total views of all associated tracks
SELECT 
	album,
	track,
	SUM(views) as total_views
FROM spotify
GROUP BY album, track
ORDER BY total_views DESC

-- Retrive the track names that have been streamed on Spotify more than Youtube
SELECT * FROM
(SELECT
	track,
	COALESCE(SUM(CASE WHEN most_played_on = 'Youtube' THEN stream END),0) AS streamed_on_youtube,
	COALESCE(SUM(CASE WHEN most_played_on = 'Spotify' THEN stream END),0) AS streamed_on_spotify
FROM spotify
GROUP BY track
) AS table_1
WHERE 
	streamed_on_spotify > streamed_on_youtube
	AND
	streamed_on_youtube <> 0

