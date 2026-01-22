/* ================================
   NETFLIX DATA CLEANING PIPELINE
   ================================ */

USE netflix_1;
GO

/* =========================
   1. RAW DATA INSPECTION
   ========================= */
SELECT *
FROM netflix1$;


/* =========================
   2. BACKUP RAW DATA
   ========================= */

SELECT *
INTO netflix_1
FROM netflix1$;

SELECT *
FROM netflix_1

/* =========================
   3. DATE NORMALIZATION
   ========================= */
UPDATE netflix_1
SET date_added = CONVERT(DATE, date_added);

ALTER TABLE netflix_1
ALTER COLUMN date_added DATE;


/* =========================
   4. CONTENT TYPE VALIDATION
   ========================= */
SELECT type, COUNT(*) AS total_count
FROM netflix_1
GROUP BY type;

-- Detect missing / blank types
SELECT *
FROM netflix_1
WHERE type IS NULL OR type = '';


/* =========================
   5. TEXT CLEANING
   ========================= */

-- Clean title whitespace
UPDATE netflix_1
SET title = LTRIM(RTRIM(title));

-- Normalize director field
UPDATE netflix_1
SET director = NULL
WHERE director = 'not given';


/* =========================
   6. COUNTRY FIELD EXPLORATION
   ========================= */

-- Distinct country values
SELECT DISTINCT country
FROM netflix_1;

-- Detect multi-country entries
SELECT *
FROM netflix_1
WHERE country LIKE '%,%';


/* =========================
   7. DURATION NORMALIZATION
   =========================
   Problem:
   - Movies use minutes (e.g., '90 min')
   - TV Shows use seasons (e.g., '1 Season', '9 Seasons')

   Solution:
   - Split into two numeric columns
   - Handle plural before singular
   ========================= */

-- Add clean numeric columns
ALTER TABLE netflix_1
ADD
    duration_min INT,
    duration_season INT;

-- Populate duration columns
UPDATE netflix_1
SET
    duration_min =
        TRY_CAST(REPLACE(duration, ' min', '') AS INT),

    duration_season =
        TRY_CAST(
            REPLACE(
                REPLACE(duration, ' Seasons', ''),
                ' Season', ''
            ) AS INT
        );


/* =========================
   8. FINAL VALIDATION
   ========================= */
SELECT
    duration,
    duration_min,
    duration_season
FROM netflix_1
ORDER BY duration;


/* =========================
   PIPELINE STATUS
   =========================
   ? Backup created
   ? Dates normalized
   ? Text fields cleaned
   ? Missing values handled
   ? Duration split into analyzable metrics

   Ready for:
   - Runtime analysis (movies)
   - Season depth analysis (TV shows)
   - Category & rating insights
   ========================================================= */


