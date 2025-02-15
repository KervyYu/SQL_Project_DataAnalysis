/*
Question:
1. What are the top skills required for these top paying remote data analyst job??
- Find the top 10 mhighest paying data analysis jobs for remote 
- Add the specific skill required  
- most common skills used for remote and non remote for top paying jobs
-Purpose: To be able to know which skill is needed especially for remote analyst jobs and non remote
*/

-- getting the highest salary remote job with skills

WITH top_salary_remote AS (
    SELECT
        j.job_id,
        j.job_title AS job_name,
        c.name AS company,
        j.job_work_from_home AS job_remote,
        j.job_schedule_type,
        j.salary_year_avg AS salary
    FROM
        job_postings_fact AS j
    INNER JOIN company_dim AS c ON j.company_id = c.company_id
    WHERE
        j.job_title_short IN ('Data Analyst') AND 
        j.job_schedule_type = 'Full-time' AND 
        salary_year_avg IS NOT NULL AND
        j.job_work_from_home = TRUE
    ORDER BY
        salary DESC
    LIMIT 10
)

SELECT
    top_salary_remote.*,
    s.skills AS skills
FROM
    top_salary_remote
INNER JOIN skills_job_dim AS sj ON top_salary_remote.job_id = sj.job_id
INNER JOIN skills_dim AS s ON sj.skill_id = s.skill_id
ORDER BY
    salary DESC





--knowing the most common skill used for remote 

WITH top_salary_remote AS (
    SELECT
        j.job_id,
        j.job_title AS job_name,
        j.job_location,
        j.job_work_from_home AS job_remote,
        j.job_schedule_type,
        j.salary_year_avg AS salary
    FROM
        job_postings_fact AS j
    WHERE
        j.job_title_short IN ('Data Analyst') AND 
        j.job_schedule_type = 'Full-time' AND 
        salary_year_avg IS NOT NULL AND
        j.job_work_from_home = TRUE
    ORDER BY
        salary DESC
    LIMIT 30
)

SELECT
    s.skills AS skills,
    COUNT(top_salary_remote.job_id) AS total_skills
FROM
    skills_dim AS s
INNER JOIN skills_job_dim AS sj ON s.skill_id = sj.skill_id
INNER JOIN top_salary_remote ON sj.job_id = top_salary_remote.job_id
GROUP BY
    s.skills
ORDER BY
    total_skills DESC



--knowing the most common skill used for non-remote 
WITH top_salary_remote AS (
    SELECT
        j.job_id,
        j.job_title AS job_name,
        j.job_location,
        j.job_work_from_home AS job_remote,
        j.job_schedule_type,
        j.salary_year_avg AS salary
    FROM
        job_postings_fact AS j
    WHERE
        j.job_title_short IN ('Data Analyst') AND 
        j.job_schedule_type = 'Full-time' AND 
        salary_year_avg IS NOT NULL AND
        j.job_work_from_home = FALSE
    ORDER BY
        salary DESC
    LIMIT 30
)


SELECT
    s.skills AS skills,
    COUNT(top_salary_remote.job_id) AS total_skills
FROM
    skills_dim AS s
INNER JOIN skills_job_dim AS sj ON s.skill_id = sj.skill_id
INNER JOIN top_salary_remote ON sj.job_id = top_salary_remote.job_id
GROUP BY
    s.skills
ORDER BY
    total_skills DESC

