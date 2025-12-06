# [Day 06] 대여점 우수 고객 찾기

[문제 링크](https://solvesql.com/problems/dvdrental-vip/) 

### 제출 일자

2025년 12월 6일 22:10

### 문제 설명

DVD Rental Store 데이터베이스에는 어느 한 DVD 대여 프랜차이즈의 고객 정보, DVD 대여 정보, 제공 중인 영화의 정보 등이 들어있습니다. 최근 다양한 OTT 서비스의 흥행으로 고객이 이탈하고 있어 우수 고객 대상 크리스마스 특별 프로모션을 진행하려고 합니다. 우수 고객은 현재 대여점의 유효 고객 중 대여 횟수가 35회 이상인 고객입니다.

데이터베이스를 조회해 프로모션 대상 우수 고객들의 고객 ID를 조회하는 쿼리를 작성해주세요. 쿼리 결과에는 아래 컬럼이 있어야 합니다.


- customer_id: 프로모션 대상 우수 고객의 ID



---
### 정답

```sql
-- 대여 횟수가 35회 이상인 고객의 ID 추출
SELECT
  r.customer_id
FROM
  rental AS r
  JOIN customer AS c ON r.customer_id = c.customer_id
WHERE
  c.active IS TRUE
GROUP BY
  r.customer_id
HAVING
  COUNT(*) >= 35;

```
