-- Subqueries
-- A subquery (also referred to as an inner query or nested query) is a query embedded inside another SQL statement (the outer query)

-- Scalar Subquery: Returns a single value (one row, one column). It can be placed anywhere a literal value or single column expression is expected.
-- Single-Row Subquery: Returns a single row containing one or more columns.
-- Multi-Row Subquery: Returns multiple rows (a list or column of values). It is paired with set operators like `IN`, `NOT IN`, `ANY`, or `ALL`.
-- Correlated Subquery: References columns from the outer query table, executing repeatedly—once for every row processed by the outer query.

SELECT *
FROM parks_and_recreation.employee_demographics;

SELECT *
FROM parks_and_recreation.employee_salary;

SELECT *
FROM parks_and_recreation.employee_demographics
WHERE employee_id IN (SELECT employee_id, dept_id					-- Error: Operand should contain 1 column(s)
						FROM parks_and_recreation.employee_salary
                        WHERE dept_id = 1);
                        
SELECT *
FROM parks_and_recreation.employee_demographics
WHERE employee_id IN (SELECT employee_id
						FROM parks_and_recreation.employee_salary
                        WHERE dept_id = 1);
                        
-- Find Average salary without GROUP BY

SELECT first_name, salary, AVG(salary)
FROM parks_and_recreation.employee_salary
GROUP BY first_name, salary;				-- wrong answer

-- Average salary
SELECT AVG(salary) FROM parks_and_recreation.employee_salary;

SELECT first_name, salary, (SELECT AVG(salary) FROM parks_and_recreation.employee_salary) AS Avg_Salary
FROM parks_and_recreation.employee_salary;

SELECT gender, AVG(age), MAX(age), MIN(age), COUNT(age)
FROM parks_and_recreation.employee_demographics
GROUP BY gender;

SELECT AVG(`MAX(age)`)
FROM
(SELECT gender,
	AVG(age),
    MAX(age),
    MIN(age),
    COUNT(age)
FROM parks_and_recreation.employee_demographics
GROUP BY gender) AS Agg_table;

SELECT AVG(`MAX(age)`)
FROM
(SELECT gender,
	AVG(age) AS avg_age,
    MAX(age) AS max_age,
    MIN(age) AS min_age,
    COUNT(age)
FROM parks_and_recreation.employee_demographics
GROUP BY gender) AS Agg_table;

-- 1. Subqueries in the WHERE Clause
-- The most common placement for a subquery is within the `WHERE` clause to dynamically filter rows based on calculated criteria rather than hardcoding static values.

	-- Scalar Subquery (Single Value)

	-- Returns a single value (1 row, 1 column) that can be compared using standard operators (`&gt;`, `&lt;`, `=`, etc.).

	-- Scalar Comparison (WHERE column = (subquery))
	SELECT
		employee_id,
		first_name,
		salary
	FROM parks_and_recreation.employee_salary
	WHERE salary > (
			SELECT AVG(salary)
			FROM parks_and_recreation.employee_salary
	);

	-- Multi-Row Filtering (WHERE column IN (subquery))

	SELECT *
	FROM parks_and_recreation.employee_demographics
	WHERE employee_id IN (
			SELECT employee_id
			FROM parks_and_recreation.employee_salary
			WHERE dept_id = 1
	);

-- 2. Subquery in the SELECT Clause (Column Expressions)

-- A subquery placed in the `SELECT` clause must return a single scalar value for every row evaluated by the outer query. This is useful when you want to compare individual row values against a global aggregate metric side-by-side.

SELECT 
	first_name,
    salary,
    (SELECT AVG(salary) FROM parks_and_recreation.employee_salary) AS overall_avg_salary
FROM parks_and_recreation.employee_salary;

-- 3. Subquery in the FROM Clause (Derived Tables)

-- When placed in the `FROM` clause, the subquery acts as a **virtual or derived table** that the outer query can query, filter, or aggregate further.

-- Example 1: Aggregating Departmental Salary Summaries
-- Suppose you want to first group `employee_salary` by department to calculate the maximum, minimum, and average salary for each department,
--  and then calculate the overall average of those departmental maximums

SELECT AVG(max_salary) as avg_of_dept_max_salaries
FROM (
		SELECT
			dept_id,
            AVG(salary) as avg_salary,
            MAX(salary) AS max_salary,
            MIN(salary) AS min_salary,
            COUNT(*) AS total_employees
        FROM parks_and_recreation.employee_salary
        GROUP BY dept_id
	) AS dept_salary_summary;

-- Example 2: Filtering on a Calculated Column
-- Since you cannot directly reference calculated columns or `CASE` statement output in a `WHERE` clause of the same query level without repeating the calculation,
--  a derived table lets you compute the logic first and filter it in the outer query


SELECT
	first_name,
    last_name,
    occupation,
    salary,
    salary_tier
FROM (
	SELECT
		first_name,
        last_name,
        occupation,
        salary,
        CASE
			WHEN salary > 70000 THEN 'Highly paid'
            WHEN salary >= 50000 THEN 'Mid Tier'
            ELSE 'Low Tier'
		END AS salary_tier
	FROM parks_and_recreation.employee_salary) AS sub_salary_tier
WHERE salary_tier = 'Highly Paid';

#### **4\. Core Subquery Rules to Remember**

-- 1. Parentheses: Every subquery must be enclosed within parentheses `(...)`.
-- 2. Order of Execution: In basic subqueries, the inner query executes **first**, and its output is passed directly to the outer query.
-- 3. Table Aliasing: Subqueries in the `FROM` clause **must** have an alias, while subqueries in `WHERE` or `SELECT` clauses generally do not require one.

-- Correlated vs. Non-Correlated Subqueries

-- Non-Correlated Subquery: The inner query is completely independent of the outer query. It runs once, calculates a result, and hands that result to the outer query

-- Correlated Subquery: The inner query depends on a value from the current row of the outer query. It re-runs for every single row evaluated by the outer query.

