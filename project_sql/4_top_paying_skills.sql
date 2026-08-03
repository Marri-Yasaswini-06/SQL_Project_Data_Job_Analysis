/*
Question: What are the top skills based on salary?
-Look at the average salary associated with each skill for Data Analyst and Business Analyst roles.
-Focuses on roles with specified salaries, regardless of location
-Why? It reveals how different skills impact salary levels for both roles and helps identify the most financially rewarding skills to acquire
or improve.
*/

SELECT 
    skills,
    ROUND(AVG(salary_year_avg),2) AS avg_salary
FROM job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE job_title_short IN ('Data Analyst','Business Analyst') AND 
      salary_year_avg IS NOT NULL AND
      job_location = 'Anywhere' AND
      job_work_from_home = True
GROUP BY skills
ORDER BY avg_salary DESC
LIMIT 25;

/*
Key Insights:
-High demand for big data and machine learning skills:** Top-paying analyst roles are associated with **PySpark, Pandas, NumPy, Databricks, and Scikit-learn**, highlighting the growing value of advanced analytics and large-scale data processing.
-Growing need for software development and deployment proficiency:** Skills such as **Bitbucket, GitLab, Jenkins, Chef, Scala, and Golang** suggest that high-paying analyst roles increasingly value software development, automation, and deployment capabilities.
-Increasing importance of cloud and modern data infrastructure:** The presence of **GCP, Kubernetes, Airflow, Linux, Elasticsearch, and Couchbase** indicates that higher-paying analyst roles are expanding into cloud computing, data engineering, and scalable technology infrastructure.

[
  {
    "skills": "pyspark",
    "avg_salary": "208172.25"
  },
  {
    "skills": "bitbucket",
    "avg_salary": "189154.50"
  },
  {
    "skills": "watson",
    "avg_salary": "160515.00"
  },
  {
    "skills": "couchbase",
    "avg_salary": "160515.00"
  },
  {
    "skills": "datarobot",
    "avg_salary": "155485.50"
  },
  {
    "skills": "gitlab",
    "avg_salary": "154500.00"
  },
  {
    "skills": "swift",
    "avg_salary": "153750.00"
  },
  {
    "skills": "jupyter",
    "avg_salary": "152776.50"
  },
  {
    "skills": "chef",
    "avg_salary": "152500.00"
  },
  {
    "skills": "pandas",
    "avg_salary": "151821.33"
  },
  {
    "skills": "golang",
    "avg_salary": "145000.00"
  },
  {
    "skills": "numpy",
    "avg_salary": "143512.50"
  },
  {
    "skills": "databricks",
    "avg_salary": "139006.00"
  },
  {
    "skills": "atlassian",
    "avg_salary": "131161.80"
  },
  {
    "skills": "elasticsearch",
    "avg_salary": "127500.00"
  },
  {
    "skills": "twilio",
    "avg_salary": "127000.00"
  },
  {
    "skills": "airflow",
    "avg_salary": "126103.00"
  },
  {
    "skills": "scikit-learn",
    "avg_salary": "125781.25"
  },
  {
    "skills": "jenkins",
    "avg_salary": "125436.33"
  },
  {
    "skills": "scala",
    "avg_salary": "124903.00"
  },
  {
    "skills": "crystal",
    "avg_salary": "120100.00"
  },
  {
    "skills": "linux",
    "avg_salary": "119338.33"
  },
  {
    "skills": "gcp",
    "avg_salary": "119166.67"
  },
  {
    "skills": "kubernetes",
    "avg_salary": "116666.67"
  },
  {
    "skills": "db2",
    "avg_salary": "114157.70"
  }
]
*/