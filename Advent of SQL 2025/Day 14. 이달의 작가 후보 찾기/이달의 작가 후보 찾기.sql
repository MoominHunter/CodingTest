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
