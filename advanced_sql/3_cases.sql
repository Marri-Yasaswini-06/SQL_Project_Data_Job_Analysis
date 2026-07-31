SELECT job_title_short,
job_location,
CASE
    WHEN job_location = 'Anywhere' THEN 'Remote'
    WHEN job_location = 'New York, NY' THEN 'Local'
    ELSE 'Onsite'
END AS location_category
FROM job_postings_fact;

--only to see the count for each category and specifically for Data Analyst roles
SELECT
COUNT(job_id) AS job_count,
CASE
    WHEN job_location = 'Anywhere' THEN 'Remote'
    WHEN job_location = 'New York, NY' THEN 'Local'
    ELSE 'Onsite'
END AS location_category
FROM job_postings_fact
WHERE job_title_short = 'Data Analyst'
GROUP BY location_category;

SELECT MAX(salary_year_avg), MIN(salary_year_avg)
FROM job_postings_fact;

--give a salary bucket from hig, low, standard, and only for data analyst roles
SELECT salary_year_avg,
CASE 
   WHEN salary_year_avg > 250000 THEN 'HIGH'
   WHEN salary_year_avg < 50000 THEN 'LOW'
   WHEN salary_year_avg IS NULL THEN 'No salary'
   ELSE 'STANDARD'
END AS salary_category
FROM job_postings_fact
WHERE job_title_short = 'Data Analyst'
ORDER BY salary_year_avg DESC;

SELECT 
    salary_year_avg,
    salary_category
FROM (
    SELECT 
        salary_year_avg,
        CASE 
            WHEN salary_year_avg > 250000 THEN 'HIGH'
            WHEN salary_year_avg < 50000 THEN 'LOW'
            WHEN salary_year_avg IS NULL THEN 'NO SALARY'
            ELSE 'STANDARD'
        END AS salary_category
    FROM job_postings_fact
    WHERE job_title_short = 'Data Analyst'
) AS salary_buckets
ORDER BY 
    CASE salary_category
        WHEN 'HIGH' THEN 1
        WHEN 'STANDARD' THEN 2
        WHEN 'LOW' THEN 3
        WHEN 'NO SALARY' THEN 4
    END;