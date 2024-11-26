# Table: Employee
+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| id          | int     |
| name        | varchar |
| department  | varchar |
| managerId   | int     |
+-------------+---------+
# id is the primary key (column with unique values) for this table.
# Each row of this table indicates the name of an employee, their department, and the id of their manager.
# If managerId is null, then the employee does not have a manager.
# No employee will be the manager of themself.
 
# Q: Write a solution to find managers with at least five direct reports.
# Return the result table in any order.

# A:
SELECT 
    E1.name
FROM 
    Employee E1
JOIN 
    Employee E2 ON E1.id = E2.managerId
GROUP BY 
    E1.id, E1.name
HAVING 
    COUNT(E2.id) >= 5;

