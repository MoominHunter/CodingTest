# [Day 05] 스탬프를 찍어드려요

[문제 링크]([https://solvesql.com/problems/movies-about-love/](https://solvesql.com/problems/count-stamps/)) 

### 제출 일자

2025년 12월 5일 00:20

### 문제 설명

Waiter's Tips 데이터베이스에는 어떤 레스토랑의 영수증 데이터가 들어있습니다. 영수증에는 식사 금액, 팁, 결제자의 성별 등 결제 관련 정보가 포함되어 있습니다.

레스토랑의 매니저인 당신은 고객 이벤트로 스탬프 제도를 운영하려고 합니다. 이 스탬프 제도는 영수 금액이 25달러 이상인 경우 스탬프를 2개, 영수 금액이 15달러 이상인 경우 1개, 이외에는 스탬프를 찍어주지 않는 규칙으로 운영될 예정입니다.

본격적으로 이벤트를 시작하기 전에, 과거의 영수증 데이터를 기반으로 스탬프가 얼마나 발급될지 미리 확인 해보려고 합니다. 각 영수증이 받을 스탬프 개수를 계산한 다음, 스탬프 개수 별로 영수증 개수를 집계하는 쿼리를 작성해주세요.

쿼리 결과는 스탬프 개수 기준 오름차순으로 정렬되어 있어야 하고, 아래 두 컬럼을 포함해야합니다.



stamp: 스탬프 개수

count_bill: 영수증 개수



---
### 정답

```sql
SELECT stamp, COUNT(stamp) AS 'count_bill'
FROM (
SELECT
  CASE
    WHEN total_bill >= 25 THEN 2
    WHEN total_bill >= 15 THEN 1
    ELSE 0
  END "stamp"
FROM
  tips
) AS t
GROUP BY stamp
ORDER BY stamp
;

```

### 새로 배운 것

- 서브쿼리 작성 시 테이블 명을 지정해줘야 함.
- IF 또는 CASE를 이용해서 새로운 컬럼을 만들 수 있음.
