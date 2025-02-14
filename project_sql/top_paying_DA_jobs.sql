/*
Question:
1. What are the top paying Data Analyst Jobs?
   a.Top paying for Remote? Non-Remote? 
- Find the top 10 mhighest paying data analysis jobs for both remote and non-remote
- Create (2) queries: 1 for remote jobs only,and 1 for non-remote
- Remove NULL values for salary
-Purpose: To be able to highlight the top-paying opportunities for DA, and to know if working remotely as DA has higher pay than non-remote
*/


-- highest paying Data Analyst job
SELECT
   j.job_id,
   j.job_title AS job_name,
   c.name AS company,
   j.job_location,
   j.job_work_from_home AS job_remote,
   j.job_schedule_type,
   j.salary_year_avg AS salary
FROM
   job_postings_fact AS j
INNER JOIN company_dim AS c ON j.company_id = c.company_id
WHERE
   (j.job_title IN ('Data Analyst') AND j.job_schedule_type = 'Full-time') AND salary_year_avg IS NOT NULL
ORDER BY
   salary DESC
LIMIT 20

-- highest paying Data Analyst job remote 
SELECT
   j.job_id,
   j.job_title AS job_name,
   c.name AS company,
   j.job_location,
   j.job_work_from_home AS job_remote,
   j.job_schedule_type,
   j.salary_year_avg AS salary
FROM
   job_postings_fact AS j
INNER JOIN company_dim AS c ON j.company_id = c.company_id
WHERE
   j.job_title IN ('Data Analyst') AND 
   j.job_schedule_type = 'Full-time' AND 
   salary_year_avg IS NOT NULL AND
   j.job_work_from_home = TRUE
ORDER BY
   salary DESC
LIMIT 20


-- highest paying Data Analyst job non-remote
SELECT
   j.job_id,
   j.job_title AS job_name,
   c.name AS company,
   j.job_location,
   j.job_work_from_home AS job_remote,
   j.job_schedule_type,
   j.salary_year_avg AS salary
FROM
   job_postings_fact AS j
INNER JOIN company_dim AS c ON j.company_id = c.company_id
WHERE
   j.job_title IN ('Data Analyst') AND 
   j.job_schedule_type = 'Full-time' AND 
   salary_year_avg IS NOT NULL AND
   j.job_work_from_home = FALSE
ORDER BY
   salary DESC
LIMIT 20