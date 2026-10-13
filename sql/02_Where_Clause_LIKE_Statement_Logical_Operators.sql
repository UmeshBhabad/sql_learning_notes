-- Where Clause

-- The WHERE clause filters rows or records from a dataset based on specified conditions.

-- While the `SELECT` statement determines which *columns* appear in the result set,
-- the `WHERE` clause dictates which *rows* meet the criteria to be included.

SELECT *
FROM parks_and_recreation.employee_salary;

-- 1. Comparision Operators

-- Comparison operators compare values in a column against a literal value, expression, or another column.
-- =(Equal to): WHERE first_name = 'Leslie'
-- > / <(Greater than / Less than): WHERE salary > 50000
-- >= / <= (Greater than or equal to / Less than or equal to): WHERE salary >= 50000
-- <> or !=(Not equal to): Filters out exact matching rows.

-- Note on Dates: Dates in MySQL follow the default 'YYYY-MM-DD' string format and can be compared directly using standard comparison operators (e.g. WHERE birth_date > '1985-01-01').

SELECT *
FROM parks_and_recreation.employee_salary
WHERE first_name = 'Leslie';

SELECT *
FROM parks_and_recreation.employee_salary
WHERE salary <= 50000;

SELECT *
FROM parks_and_recreation.employee_demographics
WHERE gender != 'Female';

SELECT *
FROM parks_and_recreation.employee_demographics
WHERE birth_date > '1985-01-01';

-- 2. Logical Operators(AND, OR, NOT)

SELECT *
FROM parks_and_recreation.employee_demographics
WHERE birth_date > '1985-01-01'
AND gender = 'male';

SELECT *
FROM parks_and_recreation.employee_demographics
WHERE birth_date > '1985-01-01'
OR gender = 'male';

SELECT *
FROM parks_and_recreation.employee_demographics
WHERE NOT gender = 'Male';

SELECT *
FROM parks_and_recreation.employee_demographics
WHERE birth_date > '1985-01-01'
OR NOT gender = 'Female';

-- Parentheses Precedence

SELECT *
FROM parks_and_recreation.employee_demographics
WHERE (first_name = 'Leslie' AND age = 44) OR age > 55;

-- 3. Special Evaluation Operators

-- BETWEEN ... AND ...

SELECT *
FROM parks_and_recreation.employee_salary
WHERE salary BETWEEN 50000 AND 75000;

SELECT *
FROM parks_and_recreation.employee_salary
WHERE occupation IN (' Office Manager', 'Director of Parks and Recreation', 'Parks Director');

-- LIKE Statement

SELECT *
FROM parks_and_recreation.employee_demographics
WHERE first_name LIKE 'a%'; -- start with alter

SELECT *
FROM parks_and_recreation.employee_demographics
WHERE first_name LIKE '%a'; -- end with a

SELECT *
FROM parks_and_recreation.employee_demographics
WHERE first_name LIKE 'a%y'; -- start with a and end with y

SELECT *
FROM parks_and_recreation.employee_demographics
WHERE first_name LIKE '%a%'; -- contains a anywhere

SELECT *
FROM parks_and_recreation.employee_demographics
WHERE first_name LIKE '_a%'; -- second letter a

SELECT *
FROM parks_and_recreation.employee_demographics
WHERE first_name LIKE 'a__%'; -- start with a followed by 2 characters

SELECT *
FROM parks_and_recreation.employee_demographics
WHERE birth_date LIKE '1989%'; -- start with 1989

-- IS NULL / IS NOT NULL

SELECT *
FROM parks_and_recreation.employee_salary
WHERE dept_id IS NULL;
