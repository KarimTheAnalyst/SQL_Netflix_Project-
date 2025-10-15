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
--Insight: 
--Netflix's library is dominated by movies, with more than double the number of films compared to TV shows. 
--This suggests a content strategy focused on providing a vast and diverse catalog of single-viewing experiences,
--potentially to cater to a wide range of user tastes and moods.
-- Q2 What is the overall distribution of content ratings on Netflix?
SELECT
	rating,
	COUNT(show_id) number_of_shows 
FROM netflix
GROUP BY rating 
ORDER BY number_of_shows DESC ;
-- The analysis of content ratings reveals that TV-MA is the most common rating on Netflix, followed by
--TV-14. This indicates a clear strategic focus on adult and young adult audiences, with significantly less
--content tailored for children and families (G, TV-Y). This strategy positions Netflix as a primary destination for mature, 
--evening entertainment rather than a family-centric platform

-- Trend over time : Has Netflix's focus on mature content (e.g., TV-MA) increased or decreased over the last 10 years?
SELECT 
	release_year, 
	COUNT(*) AS total_release,
	SUM(CASE WHEN rating = 'TV-MA' THEN 1 ELSE 0 END) AS mature_releases,
	ROUND((SUM(CASE WHEN rating = 'TV-MA' THEN 1 ELSE 0 END)*100.0/COUNT(*)),2)AS percentage_mature 
FROM netflix
WHERE release_year >= 2012
GROUP BY release_year
ORDER BY release_year DESC;  
--By analyzing rating trends over the past decade, it's clear that the proportion of 
--TV-MA content has steadily increased. While representing only a fraction of releases 
--in the early 2010s, it now constitutes a major percentage of new content added each year. 
--This highlights a deliberate strategic pivot towards capturing and retaining an adult subscriber base
-- Q3 4 Find the top 5 countries with the most content on Netflix
SELECT 
	country,
	COUNT(show_id) AS num_of_shows 
FROM netflix
WHERE country IS NOT NULL
GROUP BY country 
ORDER BY num_of_shows DESC
LIMIT 5 ;
--At first glance, the high content numbers from the US and India suggest a strategy based on population size. However, a deeper look reveals a more nuanced strategy. The United Kingdom and South Korea, for example, produce a disproportionately high number of titles relative to their smaller populations. This indicates that their high ranking is not due to population, but due to their global cultural influence and strong creative industries. Netflix is strategically investing in these countries to produce high-quality content (like British dramas and South Korean K-dramas) that has a proven track record of appealing to audiences worldwide. Therefore, the content strategy is driven more by a country's global export potential than by its population alone
--Q4 Short-Form Content: Identify the 10 shortest movies (by duration), excluding documentaries. 
SELECT title , duration  FROM netflix
WHERE type = 'Movie' 
             AND duration IS NOT NULL 
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
--The data indicates that Netflix's content acquisition peaked in 2018. Following this, there was a noticeable decline, culminating in a dramatic 38% drop in new titles between 2020 and 2021. This slowdown is very likely a direct consequence of the COVID-19 pandemic, which halted film and TV production worldwide throughout 2020, leading to a depleted content pipeline in the following year.