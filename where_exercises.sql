USE employees;

/**************************** Question 2 ********************************************/
# Find all current or previous employees with first names 'Irena', 'Vidya', or 'Maya' 
# using IN. Enter a comment with the number of records returned.

# verifying output
SELECT emp_no, first_name, last_name 
FROM employees
WHERE first_name IN ('Irena', 'Vidya', 'Maya');

# actually counting results
SELECT COUNT(*)
FROM employees
WHERE first_name IN ('Irena', 'Vidya', 'Maya');
# Answer - this is the format for the whole document.
# 709 rows counted

/**************************** Question 3 ********************************************/
# Find all current or previous employees with first names 'Irena', 'Vidya', or 'Maya',
# as in Q2, but use OR instead of IN. Enter a comment with the number of records 
# returned. Does it match number of rows from Q2?

# Finding employees with names 'Irena', 'Vidya', and 'Maya'.
SELECT emp_no, first_name, last_name
FROM employees
WHERE first_name = 'Irena'
OR first_name = 'Vidya'
OR first_name = 'Maya';

#Counting based on query above
SELECT COUNT(*)
FROM employees
WHERE first_name = 'Irena'
OR  first_name = 'Vidya'
OR first_name = 'Maya';
# 709 records returned, number of records returned match from question 2.


/**************************** Question 4 ********************************************/
# Find all current or previous employees with first names 'Irena', 'Vidya', or 'Maya', 
# using OR, and who is male. Enter a comment with the number of records returned.

# Find employees who are male and have any of the first names 'Irena', 'Vidya', or 'Maya'.
SELECT emp_no, first_name, last_name
FROM employees
WHERE gender = 'M'
	AND (
		first_name = 'Irena'
    OR  first_name = 'Vidya'
    OR  first_name = 'Maya'
);

# Counting based on query above
SELECT COUNT(*)
FROM employees
WHERE gender = 'M'
	AND (
		first_name = 'Irena'
    OR  first_name = 'Vidya'
    OR  first_name = 'Maya'
);
# 441 records returned


/**************************** Question 5 ********************************************/
# Find all current or previous employees whose last name starts with 'E'. Enter a 
# comment with the number of employees whose last name starts with E.

# Finding employees whose last name starts with 'E'.
SELECT emp_no, first_name, last_name
FROM employees
WHERE last_name LIKE 'E%';

# Counting using same query above
SELECT COUNT(*) AS 'E'
FROM employees
WHERE last_name LIKE 'E%';
# 7330 people have last names that start with 'E'.


/**************************** Question 6 ********************************************/
# Find all current or previous employees whose last name starts or ends with 'E'. 
# Enter a comment with the number of employees whose last name starts or ends with E. 
# How many employees have a last name that ends with E, but does not start with E?

# Finding employees whose last name starts OR ends with 'E'.
SELECT emp_no, first_name, last_name
FROM employees
WHERE last_name LIKE 'E%'
  OR last_name LIKE '%e';

# Counting based on the same query above
SELECT COUNT(*)
FROM employees
WHERE last_name LIKE 'E%'
  OR last_name LIKE '%e';
# 30723 peoples' last names start or end with 'E'.

# Find employees whose last name ends with 'E' but does not start with 'E'.
SELECT COUNT(*)
FROM employees
WHERE last_name LIKE '%e'
  AND last_name NOT LIKE 'E%';
# 23393 people returned


/**************************** Question 7 ********************************************/
# Find all current or previous employees employees whose last name starts and ends 
# with 'E'. Enter a comment with the number of employees whose last name starts and 
# ends with E. How many employees' last names end with E, regardless of whether 
# they start with E?

# Finding employees whose last name starts and ends with 'E'.
SELECT emp_no, first_name, last_name
FROM employees
WHERE last_name LIKE 'E%'
  AND last_name LIKE '%e';

# Counting based on previous query  
SELECT COUNT(*)
FROM employees
WHERE last_name LIKE 'E%'
  AND last_name LIKE '%e';
# 899 people have a last name that starts and ends with 'E'. 

# Finding employees whose last name ends with 'E'
SELECT emp_no, first_name, last_name
FROM employees
WHERE last_name LIKE "%e";

# Counting based on above query
SELECT COUNT(*)
FROM employees
WHERE last_name LIKE "%e";
# 24292 people have a last name that ends with 'e'

/**************************** Question 8 ********************************************/
# Find all current or previous employees hired in the 90s. Enter a comment with the 
# number of employees returned.

# Finding employees who were hired in the 90's
SELECT emp_no, first_name, last_name, hire_date
FROM employees
WHERE hire_date BETWEEN '1990-01-01' AND '1999-12-31';

# Counting based on query above
SELECT COUNT(*)
FROM employees
WHERE hire_date BETWEEN '1990-01-01' AND '1999-12-31';
# 135,214 people were hired in the 90's


/**************************** Question 9 ********************************************/
# Find all current or previous employees born on Christmas. Enter a comment with the 
# number of employees returned.

# Finding all employees born on Christmas
SELECT emp_no, first_name, last_name, birth_date
FROM employees
WHERE DAY(birth_date) = '25'
  AND MONTH(birth_date) = '12';

# Counting based on query above  
SELECT COUNT(*)
FROM employees
WHERE DAY(birth_date) = '25'
  AND MONTH(birth_date) = '12';
# 842 people were born on Christmas


/**************************** Question 10 ********************************************/
# Find all current or previous employees hired in the 90s and born on Christmas. 
# Enter a comment with the number of employees returned.

#Testing using BETWEEN with dates and DAY/MONTH functions
SELECT emp_no, first_name, last_name, hire_date, birth_date
FROM employees
WHERE hire_date BETWEEN '1990-01-01' AND '1999-12-31'
  AND ( DAY(birth_date) = '25'
	AND MONTH(birth_date) = '12'
);

# testing using 'LIKE' wildcards I'd never used before
SELECT emp_no, first_name, last_name, hire_date, birth_date
FROM employees
WHERE birth_date LIKE '____-12-25'
  AND YEAR(hire_date) BETWEEN 1990 AND 1999;

# Counting based on first query
SELECT COUNT(*)
FROM employees
WHERE hire_date BETWEEN '1990-01-01' AND '1999-12-31'
  AND ( DAY(birth_date) = '25'
	AND MONTH(birth_date) = '12'
);
# 362 people were born on Christmas and hired in the 90's

# Counting using method I hadn't used before
SELECT COUNT(*)
FROM employees
WHERE birth_date LIKE '____-12-25'
  AND YEAR(hire_date) BETWEEN 1990 AND 1999;
# 362 people confirmed with other method


/**************************** Question 11 ********************************************/
# Find all current or previous employees with a 'q' in their last name. Enter a 
# comment with the number of records returned.

# Finding employees with 'q' in their last name
SELECT emp_no, first_name, last_name
FROM employees
WHERE last_name LIKE '%q%';

SELECT COUNT(*)
FROM employees
WHERE last_name LIKE '%q%';
# 1873 people have a 'q' in their last name


/**************************** Question 12 ********************************************/
# Find all current or previous employees with a 'q' in their last name but not 'qu'. 
# How many employees are found?

# Finding employees with a 'q' in their last name but not 'qu'.
SELECT emp_no, first_name, last_name
FROM employees
WHERE last_name LIKE '%q%'
  AND last_name NOT LIKE '%qu%';
  
# Counting based on the query above
SELECT COUNT(*)
FROM employees
WHERE last_name LIKE '%q%'
  AND last_name NOT LIKE '%qu%';
# There are 547 people that have 'q' in their name but not 'qu'.