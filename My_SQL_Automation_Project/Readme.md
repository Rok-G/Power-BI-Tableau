# Automated Data Cleaning Project on US Household Income

## Introduction

📊  This project focuses on automating data cleaning processes, aiming to enhance the accuracy and reliability of data analytics in the financial domain. 

## Background

Fueled by the necessity for precise and cleansed data in economic research, this project was conceived. It leverages SQL to automate the cleaning of US household income data, preparing it for insightful analysis and decision-making.

Data originates from a comprehensive dataset detailing household incomes across the United States, enriched with geographical and demographic details.

Through this project, we sought to answer:
- How can we automate data cleaning for efficiency and accuracy?
- What strategies ensure the preservation of raw data while maintaining a clean dataset for analysis?
- How can automated processes facilitate data integrity and standardization?

## Tools I Used

This project is built on the foundation of several essential tools:

- **MySQL:** The backbone of our data cleaning, enabling sophisticated querying and automation capabilities.
- **MySQL Workbench:** A unified visual tool for database architects, developers, and DBAs.
- **Git & GitHub:** For version control, enabling collaboration and efficient tracking of changes in SQL scripts.

## The Analysis

This project employs MySQL stored procedures, events, and triggers to automate the data cleaning process. Here’s a glimpse into the methodology:

1. **Automated Data Copying and Cleaning**
   - A stored procedure (`Copy_and_Clean_Data`) duplicates the original dataset, preserving raw data and creating a new cleaned version for analysis.
   - This procedure also includes steps to standardize text fields, correct common data errors, and remove duplicate records.

2. **Event Scheduling for Regular Data Cleaning**
   - A MySQL event (`run_data_cleaning`) is scheduled to automatically invoke the data cleaning procedure, ensuring the dataset remains current and clean.

3. **Trigger-based Cleaning Upon Data Insertion**
   - A trigger (`Transfer_Clean_Data`) calls the cleaning procedure whenever new data is inserted into the raw dataset, maintaining data integrity in real-time.

## Instructions

1. **Event Scheduler Activation:**
   Ensure the MySQL Event Scheduler is enabled to allow automatic execution of the cleaning process. You can enable the scheduler by running:
   ```sql
   SET GLOBAL event_scheduler = ON;
## Deployment

- Clone the repository to obtain the SQL scripts.
- Use MySQL Workbench or a similar tool to execute the script, creating the necessary procedures, events, and triggers in your database.

## Execution

Initially, manually invoke the `Copy_and_Clean_Data` procedure to populate the cleaned dataset:

```sql
CALL Copy_and_Clean_Data();
- The event and trigger will automatically handle subsequent data cleaning.
