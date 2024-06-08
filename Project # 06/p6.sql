CREATE DATABASE IF NOT EXISTS dbp6;

USE dbp6;

CREATE TABLE IF NOT EXISTS employee (
    emp_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    phone_no VARCHAR(15),
    salary DECIMAL(10, 2),
    department VARCHAR(50)
);


USE dbp6;

INSERT INTO employee (first_name, last_name, phone_no, salary, department) VALUES
('Fakhar', 'Islam', '1234567890', 50000.00, 'IT'),
('Mehwish', 'Kayani', '2345678901', 60000.00, 'HR'),
('Saifullah', 'Khan', '3456789012', 55000.00, 'Finance'),
('Munawar', 'Abbasi', '4567890123', 52000.00, 'Marketing'),
('Asma', 'Zahid', '5678901234', 48000.00, 'IT'),
('Amir', 'Ali', '6789012345', 53000.00, 'HR'),
('Sadia', 'Akhtar', '7890123456', 58000.00, 'Finance'),
('Tariq', 'Ahmed', '8901234567', 56000.00, 'Marketing'),
('Saima', 'Iqbal', '9012345678', 54000.00, 'IT'),
('Ahmed', 'Khan', '0123456789', 59000.00, 'HR');


SELECT * FROM employee;


SELECT 
    CONCAT(
        LEFT(first_name, 3), 
        UPPER(LEFT(last_name, 3)), 
        '_', 
        emp_id, 
        '@yahoo.com'
    ) AS Email
FROM 
    employee
ORDER BY 
    Email ASC;

SELECT 
    CONCAT(
        LPAD('Oracle Internet Academy', 4 + LENGTH('Muslim'), '*'),
        'Muslim',
        RPAD('', LENGTH('Youth'), '*'),
        'Youth',
        RPAD('', LENGTH('University'), '*'),
        'University'
    ) AS padded_string;

SELECT CONCAT('Oracle Internet Academy', '*', LPAD('Muslim', 12, ''), '*', LPAD('Youth', 12, ''), '*', LPAD('University', 12, ''), '**') AS padded_string;



SELECT 
  REPLACE(
    RPAD(LPAD('****', 4, '*') || 'Muslim' || RPAD(LPAD('****', 4, '*'), 4, '*') || 'Youth' || RPAD(LPAD('****', 4, '*'), 4, '*') || 'University' || RPAD(LPAD('****', 4, '*'), 4, '*'), 
    LENGTH('Oracle Internet Academy'), 
    '****Oracle Internet Academy****'
  ) 
AS padded;


SELECT 
  REPLACE(
    LPAD('****', 4, '*') || 'Muslim' || LPAD('****', 4, '*') || 'Youth' || LPAD('****', 4, '*') || 'University', 
    'Oracle Internet Academy', 
    '****Oracle Internet Academy****'
  ) AS padded;




