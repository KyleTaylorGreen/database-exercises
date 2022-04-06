USE employees;

/*********************************************** Exercise 1 **********************************************************/
# Write a query that returns all employees, their department number, their start date, their end date, and a new 
# column 'is_current_employee' that is a 1 if the employee is still with the company and 0 if not.

# Use CTE to create a table that I can pull results from
WITH temp AS(
SELECT emp_no, first_name, last_name, dept_emp.dept_no, dept_emp.from_date, dept_emp.to_date, 
	   CASE 
       WHEN dept_emp.to_date > NOW() THEN 1
		ELSE 0
		END AS is_current_employee,
       # Assign row number to most recent to_date, partitioned by emp_no to disregard duplicate IDs' previous department dates
       ROW_NUMBER() OVER(PARTITION BY emp_no ORDER BY dept_emp.to_date DESC) AS most_recent_date
FROM employees
JOIN dept_emp USING(emp_no)
ORDER BY emp_no, dept_emp.to_date DESC)


# Selecting employees where most_recent_date is picked for each employee
SELECT * 
FROM temp 
WHERE most_recent_date = 1;


/*********************************************** Exercise 2 **********************************************************/
# Write a query that returns all employee names (previous and current), and a new column 'alpha_group' that returns 
#'A-H', 'I-Q', or 'R-Z' depending on the first letter of their last name.

SELECT first_name, last_name,
	   CASE
	   WHEN last_name RLIKE '^[A-H]' THEN 'A-H'
       WHEN last_name RLIKE '^[I-Q]' THEN 'I-Q'
       WHEN last_name RLIKE '^[R-Z]' THEN 'R-Z'
       ELSE NULL
       END AS alpha_group
FROM employees;


/*********************************************** Exercise 3 **********************************************************/
# How many employees (current or previous) were born in each decade?

SELECT COUNT(CASE WHEN birth_date BETWEEN '1940-01-01' AND '1949-12-31' THEN "40's" ELSE NULL END) AS "40's",
	   COUNT(CASE WHEN birth_date BETWEEN '1950-01-01' AND '1959-12-31' THEN "50's" ELSE NULL END) AS "50's",
	   COUNT(CASE WHEN birth_date BETWEEN '1960-01-01' AND '1969-12-31' THEN "60's" ELSE NULL END) AS "60's",
       COUNT(CASE WHEN birth_date BETWEEN '1970-01-01' AND '1979-12-31' THEN "70's" ELSE NULL END) AS "70's",
       COUNT(CASE WHEN birth_date BETWEEN '1980-01-01' AND '1989-12-31' THEN "80's" ELSE NULL END) AS "80's",
       COUNT(CASE WHEN birth_date BETWEEN '1990-01-01' AND '1999-12-31' THEN "90's" ELSE NULL END) AS "90's"
FROM employees;


/*********************************************** Exercise 4 **********************************************************/
# What is the current average salary for each of the following department groups: R&D, Sales & Marketing, Prod & QM, 
# Finance & HR, Customer Service?

SELECT *
FROM departments;

# Averaging each department groups' salaries as long as they are current
SELECT ROUND(AVG(CASE WHEN dept_name IN ('Research', 'Development') THEN salaries.salary ELSE NULL END), 2) AS 'Research & Development',
	   ROUND(AVG(CASE WHEN dept_name IN ('Sales', 'Marketing') THEN salaries.salary ELSE NULL END), 2) AS 'Sales & Marketing',
	   ROUND(AVG(CASE WHEN dept_name IN ('Production', 'Quality Management') THEN salaries.salary ELSE NULL END), 2) AS 'Production & QM',
       ROUND(AVG(CASE WHEN dept_name IN ('Finance', 'Human Resources') THEN salaries.salary ELSE NULL END), 2) AS 'Finance & HR',
       ROUND(AVG(CASE WHEN dept_name = 'Customer Service' THEN salaries.salary ELSE NULL END), 2) AS 'Customer Service'
FROM departments
JOIN dept_emp USING(dept_no)
JOIN salaries
  ON dept_emp.emp_no = salaries.emp_no 
  WHERE salaries.to_date > NOW();

# better to use if I wanted to pull data or mess with the information at all
SELECT CASE
			WHEN dept_name IN ('Research', 'Development') THEN 'Research & Development'
            WHEN dept_name IN ('Sales', 'Marketing') THEN 'Sales & Marketing'
            WHEN dept_name IN ('Production', 'Quality Management') THEN 'Prod. & QM'
            WHEN dept_name IN ( 'Finance', 'Human Resources') THEN 'Finance & HR'
            WHEN dept_name IN ('Customer Service') THEN 'Customer Service'
		END AS dept_group,
        AVG(salary)
FROM departments
JOIN dept_emp USING(dept_no)
JOIN salaries USING(emp_no)
  WHERE salaries.to_date > NOW()
GROUP BY dept_group;