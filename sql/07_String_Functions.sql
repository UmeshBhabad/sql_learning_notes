-- String Functions

-- String functions are built-in SQL tools used to manipulate, clean, extract, and format text data.
-- They play a major role in real-world data cleaning and standardization workflows.

-- 1. Character Count & Case Manipulation

	-- LENGTH
	-- Returns the total count of characters in a given string or text column.

	SELECT LENGTH('skyfall');

	SELECT first_name, LENGTH(first_name)
	FROM parks_and_recreation.employee_demographics
	ORDER BY 2;

	-- CHAR_LENGTH

	SELECT CHAR_LENGTH('Jay Ganesh');

	-- UPPER and LOWER
	-- **UPPER()**: Converts all characters in a string to uppercase.
	-- **LOWER()**: Converts all characters in a string to lowercase.

	SELECT UPPER('skyfall');
	SELECT LOWER('SKYFALL');

	SELECT first_name, UPPER(first_name)
	FROM parks_and_recreation.employee_demographics;

	SELECT first_name, LOWER(first_name)
	FROM parks_and_recreation.employee_demographics;

-- 2. Trimming Whitespace & Punctuation

	-- TRIM

	-- **TRIM()**: Removes leading and trailing white space from both ends of a string

	SELECT TRIM('          sky          ');
	-- SELECT TRIM('Jay Ganesh'); -- No effect


	-- **LTRIM()** *(Left Trim)*: Removes white space only from the left side (start) of a string

	SELECT LTRIM('          sky          ');

	-- **RTRIM()** *(Right Trim)*: Removes white space only from the right side (end) of a string

	SELECT RTRIM('          sky          ');

-- 3. Extracting Substrings (LEFT, RIGHT, SUBSTRING)

-- LEFT & RIGHT

	-- **LEFT()**: Extracts a specified number of characters from the left side of a string

	SELECT first_name, LEFT(first_name, 4)
	FROM parks_and_recreation.employee_demographics;

	-- **RIGHT()**: Extracts a specified number of characters from the right side of a string
	SELECT first_name, RIGHT(first_name, 3)
	FROM parks_and_recreation.employee_demographics;

-- SUBSTRING
-- Extracts a portion of a string starting at a specific position for a designated character count

	SELECT first_name, SUBSTRING(first_name, 3, 2)	-- SUBSTRING(string, start_position, length)
	FROM parks_and_recreation.employee_demographics;

	SELECT first_name, SUBSTRING(birth_date, 6, 2) AS birth_month
	FROM parks_and_recreation.employee_demographics;

	-- SUBSTRING_INDEX
	-- Extracts a substring before or after a specified number of delimiter occurrences

	SELECT SUBSTRING_INDEX('umeshbhabad@gmail.com', '@', -1); -- SUBSTRING_INDEX(string, delimiter, count)

-- 4. Searching & Replacing Text (REPLACE, LOCATE)

	-- REPLACE
	-- Searches a string for a specific target substring or character and replaces all occurrences with a new value

	SELECT first_name, REPLACE(first_name, 'a', 'z')		-- REPLACE(string, target_substring, replacement_string)
	FROM parks_and_recreation.employee_demographics;

	-- LOCATE
	-- Returns the numeric starting position of a specified substring or character inside a target string[17]. Returns `0` if the target is not found.

	SELECT LOCATE('x', 'Alexander');

	SELECT first_name, LOCATE('an', first_name)		-- LOCATE(substring_to_find, string_to_search)
	FROM parks_and_recreation.employee_demographics;

-- 5. Combining Columns (CONCAT)

	-- CONCAT
	-- Merges two or more separate strings or table columns together into a single unified string

	SELECT first_name, CONCAT(first_name, ' ', last_name) AS full_name		-- CONCAT(string1, string2, ...)
	FROM parks_and_recreation.employee_demographics;

-- STR_TO_DATE()
-- Converts a text string formatted as a date into a standard SQL `DATE` data type

SELECT STR_TO_DATE('09/09/2026', '%m/%d/%Y');

-- Using dashes
SELECT STR_TO_DATE('31-01-2023', '%d-%m-%Y'); -- Returns: 2023-01-31

-- Using slashes and 2-digit year
SELECT STR_TO_DATE('10/25/26', '%m/%d/%y');

-- Text-based dates (Note the literal comma matching the input)
SELECT STR_TO_DATE('May 5, 2020', '%M %d, %Y'); -- Returns: 2020-05-05