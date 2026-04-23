-- Categories
INSERT INTO categories (name)
VALUES ('Bebidas Calientes'),
       ('Bebidas Frías'),
       ('Repostería'),
       ('Snacks'),
       ('Desayunos');
-- Products
INSERT INTO products (name, category_id, price, stock, active)
VALUES -- Bebidas Calientes (category_id = 1)
       ('Café Americano', 1, 35.00, 100, true),
       ('Café Latte', 1, 45.00, 80, true),
       ('Cappuccino', 1, 45.00, 75, true),
       ('Espresso', 1, 30.00, 90, true),
       ('Chocolate Caliente', 1, 40.00, 5, true),
       -- Bebidas Frías (category_id = 2)
       ('Frappé de Café', 2, 55.00, 60, true),
       ('Smoothie de Fresa', 2, 50.00, 45, true),
       ('Té Helado', 2, 35.00, 70, true),
       ('Limonada Natural', 2, 30.00, 3, true),
       -- Repostería (category_id = 3)
       ('Croissant', 3, 25.00, 40, true),
       ('Muffin de Chocolate', 3, 30.00, 35, true),
       ('Cheesecake', 3, 55.00, 20, true),
       ('Brownie', 3, 35.00, 2, true),
       ('Donas Glaseadas', 3, 20.00, 50, true),
       -- Snacks (category_id = 4)
       ('Sandwich de Jamón', 4, 45.00, 30, true),
       ('Ensalada César', 4, 65.00, 25, true),
       ('Galletas Artesanales', 4, 15.00, 100, true),
       -- Desayunos (category_id = 5)
       ('Desayuno Completo', 5, 85.00, 15, true),
       ('Chilaquiles', 5, 70.00, 20, true),
       ('Hotcakes', 5, 55.00, 1, true);
-- Customers
INSERT INTO customers (name, email)
VALUES ('Ana García', 'ana.garcia@email.com'),
       ('Carlos Rodríguez', 'carlos.rodriguez@email.com'),
       ('María López', 'maria.lopez@email.com'),
       ('Juan Martínez', 'juan.martinez@email.com'),
       ('Laura Hernández', 'laura.hernandez@email.com'),
       ('Pedro Sánchez', 'pedro.sanchez@email.com'),
       ('Sofia Ramírez', 'sofia.ramirez@email.com'),
       ('Diego Torres', 'diego.torres@email.com'),
       ('Valentina Cruz', 'valentina.cruz@email.com'),
       ('Miguel Flores', 'miguel.flores@email.com'),
       ('Isabella Morales', 'isabella.morales@email.com'),
       ('Alejandro Ruiz', 'alejandro.ruiz@email.com'),
       ('Camila Jiménez', 'camila.jimenez@email.com'),
       ('Daniel Vargas', 'daniel.vargas@email.com'),
       ('Gabriela Mendoza', 'gabriela.mendoza@email.com');
-- Orders and Order Items (Last 30 days of data)
-- Day -30
INSERT INTO orders (customer_id, created_at, status, channel)
VALUES (
           1,
           CURRENT_TIMESTAMP - INTERVAL '30 days',
           'completed',
           'in-store'
       ),
       (
           2,
           CURRENT_TIMESTAMP - INTERVAL '30 days',
           'completed',
           'online'
       );
INSERT INTO order_items (order_id, product_id, qty, unit_price)
VALUES (1, 1, 2, 35.00),
       (1, 10, 1, 25.00),
       (2, 2, 1, 45.00),
       (2, 11, 2, 30.00);
INSERT INTO payments (order_id, method, paid_amount)
VALUES (1, 'cash', 95.00),
       (2, 'credit_card', 105.00);
-- Day -28
INSERT INTO orders (customer_id, created_at, status, channel)
VALUES (
           3,
           CURRENT_TIMESTAMP - INTERVAL '28 days',
           'completed',
           'in-store'
       ),
       (
           4,
           CURRENT_TIMESTAMP - INTERVAL '28 days',
           'completed',
           'mobile'
       );
INSERT INTO order_items (order_id, product_id, qty, unit_price)
VALUES (3, 6, 1, 55.00),
       (3, 12, 1, 55.00),
       (4, 18, 1, 85.00),
       (4, 1, 1, 35.00);
INSERT INTO payments (order_id, method, paid_amount)
VALUES (3, 'debit_card', 110.00),
       (4, 'digital_wallet', 120.00);
-- Day -25
INSERT INTO orders (customer_id, created_at, status, channel)
VALUES (
           5,
           CURRENT_TIMESTAMP - INTERVAL '25 days',
           'completed',
           'in-store'
       ),
       (
           1,
           CURRENT_TIMESTAMP - INTERVAL '25 days',
           'completed',
           'in-store'
       ),
       (
           6,
           CURRENT_TIMESTAMP - INTERVAL '25 days',
           'completed',
           'online'
       );
