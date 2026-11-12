SELECT * 
FROM loandefaultrisk_analysis.loan_data
;

#---LOAD THE DATA---
LOAD DATA LOCAL INFILE 'C:/Users/SUPRITI BEHERA/Downloads/A.csv'
INTO TABLE loandefaultrisk_analysis.loan_data
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS;

#---COUNT THE ROWS---
SELECT COUNT(*) 
FROM loandefaultrisk_analysis.loan_data
;

#---FIND ANY NULL VALUES---
SELECT * 
FROM loandefaultrisk_analysis.loan_data
WHERE LoanID IS NULL
OR Age IS NULL
OR Income IS NULL
OR LoanAmount IS NULL
OR CreditScore IS NULL
OR Months_Employed IS NULL
OR NumCreditLines IS NULL
OR InterestRate IS NULL
OR LoanTerm IS NULL
;
SELECT * 
FROM loandefaultrisk_analysis.loan_data
WHERE DTIRatio IS NULL
OR Education IS NULL
OR EmployementType IS NULL
OR MartialStaus IS NULL
OR HasMortgage IS NULL
OR HasDependents IS NULL
OR LoanPurpose IS NULL
OR HasCosigner IS NULL
OR `Default` IS NULL
;

#---FIND ANY DUPLICATE VALUES---
SELECT 
    LoanID, Age, Income, LoanAmount, CreditScore, Months_Employed, NumCreditLines, InterestRate, LoanTerm, DTIRatio, 
    Education, EmployementType, MartialStaus, HasMortgage, HasDependents, LoanPurpose, HasCoSigner, `Default`,
    COUNT(*) AS Duplicate_Count
FROM loandefaultrisk_analysis.loan_data
GROUP BY LoanID, Age, Income, LoanAmount, CreditScore, Months_Employed, NumCreditLines, InterestRate, LoanTerm, DTIRatio, 
    Education, EmployementType, MartialStaus, HasMortgage, HasDependents, LoanPurpose, HasCoSigner, `Default`
HAVING COUNT(*) > 1
;

#---TOTAL LOANS,TOTAL DEFAULTS AND TOTAL DEFAULT RATE---
SELECT COUNT(*) AS Total_Loans,
SUM(`Default`) AS Total_Defaults,
ROUND(SUM(`Default`) * 100.0 / COUNT(*), 2) AS Total_Default_Rate
FROM  loandefaultrisk_analysis.loan_data
;

#---TOTAL MONETARY VALUE OF LOANS REQUESTED VS TOTAL DEFAULTED AMOUNT---
SELECT 
    SUM(LoanAmount) AS Total_Loan_Amount_Requested,
    SUM(CASE WHEN `Default` = 1 THEN LoanAmount ELSE 0 END) AS Total_Defaulted_Amount,
    ROUND(SUM(CASE WHEN `Default` = 1 THEN LoanAmount ELSE 0 END) * 100.0 / SUM(LoanAmount), 2) AS Defaulted_Rate
FROM loandefaultrisk_analysis.loan_data
;

#---ANALYZE DEFAULT RATE BY AGE---
SELECT 
    CASE 
        WHEN Age < 25 THEN 'Under 25'
        WHEN Age BETWEEN 25 AND 35 THEN '25-35'
        WHEN Age BETWEEN 36 AND 50 THEN '36-50'
        ELSE '51+' 
    END AS Age_Bracket,
    COUNT(*) AS Total_Loans,
    SUM(`Default`) AS Total_Defaults,
    ROUND(SUM(`Default`) * 100.0 / COUNT(*), 2) AS Default_Rate
FROM  loandefaultrisk_analysis.loan_data
GROUP BY Age_Bracket
ORDER BY Default_Rate DESC
;

#---AVERAGE INCOME OF ALL THE CUSTOMERS---
SELECT ROUND(AVG(Income), 2) AS Average_Income
FROM loandefaultrisk_analysis.loan_data
;

#--- ANALYZE DEFAULT RATE BY INCOME---
SELECT 
    CASE 
        WHEN Income < 20000 THEN 'Under 20K'
        WHEN Income BETWEEN 20000 AND 59999 THEN '20K-60K'
        WHEN Income BETWEEN 60000 AND 99999 THEN '60K-100K'
        WHEN Income BETWEEN 100000 AND 139999 THEN '100K-140K'
        ELSE '140K+' 
    END AS Income_Bracket,
    COUNT(*) AS Total_Loans,
    SUM(`Default`) AS Total_Defaults,
    ROUND(SUM(`Default`) * 100.0 / COUNT(*), 2) AS Default_Rate
