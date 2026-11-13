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
  * Imported the raw CSV data into a structured MySQL database, scripts to check for NULL            values across critical fields and scanning for duplicate records to prevent skewed metrics.
  * Raw continuous variables were transformed into logical business brackets using SQL CASE          statements.
  * Engineered multi-variable SQL queries to expose interacting risk multipliers that standard       reports miss. 
* Microsoft PowerBI
  * It bridges complex backend data to bring interacting risk factors such as credit tiers, debt
    to-income ratios, and employment tenure to life in an intuitive visual layout.
  * It allows risk managers to dynamically filter across borrower segments and co-signer             statuses to pinpoint toxic underwriting clusters and guide proactive lending decisions.

# Key Analytical Insights
* Default rates decreases with age, with young borrowers (18–30) showing the highest default rate (19.39%), compared to just 5.05% for older borrowers (61–69).
* Default rates increase with loan size, rising from (8.06%) for loans below 50K to (15.79%) for loans between $200K–$250K.
* Borrowers with poor credit scores (below 500) have the highest default rate (12.77%) and represent the largest customer segment (93,507 loans), while default rates decline to 9.83% for borrowers with excellent credit scores (800+).
* Default rates increase from 10.36% for borrowers with low DTI to a peak of 12.24% at 0.60–0.79, then stabilize at 12.18% for extreme DTI (0.80+), with over 127,000 borrowers falling in the moderate-to-high DTI segments.
* Unemployed borrowers shows the highest default rate (13.55%), followed by borrowers with less than 1 year of experience (16.91%), while full-time employees (9.46%) and those with 5–10 years of experience (8.92%) demonstrate the lowest default rates.
* Borrowers earning below 50K have a significantly higher default rate (17.16%), while high income borrowers maintain rates between 8.92% and 10.44%.
* Default rates increase significantly with interest rates, rising from 6.02% for loans below 5% interest to 17.82% for loans at 20–25%.
* Business loans have the highest default rate (12.33%), while home loans have the lowest (10.23%).
* Default rates remain nearly constant (11.57%–11.70%) across all loan terms (12–60 months).
* Default rates increase from 10.52% for borrowers with 1 active credit line to 12.94% for those with 4.
* Loans without a co-signer (12.87%) and borrowers without dependents (12.72%) show higher defaults than co-signed loans (10.36%) with dependents (10.50%).
* Divorced (12.53%) and single borrowers (11.91%), along with high school graduates (12.88%), show higher default rates, while married borrowers (10.40%) and advanced degree holders, particularly PhD (10.59%), show less default rates.
* Borrowers without an existing mortgage have a higher default rate (12.35%) than those with a mortgage (10.88%).
 
# Recommendations
* Restrict unsecured lending when a borrower's DTI ratio exceeds (0.60) with less than 2 years of employment tenure.
* Mandate verified co-signers or collateral for applicants with low income (<$50K) or subprime credit scores (<500).
* Place strict approval limits and collateral requirements on large loans ($200K–$250K), unless offset by strong credit scores (700+).
* Cap unsecured loans exceeding 150K for young adults aged (18–30) who lack a co-signer.
* Enforce tighter DTI limits and secondary income verification for Unemployed or Part-time applicants without co-signers.
* Automatically flag or penalize applications where borrowers juggle 3+ open credit lines alongside a high DTI (>0.60).
* Establish automated early-warning alerts for existing borrowers in high interest-rate tiers (20%–25%) who show expanding credit lines.

# Dashboard Walkthrough
<img width="1432" height="806" alt="LoanDefaultRiskAnalysis_Dasboard_Picture" src="https://github.com/user-attachments/assets/5e79fee4-18ef-4160-a284-100d1119c306" />

* Top-Level KPI Cards: Instantly display portfolio scale, volume, and monetary default exposure to ground stakeholders in the financial stakes.
* Credit Score & DTI Distribution Charts: Map default rates across credit tiers and debt-to-income ratios to highlight how high debt and poor credit compound risk.
* Employment Stability & Income Matrix: Evaluate career tenure and income brackets to demonstrate how short job history acts as a primary risk multiplier.
* Co-Signer & Loan Purpose Breakdown: Examine structural risk mitigators to highlight the dramatic protective effect of co-signers in lowering default rates.

# Repository Structure
1. README.md - project document
2. `CustomerData_Excel_File` - raw dataset (255,347 records)
3. `SQL_Script.sql` - run the script in MySQL Workbench to create the loandefaultrisk_analysis database, import the csv dataset, and execute the risk-segmentation queries.
4. `LoanDefaultRiskAnalysis_PowerBI_File` - open the file in Microsoft Power BI Desktop to interact with the filters, inspect DAX measures, and explore borrower segments.







