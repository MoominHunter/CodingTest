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
