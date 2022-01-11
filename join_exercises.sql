USE join_example_db;
SELECT * FROM users;
SELECT * FROM roles;

SELECT users.name as user_name, roles.name as role_name
FROM users
JOIN roles ON users.role_id = roles.id;

SELECT users.name AS user_name, roles.name AS role_name
FROM users
LEFT JOIN roles ON users.role_id = roles.id;

SELECT users.name AS user_name, roles.name AS role_name
FROM users
RIGHT JOIN roles ON users.role_id = roles.id;

SELECT roles.name AS role_name, COUNT(users.role_id)
FROM roles
LEFT JOIN users ON roles.id = users.role_id
GROUP BY roles.name;

USE employees;

SELECT d.dept_name AS "Department Name", CONCAT(e.first_name, ' ', e.last_name) AS "Department Manager"
FROM departments as d
JOIN dept_manager as dm
ON d.dept_no = dm.dept_no
JOIN employees as e
ON dm.emp_no = e.emp_no
WHERE dm.to_date = '9999-01-01';

SELECT d.dept_name AS "Department Name", CONCAT(e.first_name, ' ', e.last_name) AS "Department Manager"
FROM departments as d
JOIN dept_manager as dm
ON d.dept_no = dm.dept_no
JOIN employees as e
ON dm.emp_no = e.emp_no
WHERE dm.to_date = '9999-01-01' AND e.gender = 'F';

SELECT titles.title AS Title, COUNT(titles.emp_no) AS Count
FROM titles
JOIN dept_emp USING(emp_no)
JOIN departments USING(dept_no)
WHERE titles.to_date = '9999-01-01' AND dept_emp.to_date = '9999-01-01' AND departments.dept_no = 'd009'
GROUP BY titles.title
ORDER BY titles.title;

SELECT departments.dept_name AS "Department Name", CONCAT(employees.first_name, " ", employees.last_name) AS "Name", salaries.salary as Salary
FROM departments
JOIN dept_manager USING(dept_no)
JOIN salaries USING(emp_no)
JOIN employees USING(emp_no)
WHERE dept_manager.to_date = '9999-01-01' AND salaries.to_date = '9999-01-01'
ORDER BY departments.dept_name;

SELECT departments.dept_no AS dept_no, departments.dept_name AS dept_name, COUNT(dept_emp.emp_no) AS num_employees
FROM departments
JOIN dept_emp USING(dept_no)
WHERE dept_emp.to_date = '9999-01-01'
GROUP BY dept_emp.dept_no
ORDER BY departments.dept_no;

SELECT departments.dept_name AS dept_name, AVG(salaries.salary) AS average_salary
FROM departments
JOIN dept_emp USING(dept_no)
JOIN salaries USING(emp_no)
WHERE dept_emp.to_date = '9999-01-01' AND salaries.to_date = '9999-01-01'
GROUP BY departments.dept_name
ORDER BY average_salary DESC LIMIT 1;

SELECT employees.first_name AS first_name, employees.last_name AS last_name
FROM departments
JOIN dept_emp USING(dept_no)
JOIN employees USING(emp_no)
JOIN salaries USING(emp_no)
WHERE departments.dept_name = 'Marketing' AND salaries.to_date = '9999-01-01' AND dept_emp.to_date = '9999-01-01'
GROUP BY salaries.salary, employees.first_name, employees.last_name
ORDER BY salaries.salary DESC LIMIT 1;

SELECT employees.first_name AS first_name, employees.last_name AS last_name, salaries.salary AS salary, departments.dept_name AS dept_name
FROM departments
JOIN dept_manager USING(dept_no)
JOIN salaries USING(emp_no)
JOIN employees USING(emp_no)
WHERE dept_manager.to_date = '9999-01-01' AND salaries.to_date = '9999-01-01'
GROUP BY salaries.salary, employees.first_name, employees.last_name, departments.dept_name
ORDER BY salaries.salary DESC LIMIT 1;

SELECT departments.dept_name AS dept_name, ROUND(AVG(salaries.salary)) AS average_salary
FROM departments 
JOIN dept_emp USING(dept_no)
JOIN salaries USING(emp_no)
GROUP BY departments.dept_name
ORDER BY average_salary DESC;

/*SELECT CONCAT(employees.first_name, ' ', employees.last_name) AS "Employee Name", departments.dept_name, CONCAT(employees.first_name, ' ', employees.last_name) AS "Manager Name"
FROM departments 
JOIN dept_manager USING(dept_no)
LEFT JOIN dept_emp USING(emp_no)
JOIN employees USING(emp_no)
WHERE dept_emp.to_date = '9999-01-01' AND dept_manager.to_date = '9999-01-01' 
GROUP BY departments.dept_name, dept_manager.dept_no, dept_emp.emp_no;
*/








