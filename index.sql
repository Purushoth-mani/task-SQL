CREATE DATABASE ECOMMERCE;
USE ECOMMERCE;

CREATE TABLE customers (
    id INT NOT NULL AUTO_INCREMENT,
    name VARCHAR(225) NOT NULL,
    email VARCHAR(225) NOT NULL,
    address VARCHAR(225) NOT NULL,
    PRIMARY KEY (id)
);

CREATE TABLE orders (
    id INT NOT NULL AUTO_INCREMENT,
    customer_id INT NOT NULL,
    order_date DATE NOT NULL,
    total_amount DECIMAL(10, 2) NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (customer_id) REFERENCES customers(id)
);

CREATE TABLE products (
    id INT NOT NULL AUTO_INCREMENT,
    name VARCHAR(225) NOT NULL,
    price DECIMAL(10, 2) NOT NULL,
    description VARCHAR(225) NOT NULL,
    PRIMARY KEY (id)
);


INSERT INTO customers (name , email ,address )
VALUES     ('Alice Johnson', 'alice.johnson@example.com', '123 Main St, Springfield'),
    ('Bob Smith', 'bob.smith@example.com', '456 Elm St, Shelbyville'),
    ('Charlie Brown', 'charlie.brown@example.com', '789 Oak St, Capital City'),
    ('Diana Prince', 'diana.prince@example.com', '101 Paradise Island, Themyscira'),
    ('Ethan Hunt', 'ethan.hunt@example.com', '777 Spy Lane, Mission City'),
    ('Fiona Gallagher', 'fiona.gallagher@example.com', '999 South Side, Chicago'),
    ('George Clooney', 'george.clooney@example.com', '444 Hollywood Blvd, Los Angeles'),
    ('Helen Parr', 'helen.parr@example.com', '202 Super Lane, Metroville'),
    ('Ian Fleming', 'ian.fleming@example.com', '555 Writer\'s Block, London'),
    ('Jennifer Lopez', 'jennifer.lopez@example.com', '888 Fame Ave, New York City');
    
INSERT INTO orders (customer_id, order_date, total_amount)
VALUES
    (1, '2025-01-15', 1500.00),
    (2, '2025-01-16', 2499.99),
    (3, '2025-01-17', 799.50),
    (4, '2025-01-18', 1199.99),
    (5, '2025-01-19', 450.75),
    (6, '2025-01-20', 2999.00),
    (7, '2025-01-21', 1599.95),
    (8, '2025-01-22', 850.00),
    (9, '2025-01-23', 1275.45),
    (10, '2025-01-24', 349.99);

    
    
INSERT INTO products (name, price, description)
VALUES
    ('Smartphone', 500, 'Latest model with 6.5-inch display, 128GB storage'),
    ('Laptop', 1200, 'High-performance laptop with 16GB RAM and 512GB SSD'),
    ('Wireless Headphones', 150, 'Noise-cancelling headphones with Bluetooth connectivity'),
    ('Smartwatch', 200, 'Water-resistant smartwatch with fitness tracking'),
    ('Tablet', 350, '10-inch tablet with high resolution and long battery life'),
    ('Bluetooth Speaker', 100, 'Portable Bluetooth speaker with rich sound quality'),
    ('Camera', 800, 'Digital camera with 4K video recording and 20MP resolution'),
    ('Action Figure', 50, 'Collectible action figure with movable parts'),
    ('Gaming Console', 400, 'Next-gen gaming console with 4K gaming support'),
    ('Smart TV', 700, '55-inch Smart TV with 4K resolution and smart features');
    
    
    
-- 1. Retrieve all customers who have placed an order in the last 30 days.
SELECT c.id, c.name, c.email, c.address
FROM customers c
JOIN orders o ON c.id = o.customer_id
WHERE o.order_date >= CURDATE() - INTERVAL 30 DAY;

-- 2. Get the total amount of all orders placed by each customer.
SELECT c.id, c.name, SUM(o.total_amount) AS total_spent
FROM customers c
JOIN orders o ON c.id = o.customer_id
GROUP BY c.id;

-- 3. Update the price of Product C to 45.00.
UPDATE products
SET price = 45.00
WHERE name = 'Product C';

-- 4. Add a new column `discount` to the `products` table.
ALTER TABLE products
ADD COLUMN discount DECIMAL(5,2) DEFAULT 0.00;

-- 5. Retrieve the top 3 products with the highest price.
SELECT id, name, price
FROM products
ORDER BY price DESC
LIMIT 3;

-- 6. Get the names of customers who have ordered Product A.
SELECT DISTINCT c.name
FROM customers c
JOIN orders o ON c.id = o.customer_id
JOIN order_items oi ON o.id = oi.order_id
JOIN products p ON oi.product_id = p.id
WHERE p.name = 'Product A';

-- 7. Join the orders and customers tables to retrieve the customer's name and order date for each order.
SELECT c.name, o.order_date
FROM customers c
JOIN orders o ON c.id = o.customer_id;

-- 8. Retrieve the orders with a total amount greater than 150.00.
SELECT * 
FROM orders
WHERE total_amount > 150.00;

-- 9. Normalize the database by creating a separate table for order items and updating the orders table to reference the `order_items` table.

-- Step 1: Create the `order_items` table.
CREATE TABLE order_items (
    id INT NOT NULL AUTO_INCREMENT,
    order_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT NOT NULL,
    price DECIMAL(10, 2) NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (order_id) REFERENCES orders(id),
    FOREIGN KEY (product_id) REFERENCES products(id)
);

-- Step 2: Update the `orders` table to remove product details (if they exist) and reference the `order_items` table.

-- 10. Retrieve the average total of all orders.
SELECT AVG(total_amount) AS average_order_total
FROM orders;


    
    
    

    
