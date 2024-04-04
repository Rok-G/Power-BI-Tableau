# World Life Expectancy Project (Exploratory Data Analysis)

-- This query aims to evaluate how life expectancy has changed for each country within the dataset's span of 15 years.
-- We calculate the minimum and maximum life expectancy recorded for each country to understand the range of change.
-- By subtracting the minimum from the maximum life expectancy, we determine the overall increase or decrease during this period.
-- The ROUND function is used to simplify the result to one decimal place for readability.
-- The HAVING clause ensures we exclude any countries where life expectancy data might be missing or recorded as zero, which could indicate missing or flawed data.
-- Finally, the results are ordered by the Life_Increase_in_15_Years in descending order to highlight the countries with the greatest increase in life expectancy at the top
SELECT Country, 
MIN(`Life expectancy`), 
MAX(`Life expectancy`),
ROUND(MAX(`Life expectancy`) - MIN(`Life expectancy`),1) AS Life_Increase_in_15_Years
FROM world_life_expectancy
GROUP BY Country
HAVING MIN(`Life expectancy`) <> 0
AND MAX(`Life expectancy`) <> 0
ORDER BY Life_Increase_in_15_Years DESC;


-- This query determines the average life expectancy for each year in the dataset,
-- ignoring records with a life expectancy of zero to prevent skewing the average.
-- The results are rounded to one decimal place and listed in chronological order
SELECT Year, ROUND(AVG(`Life expectancy`),1) AS Avg_Life_Expectancy
FROM world_life_expectancy
WHERE `Life expectancy` <> 0
AND `Life expectancy` <> 0
GROUP BY Year
ORDER BY Year;

-- Correlation between GDP and Life Expectancy by Country
-- This query averages life expectancy and GDP for each country, filtering out zero values to maintain data quality.
-- Countries are then sorted by GDP to observe the expected trend where higher GDP correlates with higher life expectancy.
SELECT Country,ROUND(AVG(`Life expectancy`),1) AS Avg_Life_Expectancy, ROUND(AVG(GDP),1) AS GDP
FROM world_life_expectancy
GROUP BY Country
HAVING Avg_Life_Expectancy > 0
AND GDP > 0
ORDER BY GDP;

-- Calculates the average life expectancy for two GDP groups: above and below the 1500 threshold.
-- Avoids skewing results by using NULL for life expectancy where the GDP condition is not met.
-- The output provides the count of rows and the average life expectancy for high and low GDP countries
SELECT
SUM(CASE WHEN GDP >= 1500 THEN 1 ELSE 0 END) High_GDP_Row_Count,
ROUND(AVG(CASE WHEN GDP >= 1500 THEN `Life Expectancy` ELSE NULL END),1) High_GDP_Life,
SUM(CASE WHEN GDP <= 1500 THEN 1 ELSE 0 END) Low_GDP_Row_Count,
ROUND(AVG(CASE WHEN GDP <= 1500 THEN `Life Expectancy` ELSE NULL END),1) Low_GDP_Life
FROM world_life_expectancy;

-- Explores the correlation between higher BMI and life expectancy by averaging both metrics for each country, ensuring data quality by excluding zero values.
-- Countries are sorted in descending order by BMI to highlight the trend towards higher life expectancy with higher BMI.
SELECT Country,ROUND(AVG(`Life expectancy`),1) AS Avg_Life_Expectancy, ROUND(AVG(BMI),1) AS BMI
FROM world_life_expectancy
GROUP BY Country
HAVING Avg_Life_Expectancy > 0
AND BMI > 0
ORDER BY BMI DESC;

-- Calculates a rolling total of adult mortality for each country over the years using a window function. The rolling total adds up adult mortality annually, showcasing a cumulative figure as years progress. 
-- For enhanced specificity, a WHERE clause can filter results by country, such as 'United Kingdom'.
SELECT Country, Year, `Life Expectancy`,`Adult Mortality`,
SUM( `Adult Mortality`) OVER (PARTITION BY Country ORDER BY Year) AS Rolling_Total
FROM world_life_expectancy;