USE employees;
SHOW TABLES;
DESCRIBE employees;
-- Data types: int, date, varchar, enum
-- emp_no contains a numeric data type
-- first_name, last_name, gender contain string types
-- birth_date, hire_date contain date types
SHOW CREATE TABLE employees;
DESCRIBE departments;
DESCRIBE dept_emp;
-- employees uses emp_no that then points to a dept_no under the dept_emp table
SHOW CREATE TABLE dept_manager;