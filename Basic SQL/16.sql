# Table: Users
+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| user_id     | int     |
| user_name   | varchar |
+-------------+---------+
# user_id is the primary key (column with unique values) for this table.
# Each row of this table contains the name and the id of a user.

# Table: Register
+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| contest_id  | int     |
| user_id     | int     |
+-------------+---------+
# (contest_id, user_id) is the primary key (combination of columns with unique values) for this table.
# Each row of this table contains the id of a user and the contest they registered into. 

# Q: Write a solution to find the percentage of the users registered in each contest rounded to two decimals.
# Return the result table ordered by percentage in descending order. In case of a tie, order it by contest_id in ascending order.

# A:
WITH TotalUsers AS (
    SELECT COUNT(*) AS total_users
    FROM Users
)
SELECT 
    R.contest_id,
    ROUND(COUNT(DISTINCT R.user_id) * 100.0 / TU.total_users, 2) AS percentage
FROM Register R
CROSS JOIN TotalUsers TU
GROUP BY R.contest_id, TU.total_users
ORDER BY percentage DESC, R.contest_id ASC;
