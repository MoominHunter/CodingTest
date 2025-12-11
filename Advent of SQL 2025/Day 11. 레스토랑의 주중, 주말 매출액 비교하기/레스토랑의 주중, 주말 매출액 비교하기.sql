-- 주중, 주말의 합계 매출 규모를 집계하는 쿼리
-- week라는 열 새로 만들기 (day가 평일이면 weekday, 주말이면 weekend)
-- group by week 로 매출 총계 구하기
WITH week_sales AS (
  SELECT 
    IF (day IN ('Sun', 'Sat'), 'weekend', 'weekday') AS 'week'
    , total_bill
  FROM tips
)
SELECT week, SUM(total_bill) AS 'sales'
FROM week_sales
GROUP BY week
ORDER BY SUM(total_bill) DESC
;
