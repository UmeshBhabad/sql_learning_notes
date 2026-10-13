-- Limit & Aliasing

-- The LIMIT clause and AS (Aliasing) keyword are essential tools for controlling query output size and improving code readability.

-- 1. The LIMIT Clause

-- The **LIMIT** clause restricts the maximum number of rows returned in your query output.
-- It is typically placed at the very end of your SQL statement.

SELECT *
FROM parks_and_recreation.employee_demographics;

SELECT *
FROM parks_and_recreation.employee_demographics
LIMIT 3; -- First 3 rows

-- Handling Offsets (OFFSET / Comma Syntax)
-- An offset allows you to skip a specified number of rows before starting to return records, which is useful for pagination.

-- Option A (Comma Syntax): LIMIT offset, count

SELECT *
FROM parks_and_recreation.employee_demographics
LIMIT 3, 2; -- start from 3 and then next 2 rows

-- Option B (Standard SQL Syntax): LIMIT count OFFSET offset

SELECT *
FROM parks_and_recreation.employee_demographics
LIMIT 2 OFFSET 3; -- Returns 3 rows starting after skipping the 1st row

-- Combining LIMIT with ORDER BY
-- `LIMIT` becomes particularly powerful when paired with `ORDER BY` to pull "top N" or "bottom N" records (such as the top 3 oldest employees or highest earners).

SELECT *
FROM parks_and_recreation.employee_demographics
ORDER BY age DESC
LIMIT 2, 1;

-- Aliasing (AS)

SELECT gender, AVG(age) as avg_age
FROM parks_and_recreation.employee_demographics
GROUP BY gender
HAVING AVG(age) > 40;

-- Table Aliasing
-- Used to give tables short shorthand aliases, which is crucial when shortening long table names in complex queries or joins.

SELECT
	dem.employee_id,
    dem.first_name,
    sal.salary
FROM parks_and_recreation.employee_demographics dem
JOIN parks_and_recreation.employee_salary sal
	ON dem.employee_id = sal.employee_id;