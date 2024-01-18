-- Task 2: Fans Ranking

-- Create a temporary table to store the aggregated fan counts for each origin
CREATE TEMPORARY TABLE IF NOT EXISTS tmp_fan_counts AS
SELECT origin, SUM(fans) AS nb_fans
FROM metal_bands
GROUP BY origin
ORDER BY nb_fans DESC;

-- Initialize variables for ranking
SET @rank = 0;
SET @prev_nb_fans = NULL;

-- Rank the origins based on the number of non-unique fans
SELECT origin, nb_fans,
       @rank := IF(@prev_nb_fans = nb_fans, @rank, @rank + 1) AS rank,
       @prev_nb_fans := nb_fans
FROM tmp_fan_counts;

-- Drop the temporary table after use
DROP TEMPORARY TABLE IF EXISTS tmp_fan_counts;
