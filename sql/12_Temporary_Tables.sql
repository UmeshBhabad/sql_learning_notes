-- Temporary Table

-- A temporary table in SQL is a special table that exists temporarily and is visible only within the database session in which it is created.
-- Unlike permanent physical tables or views, a temporary table is automatically destroyed(DROP) once you end your active connection or close your database session

-- 2. Two Ways to Create Temporary Tables

-- Method A: Explicit Column Definition

-- Step 1: Define the table structure

CREATE TEMPORARY TABLE temp_table
(
first_name varchar(50),
last_name varchar(50),
favorite_movie varchar(100)
);

SELECT *
FROM temp_table;

-- Step 2: Populate with data

-- Insert single row
INSERT INTO temp_table
VALUES('Umesh', 'Bhabad', 'Shawshank Redemption');

-- Insert Multiple rows

INSERT INTO temp_table(first_name, last_name, favorite_movie)
VALUES
	('Himanshu', 'Thakur', 'Shivaji: The Boss'),
    ('Chandrakant', 'Shinde', 'Suryavansham'),
    ('Aditya', 'Deoche', 'Kakan'),
    ('Raj', 'Kadam', 'Lingaa'),
    ('Vishwatej', 'Surve', 'Sairat'),
    ('Shubham', 'Bilgi', 'Raghini MMS');

SELECT *
FROM temp_table; 

SELECT *
FROM employee_salary;

-- Method B: Creating Directly from a Query

CREATE TEMPORARY TABLE salary_over_50k
SELECT *
FROM parks_and_recreation.employee_salary
WHERE salary >= 50000;

SELECT *
FROM salary_over_50k;

SELECT first_name, last_name
FROM salary_over_50k;

### **Temporary Tables vs. Common Table Expressions (CTEs)**

-- | Feature          | Temporary Table                                                                                           |          CTE (`WITH ... AS`)                                       |
-- |------------------| ----------------------------------------------------------------------------------------------------------| -------------------------------------------------------------------|
-- | Lifespan / Scope | Persists throughout your **entire active session**.                                                       | Exists **only for the execution of a single query**. 		       |
-- | Storage		  | Lives temporarily in session memory/storage																  | Not stored on disk or memory; acts as an inline subquery block 	   |
-- | Reusability      | Can be queried, joined, or modified multiple times across multiple query tabs or stored procedure steps.  | Can only be referenced once immediately following its declaration. |
-- | Best Use Case    | Complex multi-step data transformations, heavy manipulation, or stored procedures.                        | One-off calculations and simplifying readable subqueries.  		   |