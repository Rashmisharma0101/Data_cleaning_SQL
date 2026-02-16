create Database layoffs_data_cleaning;

use layoffs_data_cleaning;

select * from layoffs;

-- remove duplicates
-- standardize the data
-- check nulls
-- remove rows, columns not necessary

-- create  a staging table
create table layoffs_staging like layoffs;
insert layoffs_staging
select * from layoffs;
-- Raw table stays untouched now, we will work on staging table

select * from layoffs_staging;

-- Remove duplicates
-- table has no unique identifier
with duplicate_cte as
 (select * , row_number() over (partition by company, industry, total_laid_off, percentage_laid_off, `date`, country, stage, funds_raised_millions) as row_num
from layoffs_staging)
select * from duplicate_cte where row_num > 1;

CREATE TABLE `layoffs_staging2` (
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
-- put data into this layoffs_staging2

insert into layoffs_staging2
select * , row_number() over (partition by company, industry, total_laid_off, percentage_laid_off, `date`, country, stage, funds_raised_millions) as row_num
from layoffs_staging;


-- select * from duplicate_cte where row_num > 1;

delete 
from layoffs_staging2 where row_num > 1;
-- check if all rows having row_num > 2 got deleted
select * from layoffs_staging2 where row_num = 2; -- verified

-------------------------------------------------------------------

-- Standardize the data
-- Company
select company, trim(company) from layoffs_staging2;

update layoffs_staging2
set company = Trim(company);

-- Industry
update layoffs_staging2
set industry = 'Crypto'
where industry like 'Crypto%';
-- quick check
select distinct industry from layoffs_staging2
order by 1; -- all crypto related are marked as Crypto now

-- location

select distinct location from layoffs_staging2
order by location asc;

-- Country

select distinct country from layoffs_staging2
order by 1 asc;

update layoffs_staging2
set country = TRIM(trailing '.' from country)
where country like 'United States%';

-- check again
select distinct country from layoffs_staging2
order by 1 asc;
------------------------------------------------------------------------
-- Change data type of date column

update layoffs_staging2
set  `date` =  str_to_date(`date`, '%m/%d/%Y');

alter table layoffs_staging2
modify column `date` DATE;

------------------------------------------------------------------------

-- Nulls
-- fill nulls of the column if other rows have correspondig values

select * from layoffs_staging2 t1
join layoffs_staging2 t2
on t1.company = t2.company
and t1.location = t2.location
where (t1.industry is null or t1.industry = '') and
t2.industry is not null;

update layoffs_staging2 t1
join layoffs_staging2 t2
on t1.company = t2.company
and t1.location = t2.location
set t1.industry = t2.industry
where (t1.industry is null or t1.industry = '') and
t2.industry is not null;

select t1.industry, t2.industry from layoffs_staging2 t1
join layoffs_staging2 t2
on t1.company = t2.company
and t1.location = t2.location
where (t1.industry is null or t1.industry = '') and
t2.industry is not null;

-- no rows got updated

-- update blanks to null first
update layoffs_staging2
set industry = Null
where industry = '';

update layoffs_staging2 t1
join layoffs_staging2 t2
on t1.company = t2.company
and t1.location = t2.location
set t1.industry = t2.industry
where t1.industry is null
and t2.industry is not null;

# check again if above code worked to fill nulls
select t1.industry, t2.industry
from layoffs_staging2 t1
join layoffs_staging2 t2
on t1.company = t2.company
and t1.location = t2.location;

select * from layoffs_staging2
where industry is null;
-- as it had no multiple values

-- there are rows where both percentage drop and total_laid offs are null
delete from layoffs_staging2
where total_laid_off is null and percentage_laid_off is null;

-- delete row_num column, we no longer need it

alter table layoffs_staging2
drop row_num;

select * from layoffs_staging2;

-- we have final cleaned data (almost)

---------------------------------------------------------------------------

