SELECT job_title_short,
company_id, job_location
FROM january_jobs

UNION

SELECT job_title_short,
company_id, job_location
FROM february_jobs

UNION

SELECT job_title_short,
company_id, job_location
FROM march_jobs;

SELECT job_title_short,
company_id, job_location
FROM january_jobs

UNION ALL

SELECT job_title_short,
company_id, job_location
FROM february_jobs

UNION ALL

SELECT job_title_short,
company_id, job_location
FROM march_jobs;

SELECT 
    j.job_title_short,
    s.skills,
    s.type
FROM job_postings_fact j
LEFT JOIN skills_job_dim sjd
    ON j.job_id = sjd.job_id
LEFT JOIN skills_dim s
    ON sjd.skill_id = s.skill_id
WHERE EXTRACT(QUARTER FROM j.job_posted_date) = 1
  AND j.salary_year_avg > 70000;

SELECT sjd.skill_id, s.skills, s.type, j.job_title_short 
FROM skills_dim s 
LEFT JOIN skills_job_dim sjd 
on s.skill_id = sjd.skill_id 
INNER JOIN job_postings_fact j 
ON sjd.job_id = j.job_id 
WHERE EXTRACT(QUARTER FROM j.job_posted_date) = 1 
AND j.salary_year_avg > 70000;


SELECT * 
FROM january_jobs
WHERE EXTRACT(QUARTER FROM january_jobs.job_posted_date) = 1
AND salary_year_avg > 70000

UNION ALL

SELECT * FROM february_jobs
WHERE EXTRACT(QUARTER FROM february_jobs.job_posted_date) = 1
AND salary_year_avg > 70000

UNION ALL

SELECT * FROM march_jobs
WHERE EXTRACT(QUARTER FROM march_jobs.job_posted_date) = 1
AND salary_year_avg > 70000;

-- another method
SELECT job_location,
job_via,
job_posted_date::DATE
FROM(
    SELECT *
    FROM january_jobs
    UNION ALL
    SELECT *
    FROM february_jobs
    UNION ALL
    SELECT *
    FROM march_jobs
) AS quarter_job_postings
WHERE
salary_year_avg > 70000 AND
job_title_short = 'Data Analyst'
ORDER BY salary_year_avg DESC;