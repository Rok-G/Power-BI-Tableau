# Automated Data Cleaning Project on US Household Income 🧼💼

## Introduction 🌟

📊 This project focuses on automating data cleaning processes, aiming to enhance the accuracy and reliability of data analytics 💡.

## Background 📚

This project leverages SQL to automate the cleaning of US household income data 🇺🇸💵, preparing it for insightful analysis and decision-making.

Data originates from a comprehensive dataset detailing household incomes across the United States, enriched with geographical 🌎 and demographic 👥 details.

Through this project, we sought to answer:
- How can we automate data cleaning for efficiency and accuracy? 🤖✨
- What strategies ensure the preservation of raw data while maintaining a clean dataset for analysis? 🛡️📊
- How can automated processes facilitate data integrity and standardization? 🔄🔍

## Tools I Used 🔧

This project is built on the foundation of several essential tools:

- **MySQL:** The backbone of our data cleaning, enabling sophisticated querying and automation capabilities 🚀🧹.

## The Analysis 🕵️

This project employs MySQL stored procedures and events to automate the data cleaning process. Here’s a glimpse into the methodology:

1. **Automated Data Copying and Cleaning**
   - A stored procedure (`Copy_and_Clean_Data`) duplicates the original dataset, preserving raw data 📝 and creating a new cleaned version for analysis.
   - This procedure also includes steps to standardize text fields 📋, correct common data errors ❌, and remove duplicate records 🚫📈.

2. **Event Scheduling for Regular Data Cleaning**
   - A MySQL event (`run_data_cleaning`) is scheduled to automatically invoke the data cleaning procedure 📅🔄, ensuring the dataset remains current and clean 🌟.

## Instructions 📝

1. **Event Scheduler Activation:**
   Ensure the MySQL Event Scheduler is enabled to allow automatic execution of the cleaning process. You can enable the scheduler by ensuring that the event scheduler is enabled in your MySQL instance. This can be checked with `SHOW VARIABLES LIKE 'event_scheduler';` and enabled with `SET GLOBAL event_scheduler = ON;`. Without the event scheduler enabled, the `CREATE EVENT` statement will not produce an error, but the event will not run as expected.
   
## Deployment 🚀

- Clone the repository to obtain the SQL scripts 📂.
- Use MySQL Workbench or a similar tool to execute the script, creating the necessary procedures, events, and triggers in your database 💾🔨.

## Execution 🏃

Initially, manually invoke the `Copy_and_Clean_Data` procedure to populate the cleaned dataset 🔄.

- The event and trigger will automatically handle subsequent data cleaning 🧼🔄.

## What I Learned 🎓

- 🔄 **Automation with MySQL:** Developed proficiency in automating data cleaning tasks using stored procedures, triggers, and events 🛠️.
- 🔒 **Data Integrity Maintenance:** Gained insights into maintaining a pristine dataset while preserving the original data for auditability 📚🔐.
- 🧹 **Clean Data Best Practices:** Learned the importance of consistent data cleaning practices for reliable analysis and decision-making 📈👩‍🏫.

## Conclusions 🎉

This project underscores the significance of automated data cleaning in enhancing data quality and reliability 🚀. By leveraging MySQL's advanced features, we've established a robust framework for maintaining clean and accurate datasets 📊, facilitating more informed economic analyses and decisions 💡🎯.
