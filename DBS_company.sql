-- SQLBook: Code
CREATE DATABASE company;
USE company;
SET FOREIGN_KEY_CHECKS = 0;

CREATE TABLE Companies (
    company_id INT PRIMARY KEY AUTO_INCREMENT,
    company_name VARCHAR(50) NOT NULL UNIQUE,
    industry VARCHAR(50),
    company_type VARCHAR(50) NOT NULL,  
    founding_date DATE,
    ceo_employee_id INT
);

CREATE TABLE Departments (
    department_id INT PRIMARY KEY AUTO_INCREMENT,
    company_id INT NOT NULL,
    department_name VARCHAR(50) NOT NULL UNIQUE,
    head_employee_id INT,
    main_location_id INT,
    FOREIGN KEY (company_id) REFERENCES Companies(company_id) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (main_location_id) REFERENCES Locations(location_id) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE Employees (
    employee_id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    hire_date DATE NOT NULL,
    job_title VARCHAR(50),
    salary DECIMAL(10, 2),
    department_id INT,
    manager_id INT,
    current_location_id INT,
    status VARCHAR(20) DEFAULT 'Active' NOT NULL, 
    FOREIGN KEY (department_id) REFERENCES Departments(department_id) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (manager_id) REFERENCES Employees(employee_id) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (current_location_id) REFERENCES Locations(location_id) ON DELETE CASCADE ON UPDATE CASCADE
);

ALTER TABLE Companies ADD FOREIGN KEY (ceo_employee_id) REFERENCES Employees(employee_id) ON DELETE SET NULL ON UPDATE CASCADE;

ALTER TABLE Departments ADD FOREIGN KEY (head_employee_id) REFERENCES Employees(employee_id) ON DELETE SET NULL ON UPDATE CASCADE;

CREATE TABLE Locations (
    location_id INT PRIMARY KEY AUTO_INCREMENT,
    company_id INT NOT NULL,
    address_line1 VARCHAR(50) NOT NULL,
    city VARCHAR(50) NOT NULL,
    state_province VARCHAR(50),
    country VARCHAR(50) NOT NULL,
    FOREIGN KEY (company_id) REFERENCES Companies(company_id) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE Products (
    product_id INT PRIMARY KEY AUTO_INCREMENT,
    company_id INT NOT NULL,
    product_name VARCHAR(50) NOT NULL,
    category VARCHAR(50),
    unit_price DECIMAL(10, 2),
    launch_date DATE,
    FOREIGN KEY (company_id) REFERENCES Companies(company_id) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE ServiceRecords (
    service_id INT PRIMARY KEY AUTO_INCREMENT,
    employee_id INT NOT NULL,
    product_id INT,
    service_type VARCHAR(50) NOT NULL,  
    FOREIGN KEY (employee_id) REFERENCES Employees(employee_id)
        ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (product_id) REFERENCES Products(product_id)
        ON DELETE SET NULL ON UPDATE CASCADE
);

CREATE TABLE Websites (
    website_id INT PRIMARY KEY AUTO_INCREMENT,
    company_id INT NOT NULL,
    url VARCHAR(100) NOT NULL UNIQUE,
    website_type VARCHAR(50) NOT NULL,  
    last_updated_date DATE,
    FOREIGN KEY (company_id) REFERENCES Companies(company_id) ON DELETE CASCADE ON UPDATE CASCADE
);
SET FOREIGN_KEY_CHECKS = 1;
