-- Create stored procedure ComputeAverageWeightedScoreForUser
DELIMITER //

CREATE PROCEDURE ComputeAverageWeightedScoreForUser(IN user_id INT)
BEGIN
    DECLARE total_weighted_score FLOAT;
    DECLARE total_weight INT;
    DECLARE average_weighted_score FLOAT;

    -- Compute total weighted score for the user
    SELECT SUM(corrections.score * projects.weight) INTO total_weighted_score
    FROM corrections
    JOIN projects ON corrections.project_id = projects.id
    WHERE corrections.user_id = user_id;

    -- Compute total weight for the user
    SELECT SUM(projects.weight) INTO total_weight FROM projects;

    -- Avoid division by zero
    IF total_weight > 0 THEN
        -- Compute average weighted score
        SET average_weighted_score = total_weighted_score / total_weight;

        -- Update user's average score
        UPDATE users SET average_score = average_weighted_score WHERE id = user_id;
    END IF;
END //

DELIMITER ;

-- Test data
CALL ComputeAverageWeightedScoreForUser((SELECT id FROM users WHERE name = "Jeanne"));
