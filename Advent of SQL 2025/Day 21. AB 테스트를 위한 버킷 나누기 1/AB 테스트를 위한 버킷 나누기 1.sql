-- A: customer_id % 10 = 0 -> new_design
-- B: others
SELECT
  DISTINCT customer_id
  , IF(customer_id % 10 = 0, 'A', 'B') AS 'bucket'
FROM
  transactions
ORDER BY
  customer_id
;
