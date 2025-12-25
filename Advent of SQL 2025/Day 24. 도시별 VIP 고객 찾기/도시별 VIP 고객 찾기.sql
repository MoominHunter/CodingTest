-- city_id별로 VIP 고객을 추려 (구매금액이 많은)
-- 고객별 순매출을 집계 (할인 금액, 반품 주문 제외)
-- 각 도시별 최고 순매출 고객을 추출하는 쿼리 작성
WITH one AS (
  SELECT
    city_id
    , customer_id
    , SUM(total_price - discount_amount) AS 'spent'
  FROM transactions
  WHERE is_returned IS FALSE
  GROUP BY city_id, customer_id
  ORDER BY city_id
)
SELECT 
  city_id
  , customer_id
  , spent AS 'total_spent'
FROM one
WHERE spent IN (
              SELECT MAX(spent)
              FROM one
              GROUP BY city_id
)
;
