                          -- US Household Income Data Cleaning

-- Known error in MySQL, it will often change the names when importing
-- Best to change names of the affected columns after the impport
ALTER TABLE us_project.us_household_income_statistics
RENAME COLUMN `ï»¿id` TO `id`;

-- 200 entries missing, 32292 vs 32526 in Income Statistics table. Happens often if data isn't perfectly clean with MySQL
-- Real dataset from gov webiste, working with the raw data 
SELECT COUNT(id)
FROM us_household_income;

SELECT COUNT(id) 
FROM us_household_income_statistics;

-- Checking for duplicates
-- Groups results by `id` and sorts to highlight any `id` appearing more than once.
SELECT id, COUNT(id)
FROM us_household_income
GROUP BY id
HAVING COUNT(id)> 1;

-- Utilizes a window function to assign row numbers to each record within partitions of the same `id`, ordered by `id`.
-- Encapsulates this logic in a subquery to identify and filter for duplicate entries, i.e., entries beyond the first occurrence of each `id`
SELECT *
FROM (
SELECT row_id, id,
ROW_NUMBER() OVER(PARTITION BY id ORDER BY id) AS Row_Num
FROM us_household_income) AS Duplicates
WHERE row_num > 1;

-- Deleting the duplicate entries
DELETE FROM us_household_income
WHERE row_id IN (
        SELECT row_id
        FROM (
            SELECT row_id, id,
            ROW_NUMBER() OVER(PARTITION BY id ORDER BY id) AS Row_Num
            FROM us_household_income) AS Duplicates
        WHERE row_num > 1);

-- Checking the data for missing values or misspelings.
SELECT DISTINCT State_Name 
FROM us_household_income
ORDER BY 1;


-- Corrects the misspelling of 'Georgia'.
UPDATE us_household_income
SET State_Name = 'Georgia'
WHERE State_Name = 'georia';

-- Capitalizes 'Alabama' correctly.
UPDATE us_household_income
SET State_Name = 'Alabama'
WHERE State_Name = 'alabama';

-- Checking entries for 'Autauga County' before making updates.
SELECT *
FROM us_household_income
WHERE County = 'Autauga County';

-- Corrects the place name associated with 'Autauga County' and a specific city.
UPDATE us_household_income
SET Place = 'Autaugaville'
WHERE County = 'Autauga County' AND City = 'Vinemont';

-- Counts how many times each 'Type' appears, to understand the data distribution.
SELECT Type, COUNT(Type)
FROM us_household_income
GROUP BY Type;

-- Standardizes 'Type' by changing 'Boroughs' to 'Borough'.
UPDATE us_household_income
SET Type = 'Borough'
WHERE Type = 'Boroughs';

SELECT ALand, AWater
FROM us_household_income
WHERE (AWater = 0 OR AWater = '' OR AWater IS NULL)
AND (ALand = 0 OR ALand = '' OR ALand IS NULL);

                      -- US Household Income Exploratory Data Analysis

