-- Create database schema for an E-Commerce Tracking application
CREATE TABLE Customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(50) NOT NULL,
    city VARCHAR(30)
);

CREATE TABLE Orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    order_amount DECIMAL(10, 2),
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
);

-- Seeding relational records
INSERT INTO Customers VALUES (101, 'Aditya', 'Hyderabad');
INSERT INTO Customers VALUES (102, 'Suhas', 'Bangalore');
INSERT INTO Customers VALUES (103, 'Bandi', 'Mumbai');

INSERT INTO Orders VALUES (5001, 101, '2026-05-10', 1200.50);
INSERT INTO Orders VALUES (5002, 101, '2026-05-12', 450.00);
INSERT INTO Orders VALUES (5003, 102, '2026-05-15', 3100.00);
INSERT INTO Orders VALUES (5004, 103, '2026-05-16', 150.25);

-- Complex Query 1: Total money spent per customer using JOIN and GROUP BY
SELECT c.customer_name, c.city, COUNT(o.order_id) AS total_orders_placed, SUM(o.order_amount) AS total_revenue
FROM Customers c
LEFT JOIN Orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_name, c.city;

-- Complex Query 2: Subquery to find all orders that are priced above the company's average order value
SELECT order_id, customer_id, order_amount 
FROM Orders 
WHERE order_amount > (SELECT AVG(order_amount) FROM Orders);
