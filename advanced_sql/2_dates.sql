/* Using Casting to convert Timestamp column
 to date.
*/

SELECT
    job_title_short AS title,
    job_location AS location,
    job_posted_date::DATE AS date  -- Convert Timestamp to date
FROM
    job_postings_fact
LIMIT 100;


-- using AT TIME ZONE

SELECT
    job_title_short AS title,
    job_location AS location,
    job_posted_date AT TIME ZONE 'UTC' AT TIME ZONE 'EST',
    EXTRACT (MONTH FROM job_posted_date)  AS date_month
    -- EXTRACT (MONTH  FROM job_po)
FROM
    job_postings_fact
GROUP BY
    da
LIMIT 100;

-- Practice Problem

SELECT
    AVG(salary_year_avg) AS yearly_avg,
    AVG(salary_hour_avg) AS hourly_avg
    -- job_posted_date
FROM
    job_postings_fact
WHERE
    job_posted_date > '2023-06-01'
GROUP BY
    job_schedule_type

LIMIT 100;


--  Problem 2 

SELECT
    EXTRACT(MONTH FROM job_posted_date AT TIME ZONE 'UTC' AT TIME ZONE 'EST') AS month,
    COUNT(EXTRACT(MONTH FROM job_posted_date AT TIME ZONE 'UTC' AT TIME ZONE 'EST')) AS job_count
    -- EXTRACT(YEAR FROM job_posted_date) AS year
    

FROM
    job_postings_fact
WHERE
    EXTRACT(YEAR FROM job_posted_date) = 2023
GROUP BY
    month
ORDER BY
    month;


-- Problem 3 

SELECT
    c.name,
    j.job_health_insurance AS health_insurance,
    EXTRACT(MONTH FROM job_posted_date) AS month
FROM
    job_postings_fact j
JOIN company_dim AS c ON c.company_id = j.company_id
WHERE
    job_health_insurance = True And
    EXTRACT(YEAR FROM job_posted_date) = 2023 AND
    EXTRACT(QUARTER FROM job_posted_date) = 2 ;

-- LIMIT 1000;
