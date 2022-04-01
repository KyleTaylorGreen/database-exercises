/************************************************* Question 1 *******************************************************/
# USE your employees database.

USE employees;


/************************************************* Question 2 *******************************************************/
# DESCRIBE each table and inspect the keys and see which columns have indexes and keys.

DESCRIBE departments;
# Primary Key: dept_no
# Unique: dept_name

DESCRIBE dept_emp;
# Primary Key: emp_no, dept_no
# Unique: None

Describe dept_manager;
# Primary Keys: emp_no, dept_no
# Unique: None

Describe employees;
# Primary Key: emp_no
# Unique: None

Describe salaries;
# Primary Keys: emp_no, from_date
# Unique: None

Describe titles;
# Primary Keys: emp_no, title, from_date