CREATE DATABASE ecommerce_db;

USE ecommerce_db;


CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    name VARCHAR(50),
    email VARCHAR(100),
    city VARCHAR(50),
    signup_date DATE
);

CREATE TABLE products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100),
    category VARCHAR(50),
    price DECIMAL(10,2),
    stock INT
);


CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    total_amount DECIMAL(10,2),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

CREATE TABLE order_items (
    order_item_id INT PRIMARY KEY,
    order_id INT,
    product_id INT,
    quantity INT,
    price DECIMAL(10,2),
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

---



CREATE TABLE payments (
    payment_id INT PRIMARY KEY,
    order_id INT,
    payment_method VARCHAR(50),
    payment_status VARCHAR(20),
    payment_date DATE,
    FOREIGN KEY (order_id) REFERENCES orders(order_id)
);

---



CREATE TABLE shipping (
    shipping_id INT PRIMARY KEY,
    order_id INT,
    shipping_status VARCHAR(50),
    delivery_date DATE,
    city VARCHAR(50),
    FOREIGN KEY (order_id) REFERENCES orders(order_id)
);

---



INSERT INTO customers VALUES
(1, 'Rahul', 'rahul@gmail.com', 'Mumbai', '2023-01-10'),
(2, 'Priya', 'priya@gmail.com', 'Pune', '2023-02-15'),
(3, 'Amit', 'amit@gmail.com', 'Delhi', '2023-03-20');



INSERT INTO products VALUES
(1, 'Laptop', 'Electronics', 50000, 10),
(2, 'Mobile', 'Electronics', 20000, 20),
(3, 'Shoes', 'Fashion', 3000, 50);



INSERT INTO orders VALUES
(1, 1, '2023-06-01', 70000),
(2, 2, '2023-06-05', 20000),
(3, 3, '2023-06-10', 3000);



INSERT INTO order_items VALUES
(1, 1, 1, 1, 50000),
(2, 1, 2, 1, 20000),
(3, 2, 2, 1, 20000),
(4, 3, 3, 1, 3000);


INSERT INTO payments VALUES
(1, 1, 'UPI', 'Completed', '2023-06-01'),
(2, 2, 'Credit Card', 'Completed', '2023-06-05'),
(3, 3, 'Cash', 'Pending', '2023-06-10');


INSERT INTO shipping VALUES
(1, 1, 'Delivered', '2023-06-03', 'Mumbai'),
(2, 2, 'Shipped', NULL, 'Pune'),
(3, 3, 'Processing', NULL, 'Delhi');


select * from customers;

-- TOTAL REVENUE
select sum(total_amount) as total_revenue
from orders;

-- TOTAL ORDERS PER CUSTOMER

select customer_id, count(order_id) as
total_orders
from orders
group by customer_id
order by total_orders desc;

-- TOP 3 SELLING PRODUCTS

SELECT p.product_name, SUM(oi.quantity) AS total_sold
FROM order_items oi
JOIN products p ON oi.product_id = p.product_id
GROUP BY p.product_name
ORDER BY total_sold DESC
LIMIT 3;
-- 4. Monthly Sales Trend
-- monthly sales trend
SELECT 
    DATE_FORMAT(order_date, '%Y-%m') AS month,
    SUM(total_amount) AS monthly_sales
FROM orders
GROUP BY month
ORDER BY month;


-- 5 Customer Lifetime Value (CLV)
SELECT 
    customer_id,
    SUM(total_amount) AS lifetime_value
FROM orders
GROUP BY customer_id
ORDER BY lifetime_value DESC;


-- 6 Repeat Customers

SELECT customer_id, COUNT(order_id) AS order_count
FROM orders
GROUP BY customer_id;

-- 7 Orders with High Value (> 1000)
SELECT *
FROM orders
WHERE total_amount > 1000;


-- 9. Average Order Value
SELECT AVG(total_amount) AS avg_order_value
FROM orders;

-- 10. Orders with Product Details (JOIN)
SELECT 
    o.order_id,
    p.product_name,
    oi.quantity,
    oi.price
FROM orders o
JOIN order_items oi
    ON o.order_id = oi.order_id
JOIN products p
    ON oi.product_id = p.product_id;
    
    -- 11. Products Never Ordered
SELECT product_name
FROM products
WHERE product_id NOT IN (
    SELECT DISTINCT product_id FROM order_items
);


-- 12  Daily Sales Report
SELECT 
    order_date,
    SUM(total_amount) AS daily_sales
FROM orders
GROUP BY order_date;
select * from products;

select * from order_items;

