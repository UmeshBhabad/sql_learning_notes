-- Functions
-- In SQL, a User-Defined Function (UDF) is a stored routine that accepts input parameters, performs calculations or logic, and returns a single scalar value
-- Unlike stored procedures (which are executed using `CALL` and can return whole result sets), functions can be invoked directly inside `SELECT`, `WHERE`, or `ORDER BY` clauses.

-- Deterministic: Always returns the same output for the same input parameters (e.g., a mathematical formula).
-- Non-Deterministic: Output changes based on execution time, random generation, or external states (e.g., a function tracking NOW()).

-- 1. DETERMINISTIC

-- A deterministic function always returns the same output for the same input parameters. It does not look up data from tables or rely on the system clock.

-- Example 1: Function to Calculate a Custom Bonus
-- Suppose you want to create a function CalculateBonus that takes an employee's salary and calculates their bonus: 10% if they make over $70,000, and 5% otherwise.

	-- step 1. Creating the Function

	DELIMITER $$

	CREATE FUNCTION CalculateBonus(p_salary DECIMAL(10, 2))
	RETURNS DECIMAL(10, 2)
	DETERMINISTIC
	BEGIN
		DECLARE v_bonus DECIMAL(10, 2);
		
		IF p_salary > 70000 THEN
			SET v_bonus = p_salary * 0.10;
		ELSE
			SET v_bonus = p_salary * 0.05;
		END IF;    
		RETURN v_bonus;
	END $$

	DELIMITER ;

	-- step 2. Calling the Function on employee_salary

	SELECT
		employee_id,
		first_name,
		occupation,
		salary,
		CalculateBonus(salary) AS calculated_bonus
	FROM parks_and_recreation.employee_salary;

-- Example 2: Function to Categorize Salary Tiers
-- This function takes a salary as input and returns a descriptive category label (`VARCHAR`)

	-- Step 1. Creating a Function

	DELIMITER //

	CREATE FUNCTION GetSalaryTier(p_salary DECIMAL(10, 2))
	RETURNS VARCHAR(20)
	DETERMINISTIC
	BEGIN
		DECLARE v_tier VARCHAR(20);
		
		IF p_salary >= 70000 THEN
			SET v_tier = 'High pay';
		ELSEIF p_salary >= 50000 THEN 
			SET v_tier = 'Mid Pay';
		ELSE
			SET v_tier = 'Entry Level';
		END IF;
		
		RETURN v_tier;
	END //

	DELIMITER ;

	-- Step 2. Using the Function in SELECT and WHERE Clauses

	SELECT
		first_name,
		occupation,
		salary,
		GetSalaryTier(salary) AS tier
	FROM employee_salary
	WHERE GetSalaryTier(salary) = 'High Pay';

-- 2. NON-DETERMINISTIC

-- A non-deterministic function can return different results even when passed the exact same inputs.
-- This happens if the function reads data from tables (which can change) or uses time-dependent system functions like NOW().

-- Example 1: Dynamic Age Calculation (Uses CURDATE())

-- In `employee_demographics`, employees have a `birth_date`.
-- If you write a function that calculates an employee's current age from their `birth_date`, the output changes as real-world time progresses.

SELECT *
from parks_and_recreation.employee_demographics;

DELIMITER //

CREATE FUNCTION CalculateCurrentAge(p_birth_date DATE)
RETURNS INT
NOT DETERMINISTIC
NO SQL
BEGIN
	DECLARE v_age INT;
    
    -- TIMESTAMPDIFF compares birth_date against CURDATE(), which changes daily
    SET v_age = TIMESTAMPDIFF(YEAR, p_birth_date, CURDATE());
    
    RETURN v_age;
END //

DELIMITER ;

SELECT
	employee_id,
	first_name,
    last_name,
    age AS previous_age,
    gender,
    birth_date,
    CalculateCurrentAge(birth_date) AS current_age
FROM parks_and_recreation.employee_demographics;

-- Example 2: Random Performance Bonus (Uses RAND())

-- Suppose Tom Haverford designs a lottery-style end-of-year bonus for `employee_salary` where each employee receives a random bonus percentage between 5% and 15%.

DELIMITER $$

CREATE FUNCTION GenerateRandomBonus(p_salary DECIMAL(10, 2))
RETURNS DECIMAL(10, 2)
NOT DETERMINISTIC
NO SQL
BEGIN
	DECLARE v_bonus_percent DECIMAL(10, 2);
    DECLARE v_bonus_amount DECIMAL(10, 2);
    
    -- RAND() generates a pseudo-random decimal between 0 and 1
    SET v_bonus_percent = 5 + (RAND() * 10);
    SET v_bonus_amount = p_salary * (v_bonus_percent / 100);
    
    RETURN v_bonus_amount;
END $$

DELIMITER ;

SELECT
	first_name,
    last_name,
    salary,
    GenerateRandomBonus(salary) AS randomized_bonus
FROM parks_and_recreation.employee_salary;

-- Return Value: A function must define a `RETURNS` data type and execute a `RETURN` statement to yield a single value.

-- Query Integration: Functions can be embedded inside `SELECT` column lists, `WHERE` conditions, or `ORDER BY` clauses.
-- Stored procedures cannot be embedded in a `SELECT` statement and must be invoked with `CALL`.
