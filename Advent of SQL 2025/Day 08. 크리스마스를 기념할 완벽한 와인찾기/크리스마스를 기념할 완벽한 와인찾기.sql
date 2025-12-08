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
