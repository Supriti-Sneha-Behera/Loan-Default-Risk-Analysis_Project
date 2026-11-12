# Loan Default Risk Analysis Project

# Project Overview
Banks give loans to customers but not everyone successfully repays them. When customers fail to repay their loans, banks face financial losses...
* So, I have worked on this project using MySQL and Microsoft Power BI to analyse 255,000+ rows of historical loan data and identify which customer segments were more likely to default on their loans.
* Instead of automatically rejecting the applicant, this project helps the bank's credit team decide which application needs manual review.
* And the ultimate goal of this project is to help the credit team and the bank understand the patterns behind loan defaults so it can make better lending decisions in the future.

#  Tools Used
* Microsoft Excel
* MySQL
* Microsoft Power BI

# Purpose of Tools
* MySQL
  * We imported the raw CSV data into a structured MySQL database, scripts to check for NULL          values across critical fields and scanning for duplicate records to prevent skewed metrics.
  * Raw continuous variables were transformed into logical business brackets using SQL CASE           statements.
  * We engineered multi-variable SQL queries to expose interacting risk multipliers that standard     reports miss. 
* Microsoft PowerBI
  *

# Recommendations

# Repository Structure
1. README.md - project document
2. `CustomerData_Excel_File` - raw dataset (255,347 records)
3. `SQL_Script.sql` - run the script in MySQL Workbench to create the loandefaultrisk_analysis database, import the csv dataset, and execute the risk-segmentation queries.
4. `LoanDefaultRiskAnalysis_PowerBI_File` - open the file in Microsoft Power BI Desktop to interact with the filters, inspect DAX measures, and explore borrower segments.







