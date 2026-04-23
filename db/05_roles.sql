DROP USER IF EXISTS app_user;
-- Create app user
CREATE USER app_user WITH PASSWORD 'docker_practice';
-- Revoke default permissions
REVOKE ALL ON SCHEMA public
    FROM app_user;
REVOKE ALL ON ALL TABLES IN SCHEMA public
    FROM app_user;
REVOKE ALL ON ALL SEQUENCES IN SCHEMA public
    FROM app_user;
-- Grant minimal required permissions
GRANT USAGE ON SCHEMA public TO app_user;
-- Grant SELECT permission ONLY on views (not on tables)
GRANT SELECT ON vw_sales_daily TO app_user;
GRANT SELECT ON vw_top_products_ranked TO app_user;
GRANT SELECT ON vw_inventory_risk TO app_user;
GRANT SELECT ON vw_customer_value TO app_user;
GRANT SELECT ON vw_payment_mix TO app_user;
-- Set default privileges for future views
ALTER DEFAULT PRIVILEGES IN SCHEMA public
    GRANT SELECT ON TABLES TO app_user;