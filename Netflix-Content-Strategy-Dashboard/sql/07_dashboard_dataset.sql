/*
====================================================
KPI 01
Business Question:
How many titles are available on Netflix?
====================================================
*/

SELECT
    COUNT(*) AS total_titles
FROM netflix_titles;

/*
====================================================
KPI 02
Business Question:
How is Netflix's catalog distributed by content type?
====================================================
*/

SELECT
    type,
    COUNT(*) AS total_titles
FROM netflix_titles
GROUP BY type;

/*
====================================================
KPI 03
Business Question:
Which countries contribute the most content?
====================================================
*/

SELECT
    country,
    COUNT(*) AS total_titles
FROM netflix_titles
WHERE country IS NOT NULL
GROUP BY country
ORDER BY total_titles DESC
LIMIT 10;

/*
====================================================
KPI 04
Business Question:
Which audience ratings are most common?
====================================================
*/

SELECT
    rating,
    COUNT(*) AS total_titles
FROM netflix_titles
WHERE rating IS NOT NULL
GROUP BY rating
ORDER BY total_titles DESC;

/*
====================================================
KPI 05
Business Question:
How has Netflix's content library grown over time?
====================================================
*/

SELECT
    release_year,
    COUNT(*) AS total_titles
FROM netflix_titles
GROUP BY release_year
ORDER BY release_year;

/*
====================================================
KPI 06
Business Question:
Which genres are most common on Netflix?
====================================================
*/

SELECT
    listed_in,
    COUNT(*) AS total_titles
FROM netflix_titles
GROUP BY listed_in
ORDER BY total_titles DESC
LIMIT 10;

/*
====================================================
KPI 07
Business Question:
Which directors have the highest number of titles?
====================================================
*/

SELECT
    director,
    COUNT(*) AS total_titles
FROM netflix_titles
WHERE director IS NOT NULL
GROUP BY director
ORDER BY total_titles DESC
LIMIT 10;