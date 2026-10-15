-- Window Functions

-- A window function performs calculations across a set of rows (a "window") related to the current row, 
-- but unlike standard aggregate functions with `GROUP BY`, window functions do not collapse rows into a single output row.
-- each individual row retains its original identity while displaying calculated window values

-- 1. Core Syntax & Key Clauses

-- A window function is identified by the **OVER()** clause, which defines the window frame of rows the function operates on.

	-- FUNCTION_NAME() OVER (
			-- PARTITION BY column_name
			-- ORDER BY column_name )
        
	-- OVER(): Signals to SQL that the calculation is a window function
	-- PARTITION BY: Divides the result set into subsets (groups) to apply the calculation separately to each group without collapsing the rows
	-- ORDER BY: Specifies the sequence of rows processed within each partition

SELECT *
FROM parks_and_recreation.employee_demographics;

SELECT *
FROM parks_and_recreation.employee_salary;

-- 2. Aggregate Window Functions
-- Standard aggregate functions can be transformed into window functions when paired with the **OVER()** clause

-- AVG()
-- Calculates the average of a numeric column across the window frame or partition.
-- Common Use: Comparing an individual row's value directly against its group or city average side-by-side (e.g., checking if an employee's salary is above their department average)

-- SUM()
-- Calculates the cumulative sum across a partition. When combined with `ORDER BY`, it calculates a **rolling or running total** row by row.
-- Common Use: Financial tracking, running account balances, or cumulative revenue analysis over time

-- MIN()
-- Returns the minimum value within the defined partition or entire dataset
-- Common Use: Identifying baseline thresholds (e.g., lowest rating or lowest cost) across categories while preserving individual row details[20][21]

-- MAX()
-- Returns the maximum value within the defined partition or dataset.
-- Common Use: Finding ceiling metrics (e.g., top product price or highest score in a group) adjacent to raw row values.

-- COUNT()
-- Counts the number of rows or non-null values within each partition
-- Common Use: Checking partition sizes or total group counts directly within detailed row queries

-- 3. Group By vs. Window Function Example

	-- Aggregate function with GROUP BY
	SELECT
		gender,
		AVG(salary) AS avg_salary
	FROM parks_and_recreation.employee_demographics dem
	JOIN parks_and_recreation.employee_salary sal
		ON dem.employee_id = sal.employee_id
	GROUP BY gender;

	-- Returns only 2 summary rows: one for Female, one for Male

-- Comparing Individual Rows to Group Averages Using WINDOW Function

	SELECT
		dem.employee_id,
		gender,
		AVG(salary) OVER()
	FROM parks_and_recreation.employee_demographics dem
	JOIN parks_and_recreation.employee_salary sal
		ON dem.employee_id = sal.employee_id;

-- Window Function (Preserves Rows)

SELECT
	dem.employee_id,
    dem.first_name,
    dem.last_name,
    gender,
    AVG(salary) OVER(PARTITION BY gender)
FROM parks_and_recreation.employee_demographics dem
JOIN parks_and_recreation.employee_salary sal
	ON dem.employee_id = sal.employee_id;

-- Returns every employee row, appending the average salary of their gender group directly in a new column

SELECT
	dem.first_name,
    dem.last_name,
    gender,
    AVG(salary) AS avg_salary
FROM parks_and_recreation.employee_demographics dem
JOIN parks_and_recreation.employee_salary sal
	ON dem.employee_id = sal.employee_id
GROUP BY dem.first_name, dem.last_name, gender;

-- 3. Rolling Totals (Cumulative Aggregation)

-- Combining an aggregate function like `SUM()` with `PARTITION BY` and `ORDER BY` creates a rolling (running) total that accumulates row-by-row within each partition.

	SELECT 
		dem.employee_id,
		dem.first_name,
		dem.last_name,
		gender,
		salary,
		SUM(salary) OVER(PARTITION BY gender) AS Total_Salary		-- Total grouped by gender
	FROM parks_and_recreation.employee_demographics dem
	JOIN parks_and_recreation.employee_salary sal
		ON dem.employee_id = sal.employee_id;

	-- Rolling Total (SUM() + Partition By + ORDER By)

	SELECT 
		dem.employee_id,
		dem.first_name,
		dem.last_name,
		gender,
		salary,
		SUM(salary) OVER(PARTITION BY gender ORDER BY dem.employee_id) AS Rolling_Total		-- Rolling total grouped by gender
	FROM parks_and_recreation.employee_demographics dem
	JOIN parks_and_recreation.employee_salary sal
		ON dem.employee_id = sal.employee_id;
    
-- 4. Ranking Window Functions
-- Ranking functions assign sequential numbers or ranks to rows based on a specified ordering within a partition

-- ROW_NUMBER()
-- Assigns a unique, sequential integer starting at 1 for every row within each partition. It never produces duplicate numbers, even if row values are tied
-- Common Use: Assigning unique IDs, deduplicating messy datasets (e.g., selecting `WHERE rank = 1` in a subquery), or paginating result sets.

-- RANK()
-- Assigns a rank based on the `ORDER BY` clause. If duplicate/tied values are encountered, it assigns them the same rank number, 
-- but **skips subsequent rank numbers positionally** (e.g., 1, 2, 3, 4, 5, 5, 7).
-- Common Use: Leaderboards and competitive rankings where gaps in rank reflect ties (e.g., top-performing products or sales reps).

