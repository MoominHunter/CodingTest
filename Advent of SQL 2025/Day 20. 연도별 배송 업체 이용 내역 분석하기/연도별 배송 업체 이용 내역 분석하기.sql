SELECT
  YEAR(purchased_at) AS 'year',
  -- standard = 기본 배송 + 반품 추가
  SUM(CASE WHEN shipping_method = 'Standard' THEN 1 ELSE 0 END)
+ SUM(CASE WHEN is_returned = 1 THEN 1 ELSE 0 END) AS standard,

  SUM(CASE WHEN shipping_method = 'Express' THEN 1 ELSE 0 END) AS express,
  SUM(CASE WHEN shipping_method = 'Overnight' THEN 1 ELSE 0 END) AS overnight
FROM transactions
WHERE is_online_order = 1
GROUP BY YEAR(purchased_at)
ORDER BY YEAR(purchased_at)
  ;
