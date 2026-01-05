
-- --  January
-- CREATE TABLE january_jobs AS
--     SELECT *
--     FROM job_postings_fact
--     WHERE EXTRACT(MONTH FROM job_posted_date) = 1;

-- -- February
-- CREATE TABLE february_jobs AS
--     SELECT *
--     FROM job_postings_fact
--     WHERE EXTRACT(MONTH FROM job_posted_date) = 2;

-- -- March
-- CREATE TABLE march_jobs AS
--     SELECT *
--     FROM job_postings_fact
--     WHERE EXTRACT(MONTH FROM job_posted_date) = 3;


-- select * from february_jobs;


-- SELECT
--     COUNT(job_id) AS number_of_jobs,
--     CASE
--         WHEN job_location = 'Anywhere' THEN 'Remote'
--         WHEN job_location = 'New York, NY' THEN 'Local'
--         ELSE 'Onsite'
--     END AS location_category
-- FROM
--     job_postings_fact 
-- WHERE 
--     job_title_short = 'Data Analyst'
-- GROUP BY
--     location_category

-- ORDER BY
--     number_of_jobs ;


SELECT
    -- job_title_short,
    -- salary_year_avg AS salary_year,
    COUNT(salary_year_avg) AS salary_count,
    CASE
        WHEN salary_year_avg < 100000 THEN 'Low'
        WHEN salary_year_avg > 300000 THEN 'High'
        -- WHEN salary_year_avg BETWEEN 15000 AND 500000 THEN 'Standard'
        ELSE 'Standard'
    END AS salary_category
    
FROM
    job_postings_fact
-- WHERE
    job_title_short = 'Data Analyst' AND 
    salary_year_avg IS NOT NULL
GROUP BY
    salary_category
;



SELECT  
    max(salary_year_avg),
    min(salary_year_avg)

FROM job_postings_fact;

SELECT DISTINCT
    job_location 
FROM job_postings_fact
ORDER BY
    job_location
LIMIT 1000



SELECT 
    job_title_short,
    COUNT(job_id) AS number_of_jobs
FROM job_postings_fact
WHERE job_location ILIKE '%new%' 
-- AND
        -- job_title_short = 'Data Scientist';