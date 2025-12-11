CREATE TABLE customer (
    customer_id SERIAL PRIMARY KEY,
    full_name VARCHAR(100),
    email VARCHAR(100),
    phone VARCHAR(15)
);

CREATE TABLE orders (
    order_id SERIAL PRIMARY KEY,
    customer_id INT REFERENCES customer(customer_id),
    total_amount DECIMAL(10,2),
    order_date DATE
);

CREATE VIEW v_order_summary AS
SELECT 
    c.full_name,
    o.total_amount,
    o.order_date
FROM orders o
JOIN customer c ON o.customer_id = c.customer_id;

SELECT * FROM v_order_summary;

UPDATE orders
SET total_amount = total_amount + 10000
WHERE order_id IN (SELECT order_id FROM orders);

CREATE VIEW v_monthly_sales AS
SELECT 
    DATE_TRUNC('month', order_date) AS month,
    SUM(total_amount) AS total_sales
FROM orders
GROUP BY DATE_TRUNC('month', order_date)
ORDER BY month;

DROP VIEW v_order_summary;
DROP VIEW v_monthly_sales;
