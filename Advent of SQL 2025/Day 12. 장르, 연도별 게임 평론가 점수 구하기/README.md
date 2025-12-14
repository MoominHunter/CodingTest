# [Day 12] 장르, 연도별 게임 평론가 점수 구하기

[문제 링크](https://solvesql.com/problems/critic-scores-by-genre-and-year/)

### 제출 일자

2025년 12월 14일 16:55

### 문제 설명
Video Game Sales with Ratings 데이터베이스에는 1980년부터 2016년까지 출시된 게임 정보가 들어있습니다. 당신은 신규 게임 런칭의 책임자로서 고퀄리티의 게임을 만들고자 계획을 세우고 있고, 그 첫 단계로 새로운 게임의 장르를 결정하려고 합니다.

장르 결정에 참고하기 위해 출시 연도 기준 2011년부터 2015년까지 각 장르의 평론가 점수 평균을 계산하고자 합니다. 아래 결과 테이블 예시와 같이 평론가 점수 평균을 계산하는 쿼리를 작성해주세요. 평론가 점수 평균은 출시 연도, 장르로 묶인 게임들의 평론가 평균 점수들의 평균이며, 평론가 점수가 없는 게임은 장르 평론가 점수 평균 계산에서 제외되어야 합니다. 모든 평균 점수는 소수점 아래 셋째 자리에서 반올림 해, 둘째 자리까지 출력되어야 합니다.

결과 테이블 예시
genre	score_2011	score_2012	score_2013	score_2014	score_2015
Action	...	...	...	...	...
Adventure	...	...	...	...	...
Fighting	...	...	...	..	...
...	...	...	...	...	...


- genre: 게임 장르
- score_2011: 2011년에 출시된 해당 장르 게임의 평론가 점수 평균
- score_2012: 2012년에 출시된 해당 장르 게임의 평론가 점수 평균
- score_2013: 2013년에 출시된 해당 장르 게임의 평론가 점수 평균
- score_2014: 2014년에 출시된 해당 장르 게임의 평론가 점수 평균
- score_2015: 2015년에 출시된 해당 장르 게임의 평론가 점수 평균

| genre	| score_2011	| score_2012	| score_2013	| score_2014	| score_2015	|
|-- | -- | -- |-- | -- | -- | 
|Action	| ...	| ... | ...	| ...	| ... |
|Adventure	| ...	| ... | ...	| ...	| ... |
|Fighting	| ...	| ... | ...	| ...	| ... |




---

### 정답

```sql
-- 각 장르의 평론가 점수 평균을 계산
WITH score AS (
  SELECT ge.name AS 'genre', year, critic_score
  FROM genres ge
  JOIN games ga
  ON ge.genre_id = ga.genre_id
WHERE year BETWEEN 2011 AND 2015
  AND critic_score IS NOT NULL
)
SELECT genre
  , ROUND(AVG(CASE WHEN year = 2011 THEN critic_score END), 2) AS score_2011
  , ROUND(AVG(CASE WHEN year = 2012 THEN critic_score END), 2) AS score_2012
  , ROUND(AVG(CASE WHEN year = 2013 THEN critic_score END), 2) AS score_2013
  , ROUND(AVG(CASE WHEN year = 2014 THEN critic_score END), 2) AS score_2014
  , ROUND(AVG(CASE WHEN year = 2015 THEN critic_score END), 2) AS score_2015
FROM score
GROUP BY genre
ORDER BY genre
;
```

### 새로 배운 것
- 그룹화까진 했는데, 결과 테이블처럼 행에 있는 값을 어떻게 열로 뽑아올 수 있을지 고민했다.
- pivot밖에 떠오르지 않았는데, IF문 or CASE문을 통해 조건식으로 새로운 열을 만들 수 있음을 배웠다.
  - CASE WHEN 조건 THEN 가져올 값 ELSE 그 외 값 END) AS 컬럼명

