CREATE EXTENSION IF NOT EXISTS pg_trgm;
-- ============================================================================
-- STEP 2: SCHEMA (Tables, Constraints, Foreign Keys)
-- ============================================================================
-- Drop tables if they exist (for clean re-initialization)
DROP TABLE IF EXISTS payments CASCADE;
DROP TABLE IF EXISTS order_items CASCADE;
DROP TABLE IF EXISTS orders CASCADE;
DROP TABLE IF EXISTS customers CASCADE;
DROP TABLE IF EXISTS products CASCADE;
DROP TABLE IF EXISTS categories CASCADE;
-- TABLE: categories
CREATE TABLE categories
(
    id         SERIAL PRIMARY KEY,
    name       VARCHAR(100) NOT NULL UNIQUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
-- TABLE: products
CREATE TABLE products
(
    id          SERIAL PRIMARY KEY,
    name        VARCHAR(200)   NOT NULL,
    category_id INTEGER        NOT NULL,
    price       NUMERIC(10, 2) NOT NULL CHECK (price >= 0),
    stock       INTEGER        NOT NULL DEFAULT 0 CHECK (stock >= 0),
    active      BOOLEAN        NOT NULL DEFAULT true,
    created_at  TIMESTAMP               DEFAULT CURRENT_TIMESTAMP,
    updated_at  TIMESTAMP               DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_product_category FOREIGN KEY (category_id) REFERENCES categories (id) ON DELETE RESTRICT
);
-- TABLE: customers
CREATE TABLE customers
(
    id         SERIAL PRIMARY KEY,
    name       VARCHAR(200) NOT NULL,
    email      VARCHAR(255) NOT NULL UNIQUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
-- TABLE: orders
CREATE TABLE orders
(
    id          SERIAL PRIMARY KEY,
    customer_id INTEGER     NOT NULL,
    created_at  TIMESTAMP   NOT NULL DEFAULT CURRENT_TIMESTAMP,
    status      VARCHAR(50) NOT NULL DEFAULT 'pending',
    channel     VARCHAR(50) NOT NULL DEFAULT 'in-store',
    CONSTRAINT fk_order_customer FOREIGN KEY (customer_id) REFERENCES customers (id) ON DELETE RESTRICT,
    CONSTRAINT chk_order_status CHECK (status IN ('pending', 'completed', 'cancelled')),
    CONSTRAINT chk_order_channel CHECK (channel IN ('in-store', 'online', 'mobile'))
);
-- TABLE: order_items
CREATE TABLE order_items
(
    id         SERIAL PRIMARY KEY,
    order_id   INTEGER        NOT NULL,
    product_id INTEGER        NOT NULL,
    qty        INTEGER        NOT NULL CHECK (qty > 0),
    unit_price NUMERIC(10, 2) NOT NULL CHECK (unit_price >= 0),
    CONSTRAINT fk_order_item_order FOREIGN KEY (order_id) REFERENCES orders (id) ON DELETE CASCADE,
    CONSTRAINT fk_order_item_product FOREIGN KEY (product_id) REFERENCES products (id) ON DELETE RESTRICT
);
-- TABLE: payments
CREATE TABLE payments
(
    id          SERIAL PRIMARY KEY,
    order_id    INTEGER        NOT NULL,
    method      VARCHAR(50)    NOT NULL,
    paid_amount NUMERIC(10, 2) NOT NULL CHECK (paid_amount >= 0),
    created_at  TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_payment_order FOREIGN KEY (order_id) REFERENCES orders (id) ON DELETE CASCADE,
    CONSTRAINT chk_payment_method CHECK (
        method IN (
                   'cash',
                   'credit_card',
                   'debit_card',
                   'digital_wallet',
                   'transfer'
            )
        )
);
CREATE INDEX idx_products_category ON products (category_id);
CREATE INDEX idx_orders_customer ON orders (customer_id);
CREATE INDEX idx_order_items_order ON order_items (order_id);
CREATE INDEX idx_order_items_product ON order_items (product_id);
CREATE INDEX idx_payments_order ON payments (order_id);