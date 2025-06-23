Select * 
From employee_demographics;

Select * 
From employee_salary;

Select first_name,last_name, birth_date
From employee_demographics;

Select first_name,last_name, birth_date, age, (age+20) as age
From employee_demographics;

Select distinct gender
From employee_demographics;

Select *
   From employee_demographics
     Where first_name = 'leslie';

Select *
   From employee_salary
       Where salary > 50000;

Select *
    From employee_demographics
        Where gender = 'Female';

Select *
    From employee_demographics
        Where birth_date > '1985-01-01';


Select *
    From employee_demographics
       Where (gender = 'male' or birth_date >'1985-01-01');


Select *
  From employee_demographics
    Where (first_name = 'Leslie' and age = 44) or age > 55;

Select *
  From employee_demographics
     Where first_name like 'Jer%';

Select *
  From employee_demographics
     Where first_name like 'A__';


Select gender
From employee_demographics
Group by gender ;


Select gender, avg (age) age
From employee_demographics
Group by gender;


Select gender, avg (age) age, max(age), min(age), count(age)
From employee_demographics
Group by gender;

Select first_name
From employee_demographics
Order by first_name;

Select *
From employee_demographics
Order by gender, age;

Select gender, avg(age)
  From employee_demographics
    Group by gender
       Having avg(age)>40;


Select occupation, avg(salary)
  From employee_salary
     Where occupation like '%manager%'
       Group by occupation
          Having avg(salary)>40;

Select*
From employee_demographics
Limit 3;

Select*
From employee_demographics
Limit 2,1;

Select dem.employee_id, dem.age, sal.occupation
  From employee_demographics dem
     Inner join employee_salary sal
        On dem.employee_id = sal.employee_id
           ;


Select*
  From employee_demographics dem
    Inner join employee_salary sal
       On dem.employee_id = sal.employee_id
          Inner join parks_departments pr
              on sal.dept_id = pr.department_id;

Select*
From parks_departments;

Select*
From employee_salary;



Select first_name, last_name
  From employee_demographics
     Union
        Select first_name, last_name
            From employee_salary
               ;

Select first_name, last_name
    From employee_demographics
        Union all
            Select first_name, last_name
                From employee_salary
                   ;


Select first_name, last_name
    From employee_demographics
        Where (age > 40 and gender = 'Male')
             Union 
                Select first_name, last_name
                   From employee_demographics
                      Where (age > 40 and gender = 'Female')
                            Union 
                               Select first_name, last_name
                                   From employee_salary
                                        where salary > 70000
                                            Order by first_name
                                                      ;

Select upper(first_name), lower(first_name)
From employee_demographics;

Select substring(first_name,3,2)
From employee_demographics;

Select first_name, locate('An',first_name)
From employee_demographics;

Select first_name, replace(first_name, 'a','z')
From employee_demographics;

Select concat(first_name, ' ', last_name) as Combined
From employee_demographics;

Select*,
Case
    When age < 30 then 'Young'
       When age between 31 and 50 then 'Old'
           When age > 51  then 'Really Old'
End As Age_Groups
From employee_demographics;

Select*,
Case
   When salary <50000 then salary+(salary*0.05)
        When salary >50000 then salary+(salary*0.07)
End As Increas,
Case
  When dept_id = 6 then salary+(salary*0.10)  
End As Bonus
From employee_salary;

Select*
 From employee_demographics
   Where employee_id in
         (Select employee_id
                From employee_salary
                    Where dept_id = 1);


Select gender, avg(salary) as Salary
  From employee_demographics dem
    Inner join employee_salary sal
       On dem.employee_id = sal.employee_id
          Group by gender;


Select  dem.first_name, dem.last_name, dem.gender, Avg(salary) Over(Partition by gender) as Salary
 From employee_demographics dem
  Inner join employee_salary sal
    On dem.employee_id = sal.employee_id
       ;

