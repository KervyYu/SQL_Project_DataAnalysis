/*
4. What are the top skills based on the average salary for data analyst?
- look for the average salary for each skill associated with Data Analyst positions
-Purpose: To be able to identify how the skills impact the salary levels for Data Analyst positions. 
*/


-- top skills based on salary for non-remote Data analyst
SELECT
    s.skills,
    ROUND(AVG(salary_year_avg), 0) AS salary
FROM    
    skills_dim AS s
INNER JOIN skills_job_dim AS sj ON s.skill_id = sj.skill_id
INNER JOIN job_postings_fact AS j ON sj.job_id = j.job_id
WHERE
    j.job_title_short IN ('Data Analyst') AND
    j.salary_year_avg IS NOT NULL AND
    j.job_work_from_home = FALSE
GROUP BY
    s.skills
ORDER BY 
    salary DESC
LIMIT 20


-- top skills based on salary for remote Data analyst
SELECT
    s.skills,
    ROUND(AVG(salary_year_avg), 0) AS salary
FROM    
    skills_dim AS s
INNER JOIN skills_job_dim AS sj ON s.skill_id = sj.skill_id
INNER JOIN job_postings_fact AS j ON sj.job_id = j.job_id
WHERE
    j.job_title_short IN ('Data Analyst') AND
    j.salary_year_avg IS NOT NULL AND
    j.job_work_from_home = TRUE
GROUP BY
    s.skills
ORDER BY 
    salary DESC
LIMIT 20