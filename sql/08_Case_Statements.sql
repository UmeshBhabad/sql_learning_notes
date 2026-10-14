-- Case Statements

-- A CASE statement allows you to implement conditional `if-then-else` logic directly within your SQL queries.
-- It evaluates a sequence of conditions row-by-row and returns a specified value as soon as the first condition is satisfied.

-- CASE
	-- WHEN condition1 THEN result1 
	-- WHEN condition2 THEN result2 
	-- ELSE default_result 
-- END AS new_column_name;

SELECT *
FROM parks_and_recreation.employee_demographics;

SELECT first_name, last_name, age,
CASE
	WHEN age <= 30 THEN 'Young'
    WHEN age BETWEEN 31 AND 50 THEN 'Mid-Carrer'
    WHEN age >= 50 THEN "Senior"
END AS Age_Bracket
FROM parks_and_recreation.employee_demographics;

#### **3\. Example B: Conditional Calculations (Pay Increases &amp; Bonuses)**

-- Beyond text labels, `CASE` statements can perform inline mathematical calculations row-by-row based on complex business logic[7].

-- Suppose the Pawnee Council establishes end-of-year salary adjustments and department bonuses:

-- 1. Employees earning less than $50,000 receive a 5% raise (`salary * 1.05`).
-- 2. Employees earning greater than $50,000 receive a 7% raise (`salary * 1.07`).
-- 3. Employees in the Finance department (dept_id = 6) receive a 10% bonus (`salary * 0.10`).


-- Pay Increase And Bonus
-- < 50000 = 5%
-- > 50000 = 7%
-- Finance = 10% bonus

SELECT *
FROM parks_and_recreation.employee_salary;

SELECT first_name, last_name, salary,
CASE
	WHEN salary < 50000 THEN salary * 1.05
    WHEN salary > 50000 THEN salary * 1.07
    ELSE 0
END AS New_Salary,
CASE
	WHEN dept_id = 6 THEN salary * 0.10
END AS Bonus
FROM parks_and_recreation.employee_salary;

-- Case Statements with GROUP BY

SELECT
	CASE
		WHEN salary < 70000 THEN 'High Salary'
		WHEN salary BETWEEN 50000 AND 70000 THEN 'Mid Salary'
		ELSE 'Low Salary'
	END AS Salary_tier,
	COUNT(*) AS total_employees,
	AVG(salary) AS average_salary
FROM parks_and_recreation.employee_salary
GROUP BY
	CASE
		WHEN salary > 70000 THEN 'High Salary'
        WHEN salary BETWEEN 50000 AND 70000 THEN 'Mid Salary'
        ELSE 'Low Salary'
	END;

-- First Match Wins: Conditions are evaluated in top-down order. Once a `WHEN` condition is true, SQL returns the value and skips remaining conditions.

-- Handling ELSE: If no `WHEN` condition evaluates to true and no `ELSE` clause is provided, the CASE statement returns NULL.

-- Data Type Consistency: All possible outputs in the `THEN` and `ELSE` clauses must return the same or compatible data types (e.g., all strings or all numbers).