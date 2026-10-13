-- Joins

-- Joins allow you to combine columns from two or more tables based on a related column shared between them

SELECT *
FROM parks_and_recreation.employee_demographics;

SELECT *
FROM parks_and_recreation.employee_salary;

-- 1. Inner Joins

-- An `INNER JOIN` returns only the rows that have matching values in both tables.
-- If a row in the first table does not have a matching key in the second table, it is excluded from the output.

SELECT *
FROM parks_and_recreation.employee_demographics
INNER JOIN parks_and_recreation.employee_salary
ON employee_id = employee_id; -- Error: Column 'employee_id' in ON clause is ambiguous

SELECT *
FROM parks_and_recreation.employee_demographics
INNER JOIN parks_and_recreation.employee_salary
ON employee_demographics.employee_id = employee_salary.employee_id;

SELECT *
FROM parks_and_recreation.employee_demographics
JOIN parks_and_recreation.employee_salary -- default to INEER JOIN
ON employee_demographics.employee_id = employee_salary.employee_id;

-- Aliasing

SELECT *
FROM parks_and_recreation.employee_demographics As dem
INNER JOIN parks_and_recreation.employee_salary AS sal
ON dem.employee_id = sal.employee_id;

SELECT employee_id, age, occupation					-- Error: Column 'employee_id' in ON clause is ambiguous
FROM parks_and_recreation.employee_demographics As dem
INNER JOIN parks_and_recreation.employee_salary AS sal
ON dem.employee_id = sal.employee_id;

SELECT dem.employee_id, age, occupation
FROM parks_and_recreation.employee_demographics As dem
INNER JOIN parks_and_recreation.employee_salary AS sal
ON dem.employee_id = sal.employee_id;

-- 2. Outer Join
-- An **outer join** combines records from two tables while retaining rows that do not have a corresponding match in the other table

-- LEFT JOIN(LEFT OUTER JOIN)
-- Returns **all rows from the left table** (`FROM` clause) and the **matched rows from the right table** (`JOIN` clause) 

SELECT *
FROM parks_and_recreation.employee_demographics As dem
LEFT OUTER JOIN parks_and_recreation.employee_salary AS sal		-- LEFT JOIN
ON dem.employee_id = sal.employee_id;

-- RIGHT JOIN
-- Returns **all rows from the right table** (`JOIN` clause) and the **matched rows from the left table** (`FROM` clause)

SELECT *
FROM parks_and_recreation.employee_demographics As dem
RIGHT OUTER JOIN parks_and_recreation.employee_salary AS sal	-- RIGHT JOIN
ON dem.employee_id = sal.employee_id;

-- FULL OUTER JOIN
-- Returns **all rows when there is a match in either the left or right table**

SELECT *
FROM parks_and_recreation.employee_demographics As dem
LEFT OUTER JOIN parks_and_recreation.employee_salary AS sal
ON dem.employee_id = sal.employee_id
UNION
SELECT *
FROM parks_and_recreation.employee_demographics As dem
RIGHT OUTER JOIN parks_and_recreation.employee_salary AS sal
ON dem.employee_id = sal.employee_id;

-- 3. SELF JOIN
-- A self join is a regular join in which a table is joined with itself.
-- To perform a self-join, you must assign distinct table aliases (e.g., `emp1` and `emp2`) so MySQL can evaluate the table as two separate entities.

SELECT
	emp_1.employee_id AS emp_santa,
	emp_1.first_name AS first_name_santa,
	emp_1.last_name AS last_name_santa,
	emp_2.employee_id AS emp_santa,
	emp_2.first_name AS first_name_santa,
	emp_2.last_name AS last_name_santa
FROM parks_and_recreation.employee_salary emp_1
JOIN parks_and_recreation.employee_salary emp_2
	ON emp_1.employee_id + 1 = emp_2.employee_id;

-- 4. Joining Multiple Tables Together

SELECT *
FROM parks_and_recreation.employee_demographics As dem
INNER JOIN parks_and_recreation.employee_salary AS sal
	ON dem.employee_id = sal.employee_id
INNER JOIN parks_and_recreation.parks_departments pd
	ON sal.dept_id = pd.department_id;

SELECT *
FROM parks_and_recreation.parks_departments;