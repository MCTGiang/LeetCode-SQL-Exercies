-- Table: Delivery
+-----------------------------+---------+
| Column Name                 | Type    |
+-----------------------------+---------+
| delivery_id                 | int     |
| customer_id                 | int     |
| order_date                  | date    |
| customer_pref_delivery_date | date    |
+-----------------------------+---------+
-- delivery_id is the column of unique values of this table.
-- The table holds information about food delivery to customers that make orders at some date and specify a preferred delivery date (on the same order date or after it).

--If the customer's preferred delivery date is the same as the order date, then the order is called immediate; otherwise, it is called scheduled.
--The first order of a customer is the order with the earliest order date that the customer made. It is guaranteed that a customer has precisely one first order.

-- Q: Write a solution to find the percentage of immediate orders in the first orders of all customers, rounded to 2 decimal places.
-- A:
SELECT 
    ROUND(
        SUM(CASE WHEN order_date = customer_pref_delivery_date THEN 1 ELSE 0 END) * 100.0 / COUNT(*),
        2
    ) AS immediate_percentage
FROM (
    SELECT 
        customer_id,
        order_date,
        customer_pref_delivery_date
    FROM (
        SELECT 
            customer_id,
            order_date,
            customer_pref_delivery_date,
            ROW_NUMBER() OVER (PARTITION BY customer_id ORDER BY order_date) AS rn
        FROM Delivery
    ) AS RankedOrders
    WHERE rn = 1
) AS FirstOrderDetails;
