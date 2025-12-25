# [Day 24] 도시별 VIP 고객 찾기

[문제 링크](https://solvesql.com/problems/vip-of-cities/)

### 제출 일자

2025년 12월 25일 23:40

### 문제 설명

Store Sales in Winter 데이터베이스는 어떤 쇼핑몰 프랜차이즈의 2018년부터 2023년까지의 11월, 12월 상품 판매 기록을 담은 데이터베이스 입니다.

최근 줄어든 오프라인 상점의 매출을 늘려보고자 고객의 도시 별로 VIP를 추려 오프라인 한정 특별 프로모션을 하려고 합니다. 이를 위해 고객별 순매출을 집계한 뒤, 각 도시별 최고 순매출 고객을 추출하는 쿼리를 작성해주세요. 최고 순매출 고객은 아래와 같은 기준으로 결정됩니다.

고객별 순매출은 주문 금액에서 할인 금액을 제외한 금액을 의미
반품 주문은 집계에서 제외
쿼리 결과에는 아래 컬럼이 있어야 합니다.

- city_id: 도시 ID
- customer_id: 최고 매출 고객의 ID
- total_spent: 해당 고객의 순매출


---

### 정답

```sql
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

```

### 느낀점
- WHERE절 서브쿼리를 사용하여 풀긴 했는데,, 만약 최대값에 중복이 있어도 괜찮은 건지 모르겠다.