INSERT INTO order_items (order_id, product_id, qty, unit_price)
VALUES (5, 2, 2, 45.00),
       (5, 14, 3, 20.00),
       (6, 3, 1, 45.00),
       (6, 10, 1, 25.00),
       (7, 19, 1, 70.00),
       (7, 1, 1, 35.00);
INSERT INTO payments (order_id, method, paid_amount)
VALUES (5, 'cash', 150.00),
       (6, 'credit_card', 70.00),
       (7, 'transfer', 105.00);
-- Day -22
INSERT INTO orders (customer_id, created_at, status, channel)
VALUES (
           7,
           CURRENT_TIMESTAMP - INTERVAL '22 days',
           'completed',
           'mobile'
       ),
       (
           8,
           CURRENT_TIMESTAMP - INTERVAL '22 days',
           'completed',
           'in-store'
       );
INSERT INTO order_items (order_id, product_id, qty, unit_price)
VALUES (8, 15, 1, 45.00),
       (8, 17, 2, 15.00),
       (9, 6, 2, 55.00),
       (9, 13, 1, 35.00);
INSERT INTO payments (order_id, method, paid_amount)
VALUES (8, 'digital_wallet', 75.00),
       (9, 'cash', 145.00);
-- Day -20
INSERT INTO orders (customer_id, created_at, status, channel)
VALUES (
           9,
           CURRENT_TIMESTAMP - INTERVAL '20 days',
           'completed',
           'in-store'
       ),
       (
           10,
           CURRENT_TIMESTAMP - INTERVAL '20 days',
           'completed',
           'online'
       ),
       (
           2,
           CURRENT_TIMESTAMP - INTERVAL '20 days',
           'completed',
           'in-store'
       );
INSERT INTO order_items (order_id, product_id, qty, unit_price)
VALUES (10, 1, 3, 35.00),
       (10, 10, 2, 25.00),
       (11, 18, 1, 85.00),
       (11, 2, 1, 45.00),
       (12, 7, 1, 50.00),
       (12, 11, 1, 30.00);
INSERT INTO payments (order_id, method, paid_amount)
VALUES (10, 'cash', 155.00),
       (11, 'credit_card', 130.00),
       (12, 'debit_card', 80.00);
-- Day -18
INSERT INTO orders (customer_id, created_at, status, channel)
VALUES (
           11,
           CURRENT_TIMESTAMP - INTERVAL '18 days',
           'completed',
           'mobile'
       ),
       (
           3,
           CURRENT_TIMESTAMP - INTERVAL '18 days',
           'completed',
           'in-store'
       );
INSERT INTO order_items (order_id, product_id, qty, unit_price)
VALUES (13, 2, 1, 45.00),
       (13, 12, 1, 55.00),
       (14, 16, 1, 65.00),
       (14, 8, 1, 35.00);
INSERT INTO payments (order_id, method, paid_amount)
VALUES (13, 'digital_wallet', 100.00),
       (14, 'cash', 100.00);
-- Day -15
INSERT INTO orders (customer_id, created_at, status, channel)
VALUES (
           12,
           CURRENT_TIMESTAMP - INTERVAL '15 days',
           'completed',
           'in-store'
       ),
       (
           13,
           CURRENT_TIMESTAMP - INTERVAL '15 days',
           'completed',
           'online'
       ),
       (
           4,
           CURRENT_TIMESTAMP - INTERVAL '15 days',
           'completed',
           'in-store'
       ),
       (
           14,
           CURRENT_TIMESTAMP - INTERVAL '15 days',
           'completed',
           'mobile'
       );
INSERT INTO order_items (order_id, product_id, qty, unit_price)
VALUES (15, 1, 2, 35.00),
       (15, 14, 2, 20.00),
       (16, 6, 1, 55.00),
       (16, 13, 1, 35.00),
       (17, 19, 1, 70.00),
       (17, 3, 1, 45.00),
       (18, 20, 1, 55.00),
       (18, 1, 1, 35.00);
INSERT INTO payments (order_id, method, paid_amount)
VALUES (15, 'cash', 110.00),
       (16, 'credit_card', 90.00),
       (17, 'transfer', 115.00),
       (18, 'digital_wallet', 90.00);
-- Day -12
INSERT INTO orders (customer_id, created_at, status, channel)
VALUES (
           15,
           CURRENT_TIMESTAMP - INTERVAL '12 days',
           'completed',
           'in-store'
       ),
       (
           5,
           CURRENT_TIMESTAMP - INTERVAL '12 days',
           'completed',
           'online'
       ),
       (
           1,
           CURRENT_TIMESTAMP - INTERVAL '12 days',
           'completed',
           'in-store'
       );
