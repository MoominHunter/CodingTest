-- 1. 고객별 첫 주문(order_id) 찾기
-- 2. 그 주문에 포함된 모든 상품 row 가져오기
-- 3. category + sub_category별로
-- COUNT(DISTINCT order_id)
WITH
  two AS (
    SELECT order_id
    FROM (
      SELECT
        *
        , ROW_NUMBER() OVER (
          PARTITION BY customer_id
          ORDER BY order_date, order_id ASC)
          AS rn
      FROM records
    ) AS one
    WHERE rn = 1
  )
SELECT 
  category
  , sub_category
  , COUNT(DISTINCT records.order_id) AS cnt_orders
FROM two
  INNER JOIN records
  ON two.order_id = records.order_id
GROUP BY category, sub_category
ORDER BY COUNT(DISTINCT records.order_id) DESC
;
