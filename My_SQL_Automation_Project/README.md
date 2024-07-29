# Automated Data Cleaning Project on US Household Income

## Overview

This project focuses on automating data cleaning processes, aiming to enhance the accuracy and reliability of data analytics.

## Tools Used

- **MySQL**: Employed for its advanced data querying and automation capabilities, enabling the execution of sophisticated data cleaning operations.

## Getting Started

To dive into this project and start exploring the US Household Income dataset:

1. **Repository Setup**: Clone or download this repository to get access to both the dataset and the MySQL scripts.
2. **MySQL Configuration**: Make sure MySQL is installed and properly configured on your device.
3. **Database Initialization**: Utilize the provided SQL scripts to establish the database schema and populate it with the income data. Ensure the MySQL Event Scheduler is enabled by running `SHOW VARIABLES LIKE 'event_scheduler';` and `SET GLOBAL event_scheduler = ON;` if necessary.

## Data Cleaning and Preparation

Ensuring the dataset's integrity and accuracy is paramount. This involves eliminating duplicate records, rectifying data entry inaccuracies, and standardizing data formats across the dataset.

## Automated Cleaning Process

### Copying and Cleaning

- A stored procedure (`Copy_and_Clean_Data`) duplicates the original dataset, preserving raw data and creating a new cleaned version for analysis. This procedure also includes standardizing text fields, correcting common data errors, and removing duplicate records.

### Scheduled Data Maintenance

- A MySQL event, `run_data_cleaning`, is introduced to periodically activate the cleaning process, ensuring the dataset's continual freshness and reliability.

## What I Learned

- **Automation with MySQL**: Developed proficiency in automating data cleaning tasks using stored procedures, triggers, and events.
- **Data Integrity Maintenance**: Gained insights into maintaining a pristine dataset while preserving the original data for auditability.
- **Clean Data Best Practices**: Learned the importance of consistent data cleaning practices for reliable analysis and decision-making.

## Conclusions

This project underscores the significance of automated data cleaning in enhancing data quality and reliability. By leveraging MySQL's advanced features, we've established a robust framework for maintaining clean and accurate datasets, facilitating more informed analyses and decisions.

## Contributing

Your contributions are welcome! Feel free to fork this project, enhance the cleaning process, expand the analyses, or refine the documentation.

## ©️ License

This project is released under the MIT License. See the [LICENSE](./LICENSE.md) file for more details.
