-- World Life Expectancy Project (Data Cleaning)

-- Genaral checking of the overall data
SELECT * 
FROM world_life_expectancy
;

-- Searching for duplicates in the dataset, focusing on duplicate years for each country
-- This step identifies any records where the combination of Country and Year appears more than once.
-- Grouping by Country and Year helps us spot these duplicates directly.
SELECT Country, Year, CONCAT(Country, Year),COUNT(CONCAT(Country, Year))
FROM world_life_expectancy
GROUP BY Country, Year, CONCAT(Country, Year)
HAVING COUNT(CONCAT(Country, Year)) > 1
;

-- Using a subquery and PARTITION BY to find and remove duplicate entries
-- We assign a row number to each entry grouped by Country and Year. Entries beyond the first are considered duplicates.
-- This technique allows us to pinpoint exact duplicate rows we want to remove.
SELECT *
FROM (
    SELECT Row_ID,
    CONCAT(Country, Year),
    ROW_NUMBER () OVER(PARTITION BY CONCAT(Country, Year) ORDER BY CONCAT(Country, Year)) AS Row_Num
    FROM world_life_expectancy
    ) AS Row_Table
WHERE Row_Num >1
;

-- Deleting Duplicate Row_ID from the Table
-- Prior to this I have made a Backup Table named world_life_expectancy_backup
-- This step removes the identified duplicates from the database to maintain data integrity.
DELETE FROM world_life_expectancy
WHERE Row_ID IN (
                SELECT Row_ID
                FROM ( SELECT Row_ID,
                CONCAT(Country, Year),
                ROW_NUMBER () OVER(PARTITION BY CONCAT(Country, Year) ORDER BY CONCAT(Country, Year)) AS Row_Num
                FROM world_life_expectancy
                ) AS Row_Table
    WHERE Row_Num > 1);
                
-- Searching for Missing data, this time we are looking for BLANK entries ''.
-- NULL is not the same as Blank and will skew the results if not corrected                 
SELECT * 
FROM world_life_expectancy
WHERE Status = '';

-- Double checking for any non-blank 'Status' entries to ensure no data is overlooked
-- This step is crucial for understanding the variety of 'Status' values present in our dataset.
SELECT DISTINCT (Status) 
FROM world_life_expectancy
WHERE Status <>'';

-- Attempt to update 'Status' to 'Developing' for certain countries
-- This initial approach did not work as expected, leading to further refinement in the next steps.
UPDATE world_life_expectancy
SET status = 'Developing'
WHERE Country IN (SELECT DISTINCT(Country)
                  FROM world_life_expectancy
                  WHERE Status = 'Developing');

-- Using a self-join to update the 'Status' of countries accurately
-- Self-joins allow us to reference the same table in an UPDATE operation, enabling complex condition checks and updates.
UPDATE world_life_expectancy T1
JOIN world_life_expectancy T2
     ON T1.Country = T2.Country
SET T1.Status = 'Developing'
WHERE T1.Status = ''
AND T2.Status <> ''
AND T2.Status = 'Developing'
;

-- Blank entry from Developed country. Need to rewrite the query above and look for that too
SELECT *
FROM world_life_expectancy
WHERE Country = 'United States of America';

-- Updating 'Status' for developed countries with blank entries
-- Similar to the previous step but specifically targeting 'Developed' countries to ensure accurate data classification.
UPDATE world_life_expectancy T1
JOIN world_life_expectancy T2
     ON T1.Country = T2.Country
SET T1.Status = 'Developed'
WHERE T1.Status = ''
AND T2.Status <> ''
AND T2.Status = 'Developed'
;

-- Identifying blank values in the 'Life expectancy' column
-- This step helps in locating records where 'Life expectancy' data is missing, crucial for subsequent data cleaning operations.
SELECT *
FROM world_life_expectancy
WHERE `Life expectancy` = '' ;

-- Preparing to add average age to blank 'Life expectancy' fields
-- This complex operation calculates the average 'Life expectancy' based on adjacent years for the same country.
-- The goal is to interpolate missing data with reasoned estimates, enhancing the dataset's completeness.
SELECT T1.Country, T1.Year, T1.`Life expectancy`,
       T2.Country, T2.Year, T2.`Life expectancy`,
       T3.Country, T3.Year, T3.`Life expectancy`,
      ROUND((T2.`Life expectancy` + T3.`Life expectancy`)/2,1)
FROM world_life_expectancy T1
JOIN world_life_expectancy T2
     ON T1.Country = T2.Country
     AND T1.Year = T2.Year -1
JOIN world_life_expectancy T3
     ON T1.Country = T3.Country
     AND T1.Year = T3.Year +1
WHERE T1.`Life expectancy` = ''
     ;
 
-- Updating the table with the average 'Life expectancy' calculated above
-- This final step applies the calculated averages to fill in blank 'Life expectancy' entries, rounding to 1 decimal for precision.
-- It's a key part of making the dataset more complete and useful for analysis.
UPDATE world_life_expectancy T1
JOIN world_life_expectancy T2
     ON T1.Country = T2.Country
     AND T1.Year = T2.Year -1
JOIN world_life_expectancy T3
     ON T1.Country = T3.Country
     AND T1.Year = T3.Year +1
SET T1.`Life expectancy` = ROUND((T2.`Life expectancy` + T3.`Life expectancy`)/2,1)
WHERE T1.`Life expectancy`= '' ;

-- Final check to ensure all updates and cleaning operations have been successfully applied
SELECT Country, Year, `Life expectancy`
FROM world_life_expectancy