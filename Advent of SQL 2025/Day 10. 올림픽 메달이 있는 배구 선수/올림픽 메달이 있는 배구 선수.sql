SELECT
  a.id        AS id,
  a.name      AS name,
  GROUP_CONCAT(DISTINCT r.medal ORDER BY r.medal SEPARATOR ', ') AS medals
FROM records r
JOIN athletes a ON r.athlete_id = a.id
JOIN teams    t ON r.team_id    = t.id
JOIN events   e ON r.event_id   = e.id
JOIN games    g ON r.game_id    = g.id
WHERE
  t.team = 'KOR'
  AND e.event = 'Volleyball Women''s Volleyball'
  AND g.year <= 2016
  AND r.medal IS NOT NULL
GROUP BY
  a.id,
  a.name
ORDER BY
  a.id;
