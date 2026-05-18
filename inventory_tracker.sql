-- Create database schema for Inventory Tracking management
CREATE TABLE Suppliers (
    supplier_id INT PRIMARY KEY,
    supplier_name VARCHAR(50) NOT NULL,
    contact_country VARCHAR(30)
);

CREATE TABLE Products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(50) NOT NULL,
    supplier_id INT,
    stock_quantity INT,
    unit_price DECIMAL(10, 2),
    FOREIGN KEY (supplier_id) REFERENCES Suppliers(supplier_id)
);

-- Seeding relational lookup records
INSERT INTO Suppliers VALUES (501, 'TechCorp India', 'India');
INSERT INTO Suppliers VALUES (502, 'Global Imports', 'USA');

INSERT INTO Products VALUES (1001, 'Mechanical Keyboard', 501, 120, 4500.00);
INSERT INTO Products VALUES (1002, 'Gaming Mouse', 501, 8, 2500.00);
INSERT INTO Products VALUES (1003, 'UltraWide Monitor', 502, 15, 28000.00);
INSERT INTO Products VALUES (1004, 'HDMI Cable', 502, 0, 450.00);

-- Complex Query 1: Categorizing stock levels dynamically using CASE WHEN
SELECT product_name, stock_quantity, unit_price,
    CASE 
        WHEN stock_quantity = 0 THEN 'OUT OF STOCK'
        WHEN stock_quantity < 10 THEN 'CRITICAL LOW STOCK'
        ELSE 'IN STOCK'
    END AS inventory_status
FROM Products;

-- Complex Query 2: Subquery to aggregate total asset value from specific overseas suppliers
SELECT SUM(stock_quantity * unit_price) AS total_overseas_asset_value
FROM Products
WHERE supplier_id IN (
    SELECT supplier_id FROM Suppliers WHERE contact_country = 'USA'
);
