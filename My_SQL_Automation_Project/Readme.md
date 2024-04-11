# 🧹 Automated Data Cleaning Project on US Household Income

## 🌟 Overview

This initiative delves into automating the data cleaning process for the US Household Income dataset, aiming to enhance both the accuracy and reliability of data analytics. Through meticulous examination of household income data across different states, this project endeavors to shed light on income disparities and standardize the dataset for comprehensive economic analysis.

## 💻 Tools Used

- **MySQL**: Employed for its advanced data querying and automation capabilities, enabling the execution of sophisticated data cleaning operations.

## 🚀 Getting Started

To dive into this project and start exploring the US Household Income dataset:

1. **Repository Setup**: Clone or download this repository to get access to both the dataset and the MySQL scripts.
2. **MySQL Configuration**: Make sure MySQL is installed and properly configured on your device.
3. **Database Initialization**: Utilize the provided SQL scripts to establish the database schema and populate it with the income data.
4. **Data Exploration**: Execute the predefined queries or craft your own analyses to investigate the cleaned dataset and uncover insights.

## 📊 Dataset Overview

The dataset under scrutiny offers a detailed exploration of household income within the US, encompassing:

- `State_Name`: Name of each state.
- `County`: Respective counties within the states.
- `City`: Cities within the counties.
- `Mean`: Mean household income for specified areas.
- `Median`: Median household income for those areas.
- `Type`: Classification of areas (urban, suburban, rural).

## 🔍 Data Cleaning and Preparation

A paramount step in this project is ensuring the dataset's integrity and accuracy. This involves:
- Eliminating duplicate records.
- Rectifying data entry inaccuracies.
- Standardizing data formats across the dataset.

## 🔄 Automated Cleaning Process

### Copying and Cleaning

The heart of our analysis is the `Copy_and_Clean_Data` stored procedure, which:
- Duplicates the dataset for preservation and analysis.
- Standardizes text fields, amends common errors, and removes duplicates.

### Scheduled Data Maintenance

We also introduce a MySQL event, `run_data_cleaning`, to periodically activate the cleaning process, guaranteeing the dataset's continual freshness and reliability.

## 💡 Conclusions and Insights

This meticulous project unveils the critical role automated data cleaning plays in ensuring data quality and reliability. By harnessing MySQL's powerful features, we've crafted a robust framework for maintaining an accurate and standardized dataset, paving the way for insightful economic analyses and informed decision-making.

## 🤝 Contributing

Your contributions are welcome! Feel free to fork this project, enhance the cleaning process, expand the analyses, or refine the documentation.

## ©️ License

This project is released under the MIT License. See the [LICENSE](./LICENSE.md) file for more details.
# Automated Data Cleaning Project on US Household Income 

 ## 🌟 Introduction 

📊 This project focuses on automating data cleaning processes, aiming to enhance the accuracy and reliability of data analytics.

## Background 📚

This project leverages SQL to automate the cleaning of US household income data, preparing it for insightful analysis and decision-making.

Data originates from a comprehensive dataset detailing household incomes across the United States, enriched with geographical and demographic details.

Through this project, we sought to answer:
- How can we automate data cleaning for efficiency and accuracy? 
- What strategies ensure the preservation of raw data while maintaining a clean dataset for analysis? 
- How can automated processes facilitate data integrity and standardization? 

## Tools I Used 🔧

- **MySQL:** The backbone of our data cleaning, enabling sophisticated querying and automation capabilities.

## The Analysis 🕵️

This project employs MySQL stored procedures and events to automate the data cleaning process. Here’s a glimpse into the methodology:

1. **Automated Data Copying and Cleaning**
   - A stored procedure (`Copy_and_Clean_Data`) duplicates the original dataset, preserving raw data 📝 and creating a new cleaned version for analysis.
   - This procedure also includes steps to standardize text fields 📋, correct common data errors ❌, and remove duplicate records.

2. **Event Scheduling for Regular Data Cleaning**
   - A MySQL event (`run_data_cleaning`) is scheduled to automatically invoke the data cleaning procedure, ensuring the dataset remains current and clean.

## Instructions 📝

1. **Event Scheduler Activation:**
   Ensure the MySQL Event Scheduler is enabled to allow automatic execution of the cleaning process. You can enable the scheduler by ensuring that the event scheduler is enabled in your MySQL instance. This can be checked with `SHOW VARIABLES LIKE 'event_scheduler';` and enabled with `SET GLOBAL event_scheduler = ON;`. Without the event scheduler enabled, the `CREATE EVENT` statement will not produce an error, but the event will not run as expected.
   
## Deployment 🚀

- Clone the repository to obtain the SQL scripts.
- Use MySQL Workbench or a similar tool to execute the script, creating the necessary procedures, events, and triggers in your database.

## Execution 🏃

Initially, manually invoke the `Copy_and_Clean_Data` procedure to populate the cleaned dataset.

- The event and trigger will automatically handle subsequent data cleaning.

## What I Learned 🎓

- 🔄 **Automation with MySQL:** Developed proficiency in automating data cleaning tasks using stored procedures, triggers, and events.
- 🔒 **Data Integrity Maintenance:** Gained insights into maintaining a pristine dataset while preserving the original data for auditability.
- 🧹 **Clean Data Best Practices:** Learned the importance of consistent data cleaning practices for reliable analysis and decision-making.

## Conclusions 🎉

This project underscores the significance of automated data cleaning in enhancing data quality and reliability. By leveraging MySQL's advanced features, we've established a robust framework for maintaining clean and accurate datasets, facilitating more informed analyses and decisions.
