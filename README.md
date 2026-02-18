# Data_cleaning_SQL

# Project Overview

This project focuses on cleaning and performing exploratory data analysis (EDA) using SQL on a real-world layoffs dataset. The goal is to transform raw, inconsistent data into a structured format and extract meaningful business insights such as layoff trends over time, company-level impact, and industry patterns.

This project demonstrates strong SQL skills including data cleaning, aggregation, window functions, Common Table Expressions (CTEs), and analytical querying.

# Dataset Description

The dataset contains information about global layoffs across companies and industries.

Key columns include:
company – Name of the company
location – Company location
industry – Industry category
total_laid_off – Number of employees laid off
percentage_laid_off – Percentage of workforce laid off
date – Layoff date
stage – Company stage (Startup, Post-IPO, etc.)
country – Country of company
funds_raised_millions – Total funds raised

# Project Objectives
--Data Cleaning
Remove duplicate records
Handle NULL and missing values
Standardize text fields (company, industry, country)
Convert date column to proper DATE format
Remove irrelevant or inconsistent records
Create structured staging tables

--Exploratory Data Analysis (EDA)
Identify total layoffs by company
Identify layoffs trend by year and month
Find companies with highest layoffs
Analyze layoffs by industry and country
Find year with maximum layoffs per company
Identify rolling totals and trends

# Key Insights

Identified companies with highest layoffs globally
Found peak layoff periods (major layoffs concentrated in specific years)
Identified most affected industries
Found companies with complete workforce layoffs (100%)
Observed trends in layoffs post-funding and company stage
Identified maximum layoff year per company

# SQL Concepts Demonstrated

GROUP BY and Aggregations
Window Functions (RANK, ROW_NUMBER, MAX OVER)
Common Table Expressions (CTEs)
Data Cleaning Techniques
Handling NULL values
Date functions
Filtering and sorting
Subqueries

# Tools Used

MySQL
SQL Workbench
GitHub (for project documentation)

# Business Value of This Project
This project demonstrates the ability to:
Clean real-world messy data
Perform structured SQL analysis
Extract meaningful business insights
Use advanced SQL techniques required in Data Analyst roles

# Conclusion
This project highlights end-to-end SQL capabilities including data cleaning, transformation, and exploratory data analysis. It demonstrates readiness for real-world data analyst tasks involving messy datasets and business insight generation.
