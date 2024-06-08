-- Create database
CREATE DATABASE dblab;

-- Use the database
USE dblab;

-- Create employees table
CREATE TABLE employees (
    Employee_ID INT PRIMARY KEY,
    First_Name VARCHAR(50),
    Last_Name VARCHAR(50),
    Email VARCHAR(100),
    Phone_No VARCHAR(20),
    Hire_Date DATE,
    Job_ID VARCHAR(20),
    Salary DECIMAL(10, 2),
    Commission_PCT DECIMAL(4, 2),
    Manager_ID INT,
    Department_ID INT
);

-- Create department table
CREATE TABLE department (
    Department_ID INT PRIMARY KEY,
    Department_Name VARCHAR(100),
    Manager_ID INT,
    Location_ID INT
);

-- Create location table
CREATE TABLE location (
    Location_ID INT PRIMARY KEY,
    Street_Address VARCHAR(255),
    Postal_Code VARCHAR(20),
    City VARCHAR(100),
    State_Province VARCHAR(100),
    Country_ID CHAR(2)
);

-- Create countries table
CREATE TABLE countries (
    Country_ID CHAR(2) PRIMARY KEY,
    Country_Name VARCHAR(100),
    Region_ID INT
);

-- Create job_history table
CREATE TABLE job_history (
    Employee_ID INT,
    Start_Date DATE,
    End_Date DATE,
    Job_ID VARCHAR(20),
    Department_ID INT,
    PRIMARY KEY (Employee_ID, Start_Date),
    FOREIGN KEY (Employee_ID) REFERENCES employees(Employee_ID),
    FOREIGN KEY (Job_ID) REFERENCES jobs(Job_ID),
    FOREIGN KEY (Department_ID) REFERENCES department(Department_ID)
);

-- Create jobs table
CREATE TABLE jobs (
    Job_ID VARCHAR(20) PRIMARY KEY,
    Job_Title VARCHAR(100),
    Min_Salary DECIMAL(10, 2),
    Max_Salary DECIMAL(10, 2)
);
-- Insert Pakistani employee data into employees table
INSERT INTO employees (Employee_ID, First_Name, Last_Name, Email, Phone_No, Hire_Date, Job_ID, Salary, Commission_PCT, Manager_ID, Department_ID)
VALUES
    (4, 'Ali', 'Khan', 'ali.khan@example.com', '123-456-7891', '2021-05-10', 'IT_PROG', 55000.00, NULL, 1, 1),
    (5, 'Fatima', 'Ahmed', 'fatima.ahmed@example.com', '987-654-3211', '2021-06-20', 'HR_REP', 50000.00, 0.05, 2, 2),
    (6, 'Muhammad', 'Iqbal', 'muhammad.iqbal@example.com', '555-555-5556', '2021-07-15', 'SA_REP', 65000.00, 0.10, 3, 3),
    (7, 'Ayesha', 'Raza', 'ayesha.raza@example.com', '123-456-7892', '2021-08-01', 'IT_PROG', 60000.00, NULL, 1, 1),
    (8, 'Sajid', 'Ali', 'sajid.ali@example.com', '987-654-3212', '2021-09-10', 'HR_REP', 55000.00, 0.05, 2, 2),
    (9, 'Sana', 'Khan', 'sana.khan@example.com', '555-555-5557', '2021-10-15', 'SA_REP', 70000.00, 0.10, 3, 3),
    (10, 'Hassan', 'Ahmed', 'hassan.ahmed@example.com', '123-456-7893', '2021-11-01', 'IT_PROG', 65000.00, NULL, 1, 1),
    (11, 'Amina', 'Zafar', 'amina.zafar@example.com', '987-654-3213', '2021-12-10', 'HR_REP', 60000.00, 0.05, 2, 2),
    (12, 'Bilal', 'Malik', 'bilal.malik@example.com', '555-555-5558', '2022-01-15', 'SA_REP', 75000.00, 0.10, 3, 3),
    (13, 'Mariam', 'Abbas', 'mariam.abbas@example.com', '123-456-7894', '2022-02-01', 'IT_PROG', 70000.00, NULL, 1, 1);

-- Insert Pakistani department data into department table
INSERT INTO department (Department_ID, Department_Name, Manager_ID, Location_ID)
VALUES
    (4, 'Engineering', 4, 1),
    (5, 'Finance', 5, 2),
    (6, 'Marketing', 6, 3),
    (7, 'Operations', 7, 1),
    (8, 'Research', 8, 2),
    (9, 'Customer Service', 9, 3),
    (10, 'Sales', 10, 1),
    (11, 'Human Resources', 11, 2),
    (12, 'IT Support', 12, 3),
    (13, 'Quality Assurance', 13, 1);
    
    -- Insert Pakistani location data into location table
