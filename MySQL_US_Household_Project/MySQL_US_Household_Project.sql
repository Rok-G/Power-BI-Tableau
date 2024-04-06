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

-- TOP 10 States with the largest area of Land
SELECT State_Name, SUM(ALand), SUM(AWater)
FROM us_household_income
GROUP BY State_Name
ORDER BY 2 DESC
LIMIT 10;


-- Joins 'us_household_income' with 'us_household_income_statistics' on matching 'id'.
-- Filters the results to exclude records where 'Mean' income is reported as zero.
SELECT *
FROM us_household_income AS I
INNER JOIN us_household_income_statistics AS S
    ON I.id = S.id
WHERE Mean <> 0;


-- Average 'Mean' and 'Median' income for each state, excluding records where 'Mean' is zero.
-- Groups the results by 'State_Name' to ensure averages are calculated on a per-state basis.
-- Orders the states by the average 'Mean' income in ascending order to find the lowest income states.
-- Limits the output to the 5 states with the lowest average income, providing a focused view on lower-income areas.
SELECT I.State_Name, ROUND(AVG(Mean),1), ROUND(AVG(Median),1)
FROM us_household_income AS I
INNER JOIN us_household_income_statistics AS S
    ON I.id = S.id
WHERE Mean <> 0
GROUP BY I.State_Name
ORDER BY 2
LIMIT 5;

-- Aggregates income data by 'Type' to understand income distribution across different classifications.
-- Excludes entries with a 'Mean' income of zero to ensure accuracy of averages.
-- Computes the count of entries, average 'Mean', and average 'Median' income for each 'Type'.
-- Results are sorted by the average 'Mean' income in descending order, focusing on the top 20 highest average incomes by 'Type'.
SELECT Type, COUNT(Type), ROUND(AVG(Mean),1), ROUND(AVG(Median),1)
FROM us_household_income AS I
INNER JOIN us_household_income_statistics AS S
    ON I.id = S.id
WHERE Mean <> 0
GROUP BY Type
ORDER BY 3 DESC
LIMIT 20;

-- Selects income data grouped by 'Type', calculating counts, and averages of 'Mean' and 'Median' incomes.
-- Ignores records with a 'Mean' income of zero to improve data relevance.
-- Applies a filter to exclude 'Type' groups with fewer than 100 entries, removing outliers that might skew the analysis.
-- Sorts the remaining groups by the average 'Median' income in descending order, prioritizing types with higher median incomes.
SELECT Type, COUNT(Type), ROUND(AVG(Mean),1), ROUND(AVG(Median),1)
FROM us_household_income AS I
INNER JOIN us_household_income_statistics AS S
    ON I.id = S.id
WHERE Mean <> 0
GROUP BY 1
HAVING COUNT(Type) > 100
ORDER BY 4 DESC;

SELECT *
FROM us_household_income
WHERE Type = 'Community';


-- Gathers income statistics at the city level within each state, providing insights into local economic conditions.
-- Calculates the rounded average 'Mean' and 'Median' incomes for each city-state combination.
-- Groups results by 'State_Name' and 'City' to ensure accurate locality-specific averages.
-- Orders the cities by their average 'Mean' income in descending order, highlighting areas with the highest income levels first
SELECT 	I.State_Name, City, ROUND(AVG(Mean),1),ROUND(AVG(Median),1)
FROM us_household_income AS I
INNER JOIN us_household_income_statistics AS S
    ON I.id = S.id
GROUP BY I.State_Name, City
ORDER BY ROUND(AVG(Mean),1) DESC;
