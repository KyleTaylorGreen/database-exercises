USE employees;

# 1) Find all the current employees with the same hire date as employee 101010 using a sub-query.

SELECT employees.first_name, employees.last_name, employees.hire_date
FROM employees
WHERE employees.hire_date = (
	SELECT employees.hire_date
	FROM employees
	WHERE employees.emp_no = 101010
);
                             
                             
# 2) Find all the titles ever held by all current employees with the first name Aamod

# Current employees named Aamod
SELECT dept_emp.emp_no
FROM dept_emp
JOIN employees
  ON employees.emp_no = dept_emp.emp_no
WHERE dept_emp.to_date > NOW()
  AND employees.first_name = 'Aamod';
  

# Return title so long as ID is in list of current employees named 'Aamod'.
SELECT employees.first_name, employees.last_name, titles.title
FROM employees
JOIN titles
  ON titles.emp_no = employees.emp_no
  AND employees.emp_no IN (
	  SELECT dept_emp.emp_no
	  FROM dept_emp
	  JOIN employees
	    ON employees.emp_no = dept_emp.emp_no
	  WHERE dept_emp.to_date > NOW()
		AND employees.first_name = 'Aamod'
	) 
ORDER BY employees.last_name;


# 3) How many people in the employees table are no longer working for the company? Give the answer in a 
#    comment in your code.

# Find all current employees
SELECT employees.emp_no AS CurrentID, employees.first_name, employees.last_name
FROM employees
JOIN salaries
  ON salaries.emp_no = employees.emp_no
  AND salaries.to_date > NOW();

SELECT employees.emp_no, employees.first_name, employees.last_name
FROM employees
WHERE employees.emp_no NOT IN  (
      SELECT employees.emp_no AS CurrentID
	  FROM employees
	  JOIN salaries
	    ON salaries.emp_no = employees.emp_no
	    AND salaries.to_date > NOW()
	 );
# 59900 employees returned


# 4) Find all the current department managers that are female. List their names in a comment in your code.

SELECT employees.first_name, employees.last_name
FROM employees
WHERE employees.emp_no IN (
	SELECT dept_manager.emp_no
	FROM dept_manager
    JOIN employees
      ON employees.emp_no = dept_manager.emp_no
	WHERE employees.gender = 'F'
      AND dept_manager.to_date > NOW()
);
# Isamu Legleitner
# Karsten Sigstam
# Leon DasSama
# Hilary Kambil

# 5) Find all the employees who currently have a higher salary than the companies overall, historical average salary.

SELECT employees.first_name, employees.last_name, salaries.salary AS CurrentSalary
FROM employees
JOIN salaries
  ON salaries.emp_no = employees.emp_no
WHERE salaries.salary > (
						 SELECT AVG(salaries.salary)
                         FROM salaries
                         )
AND salaries.to_date > NOW();

# 6) How many current salaries are within 1 standard deviation of the current highest salary? 
#    (Hint: you can use a built in function to calculate the standard deviation.) What percentage of all salaries is this?


SELECT employees.first_name, employees.last_name, salaries.salary
    (salary - (SELECT AVG(salary) FROM salaries WHERE salaries.to_date > NOW()))
    /
    (SELECT stddev(salary) FROM salaries WHERE salaries.to_date > NOW()) AS zscore
FROM employees
JOIN salaries
  ON salaries.emp_no = employees.emp_no
  WHERE salaries.to_date > NOW()
Group BY employees.first_name, employees.last_name;

                         