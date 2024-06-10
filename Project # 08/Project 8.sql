-- Create the database
CREATE DATABASE project8;

-- Switch to the project8 database
USE project8;

-- Create the orchestras table
CREATE TABLE orchestras (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    rating DECIMAL(3, 2) NOT NULL,
    city_origin VARCHAR(255) NOT NULL,
    country_origin VARCHAR(255) NOT NULL,
    year INT NOT NULL
);

-- Create the concerts table
CREATE TABLE concerts (
    id INT AUTO_INCREMENT PRIMARY KEY,
    city VARCHAR(255) NOT NULL,
    country VARCHAR(255) NOT NULL,
    year INT NOT NULL,
    rating DECIMAL(3, 2) NOT NULL,
    orchestras_id INT,
    FOREIGN KEY (orchestras_id) REFERENCES orchestras(id)
);

-- Create the members table
CREATE TABLE members (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    position VARCHAR(255) NOT NULL,
    experience INT NOT NULL,
    orchestras_id INT,
    wage DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (orchestras_id) REFERENCES orchestras(id)
);



-- Insert data into the orchestras table (8 records)
INSERT INTO orchestras (name, rating, city_origin, country_origin, year)
VALUES
('New York Philharmonic', 4.8, 'New York', 'USA', 1842),
('Berlin Philharmonic', 4.9, 'Berlin', 'Germany', 1882),
('Vienna Philharmonic', 4.7, 'Vienna', 'Austria', 1842),
('London Symphony Orchestra', 4.6, 'London', 'UK', 1904),
('Chicago Symphony Orchestra', 4.7, 'Chicago', 'USA', 1891),
('Los Angeles Philharmonic', 4.6, 'Los Angeles', 'USA', 1919),
('Royal Concertgebouw Orchestra', 4.8, 'Amsterdam', 'Netherlands', 1888),
('Boston Symphony Orchestra', 4.7, 'Boston', 'USA', 1881);

-- Insert data into the concerts table (8 records)
INSERT INTO concerts (city, country, year, rating, orchestras_id)
VALUES
('New York', 'USA', 2022, 4.8, 1),
('Berlin', 'Germany', 2022, 4.9, 2),
('Vienna', 'Austria', 2022, 4.7, 3),
('Tokyo', 'Japan', 2023, 4.9, 1),
('London', 'UK', 2023, 4.8, 2),
('Chicago', 'USA', 2023, 4.7, 5),
('Los Angeles', 'USA', 2023, 4.6, 6),
('Amsterdam', 'Netherlands', 2023, 4.8, 7);

-- Insert data into the members table (10 records)
INSERT INTO members (name, position, experience, orchestras_id, wage)
VALUES
('John Doe', 'Conductor', 20, 1, 80000.00),
('Jane Smith', 'Violinist', 15, 1, 60000.00),
('Hans Müller', 'Cellist', 25, 2, 70000.00),
('Anna Schmidt', 'Violinist', 18, 2, 60000.00),
('Peter Gruber', 'Conductor', 22, 3, 85000.00),
('Franz Huber', 'Cellist', 20, 3, 70000.00),
('Emily Brown', 'Pianist', 10, 4, 65000.00),
('Michael Johnson', 'Flutist', 12, 5, 62000.00),
('Laura Wilson', 'Harpist', 8, 6, 58000.00),
('David Anderson', 'Trumpeter', 14, 7, 64000.00),
('Sarah Lee', 'Clarinetist', 11, 8, 61000.00),
('Paul King', 'Percussionist', 13, 1, 63000.00),
('Sophie Martin', 'Violist', 9, 4, 59000.00),
('Thomas White', 'Trombonist', 16, 5, 67000.00),
('Olivia Green', 'Bassoonist', 10, 6, 62000.00);


-- Question 1 (a)
SELECT DISTINCT o.name
FROM orchestras o
WHERE o.city_origin IN (
    SELECT DISTINCT c.city
    FROM concerts c
    WHERE c.year = 2021
);





SELECT m.name, m.position
FROM members m
JOIN orchestras o ON m.orchestras_id = o.id
WHERE m.experience > 10
AND o.rating >= 9.4;


SELECT m.name, m.position
FROM members m
WHERE m.wage > (
    SELECT AVG(wage)
    FROM members
    WHERE position = 'Violinist'
);



SELECT m.name, m.position
FROM members m
WHERE m.wage > (
    SELECT AVG(wage)
    FROM members
    WHERE position = 'Violinist'
);


-- Find the year the 'Chamber Orchestra' was created
SELECT name
FROM orchestras
WHERE year > (
    SELECT year
    FROM orchestras
    WHERE name = 'Chamber Orchestra'
)
AND rating > 9.5;


