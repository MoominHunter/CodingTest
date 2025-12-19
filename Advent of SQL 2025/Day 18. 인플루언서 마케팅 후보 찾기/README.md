# [Day 18] 인플루언서 마케팅 후보 찾기

[문제 링크](https://solvesql.com/problems/influencer-marketing-candidates/)

### 제출 일자

2025년 12월 19일 15:40

### 문제 설명

Facebook 소셜 네트워크 데이터베이스는 Facebook 서비스에서 샘플링한 사용자의 메타 정보와 사용자 사이의 친구 관계를 담고 있습니다. edges 테이블에는 사용자의 친구 관계 정보가 들어있는데 각 행의 user_a_id 컬럼 사용자와 user_b_id 컬럼 사용자가 서로 친구 관계라는 의미 입니다.

Facebook을 통해 인플루언서 마케팅을 하려는 당신은 비용과 마케팅 효과를 생각해 적절한 인플루언서를 선정하려고 합니다. 여러 가지 효과를 감안해서 당신은 다음과 같은 인플루언서 선정 기준을 정했습니다.

- 후보의 친구 수가 100명 이상
- 후보 친구들의 친구 수의 합계(`a`)와 후보 친구 수(`b`)의 비율(`a/b`)

이 높은 순으로 선정
단, 친구들의 친구 수 합계 계산에는 중복된 친구와 후보자도 모두 포함


- user_id: 후보의 사용자 ID
- friends: 후보의 친구 수
- friends_of_friends: 후보 친구들의 친구 수 합계
- ratio: 후보 친구들의 친구 수 합계와 후보 친구 수의 비율

힌트
사용자의 친구 관계 테이블인 edges는 수만 개 이상의 레코드가 있는 큰 테이블 입니다. 친구들의 친구 수를 집계할 때 edges 테이블을 self-join 하는 접근법은 계산량이 많아 쿼리 수행이 불가능 합니다.


---

### 정답

```sql
WITH undirected AS (
  SELECT user_a_id AS user_id, user_b_id AS friend_id
  FROM edges
  UNION ALL
  SELECT user_b_id AS user_id, user_a_id AS friend_id
  FROM edges
),
friends_num AS (
  SELECT
    user_id,
    COUNT(*) AS friends
  FROM undirected
  GROUP BY user_id
),
friends_of_friends AS (
  SELECT
    u.user_id,
    SUM(fn2.friends) AS friends_of_friends
  FROM undirected u
  JOIN friends_num fn2
    ON fn2.user_id = u.friend_id
  GROUP BY u.user_id
)
SELECT
  fn.user_id,
  fn.friends,
  fof.friends_of_friends,
  ROUND(fof.friends_of_friends / fn.friends, 2) AS ratio
FROM friends_num fn
JOIN friends_of_friends fof
  ON fof.user_id = fn.user_id
WHERE fn.friends >= 100
ORDER BY ratio DESC, fn.user_id ASC
LIMIT 5;

```

### 느낀점
- SQL은 너무 어렵다..
