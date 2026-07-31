-- SELECT *
-- FROM (
--     SELECT *
--     FROM job_postings_fact
--     WHERE EXTRACT(MONTH FROM job_posted_date) = 1
-- ) AS january_jobs;

-- WITH january_jobs AS(
--     SELECT *
--     FROM job_postings_fact
--     WHERE EXTRACT(MONTH FROM job_posted_date) = 1
-- )
-- SELECT * FROM january_jobs;

SELECT c.company_id,
       c.name,
       j.job_no_degree_mention
FROM job_postings_fact j 
INNER JOIN company_dim c
ON j.company_id = c.company_id
WHERE c.company_id IN(
    SELECT company_id
    FROM job_postings_fact
    WHERE job_no_degree_mention = 'true'
);

SELECT 
    c.company_id,
    c.name,
    j.job_no_degree_mention
FROM job_postings_fact j 
INNER JOIN company_dim c
    ON j.company_id = c.company_id
WHERE j.job_no_degree_mention = 'true'
ORDER BY company_id;

SELECT company_id,
name as company_name
FROM company_dim
WHERE company_id IN(
    SELECT company_id
    FROM job_postings_fact
    WHERE job_no_degree_mention = 'true'
    ORDER BY company_id
);

--find the companies with most job openings, give the total number wrt company_id and names
WITH high_jobs_companies AS(
    SELECT company_id, COUNT(*) AS total_number_of_jobs
    FROM job_postings_fact
    GROUP BY company_id 
)
SELECT company_dim.name, high_jobs_companies.total_number_of_jobs
FROM company_dim LEFT JOIN high_jobs_companies
ON company_dim.company_id = high_jobs_companies.company_id 
ORDER BY total_number_of_jobs DESC;

--with cte
WITH skills_set AS(
    SELECT skill_id,
    COUNT(*) AS skill_count
    FROM skills_job_dim
    GROUP BY skill_id
)
SELECT skills_dim.skills, skills_set.skill_count
FROM skills_dim LEFT JOIN skills_set
ON skills_dim.skill_id = skills_set.skill_id
ORDER BY skill_count DESC
LIMIT 5;

--with subquery
SELECT 
    s.skills,
    skill_counts.skill_count
FROM (
    SELECT 
        skill_id,
        COUNT(*) AS skill_count
    FROM skills_job_dim
    GROUP BY skill_id
) AS skill_counts
INNER JOIN skills_dim s
    ON skill_counts.skill_id = s.skill_id
ORDER BY skill_counts.skill_count DESC
LIMIT 5;

SELECT
    company_id,
    total_jobs,
    CASE
        WHEN total_jobs < 10 THEN 'Small'
        WHEN total_jobs < 50 THEN 'Medium'
        ELSE 'Large'
    END AS company_size
FROM (
    SELECT
        company_id,
        COUNT(*) AS total_jobs
    FROM job_postings_fact
    GROUP BY company_id
) AS job_counts;

SELECT job_id, COUNT(*)
FROM job_postings_fact
WHERE job_work_from_home = 'true'
GROUP BY job_id;


SELECT s.skill_id, s.skills, job_count.remote_jobs
FROM (
    SELECT sjd.skill_id, COUNT(*) AS remote_jobs
    FROM job_postings_fact j
    INNER JOIN skills_job_dim sjd
    ON j.job_id = sjd.job_id
    WHERE j.job_work_from_home = 'true' AND
    j.job_title_short = 'Data Analyst'
    GROUP BY sjd.skill_id
) AS job_count
INNER JOIN skills_dim s ON job_count.skill_id = s.skill_id
ORDER BY job_count.remote_jobs DESC
LIMIT 5;