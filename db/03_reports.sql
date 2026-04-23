CREATE OR REPLACE VIEW vw_sales_daily AS
SELECT DATE(o.created_at)                       AS fecha,
       COUNT(DISTINCT o.id)                     AS tickets,
       SUM(oi.qty * oi.unit_price)              AS total_ventas,
       COALESCE(AVG(oi.qty * oi.unit_price), 0) AS ticket_promedio,
       COUNT(DISTINCT o.customer_id)            AS clientes_unicos,
       CASE
           WHEN COUNT(DISTINCT o.id) > 5 THEN 'Alto'
           WHEN COUNT(DISTINCT o.id) > 2 THEN 'Medio'
           ELSE 'Bajo'
           END                                  AS volumen_dia
FROM orders o
         INNER JOIN order_items oi ON o.id = oi.order_id
WHERE o.status = 'completed'
GROUP BY DATE(o.created_at)
HAVING SUM(oi.qty * oi.unit_price) > 0
ORDER BY fecha DESC;
COMMENT ON VIEW vw_sales_daily IS 'Daily sales metrics with revenue, ticket count, and average ticket value';
-- VIEW: vw_top_products_ranked
CREATE OR REPLACE VIEW vw_top_products_ranked AS
SELECT p.id                        AS product_id,
       p.name                      AS product_name,
       c.name                      AS category_name,
       SUM(oi.qty)                 AS total_units,
       SUM(oi.qty * oi.unit_price) AS total_revenue,
       ROUND(
               SUM(oi.qty * oi.unit_price) / NULLIF(SUM(oi.qty), 0),
               2
       )                           AS revenue_per_unit,
       ROW_NUMBER() OVER (
           ORDER BY SUM(oi.qty * oi.unit_price) DESC
           )                       AS ranking_revenue,
       ROW_NUMBER() OVER (
           ORDER BY SUM(oi.qty) DESC
           )                       AS ranking_units,
       CASE
           WHEN SUM(oi.qty * oi.unit_price) > 1000 THEN 'Estrella'
           WHEN SUM(oi.qty * oi.unit_price) > 500 THEN 'Popular'
           ELSE 'Regular'
           END                     AS performance_category
FROM products p
         INNER JOIN categories c ON p.category_id = c.id
         INNER JOIN order_items oi ON p.id = oi.product_id
         INNER JOIN orders o ON oi.order_id = o.id
WHERE o.status = 'completed'
GROUP BY p.id,
         p.name,
         c.name
ORDER BY total_revenue DESC;
COMMENT ON VIEW vw_top_products_ranked IS 'Product ranking by revenue and units with window functions for ranking';
-- VIEW: vw_inventory_risk
CREATE OR REPLACE VIEW vw_inventory_risk AS
WITH daily_sales AS (SELECT oi.product_id,
                            COUNT(DISTINCT DATE(o.created_at)) AS days_with_sales,
                            SUM(oi.qty)                        AS total_sold,
                            ROUND(
                                    SUM(oi.qty)::NUMERIC / NULLIF(COUNT(DISTINCT DATE(o.created_at)), 0),
                                    2
                            )                                  AS avg_daily_qty
                     FROM order_items oi
                              INNER JOIN orders o ON oi.order_id = o.id
                     WHERE o.status = 'completed'
                       AND o.created_at >= CURRENT_TIMESTAMP - INTERVAL '30 days'
                     GROUP BY oi.product_id
                     HAVING SUM(oi.qty) > 0)
SELECT p.id                          AS product_id,
       p.name                        AS product_name,
       c.name                        AS category_name,
       p.stock                       AS current_stock,
       COALESCE(ds.avg_daily_qty, 0) AS avg_daily_sales,
       CASE
           WHEN COALESCE(ds.avg_daily_qty, 0) = 0 THEN NULL
           ELSE ROUND(p.stock / ds.avg_daily_qty, 1)
           END                       AS days_remaining,
       ROUND(
               (
                   p.stock::NUMERIC / NULLIF(p.stock + COALESCE(ds.total_sold, 0), 0)
                   ) * 100,
               2
       )                             AS stock_percentage,
       CASE
           WHEN p.stock = 0 THEN 'AGOTADO'
           WHEN p.stock <= 5
               OR (
                    COALESCE(ds.avg_daily_qty, 0) > 0
                        AND p.stock / ds.avg_daily_qty < 3
                    ) THEN 'CRÍTICO'
           WHEN p.stock <= 20
               OR (
                    COALESCE(ds.avg_daily_qty, 0) > 0
                        AND p.stock / ds.avg_daily_qty < 7
                    ) THEN 'BAJO'
           ELSE 'NORMAL'
           END                       AS risk_level,
       p.active                      AS is_active
