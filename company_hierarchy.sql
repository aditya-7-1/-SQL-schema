-- Create database schema for Corporate Hierarchy management
CREATE TABLE Departments (
    dept_id INT PRIMARY KEY,
    dept_name VARCHAR(50) NOT NULL,
    location VARCHAR(30)
);

CREATE TABLE Employees (
    emp_id INT PRIMARY KEY,
    emp_name VARCHAR(50) NOT NULL,
    dept_id INT,
    manager_id INT,
    salary DECIMAL(10, 2),
    FOREIGN KEY (dept_id) REFERENCES Departments(dept_id),
    FOREIGN KEY (manager_id) REFERENCES Employees(emp_id)
);

-- Seeding relational data
INSERT INTO Departments VALUES (10, 'Engineering', 'Hyderabad');
INSERT INTO Departments VALUES (20, 'Product', 'Bangalore');

-- Seeding Managers first, then team members
INSERT INTO Employees VALUES (1, 'Aditya', 10, NULL, 95000.00);  -- Top Manager
INSERT INTO Employees VALUES (2, 'Suhas', 10, 1, 75000.00);     -- Reports to Aditya
INSERT INTO Employees VALUES (3, 'Bandi', 20, NULL, 88000.00);  -- Product Manager
INSERT INTO Employees VALUES (4, 'Rahul', 10, 1, 60000.00);     -- Reports to Aditya

-- Complex Query 1: Self-Join to display Employee alongside their Manager's name
SELECT e.emp_name AS employee_name, m.emp_name AS reports_to, d.dept_name
FROM Employees e
LEFT JOIN Employees m ON e.manager_id = m.emp_id
INNER JOIN Departments d ON e.dept_id = d.dept_id;

-- Complex Query 2: Find departments where the average salary is above 70,000
SELECT d.dept_name, COUNT(e.emp_id) AS total_employees, AVG(e.salary) AS average_department_salary
FROM Departments d
INNER JOIN Employees e ON d.dept_id = e.dept_id
GROUP BY d.dept_name
HAVING AVG(e.salary) > 70000;
