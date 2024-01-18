-- Create stored procedure ComputeAverageWeightedScoreForUsers
DELIMITER //

CREATE PROCEDURE ComputeAverageWeightedScoreForUsers()
BEGIN
    DECLARE done INT DEFAULT FALSE;
    DECLARE user_id INT;
    
    -- Cursor to iterate over users
    DECLARE users_cursor CURSOR FOR SELECT id FROM users;
    
    -- Declare handlers for exceptions
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
    
    OPEN users_cursor;
    
    -- Loop through users
    users_loop: LOOP
        FETCH users_cursor INTO user_id;
        IF done THEN
            LEAVE users_loop;
        END IF;
        
        -- Compute average weighted score for each user
        CALL ComputeAverageWeightedScoreForUser(user_id);
    END LOOP;
    
    CLOSE users_cursor;
    
END //

DELIMITER ;
