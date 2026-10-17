-- Views in SQL

-- A View in SQL is a virtual table defined by a underlying `SELECT` query. Unlike physical tables, a view does not store data on disk itself;
-- instead, it dynamically retrieves and displays fresh data from the base tables whenever it is queried.

-- ### 1. Why Use Views?

-- Hiding Data Complexity: Simplifies complex queries involving multiple `JOIN`s, `GROUP BY` aggregations, or conditional logic so end users don't have to write them repeatedly.
-- Restricting Data Access (Security): Enhances database security by restricting access to sensitive columns (like salaries or SSNs) or specific rows.
-- Data Consistency: Ensures standardized calculations and business logic across different teams and applications.
-- Renaming Columns: Allows renaming raw table columns into user-friendly aliases without altering underlying base table schemas.

-- ### 2. Basic Syntax

-- CREATE VIEW view_name AS
	-- SELECT column1, column2
	-- FROM table_name
	-- WHERE condition;
    
-- To query a view, treat it like a standard table
-- SELECT * FROM view_name;

-- 3. Examples Using the parks_and_recreation Database

-- Example A: Hiding Query Complexity (JOIN Operations)
-- Instead of writing a `JOIN` between `employee_demographics` and `employee_salary` every time you need combined employee data,
-- you can encapsulate the join into a view.

CREATE VIEW employee_full_details AS
SELECT
	dem.employee_id,
    dem.first_name,
    dem.last_name,
    dem.gender,
    dem.age,
    sal.occupation,
    sal.salary
FROM parks_and_recreation.employee_demographics AS dem
JOIN parks_and_recreation.employee_salary AS sal
	ON dem.employee_id = sal.employee_id;
    
SELECT * FROM employee_full_details WHERE age > 35;

-- Example B: Restricting Sensitive Data (Security)
-- If non-HR staff need access to an employee directory, you can create a view that excludes sensitive salary information.

CREATE VIEW public_employee_directory AS
SELECT
	employee_id,
    first_name,
    last_name,
    occupation
FROM parks_and_recreation.employee_salary;

SELECT * FROM public_employee_directory;

-- Example C: Encapsulating Aggregations
-- You can store complex summary statistics (like departmental payroll totals and averages) inside a view.

CREATE VIEW department_salary_stats AS
SELECT
	dept_id,
    COUNT(*) AS total_employees,
    AVG(salary) AS avg_salary,
    SUM(salary) AS total_payroll
FROM parks_and_recreation.employee_salary
GROUP BY dept_id;

SELECT * FROM department_salary_stats;

-- 4. Modifying or Dropping Views

DROP VIEW IF EXISTS employee_full_details;

-- 5. Summary Comparison: CTEs vs. Temp Tables vs. Views

-- | Feature          | Common Table Expression (CTE)                     | Temporary Table                                     | View                                    			   |
-- | ---------------- | ------------------------------------------------- | --------------------------------------------------- | ---------------------------------------------------- |
-- | Storage Type     | No physical storage (inline subquery block)       | Session-bound memory/disk storage              	 	| Stored database definition (no physical data stored) |
-- | Lifecycle Scope  | Exists only during the single executing statement | Persists until the database session/connection ends | Permanent schema object until explicitly dropped     |
-- | Primary Use Case | Improving subquery readability and modular logic  | Staging complex multi-step transformations          | Security abstraction and reusable query shortcuts    |