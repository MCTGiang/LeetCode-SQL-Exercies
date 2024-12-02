--Table: Products
+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| product_id    | int     |
| new_price     | int     |
| change_date   | date    |
+---------------+---------+
--(product_id, change_date) is the primary key (combination of columns with unique values) of this table.
--Each row of this table indicates that the price of some product was changed to a new price at some date.
--Write a solution to find the prices of all products on 2019-08-16. Assume the price of all products before any change is 10.
--Return the result table in any order.

  WITH LatestPrice AS (
    SELECT 
        product_id, 
        new_price, 
        change_date
    FROM Products
    WHERE change_date <= '2019-08-16'
),
RankedPrices AS (
    SELECT 
        product_id, 
        new_price, 
        ROW_NUMBER() OVER (PARTITION BY product_id ORDER BY change_date DESC) AS rnk
    FROM LatestPrice
)
SELECT 
    p.product_id, 
    COALESCE(lp.new_price, 10) AS price
FROM 
    (SELECT DISTINCT product_id FROM Products) p
LEFT JOIN RankedPrices lp
    ON p.product_id = lp.product_id AND lp.rnk = 1;
