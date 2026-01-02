-- data cleaning 

select * from layoffs

--- 1- remove duplicates 
--- 2- stardarize the data 
--- 3- null values or blank values
--- 4- remove any columns

--- tip: take a copy from a raw data before da any thing 

--- create the same table structure 
SELECT *
INTO layoffs_staging
FROM layoffs
WHERE 1 = 0;

--- confirm table creation 
SELECT *
FROM layoffs_staging;

-- insert the data into the table
INSERT INTO layoffs_staging
SELECT *
FROM layoffs;

-- 1- remove duplicates process 

----1.a- arange the data with row_number function    
select * , 
ROW_NUMBER()over(
			partition by company , location , industry,total_laid_off,
			percentage_laid_off,date,stage,country,funds_raised_millions 
			order by company
                  )as row_num
from layoffs_staging

----1.b- find the duplicates when row_num is greater than 1

with duplicates_cte as
(
select * , 
ROW_NUMBER()over(
			partition by company , location , industry,total_laid_off,
			percentage_laid_off,date,stage,country,funds_raised_millions 
			order by (select null)
                  )as row_num
from layoffs_staging
)
select * from duplicates_cte 
where row_num >1

--- check any record 
select * from layoffs_staging
where company = 'Casper'

----1.c- Remove this duplicates 

with duplicates_cte as
(
select * , 
ROW_NUMBER()over(
			partition by company , location , industry,total_laid_off,
			percentage_laid_off,date,stage,country,funds_raised_millions 
			order by (select null)
                  )as row_num
from layoffs_staging
)
DELETE 
from duplicates_cte 
where row_num >1


--- 2- stardarizing the data

---2.a- remove extra space

--- find the problem
select  company , trim(company)
from layoffs_staging

-- update it 
UPDATE layoffs_staging
SET company = TRIM(company)

---2.b- similar values
 
--- find the problem
--1
select distinct industry
from layoffs_staging
order by 1

select *
from layoffs_staging
where industry like 'Crypto%'

--------------------------
--2
select distinct country
from layoffs_staging
order by 1

select *
from layoffs_staging
where country like 'United States%'


---- update it 
--1
UPDATE layoffs_staging
SET industry = 'Crypto'
where  industry like 'crypto%'

--2
UPDATE layoffs_staging
SET country = 'United States'
where  country like 'United States%'


--- 3- null values or blank values
----- identify the problem and the records  
select *
from layoffs_staging
where industry is null
or industry ='null'
------------- compare between the same table to see if the company which have null have another record with value 
select * 
from layoffs_staging t1
join layoffs_staging t2
on t1.company =t2.company
where (t1.industry is null or t1.industry ='null')
and t2.industry is not null

----- update ( It takes the industry value from another row of the same company.
---This happens only if the other row has a valid (non-NULL, non-blank) industry value)

UPDATE t1
SET t1.industry = t2.industry
FROM layoffs_staging t1
JOIN layoffs_staging t2
    ON t1.company = t2.company
WHERE (t1.industry IS NULL OR LTRIM(RTRIM(t1.industry)) = '')
  AND t2.industry IS NOT NULL;

---- convert the blank into null value 
update layoffs_staging
set industry = null
where industry = 'null'

------- 4- remove (total_laid_off and percentage_laid_off) when both are null ##its not 100% right

--- the null records 
select *  from layoffs_staging
where total_laid_off is null
and percentage_laid_off is null

---remove them 

delete 
from layoffs_staging
where total_laid_off is null
and percentage_laid_off is null

--- the cleaned data 

select * from layoffs_staging