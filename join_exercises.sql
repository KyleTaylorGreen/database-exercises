/************************************************** Exercise Set 1 ******************************************************/
# 1) Use the join_example_db. Select all the records from both the users and roles tables.

USE join_example_db;

SELECT *
FROM users;
# 6 employees

SELECT *
FROM roles;
# 4 roles


# 2) Use join, left join, and right join to combine results from the users and roles tables as we did in the lesson. 
# Before you run each query, guess the expected number of results.

# inner join
SELECT users.name AS Username, roles.name AS Role
FROM users
JOIN roles ON users.role_id = roles.id;
# Expecting 4 results
# Two employees have NULL values for role_id, so only four populated.

# left join
SELECT users.name AS Username, roles.name AS Role
FROM users
LEFT JOIN roles ON users.role_id = roles.id;
# Expecting 6 reults 
# Result: 6 rows

# right join
SELECT users.name AS Username, roles.name AS Role
FROM users
RIGHT JOIN roles ON users.role_id = roles.id;
# Expecting 4 reults
# Result: 5 results


# 3) Although not explicitly covered in the lesson, aggregate functions like count can be used with join queries. 
# Use count and the appropriate join type to get a list of roles along with the number of users that has the role. 
# Hint: You will also need to use group by in the query.

SELECT roles.name, COUNT(users.name) AS NumOfPplPerRole
FROM users
RIGHT JOIN roles ON roles.id = users.role_id
GROUP BY roles.name;


/************************************************** Exercise Set 2 ******************************************************/
# 1) Use the employees database.

USE employees;


# 2) Using the example in the Associative Table Joins section as a guide, write a query that shows each department 
# along with the name of the current manager for that department.

SELECT departments.dept_name, employees.first_name, employees.last_name, employees.emp_no
FROM dept_manager
JOIN departments
	ON dept_manager.dept_no = departments.dept_no
JOIN employees
	ON dept_manager.emp_no = employees.emp_no
WHERE dept_manager.to_date > NOW();
    
SELECT *
FROM dept_manager;


# 3) Find the name of all departments currently managed by women.

SELECT departments.dept_name, employees.first_name, employees.last_name, employees.emp_no, employees.gender
FROM dept_manager
JOIN departments
  ON dept_manager.dept_no = departments.dept_no
JOIN employees
  ON dept_manager.emp_no = employees.emp_no
WHERE employees.gender = 'F'
  AND dept_manager.to_date > NOW();

# 4) Find the current titles of employees currently working in the Customer Service department.

SELECT titles.title, COUNT(titles.title)
FROM titles
JOIN dept_emp
  ON titles.emp_no = dept_emp.emp_no
JOIN departments
  ON dept_emp.dept_no = departments.dept_no
WHERE dept_emp.to_date > NOW()
  AND departments.dept_name = 'Customer Service'
  AND titles.to_date > NOW()
GROUP BY titles.title;

# 5) Find the current salary of all current managers.

SELECT departments.dept_name, CONCAT(employees.first_name, ' ', employees.last_name) AS full_name, salaries.salary
FROM dept_manager
JOIN departments
	ON dept_manager.dept_no = departments.dept_no
JOIN employees
	ON dept_manager.emp_no = employees.emp_no
JOIN salaries
	ON dept_manager.emp_no = salaries.emp_no
WHERE dept_manager.to_date > NOW()
	AND salaries.to_date > NOW()
ORDER BY departments.dept_name;


# 6) Find the number of current employees in each department.

SELECT dept_emp.dept_no, departments.dept_name, COUNT(dept_emp.emp_no) AS Num_Employees
FROM dept_emp
JOIN departments
  ON dept_emp.dept_no = departments.dept_no
WHERE dept_emp.to_date > NOW()
GROUP BY dept_emp.dept_no, departments.dept_name
ORDER BY dept_emp.dept_no;


# 7) Which department has the highest average salary? Hint: Use current not historic information.

SELECT departments.dept_name, ROUND(AVG(salary), 2) AS AvgSalary
FROM salaries
JOIN dept_emp
  ON salaries.emp_no = dept_emp.emp_no
JOIN departments
  ON dept_emp.dept_no = departments.dept_no
WHERE dept_emp.to_date > NOW()
  AND salaries.to_date > NOW()
GROUP BY departments.dept_name
ORDER BY AvgSalary DESC
LIMIT 1;


# 8) Who is the highest paid employee in the Marketing department?

SELECT employees.first_name, employees.last_name
FROM employees
JOIN salaries
  ON employees.emp_no = salaries.emp_no
JOIN dept_emp
  ON employees.emp_no = dept_emp.emp_no
JOIN departments
  ON dept_emp.dept_no = departments.dept_no
WHERE departments.dept_name = 'Marketing'
  AND dept_emp.to_date > NOW()
ORDER BY salaries.salary DESC
LIMIT 1;


# 9) Which current department manager has the highest salary?

SELECT employees.first_name, employees.last_name, salaries.salary, departments.dept_name
FROM employees
JOIN salaries
  ON employees.emp_no = salaries.emp_no
JOIN dept_manager
  ON employees.emp_no = dept_manager.emp_no
JOIN departments
  ON dept_manager.dept_no = departments.dept_no
WHERE dept_manager.to_date > NOW()
ORDER BY salaries.salary DESC
LIMIT 1;


# 10) Determine the average salary for each department. Use all salary information and round your results.

SELECT departments.dept_name, AVG(salaries.salary) AS AvgSalary
FROM salaries
JOIN employees
  ON salaries.emp_no = employees.emp_no
JOIN dept_emp
  ON salaries.emp_no = dept_emp.emp_no
JOIN departments
  ON dept_emp.dept_no = departments.dept_no
GROUP BY departments.dept_name
ORDER BY AvgSalary DESC; 


# 11) Bonus Find the names of all current employees, their department name, and their current manager's name.
SELECT CONCAT(emp.first_name, " ", emp.last_name) AS EmployeeName, departments.dept_name, CONCAT(manager.first_name, " ", manager.last_name) AS ManagerName
FROM employees AS emp
JOIN dept_emp
  ON emp.emp_no = dept_emp.emp_no
JOIN departments
  ON dept_emp.dept_no = departments.dept_no
JOIN dept_manager
  ON departments.dept_no = dept_manager.dept_no
JOIN employees AS manager
  ON dept_manager.emp_no = manager.emp_no
WHERE dept_manager.to_date > NOW()
  AND dept_emp.to_date > NOW()
ORDER BY EmployeeName;

# 12) Bonus Who is the highest paid employee within each department.

SELECT full_name, HighestSalary, Dept_name
	FROM (SELECT CONCAT(employees.first_name, " ", employees.last_name) AS full_name, 
				 MAX(salaries.salary) OVER(PARTITION BY departments.dept_name) AS HighestSalary, 
                 departments.dept_name AS Dept_name, salaries.salary AS ActualSalary, 
                 departments.dept_name AS Verify
		  FROM employees
		  JOIN dept_emp
		    ON employees.emp_no = dept_emp.emp_no
		  JOIN salaries
		    ON employees.emp_no = salaries.emp_no
		  JOIN departments
	        ON dept_emp.dept_no = departments.dept_no
		  WHERE salaries.to_date > NOW()
		    AND salaries.emp_no = employees.emp_no
		  ORDER BY HighestSalary) AS subTable
WHERE HighestSalary = ActualSalary
  AND Dept_name = Verify;