FROM loandefaultrisk_analysis.loan_data
GROUP BY Income_Bracket
ORDER BY Default_Rate DESC
;

#---ANALYZE DEFAULT RATE BY LOAN AMOUNT---
SELECT 
    CASE 
        WHEN LoanAmount < 10000 THEN 'Under 10K'
        WHEN LoanAmount BETWEEN 10000 AND 79999 THEN '10K-80K'
        WHEN LoanAmount BETWEEN 80000 AND 159999 THEN '80K-160K'
        WHEN LoanAmount BETWEEN 160000 AND 239999 THEN '160K-240K'
        ELSE '240K+' 
    END AS Loan_Amount_Bracket,
    COUNT(*) AS Total_Loans,
    SUM(`Default`) AS Total_Defaults,
    ROUND(SUM(`Default`) * 100.0 / COUNT(*), 2) AS Default_Rate
FROM loandefaultrisk_analysis.loan_data
GROUP BY Loan_Amount_Bracket
ORDER BY Default_Rate DESC
;

#---AVERAGE CREDIT SCORE OF ALL THE CUSTOMERS---
SELECT ROUND(AVG(CreditScore), 0) AS Average_Credit_Score
FROM loandefaultrisk_analysis.loan_data
;

#---ANALYZE DEFAULT RATE BY CREDIT SCORE---
SELECT 
    CASE 
        WHEN CreditScore < 500 THEN 'Poor (<500)'
        WHEN CreditScore BETWEEN 500 AND 599 THEN 'Fair (500-599)'
        WHEN CreditScore BETWEEN 600 AND 699 THEN 'Good (600-699)'
        WHEN CreditScore BETWEEN 700 AND 799 THEN 'Very Good (700-799)'
        ELSE 'Excellent (800+)' 
    END AS Credit_Score_Bracket,
    COUNT(*) AS Total_Loans,
    SUM(`Default`) AS Total_Defaults,
    ROUND(SUM(`Default`) * 100.0 / COUNT(*), 2) AS Default_Rate
FROM loandefaultrisk_analysis.loan_data
GROUP BY Credit_Score_Bracket
ORDER BY Default_Rate DESC
;

#---ANALYZE DEFAULT RATE BY MONTHS EMPLOYED---
SELECT 
    CASE 
        WHEN Months_Employed < 12 THEN 'Less than 1 year'
        WHEN Months_Employed BETWEEN 12 AND 35 THEN '1-3 years'
        WHEN Months_Employed BETWEEN 36 AND 59 THEN '3-5 years'
        WHEN Months_Employed BETWEEN 60 AND 107 THEN '5-9 years'
        ELSE '9+ years' 
    END AS Month_Employed_Bracket,
    COUNT(*) AS Total_Loans,
    SUM(`Default`) AS Total_Defaults,
    ROUND(SUM(`Default`) * 100.0 / COUNT(*), 2) AS Default_Rate
FROM loandefaultrisk_analysis.loan_data
GROUP BY Month_Employed_Bracket
ORDER BY Default_Rate DESC
;

#---ANALYZE DEFAULT RATE BY NUMER OF CREDIT LINES---
SELECT 
    CASE 
        WHEN NumCreditLines = 1 THEN '1 Line'
        WHEN NumCreditLines BETWEEN 2 AND 3 THEN '2-3 Lines'
        ELSE '4+ Lines' 
    END AS NumCreditLines_Bracket,
    COUNT(*) AS Total_Loans,
    SUM(`Default`) AS Total_Defaults,
    ROUND(SUM(`Default`) * 100.0 / COUNT(*), 2) AS Default_Rate
FROM loandefaultrisk_analysis.loan_data
GROUP BY NumCreditLines_Bracket
ORDER BY Default_Rate DESC
;

