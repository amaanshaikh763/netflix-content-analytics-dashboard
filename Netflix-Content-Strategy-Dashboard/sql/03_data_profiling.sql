Description:
/*
====================================================
Project: Netflix Content Strategy & Business Intelligence Dashboard
Author : Amaan Shaikh
Database: PostgreSQL
This script performs initial data profiling to
understand data quality before analysis.
====================================================
*/

Business Question 1
-- How many titles are in the dataset?
-- Total Records

SELECT COUNT(*) AS total_titles
FROM netflix_titles;

"total_titles"
8807

-- Why?

-- Before analyzing data, confirm the dataset size.

Business Question 2

-- Movies vs TV Shows

SELECT
    type,
    COUNT(*) AS total_titles
FROM netflix_titles
GROUP BY type;


Business Question 3

-- Missing Directors

SELECT COUNT(*) AS missing_directors
FROM netflix_titles
WHERE director IS NULL
   OR TRIM(director) = '';

   Business Question 4

   -- Missing Countries

SELECT COUNT(*) AS missing_countries
FROM netflix_titles
WHERE country IS NULL
   OR TRIM(country) = '';

   Business Question 5

   -- Missing Ratings

SELECT COUNT(*) AS missing_ratings
FROM netflix_titles
WHERE rating IS NULL
   OR TRIM(rating) = '';

   Business Question 6

   -- Missing Duration

SELECT COUNT(*) AS missing_duration
FROM netflix_titles
WHERE duration IS NULL
   OR TRIM(duration) = '';