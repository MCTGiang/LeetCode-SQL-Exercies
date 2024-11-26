# Table: Visits
+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| visit_id    | int     |
| customer_id | int     |
+-------------+---------+
# visit_id is the column with unique values for this table.
# This table contains information about the customers who visited the mall.
 
# Table: Transactions
+----------------+---------+
| Column Name    | Type    |
+----------------+---------+
| transaction_id | int     |
| visit_id       | int     |
| amount         | int     |
+----------------+---------+
# transaction_id is column with unique values for this table.
# This table contains information about the transactions made during the visit_id.
 
# Q: Write a solution to find the IDs of the users who visited without making any transactions and the number of times they made these types of visits.
# Return the result table sorted in any order.

# A:
SELECT V.customer_id, COUNT(V.visit_id) AS visit_times
FROM Visits V
LEFT JOIN Transactions T ON V.visit_id = T.visit_id
WHERE T.transaction_id IS NULL
GROUP BY V.customer_id;
