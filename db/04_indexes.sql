CREATE INDEX IF NOT EXISTS idx_orders_created_at ON orders(created_at DESC);
CREATE INDEX IF NOT EXISTS idx_products_name_trgm ON products USING gin(name gin_trgm_ops);
CREATE INDEX IF NOT EXISTS idx_order_items_composite ON order_items(order_id, product_id);
CREATE INDEX IF NOT EXISTS idx_orders_status ON orders(status) WHERE status = 'completed';
CREATE INDEX IF NOT EXISTS idx_payments_method ON payments(method);
CREATE INDEX IF NOT EXISTS idx_order_items_revenue ON order_items(product_id, qty, unit_price);
