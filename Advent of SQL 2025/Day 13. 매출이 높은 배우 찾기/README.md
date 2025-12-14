# [Day 13] 매출이 높은 배우 찾기

[문제 링크](https://solvesql.com/problems/top-revenue-actors/)

### 제출 일자

2025년 12월 14일 23:50

### 문제 설명
DVD Rental Store 데이터베이스에는 어느 한 DVD 대여 프랜차이즈의 고객 정보, DVD 대여 정보, 제공 중인 영화의 정보 등이 들어있습니다.

대여 매출이 높았던 상위 5명의 배우를 추리고 특별 코너를 만들어 프로모션에 활용하려고 합니다. 데이터베이스를 조회해 배우별 대여 매출 합계를 계산하고, 그 중 상위 5명의 정보를 출력하는 쿼리를 작성해주세요. 배우별 대여 매출 합계는 배우가 출연한 작품들의 매출 합계입니다.

쿼리 결과에는 아래 컬럼이 있어야 하며, 매출액 기준 내림차순으로 정렬되어 있어야 합니다.

first_name: 배우의 이름
last_name: 배우의 성
total_revenue: 배우 출연작들의 총 매출


---

### 정답

```sql
-- 배우별 대여 매출 합계를 계산, 상위 5명의 정보만 출력하는 쿼리를 작성

-- film_actor: film_id, actor_id
-- actor:actor_id, first_name, last_name
-- payment: payment_id, rental_id, amount
-- rental: rental_id, inventory_id
-- inventory: inventory_id, film_id

WITH bill AS (
  SELECT i.film_id, p.amount
  FROM rental r
  JOIN payment p ON r.rental_id = p.rental_id
  JOIN inventory i ON r.inventory_id = i.inventory_id
)
, actor_info AS (
  SELECT f.film_id, a.actor_id, first_name, last_name
  FROM actor a
  JOIN film_actor f ON a.actor_id = f.actor_id
)

SELECT a.first_name, a.last_name, SUM(amount) AS 'total_revenue'
FROM bill b
  JOIN actor_info a ON b.film_id = a.film_id
GROUP BY a.actor_id
ORDER BY SUM(amount) DESC
LIMIT 5;
```

### 새로 배운 것
- 매출이 높은 상위 5명 뽑기
  - 매출액 기준 내림차순 정렬 후, LIMIT 5;

