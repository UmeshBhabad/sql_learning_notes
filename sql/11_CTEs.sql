-- CTEs Common Table Expressions

-- #### 1. What is a CTE?

-- A Common Table Expression (CTE) is a named, temporary result set defined using the `WITH` clause that exists only within the execution scope of a single SQL statement.

-- Defined using the **WITH** clause, a CTE allows you to write a subquery block, give it an alias,
-- and then reference it within your main query as if it were a virtual table

-- Unlike permanent tables, views, or temporary tables, CTEs are not stored on disk or saved in memory across sessions;
-- they function as an inline query block that enhances query modularity and structure.

-- Syntax

-- WITH cte_name AS
-- (
-- 	SELECT column1, column2
--     FROM table_name
--     WHERE condition
-- )
-- SELECT *
-- FROM cte_name;

-- A CTE is not stored permanently on disk or in database memory like a table or view
-- It must be queried **immediately** after its `WITH` definition.
-- Attempting to reference it in a separate statement later will return a table non-existence error.

-- CTEs produce the exact same results as subqueries (derived tables),
-- but they keep code formatted logically from top to bottom rather than nesting logic inside the `FROM` clause.

-- Normal Subquery

SELECT AVG(avg_sal)
FROM
(
SELECT
	gender,
    AVG(salary) AS avg_sal,
    MAX(salary) AS max_sal,
    MIN(salary) AS min_sal,
    COUNT(salary) AS count_sal
FROM parks_and_recreation.employee_demographics dem
JOIN parks_and_recreation.employee_salary sal
	ON dem.employee_id = sal.employee_id
GROUP BY gender
) example_subquery;

-- CTE Example

WITH CTE_Example AS
(
SELECT
	gender,
    AVG(salary) AS avg_sal,
    MAX(salary) AS max_sal,
    MIN(salary) AS min_sal,
    COUNT(salary) AS count_sal
FROM parks_and_recreation.employee_demographics dem
JOIN parks_and_recreation.employee_salary sal
	ON dem.employee_id = sal.employee_id
GROUP BY gender
)
SELECT AVG(avg_sal)
FROM CTE_Example;

SELECT AVG(avg_sal)
FROM CTE_Example;		-- Error: Table doesn't Exist

-- Chaining Multiple CTEs in a Single Statement

WITH CTE_Example AS
(
SELECT
	employee_id, gender, birth_date
FROM parks_and_recreation.employee_demographics
WHERE birth_date > '1985-01-01'
),
CTE_Example2 AS
(
SELECT
	employee_id,
    salary
FROM parks_and_recreation.employee_salary
WHERE salary > 50000
)
SELECT *
FROM CTE_Example
JOIN CTE_Example2
	ON CTE_Example.employee_id = CTE_Example2.employee_id;
    
-- 3. Overriding Column Aliases in the CTE Header

-- You can explicitly override column names directly in the CTE header—such as `WITH my_cte (col1, col2) AS (...)` - which overwrites any column aliases inside the inner query.
WITH CTE_Example(Gender, AVG_Sal, MAX_Sal, MIN_Sal, COUNT_Sal) AS
(
SELECT
	gender,
    AVG(salary) AS avg_sal,
    MAX(salary) AS max_sal,
    MIN(salary) AS min_sal,
    COUNT(salary) AS count_sal
FROM parks_and_recreation.employee_demographics dem
JOIN parks_and_recreation.employee_salary sal
	ON dem.employee_id = sal.employee_id
GROUP BY gender
)
SELECT *
FROM CTE_Example;
