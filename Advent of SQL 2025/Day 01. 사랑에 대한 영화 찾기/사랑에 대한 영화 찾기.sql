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
