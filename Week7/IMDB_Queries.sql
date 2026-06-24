/* SELECT *
from directors;

Select *
from genres;
 
Select *
from movies;
*/

-- Above are test queries making sure everything works well
------------------------------------------------------------------------------------------------------------------------


-- Exploratory Query 1: grouping of movie totals by rating

SELECT rating, COUNT(*) AS total_movies
FROM Movies
GROUP BY rating
ORDER BY rating;

-- Exploratory Query 1B: grouping of movie totals by genre
SELECT genres.genre, COUNT(movies.movie_id) AS total_movies
FROM Movies
JOIN genres ON movies.movie_id = genres.m_id
GROUP BY genres.genre
ORDER BY genres.genre;

-- Exxploratory Query 2: Exploratory Query on split of revenue of money by director, useful for choosing directors to guarantee success as much as one can

SELECT
    movies.movie_title,
    movies.revenue, 
    directors.director
FROM movies
JOIN directors on movies.movie_id = directors.mov_id
GROUP BY movies.revenue
ORDER BY movies.revenue DESC;

-- Exploratory Query 3: max dollar amount by movie

SELECT movies.country, movies.movie_title, MAX(movies.revenue)
FROM Movies
GROUP BY country
ORDER BY revenue DESC;

-- Exploratory Query 4: ranking directors by revenue across movies directed

SELECT
    movies.movie_title,
    directors.director,
    movies.country,
    SUM(movies.revenue) AS total_revenue
FROM movies
JOIN directors on movies.movie_id = directors.mov_id
GROUP BY movies.revenue
ORDER BY movies.revenue DESC;

-- Exploratory Query 5: identification of movies with the word "THE" in the title

SELECT *
FROM Movies
WHERE movies.movie_title LIKE '%The%';


------------------------------------------------------------------------------------------------------------------------

-- Business Query 1: seeing how if there's any correlation between votes and revenue or review score and revenue

SELECT 
    movies.rating,
    COUNT(Movies.movie_id) AS Total_Movies,
    SUM(movies.votes) AS Total_Votes,
    ROUND(AVG(Movies.revenue), 2) AS Average_Revenue_Movie, 
    ROUND(AVG(Movies.SCORE), 2) AS Average_Review_Score
FROM Movies
WHERE Movies.rating IS NOT NULL 
  AND Movies.rating != ''
  AND Movies.votes > 100000
GROUP BY Movies.rating
HAVING Total_Movies > 5
ORDER BY Average_Revenue_Movie;

-- Business Query 2: Complex Filtering with multiple conditions to load the more popularly rated movies that have a rating of PG-13 or R

SELECT
    Movies.movie_title,
    Movies.rating, 
    Movies.SCORE, 
    Movies.revenue
FROM movies
WHERE rating = 'PG-13' OR rating = 'R' 
  AND SCORE >= 8.0 
  AND revenue > 500000000
ORDER BY revenue Desc;

-- Business Query 3: answers the question to see which country has the most engagement with movies

SELECT 
    country,
    COUNT(movie_id) AS total_movies_produced,
    SUM(votes) AS total_audience_votes,
    ROUND(AVG(votes), 0) AS average_votes_per_movie,
    ROUND(AVG(SCORE), 2) AS average_country_score
FROM movies
WHERE country IS NOT NULL 
  AND country != ''
GROUP BY country
HAVING total_movies_produced >= 2
ORDER BY average_votes_per_movie DESC;