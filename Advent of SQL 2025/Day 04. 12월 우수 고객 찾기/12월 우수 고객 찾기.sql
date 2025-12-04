-- 2020년동안 미국 한 커머스 업체의 주문정보
-- 2020년 12월 동안 있었던 모든 주문의 매출(sales) 합계가 1000불 이상인 고객 ID(customer_id)를 출력

SELECT
  c.customer_id
FROM
  records r
  JOIN customer_stats c
  ON r.customer_id = c.customer_id
WHERE
  order_date LIKE '2020-12%'
GROUP BY
  c.customer_id
HAVING
  SUM(r.sales) >= 1000
;
