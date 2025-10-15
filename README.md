# Netflix Content Strategy Analysis: A SQL Deep Dive

## Project Overview

This project performs an in-depth analysis of the Netflix content library using SQL. The primary objective is to answer key business questions to uncover insights into the platform's content strategy, production trends, and audience targeting. By analyzing the dataset, this project aims to demonstrate how SQL can be used as a powerful tool for transforming raw data into actionable business intelligence.

This analysis explores the distribution of content types, the most common content ratings, the top-producing countries, and trends in content addition over time. The goal is to not only practice SQL skills but also to develop a strategic understanding of the business decisions that drive a major streaming platform like Netflix.

---

## Tools and Technologies

*   **Database:** PostgreSQL (via pgAdmin)
*   **Querying Language:** SQL
*   **Dataset:** [Netflix Movies and TV Shows on Kaggle](https://www.kaggle.com/datasets/shivamb/netflix-shows)

---

## The Analysis: Answering Key Business Questions

This section details the business questions posed during the analysis, the SQL queries written to answer them, and the key insights derived from the results.



### 1. Content Format Distribution: Movies vs. TV Shows

*   **Question:** What is the distribution of movies versus TV shows in the Netflix library?
*   **SQL Query:**
    ```sql
    -- Q1. The number of movies versus the number of TV shows 
    SELECT type, 
        COUNT(*) AS total_records FROM netflix
        GROUP BY type;
    ```
*   **Insight:**
    > Netflix's library is dominated by movies, with more than double the number of films compared to TV shows. This suggests a content strategy focused on providing a vast and diverse catalog of single-viewing experiences, potentially to cater to a wide range of user tastes and moods.



### 2. Audience Targeting: Content Rating Distribution

*   **Question:** What is the overall distribution of content ratings on Netflix?
*   **SQL Query:**
    ```sql
    -- Q2 What is the overall distribution of content ratings on Netflix?
    SELECT
        rating,
        COUNT(show_id) number_of_shows 
    FROM netflix
    GROUP BY rating 
    ORDER BY number_of_shows DESC ;
    ```
*   **Insight:**
    > The analysis of content ratings reveals that TV-MA is the most common rating on Netflix, followed by TV-14. This indicates a clear strategic focus on adult and young adult audiences, with significantly less content tailored for children and families (G, TV-Y). This strategy positions Netflix as a primary destination for mature, evening entertainment rather than a family-centric platform.



### 3. Content Strategy Over Time: Trend of Mature Content

*   **Question:** Has Netflix's focus on mature content (e.g., TV-MA) increased or decreased over the last 10 years?
*   **SQL Query:**
    ```sql
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
    ```
*   **Insight:**
    > By analyzing rating trends over the past decade, it's clear that the proportion of TV-MA content has steadily increased. While representing only a fraction of releases in the early 2010s, it now constitutes a major percentage of new content added each year. This highlights a deliberate strategic pivot towards capturing and retaining an adult subscriber base.



### 4. Global Production: Top 5 Content Producing Countries

*   **Question:** Which 5 countries have produced the most content available on Netflix?
*   **SQL Query:**
    ```sql
    -- Q3 4 Find the top 5 countries with the most content on Netflix
    SELECT 
        country,
        COUNT(show_id) AS num_of_shows 
    FROM netflix
    WHERE country IS NOT NULL
    GROUP BY country 
    ORDER BY num_of_shows DESC
    LIMIT 5 ;
    ```
*   **Insight:**
    > At first glance, the high content numbers from the US and India suggest a strategy based on population size. However, a deeper look reveals a more nuanced strategy. The United Kingdom and South Korea, for example, produce a disproportionately high number of titles relative to their smaller populations. This indicates that their high ranking is not due to population, but due to their global cultural influence and strong creative industries. Netflix is strategically investing in these countries to produce high-quality content (like British dramas and South Korean K-dramas) that has a proven track record of appealing to audiences worldwide. Therefore, the content strategy is driven more by a country's global export potential than by its population alone.



### 5. Content Diversity: Analysis of Short-Form Content

*   **Question:** What are the 10 shortest non-documentary movies available on the platform?
*   **SQL Query:**
    ```sql
    --Q4 Short-Form Content: Identify the 10 shortest movies (by duration), excluding documentaries. 
    SELECT title , duration  FROM netflix
    WHERE type = 'Movie' 
                 AND duration IS NOT NULL 
                 AND listed_in NOT LIKE '%Documentaries%'
    GROUP BY title, duration
    ORDER BY 
        CAST(REPLACE(duration, 'min', '') AS INTEGER )  ASC
    LIMIT 10;
    ```
*   **Insight:**
    > An analysis of movie durations reveals that Netflix's library includes a category of "short films" and animated shorts, with runtimes as low as 3 minutes. This represents a strategic inclusion of content that caters to viewers seeking brief, impactful storytelling and allows Netflix to experiment with new storytelling formats.



### 6. Platform Growth: Content Additions from 2017-2021

*   **Question:** How many titles were added to Netflix each year between 2017 and 2021?
*   **SQL Query:**
    ```sql
    --Platform Growth Analysis: Count how many titles were added to Netflix each year between 2017 and 2021 
    SELECT 
        release_year, 
        COUNT(*) AS num_of_shows_added 
    FROM netflix
    WHERE release_year BETWEEN '2017' AND '2021' 
    GROUP BY release_year;
    ```
*   **Insight:**
    > This analysis of platform growth reveals that Netflix's content pipeline was severely impacted by the COVID-19 pandemic. After a stable period of adding over 1,000 titles annually from 2017-2019, the number of new releases dropped sharply in 2021. This reflects the production shutdowns of 2020 and highlights the platform's sensitivity to major real-world events.



---

## Project Structure

For clarity and reproducibility, the repository is organized as follows:

```
netflix-sql-analysis/
│
├── README.md                # This project summary file
├── netflix_titles.csv       # The raw data file from Kaggle
├── create_table.sql         # The SQL script to create the database table
└── analysis_queries.sql     # A single .sql file containing all analysis queries
```

---

## Database Schema

The Netflix dataset is structured with the following table schema:

```sql
-- Create Netflix database 
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
```

---

## Conclusion

This SQL-based analysis of the Netflix dataset reveals a clear and deliberate content strategy. By examining the library's composition, production sources, and content diversity, several key insights emerge:

**Strategic Focus on Adult Audiences:** The analysis shows that Netflix's content is predominantly aimed at mature audiences, with TV-MA being the most common rating. This library is heavily anchored in the United States, which produces nearly three times more content than any other country.

**Global Strategy with Key Production Hubs:** While US-centric, the strategy includes strategic investments in countries like India, the UK, Japan, and South Korea to source culturally influential content for global audiences.

**Content Format Diversity:** Netflix maintains a diverse portfolio ranging from traditional feature films to short-form content, catering to various viewing preferences and engagement patterns.

**Vulnerability to External Events:** The dramatic drop in content additions in 2021 demonstrates how real-world events like the COVID-19 pandemic can significantly impact a digital platform's content pipeline.

This project successfully demonstrates the power of SQL for conducting strategic business analysis and extracting actionable insights from large datasets.

---

## Future Enhancements

Potential improvements for this analysis could include:
*   **Time-Series Analysis:** Using window functions to analyze month-over-month content addition trends
*   **Data Visualization:** Creating interactive dashboards using tools like Tableau or Power BI
*   **Advanced Analytics:** Joining with external datasets (e.g., IMDb ratings) for deeper content performance analysis
*   **Text Analysis:** Implementing natural language processing on content descriptions for genre classification

