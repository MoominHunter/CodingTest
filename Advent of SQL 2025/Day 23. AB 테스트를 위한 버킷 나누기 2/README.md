# [Day 23] AB 테스트를 위한 버킷 나누기 2

[문제 링크](https://solvesql.com/problems/ab-testing-buckets-2/)

### 제출 일자

2025년 12월 24일 00:35

### 문제 설명

Store Sales in Winter 데이터베이스는 어떤 쇼핑몰 프랜차이즈의 2018년부터 2023년까지의 11월, 12월 상품 판매 기록을 담은 데이터베이스 입니다.

당신은 A/B 테스트를 위해 사용자 ID가 10으로 나누어 떨어지는 사용자를 A 버킷으로, 나누어 떨어지지 않는 사용자를 B 버킷으로 나눈 후 A 버킷에 할당된 사용자에게만 변경을 주어 지표를 추적하는 실험을 계획하고 있습니다.

커머스 서비스에서 사용자를 기준으로 버킷을 나눌 때는 사전에 버킷이 균등하게 나뉘어져 있는지 확인하는 절차가 필요합니다. 특정 버킷에 큰 손 고객이 몰려 있는 경우 테스트 결과가 왜곡 될 수 있기 때문입니다.

이를 확인하기 위해 버킷별 사용자 수, 평균 주문 수, 평균 주문 금액을 확인하려고 합니다. 아래 데이터를 추출하는 쿼리를 작성해주세요.

- bucket: 사용자 버킷
- user_count: 버킷에 포함된 사용자 수
- avg_orders: 버킷에 포함된 사용자들의 평균 주문 수
- avg_revenue: 버킷에 포함된 사용자들의 평균 주문 금액 ($)


평균 집계에 사용되는 주문에는 최종적으로 반품된 주문은 제외해야 하고, 모든 평균값은 소수점 아래 셋째 자리에서 반올림 해 둘째 자리까지 표현되어야 합니다.
---

### 정답

```sql
WITH user_metrics AS (
    SELECT 
        customer_id,
        CASE WHEN customer_id % 10 = 0 THEN 'A' ELSE 'B' END AS bucket,
        COUNT(DISTINCT transaction_id) AS order_count,
        SUM(total_price) AS total_revenue
  FROM transactions
  WHERE is_returned = FALSE
  GROUP BY customer_id
)
SELECT 
    bucket,
    COUNT(DISTINCT customer_id) AS user_count,
    ROUND(AVG(order_count), 2) AS avg_orders,
    ROUND(AVG(total_revenue), 2) AS avg_revenue
FROM user_metrics
GROUP BY bucket
ORDER BY bucket;

;

```

### 처음 작성한 코드가 틀린 이유
- avg_revenue의 정의를 다르게 잡음
  - 내 코드: 주문 1건당 평균 금액
  - 문제 의도: 사용자 1명 당 평균 주문 금액
- total_price에서 할인 가격을 뺐음
- transaction_iddp DISTINCT 처리를 하지 않았음