Select  dem.first_name, dem.last_name, dem.gender, sal.salary,
sum(salary) Over(Partition by gender order by dem.employee_id) as Salary
 From employee_demographics dem
  Inner join employee_salary sal
    On dem.employee_id = sal.employee_id
       ;


With CTE_Example As
(
Select gender, avg(age), max(age), min(age), count(age)
  From employee_demographics dem
   Inner Join employee_salary sal
      On dem.employee_id = sal.employee_id
       Group by gender
)
Select*
From CTE_Example;


With CTE_Example As
(
Select*
  From employee_demographics
    Where birth_date > '1985-01-01'
),
CTE_Example2 As
(
Select*
  From employee_salary
    Where salary > 50000
)
Select*
 From CTE_Example dem
  Inner join CTE_Example2 sal
     On dem.employee_id= sal.employee_id;


Create temporary table salary_over_50k
Select*
From employee_salary
Where salary > 50000; 


Select*
From salary_over_50k;


Delimiter $$
   Create procedure large_salaries()
      Begin
         Select*
             From employee_salary 
                Where salary >50000;
                   End $$
                     Delimiter ;

Call large_salaries;

Delimiter $$
   Create Trigger insert_employee
      After Insert On employee_salary
          For Each Row
             Begin
                INSERT INTO employee_demographics (employee_id, first_name, last_name)
                   VALUES (NEW.employee_id, NEW.first_name, NEW.last_name);
                        End $$
                           Delimiter ;


INSERT INTO employee_salary (employee_id, first_name, last_name, occupation, salary, dept_id)
VALUES(13, 'Jean-Ralphio','Saperstein','Entertainment 720 CEO',1000000,NULL);

Select*
From employee_demographics;

Select*
From employee_salary;

Create Table layoffs_stage
like layoffs;


Select*
From layoffs_stage;

Insert layoffs_stage
Select*
From layoffs;

Select*
From layoffs_stage;

Select*,
Row_number() over(order by company)
From layoffs_stage;


Select*,
Row_number() over(partition by company, location, industry, total_laid_off, percentage_laid_off, `date`, stage, country, funds_raised_millions) as row_num
From layoffs_stage;

With CTE_Example As
(
Select*,
Row_number() over(partition by company, location, industry, total_laid_off, percentage_laid_off, `date`, stage, country, funds_raised_millions) as row_num
From layoffs_stage
)
Select*
From CTE_Example
Where row_num > 1; 

