# Employee Analysis

### Project Overview

### Data Source

### Tools

### Data Cleaning/Preparation

### Exploratory Data Analysis

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


### Recommendations

### Limitations

### References
[Alex the Analyst - YouTube Channel](https://www.youtube.com/watch?v=OT1RErkfLNQ&list=PL9PrwgRNlv62OiqVlASto1N4cAQRg60dr&index=22&pp=gAQBiAQB)








