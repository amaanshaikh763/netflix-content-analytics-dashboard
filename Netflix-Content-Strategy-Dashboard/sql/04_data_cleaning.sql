/*
====================================================
Project: Netflix Content Strategy & Business Intelligence Dashboard
Script : 04_data_cleaning.sql
Author : Amaan Shaikh

Purpose:
Prepare the dataset for analysis by cleaning
and standardizing important fields.
====================================================
*/

/*
====================================================
Business Question:
Are there any duplicate show IDs?
====================================================
*/

SELECT
    show_id,
    COUNT(*) AS duplicate_count
FROM netflix_titles
GROUP BY show_id
HAVING COUNT(*) > 1;

/*
====================================================
Step 1: Add a cleaned date column
Purpose:
Keep the original text column while creating
a proper DATE column for analysis.
====================================================
*/

ALTER TABLE netflix_titles
ADD COLUMN date_added_clean DATE;

