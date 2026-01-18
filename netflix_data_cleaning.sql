/* ================================
   NETFLIX DATA CLEANING PIPELINE
   ================================ */

-- Inspect Raw Data
SELECT *
FROM netflix1$;


-- Create Backup Table (Protect Raw Data)
SELECT *
INTO net_backup
FROM netflix1$;


-- Convert date_added to DATE
UPDATE net_backup
SET date_added = CONVERT(DATE, date_added);

ALTER TABLE net_backup
ALTER COLUMN date_added DATE;


-- Validate Content Type Distribution
SELECT type, COUNT(*) AS total_count
FROM net_backup
GROUP BY type;


-- Detect Missing / Blank Types
SELECT *
FROM net_backup
WHERE type IS NULL OR type = '';


-- Clean Title Whitespace
UPDATE net_backup
SET title = RTRIM(LTRIM(title));


-- Explore Country Field (Multi-Country Detection)
SELECT DISTINCT country
FROM net_backup;

SELECT *
FROM net_backup
WHERE country LIKE '%,%';

--Normalize Director Field
UPDATE net_backup
SET director = NULL
WHERE director = 'not given';




