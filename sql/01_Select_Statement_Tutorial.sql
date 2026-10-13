-- SELECT Statement

-- Select ALL columns

select *
FROM parks_and_recreation.employee_demographics;

-- Select specific columns

select 
	first_name,
    last_name,
    birth_date,
    age
FROM parks_and_recreation.employee_demographics;

-- Expressions & Inline Calculations

select 
	first_name,
    last_name,
    birth_date,
    age,
    (age + 10) * 10 + 10
FROM parks_and_recreation.employee_demographics;

-- PEMDAS

# P : Paranthesses
# E : Exponential
# M : Multiplication
# D : Division
# A : Addition
# S : Subtraction

-- DISTINCT Keyword

SELECT
	DISTINCT first_name,
    gender
FROM parks_and_recreation.employee_demographics;

SELECT
	DISTINCT gender
FROM parks_and_recreation.employee_demographics;