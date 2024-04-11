--                  Automated Data Cleaning Project on US Household Income

-- Display all records from the raw data table for reference
SELECT *
FROM us_household_income;

-- Display all records from the cleaned data table for reference
SELECT *
FROM us_household_income_cleaned;


-- Initialize SQL delimiter for defining stored procedures
DELIMITER $$

-- Drop the stored procedure if it already exists to avoid errors on recreation
DROP PROCEDURE IF EXISTS Copy_and_Clean_Data;

-- Create a new stored procedure for copying and cleaning data
CREATE PROCEDURE Copy_and_Clean_Data()
BEGIN 
    -- Create a cleaned version of the table if it doesn't exist to preserve raw data
    -- This table structure mirrors the original but includes a timestamp for tracking changes
    CREATE TABLE IF NOT EXISTS `us_household_income_cleaned` (
      `row_id` int DEFAULT NULL,
      `id` int DEFAULT NULL,
      `State_Code` int DEFAULT NULL,
      `State_Name` text,
      `State_ab` text,
      `County` text,
      `City` text,
      `Place` text,
      `Type` text,
      `Primary` text,
      `Zip_Code` int DEFAULT NULL,
      `Area_Code` int DEFAULT NULL,
      `ALand` int DEFAULT NULL,
      `AWater` int DEFAULT NULL,
      `Lat` double DEFAULT NULL,
      `Lon` double DEFAULT NULL,
      `TimeStamp` TIMESTAMP DEFAULT CURRENT_TIMESTAMP -- Adds a timestamp for each record to track changes
    ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
    
    -- Copy data from the original table to the cleaned table, adding the current timestamp to each row
    INSERT INTO us_household_income_cleaned
    SELECT *, CURRENT_TIMESTAMP
    FROM us_household_income;
    
    -- Remove duplicates based on the `id` and `TimeStamp` to ensure data uniqueness
    DELETE FROM us_household_income_cleaned
    WHERE row_id IN (
        SELECT row_id
        FROM (
            SELECT row_id, id,
                ROW_NUMBER() OVER (
                    PARTITION BY id, `TimeStamp` 
                    ORDER BY id,`TimeStamp`) AS row_num
            FROM us_household_income_cleaned
        ) duplicates
        WHERE row_num > 1 
    );

    -- Correct common data quality issues such as typos and standardize certain text fields to ensure consistency
    UPDATE us_household_income_cleaned
    SET State_Name = 'Georgia'
    WHERE State_Name = 'georia';

    UPDATE us_household_income_cleaned
    SET County = UPPER(County), City = UPPER(City), Place = UPPER(Place), State_Name = UPPER(State_Name);

    UPDATE us_household_income_cleaned
    SET `Type` = 'CDP'
    WHERE `Type` = 'CPD';

    UPDATE us_household_income_cleaned
    SET `Type` = 'Borough'
    WHERE `Type` = 'Boroughs';
    
END $$
DELIMITER ; -- Reset the delimiter to its default value

-- Execute the stored procedure to clean the data
CALL Copy_and_Clean_Data();


-- Schedule the data cleaning to run automatically every 30 days
DROP EVENT run_data_cleaning; -- Ensure only one instance of the event exists
CREATE EVENT run_data_cleaning
    ON SCHEDULE EVERY 30 DAY
    DO CALL Copy_and_Clean_Data();

-- Create a trigger to automatically clean new data after adding it into the raw data table
DELIMITER $$
CREATE TRIGGER Transfer_Clean_Data
    AFTER INSERT ON us_household_income
    FOR EACH ROW
BEGIN
    CALL Copy_and_Clean_Data();
END $$
DELIMITER ;


-- Debugging and validation queries to ensure the cleaning process is working as expected
-- Checks for duplicates in the cleaned data
SELECT row_id, id, row_num
FROM (
    SELECT row_id, id,
        ROW_NUMBER() OVER (
            PARTITION BY id
            ORDER BY id) AS row_num
    FROM us_household_income_cleaned
) duplicates
WHERE row_num > 1;

-- Count the total number of rows in the cleaned table to verify data transfer
SELECT COUNT(row_id)
FROM us_household_income_cleaned;

-- Verify changes to state names and count records per state to ensure cleaning has been effective
SELECT State_Name, COUNT(State_Name)
FROM us_household_income_cleaned
GROUP BY State_Name;
