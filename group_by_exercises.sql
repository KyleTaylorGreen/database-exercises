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
GROUP BY username WITH ROLLUP
HAVING COUNT(*) >= 2;
# Answer 1: There are duplicate usernames.
# Total before adjustment: 300024


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
# 286772 total duplicates


/************************************* Question 9 *******************************************/
