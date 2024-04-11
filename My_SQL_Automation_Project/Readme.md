# 🧹 Automated Data Cleaning Project on US Household Income

## 🌟 Overview

This project focuses on automating data cleaning processes, aiming to enhance the accuracy and reliability of data analytics.

## 💻 Tools Used

- **MySQL**: Employed for its advanced data querying and automation capabilities, enabling the execution of sophisticated data cleaning operations.

## 🚀 Getting Started

To dive into this project and start exploring the US Household Income dataset:

1. **Repository Setup**: Clone or download this repository to get access to both the dataset and the MySQL scripts.
2. **MySQL Configuration**: Make sure MySQL is installed and properly configured on your device.
3. **Database Initialization**: Utilize the provided SQL scripts to establish the database schema and populate it with the income data.
4.  **Event Scheduler Activation:**
   Ensure the MySQL Event Scheduler is enabled to allow automatic execution of the cleaning process. You can enable the scheduler by ensuring that the event scheduler is enabled in your MySQL instance. This can be checked with `SHOW VARIABLES LIKE 'event_scheduler';` and enabled with `SET GLOBAL event_scheduler = ON;`. Without the event scheduler enabled, the `CREATE EVENT` statement will not produce an error, but the event will not run as expected.

## 🔍 Data Cleaning and Preparation

A paramount step in this project is ensuring the dataset's integrity and accuracy. This involves:
- Eliminating duplicate records.
- Rectifying data entry inaccuracies.
- Standardizing data formats across the dataset.

## 🔄 Automated Cleaning Process
This project leverages SQL to automate the cleaning of US household income data, preparing it for insightful analysis and decision-making.

Data originates from a comprehensive dataset detailing household incomes across the United States, enriched with geographical and demographic details.

Through this project, we sought to answer:
- How can we automate data cleaning for efficiency and accuracy? 
- What strategies ensure the preservation of raw data while maintaining a clean dataset for analysis? 
- How can automated processes facilitate data integrity and standardization?
- 
### Copying and Cleaning

- A stored procedure (`Copy_and_Clean_Data`) duplicates the original dataset, preserving raw data and creating a new cleaned version for analysis.
   - This procedure also includes steps to standardize text fields, correct common data errors, and remove duplicate records.

### Scheduled Data Maintenance

We also introduce a MySQL event, `run_data_cleaning`, to periodically activate the cleaning process, guaranteeing the dataset's continual freshness and reliability.

## 🎓 What I Learned 

- 🔄 **Automation with MySQL:** Developed proficiency in automating data cleaning tasks using stored procedures, triggers, and events.
- 🔒 **Data Integrity Maintenance:** Gained insights into maintaining a pristine dataset while preserving the original data for auditability.
- 🧹 **Clean Data Best Practices:** Learned the importance of consistent data cleaning practices for reliable analysis and decision-making.

## 🎉 Conclusions 

This project underscores the significance of automated data cleaning in enhancing data quality and reliability. By leveraging MySQL's advanced features, we've established a robust framework for maintaining clean and accurate datasets, facilitating more informed analyses and decisions.

## 🤝 Contributing

Your contributions are welcome! Feel free to fork this project, enhance the cleaning process, expand the analyses, or refine the documentation.

## ©️ License

This project is released under the MIT License. See the [LICENSE](./LICENSE.md) file for more details.
