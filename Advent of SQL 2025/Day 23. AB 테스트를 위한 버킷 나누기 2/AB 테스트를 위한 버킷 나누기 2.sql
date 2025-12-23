WITH user_metrics AS (
    SELECT 
        customer_id,
        CASE WHEN customer_id % 10 = 0 THEN 'A' ELSE 'B' END AS bucket,
        COUNT(DISTINCT transaction_id) AS order_count,
        SUM(total_price) AS total_revenue
  FROM transactions
  WHERE is_returned = FALSE
  GROUP BY customer_id
)
SELECT 
    bucket,
    COUNT(DISTINCT customer_id) AS user_count,
    ROUND(AVG(order_count), 2) AS avg_orders,
    ROUND(AVG(total_revenue), 2) AS avg_revenue
FROM user_metrics
GROUP BY bucket
ORDER BY bucket;
