/*
Question: What are the most in-demand skills for data and business analysts?
-Join job postings to innner join table similar to query 2
-Identify the top 5 in-demand skills for a data analyst.
-Focus on all job postings
-Why? Retrieves the top 5 skills with the highest demand in the job market, providing insights into the most valuable skills for job seekers.
*/

SELECT 
    skills,
    COUNT(*) AS demand_count
FROM job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE job_title_short IN ('Data Analyst','Business Analyst') AND 
      job_work_from_home = True 
GROUP BY skills
ORDER BY demand_count DESC
LIMIT 5;

/*
Key Insights:

-SQL dominates analyst job demand:** With **8,557 postings**, SQL is the most in-demand skill by a significant margin, highlighting its importance as a core requirement across data and business analyst roles.
-Excel remains highly valuable for analytics:** At **5,594 postings**, Excel ranks second, showing that traditional spreadsheet and business analysis skills continue to be widely sought after.
-The market favors a combination of technical and visualization skills:** **Python (4,876)**, **Tableau (4,473)**, and **Power BI (3,164)** show strong demand, indicating that employers value candidates who can combine **programming, data analysis, and data visualization** capabilities.

[
  {
    "skills": "sql",
    "demand_count": "8557"
  },
  {
    "skills": "excel",
    "demand_count": "5594"
  },
  {
    "skills": "python",
    "demand_count": "4876"
  },
  {
    "skills": "tableau",
    "demand_count": "4473"
  },
  {
    "skills": "power bi",
    "demand_count": "3164"
  }
]
*/