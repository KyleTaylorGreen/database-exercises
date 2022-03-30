use employees;
show tables;

SELECT * FROM information_schema.columns WHERE table_schema = 'employees';

-- "Which table(s) do you think contain a numeric type column?" 
--  I think employees, dept_emp, dept_manager, salaries, and titles have numeric data types.

-- "Which table(s) do you think contain a string type column?" 
-- employees, dept_emp, dept_manager, titles, departments all have string type columns.

-- "Which table(s) do you think contain a date type column?"
-- dept_emp, dept_manager, employees, salaries and titles all have date type columns.

-- "What is the relationship between the employees and the departments tables?"
 
select * from employees;
select * from departments;

-- They don't share data but presumably every employee works within a specific department, 
-- which is in the dept_emp table.

show create table dept_manager;
/* 'CREATE TABLE `dept_manager` (
  `emp_no` int NOT NULL,
  `dept_no` char(4) NOT NULL,
  `from_date` date NOT NULL,
  `to_date` date NOT NULL,
  PRIMARY KEY (`emp_no`,`dept_no`),
  KEY `dept_no` (`dept_no`),
  CONSTRAINT `dept_manager_ibfk_1` FOREIGN KEY (`emp_no`) REFERENCES `employees` (`emp_no`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `dept_manager_ibfk_2` FOREIGN KEY (`dept_no`) REFERENCES `departments` (`dept_no`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=latin1'
*/