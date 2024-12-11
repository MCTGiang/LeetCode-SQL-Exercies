---Table: RequestAccepted
+----------------+---------+
| Column Name    | Type    |
+----------------+---------+
| requester_id   | int     |
| accepter_id    | int     |
| accept_date    | date    |
+----------------+---------+
---(requester_id, accepter_id) is the primary key (combination of columns with unique values) for this table.
---This table contains the ID of the user who sent the request, the ID of the user who received the request, and the date when the request was accepted.

---Write a solution to find the people who have the most friends and the most friends number.
---The test cases are generated so that only one person has the most friends.

---Combines friend relationships
WITH CombinedFriends AS (
    SELECT 
        requester_id AS id,
        accepter_id AS friend
    FROM RequestAccepted
    UNION
    SELECT 
        accepter_id AS id,
        requester_id AS friend
    FROM RequestAccepted
),
---Compute the total number of friends
FriendsCount AS (
    SELECT id, COUNT(DISTINCT friend) AS total_friends
    FROM CombinedFriends
    GROUP BY id
),
---Maximum number of friends any user has
MaxFriends AS (
    SELECT MAX(total_friends) AS max_friends
    FROM FriendsCount
)
---find the user(s) with the maximum number of friends
SELECT
    f.id,
    f.total_friends AS num
FROM
    FriendsCount f
JOIN
    MaxFriends m
ON
    f.total_friends = m.max_friends;
