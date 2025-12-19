# [Day 19] 연도별 순매출 구하기

[문제 링크](https://solvesql.com/problems/yearly-net-sales/)

### 제출 일자

2025년 12월 19일 15:57

### 문제 설명

Store Sales in Winter 데이터베이스는 어떤 쇼핑몰 프랜차이즈의 2018년부터 2023년까지의 11월, 12월 상품 판매 기록을 담은 데이터베이스 입니다.

이 쇼핑몰의 겨울 매출이 몇 년째 부진하여 경영진은 겨울 매출 개선을 위해 데이터 분석 경험이 많은 당신을 고용했습니다. 당신은 기본적인 분석을 하기 위해 연도별 겨울 순매출을 계산해 보고자 합니다. 쇼핑몰이 다양한 시즌 이벤트와 할인을 제공하고 있기에 전체 매출과 반품, 할인 등을 제외한 순매출 값은 차이가 날 수 있기 때문입니다.

데이터베이스를 조회해 연도별 순매출을 조회하는 쿼리를 작성해주세요. 순매출은 반품되지 않은 거래 내역에 대해 주문 금액에서 할인 금액을 제외한 실제 결제 금액의 합을 의미합니다. 쿼리 결과는 아래 컬럼을 포함해야 하고, 연도 기준 오름차순 정렬되어 있어야 합니다.

- year: 연도
- net_sales: 해당 연도의 순매출 합


---

### 정답

```sql
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
```
