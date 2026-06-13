-- RX growth percentage
SELECT 
    physician_id,
    product_id,
    month,
    rx_units,
    LAG(rx_units) OVER (PARTITION BY physician_id, product_id ORDER BY month) AS prev_month_units,
    ROUND(
        (rx_units - LAG(rx_units) OVER (PARTITION BY physician_id, product_id ORDER BY month)) 
        / NULLIF(LAG(rx_units) OVER (PARTITION BY physician_id, product_id ORDER BY month),0) * 100, 
    2) AS rx_growth_pct
FROM rx_data
ORDER BY physician_id, product_id, month;

-- call effectiveness ratio--
SELECT 
    m.physician_id,
    m.product_id,
    m.month,
    m.rx_units,
    COALESCE(mc.total_calls_made, 0) AS total_calls_made,
    ROUND(m.rx_units / NULLIF(mc.total_calls_made, 0), 2) AS rx_per_call
FROM vw_master m
LEFT JOIN vw_monthly_calls mc 
    ON m.physician_id = mc.physician_id 
    AND m.product_id = mc.product_discussed_id 
    AND m.month = mc.month
ORDER BY m.physician_id, m.product_id, m.month;

SHOW COLUMNS FROM vw_monthly_calls;

-- physician penetration
SELECT 
    p.segment,
    COUNT(DISTINCT p.physician_id) AS total_physicians,
    COUNT(DISTINCT mc.physician_id) AS physicians_called,
    ROUND(COUNT(DISTINCT mc.physician_id) / COUNT(DISTINCT p.physician_id) * 100, 2) AS penetration_pct
FROM physicians p
LEFT JOIN vw_monthly_calls mc ON p.physician_id = mc.physician_id
GROUP BY p.segment
ORDER BY p.segment;

-- territory market share
WITH territory_product_sales AS (
    SELECT territory_id, product_id, SUM(rx_value_usd) AS territory_product_value
    FROM vw_master
    GROUP BY territory_id, product_id
),
product_totals AS (
    SELECT product_id, SUM(rx_value_usd) AS total_product_value
    FROM vw_master
    GROUP BY product_id
)
SELECT 
    t.territory_id,
    t.product_id,
    t.territory_product_value,
    ROUND(t.territory_product_value / p.total_product_value * 100, 2) AS market_share_pct
FROM territory_product_sales t
INNER JOIN product_totals p ON t.product_id = p.product_id
ORDER BY t.product_id, market_share_pct DESC;