-- Step 1: Calculate the number of members for each orchestra
WITH OrchestraMemberCount AS (
    SELECT o.id, o.name, COUNT(m.id) AS member_count
    FROM orchestras o
    JOIN members m ON o.id = m.orchestras_id
    GROUP BY o.id, o.name
),

-- Step 2: Calculate the average number of members across all orchestras
AverageMembership AS (
    SELECT AVG(member_count) AS avg_membership
    FROM OrchestraMemberCount
)

-- Step 3: Filter orchestras that have more members than the average
SELECT omc.name, omc.member_count
FROM OrchestraMemberCount omc
JOIN AverageMembership am ON omc.member_count > am.avg_membership;




-- Create the database
CREATE DATABASE project8_university;

-- Switch to the project8_university database
USE project8_university;

-- Create the student table
CREATE TABLE student (
    id INT AUTO_INCREMENT PRIMARY KEY,
    f_name VARCHAR(255) NOT NULL,
    l_name VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL UNIQUE,
    dob DATE NOT NULL,
    start_date DATE NOT NULL
);

-- Create the lecturer table
CREATE TABLE lecturer (
    id INT AUTO_INCREMENT PRIMARY KEY,
    f_name VARCHAR(255) NOT NULL,
    l_name VARCHAR(255) NOT NULL,
    degree VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL UNIQUE
);

-- Create the academic_semester table
CREATE TABLE academic_semester (
    id INT AUTO_INCREMENT PRIMARY KEY,
    calender_year INT NOT NULL,
    term VARCHAR(255) NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL
);

-- Create the courses table
CREATE TABLE courses (
    course_code VARCHAR(10) PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    learning_path VARCHAR(255) NOT NULL,
    short_description TEXT,
    lecture_hours INT NOT NULL,
    tutorial_hours INT NOT NULL,
    ects_points DECIMAL(4, 2) NOT NULL,
    has_exams BOOLEAN NOT NULL,
    has_project BOOLEAN NOT NULL
);

-- Create the course_edition table
CREATE TABLE course_edition (
    id INT AUTO_INCREMENT PRIMARY KEY,
    course_id VARCHAR(10),
    academic_session_id INT,
    lecturer_id INT,
    FOREIGN KEY (course_id) REFERENCES courses(course_code),
    FOREIGN KEY (academic_session_id) REFERENCES academic_semester(id),
    FOREIGN KEY (lecturer_id) REFERENCES lecturer(id)
);

-- Create the course_enrollement table
CREATE TABLE course_enrollement (
    course_edition_id INT,
    student_id INT,
    midterm_grade DECIMAL(3, 2),
    final_grade DECIMAL(3, 2),
    course_letter_grade CHAR(2),
    passed BOOLEAN,
    PRIMARY KEY (course_edition_id, student_id),
    FOREIGN KEY (course_edition_id) REFERENCES course_edition(id),
    FOREIGN KEY (student_id) REFERENCES student(id)
);


-- Switch to the project8_university database
USE project8_university;

-- Insert data into the student table
INSERT INTO student (f_name, l_name, email, dob, start_date)
VALUES
('John', 'Doe', 'john.doe@example.com', '2000-01-15', '2019-09-01'),
('Jane', 'Smith', 'jane.smith@example.com', '2001-02-25', '2020-09-01'),
('Michael', 'Brown', 'michael.brown@example.com', '1999-03-30', '2018-09-01'),
('Emily', 'Davis', 'emily.davis@example.com', '2002-04-18', '2021-09-01'),
('Daniel', 'Wilson', 'daniel.wilson@example.com', '2000-05-12', '2019-09-01'),
('Sophia', 'Martinez', 'sophia.martinez@example.com', '2001-06-23', '2020-09-01'),
('James', 'Taylor', 'james.taylor@example.com', '1999-07-14', '2018-09-01'),
('Olivia', 'Anderson', 'olivia.anderson@example.com', '2002-08-05', '2021-09-01');

-- Insert data into the lecturer table
INSERT INTO lecturer (f_name, l_name, degree, email)
VALUES
('Robert', 'Johnson', 'PhD', 'robert.johnson@example.com'),
('Patricia', 'Williams', 'PhD', 'patricia.williams@example.com'),
('Linda', 'Jones', 'MSc', 'linda.jones@example.com'),
('David', 'Brown', 'PhD', 'david.brown@example.com'),
('Barbara', 'Miller', 'MSc', 'barbara.miller@example.com'),
('James', 'Wilson', 'PhD', 'james.wilson@example.com'),
('Elizabeth', 'Moore', 'MSc', 'elizabeth.moore@example.com'),
('Jennifer', 'Taylor', 'PhD', 'jennifer.taylor@example.com');

