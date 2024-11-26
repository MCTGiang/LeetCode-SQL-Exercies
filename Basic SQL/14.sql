# Table: Prices
+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| product_id    | int     |
| start_date    | date    |
| end_date      | date    |
| price         | int     |
+---------------+---------+
# (product_id, start_date, end_date) is the primary key (combination of columns with unique values) for this table.
# Each row of this table indicates the price of the product_id in the period from start_date to end_date.
# For each product_id there will be no two overlapping periods. That means there will be no two intersecting periods for the same product_id.

# Table: UnitsSold
+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| product_id    | int     |
| purchase_date | date    |
| units         | int     |
+---------------+---------+
# This table may contain duplicate rows.
# Each row of this table indicates the date, units, and product_id of each product sold. 
 
# Q: Write a solution to find the average selling price for each product. average_price should be rounded to 2 decimal places. If a product does not have any sold units, its average selling price is assumed to be 0.
# Return the result table in any order.

# A:
SELECT 
    P.product_id,
    ROUND(SUM(P.price * U.units)/ SUM(U.units), 2) AS average_price
FROM Prices P
JOIN UnitsSold U ON P.product_id = U.product_id
AND U.purchase_date BETWEEN P.start_date AND P.end_date
GROUP BY P.product_id;
