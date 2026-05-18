CREATE TABLE CareTakers (
    caretaker_id INT PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    shift VARCHAR(20)
);

CREATE TABLE Vehicles (
    vehicle_id VARCHAR(10) PRIMARY KEY,
    model_name VARCHAR(50) NOT NULL,
    vehicle_type VARCHAR(20),
    caretaker_id INT,
    daily_rate DECIMAL(10, 2),
    FOREIGN KEY (caretaker_id) REFERENCES CareTakers(caretaker_id)
);

-- Insert dummy seed data for application validation
INSERT INTO CareTakers VALUES (1, 'ADITYA', 'Morning');
INSERT INTO CareTakers VALUES (2, 'SUHAS', 'Evening');
INSERT INTO CareTakers VALUES (3, 'BANDI', 'Night');

INSERT INTO Vehicles VALUES ('V101', 'Mahindra XUV700', 'SUV', 1, 3500.00);
INSERT INTO Vehicles VALUES ('V102', 'Tata Nexon', 'Compact SUV', 1, 2000.00);
INSERT INTO Vehicles VALUES ('V103', 'Hyundai i20', 'Hatchback', 2, 1500.00);
INSERT INTO Vehicles VALUES ('V104', 'Honda City', 'Sedan', 3, 2500.00);

-- Demonstration Query 1: Fetching structural ownership using INNER JOIN
SELECT v.vehicle_id, v.model_name, v.vehicle_type, c.name AS caretaker_assigned
FROM Vehicles v
INNER JOIN CareTakers c ON v.caretaker_id = c.caretaker_id;

-- Demonstration Query 2: Aggregating analytics using GROUP BY
SELECT vehicle_type, COUNT(*) AS total_count, AVG(daily_rate) AS average_rental_cost
FROM Vehicles
GROUP BY vehicle_type
HAVING AVG(daily_rate) >= 1500;
