# [Day 04] 12월 우수 고객 찾기

[문제 링크](solvesql.com/problems/whales-of-december/) 

### 제출 일자

2025년 12월 4일 15:00

### 문제 설명
US E-Commerce Records 2020 데이터베이스에는 2020년 1년 동안 미국의 한 커머스 업체의 주문 정보가 저장되어 있습니다.

12월 판매 실적을 개선하기 위해 지난 12월에 매출이 높았던 고객들에게 프로모션을 제공하려고 합니다. 
  2020년 12월 동안 있었던 모든 주문의 매출 합계가 1000$ 이상인 고객 ID를 출력하는 쿼리를 작성해주세요. 쿼리 결과에는 고객 ID가 들어있는 컬럼 하나만 있어야 합니다.


---
### 정답

```sql
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
```
