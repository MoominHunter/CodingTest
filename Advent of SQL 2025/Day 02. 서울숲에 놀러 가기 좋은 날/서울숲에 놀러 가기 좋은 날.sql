SELECT
  measured_at AS good_day
FROM
  measurements
WHERE
  (measured_at LIKE '2022-12%') 
  && (pm2_5 <= 9)
ORDER BY
  measured_at;
