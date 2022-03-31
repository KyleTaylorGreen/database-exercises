USE employees;

/************************************** Question 2 ****************************************/
# List the first 10 distinct last name sorted in descending order.

# Answer:
SELECT DISTINCT last_name
FROM employees
ORDER BY last_name DESC
LIMIT 10;


/************************************** Question 3 ****************************************/
# Find all previous or current employees hired in the 90s and born on Christmas. Find the 
# first 5 employees hired in the 90's by sorting by hire date and limiting your results 
# to the first 5 records. Write a comment in your code that lists the five names of the 
# employees returned.

SELECT first_name, last_name, birth_date, hire_date
FROM employees
WHERE birth_date LIKE '____-12-25'
  AND hire_date BETWEEN '1990-01-01' AND '1999-12-31'
ORDER BY hire_date
LIMIT 5;
# Answer: 
# Alselm Cappelo
# Utz Mandell
# Bouchung Schreiter
# Baocai Kushner
# Petter Stroustup

/************************************** Question 4 ****************************************/
# Try to think of your results as batches, sets, or pages. The first five results are your
# first page. The five after that would be your second page, etc. Update the query to find 
# the tenth page of results.

SELECT first_name, last_name, birth_date, hire_date
FROM employees
WHERE birth_date LIKE '____-12-25'
  AND hire_date BETWEEN '1990-01-01' AND '1999-12-31'
ORDER BY hire_date
LIMIT 5 OFFSET 50;
/* Answers: 
      - Names:
			  Christophe Baca
              Moie Birsak
              Chikako Ibel
              Shounak Jansen
              Zhigen Boissier
	  - Offset = page number * LIMIT
*/