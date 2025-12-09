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
-- 조건에 맞는 와인 목록을 추출하기
-- 각 열의 계산된 평균 값이 필요하므로 WITH AS 구문을 사용
-- 화이트 와인만 계산한 값 추가하기
WITH
  wine_avg AS (
    SELECT
      AVG(density) AS avg_density,
      AVG(residual_sugar) AS avg_sugar
    FROM
      wines
  ),
  wine_avg_white AS (
    SELECT
      AVG(pH) AS avg_pH,
      AVG(citric_acid) AS avg_acid
    FROM
      wines
    WHERE
      color LIKE 'white'
  )
SELECT
  color,
  fixed_acidity,
  volatile_acidity,
  citric_acid,
  residual_sugar,
  chlorides,
  free_sulfur_dioxide,
  total_sulfur_dioxide,
  density,
  pH,
  sulphates,
  alcohol,
  quality
FROM
  wines,
  wine_avg,
  wine_avg_white
WHERE
  -- 화이트 와인
  (color LIKE 'white')
  -- 품질이 7 이상
  AND (quality >= 7)
  -- 밀도(density)와 잔여 설탕(residual_sugar)이 평균보다 높은 것
  AND (density > avg_density)
  AND (residual_sugar > avg_sugar)
  -- 산도가 화이트 와인 평균보다 낮고
  AND (pH < avg_pH)
  -- 구연산 값이 평균보다 높을 것
  AND (citric_acid > avg_acid);

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