#---ANALYZE DEFAULT RATE BY INTEREST RATE---
SELECT 
    CASE 
        WHEN InterestRate < 5.00 THEN 'Low (<5)'
        WHEN InterestRate BETWEEN 5.00 AND 9.99 THEN 'Moderate (5.00-9.99)'
        WHEN InterestRate BETWEEN 10.00 AND 19.99 THEN 'High (10.00-19.99)'
        ELSE 'Very High (20.00+)' 
    END AS Interest_Rate_Bracket,
    COUNT(*) AS Total_Loans,
    SUM(`Default`) AS Total_Defaults,
    ROUND(SUM(`Default`) * 100.0 / COUNT(*), 2) AS Default_Rate
FROM loandefaultrisk_analysis.loan_data
GROUP BY Interest_Rate_Bracket
ORDER BY Default_Rate DESC
;

#---ANALYZE DEFAULT RATE BY LOAN TERM---
SELECT 
    CASE 
        WHEN LoanTerm < 12 THEN 'Less than 1 year'
        WHEN LoanTerm BETWEEN 12 AND 24 THEN '1-2 years'
        WHEN LoanTerm BETWEEN 25 AND 48 THEN '2-4 years' 
        ELSE '4+ years' 
    END AS Loan_Term_Bracket,
    COUNT(*) AS Total_Loans,
    SUM(`Default`) AS Total_Defaults,
    ROUND(SUM(`Default`) * 100.0 / COUNT(*), 2) AS Default_Rate
FROM loandefaultrisk_analysis.loan_data
GROUP BY Loan_Term_Bracket
ORDER BY Default_Rate DESC
;

#---ANALYZE DEFAULT RATE BY DTIRATIO---
SELECT 
    CASE 
        WHEN DTIRatio < 0.20 THEN 'Low (<0.20)'
        WHEN DTIRatio BETWEEN 0.20 AND 0.39 THEN 'Moderate (0.20-0.39)'
        WHEN DTIRatio BETWEEN 0.40 AND 0.59 THEN 'High (0.40-0.59)'
        WHEN DTIRatio BETWEEN 0.60 AND 0.79 THEN 'Very High (0.60-0.79)'
        ELSE 'Extreme (0.80+)' 
    END AS DTI_Ratio_Bracket,
    COUNT(*) AS Total_Loans,
    SUM(`Default`) AS Total_Defaults,
    ROUND(SUM(`Default`) * 100.0 / COUNT(*), 2) AS Default_Rate
FROM loandefaultrisk_analysis.loan_data
GROUP BY DTI_Ratio_Bracket
ORDER BY Default_Rate DESC
;

#---ANALYZE DEFAULT RATE BY EDUCATION---
SELECT 
    Education,
    COUNT(*) AS Total_Loans,
    SUM(`Default`) AS Total_Defaults,
    ROUND(SUM(`Default`) * 100.0 / COUNT(*), 2) AS Default_Rate
FROM loandefaultrisk_analysis.loan_data
GROUP BY Education
ORDER BY Default_Rate DESC
;

#---ANALYZE DEFAULT RATE BY EMPLOYEMENT TYPE---
SELECT 
    EmployementType,
    COUNT(*) AS Total_Loans,
    SUM(`Default`) AS Total_Defaults,
    ROUND(SUM(`Default`) * 100.0 / COUNT(*), 2) AS Default_Rate
FROM loandefaultrisk_analysis.loan_data
GROUP BY EmployementType
ORDER BY Default_Rate DESC
;

#---ANALYZE DEFAULT RATE BY MARTIAL STATUS---
SELECT 
    MartialStaus,
    COUNT(*) AS Total_Loans,
    SUM(`Default`) AS Total_Defaults,
    ROUND(SUM(`Default`) * 100.0 / COUNT(*), 2) AS Default_Rate
FROM loandefaultrisk_analysis.loan_data
GROUP BY MartialStaus
ORDER BY Default_Rate DESC
;

#---ANALYZE DEFAULT RATE BY MORTAGE---
SELECT 
    HasMortgage,
    COUNT(*) AS Total_Loans,
    SUM(`Default`) AS Total_Defaults,
    ROUND(SUM(`Default`) * 100.0 / COUNT(*), 2) AS Default_Rate
FROM loandefaultrisk_analysis.loan_data
GROUP BY HasMortgage
ORDER BY Default_Rate DESC
;

#---ANALYZE DEFAULT RATE BY HAS DEPENDENCE---
SELECT 
    HasDependents,
    COUNT(*) AS Total_Loans,
    SUM(`Default`) AS Total_Defaults,
    ROUND(SUM(`Default`) * 100.0 / COUNT(*), 2) AS Default_Rate
