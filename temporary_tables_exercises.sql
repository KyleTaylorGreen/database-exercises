USE employees;

/*************************************************** Exercise 1 ******************************************************/
-- Specify the db where you have permissions and add the temp table name.
-- Replace "my_database_with_permissions"" with the database name where you have appropriate permissions. 
#  It should match your username.
CREATE TEMPORARY TABLE jemison_1739.employees_with_departments AS 
SELECT * FROM employees JOIN dept_emp USING(emp_no);

-- Change the current db.
USE jemison_1739;
SELECT * FROM employees_with_departments;

# Add full name column
ALTER TABLE employees_with_departments ADD full_name VARCHAR(255);

# updating column with values
UPDATE employees_with_departments
SET full_name = CONCAT(first_name, " ", last_name);

SELECT * FROM employees_with_departments;

# Dropping first/last name columns
ALTER TABLE employees_with_departments DROP COLUMN first_name;
ALTER TABLE employees_with_departments DROP COLUMN last_name;

SELECT * FROM employees_with_departments;


/*************************************************** Exercise 2 ******************************************************/

USE sakila;

# Creating table
CREATE TEMPORARY TABLE jemison_1739.payment_in_cents AS
SELECT * FROM sakila.payment;

# viewing table
USE jemison_1739;
SELECT * FROM payment_in_cents;

# Added/dropped column before realizing I had to transform one of the original columns
ALTER TABLE payment_in_cents ADD amount_in_cents DECIMAL;
ALTER TABLE payment_in_cents DROP amount_in_cents;

# Modified table to compatible numeric type so it could be multiplied by 100, then converted to INT
ALTER TABLE payment_in_cents MODIFY amount DECIMAL(6,2);
UPDATE payment_in_cents
SET amount = amount * 100;
ALTER TABLE payment_in_cents MODIFY amount INT;

# Viewing results
SELECT * FROM payment_in_cents;

/*************************************************** Exercise 3 ******************************************************/

USE employees;

# created temporary table with current salaries, grouped by department
CREATE TEMPORARY TABLE jemison_1739.salaries_in_departments AS 
SELECT departments.dept_name, AVG(salaries.salary) AS AvgSalary
FROM employees
JOIN dept_emp USING(emp_no) 
JOIN salaries USING(emp_no)
JOIN departments USING(dept_no)
WHERE salaries.to_date > NOW()
GROUP BY departments.dept_name;

# viewing for testing purposes
USE jemison_1739;
SELECT * FROM salaries_in_departments;


# Finding standard deviation using the department averages against overall historical average
SELECT (AvgSalary - (SELECT AVG(salary) FROM employees.salaries)) /
	   (SELECT stddev(salary) FROM employees.salaries) AS zscore, AvgSalary,
		salaries_in_departments.dept_name
FROM salaries_in_departments
GROUP BY AvgSalary, salaries_in_departments.dept_name
ORDER BY zscore DESC
LIMIT 1;
