/*
Walmart Sales Data Exploration !

Skills used: CTE's, Temp Tabels, Aggregate Functions, Converting Data Types,
			 Conditional Expressions, Windows Functions  

*/





SELECT * FROM wal_info LIMIT(5);





----------------------------
-- total price per branch

SELECT branch, SUM(total) AS total_branch FROM wal_info
GROUP By branch
ORDER BY total_branch








----------------------------
-- avg cog for product line

WITH rolling (product_line, avg_cog, avg_rating)
AS(
	SELECT  product_line,
			ROUND(AVG(cogs),3) AS avg_cog,
			CAST(AVG(rating) AS FLOAT(2)) AS avg_rating 
	FROM wal_info
	GROUP BY product_line
	ORDER BY avg_cog DESC
)
SELECT * FROM rolling









------------------------------
-- total quantitty per time

WITH total_count (quantity, hour_price)
AS(
	SELECT quantity, 
		   EXTRACT(HOUR FROM time) AS hour_price 
	FROM wal_info 
)
SELECT 
	hour_price, 
	SUM(quantity) AS total_count_sold 
FROM total_count
GROUP BY hour_price
ORDER BY total_count_sold DESC









-------------------------------
-- total customer

SELECT 
	customer_type, 
	gender, 
	SUM(cogs) AS cog 
FROM wal_info
GROUP By customer_type, gender
ORDER BY customer_type









---------------------------------
-- tracking cogs.
-- temp table

CREATE TEMP TABLE IF NOT EXISTS CogPerQuality
(
	rating NUMERIC,
	cog NUMERIC,
	quality VARCHAR(10),
	dow VARCHAR(10)
)



INSERT INTO CogPerQuality
SELECT 
	rating, 
	cogs, 
	(
	CASE 
		WHEN rating BETWEEN 4.0 AND 6.0 THEN 'BAD'
		WHEN rating BETWEEN 6.0 AND 8.0 THEN 'NOT BAD'
	ELSE 'GOOD' 
	END ) AS quality,
	TO_CHAR(date, 'Day') AS dow
FROM wal_info






-- cogs for each quality

SELECT 
	dow, 
	quality, 
	ROUND(AVG(cog),2) AS cog 
FROM CogPerQuality
WHERE quality IN ('GOOD', 'NOT BAD')
GROUP BY dow, quality
ORDER BY cog DESC
LIMIT (6)






-- percentage of cog_quality by each cog in each qualtiy,
-- in 3 steps:
-- quality = 'BAD'


WITH CteCog (cog, quality, cog_quality) 
AS(
SELECT 
	cog,
	quality, 
	AVG(cog) OVER (PARTITION BY quality )  AS cog_quality
FROM CogPerQuality
)

SELECT 
	quality,
	cog, 
	ROUND((cog_quality/cog)*100,2) AS prc_of_cog_quality
FROM CteCog
WHERE quality = 'BAD'
ORDER BY prc_of_cog_quality DESC
LIMIT 8 




-- quality = 'NOT BAD'

WITH CteCog (cog, quality, cog_quality) 
AS(
SELECT 
	cog,
	quality, 
	AVG(cog) OVER (PARTITION BY quality )  AS cog_quality
FROM CogPerQuality
)

SELECT 
	quality,
	cog, 
	ROUND((cog_quality/cog)*100,2) AS prc_of_cog_quality
FROM CteCog
WHERE quality = 'NOT BAD'
ORDER BY prc_of_cog_quality DESC
LIMIT 8 




-- quality = 'GOOD'

WITH CteCog (cog, quality, cog_quality) 
AS(
SELECT 
	cog,
	quality, 
	AVG(cog) OVER (PARTITION BY quality )  AS cog_quality
FROM CogPerQuality
)

SELECT 
	quality,
	cog, 
	ROUND((cog_quality/cog)*100,3) AS prc_of_cog_quality
FROM CteCog
WHERE quality = 'GOOD'
ORDER BY prc_of_cog_quality DESC
LIMIT 8 







