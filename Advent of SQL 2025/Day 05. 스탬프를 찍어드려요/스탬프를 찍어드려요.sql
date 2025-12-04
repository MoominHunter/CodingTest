SELECT stamp, COUNT(stamp) AS 'count_bill'
FROM (
SELECT
  CASE
    WHEN total_bill >= 25 THEN 2
    WHEN total_bill >= 15 THEN 1
    ELSE 0
  END "stamp"
FROM
  tips
) AS t
GROUP BY stamp
ORDER BY stamp
;
