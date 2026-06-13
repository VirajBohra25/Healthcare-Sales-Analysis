CREATE OR REPLACE VIEW vw_monthly_calls AS
SELECT c.physician_id, c.product_discussed_id,
    DATE_FORMAT(c.call_date, '%Y-%m-01') AS month,
    COUNT(c.call_id) AS total_calls_made,
    ROUND(AVG(c.call_duration_min),0) AS avg_call_duration
FROM call_activity c
GROUP BY c.physician_id, c.product_discussed_id, DATE_FORMAT(c.call_date, '%Y-%m-01');