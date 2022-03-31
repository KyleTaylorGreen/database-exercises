USE employees;

/************************************* Question 2 ***************************************/
# Find all employees with first names 'Irena', 'Vidya', or 'Maya', and order your results 
# returned by first name. In your comments, answer: What was the first and last name in 
# the first row of the results? What was the first and last name of the last person in 
# the table?

# Finding all employees with first names 'Irena', 'Vidya', or 'Maya', ordered by first name
SELECT emp_no, first_name, last_name
FROM employees
WHERE first_name IN ('Irena', 'Vidya', 'Maya')
ORDER BY first_name;
# Answer 1: Irena Reutenauer
# Answer 2: Vidya Simmen


/************************************* Question 3 ***************************************/
# Find all employees with first names 'Irena', 'Vidya', or 'Maya', and order your results 
# returned by first name and then last name. In your comments, answer: What was the first 
# and last name in the first row of the results? What was the first and last name of the 
# last person in the table?

#Ordering all employees named 'Irena', 'Vidya', or 'Maya' by first then last name
SELECT emp_no, first_name, last_name
FROM employees
WHERE first_name IN ('Irena', 'Vidya', 'Maya')
ORDER BY first_name, last_name;
# Answer 1: Irena Acton
# Answer 2: Vidya Zweizig


/************************************* Question 4 ***************************************/
# Find all employees with first names 'Irena', 'Vidya', or 'Maya', and order your results 
# returned by last name and then first name. In your comments, answer: What was the first 
# and last name in the first row of the results? What was the first and last name of the 
# last person in the table?

# Finding employees named 'Irena', 'Vidya', or 'Maya' ordered by last and then first name.
SELECT emp_no, first_name, last_name
FROM employees
WHERE first_name IN ('Irena', 'Vidya', 'Maya')
ORDER BY last_name, first_name;
# Answer 1: Irena Acton
# Answer 2: Maya Zyda


/************************************* Question 5 ***************************************/
# Write a query to to find all employees whose last name starts and ends with 'E'. Sort 
# the results by their employee number. Enter a comment with the number of employees 
# returned, the first employee number and their first and last name, and the last employee
# number with their first and last name.

# Finding all employees whose last name starts and ends with E, sorted by employee number
SELECT emp_no, first_name, last_name
#SELECT COUNT(*)
FROM employees
WHERE last_name LIKE '%e'
	AND last_name LIKE 'E%'
ORDER BY emp_no;
# Answer 1: 899
# Answer 2: 10021 - Ramzi Erde
# Answer 3: 499648 - Tadahiro Erde

/************************************* Question 6 ***************************************/
# Write a query to to find all employees whose last name starts and ends with 'E'. 
# Sort the results by their hire date, so that the newest employees are listed first. 
# Enter a comment with the number of employees returned, the name of the newest employee, 
# and the name of the oldest employee.

# Finding/Counting all employees whose last name starts and ends with 'e', sorted by 
# hire date
#SELECT COUNT(*)
SELECT emp_no, first_name, last_name, hire_date
FROM employees
WHERE last_name LIKE 'E%'
	AND last_name LIKE '%e'
ORDER BY hire_date DESC;
# Answer 1: 899
# Answer 2: Teiji Eldridge
# Answer 3: Sergi Erde


/************************************* Question 7 ***************************************/
# Find all employees hired in the 90s and born on Christmas. Sort the results so that the 
# oldest employee who was hired last is the first result. 
# Enter a comment with the number of employees returned, the name of the oldest employee 
# who was hired last, and the name of the youngest employee who was hired first.

# Finding all employees hired in 90s and born on Christmas, sorted by age/hire date
#SELECT COUNT(*)
SELECT emp_no, first_name, last_name, birth_date, hire_date
FROM employees
WHERE birth_date LIKE '____-12-25'
	AND hire_date BETWEEN '1990-01-01' AND '1999-12-31'
ORDER BY birth_date, hire_date DESC;
# Answer 1: 362
# Answer 2: Khun Bernini
# Answer 3: Douadi Pettis