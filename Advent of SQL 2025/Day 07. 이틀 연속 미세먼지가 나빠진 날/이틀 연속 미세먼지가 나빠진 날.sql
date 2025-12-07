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
