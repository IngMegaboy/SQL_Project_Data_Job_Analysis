WITH quarter_1 AS (
SELECT
    job_title_short,
    company_id,
    job_location,
    salary_year_avg
FROM
    january_jobs

UNION 

SELECT
    job_title_short,
    company_id,
    job_location,
    salary_year_avg
FROM
    february_jobs

UNION 

SELECT
    job_title_short,
    company_id,
    job_location,
    salary_year_avg
FROM
    march_jobs
)

SELECT
    quarter_1.job_title_short,
    quarter_1.company_id,
    quarter_1.job_location,
    skills.skills,
    skills.type
FROM
    quarter_1
INNER JOIN skills_job_dim AS job_to_skill ON job_to_skill.job_id = quarter_1.company_id
INNER JOIN skills_dim AS skills ON skills.skill_id = job_to_skill.skill_id
WHERE
    salary_year_avg > 70000

LIMIT 100;



/*
Find job postings from the first quarter that have salary greater than $70K
- Combine job posting tables from the first quarter 0f 2023(Jan-Mar)
- Get job postings with an average yearly salary > $70,000

*/

SELECT 
    quarter1_job_postings.job_title_short,
    quarter1_job_postings.job_location,
    quarter1_job_postings.job_via,
    quarter1_job_postings.job_posted_date::DATE,
    quarter1_job_postings.salary_year_avg
FROM (
    SELECT *
    FROM january_jobs
    UNION ALL
    SELECT *
    FROM february_jobs
    UNION ALL
    SELECT *
    FROM march_jobs
) AS quarter1_job_postings
WHERE
    quarter1_job_postings.salary_year_avg > 70000 AND
    quarter1_job_postings.job_title_short = 'Data Analyst'
ORDER BY
    quarter1_job_postings.salary_year_avg DESC

