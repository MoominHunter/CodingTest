-- AIR_POLLUTION: LOCATION1, LOCATION2, YM, PM_VAL1, PM_VAL2

-- 수원 지역의 연도 별 평균 미세먼지 오염도 & 평균 초미세먼지 오염도를 조회하는 쿼리 작성

-- LOCATION2 == '수원', GROUP BY YM
-- DATE의 경우 그룹바이를 어떻게 해야 하지? 
-- GROUP BY year|month|day(DATE column)

SELECT year(YM) AS YEAR
        , ROUND(AVG(PM_VAL1), 2) AS 'PM10'
        , ROUND(AVG(PM_VAL2), 2) AS 'PM2.5'
FROM AIR_POLLUTION
WHERE LOCATION2 LIKE '수원'
GROUP BY year(YM)
ORDER BY YEAR
;