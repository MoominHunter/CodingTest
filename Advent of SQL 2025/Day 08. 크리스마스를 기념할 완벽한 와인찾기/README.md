# [Day 08] 크리스마스를 기념할 완벽한 와인찾기

[문제 링크](https://solvesql.com/problems/wines-for-friends/) 

### 제출 일자

2025년 12월 8일 17:10

### 문제 설명

Wine Quality 데이터베이스는 와인의 품질, 산도, 도수 등 다양한 와인의 품질 정보를 담고 있습니다.

크리스마스를 맞아 당신은 친구에게 와인을 선물하려고 합니다. 친구와 함께 마셨던 와인 목록을 통해 당신은 친구의 와인 취향을 알게 되었습니다.

화이트 와인을 선호합니다.
복합적인 맛이 있는 와인을 좋아합니다.
너무 가볍지 않고 입안에서 풍부하게 느껴지는 바디감과 은은한 단맛을 선호합니다.
산미가 어느 정도 있는 신선한 맛을 좋아합니다.
친구의 와인 취향을 바탕으로 선물할 와인을 고르는 조건을 아래와 같이 결정했습니다.

- 화이트 와인일 것
- 와인 품질 점수가 7점 이상일 것
- 밀도와 잔여 설탕이 와인 전체의 해당 성분 평균 보다 높을 것
- 산도가 화이트 와인 전체 평균보다 낮고, 구연산 값이 화이트 와인 전체 평균 보다 높을 것


위의 조건에 맞는 와인 목록을 추린 뒤 그 중 하나의 와인을 친구에게 선물하려고 합니다. 조건에 맞는 와인 목록을 출력하는 쿼리를 작성해주세요. 쿼리 결과에는 wines 테이블에 있는 모든 컬럼이 출력되어야 합니다.


---

### 정답

```sql
-- 오늘의 미세먼지 수치(pm10)가 어제보다 나빠지고 (크고)
-- 어제의 미세먼지 수치가 그제보다 나빠졌으며 (크고)
-- 오늘의 미세먼지 수치가 30이상인 날

WITH  -- 일단 이틀 전의 미세먼지 데이터까지 새로운 행으로 만들기 (LAG함수 사용)
  pm10_bad AS (
    SELECT
      measured_at,
      pm10,
      LAG(pm10, 1) OVER (
        ORDER BY
          measured_at
      ) AS 'oneday_pm10',
      LAG(pm10, 2) OVER (
        ORDER BY
          measured_at
      ) AS 'twoday_pm10'
    FROM
      measurements
  )
SELECT
  measured_at AS date_alert -- , pm10, oneday_pm10, twoday_pm10
FROM
  pm10_bad
WHERE
 -- 1. 오늘의 수치가 어제 수치보다 나빠지고 (크고)
  (pm10 > oneday_pm10)
 -- 2. 어제의 미세먼지 수치가 그제보다 나빠지고 (크고)
  AND (oneday_pm10 > twoday_pm10)
 -- 3. 오늘의 미세먼지 수치가 30 이상인 날
  AND (pm10 >= 30)
  AND (oneday_pm10 IS NOT NULL AND twoday_pm10 IS NOT NULL)
ORDER BY
  measured_at ASC
;

```

### 새로 배운 것

- WHERE 절에서 함수를 사용할 수 없다. 때문에 서브쿼리나 WITH 구문을 사용하여 계산된 값을 불러온다.

-  WITH AS 구문 두 번 사용 시, 다음과 같은 형태로 작성한다.
  ```sql
  WITH A AS(
  ...
  )
  , B AS(
  ...
  )
  ```
