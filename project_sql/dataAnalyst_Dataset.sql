SELECT
    j.*,
    c.name,
    s.skills
FROM
    job_postings_fact AS j
INNER JOIN skills_job_dim AS sj ON j.job_id = sj.job_id
INNER JOIN skills_dim AS s ON sj.skill_id = s.skill_id
INNER JOIN company_dim AS c ON j.company_id = c.company_id
WHERE
     j.job_title_short IN ('Data Analyst') AND
     j.job_work_from_home = TRUE
