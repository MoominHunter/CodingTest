# [Day 09] 두 대회 연속으로 출전한 기록이 있는 배구 선수

[문제 링크](https://solvesql.com/problems/volleyball-players-in-two-consecutive-olympics/) 

### 제출 일자

2025년 12월 9일 23:55

### 문제 설명
역대 올림픽 정보 데이터베이스에는 1986년부터 2016년까지 역대 하계/동계 올림픽의 개최 정보와 참여한 선수들의 정보가 들어있습니다.

최근 '신인감독 김연경' 프로그램을 재밌게 보고 배구에 관심을 갖게 된 당신은 김연경 선수가 올림픽 대회를 연속으로 참여했다는 사실을 알게 되었습니다. 김연경 선수 이외에도 올림픽에 연달아 참여한 여자 배구 선수가 궁금해져 데이터베이스에서 이를 찾아보고자 합니다.

2016년까지 대한민국 국가대표팀에 소속되어 여자 배구 종목에 두 대회 이상 연속으로 참가한 선수의 ID와 이름을 출력하는 쿼리를 작성해주세요. 여자 배구 종목은 event = 'Volleyball Women''s Volleyball'로 조회할 수 있고, 대한민국 국가대표팀은 team = 'KOR'으로 조회가 가능합니다. 쿼리 결과에는 중복된 선수가 1번만 나와야 하고, 아래 컬럼이 있어야 합니다.


- id: 선수 ID
- name: 선수 이름

|id | name|
|--|--|
|...|	...|


김연경 선수의 경우 2016년 기준 2012 런던 하계 올림픽과 2016년 리우데자네이루 하계 올림픽에 2연속으로 참여해 쿼리 결과에 있어야 합니다.

---

### 정답

```sql
WITH
  base AS (
    SELECT
      r.athlete_id AS id,
      a.name,
      g.year,
      LAG(g.year) OVER (
        PARTITION BY
          r.athlete_id
        ORDER BY
          g.year
      ) AS prev_year
    FROM
      records r
      JOIN athletes a ON r.athlete_id = a.id
      JOIN games g ON g.id = r.game_id
      JOIN teams t ON t.id = r.team_id
      JOIN events e ON e.id = r.event_id
    WHERE
      t.team = 'KOR'
      AND e.event = 'Volleyball Women''s Volleyball'
      AND g.year <= 2016
  )
SELECT DISTINCT
  id,
  name
FROM
  base
WHERE
  prev_year IS NOT NULL
  AND year - prev_year = 4
ORDER BY
  id;

```

### 새로 배운 것

- 연속된 값을 구하는게 어려웠다. 결국 지피티의 도움으로 문제를 해결했다. LAG()함수를 사용해서, 이전 연도의 값을 새로운 열로 만든 뒤 4 차이가 나는 데이터만 중복 제거하여 불러온다.
- 다중 조인 하는 방법도 다시 한 번 배웠다.
- 문제에서 요구하는 조건이 많아질수록, 쿼리가 복잡해지지 않도록 미리 주석으로 설계 후 코드를 작성해야겠다.
