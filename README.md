# SQL_Netflix_Project-
Netflix Content Strategy Analysis: A SQL Deep Dive
Project Overview

This project performs an in-depth analysis of the Netflix content library using SQL. The primary objective is to answer key business questions to uncover insights into the platform's content strategy, production trends, and audience targeting. By analyzing the dataset, this project aims to demonstrate how SQL can be used as a powerful tool for transforming raw data into actionable business intelligence.

This analysis explores the distribution of content types, the most common content ratings, the top-producing countries, and trends in content addition over time. The goal is to not only practice SQL skills but also to develop a strategic understanding of the business decisions that drive a major streaming platform like Netflix.

Tools and Technologies
Database: PostgreSQL (via pgAdmin)
Querying Language: SQL
Dataset: Netflix Movies and TV Shows on Kaggle

The Analysis: Answering Key Business Questions

This section details the business questions posed during the analysis, the SQL queries written to answer them, and the key insights derived from the results.

1. Content Format Distribution: Movies vs. TV Shows
Question: What is the distribution of movies versus TV shows in the Netflix library?
SQL Query:
Insight:
2. Audience Targeting: Content Rating Distribution
Question: What is the overall distribution of content ratings on Netflix?
SQL Query:
Insight:
3. Content Strategy Over Time: Trend of Mature Content
Question: Has Netflix's focus on mature content (e.g., TV-MA) increased or decreased over the last 10 years?
SQL Query:
Insight:
4. Global Production: Top 5 Content Producing Countries
Question: Which 5 countries have produced the most content available on Netflix?
SQL Query:
Insight:
5. Content Diversity: Analysis of Short-Form Content
Question: What are the 10 shortest non-documentary movies available on the platform?
SQL Query:
Insight:
6. Platform Growth: Content Additions from 2017-2021
Question: How many titles were added to Netflix each year between 2017 and 2021?
SQL Query:
Insight:

Project Structure
For clarity and reproducibility, the repository is organized as follow
Plain Text

netflix-sql-analysis/
│
├── README.md                # This project summary file
├── netflix_titles.csv       # The raw data file from Kaggle
├── create_table.sql         # The SQL script to create the database table
└── analysis_queries.sql     # A single .sql file containing all analysis queries

Database Schema
The Netflix dataset is structured with the following table schema:
SQL
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

Conclusion
This SQL-based analysis of the Netflix dataset reveals a clear and deliberate content strategy. By examining the library's composition, production sources, and content diversity, several key insights emerge:
Strategic Focus on Adult Audiences: The analysis shows that Netflix's content is predominantly aimed at mature audiences, with TV-MA being the most common rating. This library is heavily anchored in the United States, which produces nearly three times more content than any other country.
Global Strategy with Key Production Hubs: While US-centric, the strategy includes strategic investments in countries like India, the UK, Japan, and South Korea to source culturally influential content for global audiences.Content Format Diversity: Netflix maintains a diverse portfolio ranging from traditional feature films to short-form content, catering to various viewing preferences and engagement patterns.
Vulnerability to External Events: The dramatic drop in content additions in 2021 demonstrates how real-world events like the COVID-19 pandemic can significantly impact a digital platform's content pipeline.
This project successfully demonstrates the power of SQL for conducting strategic business analysis and extracting actionable insights from large datasets.

