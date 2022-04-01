USE employees;

/************************************* Question 2 *******************************************/
# In your script, use DISTINCT to find the unique titles in the titles table. How many unique
# titles have there ever been? Answer that in a comment in your SQL file.

SELECT DISTINCT title
FROM titles;
# There have been 7 distinct titles


/************************************* Question 3 *******************************************/
# Write a query to to find a list of all unique last names of all employees that start and 
# end with 'E' using GROUP BY.

SELECT last_name
FROM employees
WHERE last_name LIKE "E%E"
GROUP BY last_name;


/************************************* Question 4 *******************************************/
# Write a query to to find all unique combinations of first and last names of all employees 
# whose last names start and end with 'E'.

SELECT first_name,last_name
FROM employees
WHERE last_name LIKE "E%E"
GROUP BY last_name, first_name
ORDER BY last_name;


/************************************* Question 5 *******************************************/
# Write a query to find the unique last names with a 'q' but not 'qu'. Include those names 
# in a comment in your sql code.

SELECT last_name
FROM employees
WHERE last_name LIKE '%q%'
  AND last_name NOT LIKE '%qu%'
GROUP BY last_name;
# Answer: Chleq, Lindqvist, Qiwen


/************************************* Question 6 *******************************************/
# Add a COUNT() to your results (the query above) to find the number of employees with the 
# same last name.

SELECT last_name, COUNT(*)
FROM employees
WHERE last_name LIKE '%q%'
  AND last_name NOT LIKE '%qu%'
GROUP BY last_name;
# Answer:
# Chleq: 189
# Lindqvist: 190
# Qiwen: 168


/************************************* Question 7 *******************************************/
# Find all all employees with first names 'Irena', 'Vidya', or 'Maya'. Use COUNT(*) and 
# GROUP BY to find the number of employees for each gender with those names.

SELECT first_name, gender, COUNT(*)
FROM employees
WHERE first_name IN ('Irena', 'Vidya', 'Maya')
GROUP BY first_name, gender
ORDER BY first_name;
#   Irena		   Maya	          Vidya
# M:144 F:97 	M:146 F:90	   M:151 F: 81


/************************************* Question 8 *******************************************/
# Using your query that generates a username for all of the employees, generate a count 
# employees for each unique username. Are there any duplicate usernames? 
# BONUS: How many duplicate usernames are there?

SELECT CONCAT(SUBSTR(LOWER(first_name), 1, 1), 
	   SUBSTR(LOWER(last_name), 1, 4), 
       '_', 
       SUBSTR(birth_date, 6, 2), 
       SUBSTR(birth_date, 3, 2)) AS username,
       COUNT(*)
FROM employees
GROUP BY username
HAVING COUNT(*) >= 2;

SELECT SUM(total)
FROM ( SELECT CONCAT(SUBSTR(LOWER(first_name), 1, 1), 
	   SUBSTR(LOWER(last_name), 1, 4), 
       '_', 
       SUBSTR(birth_date, 6, 2), 
       SUBSTR(birth_date, 3, 2)) AS username,
       COUNT(*) AS total
	   FROM employees
       GROUP BY username
       HAVING total >= 2
) AS total_count;
# Answer 1: There are duplicate usernames.
# Total before adjustment: 27403


# Counting amount of usernames that have duplicates
SELECT COUNT(*)
FROM ( SELECT CONCAT(SUBSTR(LOWER(first_name), 1, 1), 
	   SUBSTR(LOWER(last_name), 1, 4), 
       '_', 
       SUBSTR(birth_date, 6, 2), 
       SUBSTR(birth_date, 3, 2)) AS username,
       COUNT(*)
FROM employees
GROUP BY username
HAVING COUNT(*) >= 2) AS Total_Rows;
# 13251 usernames that have duplicates
# 14152 total duplicates (assuming the original username is not counted as duplicate)


/************************************* Question 9 *******************************************/
# a) Determine the historic average salary for each employee. When you hear, read, or think
#    "for each" with regard to SQL, you'll probably be grouping by that exact column.

SELECT emp_no, ROUND(AVG(salary), 2) AS AverageSalary
FROM salaries
GROUP BY emp_no;


# b) Using the dept_emp table, count how many current employees work in each
# department. The query result should show 9 rows, one for each department and 
# the employee count.

SELECT dept_no, COUNT(dept_no)
FROM dept_emp
GROUP BY dept_no;
# Answer:
# d001: 20211    d002: 17346   d003: 17786
# d004: 73485    d005: 85707   d006: 20117
# d007: 52245    d008: 21126   d009: 23580


# c) Determine how many different salaries each employee has had. This includes
# both historic and current.

SELECT emp_no, COUNT(salary) AS DifferentSalaries
FROM salaries
GROUP BY emp_no;


# d) Find the maximum salary for each employee.

SELECT emp_no, MAX(salary) AS MaxSalary
FROM salaries
GROUP BY emp_no;


# e) Find the minimum salary for each employee.

SELECT emp_no, MIN(salary) AS MinSalary
FROM salaries
GROUP BY emp_no;


# f) Find the standard deviation of salaries for each employee.

SELECT emp_no, ROUND(STDDEV(salary), 2) AS StdDevOfSalary
FROM salaries
GROUP BY emp_no;


# g) Now find the max salary for each employee where that 
# max salary is greater than $150,000.

SELECT emp_no, MAX(salary) AS MaxSalary
FROM salaries
GROUP BY emp_no
HAVING MaxSalary > 150000;


# h) Find the average salary for each employee where 
# that average salary is between $80k and $90k.

SELECT emp_no, ROUND(AVG(salary), 2) AS AverageSalary
FROM salaries
GROUP BY emp_no
Having AverageSalary BETWEEN 80000 AND 90000;