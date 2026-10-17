-- Triggers & Events

-- 1. SQL Triggers

-- A trigger is a block of SQL code that executes automatically whenever a specific **data modification event** — such as an `INSERT`, `UPDATE`, or `DELETE` — takes place on a target table.
-- Triggers are used to enforce business rules, maintain audit trails, and keep related tables synchronized automatically.

-- Trigger Timing (BEFORE/AFTER): Determines whether the trigger runs before or after the triggering event completes.

-- Execution Scope (FOR EACH ROW): Ensures the trigger code runs for every individual row affected by the query.

-- Context Keywords (NEW/OLD):
-- * `NEW`: Refers to the new row values being inserted or updated.
-- * `OLD`: Refers to the existing row values being deleted or overwritten.

SELECT *
FROM parks_and_recreation.employee_demographics;

SELECT *
FROM parks_and_recreation.employee_salary;

-- Trigger Example: Auto-Populating Demographics

DELIMITER $$

CREATE TRIGGER employee_insert
	AFTER INSERT ON employee_salary
    FOR EACH ROW
BEGIN
	INSERT INTO parks_and_recreation.employee_demographics(employee_id, first_name, last_name)
	VALUES (NEW.employee_id, NEW.first_name, NEW.last_name);
END $$

DELIMITER ;


-- Testing the Trigger
INSERT INTO employee_salary (employee_id, first_name, last_name, occupation, salary, dept_id)
VALUES(13, 'Umesh', 'Bhabad', 'Software Developer', 100000, NULL);

-- Dropping trigger

DROP TRIGGER IF EXISTS employee_insert;

-- 2. EVENTS

-- An event is a scheduled task that executes automatically according to a predefined time schedule (such as every day, every month, or every 30 seconds),
-- rather than firing in response to a table action.

-- Events act as background automators for recurring administrative tasks like pulling data feeds, exporting scheduled reports, or purging outdated records.

-- Event Example: Scheduled Employee Retirement Cleanup

SELECT *
FROM parks_and_recreation.employee_demographics;

DELIMITER $$

CREATE EVENT delete_retirees
ON SCHEDULE EVERY 30 SECOND
DO
BEGIN
	DELETE
	FROM parks_and_recreation.employee_demographics
    WHERE age >= 60;
END $$

DELIMITER ;

SHOW VARIABLES LIKE 'event%';

DROP EVENT IF EXISTS parks_and_recreation.delete_retirees;

### 3. Quick Comparison: Triggers vs. Events

-- | Feature          | Trigger                                                   | Event                                                          |
-- | ---------------- | ----------------------------------------------------------| ---------------------------------------------------------------|
-- | Activation Cause | Table actions (`INSERT`, `UPDATE`, `DELETE`)              | Time-based schedule (`EVERY 1 DAY`, `EVERY 30 SECOND`)    	   |
-- | Primary Goal     | Data integrity, auditing, and multi-table synchronization | Automated maintenance, scheduled reporting, and data archiving |
-- | Row Reference    | Uses `NEW` and `OLD` row aliases                          | Operates on standard query filter conditions	               |
