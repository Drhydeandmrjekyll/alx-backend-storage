-- Task 3: Glam Rock Bands Ranking by Longevity

-- Create a temporary table to store the computed lifespan for each Glam Rock band
CREATE TEMPORARY TABLE IF NOT EXISTS tmp_glam_rock_lifespan AS
SELECT
    band_name,
    CASE
        WHEN formed IS NULL OR split IS NULL THEN 0
        ELSE YEAR(split) - YEAR(formed)
    END AS lifespan
FROM metal_bands
WHERE style = 'Glam Rock';

-- Rank the Glam Rock bands by longevity
SELECT band_name, lifespan
FROM tmp_glam_rock_lifespan
ORDER BY lifespan DESC, band_name ASC;

-- Drop the temporary table after use
DROP TEMPORARY TABLE IF EXISTS tmp_glam_rock_lifespan;