-- Insert data into the academic_semester table
INSERT INTO academic_semester (calender_year, term, start_date, end_date)
VALUES
(2021, 'Fall', '2021-09-01', '2021-12-31'),
(2021, 'Spring', '2021-01-01', '2021-04-30'),
(2022, 'Fall', '2022-09-01', '2022-12-31'),
(2022, 'Spring', '2022-01-01', '2022-04-30'),
(2023, 'Fall', '2023-09-01', '2023-12-31'),
(2023, 'Spring', '2023-01-01', '2023-04-30'),
(2024, 'Fall', '2024-09-01', '2024-12-31'),
(2024, 'Spring', '2024-01-01', '2024-04-30');

-- Insert data into the courses table
INSERT INTO courses (course_code, title, learning_path, short_description, lecture_hours, tutorial_hours, ects_points, has_exams, has_project)
VALUES
('CS101', 'Introduction to Computer Science', 'Computer Science', 'Basic concepts of computer science', 30, 15, 5.0, TRUE, FALSE),
('MATH201', 'Calculus I', 'Mathematics', 'Introduction to calculus', 40, 20, 6.0, TRUE, FALSE),
('PHYS101', 'General Physics I', 'Physics', 'Basic principles of physics', 35, 20, 6.0, TRUE, TRUE),
('ENG101', 'English Literature', 'Arts', 'Study of English literature', 25, 10, 4.0, TRUE, TRUE),
('BIO101', 'Introduction to Biology', 'Biology', 'Basic concepts of biology', 30, 15, 5.0, TRUE, FALSE),
('HIST101', 'World History', 'History', 'Overview of world history', 30, 15, 5.0, TRUE, FALSE),
('CS102', 'Data Structures', 'Computer Science', 'Introduction to data structures', 40, 20, 6.0, TRUE, TRUE),
('MATH202', 'Calculus II', 'Mathematics', 'Continuation of Calculus I', 40, 20, 6.0, TRUE, TRUE);

-- Insert data into the course_edition table
INSERT INTO course_edition (course_id, academic_session_id, lecturer_id)
VALUES
('CS101', 1, 1),
('MATH201', 2, 2),
('PHYS101', 3, 3),
('ENG101', 4, 4),
('BIO101', 5, 5),
('HIST101', 6, 6),
('CS102', 7, 7),
('MATH202', 8, 8);



ALTER TABLE course_enrollement MODIFY COLUMN final_grade DECIMAL(5, 2);


-- Insert data into the course_enrollement table
INSERT INTO course_enrollement (course_edition_id, student_id, midterm_grade, final_grade, course_letter_grade, passed)
VALUES
(1, 1, 85.0, 90.0, 'A', TRUE),
(2, 2, 75.0, 80.0, 'B', TRUE),
(3, 3, 65.0, 70.0, 'C', TRUE),
(4, 4, 95.0, 93.0, 'A', TRUE),
(5, 5, 55.0, 60.0, 'D', TRUE),
(6, 6, 85.0, 88.0, 'B', TRUE),
(7, 7, 75.0, 78.0, 'C', TRUE),
(8, 8, 95.0, 96.0, 'A', TRUE),
(1, 2, 80.0, 85.0, 'B', TRUE),
(2, 3, 70.0, 75.0, 'C', TRUE),
(3, 4, 60.0, 65.0, 'D', TRUE),
(4, 5, 90.0, 92.0, 'A', TRUE);

SELECT course_code, title
FROM courses
WHERE course_code IN (
    SELECT ce.course_id
    FROM course_edition ce
    JOIN academic_semester a ON ce.academic_session_id = a.id
    WHERE a.term = 'Spring'
);

SELECT id, CONCAT(f_name, ' ', l_name) AS full_name
FROM student
WHERE id IN (
    SELECT DISTINCT student_id
    FROM course_enrollement
    WHERE passed = TRUE
);

SELECT l.f_name, l.l_name, COUNT(ce_count.lecturer_id) AS num_of_courses
FROM lecturer l
JOIN (
    SELECT lecturer_id, COUNT(*) AS num_of_courses
    FROM course_edition
    GROUP BY lecturer_id
) AS ce_count ON l.id = ce_count.lecturer_id
WHERE ce_count.num_of_courses = (
    SELECT MIN(num_of_courses)
    FROM (
        SELECT COUNT(*) AS num_of_courses
        FROM course_edition
        GROUP BY lecturer_id
    ) AS min_courses
)
GROUP BY l.id, l.f_name, l.l_name;



SELECT s.id, s.f_name, s.l_name, COUNT(ce.student_id) AS num_of_course_editions
FROM student s
JOIN (
    SELECT student_id, COUNT(*) AS num_of_course_editions
    FROM course_enrollement
    GROUP BY student_id
) AS ce ON s.id = ce.student_id
WHERE ce.num_of_course_editions = (
    SELECT MAX(num_of_course_editions)
    FROM (
        SELECT COUNT(*) AS num_of_course_editions
        FROM course_enrollement
        GROUP BY student_id
    ) AS max_ce
)
GROUP BY s.id, s.f_name, s.l_name;
