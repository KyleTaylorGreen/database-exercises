USE employees;

/************************************* Question 2 ***************************************/
# Write a query to to find all employees whose last name starts and ends with 'E'. 
# Use concat() to combine their first and last name together as a single column named full_name.

# Answer:
SELECT CONCAT(first_name, ' ', last_name) AS full_name
FROM employees
WHERE last_name LIKE '%e'
	AND last_name LIKE 'E%';


/************************************* Question 3 ***************************************/
# Convert the names produced in your last query to all uppercase.

# Answer:
SELECT UPPER(CONCAT(first_name, ' ', last_name)) AS full_name
FROM employees
WHERE last_name LIKE '%e'
	AND last_name LIKE 'E%';
    

/************************************* Question 4 ***************************************/
# Find all employees hired in the 90s and born on Christmas. Use datediff() function to 
# find how many days they have been working at the company (Hint: You will also need to 
# use NOW() or CURDATE()),

# Answer:
SELECT first_name, last_name, hire_date, DATEDIFF(NOW(), hire_date), NOW()
FROM employees
WHERE birth_date LIKE '____-12-25'
	AND hire_date BETWEEN '1990-01-01' AND '1999-12-31';


/************************************* Question 5 ***************************************/
# Find the smallest and largest current salary from the salaries table.

SELECT MIN(salary), MAX(salary)
FROM salaries
WHERE to_date > NOW();
# Min salary: $38623
# Max salary: $158220


/************************************* Question 6 ***************************************/
# Use your knowledge of built in SQL functions to generate a username for all of the 
# employees. A username should be all lowercase, and consist of the first character of 
# the employees first name, the first 4 characters of the employees last name,
# an underscore, the month the employee was born, and the last two digits of the year 
# that they were born. Below is an example of what the first 10 rows will look like: N/A

# Answer
# Making usernames in format xxxxx_#### based on above requirements
SELECT LOWER(CONCAT(SUBSTR(first_name, 1, 1), 
	   SUBSTR(last_name, 1, 4), 
       '_', 
       SUBSTR(birth_date, 6, 2), 
       SUBSTR(birth_date, 3, 2))) AS username, 
       first_name, 
       last_name, 
       birth_date
FROM employees