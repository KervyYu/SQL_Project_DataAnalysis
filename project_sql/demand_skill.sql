/*
Question:
3. What skills are in demand for data analyst job??
- most in demand skills used for Data Analyst jobs
-Purpose: To be able to know which skill is in demand for data analyst jobs overall
*/


SELECT 
    s.skills,
    COUNT(j.job_id) AS demand_skill
FROM
    skills_dim AS s 
INNER JOIN skills_job_dim AS sj ON sj.skill_id = s.skill_id
INNER JOIN job_postings_fact AS j ON sj.job_id = j.job_id
WHERE
    j.job_title_short IN ('Data Analyst')
GROUP BY
    s.skills
ORDER BY
    demand_skill DESC
LIMIT 5


