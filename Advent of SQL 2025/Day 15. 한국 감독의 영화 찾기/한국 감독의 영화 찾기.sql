WITH
  film AS (
    SELECT
      artwork_id,
      title
    FROM
      artworks
    WHERE
      classification LIKE 'Film%'
  )
SELECT
  a.name AS 'artist',
  f.title AS 'title'
FROM
  artworks_artists aa
  JOIN film f ON aa.artwork_id = f.artwork_id
  JOIN artists a ON aa.artist_id = a.artist_id
WHERE
  a.nationality LIKE 'Korean';