INSERT INTO location (Location_ID, Street_Address, Postal_Code, City, State_Province, Country_ID)
VALUES
    (4, '123 Liberty Avenue', '74000', 'Lahore', 'Punjab', 'PK'),
    (5, '456 Karachi Street', '75400', 'Karachi', 'Sindh', 'PK'),
    (6, '789 Islamabad Road', '44000', 'Islamabad', 'Capital Territory', 'PK'),
    (7, '321 Peshawar Boulevard', '25000', 'Peshawar', 'Khyber Pakhtunkhwa', 'PK'),
    (8, '654 Quetta Lane', '87300', 'Quetta', 'Balochistan', 'PK'),
    (9, '987 Multan Circle', '60000', 'Multan', 'Punjab', 'PK'),
    (10, '741 Faisalabad Avenue', '38000', 'Faisalabad', 'Punjab', 'PK'),
    (11, '963 Rawalpindi Street', '46000', 'Rawalpindi', 'Punjab', 'PK'),
    (12, '852 Hyderabad Road', '71000', 'Hyderabad', 'Sindh', 'PK'),
    (13, '159 Gujranwala Lane', '52250', 'Gujranwala', 'Punjab', 'PK');
-- Insert data for ten countries into the countries table
INSERT INTO countries (Country_ID, Country_Name, Region_ID)
VALUES
    ('PK', 'Pakistan', 3),
    ('IN', 'India', 3),
    ('BD', 'Bangladesh', 3),
    ('LK', 'Sri Lanka', 3),
    ('NP', 'Nepal', 3),
    ('AF', 'Afghanistan', 3),
    ('IR', 'Iran', 4),
    ('IQ', 'Iraq', 4),
    ('SA', 'Saudi Arabia', 4),
    ('TR', 'Turkey', 5);
-- Insert data into jobs table
INSERT INTO jobs (Job_ID, Job_Title, Min_Salary, Max_Salary)
VALUES
    ('IT_PROG', 'IT Programmer', 50000.00, 100000.00),
    ('HR_REP', 'HR Representative', 45000.00, 90000.00),
    ('SA_REP', 'Sales Representative', 60000.00, 120000.00);

-- Insert data into job_history table
INSERT INTO job_history (Employee_ID, Start_Date, End_Date, Job_ID, Department_ID)
VALUES
    (1, '2020-01-01', '2022-01-01', 'IT_PROG', 1),
    (2, '2020-02-15', '2022-02-15', 'HR_REP', 2),
    (3, '2020-03-20', NULL, 'SA_REP', 3);


-- Insert data into employees table
INSERT INTO employees (Employee_ID, First_Name, Last_Name, Email, Phone_No, Hire_Date, Job_ID, Salary, Commission_PCT, Manager_ID, Department_ID)
VALUES
    (1, 'John', 'Doe', 'john.doe@example.com', '123-456-7890', '2020-01-01', 'IT_PROG', 50000.00, NULL, NULL, 1),
    (2, 'Jane', 'Smith', 'jane.smith@example.com', '987-654-3210', '2020-02-15', 'HR_REP', 45000.00, 0.05, 1, 2),
    (3, 'Michael', 'Johnson', 'michael.johnson@example.com', '555-555-5555', '2020-03-20', 'SA_REP', 60000.00, 0.10, 1, 3);

-- Insert data into department table
INSERT INTO department (Department_ID, Department_Name, Manager_ID, Location_ID)
VALUES
    (1, 'IT', 1, 1),
    (2, 'HR', 2, 2),
    (3, 'Sales', 3, 3);

-- Insert data into location table
INSERT INTO location (Location_ID, Street_Address, Postal_Code, City, State_Province, Country_ID)
VALUES
    (1, '123 Main St', '12345', 'New York', 'NY', 'US'),
    (2, '456 Elm St', '54321', 'Los Angeles', 'CA', 'US'),
    (3, '789 Oak St', '98765', 'Chicago', 'IL', 'US');

-- Insert data into countries table
INSERT INTO countries (Country_ID, Country_Name, Region_ID)
VALUES
    ('US', 'United States', 1);

-- Insert data into job_history table
INSERT INTO job_history (Employee_ID, Start_Date, End_Date, Job_ID, Department_ID)
VALUES
    (1, '2020-01-01', '2022-01-01', 'IT_PROG', 1),
    (2, '2020-02-15', '2022-02-15', 'HR_REP', 2),
    (3, '2020-03-20', NULL, 'SA_REP', 3);

-- Insert data into jobs table
INSERT INTO jobs (Job_ID, Job_Title, Min_Salary, Max_Salary)
VALUES
    ('IT_PROG', 'IT Programmer', 50000.00, 100000.00),
    ('HR_REP', 'HR Representative', 45000.00, 90000.00),
    ('SA_REP', 'Sales Representative', 60000.00, 120000.00);

SELECT 
    Employee_ID,
    CONCAT(First_Name, ' ', Last_Name) AS Employee_Name,
    Salary AS Original_Salary,
    (
        SELECT Department_Name 
        FROM department 
        WHERE Department_ID = employees.Department_ID
    ) AS Department,
    (Salary + 2000) AS Increased_Salary
FROM 
    employees;
