-- Stored Procedures

-- A stored procedure is a saved block of SQL statements stored directly inside the database management system that can be reused and executed repeatedly.
-- Instead of rewriting complex queries repeatedly, you can package them into a stored procedure and execute them on demand using the **CALL** statement.

#### 1. Why Use Stored Procedures?

-- Reusability: Encapsulates repetitive code into a single, standardized command.
-- Network & Performance Efficiency: Reduces network bandwidth since only the `CALL` execution request is transmitted rather than lengthy query blocks.
-- Security & Access Control: Allows users to perform specific database operations without giving them direct `SELECT`, `UPDATE`, or `DELETE` access to raw underlying tables.

SELECT *
FROM parks_and_recreation.employee_salary
WHERE salary >= 50000;

-- Creating a simple procedure

USE parks_and_recreation;

CREATE PROCEDURE large_salaries()
SELECT *
FROM parks_and_recreation.employee_salary
WHERE salary >= 50000;

-- Executing the procedure

CALL large_salaries();

CREATE PROCEDURE large_salaries2()
SELECT *
FROM parks_and_recreation.employee_salary
WHERE salary >= 50000;
SELECT *
FROM parks_and_recreation.employee_salary
WHERE salary >= 10000;

CALL large_salaries2();

-- 2. Delimiters (DELIMITER) & Procedure Creation

-- By default, MySQL uses the semicolon `;` to mark the end of an individual SQL statement[4].
-- When creating a stored procedure containing multiple statements inside a **BEGIN ... END** block, you must temporarily redefine the delimiter (e.g., to `//` or `$$`) so MySQL does not terminate the procedure definition prematurely.

	-- Multi-Statement Procedures & Delimiters(DELIMITER & BEGIN ... END)
	-- When a procedure contains **multiple SQL statements**, you must wrap the query block inside a BEGIN ... END block

	-- Step 1: Temoparily Change the statement delimiter to // 
	-- DELIMITER //

	-- Step 2: Create procedure with multiple queries inside BEGIN...END
	-- CREATE PROCEDURE large_salaries_summary()
	-- BEGIN
		-- SELECT * FROM employee_salary WHERE salary >= 50000;
		-- SELECT * FROM employee_salary WHERE salary >= 10000;
	-- END //

	-- Step 3: Reset delimiter back to semicolon
	-- DELIMITER ;

	-- Step 4: Call the multi-query procedure
	-- CALL large_salaries_summary();
    
DELIMITER $$
CREATE PROCEDURE large_salaries3()
BEGIN
	SELECT *
	FROM parks_and_recreation.employee_salary
	WHERE salary >= 50000;
	SELECT *
	FROM parks_and_recreation.employee_salary
	WHERE salary >= 10000;
END $$
DELIMITER ;

CALL large_salaries3();

-- 3. Using Parameters(IN Parameters)

-- Parameters turn stored procedures into dynamic, reusable templates by allowing you to pass in input values at execution time.

-- Parameter Definition: Defined inside the procedure's parentheses, specifying the parameter direction (`IN`, `OUT`, or `INOUT`), name, and data type.
-- Naming Conventions: It is best practice to prefix parameter names (e.g., `p_employee_id` or `p_dept_id`) to avoid naming conflicts with table columns.

DELIMITER $$
CREATE PROCEDURE get_employee_salary_by_id(emp_id_param INT)
BEGIN
	SELECT salary
	FROM parks_and_recreation.employee_salary
    WHERE employee_id = emp_id_param;
END $$
DELIMITER ;m

-- Retrieve salary for Employee ID 1 (Leslie Knope)
CALL get_employee_salary_by_id(1);

CALL get_employee_salary_by_id(5);

-- 4. Parameter Modes (IN, OUT, INOUT)

-- Stored procedures support three parameter modes:

-- IN: Passes a value into the procedure (read-only inside procedure).
-- OUT: Passes a value back out to the calling environment.
-- INOUT: Accepts an initial value in and returns an updated value back out.

DELIMITER //

CREATE PROCEDURE get_high_earner_count(
	IN p_min_salary DECIMAL(10, 2),
    OUT p_total_count INT
)
BEGIN
	SELECT
		COUNT(*) INTO p_total_count
        FROM parks_and_recreation.employee_salary
        WHERE salary > p_min_salary;
END //

DELIMITER ;

-- call the procedure
-- Pass the minimum salary threshold (e.g., 50000) for IN, and a variable (@total_count) for OUT
CALL get_high_earner_count(60000, @total_count);

-- Display the result captured in the variable
SELECT @total_count AS high_earner_count;

-- 5. Dropping Stored Procedures

-- To remove or replace an existing procedure, use `DROP PROCEDURE IF EXISTS`.

DROP PROCEDURE IF EXISTS large_salaries;


-- 6. Stored Procedures vs Functions

-- While both encapsulate code, they serve different purposes in SQL

-- SQL Functions: Must always return a single value and are generally used inside expressions (like `SELECT` or `WHERE` clauses) for calculations or data formatting.

-- Stored Procedures: Can execute multiple SQL statements, accept input (`IN`) and output (`OUT`) parameters, and perform operations that modify database state—such as `INSERT`, `UPDATE`, or `DELETE` commands.