-- 전체 친구 관계 중 초기 0.1%의 친구 관계만 추출
-- 두 사용자의 ID의 합이 상위 0.1%이내인 친구 관계 출력하기
-- 새로운 컬럼 만들기  (사용자 ID 합)
-- id_sum 오름차순 정렬 
-- 0.1% 이내만 출력하기
  -- ranking 컬럼 만들기
  -- 총 row의 개수 구하기 (COUNT(*))
  -- where ranking / row_num <= 0.1 조건 추가
WITH point AS (
  SELECT 
    user_a_id
    , user_b_id
    , (user_a_id + user_b_id) AS 'id_sum'
    , rank() over (ORDER BY (user_a_id + user_b_id)) AS 'ranking'
  FROM edges
)
, row_num AS (
  SELECT COUNT(*) AS 'count_row'
  FROM edges
)
SELECT 
  user_a_id
  , user_b_id
  , id_sum
FROM point, row_num
WHERE (ranking / count_row) <= 0.001
;