-- DENSE_RANK()
-- Similar to `RANK()`, it assigns tied values the same rank, but **does not skip subsequent numbers** (e.g., 1, 2, 3, 4, 5, 5, 6).
-- Common Use: Assigning continuous tier rankings (e.g., salary or price tiers) where consecutive rank values are required without numerical gaps
    
	-- ROW_NUMBER()

	SELECT 
		dem.employee_id,
		dem.first_name,
		dem.last_name,
		gender,
		salary,
		ROW_NUMBER() OVER(PARTITION BY gender)
	FROM parks_and_recreation.employee_demographics dem
	JOIN parks_and_recreation.employee_salary sal
		ON dem.employee_id = sal.employee_id;
		
	SELECT 
		dem.employee_id,
		dem.first_name,
		dem.last_name,
		gender,
		salary,
		ROW_NUMBER() OVER(PARTITION BY gender ORDER BY salary DESC)
	FROM parks_and_recreation.employee_demographics dem
	JOIN parks_and_recreation.employee_salary sal
		ON dem.employee_id = sal.employee_id;
		
	-- RANK()

	-- Ranking functions evaluate ordering rules to assign numbers or rankings to individual rows within a partition

	SELECT 
		dem.employee_id,
		dem.first_name,
		dem.last_name,
		gender,
		salary,
		ROW_NUMBER() OVER(PARTITION BY gender ORDER BY salary DESC) AS row_num,
		RANK() OVER(PARTITION BY gender ORDER BY salary DESC) AS rank_num
	FROM parks_and_recreation.employee_demographics dem
	JOIN parks_and_recreation.employee_salary sal
		ON dem.employee_id = sal.employee_id;

	-- RANK()
	-- Assigns rank numbers based on ordering.
	-- If tied values exist (e.g., two salaries at $50,000), they receive the same rank, and subsequent ranks **skip numbers positionally** (e.g., 1, 2, 3, 4, 5, 5, 7)

	SELECT 
		dem.employee_id,
		dem.first_name,
		dem.last_name,
		gender,
		salary,
		ROW_NUMBER() OVER(PARTITION BY gender ORDER BY salary DESC) AS row_num,
		RANK() OVER(PARTITION BY gender ORDER BY salary DESC) AS rank_num
	FROM parks_and_recreation.employee_demographics dem
	JOIN parks_and_recreation.employee_salary sal
		ON dem.employee_id = sal.employee_id;
		
	-- DENSE_RANK()
	-- Functions like `RANK()`, but **does not skip numbers** after ties (e.g., 1, 2, 3, 4, 5, 5, 6)

	SELECT 
		dem.employee_id,
		dem.first_name,
		dem.last_name,
		gender,
		salary,
		ROW_NUMBER() OVER(PARTITION BY gender ORDER BY salary DESC) AS row_num,
		DENSE_RANK() OVER(PARTITION BY gender ORDER BY salary DESC) AS dense_rank_num
	FROM parks_and_recreation.employee_demographics dem
	JOIN parks_and_recreation.employee_salary sal
		ON dem.employee_id = sal.employee_id;

-- 3. Value Window Functions
-- Value functions allow you to evaluate specific target values from preceding, succeeding, or boundary rows within a partition

-- LAG()
-- Accesses data from a preceding (prior) row within the same partition at a given offset without needing a self-join.
-- Common Use: Period-over-period comparisons, such as calculating month-over-month revenue growth or change from the prior record.

-- LEAD()
-- Accesses data from a succeeding (following) row within the partition at a given offsetAccesses data from a succeeding (following) row within the partition at a given offset.
-- Common Use: Looking ahead to upcoming events or calculating time gaps between sequential user actions.

-- FIRST_VALUE()
-- Returns the first value in an ordered partition or window frame
-- Common Use: Benchmarking every record in a group against the top or initial entry (e.g., comparing current prices to a baseline launch price).

-- LAST_VALUE()
-- Returns the last value in an ordered partition or window frame
-- Common Use: Comparing individual records against the latest or lowest boundary value in a window.

	-- LAG() and LEAD()
	-- **LAG(column, offset)**: Accesses data from a row **preceding** the current row by a specified offset (default is `1`).
	-- **LEAD(column, offset)**: Accesses data from a row **following** the current row by a specified offset (default is `1`).

	SELECT
		employee_id,
		first_name,
		salary,
		LAG(salary, 1) OVER(ORDER BY salary DESC) AS previous_higher_salary,
		salary - LAG(salary, 1) OVER(ORDER BY salary DESC) as salary_difference,
		LEAD(salary, 1) OVER(ORDER BY salary DESC) AS next_lower_salary
	FROM parks_and_recreation.employee_salary;

	-- FIRST_VALUE()
	-- Returns the value from the **first row** in the partition or ordered window.

	SELECT
		employee_id,
		first_name,
		dept_id,
		salary,
		FIRST_VALUE(salary) OVER(PARTITION BY dept_id ORDER BY salary DESC) AS top_dept_salary,
		FIRST_VALUE(salary) OVER(PARTITION BY dept_id ORDER BY salary DESC) - salary AS gap_from_top
	FROM parks_and_recreation.employee_salary;

	-- LAST_VALUE()
	-- Returns the value from the **last row** in the window frame

	SELECT
		employee_id,
		first_name,
		dept_id,
		salary,
		LAST_VALUE(salary) OVER(PARTITION BY dept_id ORDER BY salary DESC ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS lowest_dept_salary
	FROM parks_and_recreation.employee_salary;