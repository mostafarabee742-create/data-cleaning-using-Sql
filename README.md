# data-cleaning-using-Sql

Data Cleaning Using SQL – Layoffs Dataset
Problem Statement

The raw layoffs dataset contained duplicate records, inconsistent text formatting, missing values, and incorrect data types, making it unreliable for analysis.
The objective of this project was to clean and standardize the data using SQL, ensuring accuracy and consistency so it can be confidently used for analytical reporting and insights.

-Project Overview:

This project demonstrates a complete data cleaning workflow using SQL on a layoffs dataset.
All cleaning steps were executed directly in SQL, following best practices commonly used in real-world data analytics projects.

-Dataset Description:

Dataset: Layoffs data

Structure: Single table (layoffs)

-Common Issues Identified:

Duplicate rows

Inconsistent company and industry naming

Blank and null values

Incorrect date format

Redundant columns

-Tools & Technologies:

SQL

Techniques: CTEs, Window Functions, Data Standardization

-Data Cleaning Process
1. Data Exploration

Reviewed raw data using SELECT *

Checked for duplicates and null values

2. Removing Duplicates

Created a staging table to preserve raw data

Used ROW_NUMBER() with PARTITION BY across key columns

Deleted records where duplicate row number > 1

3. Standardizing Data

Trimmed extra spaces from company names

Unified industry values (e.g., crypto-related entries)

Standardized country names

Converted date column to proper DATE format

4. Handling Null and Blank Values

Replaced blank strings with NULL

Populated missing industry values using self-joins

Removed records where critical fields were missing

5. Column Cleanup

Removed helper columns used for deduplication

Kept only analysis-relevant fields

SQL Concepts Used

CTE (WITH)

ROW_NUMBER() OVER (PARTITION BY)

TRIM()

UPDATE, DELETE

CASE WHEN

IS NULL

Self joins for data enrichment

-Final Outcome

Duplicate-free dataset

Consistent and standardized values

Proper data types for dates

Clean table ready for analysis or dashboarding

-Repository Structure


Author

Mostafa
Aspiring Data Analyst | SQL | Data Cleaning | Data Analysis
