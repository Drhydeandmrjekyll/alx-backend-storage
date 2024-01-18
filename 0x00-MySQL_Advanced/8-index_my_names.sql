-- Create index idx_name_first on the first letter of name in the names table
USE holberton;

-- Add new column for first letter of the name
ALTER TABLE names ADD COLUMN first_letter CHAR(1) GENERATED ALWAYS AS (LEFT(name, 1)) STORED;

-- Create index on new column
CREATE INDEX idx_name_first ON names (first_letter);

-- Optimize the table
OPTIMIZE TABLE names;
