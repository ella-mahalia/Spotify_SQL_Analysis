-- Find the top 3 most-viewed tracks for each artist using window functions
 -- Each artists and total view for each track
 -- Track with highest view for each artist
 -- Dense Rank: assigns a rank to each row within a partition of a result set 
 -- CTE: simplifies complex queries by creating temp named result sets
 -- Filter rank 

WITH ranking_artist
AS(
SELECT 
	artist,
	track,
	SUM(views) AS total_views,
	DENSE_RANK() OVER(PARTITION BY artist ORDER BY SUM(views) DESC) AS rank
FROM spotify
GROUP BY artist, track
)
SELECT * FROM ranking_artist
WHERE rank <= 3
ORDER BY artist, total_views DESC


-- Write a query to find tracks where the liveness score is above the average
SELECT 
	track,
	artist,
	liveness
FROM spotify
WHERE liveness > (SELECT AVG(liveness) FROM spotify)

-- Using a WITH clause to calculate the difference between the highest and 
-- lowest energy values for tracks in each album

WITH CTE 
AS
(SELECT
	album, 
	MAX(energy) AS highest_energy,
	MIN(energy) AS lowest_energy
FROM spotify
GROUP BY album
)
SELECT 
	album,
	highest_energy - lowest_energy as energy_diff
FROM CTE
ORDER BY energy_diff DESC
	
