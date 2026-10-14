-- UNIONS

-- While JOINs combine **columns** horizontally from multiple tables based on matching keys,
-- UNIONs combine **rows** vertically by stacking the result sets of two or more `SELECT` statements on top of each other.

#### 1. Core Rules for Writing Unions

-- To successfully execute a `UNION`, your queries must follow strict structural rules:

-- 1. Same Number of Columns: Every `SELECT` statement in the `UNION` block must return the exact same number of columns.
-- 2. Compatible Data Types: The corresponding columns across each query must have matching or similar data types (e.g., text matched with text, numbers with numbers).
-- 3. Column Headers: The final output takes its column header names directly from the first SELECT statement

SELECT age, gender
FROM parks_and_recreation.employee_demographics
UNION
SELECT first_name, last_name
FROM parks_and_recreation.employee_demographics;

-- 2. UNION (Distinct) vs. UNION ALL

-- UNION (or `UNION DISTINCT`): Combines result sets and automatically removes duplicate rows, returning only unique records.

	SELECT first_name, last_name
	FROM parks_and_recreation.employee_demographics
	UNION												-- default DISTINCT
	SELECT first_name, last_name
	FROM parks_and_recreation.employee_demographics;

	-- If an employee appears in both tables, UNION returns them only once

-- UNION ALL: Combines all rows from every query without removing duplicates.

	SELECT first_name, last_name
	FROM parks_and_recreation.employee_demographics
	UNION ALL
	SELECT first_name, last_name
	FROM parks_and_recreation.employee_demographics;

	-- If an employee is listed in both tables, they will appear twice in the final output.

-- 3. Practical Example: Categorized Budget Report

-- A common real-world application of `UNION` is compiling multi-criteria reports with custom labels—such as identifying staff based on demographic and salary thresholds.

-- Query 1: Identify older male employees
SELECT first_name, last_name, 'OLD Man' as Label
FROM parks_and_recreation.employee_demographics
WHERE age > 40 AND gender = 'Male'

UNION

-- Query 2: Identify older female employees
SELECT first_name, last_name, 'OLD Lady' as Label
FROM parks_and_recreation.employee_demographics
WHERE age > 40 AND gender = 'Female'

UNION

-- Query 3: Identify highly paid employees
SELECT first_name, last_name, 'Highly paid Employee' AS Label
FROM parks_and_recreation.employee_salary
WHERE salary > 70000
ORDER BY first_name, last_name;

#### **Summary Comparison: Joins vs. Unions**

-- | Feature            | `JOIN`                                    | `UNION`                                      |
-- | ------------------ | ----------------------------------------- | -------------------------------------------- |
-- | Combination Axis   | Horizontal (appends columns side-by-side) | Vertical (stacks rows on top of each other)  |
-- | Key Requirement    | Common matching key column between tables | Equal column count &amp; matching data types |
-- | Duplicate Handling | Depends on join condition logic           | `UNION` dedupes; `UNION ALL` keeps all       |