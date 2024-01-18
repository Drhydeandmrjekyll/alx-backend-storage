-- Create stored procedure ComputeAverageScoreForUser
DELIMITER //

CREATE PROCEDURE ComputeAverageScoreForUser(IN user_id INT)
BEGIN
    DECLARE total_score INT;
    DECLARE total_projects INT;
    DECLARE average_score FLOAT;

    -- Compute total score for the user
    SELECT SUM(score) INTO total_score FROM corrections WHERE user_id = user_id;
    
    -- Compute total number of projects for the user
    SELECT COUNT(DISTINCT project_id) INTO total_projects FROM corrections WHERE user_id = user_id;

    -- Avoid division by zero
    IF total_projects > 0 THEN
        -- Compute average score
        SET average_score = total_score / total_projects;

        -- Update the user's average score
        UPDATE users SET average_score = average_score WHERE id = user_id;
    END IF;
END //

DELIMITER ;

-- Test data
CALL ComputeAverageScoreForUser((SELECT id FROM users WHERE name = "Jeanne"));
