# [Day 14] 이달의 작가 후보 찾기

[문제 링크](https://solvesql.com/problems/monthly-author-candidates/)

### 제출 일자

2025년 12월 15일 00:20

### 문제 설명
Amazon Top 50 Bestselling Books 데이터베이스에는 아마존 쇼핑몰에서 2009년부터 2019년까지 매년 집계한 판매량 상위 50위의 책 정보를 담고 있습니다.

북클럽을 운영하는 당신은 화제성과 작품성을 모두 잡은 소설 작가를 찾아 이달의 작가로 선정하고 해당 작가의 작품들을 리뷰하는 시간을 가져보려고 합니다. 후보 작가 선정을 위해 당신은 아래와 같은 기준을 선정했습니다.

아마존 판매량 상위 50위 이내에 작품, 연도 상관 없이 2회 이상 등재
해당 작가 작품들의 평균 사용자 평점이 4.5점 이상
해당 작가 작품들의 평균 리뷰 수가 소설 분야 작품들의 평균 리뷰 수 이상
데이터베이스를 조회해 위 기준에 맞는 후보 작가 이름을 출력하는 쿼리를 작성해주세요. 쿼리 결과에는 작가 이름이 출력되는 컬럼 하나만 있어야 하고, 작가 이름 기준 사전순으로 정렬되어 있어야 합니다.




---

### 정답

```sql

-- 조건에 해당하는 작가 이름 출력하기
-- 2회 이상 등재
-- 작품들 평균 평점 4.5 이상
-- 작품들의 평균 리뷰 수 >= 소설분야(Fiction) 평균 리뷰 수
SELECT
  author
FROM
  books
WHERE
  genre LIKE 'Fiction'
GROUP BY
  author
HAVING
  COUNT(author) >= 2
  AND AVG(user_rating) >= 4.5
  AND AVG(reviews) >= (
    SELECT
      AVG(reviews)
    FROM
      books
    WHERE
      genre LIKE 'Fiction'
  )
ORDER BY
  author ASC;
```

### 새로 배운 것

- WHERE절에 계산된 값이 필요할 경우 서브쿼리를 사용하여 필터링을 할 수 있다.
