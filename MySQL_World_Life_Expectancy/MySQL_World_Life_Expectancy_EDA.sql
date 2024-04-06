-- World Life Expectancy Project (Exploratory Data Analysis) - EDA

-- Genaral checking of the overall data
SELECT * 
FROM world_life_expectancy;

-- Calculates the minimum and maximum life expectancy for each country,
-- along with the difference between these values over a 15-year span, indicating improvements in life expectancy.
-- Filters out countries with 0 values to ensure data integrity.
-- Results are ordered by the increase in life expectancy in ascending order.
SELECT Country, MIN(`Life expectancy`), MAX(`Life expectancy`),
ROUND(MAX(`Life expectancy`) - MIN(`Life expectancy`),1) AS Life_Increase_15_Years
FROM world_life_expectancy
GROUP BY Country
HAVING MIN(`Life expectancy`) <> 0
AND MAX(`Life expectancy`) <> 0
ORDER BY Life_Increase_15_Years ASC;

-- Aggregates life expectancy by year across all countries, calculating the average life expectancy for each year.
-- Excludes records with life expectancy of 0 to ensure accuracy.
-- Results are ordered chronologically by year.
SELECT Year, ROUND(AVG(`Life expectancy`),1)
FROM world_life_expectancy
WHERE `Life expectancy` <> 0
AND `Life expectancy` <> 0
GROUP BY Year
ORDER BY Year;

-- Aggregates data by country to calculate average life expectancy and GDP,
-- only including countries with non-zero values for both metrics.
-- Results are ordered by GDP in descending order to highlight wealthier nations first.
SELECT Country, ROUND(AVG(`Life expectancy`),1) AS Life_Exp, ROUND(AVG(GDP),1) AS GDP
FROM world_life_expectancy
GROUP BY Country
HAVING Life_Exp > 0
AND GDP > 0
ORDER BY GDP DESC;

-- Separates countries into high and low GDP groups based on a threshold of 1500,
-- then calculates the count of countries and average life expectancy for each group.
SELECT 
SUM(CASE WHEN GDP >= 1500 THEN 1 ELSE 0 END) High_GDP_Count,
AVG(CASE WHEN GDP >= 1500 THEN `Life expectancy` ELSE NULL END) High_GDP_Life_Expectancy,
SUM(CASE WHEN GDP <= 1500 THEN 1 ELSE 0 END) Low_GDP_Count,
AVG(CASE WHEN GDP <= 1500 THEN `Life expectancy` ELSE NULL END) Low_GDP_Life_Expectancy
FROM world_life_expectancy;

-- Groups the data by 'Status' (developed or developing status) and calculates the average life expectancy for each status group.
SELECT Status, ROUND(AVG(`Life expectancy`),1)
FROM world_life_expectancy
GROUP BY Status;

-- Similar to the previous query, but also counts the number of distinct countries within each status group,
-- providing insight into the dataset's composition and the average life expectancy by status.
SELECT Status, COUNT(DISTINCT Country), ROUND(AVG(`Life expectancy`),1)
FROM world_life_expectancy
GROUP BY Status;

-- Aggregates data by country to calculate average life expectancy and Body Mass Index (BMI),
-- only including countries with positive values for both metrics.
-- Results are ordered by BMI in ascending order to spotlight countries with lower average BMI first
SELECT Country, ROUND(AVG(`Life expectancy`),1) AS Life_Exp, ROUND(AVG(BMI),1) AS BMI
FROM world_life_expectancy
GROUP BY Country
HAVING Life_Exp > 0
AND BMI > 0
ORDER BY BMI ASC;

-- For a specific country ('United Kingdom'), calculates the 'Adult Mortality' rate for each year
-- and a rolling total of 'Adult Mortality' over the years.
-- This can show trends in adult mortality within the country over time.
SELECT Country,Year,`Life expectancy`,`Adult Mortality`,
SUM(`Adult Mortality`) OVER(PARTITION BY Country ORDER BY Year) AS Rolling_Total
FROM world_life_expectancy
WHERE Country = 'United Kingdom';