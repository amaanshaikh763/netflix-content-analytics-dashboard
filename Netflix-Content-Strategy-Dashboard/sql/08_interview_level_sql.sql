-- Which release years have more content than the average number of titles released per year?

-- =========================================================
-- BUSINESS QUESTION 1
-- Which release years have above-average content releases?
-- BUSINESS VALUE:
-- Helps identify Netflix's strongest content production years.
-- =========================================================

WITH yearly_titles AS (

    SELECT
        release_year,
        COUNT(*) AS total_titles

    FROM netflix_titles

    GROUP BY release_year

)

SELECT
    release_year,
    total_titles

FROM yearly_titles

WHERE total_titles >

(
    SELECT AVG(total_titles)
    FROM yearly_titles
)

ORDER BY total_titles DESC;

-- Netflix experienced its highest volume of content releases in 2018 (1,147 titles), indicating a major expansion phase. Between 2016 and 2020, the platform consistently released content above its long-term average, reflecting aggressive investment in catalog growth during this period.

-- =========================================================
-- BUSINESS QUESTION 2
-- Rank release years based on the number of titles released.
-- BUSINESS VALUE:
-- Identifies Netflix's most productive content release years.
-- =========================================================

SELECT
    release_year,
    COUNT(*) AS total_titles,

    RANK() OVER(
        ORDER BY COUNT(*) DESC
    ) AS release_rank

FROM netflix_titles

GROUP BY release_year

ORDER BY release_rank;

-- =========================================================
-- BUSINESS QUESTION 3
-- Compare RANK(), DENSE_RANK() and ROW_NUMBER()
-- BUSINESS VALUE:
-- Demonstrates different ranking techniques used in reporting
-- and leaderboard generation.
-- =========================================================

SELECT
    release_year,
    COUNT(*) AS total_titles,

    RANK() OVER(
        ORDER BY COUNT(*) DESC
    ) AS rank,

    DENSE_RANK() OVER(
        ORDER BY COUNT(*) DESC
    ) AS dense_rank,

    ROW_NUMBER() OVER(
        ORDER BY COUNT(*) DESC
    ) AS row_number

FROM netflix_titles

GROUP BY release_year

ORDER BY total_titles DESC;

-- =========================================================
-- BUSINESS QUESTION 4
-- Calculate cumulative content growth over release years.
--
-- BUSINESS VALUE:
-- Shows how Netflix's content library has expanded over time
-- and highlights periods of rapid catalog growth.
-- =========================================================

WITH yearly_content AS (

    SELECT
        release_year,
        COUNT(*) AS total_titles

    FROM netflix_titles

    GROUP BY release_year

)

SELECT

    release_year,

    total_titles,

    SUM(total_titles)
    OVER(
        ORDER BY release_year
    ) AS cumulative_titles

FROM yearly_content

ORDER BY release_year;

-- =========================================================
-- BUSINESS QUESTION 5
-- What percentage of Netflix's catalog is Movies vs TV Shows?
--
-- BUSINESS VALUE:
-- Helps understand the overall content mix and supports
-- strategic decisions around content investment.
-- =========================================================

SELECT

    type,

    COUNT(*) AS total_titles,

    ROUND(
        COUNT(*) * 100.0 /
        SUM(COUNT(*)) OVER(),
        2
    ) AS percentage_of_catalog

FROM netflix_titles

GROUP BY type

ORDER BY total_titles DESC;

-- =========================================================
-- BUSINESS QUESTION 6
-- Which directors have produced more titles than the
-- average number of titles per director?
--
-- BUSINESS VALUE:
-- Identifies high-performing directors who have contributed
-- significantly to Netflix's content library.
-- =========================================================

WITH director_counts AS (

    SELECT
        director,
        COUNT(*) AS total_titles

    FROM netflix_titles

    WHERE director IS NOT NULL

    GROUP BY director

)

SELECT
    director,
    total_titles

FROM director_counts

WHERE total_titles >

(
    SELECT AVG(total_titles)
    FROM director_counts
)

ORDER BY total_titles DESC;

-- =========================================================
-- BUSINESS QUESTION 7
-- Rank directors based on the number of Netflix titles.
--
-- BUSINESS VALUE:
-- Identifies the most prolific directors in the Netflix
-- catalog for partnership and content strategy analysis.
-- =========================================================

SELECT
    director,
    COUNT(*) AS total_titles,

    DENSE_RANK() OVER(
        ORDER BY COUNT(*) DESC
    ) AS director_rank

FROM netflix_titles

WHERE director IS NOT NULL

GROUP BY director

ORDER BY director_rank
LIMIT 10;

-- =========================================================
-- BUSINESS QUESTION 8
-- Which countries contribute the most content?
--
-- BUSINESS VALUE:
-- Helps identify key regions contributing to Netflix's
-- global content library.
-- =========================================================

SELECT

    country,

    COUNT(*) AS total_titles,

    DENSE_RANK() OVER(
        ORDER BY COUNT(*) DESC
    ) AS country_rank

FROM netflix_titles

WHERE country IS NOT NULL

GROUP BY country

ORDER BY country_rank
LIMIT 10;

-- =========================================================
-- BUSINESS QUESTION 9
-- Which content ratings are most common?
--
-- BUSINESS VALUE:
-- Helps understand the maturity profile of Netflix's
-- content library.
-- =========================================================

SELECT

    rating,

    COUNT(*) AS total_titles,

    ROUND(
        COUNT(*) * 100.0 /
        SUM(COUNT(*)) OVER(),
        2
    ) AS percentage

FROM netflix_titles

WHERE rating IS NOT NULL

GROUP BY rating

ORDER BY total_titles DESC
LIMIT 5;

-- =========================================================
-- BUSINESS QUESTION 10
-- Which genres dominate Netflix's catalog?
--
-- BUSINESS VALUE:
-- Helps identify audience preferences and content
-- investment opportunities.
-- =========================================================

SELECT

    listed_in,

    COUNT(*) AS total_titles

FROM netflix_titles

GROUP BY listed_in

ORDER BY total_titles DESC
LIMIT 10;

/*
=========================================================

INTERVIEW TOPICS COVERED

✓ Common Table Expressions (CTE)

✓ Window Functions
    - RANK()
    - DENSE_RANK()
    - ROW_NUMBER()

✓ Running Totals

✓ Percentage Calculations

✓ Nested Queries

✓ Aggregations

✓ GROUP BY

✓ HAVING

✓ Business Analytics

=========================================================
*/
