-- Exploratory Data Analysis

select max(total_laid_off), max(percentage_laid_off) from layoffs_staging2;

select * from layoffs_staging2
where percentage_laid_off = 1
order by funds_raised_millions desc;

select company , sum(total_laid_off) as layoff_total from layoffs_staging2
group by company  order by layoff_total desc;  
-- Amazon did most layoffs

select industry , sum(total_laid_off) as layoff_total from layoffs_staging2
group by industry order by layoff_total desc; 

-- Consumer got hit the most (corona times)

select min(date), max(date) from layoffs_staging2;

select country , sum(total_laid_off) as layoff_total from layoffs_staging2
group by country order by layoff_total desc;

-- US had maximum layoffs , followed by India

select year(date) , sum(total_laid_off) as layoff_total from layoffs_staging2
group by year(date) order by layoff_total desc;

-- Rolling sum

with cte1 as (select year(date) as yr, month(date) as mn, sum(total_laid_off) as sums
from layoffs_staging2
group by year(date), month(date)
order by year(date), month(date))
select yr, mn, sums, sum(sums) over (partition by  yr order by mn) as rolling_sums
from cte1 where yr is not null;
 
 
 -- layoffs of company by year
with cte1 as (select company , year(date) as yr, sum(total_laid_off) as layoff_total from layoffs_staging2
group by yr, company  
having  yr is not null
order by  company, yr),
cte2 as (select company, yr, layoff_total, rank() over (partition by company order by layoff_total desc) as layoff_year_rank from cte1)

select company, yr, layoff_total
FROM cte2
WHERE layoff_year_rank = 1;
