-- Netflix Project
--Create Netflix database 
DROP TABLE IF EXISTS netflix;
CREATE TABLE netflix (
		show_id VARCHAR(6),
		type VARCHAR(10),	
		title VARCHAR(150),	
		director VARCHAR(208),	
		castS	VARCHAR(1000),
		country	VARCHAR(154),
		date_added	VARCHAR(50),
		release_year INT,	
		rating	VARCHAR(10),
		duration VARCHAR(15),	
		listed_in VARCHAR(100),	
		description VARCHAR(250)
);

SELECT * FROM netflix;

SELECT 
      COUNT(*) AS total_records 
FROM netflix;

SELECT 
	DISTINCT type 
FROM netflix;
--Netflix Business Problems & Analytical Questions
--Q1. The number of movies versus the number of TV shows 
SELECT type, 
	COUNT(*) AS total_records FROM netflix
	GROUP BY type;
-- Q2 What is the overall distribution of content ratings on Netflix?
SELECT
	rating,
	COUNT(show_id) number_of_shows 
FROM netflix
GROUP BY rating 
ORDER BY number_of_shows DESC ;

--Trend over time ( last decade) : Has Netflix's focus on mature content (e.g., TV-MA) increased or decreased over the last 10 years?
SELECT 
	release_year, 
	COUNT(*) AS total_release,
	SUM(CASE WHEN rating = 'TV-MA' THEN 1 ELSE 0 END) AS mature_releases,
	ROUND((SUM(CASE WHEN rating = 'TV-MA' THEN 1 ELSE 0 END)*100.0/COUNT(*)),2)AS percentage_mature 
FROM netflix
WHERE release_year >= 2012
GROUP BY release_year
ORDER BY release_year DESC;  

-- Q3  Find the top 5 countries with the most content on Netflix
SELECT 
	country,
	COUNT(show_id) AS num_of_shows 
FROM netflix
WHERE country IS NOT NULL
GROUP BY country 
ORDER BY num_of_shows DESC
LIMIT 5 ;
--Q4 Short-Form Content: Identify the 10 shortest movies (by duration), excluding documentaries. 
SELECT title , duration  FROM netflix
WHERE type = 'Movie' AND 
                     duration IS NOT NULL
					 AND listed_in NOT LIKE '%Documentaries%'
GROUP BY title, duration
ORDER BY 
	CAST(REPLACE(duration, 'min', '') AS INTEGER )  ASC
LIMIT 10;
--Platform Growth Analysis: Count how many titles were added to Netflix each year between 2017 and 2021 
SELECT 
	release_year, 
	COUNT(*) AS num_of_shows_added 
FROM netflix
WHERE release_year BETWEEN '2017' AND '2021' 
GROUP BY release_year;
--Binge-Worthy Series: List all TV shows that are labeled as 'One Season'
SELECT * FROM netflix
	    WHERE type = 'TV show'
	           AND duration = '1 Season'
 --Genre Combination Analysis: How many titles are listed as both 'Comedies' and 'Dramas'
SELECT COUNT(*) FROM netflix
WHERE listed_in LIKE %Comedies%Dramas%;

