# Table: Weather
+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| id            | int     |
| recordDate    | date    |
| temperature   | int     |
+---------------+---------+
# id is the column with unique values for this table.
# There are no different rows with the same recordDate.
# This table contains information about the temperature on a certain day.
 
# Q: Write a solution to find all dates' id with higher temperatures compared to its previous dates (yesterday).
# Return the result table in any order.

# A OPT1: Using SELF JOIN
SELECT W1.id
FROM Weather W1
JOIN Weather W2 ON W1.recordDate = DATE_ADD(W2.recordDate, INTERVAL 1 DAY)
WHERE W1.temperature > W2.temperature;

# A OPT2: Using LAG function as sub-query
SELECT id
FROM (
    SELECT id, temperature, LAG(temperature) OVER (ORDER BY recordDate) AS prev_temperature
    FROM Weather
) sub
WHERE temperature > prev_temperature;
