--Table: Movies
+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| movie_id      | int     |
| title         | varchar |
+---------------+---------+
--movie_id is the primary key (column with unique values) for this table.
--title is the name of the movie.

--Table: Users
+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| user_id       | int     |
| name          | varchar |
+---------------+---------+
--user_id is the primary key (column with unique values) for this table.
--The column 'name' has unique values.

--Table: MovieRating
+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| movie_id      | int     |
| user_id       | int     |
| rating        | int     |
| created_at    | date    |
+---------------+---------+
--(movie_id, user_id) is the primary key (column with unique values) for this table.
--This table contains the rating of a movie by a user in their review.
--created_at is the user's review date. 
 
--Write a solution to:
--Find the name of the user who has rated the greatest number of movies. In case of a tie, return the lexicographically smaller user name.
--Find the movie name with the highest average rating in February 2020. In case of a tie, return the lexicographically smaller movie name.

WITH top_movie AS (
    SELECT 
        m.title AS results,
        ROUND(AVG(r.rating),2) as aver_rating
    FROM Movies m
    LEFT JOIN MovieRating r ON m.movie_id = r.movie_id
    WHERE r.created_at BETWEEN '2020-02-01' AND '2020-02-29' 
    GROUP BY m.title
    ORDER BY aver_rating DESC, results ASC LIMIT 1
    ),
top_user AS(
    SELECT 
        u.name AS results,
        COUNT(r.rating) as rated_movies
    FROM Users u
    LEFT JOIN MovieRating r ON u.user_id = r.user_id
    GROUP BY u.name
    ORDER BY rated_movies DESC,u.name ASC LIMIT 1
    )
SELECT results FROM top_movie
UNION ALL
SELECT results FROM top_user
