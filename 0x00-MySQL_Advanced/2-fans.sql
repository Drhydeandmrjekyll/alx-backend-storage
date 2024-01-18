-- Task 2: Fans Ranking

-- Create a temporary table to store the aggregated fan counts for each origin
CREATE TEMPORARY TABLE IF NOT EXISTS tmp_fan_counts AS
SELECT origin, COUNT(*) AS nb_fans
FROM metal_bands
GROUP BY origin;

-- Rank the origins based on the number of non-unique fans
SET @rank = 0;
SELECT origin, nb_fans,
       @rank := @rank + 1 AS rank
FROM tmp_fan_counts
ORDER BY nb_fans DESC;

-- Drop the temporary table after use
DROP TEMPORARY TABLE IF EXISTS tmp_fan_counts;
