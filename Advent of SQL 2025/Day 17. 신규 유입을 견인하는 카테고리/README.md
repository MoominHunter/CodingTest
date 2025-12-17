# [Day 17] 신규 유입을 견인하는 카테고리

[문제 링크](https://solvesql.com/problems/first-order-category/)

### 제출 일자

2025년 12월 18일 03:22

### 문제 설명
US E-Commerce Records 2020 데이터베이스는 미국의 한 온라인 쇼핑몰의 2020년 주문 데이터를 담고 있습니다. 쇼핑몰의 운영팀은 어떤 상품 카테고리가 신규 고객의 첫 구매를 가장 강력하게 유도하는지 파악하여 마케팅 전략에 활용하려고 합니다.

모든 카테고리와 서브 카테고리의 조합에 대해 해당 카테고리 조합에 속한 상품이 각 사용자의 첫 구매로 주문된 건수를 집계하고, 집계된 첫 주문 건수가 많은 순서대로 내림차순 정렬하는 쿼리를 작성해주세요. 쿼리 결과에는 아래 3개의 컬럼이 있어야 합니다.

- category: 카테고리
- sub_category: 서브 카테고리
- cnt_orders: 카테고리 조합에 속하는 상품을 첫 구매한 주문 건수


힌트
여러 상품을 묶어 하나의 주문으로 구매한 경우로 인해 records 테이블에 같은 order_id를 갖는 데이터가 여러개 존재할 수 있습니다. 또한, 집계하는 단위가 상품의 수가 아닌 주문의 수라는 것을 유의하세요.


---

### 정답

```sql
-- 1. 고객별 첫 주문(order_id) 찾기
-- 2. 그 주문에 포함된 모든 상품 row 가져오기
-- 3. category + sub_category별로
-- COUNT(DISTINCT order_id)
WITH
  two AS (
    SELECT order_id
    FROM (
      SELECT
        *
        , ROW_NUMBER() OVER (
          PARTITION BY customer_id
          ORDER BY order_date, order_id ASC)
          AS rn
      FROM records
    ) AS one
    WHERE rn = 1
  )
SELECT 
  category
  , sub_category
  , COUNT(DISTINCT records.order_id) AS cnt_orders
FROM two
  INNER JOIN records
  ON two.order_id = records.order_id
GROUP BY category, sub_category
ORDER BY COUNT(DISTINCT records.order_id) DESC
;

```

### 처음 작성한 코드
```sql
-- 두 테이블 조인
-- first_order_date와 order_date가 일치하는 주문만 남기기
-- DISTINCT로 중복값 제거하기? -> customer_id 단일 열만 뽑는게 아니라 안되나?
-- ROW_NUMBER() 함수로, 고객의 주문건수에 번호를 매긴 뒤, 맨 위 행을 출력하기

WITH
  new AS (
    SELECT
      r.order_date,
      r.order_id,
      r.customer_id,
      r.category,
      r.sub_category,
      c.first_order_date,
      ROW_NUMBER() OVER (
        PARTITION BY
          r.customer_id
        ORDER BY
          r.order_date
      ) AS 'rn'
    FROM
      records r
      JOIN customer_stats c ON r.customer_id = c.customer_id
    WHERE
      r.order_date = c.first_order_date
  )
SELECT category, sub_category, COUNT(*) AS 'cnt_orders'
FROM new  
WHERE rn = 1
GROUP BY category, sub_category
ORDER BY COUNT(*) DESC
;
```

### 코드가 틀린 이유
- 문제 이해를 잘못했다. 단순히 한 행이 주문 1건이 아니라, 같은 주문번호로 여러 개의 행이 존재할 수 있음을 간과했다. 따라서 이 문제를 풀기 위해서는 내가 접근한 방식대로 접근하면 안된다. (각 고객 별로 order_date가 가장 빠른 주문 1건만 뽑음)
- 우선 고객별 첫 주문, order_id를 뽑아야 한다. 따라서 `ROW_NUMBER()` 함수를 이용하여 customer_id 별 행 번호를 저장한 열을 만들었다. 정렬은 날짜순, 주문번호순으로 지정했다. 그리고 고객별로 행 번호가 1인 주문번호만 뽑는다.
- 다음으로 records 테이블에서 위의 주문번호인 데이터만 남긴다. 이렇게 접근하면, 한 주문번호에 여러 개의 행이 존재해도 모두 뽑아낼 수 있다.
- 이후 카테고리별로 그룹화한뒤, order_id를 집계해주면 끝이다. 단, 중복값이 존재할 수 있으므로 `DISTINCT` 조건을 넣어 고유값의 개수만 세도록 한다.

### 새로 배운 것 및 느낀점
- 늘 헷갈리는 `ROW_NUMER()` 함수 사용법을 다시 배웠다. 잘 익혀서 앞으로 자유롭게 사용하게 되면 좋을 것 같다.
- 처음에는 왜 `DISTINCT` 조건을 넣어야 하는지 이해 못했는데, 중복값을 제거해줘야 함을 깨달았다. 원래는 `COUNT(*)`를 썼는데, 이렇게 써도 안된다. 결국 중복값도 모두 세어버리기 때문에 정답값이 달라질 수밖에 없다.
- 점점 난이도가 올라가지만 프로그래머스 문제와 달리 문제 퀄리티가 좋아서 만족 중이다. 25일 챌린지 후에는 다시 한 번 문제를 복습하면서 조인의 개념과 함수들을 더 공부하고 체화하고 싶다.
