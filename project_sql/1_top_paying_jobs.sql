/*
Questions: What are the top paying Data Scientist job?
- Identify the top 10 highest-payih Data Scientist roles that are available remotely,
- Focus on job posting with specified salaries (remove null)
- Why? Highlight the top-paying opportunities for Data Scientist, offering insights into

*/

SELECT
    job_id,
    name AS company_name ,
    job_title,
    job_location,
    job_schedule_type,
    salary_year_avg,
    job_posted_date
FROM
    job_postings_fact
JOIN company_dim ON job_postings_fact.company_id=company_dim.company_id
WHERE
    job_title_short = 'Data Scientist' AND
    job_location = 'Anywhere' AND
    salary_year_avg IS NOT NULL
ORDER BY
    salary_year_avg DESC
LIMIT 10;