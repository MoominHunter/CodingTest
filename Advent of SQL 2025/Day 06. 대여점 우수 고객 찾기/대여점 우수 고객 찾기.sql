-- 대여 횟수가 35회 이상인 고객의 ID 추출
SELECT
  r.customer_id
FROM
  rental AS r
  JOIN customer AS c ON r.customer_id = c.customer_id
WHERE
  c.active IS TRUE
GROUP BY
  r.customer_id
HAVING
  COUNT(*) >= 35;
