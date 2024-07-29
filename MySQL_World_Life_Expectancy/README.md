# World Life Expectancy Data Analysis Project

## Overview

This project dives deep into **exploring**, **cleaning**, and **analyzing** the World Life Expectancy dataset. Our aim is to uncover insightful trends about global health, focusing on factors like life expectancy, GDP, adult mortality, and BMI across various countries over time.

## Tools Used

- **MySQL** for robust database management and sophisticated query execution.

## How to Use

1. **Clone this repository** to your local machine.
2. Make sure **MySQL** is installed and properly set up on your system.
3. Execute the **SQL scripts** provided to create and populate the database.
4. Run the analysis queries to start exploring the dataset.

## Dataset Overview

The dataset encompasses a variety of health metrics for countries worldwide, spanning multiple years. Key columns include:

- `Country`
- `Year`
- `Life Expectancy`
- `Adult Mortality`
- `BMI`
- `GDP`

## Data Cleaning Process

**Ensuring data integrity**: We meticulously identify and eliminate duplicate records, address missing values, and correct inconsistencies.

![Duplicate Year _Cleaning1](https://github.com/Rok-G/SQL_Projects/assets/154329858/9bf0a336-54be-4029-ae0f-a5f9f6c88d41)
![Row_ID_Duplicates2](https://github.com/Rok-G/SQL_Projects/assets/154329858/ebaf3a03-423c-46bc-bec3-06c09afa1b98)

## Exploratory Data Analysis (EDA)

### Trends in Life Expectancy

We examine how life expectancy has evolved over 15 years, pinpointing countries with significant improvements.

![life_expectancy_increase_bar_400](https://github.com/Rok-G/SQL_Projects/assets/154329858/4cb49d0d-0de8-487c-bb71-9c0e404daf0b)

### The Relationship Between GDP and Life Expectancy

Our analysis reveals a compelling correlation between a nation's wealth (GDP) and the health of its people.

![life_expectancy_gdp_pie_400](https://github.com/Rok-G/SQL_Projects/assets/154329858/8ae53c2f-2269-41eb-8be7-109cb78cea46)

### BMI Versus Life Expectancy

A closer look at the complex interaction between BMI and life expectancy sheds light on global health patterns.

![life_expectancy_bmi_pie_400](https://github.com/Rok-G/SQL_Projects/assets/154329858/53654f3b-ec8b-4337-9994-70563186bf7a)

## Insights and Conclusions

- **Economic Growth and Health**: There's a notable trend of improving life expectancy in countries experiencing economic upturns.
- **Beyond BMI**: Contrary to common assumptions, higher BMI does not always correlate with lower life expectancy, illustrating the multifaceted nature of health determinants.
- **Progress in Public Health**: Declining adult mortality rates across many regions signal advancements in healthcare and living conditions.

## Contributing

Feel free to fork this project and contribute! Whether it's adding new analyses, enhancing the data cleaning process, or improving the documentation, your contributions are welcome.

## License

This project is licensed under the MIT License - see the [LICENSE.md](./LICENSE.md) file for details.

