---Table: Customer
+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| customer_id   | int     |
| name          | varchar |
| visited_on    | date    |
| amount        | int     |
+---------------+---------+
---In SQL,(customer_id, visited_on) is the primary key for this table.
---This table contains data about customer transactions in a restaurant.
---visited_on is the date on which the customer with ID (customer_id) has visited the restaurant.
---amount is the total paid by a customer.
 
---You are the restaurant owner and you want to analyze a possible expansion (there will be at least one customer every day).
---Compute the moving average of how much the customer paid in a seven days window (i.e., current day + 6 days before). average_amount should be rounded to two decimal places.
---Return the result table ordered by visited_on in ascending order.

WITH DailyTotal AS (
    SELECT
        visited_on,
        SUM(amount) AS daily_amount
    FROM Customer
    GROUP BY visited_on
),
SevenDay AS (
    SELECT
        DT1.visited_on,
        (
            SELECT SUM(DT2.daily_amount)
            FROM DailyTotal DT2
            WHERE DT2.visited_on BETWEEN DATE_SUB(DT1.visited_on, INTERVAL 6 DAY) AND DT1.visited_on
        ) AS amount,
        (
            SELECT COUNT(DISTINCT DT2.visited_on)
            FROM DailyTotal DT2
            WHERE DT2.visited_on BETWEEN DATE_SUB(DT1.visited_on, INTERVAL 6 DAY) AND DT1.visited_on
        ) AS day_count
    FROM DailyTotal DT1
)
SELECT
    visited_on,
    amount,
    ROUND(1.0 * amount / 7, 2) AS average_amount
FROM SevenDay
WHERE day_count = 7
ORDER BY visited_on ASC;
