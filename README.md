# Employee Analysis

### Project Overview
This project involves performing end-to-end SQL-based data analysis (employee_demographics, employee_salary, and layoffs). The aim is to demonstrate SQL proficiency in data cleaning, exploratory analysis, aggregations, joins, subqueries, and window functions to uncover trends and make informed recommendations.

### Data Source
#### Beginner-Parks_and_Rec_Create
- Employee_Demographics: Contains employee ID, names, birth dates, gender, and age.
- Employee_Salary: Includes employee ID, salary, occupation, and department ID.
- Layoffs: Contains global tech layoff data, including company, industry, country, funding, and layoff metrics.

### Tools
SQL for data analysis

### Data Cleaning/Preparation
- Removed duplicates using ROW_NUMBER() in both layoffs and layoffs_stage tables.
- Standardized data entries using:
- TRIM() to remove trailing whitespaces from company and country.
   - STR_TO_DATE() to convert text-formatted dates into actual DATE types.
   - REPLACE() and UPPER()/LOWER() functions to clean textual fields.
   - Normalized inconsistent industry names (e.g., mapping all “Crypto-related” entries to "Crypto").
- Used CASE statements to bucket employees by age groups and compute salary increments/bonuses.
- Created temporary tables and Common Table Expressions (CTEs) for stepwise transformations.
- Used triggers and procedures to automate employee data insertion and salary checks.

### Data Analysis
Include interesting code/features worked with
```sql
Select distinct industry
From layoffs_stage2
Order by 1;

Select dem.company, dem.industry, sal.company, sal.industry
 From layoffs_stage2 dem
   Inner Join layoffs_stage2 sal
     On dem.company = sal.company
       Where (dem.industry = '' or dem.industry IS Null)
		  And sal.industry IS NOT Null
             ;

Update layoffs_stage2 dem
  Inner Join layoffs_stage2 sal
     On dem.company = sal.company
       Set dem.industry = sal.company
       Where (dem.industry = '' or dem.industry IS Null)
		  And sal.industry IS NOT Null
               ;
```

### Results/Findings
The analysis results are summarized as follows:
- The average salary for male employees is higher than for female employees across departments.
- Certain high-paying occupations (e.g., managers and CEOs) are concentrated in a few departments.
- In the layoff dataset, many entries had missing or inconsistent industry, date, and company values.
- Duplicate entries were common in the layoff dataset, but successfully removed using window functions.


### References
[Alex the Analyst - YouTube Channel](https://www.youtube.com/watch?v=OT1RErkfLNQ&list=PL9PrwgRNlv62OiqVlASto1N4cAQRg60dr&index=22&pp=gAQBiAQB)