FROM loandefaultrisk_analysis.loan_data
GROUP BY HasDependents
ORDER BY Default_Rate DESC
;

#---ANALYZE DEFAULT RATE BY LOAN PURPOSE---
SELECT 
    LoanPurpose,
    COUNT(*) AS Total_Loans,
    SUM(`Default`) AS Total_Defaults,
    ROUND(SUM(`Default`) * 100.0 / COUNT(*), 2) AS Default_Rate
FROM loandefaultrisk_analysis.loan_data
GROUP BY LoanPurpose
ORDER BY Default_Rate DESC
;

#---DEFAULT RATE BY HAS COSIGNER---
SELECT 
    HasCoSigner,
    COUNT(*) AS Total_Loans,
    SUM(`Default`) AS Total_Defaults,
    ROUND(SUM(`Default`) * 100.0 / COUNT(*), 2) AS Default_Rate
FROM loandefaultrisk_analysis.loan_data
GROUP BY HasCoSigner
ORDER BY Default_Rate DESC
;

#---ANALYZE THE DEFAULT RATE BY INCOME BRACKET AND COSIGNER---
SELECT 
    CASE 
        WHEN Income < 20000 THEN 'Under 20K'
        WHEN Income BETWEEN 20000 AND 59999 THEN '20K-60K'
        WHEN Income BETWEEN 60000 AND 99999 THEN '60K-100K'
        WHEN Income BETWEEN 100000 AND 139999 THEN '100K-140K'
        ELSE '140K+' 
    END AS Income_Bracket, HasCosigner,
    COUNT(*) AS Total_Loans,
    SUM(`Default`) AS Total_Defaults,
    ROUND(SUM(`Default`) * 100.0 / COUNT(*), 2) AS Default_Rate
FROM loandefaultrisk_analysis.loan_data
GROUP BY Income_Bracket,HasCosigner
ORDER BY Income_Bracket,HasCosigner, Default_Rate DESC
;

#---ANALYZE THE DEFAULT RATE BY EMPLOYEMENT TYPE AND LOAN PURPOSE---
SELECT 
    EmployementType,LoanPurpose,
    COUNT(*) AS Total_Loans,
    SUM(`Default`) AS Total_Defaults,
    ROUND(SUM(`Default`) * 100.0 / COUNT(*), 2) AS Default_Rate
FROM loandefaultrisk_analysis.loan_data
GROUP BY EmployementType, LoanPurpose
ORDER BY Default_Rate DESC
;

#---ANALYZE THE DEFAULT RATE BY CREDIT SCORE AND LOAN AMOUNT---
SELECT 
    CASE 
        WHEN CreditScore < 500 THEN 'Poor (<500)'
        WHEN CreditScore BETWEEN 500 AND 599 THEN 'Fair (500-599)'
        WHEN CreditScore BETWEEN 600 AND 699 THEN 'Good (600-699)'
        WHEN CreditScore BETWEEN 700 AND 799 THEN 'Very Good (700-799)'
        ELSE 'Excellent (800+)'
    END AS Credit_Score_Bracket,
    CASE 
		WHEN LoanAmount < 10000 THEN 'Under 10K'
        WHEN LoanAmount BETWEEN 10000 AND 79999 THEN '10K-80K'
        WHEN LoanAmount BETWEEN 80000 AND 159999 THEN '80K-160K'
        WHEN LoanAmount BETWEEN 160000 AND 239999 THEN '160K-240K'
        ELSE '240K+' 
    END AS Loan_Amount_Bracket,
    COUNT(*) AS Total_Loans,
    SUM(`Default`) AS Total_Defaults,
    ROUND(SUM(`Default`) * 100.0 / COUNT(*), 2) AS Default_Rate
FROM loandefaultrisk_analysis.loan_data
GROUP BY Credit_Score_Bracket, Loan_Amount_Bracket
ORDER BY Default_Rate DESC
;

