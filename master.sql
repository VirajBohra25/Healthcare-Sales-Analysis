CREATE VIEW vw_master AS
SELECT 
    r.rx_id,
    r.physician_id,
    r.product_id,
    r.month,
    r.rx_units,
    r.rx_value_usd,
    p.physician_name,
    p.specialty,
    p.segment,
    t.territory_id,
    t.territory_name,
    t.region,
    pr.product_name,
    pr.category
FROM rx_data r
INNER JOIN physicians p ON r.physician_id = p.physician_id
INNER JOIN territories t ON p.territory_id = t.territory_id
INNER JOIN products pr ON r.product_id = pr.product_id;