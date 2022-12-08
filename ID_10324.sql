-- Distances Traveled
-- Problem Statement:
	-- Find the top 10 users that have traveled the greatest distance. Output their id, name and a total distance traveled.
-- ID 10324

-- Tables: 
	-- Table Name: employee
		-- Columns Name: Data Type
		-- id: int
		-- user_id: int
		-- distance: int
		
	-- Table Name: bonus
		-- Columns Name: Data Type
		-- id: int
		-- name: varchar

WITH cte1 AS (
    SELECT
        DISTINCT lrl.user_id,
        lu.name, 
        SUM(lrl.distance) OVER(PARTITION BY lu.name) AS traveled_distance
    FROM lyft_rides_log lrl
    LEFT JOIN lyft_users lu
    ON lrl.user_id = lu.id
    ORDER BY traveled_distance DESC
),

cte2 AS (
    SELECT
        user_id,
        name,
        traveled_distance,
        RANK() OVER(ORDER BY traveled_distance DESC) AS rnk
    FROM cte1
)


SELECT 
    user_id,
    name,
    traveled_distance
FROM cte2 WHERE rnk <= 10