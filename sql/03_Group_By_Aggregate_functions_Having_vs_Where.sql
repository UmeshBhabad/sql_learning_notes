-- GROUP BY

-- 1. Basic Syntax & How It Works

-- The GROUP BY clause groups together rows that share the same values in specified columns into summary rows.
-- It is primarily used alongside **aggregate functions** to roll up raw row data into summary statistics for each distinct group.

SELECT *
FROM parks_and_recreation.employee_demographics;

SELECT gender
FROM parks_and_recreation.employee_demographics
GROUP BY gender;

SELECT occupation, salary
FROM parks_and_recreation.employee_salary
GROUP BY occupation, salary;

-- 2. Common Aggregate Functions

-- Aggregate functions perform calculations across a set of values within each group and return a single summary metric per group.

-- AVG(): Calculates the average of numeric values (e.g., `AVG(age)` or `AVG(salary)`).
-- COUNT(): Counts the total number of non-null records or rows in each group (e.g., `COUNT(employee_id)` or `COUNT(*)`).
-- SUM(): Calculates the grand total of numeric values in a column.
-- MIN(): Identifies the lowest value within the group.
-- MAX(): Identifies the highest value within the group

SELECT gender, AVG(age)
FROM parks_and_recreation.employee_demographics
GROUP BY gender;

SELECT
	gender,
	AVG(age) AS avg_age,
    MAX(age) AS max_age,
    MIN(age) AS min_age,
    COUNT(age) AS total_employees
FROM parks_and_recreation.employee_demographics
GROUP BY gender;

-- 3. The Column Match Rule (Crucial Rule)

-- A common error occurs when selecting a non-aggregated column that is not present in the `GROUP BY` clause.

-- Rule: Every non-aggregated column listed in your `SELECT` clause **must** be explicitly included in the `GROUP BY` clause.

	-- Incorrect:

	-- Causes error: 'first_name' is not aggregated and not in GROUP BY

	SELECT first_name, gender, AVG(age)
	FROM employee_demographics
	GROUP BY gender; 

	-- Correct:

	SELECT first_name, gender, AVG(age)
	FROM employee_demographics
	GROUP BY first_name, gender;
    
-- 4. Grouping by Multiple Columns

-- You can group by multiple fields simultaneously (e.g., `occupation` and `salary`).
-- SQL creates a distinct summary group for every unique **combination** of values across those columns.

SELECT
	occupation,
    salary,
    COUNT(*) AS count_employees
FROM parks_and_recreation.employee_salary
GROUP BY occupation, salary;

-- ORDER BY

SELECT *
FROM parks_and_recreation.employee_demographics
ORDER BY first_name; -- ordering by first_name in acending order by default

SELECT *
FROM parks_and_recreation.employee_demographics
ORDER BY birth_date DESC;

SELECT *
FROM parks_and_recreation.employee_demographics
ORDER BY gender, age DESC; -- gender by ascending and age by decending order

SELECT *
FROM parks_and_recreation.employee_demographics
ORDER BY 5, 4; -- order gender, age by positions of columns

-- HAVING vs WHERE

-- While both **WHERE** and **HAVING** are used to filter data in SQL, they operate at completely different stages of query execution

-- #### Core Difference &amp; Execution Sequence

-- WHERE: Filters raw, individual rows before any grouping or aggregation takes place.
-- HAVING: Filters summary groups after the `GROUP BY` clause has created aggregated calculations.

-- Why WHERE Fails on Aggregate Functions

-- Attempting to filter an aggregate calculation (like `AVG()`, `COUNT()`, or `SUM()`) inside a `WHERE` clause causes SQL to throw an error (such as *invalid use of group function*).
-- This happens because in SQL's logical execution order, `WHERE` evaluates rows before `GROUP BY` has rolled them up.

SELECT gender, AVG(age)
FROM parks_and_recreation.employee_demographics
WHERE AVG(age) > 40 -- WHERE evaluates agrregate function before GROUP BY
GROUP BY gender; -- Invalid use of group function

SELECT gender, AVG(age)
FROM parks_and_recreation.employee_demographics
GROUP BY gender
HAVING AVG(age) > 40; -- aggregate function is used with GROUP BY first then comes HAVING condition

SELECT occupation, AVG(salary)
FROM parks_and_recreation.employee_salary
WHERE occupation LIKE '%manager%'	-- WHERE clause is filtering raw table values rather than an aggregate calculation
GROUP BY occupation
HAVING AVG(salary) > 75000;