CREATE TABLE `layoffs_stage2` (
  `company` text,
  `location` text,
  `industry` text,
  `total_laid_off` int DEFAULT NULL,
  `percentage_laid_off` text,
  `date` text,
  `stage` text,
  `country` text,
  `funds_raised_millions` int DEFAULT NULL,
  `row_num` int
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


Insert layoffs_stage2
Select*,
Row_number() over(partition by company, location, industry, total_laid_off, percentage_laid_off, `date`, stage, country, funds_raised_millions) as row_num
From layoffs_stage;

Delete
From layoffs_stage2
Where row_num > 1;


Select*
From layoffs_stage2
Where row_num > 1;


Select*
From layoffs_stage2;

Select company, trim(company)
From layoffs_stage2;

Update layoffs_stage2
Set company = trim(company)
;

Select distinct(industry)
From layoffs_stage2
Order by industry;


Select industry
From layoffs_stage2
Where industry like '%Crypto%'
Order by industry desc;

Update layoffs_stage2
Set industry = 'Crypto'
Where industry like '%Crypto%';

Select distinct industry
From layoffs_stage2
Order by industry;

Select distinct country
From layoffs_stage2
Order by country;

Select distinct country, trim(trailing '.' From country) as country
From layoffs_stage2
Order by country;

Update layoffs_stage2
Set country = trim(trailing '.' From country)
;


Select distinct country
From layoffs_stage2
Order by country;


Select distinct `date`,
str_to_date(`date`, '%m/%d/%Y')
From layoffs_stage2
Order by 1;

Update layoffs_stage2
Set `date` = str_to_date(`date`, '%m/%d/%Y')
; 

Alter table layoffs_stage2
Modify Column `date` date
;


Update layoffs_stage2
Set industry = Null
Where industry = ''; 

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
		  And sal.industry IS NOT Null;
             
Select distinct industry
From layoffs_stage2
Order by 1;


Select total_laid_off, percentage_laid_off
From layoffs_stage2
Where (total_laid_off IS NULL OR percentage_laid_off IS NULL)
;

Alter table layoffs_stage2
Drop column row_num;


Select*
From layoffs_stage2;


Select first_name, last_name, concat(first_name,' ', last_name) as Combined
From employee_demographics;

Select first_name, last_name, 
row_number() over(order by last_name)
From employee_demographics;

Delimiter $$
Create procedure Employment_Demo()
Begin
 Select*
  From employee_demographics dem
    Inner Join employee_demographics sal
     On dem.employee_id = sal.employee_id
       ;
End $$
Delimiter ;

Call Employment_Demo;

Delimiter $$
   Create Trigger employee_insert2
      After Insert On employee_salary
         For Each Row
             Begin
                INSERT INTO employee_demographics (employee_id, first_name, last_name)
                    VALUES (NEW.employee_id, NEW.first_name, NEW.last_name); 
                        End $$
                           Delimiter ;

INSERT INTO employee_salary (employee_id, first_name, last_name, occupation, salary, dept_id)
VALUES(13, 'Jean-Ralphio','Saperstein','Entertainment 720 CEO',1000000,NULL);

Select*
From employee_demographics;

Select*
From employee_salary;

Create table layoffs2
like layoffs;

Insert layoffs2
Select*
From layoffs;

Select*
From layoffs2;


Select*,
row_number() over(partition by company, location, industry, total_laid_off, percentage_laid_off, `date`, stage, country, funds_raised_millions order by company) as row_num
From layoffs2;

With CTE_Example as
(
Select*,
row_number() over(partition by company, location, industry, total_laid_off, percentage_laid_off, `date`, stage, country, funds_raised_millions order by company) as row_num
From layoffs2
)
Select*
From CTE_Example
Where row_num > 1;


CREATE TABLE `layoffs3` (
  `company` text,
  `location` text,
  `industry` text,
  `total_laid_off` int DEFAULT NULL,
  `percentage_laid_off` text,
  `date` text,
  `stage` text,
  `country` text,
  `funds_raised_millions` int DEFAULT NULL,
  `row_num` INT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;



Insert layoffs3
Select*,
row_number() over(partition by company, location, industry, total_laid_off, percentage_laid_off, `date`, stage, country, funds_raised_millions order by company) as row_num
From layoffs2;

Select* 
FROM layoffs3;

Select* 
FROM layoffs3
Where row_num>1;

delete
FROM layoffs3
Where row_num>1;

Select `date`,
str_to_date(`date`,'%m/%d/%Y')
From layoffs3
;

Update layoffs3
Set `date` = str_to_date(`date`,'%m/%d/%Y')
;

Select* 
FROM layoffs3;

Alter table layoffs3
Modify Column `date` date;

Update layoffs3
Set industry = Null
Where industry = '';

Select distinct industry
FROM layoffs3
order by 1;

Select dem.company, dem.industry, sal.company, sal.industry
 From layoffs3 dem
   Inner Join layoffs3 sal
      On dem.company = sal.company
       Where (dem.industry = '' or dem.industry IS NULL) 
         and sal.industry IS NOT NULL;

Update layoffs3 dem
  Inner Join layoffs3 sal
      On dem.company = sal.company
       Set dem.industry = sal.industry
       Where (dem.industry = '' or dem.industry IS NULL) 
         and sal.industry IS NOT NULL;




































































































































































































































































































































