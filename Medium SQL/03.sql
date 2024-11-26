# Table: Transactions
+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| id            | int     |
| country       | varchar |
| state         | enum    |
| amount        | int     |
| trans_date    | date    |
+---------------+---------+
# id is the primary key of this table.
# The table has information about incoming transactions.
# The state column is an enum of type ["approved", "declined"]. 

# Q: Write an SQL query to find for each month and country, the number of transactions and their total amount, the number of approved transactions and their total amount.
# Return the result table in any order.

# A:
SELECT
    DATE_FORMAT(trans_date, '%Y-%m') AS month,  -- Format as 'YYYY-MM'
    country,
    COUNT(id) AS trans_count,
    SUM(CASE WHEN state = 'approved' THEN 1 ELSE 0 END) AS approved_count,  -- Sum approved count
    SUM(amount) AS trans_total_amount,
    SUM(CASE WHEN state = 'approved' THEN amount ELSE 0 END) AS approved_total_amount  -- Sum approved amounts
FROM Transactions
GROUP BY DATE_FORMAT(trans_date, '%Y-%m'), country;
