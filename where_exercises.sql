USE employees;


# 2
# verifying output
SELECT emp_no, first_name, last_name 
FROM employees
WHERE first_name IN ('Irena', 'Vidya', 'Maya');

# actually counting results
SELECT COUNT(first_name)
FROM employees
WHERE first_name IN ('Irena', 'Vidya', 'Maya');
# 709 rows counted

# 3

SELECT emp_no, first_name, last_name
FROM employees
WHERE first_name = 'Irena'
OR  first_name = 'Vidya'
OR first_name = 'Maya';

SELECT COUNT(first_name)
FROM employees
WHERE first_name = 'Irena'
OR  first_name = 'Vidya'
OR first_name = 'Maya';
# 709 records returned, number of records returned match from question 2.


#4

SELECT emp_no, first_name, last_name
FROM employees
WHERE gender = 'M'
	AND (
		first_name = 'Irena'
    OR  first_name = 'Vidya'
    OR  first_name = 'Maya'
);

SELECT COUNT(first_name)
FROM employees
WHERE gender = 'M'
	AND (
		first_name = 'Irena'
    OR  first_name = 'Vidya'
    OR  first_name = 'Maya'
);

# 441 records returned


# 5

SELECT emp_no, first_name, last_name
FROM employees
WHERE last_name LIKE 'E%';

SELECT COUNT(last_name)
FROM employees
WHERE last_name LIKE 'E%';
# 7330 people have last names that start with 'E'.


# 6

SELECT emp_no, first_name, last_name
FROM employees
WHERE last_name LIKE 'E%'
  OR last_name LIKE '%e';

SELECT COUNT(last_name)
FROM employees
WHERE last_name LIKE 'E%'
  OR last_name LIKE '%e';
# 30723 peoples' last names start or end with 'E'.

SELECT COUNT(last_name)
FROM employees
WHERE last_name LIKE '%e'
  AND last_name NOT LIKE 'E%';
# 23393 people have a last name that ends with 'e' but does not start with 'E'.

# 7

SELECT emp_no, first_name, last_name
FROM employees
WHERE last_name LIKE 'E%'
  AND last_name LIKE '%e';
  
SELECT COUNT(last_name)
FROM employees
WHERE last_name LIKE 'E%'
  AND last_name LIKE '%e';
# 899 people have a last name that starts and ends with 'E'

# 8

SELECT emp_no, first_name, last_name, hire_date
FROM employees
WHERE hire_date BETWEEN '1990-01-01' AND '1999-12-31';

SELECT COUNT(*)
FROM employees
WHERE hire_date BETWEEN '1990-01-01' AND '1999-12-31';
# 135,214 people were hired in the 90's


# 9 

SELECT emp_no, first_name, last_name, birth_date
FROM employees
WHERE DAY(birth_date) = '25'
  AND MONTH(birth_date) = '12';
  
SELECT COUNT(*)
FROM employees
WHERE DAY(birth_date) = '25'
  AND MONTH(birth_date) = '12';
# 842 people were born on Christmas


# 10

SELECT emp_no, first_name, last_name, hire_date, birth_date
FROM employees
WHERE hire_date BETWEEN '1990-01-01' AND '1999-12-31'
  AND ( DAY(birth_date) = '25'
	AND MONTH(birth_date) = '12'
);

SELECT COUNT(*)
FROM employees
WHERE hire_date BETWEEN '1990-01-01' AND '1999-12-31'
  AND ( DAY(birth_date) = '25'
	AND MONTH(birth_date) = '12'
);
# 362 people were born on Christmas and hired in the 90's


# 11

SELECT emp_no, first_name, last_name
FROM employees
WHERE last_name LIKE '%q%';

SELECT COUNT(*)
FROM employees
WHERE last_name LIKE '%q%';
# 1873 people have a 'q' in their last name


# 12

SELECT emp_no, first_name, last_name
FROM employees
WHERE last_name LIKE '%q%'
  AND last_name NOT LIKE '%qu%';
  
SELECT COUNT(*)
FROM employees
WHERE last_name LIKE '%q%'
  AND last_name NOT LIKE '%qu%';
# There are 547 people that have 'q' in their name but not 'qu'.


