-- 배송이 중단되어 다음 날로 이월될 경우, 다음 날 감당해야 할 최대 물량이 어느 정도인지
-- 2023년 11월, 12월 주문에 대하여, 온라인 주문 건만 해당됨

WITH
  one AS (
    SELECT 
      DATE(purchased_at) AS 'order_date'
      -- , DATE_FORMAT(purchased_at, '%W') AS 'weekday'
      , COUNT(transaction_id) AS 'num_orders_today'
    FROM transactions
    WHERE
      YEAR(purchased_at) = 2023
      AND MONTH(purchased_at) IN (11, 12)
      AND is_online_order = 1
    GROUP BY DATE(purchased_at)
    ORDER BY DATE(purchased_at)
  )
, two AS (
  SELECT
    order_date
    , DATE_FORMAT(order_date, '%W') AS 'weekday'
    , num_orders_today
    , LAG (num_orders_today, 1) OVER (
        ORDER BY order_date) AS 'num_orders_yesterday'
  FROM one
  )
SELECT 
  order_date
  , weekday
  , num_orders_today
  , IF (num_orders_yesterday IS NULL
    , num_orders_today
    , num_orders_today + num_orders_yesterday)
    AS 'num_orders_from_yesterday'
FROM two
;
