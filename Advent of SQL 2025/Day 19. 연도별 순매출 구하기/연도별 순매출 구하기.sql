-- 상품 판매 기록 DB
-- 연도별 겨울 순매출
-- 순매출: 반품x, 주문금액에서 할인금액을 제외한 실제 결제 금액의 합


WITH 
  winter_sale AS(
    SELECT 
      YEAR(purchased_at) AS 'year'
      , total_price
      , discount_amount
      , (total_price - discount_amount) AS 'sales'
    FROM transactions
    WHERE is_returned != 1
  )
SELECT year, SUM(sales) AS 'net_sales'
FROM winter_sale
GROUP BY year
ORDER BY year ASC
;