INSERT INTO order_items (order_id, product_id, qty, unit_price)
VALUES (19, 2, 2, 45.00),
       (19, 10, 1, 25.00),
       (20, 18, 1, 85.00),
       (20, 11, 1, 30.00),
       (21, 7, 2, 50.00),
       (21, 17, 3, 15.00);
INSERT INTO payments (order_id, method, paid_amount)
VALUES (19, 'debit_card', 115.00),
       (20, 'credit_card', 115.00),
       (21, 'cash', 145.00);
-- Day -10
INSERT INTO orders (customer_id, created_at, status, channel)
VALUES (
           6,
           CURRENT_TIMESTAMP - INTERVAL '10 days',
           'completed',
           'mobile'
       ),
       (
           7,
           CURRENT_TIMESTAMP - INTERVAL '10 days',
           'completed',
           'in-store'
       ),
       (
           8,
           CURRENT_TIMESTAMP - INTERVAL '10 days',
           'completed',
           'online'
       );
INSERT INTO order_items (order_id, product_id, qty, unit_price)
VALUES (22, 1, 1, 35.00),
       (22, 12, 1, 55.00),
       (23, 15, 1, 45.00),
       (23, 14, 2, 20.00),
       (24, 6, 1, 55.00),
       (24, 13, 1, 35.00);
INSERT INTO payments (order_id, method, paid_amount)
VALUES (22, 'digital_wallet', 90.00),
       (23, 'cash', 85.00),
       (24, 'credit_card', 90.00);
-- Day -8
INSERT INTO orders (customer_id, created_at, status, channel)
VALUES (
           9,
           CURRENT_TIMESTAMP - INTERVAL '8 days',
           'completed',
           'in-store'
       ),
       (
           10,
           CURRENT_TIMESTAMP - INTERVAL '8 days',
           'completed',
           'in-store'
       ),
       (
           11,
           CURRENT_TIMESTAMP - INTERVAL '8 days',
           'completed',
           'mobile'
       ),
       (
           2,
           CURRENT_TIMESTAMP - INTERVAL '8 days',
           'completed',
           'online'
       );
INSERT INTO order_items (order_id, product_id, qty, unit_price)
VALUES (25, 2, 1, 45.00),
       (25, 10, 1, 25.00),
       (26, 19, 1, 70.00),
       (26, 1, 2, 35.00),
       (27, 3, 1, 45.00),
       (27, 11, 1, 30.00),
       (28, 16, 1, 65.00),
       (28, 8, 1, 35.00);
INSERT INTO payments (order_id, method, paid_amount)
VALUES (25, 'cash', 70.00),
       (26, 'transfer', 140.00),
       (27, 'debit_card', 75.00),
       (28, 'credit_card', 100.00);
-- Day -5
INSERT INTO orders (customer_id, created_at, status, channel)
VALUES (
           12,
           CURRENT_TIMESTAMP - INTERVAL '5 days',
           'completed',
           'in-store'
       ),
       (
           13,
           CURRENT_TIMESTAMP - INTERVAL '5 days',
           'completed',
           'mobile'
       ),
       (
           14,
           CURRENT_TIMESTAMP - INTERVAL '5 days',
           'completed',
           'in-store'
       ),
       (
           3,
           CURRENT_TIMESTAMP - INTERVAL '5 days',
           'completed',
           'online'
       ),
       (
           15,
           CURRENT_TIMESTAMP - INTERVAL '5 days',
           'completed',
           'in-store'
       );
INSERT INTO order_items (order_id, product_id, qty, unit_price)
VALUES (29, 1, 3, 35.00),
       (29, 14, 4, 20.00),
       (30, 6, 2, 55.00),
       (30, 12, 1, 55.00),
       (31, 18, 1, 85.00),
       (31, 2, 1, 45.00),
       (32, 20, 1, 55.00),
       (32, 17, 2, 15.00),
       (33, 7, 1, 50.00),
       (33, 13, 1, 35.00);
INSERT INTO payments (order_id, method, paid_amount)
VALUES (29, 'cash', 185.00),
       (30, 'digital_wallet', 165.00),
       (31, 'credit_card', 130.00),
       (32, 'debit_card', 85.00),
       (33, 'cash', 85.00);
