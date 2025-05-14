-- Create the ecommerce database
CREATE DATABASE IF NOT EXISTS ecommerce;
USE ecommerce;

-- Create customers table
CREATE TABLE customers (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    address TEXT NOT NULL
);

-- Create products table
CREATE TABLE products (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    price DECIMAL(10, 2) NOT NULL,
    description TEXT
);

-- Create orders table
CREATE TABLE orders (
    id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT,
    order_date DATE NOT NULL,
    total_amount DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (customer_id) REFERENCES customers(id)
);

-- Create order_items table
CREATE TABLE order_items (
    id INT PRIMARY KEY AUTO_INCREMENT,
    order_id INT,
    product_id INT,
    quantity INT NOT NULL,
    unit_price DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (order_id) REFERENCES orders(id),
    FOREIGN KEY (product_id) REFERENCES products(id)
);

-- Insert sample data into customers table
INSERT INTO customers (name, email, address) VALUES
('John Doe', 'john@example.com', '123 Main St, City'),
('Jane Smith', 'jane@example.com', '456 Oak Ave, Town'),
('Bob Wilson', 'bob@example.com', '789 Pine Rd, Village');

-- Insert sample data into products table
INSERT INTO products (name, price, description) VALUES
('Product A', 99.99, 'High-quality product A'),
('Product B', 149.99, 'Premium product B'),
('Product C', 29.99, 'Budget-friendly product C'),
('Product D', 199.99, 'Luxury product D'),
('Product E', 79.99, 'Mid-range product E');

-- Insert sample data into orders table
INSERT INTO orders (customer_id, order_date, total_amount) VALUES
(1, '2024-01-15', 199.98),
(2, '2024-01-20', 149.99),
(3, '2024-01-25', 109.98),
(1, '2024-02-01', 279.98);

-- Insert sample order items
INSERT INTO order_items (order_id, product_id, quantity, unit_price) VALUES
(1, 1, 2, 99.99),  -- Product A
(2, 2, 1, 149.99), -- Product B
(3, 1, 1, 99.99),  -- Product A
(4, 4, 1, 199.99); -- Product D

-- Add discount column to products table
ALTER TABLE products
ADD COLUMN discount DECIMAL(5, 2) DEFAULT 0.00;

-- Update Product C price
UPDATE products
SET price = 45.00
WHERE name = 'Product C';

-- Query 1: Retrieve customers who placed orders in last 30 days
SELECT DISTINCT c.*
FROM customers c
JOIN orders o ON c.id = o.customer_id
WHERE o.order_date >= DATE_SUB(CURDATE(), INTERVAL 30 DAY);

-- Query 2: Get total amount of orders by each customer
SELECT c.name, SUM(o.total_amount) as total_spent
FROM customers c
LEFT JOIN orders o ON c.id = o.customer_id
GROUP BY c.id, c.name;

-- Query 3: Get top 3 products with highest price
SELECT *
FROM products
ORDER BY price DESC
LIMIT 3;

-- Query 4: Get customers who ordered Product A
SELECT DISTINCT c.name
FROM customers c
JOIN orders o ON c.id = o.customer_id
JOIN order_items oi ON o.id = oi.order_id
JOIN products p ON oi.product_id = p.id
WHERE p.name = 'Product A';

-- Query 5: Join orders and customers for name and order date
SELECT c.name, o.order_date
FROM orders o
JOIN customers c ON o.customer_id = c.id;

-- Query 6: Get orders with total amount > 150
SELECT *
FROM orders
WHERE total_amount > 150.00;

-- Query 7: Get average order total
SELECT AVG(total_amount) as average_order_total
FROM orders;