#---ANALYZE THE DEFAULT RATE BY DTI RATIO AND HAS MORTGAGE---
SELECT 
    CASE 
        WHEN DTIRatio < 0.20 THEN 'Low (<0.20)'
        WHEN DTIRatio BETWEEN 0.20 AND 0.39 THEN 'Moderate (0.20-0.39)'
        WHEN DTIRatio BETWEEN 0.40 AND 0.59 THEN 'High (0.40-0.59)'
        WHEN DTIRatio BETWEEN 0.60 AND 0.79 THEN 'Very High (0.60-0.79)'
        ELSE 'Extreme (0.80+)'
    END AS DTI_Ratio_Bracket,HasMortgage,
    COUNT(*) AS Total_Loans,
    SUM(`Default`) AS Total_Defaults,
    ROUND(SUM(`Default`) * 100.0 / COUNT(*), 2) AS Default_Rate
FROM loandefaultrisk_analysis.loan_data
GROUP BY HasMortgage, DTI_Ratio_Bracket
ORDER BY Default_Rate DESC
;

#---ANALYZE THE DEFAULT RATE BY MONTHS EMPLOYED AND INCOME---
SELECT 
    CASE 
		WHEN Income < 20000 THEN 'Under 20K'
        WHEN Income BETWEEN 20000 AND 59999 THEN '20K-60K'
        WHEN Income BETWEEN 60000 AND 99999 THEN '60K-100K'
        WHEN Income BETWEEN 100000 AND 139999 THEN '100K-140K'
        ELSE '140K+' 
    END AS Income_Bracket,
    CASE 
		WHEN Months_Employed < 12 THEN 'Less than 1 year'
        WHEN Months_Employed BETWEEN 12 AND 35 THEN '1-3 years'
        WHEN Months_Employed BETWEEN 36 AND 59 THEN '3-5 years'
        WHEN Months_Employed BETWEEN 60 AND 107 THEN '5-9 years'
        ELSE '9+ years'
    END AS Months_Employed_Bracket,
    COUNT(*) AS Total_Loans,
    SUM(`Default`) AS Total_Defaults,
    ROUND(SUM(`Default`) * 100.0 / COUNT(*), 2) AS Default_Rate
FROM loandefaultrisk_analysis.loan_data
GROUP BY Income_Bracket, Months_Employed_Bracket
ORDER BY Default_Rate DESC
;

#---ANALYZE THE DEFAULT RATE BY CREDIT LINES AND INTEREST RATES---
SELECT 
    CASE 
        WHEN NumCreditLines = 1 THEN '1 Line'
        WHEN NumCreditLines BETWEEN 2 AND 3 THEN '2-3 Lines'
        ELSE '4+ Lines' 
    END AS Credit_Line_Bracket,
    CASE 
		WHEN InterestRate < 5.00 THEN 'Low (<5)'
        WHEN InterestRate BETWEEN 5.00 AND 9.99 THEN 'Moderate (5.00-9.99)'
        WHEN InterestRate BETWEEN 10.00 AND 19.99 THEN 'High (10.00-19.99)'
        ELSE 'Very High (20.00+)' 
    END AS Interest_Rate_Bracket,
    COUNT(*) AS Total_Loans,
    SUM(`Default`) AS Total_Defaults,
    ROUND(SUM(`Default`) * 100.0 / COUNT(*), 2) AS Default_Rate
FROM loandefaultrisk_analysis.loan_data
GROUP BY Credit_Line_Bracket, Interest_Rate_Bracket
ORDER BY Default_Rate DESC
;

#---ANALYZE THE DEFAULT RATE BY EDUCATION AND EMPLOYEMENT TYPE---
SELECT 
    Education,EmployementType,
    COUNT(*) AS Total_Loans,
    SUM(`Default`) AS Total_Defaults,
    ROUND(SUM(`Default`) * 100.0 / COUNT(*), 2) AS Default_Rate
FROM loandefaultrisk_analysis.loan_data
GROUP BY Education, EmployementType
ORDER BY Default_Rate DESC
;

#---ANALYZE THE DEFAULT RATE BY CREDIT LOAN TERM AND LOAN PURPOSE---
SELECT 
    LoanPurpose,LoanTerm,
    COUNT(*) AS Total_Loans,
    SUM(`Default`) AS Total_Defaults,
    ROUND(SUM(`Default`) * 100.0 / COUNT(*), 2) AS Default_Rate
FROM loandefaultrisk_analysis.loan_data
GROUP BY LoanPurpose, LoanTerm
ORDER BY Default_Rate DESC
;




