FROM products p
         INNER JOIN categories c ON p.category_id = c.id
         LEFT JOIN daily_sales ds ON p.id = ds.product_id
WHERE p.active = true
ORDER BY CASE
             WHEN p.stock = 0 THEN 1
             WHEN p.stock <= 5 THEN 2
             WHEN p.stock <= 20 THEN 3
             ELSE 4
             END,
         p.stock ASC;
COMMENT ON VIEW vw_inventory_risk IS 'Inventory risk assessment with stock levels and days remaining calculations';
-- VIEW: vw_customer_value
CREATE OR REPLACE VIEW vw_customer_value AS
SELECT c.id                                  AS customer_id,
       c.name                                AS customer_name,
       c.email                               AS customer_email,
       COUNT(DISTINCT o.id)                  AS num_ordenes,
       SUM(oi.qty * oi.unit_price)           AS total_gastado,
       ROUND(AVG(oi.qty * oi.unit_price), 2) AS gasto_promedio,
       MAX(o.created_at)                     AS last_purchase,
       CASE
           WHEN COUNT(DISTINCT o.id) >= 5 THEN 'VIP'
           WHEN COUNT(DISTINCT o.id) >= 3 THEN 'Frecuente'
           ELSE 'Ocasional'
           END                               AS customer_segment,
       ROUND(
               SUM(oi.qty * oi.unit_price) / NULLIF(COUNT(DISTINCT o.id), 0),
               2
       )                                     AS avg_order_value,
       EXTRACT(
               DAY
               FROM (CURRENT_TIMESTAMP - MAX(o.created_at))
       )                                     AS days_since_last_purchase
FROM customers c
         INNER JOIN orders o ON c.id = o.customer_id
         INNER JOIN order_items oi ON o.id = oi.order_id
WHERE o.status = 'completed'
GROUP BY c.id,
         c.name,
         c.email
HAVING SUM(oi.qty * oi.unit_price) > 0
ORDER BY total_gastado DESC;
COMMENT ON VIEW vw_customer_value IS 'Customer lifetime value with purchase frequency and segmentation';
-- VIEW: vw_payment_mix
CREATE OR REPLACE VIEW vw_payment_mix AS
WITH payment_totals AS (SELECT p.method,
                               COUNT(*)           AS transaction_count,
                               SUM(p.paid_amount) AS method_total,
                               AVG(p.paid_amount) AS method_avg
                        FROM payments p
                                 INNER JOIN orders o ON p.order_id = o.id
                        WHERE o.status = 'completed'
                        GROUP BY p.method),
     grand_total AS (SELECT SUM(paid_amount) AS total_revenue
                     FROM payments p
                              INNER JOIN orders o ON p.order_id = o.id
                     WHERE o.status = 'completed')
SELECT pt.method               AS payment_method,
       CASE
           pt.method
           WHEN 'cash' THEN 'Efectivo'
           WHEN 'credit_card' THEN 'Tarjeta de Crédito'
           WHEN 'debit_card' THEN 'Tarjeta de Débito'
           WHEN 'digital_wallet' THEN 'Billetera Digital'
           WHEN 'transfer' THEN 'Transferencia'
           ELSE 'Otro'
           END                 AS method_name,
       pt.transaction_count    AS total_transactions,
       pt.method_total         AS total_amount,
       ROUND(pt.method_avg, 2) AS avg_transaction,
       ROUND(
               (pt.method_total / NULLIF(gt.total_revenue, 0)) * 100,
               2
       )                       AS percentage,
       CASE
           WHEN (pt.method_total / NULLIF(gt.total_revenue, 0)) * 100 > 30 THEN 'Dominante'
           WHEN (pt.method_total / NULLIF(gt.total_revenue, 0)) * 100 > 15 THEN 'Importante'
           ELSE 'Secundario'
           END                 AS importance_level
FROM payment_totals pt
         CROSS JOIN grand_total gt
ORDER BY pt.method_total DESC;
COMMENT ON VIEW vw_payment_mix IS 'Payment method distribution with percentages and transaction analysis';