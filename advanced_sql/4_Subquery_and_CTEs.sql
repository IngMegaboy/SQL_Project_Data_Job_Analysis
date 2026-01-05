--  SUBQUERY

SELECT *
FROM  
(SELECT *
FROM
    job_postings_fact 
WHERE
    EXTRACT(MONTH FROM job_posted_date) = 1) AS january_jobs;


-- Common Expresion Tables (CTEs)

WITH january_jobs AS (
    SELECT *
    FROM job_postings_fact
    WHERE EXTRACT(MONTH FROM job_posted_date) = 1
)
SELECT *
FROM january_jobs;


SELECT
    company_id,
    name AS company_name
FROM
    company_dim
WHERE company_id IN (
    SELECT
        company_id
    FROM
        job_postings_fact
    WHERE
        job_no_degree_mention = true
  
);


/*
Find the companies that have the most job openings.
- Get the total number of job postins per company_id
- Return the total numbr of jobs with the company name
*/

WITH company_job_count AS  (
    SELECT
        company_id,
        COUNT(company_id) AS total_jobs
    FROM
        job_postings_fact 
    GROUP BY
        company_id
)

SELECT
    company_dim.name AS company_name,
    company_job_count.total_jobs
FROM
    company_dim
LEFT JOIN company_job_count ON company_job_count.company_id = company_dim.company_id
ORDER BY
    total_jobs DESC



/* Problem 1:
- Identify the top 5 skills that are most frequently mentioned
  in the job posting. Use a subquery ti find the skill IDs with the highest
  counts in the skills_job_dim table and then join this result with the
  skills_dim table to get the skill names

*/

SELECT
    skills,
    COUNT(skills) AS top_five_skills
FROM(
    SELECT
        job_to_skill.skill_id,
        skills.skills
    FROM
        job_postings_fact AS job

    JOIN skills_job_dim AS job_to_skill ON job_to_skill.job_id =  job.job_id
    JOIN skills_dim AS skills ON job_to_skill.skill_id = skills.skill_id
    )
GROUP BY
    skills
ORDER BY
    top_five_skills DESC
LIMIT 5



/*
Problem 2
- Determine the size category('Small','Medium','Large') for each company
  by first identifying the number of job postings they have. Use a subquery
  to calculate the total job postings per company. A company is considered
  'Small' if it has less than 10 jobs, 'Medium' if the number of job postings
  is between 10 and 50, and 'Large' if it has more than 50 job postings.
  Implement a subquery to aggregate job counts per company before classifying
  them based on size

*/

SELECT
    company_name,
    company_job_count,
    CASE 
            WHEN company_job_count < 10 THEN 'Small'
            WHEN company_job_count > 50 THEN 'Large'
            ELSE 'Medium'
        END AS Category

FROM
    (SELECT
        company.name AS company_name,
        COUNT(company.name) AS company_job_count
    FROM
        job_postings_fact AS job
    JOIN company_dim AS company ON company.company_id = job.company_id
    GROUP BY
        company.name
    );


/*
Find the count of the number of remote job postings pero skill
    - Display the top 5 skills by their demand in remote jobs
    - Include skill ID, name, and count of postings requiring the skill

*/


WITH remote_job_skills AS (
    SELECT
        skill_id,
        COUNT(skill_id) AS skill_count
    FROM
        skills_job_dim AS skills_to_job
    INNER JOIN job_postings_fact AS job_postings ON job_postings.job_id = skills_to_job.job_id
    WHERE
        job_work_from_home = True AND
        job_postings.job_title_short = 'Data Analyst'
    GROUP BY
        skill_id
)

SELECT 
    skills.skill_id,
    skills AS skill_name,
    skill_count
FROM
    remote_job_skills
INNER JOIN skills_dim AS skills ON skills.skill_id = remote_job_skills.skill_id
ORDER BY
    skill_count DESC
LIMIT 5

