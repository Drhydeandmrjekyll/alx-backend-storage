-- 5-valid_email.sql

-- Existing code for initialization

-- Create Trigger
DELIMITER //

CREATE TRIGGER reset_valid_email_trigger
BEFORE UPDATE ON users
FOR EACH ROW
BEGIN
    IF NEW.email != OLD.email THEN
        SET NEW.valid_email = 0;
    END IF;
END;

//

DELIMITER ;
