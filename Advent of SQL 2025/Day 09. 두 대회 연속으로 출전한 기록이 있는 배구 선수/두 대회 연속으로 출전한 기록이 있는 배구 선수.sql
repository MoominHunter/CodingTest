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
