SELECT job_posted_date
FROM job_postings_fact
LIMIT 10;

SELECT
'123'::INTEGER,
'true'::BOOLEAN,
'3.14'::REAL;

SELECT
job_title_short AS title,
job_location AS location,
job_posted_date::DATE AS date
FROM job_postings_fact
LIMIT 10;

SELECT *
FROM job_postings_fact
LIMIT 10;

SELECT
job_title_short AS title,
job_location AS location,
job_posted_date::time AT TIME ZONE 'UTC' AS date_time
FROM job_postings_fact
LIMIT 10;

SELECT 
EXTRACT(MONTH FROM job_posted_date) AS months,
EXTRACT(MINUTE FROM job_posted_date) AS minute
FROM job_postings_fact
LIMIT 5;

SELECT
COUNT(job_id) AS job_count,
EXTRACT(MONTH FROM job_posted_date) AS months
FROM job_postings_fact
WHERE job_title_short = 'Data Analyst'
GROUP BY months
ORDER BY job_count DESC;

SELECT job_schedule_type, 
AVG(salary_year_avg) AS avg_sal,
AVG(salary_hour_avg) AS avg_hour
FROM job_postings_fact
WHERE job_posted_date > '2023-06-01'
GROUP BY job_schedule_type;

SELECT 
COUNT(job_id) AS job_count,
EXTRACT(
    MONTH FROM 
        job_posted_date AT TIME ZONE 'UTC' 
        AT TIME ZONE 'America/New_York'
        
    ) AS months
FROM job_postings_fact
WHERE EXTRACT(
    YEAR FROM 
        job_posted_date AT TIME ZONE 'UTC' 
        AT TIME ZONE 'America/New_York'
        
    ) = 2023
GROUP BY months
ORDER BY months;

SELECT
DISTINCT c.name AS company_name
FROM job_postings_fact j
INNER JOIN company_dim c
ON j.company_id = c.company_id
WHERE job_health_insurance = 'true'
AND EXTRACT(YEAR FROM job_posted_date) = 2023
AND EXTRACT(QUARTER FROM job_posted_date) = 2;

--January
CREATE TABLE january_jobs AS
    SELECT * 
    FROM job_postings_fact
    WHERE EXTRACT(MONTH FROM job_posted_date) = 1;

--Feb
CREATE TABLE february_jobs AS
    SELECT * 
    FROM job_postings_fact
    WHERE EXTRACT(MONTH FROM job_posted_date) = 2;

--March
CREATE TABLE march_jobs AS
    SELECT * 
    FROM job_postings_fact
    WHERE EXTRACT(MONTH FROM job_posted_date) = 3;

SELECT job_posted_date
FROM march_jobs;