# Table: Employee
+-------------+------+
| Column Name | Type |
+-------------+------+
| id          | int  |
| salary      | int  |
+-------------+------+
# id is the primary key (column with unique values) for this table.
# Each row of this table contains information about the salary of an employee.
 
# Write a solution to find the second highest distinct salary from the Employee table. If there is no second highest salary, return null (return None in Pandas).

WITH RankedSalary AS (
    SELECT
        *,
        DENSE_RANK() OVER (ORDER BY salary DESC) AS ranked
    FROM Employee
)
SELECT 
    (SELECT salary 
     FROM RankedSalary 
     WHERE ranked = 2 
     LIMIT 1) AS SecondHighestSalary;
