# [Day 10] 올림픽 메달이 있는 배구 선수

[문제 링크](https://solvesql.com/problems/volleyball-players-with-medals/) 

### 제출 일자

2025년 12월 10일 23:55

### 문제 설명
역대 올림픽 정보 데이터베이스에는 1986년부터 2016년까지 역대 하계/동계 올림픽의 개최 정보와 참여한 선수들의 정보가 들어있습니다.

최근 '신인감독 김연경' 프로그램을 재밌게 보고 배구에 관심을 갖게 된 당신은 김연경 선수가 올림픽 메달을 수상하지는 못했다는 사실을 알게되었습니다. 당신은 역대 대한민국 여자배구 대표팀이 메달을 딴 적이 있는지 궁금해져 데이터베이스에서 관련 정보를 조회하려고 합니다.

2016년까지 대한민국 국가대표팀에 소속되어 여자 배구 종목에 참가한 선수 중 메달을 딴 선수의 ID와 이름, 메달 종류를 출력하는 쿼리를 작성해주세요. 여자 배구 종목은 event = 'Volleyball Women''s Volleyball'로 조회할 수 있고, 대한민국 국가대표팀은 team = 'KOR'으로 조회가 가능합니다. 쿼리 결과에는 중복된 선수가 1번만 나와야 하고, 아래 컬럼이 있어야 합니다. 한 선수가 여러 개의 메달을 가진 경우 메달 종류를 쉼표(,)로 붙여 하나의 컬럼에 출력되도록 쿼리를 작성해주세요.

- id: 선수 ID
- name: 선수 이름
- medals: 받은 올림픽 메달

결과 데이터 예시

|id	| name	| medals|
|-- | -- | -- |
|6734	| Baek Myeong-Seon	| Bronze |
|...	| ...	| ... |

백명선 선수는 1976년 몬트리올 하계 올림픽에 대한민국 여자 배구 대표팀으로 참가해 동메달을 딴 이력이 있습니다.


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
