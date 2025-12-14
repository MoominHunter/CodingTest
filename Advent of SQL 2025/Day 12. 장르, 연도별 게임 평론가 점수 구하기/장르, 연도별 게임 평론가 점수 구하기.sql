WITH score AS (
  SELECT ge.name AS 'genre', year, critic_score
  FROM genres ge
  JOIN games ga
  ON ge.genre_id = ga.genre_id
WHERE year BETWEEN 2011 AND 2015
  AND critic_score IS NOT NULL
)
SELECT genre
  , ROUND(AVG(CASE WHEN year = 2011 THEN critic_score END), 2) AS score_2011
  , ROUND(AVG(CASE WHEN year = 2012 THEN critic_score END), 2) AS score_2012
  , ROUND(AVG(CASE WHEN year = 2013 THEN critic_score END), 2) AS score_2013
  , ROUND(AVG(CASE WHEN year = 2014 THEN critic_score END), 2) AS score_2014
  , ROUND(AVG(CASE WHEN year = 2015 THEN critic_score END), 2) AS score_2015
FROM score
GROUP BY genre
ORDER BY genre
;
