# [Day 01] 사랑에 대한 영화 찾기

[문제 링크](https://solvesql.com/problems/movies-about-love/) 

### 제출 일자

2025년 12월 1일 15:10

### 문제 설명

Movies on OTT 데이터베이스는 넷플릭스, 디즈니 플러스 등 OTT 플랫폼에서 서비스하는 영화 정보를 담고 있습니다.
이 영화 중 크리스마스에 연인과 함께 볼 사랑에 대한 영화를 찾고 싶습니다. 
영화 제목에 'Love' 또는 'love'라는 글자가 포함된 영화의 제목과 개봉 연도, 로튼 토마토 평점을 조회하는 쿼리를 작성해주세요. 
결과는 로튼 토마토 평점이 높은 순으로 정렬되어 있어야 하고, 만약 평점이 같다면 개봉 연도가 최근인 영화부터 출력되어야 합니다.


title: 영화 제목

year: 개봉년도

rotten_tomatoes: 로튼 토마토 점수

---
### 정답

```sql
-- 영화 제목에 'LOVE' or 'love' 가 포함된 영화를 조회
SELECT
  title,
  year,
  rotten_tomatoes
FROM
  movies
WHERE
  (title LIKE '%love%') | 
  (title LIKE '%Love%')
ORDER BY
  rotten_tomatoes DESC, year DESC
  ;

```
