# [Day 22] 연속된 이틀간의 누적 주문 계산하기

[문제 링크](https://solvesql.com/problems/cumulative-orders/)

### 제출 일자

2025년 12월 23일 18:20

### 문제 설명

Store Sales in Winter 데이터베이스는 어떤 쇼핑몰 프랜차이즈의 2018년부터 2023년까지의 11월, 12월 상품 판매 기록을 담은 데이터베이스 입니다.

최근 온라인 주문 증가와 기상 악화로 인해 배송 지연이 잦아지고 있습니다. 물류 센터장은 만약 하루 배송이 중단되어 다음 날로 이월될 경우, 물류 센터가 감당해야 할 최대 물량이 어느 정도인지 시뮬레이션하고 싶어합니다.

transactions 테이블을 이용하여 2023년 11월, 12월 주문에 대해 다음 데이터를 추출하는 쿼리를 작성해 주세요.


- order_date: 주문일
- weekday: 요일 (Sunday, Monday, ..., Saturday)
- num_orders_today: 주문일 당일의 주문 건수
- num_orders_from_yesterday: 주문일 하루 이전 날짜부터 주문일 당일까지 연속된 이틀간의 합계 주문 건수의 합


주문 건수 집계에는 배송이 필요한 온라인 주문 건만 포함되어 있어야 하고, 쿼리 결과는 주문일 기준 오름차순 정렬되어 있어야 합니다.

---

### 정답

```sql
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

```

### 새로 배운 것
- DATE_FORMAT(날짜 열, '%W')
  - 날짜 데이터에서 요일을 뽑아올 수 있다.
  - '%w': 번호로 출력
  - '%W': 요일 문자로 출력 `Wednesday`
  - '%a': 약어로 출력 `Wed`
- LAG(), LEAD() 함수 사용법을 복습했다.
- IF문 말고 CASE문도 자유롭게 사용하면 좋을 것 같다.
