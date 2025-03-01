/*
5. What are the most optimal skills to learn for both high salary and most used?
- Combine the in-demand skill and skills based on salary to compare
- Identify which skills is the most optimal if you will focus on remote work or if you dont want to work remotely
Purpose: Know which skill you will want to prioritize taking your time learning
*/


-- optimal skills for Data Analyst Position


WITH indemand_skill AS(
    SELECT
        s.skill_id, 
        s.skills,
        COUNT(j.job_id) AS demand_skill
    FROM
        skills_dim AS s 
    INNER JOIN skills_job_dim AS sj ON sj.skill_id = s.skill_id
    INNER JOIN job_postings_fact AS j ON sj.job_id = j.job_id
    WHERE
        j.job_title_short IN ('Data Analyst') 
    GROUP BY
        s.skills, s.skill_id
),

high_salary AS(
    SELECT
        s.skill_id,
        s.skills,
        ROUND(AVG(salary_year_avg), 0) AS salary
    FROM    
        skills_dim AS s
    INNER JOIN skills_job_dim AS sj ON s.skill_id = sj.skill_id
    INNER JOIN job_postings_fact AS j ON sj.job_id = j.job_id
    WHERE
        j.job_title_short IN ('Data Analyst') AND
        j.salary_year_avg IS NOT NULL 
    GROUP BY
        s.skills,s.skill_id

)



SELECT
    indemand_skill.skills AS skills,
    indemand_skill.demand_skill AS demands,
    high_salary.salary AS salary
FROM
    indemand_skill
INNER JOIN high_salary ON indemand_skill.skill_id = high_salary.skill_id
WHERE
    indemand_skill.demand_skill > 10
ORDER BY
     salary DESC


--optimal skills for remote Data Analyst

SELECT
    s.skills AS skills,
    COUNT(sj.job_id) AS demand,
    ROUND(AVG(j.salary_year_avg), 0) AS salary
FROM 
    skills_dim AS s
INNER JOIN skills_job_dim AS sj ON s.skill_id = sj.skill_id
INNER JOIN job_postings_fact AS j ON sj.job_id = j.job_id
WHERE
    j.job_title_short IN ('Data Analyst') AND
    j.salary_year_avg IS NOT NULL AND
    j.job_schedule_type LIKE '%Full-time%' AND
    j.job_work_from_home = TRUE
GROUP BY
    s.skills
HAVING
    COUNT(j.job_id) > 10
ORDER BY
      salary DESC,
      demand DESC
LIMIT 25



--optimal skills for non-remote Data Analyst

SELECT
    s.skills AS skills,
    COUNT(sj.job_id) AS demand,
    ROUND(AVG(j.salary_year_avg), 0) AS salary
FROM 
    skills_dim AS s
INNER JOIN skills_job_dim AS sj ON s.skill_id = sj.skill_id
INNER JOIN job_postings_fact AS j ON sj.job_id = j.job_id
WHERE
    j.job_title_short IN ('Data Analyst') AND
    j.salary_year_avg IS NOT NULL AND
    j.job_schedule_type LIKE '%Full-time%' AND
    j.job_work_from_home = FALSE
GROUP BY
    s.skills
HAVING
    COUNT(j.job_id) > 10
ORDER BY
      salary DESC,
      demand DESC
LIMIT 25