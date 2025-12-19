WITH undirected AS (
  SELECT user_a_id AS user_id, user_b_id AS friend_id
  FROM edges
  UNION ALL
  SELECT user_b_id AS user_id, user_a_id AS friend_id
  FROM edges
),
friends_num AS (
  SELECT
    user_id,
    COUNT(*) AS friends
  FROM undirected
  GROUP BY user_id
),
friends_of_friends AS (
  SELECT
    u.user_id,
    SUM(fn2.friends) AS friends_of_friends
  FROM undirected u
  JOIN friends_num fn2
    ON fn2.user_id = u.friend_id
  GROUP BY u.user_id
)
SELECT
  fn.user_id,
  fn.friends,
  fof.friends_of_friends,
  ROUND(fof.friends_of_friends / fn.friends, 2) AS ratio
FROM friends_num fn
JOIN friends_of_friends fof
  ON fof.user_id = fn.user_id
WHERE fn.friends >= 100
ORDER BY ratio DESC, fn.user_id ASC
LIMIT 5;
