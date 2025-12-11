# [Day 11] 레스토랑의 주중, 주말 매출액 비교하기

[문제 링크](https://solvesql.com/problems/revenue-weekday-weekend/) 

### 제출 일자

2025년 12월 12일 00:50

### 문제 설명
Waiter's Tips 데이터베이스는 어떤 레스토랑의 영수증 데이터를 담고 있습니다. 영수증에는 식사 금액, 팁, 결제자의 성별 등 결제 관련 정보가 포함되어 있습니다.

레스토랑의 주인인 당신은 신규 직원 고용과 적절한 재료 수급을 위해 주중, 주말 각각의 매출액 규모를 파악하려고 합니다. 데이터베이스를 조회해 주중, 주말의 합계 매출 규모를 집계하는 쿼리를 작성해주세요. 쿼리 결과에는 아래 컬럼이 있어야 하고, 매출액 합계 기준 내림차순으로 정렬되어 있어야 합니다.

- week: 토/일요일의 경우 'weekend', 다른 요일의 경우 'weekday'
- sales: 매출액 합계

결과 데이터 예시
week	sales
weekend	...
weekday	...

|week	| sales	| 
|-- | -- | 
|weekend	| ...	| 
|weekday	| ...	| 


---

### 정답

```sql
-- 주중, 주말의 합계 매출 규모를 집계하는 쿼리
-- week라는 열 새로 만들기 (day가 평일이면 weekday, 주말이면 weekend)
-- group by week 로 매출 총계 구하기
WITH week_sales AS (
  SELECT 
    IF (day IN ('Sun', 'Sat'), 'weekend', 'weekday') AS 'week'
    , total_bill
  FROM tips
)
SELECT week, SUM(total_bill) AS 'sales'
FROM week_sales
GROUP BY week
ORDER BY SUM(total_bill) DESC
;

```

### 새로 배운 것

- IF문 사용하여 새로운 열 만들기
  - IF (적용할 열 > 조건, TRUE 값, FALSE 값) AS 'sample'