-- Day -3
INSERT INTO orders (customer_id, created_at, status, channel)
VALUES (
           1,
           CURRENT_TIMESTAMP - INTERVAL '3 days',
           'completed',
           'in-store'
       ),
       (
           4,
           CURRENT_TIMESTAMP - INTERVAL '3 days',
           'completed',
           'mobile'
       ),
       (
           5,
           CURRENT_TIMESTAMP - INTERVAL '3 days',
           'completed',
           'online'
       ),
       (
           6,
           CURRENT_TIMESTAMP - INTERVAL '3 days',
           'completed',
           'in-store'
       ),
       (
           7,
           CURRENT_TIMESTAMP - INTERVAL '3 days',
           'completed',
           'in-store'
       );
INSERT INTO order_items (order_id, product_id, qty, unit_price)
VALUES (34, 2, 2, 45.00),
       (34, 10, 2, 25.00),
       (35, 15, 1, 45.00),
       (35, 11, 1, 30.00),
       (36, 19, 1, 70.00),
       (36, 3, 1, 45.00),
       (37, 1, 2, 35.00),
       (37, 17, 3, 15.00),
       (38, 6, 1, 55.00),
       (38, 12, 1, 55.00);
INSERT INTO payments (order_id, method, paid_amount)
VALUES (34, 'cash', 140.00),
       (35, 'credit_card', 75.00),
       (36, 'transfer', 115.00),
       (37, 'digital_wallet', 115.00),
       (38, 'debit_card', 110.00);
-- Day -1
INSERT INTO orders (customer_id, created_at, status, channel)
VALUES (
           8,
           CURRENT_TIMESTAMP - INTERVAL '1 day',
           'completed',
           'mobile'
       ),
       (
           9,
           CURRENT_TIMESTAMP - INTERVAL '1 day',
           'completed',
           'in-store'
       ),
       (
           10,
           CURRENT_TIMESTAMP - INTERVAL '1 day',
           'completed',
           'online'
       ),
       (
           11,
           CURRENT_TIMESTAMP - INTERVAL '1 day',
           'completed',
           'in-store'
       ),
       (
           12,
           CURRENT_TIMESTAMP - INTERVAL '1 day',
           'completed',
           'in-store'
       ),
       (
           13,
           CURRENT_TIMESTAMP - INTERVAL '1 day',
           'completed',
           'mobile'
       );
INSERT INTO order_items (order_id, product_id, qty, unit_price)
VALUES (39, 1, 2, 35.00),
       (39, 14, 2, 20.00),
       (40, 18, 1, 85.00),
       (40, 2, 1, 45.00),
       (41, 7, 1, 50.00),
       (41, 13, 1, 35.00),
       (42, 16, 1, 65.00),
       (42, 8, 1, 35.00),
       (43, 3, 2, 45.00),
       (43, 10, 1, 25.00),
       (44, 6, 1, 55.00),
       (44, 11, 2, 30.00);
INSERT INTO payments (order_id, method, paid_amount)
VALUES (39, 'cash', 110.00),
       (40, 'credit_card', 130.00),
       (41, 'digital_wallet', 85.00),
       (42, 'debit_card', 100.00),
       (43, 'cash', 115.00),
       (44, 'transfer', 115.00);
-- Today
INSERT INTO orders (customer_id, created_at, status, channel)
VALUES (
           14,
           CURRENT_TIMESTAMP - INTERVAL '4 hours',
           'completed',
           'in-store'
       ),
       (
           15,
           CURRENT_TIMESTAMP - INTERVAL '3 hours',
           'completed',
           'mobile'
       ),
       (
           1,
           CURRENT_TIMESTAMP - INTERVAL '2 hours',
           'completed',
           'online'
       ),
       (
           2,
           CURRENT_TIMESTAMP - INTERVAL '1 hour',
           'completed',
           'in-store'
       ),
       (
           3,
           CURRENT_TIMESTAMP - INTERVAL '30 minutes',
           'completed',
           'in-store'
       ),
       (
           4,
           CURRENT_TIMESTAMP - INTERVAL '15 minutes',
           'pending',
           'mobile'
       );
INSERT INTO order_items (order_id, product_id, qty, unit_price)
VALUES (45, 2, 1, 45.00),
       (45, 12, 1, 55.00),
       (46, 19, 1, 70.00),
       (46, 1, 1, 35.00),
       (47, 20, 1, 55.00),
       (47, 17, 2, 15.00),
       (48, 6, 2, 55.00),
       (48, 13, 1, 35.00),
       (49, 18, 1, 85.00),
       (49, 11, 1, 30.00),
       (50, 15, 1, 45.00),
       (50, 14, 2, 20.00);
INSERT INTO payments (order_id, method, paid_amount)
VALUES (45, 'credit_card', 100.00),
       (46, 'cash', 105.00),
       (47, 'digital_wallet', 85.00),
       (48, 'debit_card', 145.00),
       (49, 'transfer', 115.00);