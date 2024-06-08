-- Step 1: Create Database
CREATE DATABASE IF NOT EXISTS project7;

-- Step 2: Use the Database
USE project7;

-- Step 3: Create Tables
-- Create departments table
CREATE TABLE departments (
    dept_no INT PRIMARY KEY,
    dept_name VARCHAR(255) NOT NULL
);

-- Create titles table
CREATE TABLE titles (
    title_id INT PRIMARY KEY,
    title_name VARCHAR(255) NOT NULL
);

-- Create employees table
CREATE TABLE employees (
    emp_no INT PRIMARY KEY,
    emp_title_id INT,
    dob DATE,
    first_name VARCHAR(255) NOT NULL,
    last_name VARCHAR(255) NOT NULL,
    sex CHAR(1),
    hire_date DATE,
    FOREIGN KEY (emp_title_id) REFERENCES titles(title_id)
);

-- Create dept_emp table
CREATE TABLE dept_emp (
    emp_no INT,
    dept_no INT,
    FOREIGN KEY (emp_no) REFERENCES employees(emp_no),
    FOREIGN KEY (dept_no) REFERENCES departments(dept_no),
    PRIMARY KEY (emp_no, dept_no)
);

-- Create dept_manager table
CREATE TABLE dept_manager (
    dept_no INT,
    emp_no INT,
    FOREIGN KEY (dept_no) REFERENCES departments(dept_no),
    FOREIGN KEY (emp_no) REFERENCES employees(emp_no),
    PRIMARY KEY (dept_no, emp_no)
);

-- Create salaries table
CREATE TABLE salaries (
    emp_no INT,
    salary DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (emp_no) REFERENCES employees(emp_no),
    PRIMARY KEY (emp_no)
);




-- Step 2: Insert Data into departments table
INSERT INTO departments (dept_no, dept_name) VALUES
(1, 'Engineering'),
(2, 'Marketing'),
(3, 'Sales'),
(4, 'Human Resources'),
(5, 'Finance'),
(6, 'Legal');

-- Step 3: Insert Data into titles table
INSERT INTO titles (title_id, title_name) VALUES
(1, 'Software Engineer'),
(2, 'Marketing Specialist'),
(3, 'Sales Manager'),
(4, 'HR Specialist'),
(5, 'Financial Analyst'),
(6, 'Legal Advisor');

-- Step 4: Insert Data into employees table
INSERT INTO employees (emp_no, emp_title_id, dob, first_name, last_name, sex, hire_date) VALUES
(101, 1, '1985-01-15', 'Fakhar', 'Islam', 'M', '2010-06-01'),
(102, 2, '1990-03-22', 'Mehwish', 'Kayani', 'F', '2012-09-15'),
(103, 3, '1987-05-10', 'Saifullah', 'Khan', 'M', '2011-11-30'),
(104, 4, '1992-07-18', 'Ayesha', 'Ahmed', 'F', '2014-02-20'),
(105, 5, '1989-09-25', 'Ali', 'Raza', 'M', '2013-04-10'),
(106, 6, '1991-11-30', 'Sara', 'Hassan', 'F', '2015-08-05'),
(107, 1, '1988-02-14', 'Imran', 'Ali', 'M', '2016-03-17');

-- Step 5: Insert Data into dept_emp table
INSERT INTO dept_emp (emp_no, dept_no) VALUES
(101, 1),
(102, 2),
(103, 3),
(104, 4),
(105, 5),
(106, 6),
(107, 1);

-- Step 6: Insert Data into dept_manager table
INSERT INTO dept_manager (dept_no, emp_no) VALUES
(1, 101),
(2, 102),
(3, 103),
(4, 104),
(5, 105),
(6, 106);

-- Step 7: Insert Data into salaries table
INSERT INTO salaries (emp_no, salary) VALUES
(101, 80000.00),
(102, 60000.00),
(103, 75000.00),
(104, 55000.00),
(105, 70000.00),
(106, 90000.00),
(107, 85000.00);


-- Question 1 
SELECT 
    e.emp_no,
    e.last_name,
    e.first_name,
    e.sex,
    s.salary
FROM 
    employees e
JOIN 
    salaries s ON e.emp_no = s.emp_no;

-- Question no 2 
SELECT 
    first_name,
    last_name,
    hire_date
FROM 
    employees
WHERE 
    YEAR(hire_date) = 1986;
    
    
    -- Question 3
    
    SELECT 
    d.dept_no,
    d.dept_name,
    dm.emp_no AS manager_emp_no,
    e.last_name,
    e.first_name
FROM 
    departments d
JOIN 
    dept_manager dm ON d.dept_no = dm.dept_no
JOIN 
    employees e ON dm.emp_no = e.emp_no;
    
    
    -- Question 4 
    
    SELECT 
    e.emp_no,
    e.last_name,
    e.first_name,
    d.dept_name
FROM 
    employees e
JOIN 
    dept_emp de ON e.emp_no = de.emp_no
JOIN 
    departments d ON de.dept_no = d.dept_no;
    
    -- Question 5 
    
    SELECT 
    first_name,
    last_name,
    sex
FROM 
    employees
WHERE 
    first_name = 'Fakhar'
    AND last_name LIKE 'I%';




-- Question 6 

SELECT 
    e.emp_no,
    e.last_name,
    e.first_name,
    e.sex AS Gender,
    s.salary
FROM 
    employees e
JOIN 
    salaries s ON e.emp_no = s.emp_no
WHERE 
    s.salary = (
        SELECT 
            MAX(salary)
        FROM 
            salaries
        WHERE 
            emp_no IN (
                SELECT 
                    emp_no
                FROM 
                    employees
                WHERE 
                    sex = e.sex
            )
    )
ORDER BY 
    e.sex;

-- Question 7 

SELECT 
    e.emp_no,
    e.last_name,
    e.first_name,
    s.salary,
    d.dept_name
FROM 
    employees e
JOIN 
    salaries s ON e.emp_no = s.emp_no
JOIN 
    dept_emp de ON e.emp_no = de.emp_no
JOIN 
    departments d ON de.dept_no = d.dept_no;


-- Question 8 

SELECT 
    e.emp_no,
    e.last_name,
    e.first_name,
    e.sex,
    e.hire_date,
    t.title_name
FROM 
    employees e
LEFT JOIN 
    titles t ON e.emp_title_id = t.title_id;
    
    -- Question 9 
    
    SELECT 
    d.dept_no,
    d.dept_name,
    dm.emp_no AS manager_emp_no
FROM 
    departments d
CROSS JOIN 
    dept_manager dm;


-- Question 10 

SELECT 
    e.emp_no,
    e.last_name,
    e.first_name,
    e.sex,
    e.hire_date,
    d.dept_no,
    d.dept_name
FROM 
    departments d
RIGHT JOIN 
    employees e ON e.emp_no = d.emp_no;


