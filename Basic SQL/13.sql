# Table: Cinema

+----------------+----------+
| Column Name    | Type     |
+----------------+----------+
| id             | int      |
| movie          | varchar  |
| description    | varchar  |
| rating         | float    |
+----------------+----------+
# id is the primary key (column with unique values) for this table.
# Each row contains information about the name of a movie, its genre, and its rating.
# rating is a 2 decimal places float in the range [0, 10]
 

# Q: Write a solution to report the movies with an odd-numbered ID and a description that is not "boring".
# Return the result table ordered by rating in descending order.

# A:
SELECT 
    id,
    movie,
    description,
    rating 
FROM Cinema
WHERE id % 2 = 1 -- Checks if id is odd (simplified)
  AND description NOT LIKE '%boring%' -- Checks if description does not contain 'boring'
ORDER BY rating DESC;
  
