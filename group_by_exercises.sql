USE employees;
SELECT DISTINCT title FROM titles;
-- 2. There are seven unique titles.
SELECT last_name FROM employees WHERE last_name LIKE 'E%E' GROUP BY last_name;
SELECT first_name, last_name FROM employees WHERE last_name LIKE 'E%E' GROUP BY first_name, last_name;
SELECT last_name FROM employees WHERE last_name LIKE '%q%' AND last_name NOT LIKE '%qu%' GROUP BY last_name;
-- 5. The unique last names for this query are Chleq, Lindqvist, and Qiwen.
SELECT last_name, COUNT(last_name) FROM employees WHERE last_name LIKE '%q%' AND last_name NOT LIKE '%qu%' GROUP BY last_name;
SELECT first_name, gender, COUNT(*) FROM employees WHERE first_name IN('Irena', 'Vidya','Maya') GROUP BY first_name, gender;
-- SELECT COUNT(DISTINCT LOWER(CONCAT(SUBSTR(first_name, 1, 1), SUBSTR(last_name, 1, 4), '_', SUBSTR(birth_date, 6, 2), SUBSTR(birth_date, 3, 2)))) AS username FROM employees;
-- There are duplicates. The unique count provides 285,872 results, while the total count (removing DISTINCT) produces 300,024 results. This means there are 14,152 more usernames needed to have each be unique.
SELECT LOWER(CONCAT(SUBSTR(first_name, 1, 1), SUBSTR(last_name, 1, 4), '_', SUBSTR(birth_date, 6, 2), SUBSTR(birth_date, 3, 2))) AS username, COUNT(*) FROM employees GROUP BY username HAVING COUNT(*) > 1;
-- Better visually to at least show the count of each username, can maniuplate the HAVING expression to show varying degrees of duplication. There are 27,403 total impacted employees (cycling through diff. HAVING parameters), from a total of 13,251 duplicated usernames. 
SELECT emp_no, AVG(salary) FROM salaries GROUP BY emp_no; 
SELECT dept_no, COUNT(emp_no) FROM dept_emp WHERE to_date LIKE '9999-01-01' GROUP BY dept_no;
SELECT emp_no, COUNT(DISTINCT salary) FROM salaries GROUP BY emp_no;
SELECT emp_no, MAX(salary) FROM salaries GROUP BY emp_no;
SELECT emp_no, MIN(salary) FROM salaries GROUP BY emp_no;
SELECT emp_no, STD(salary) FROM salaries GROUP BY emp_no;
SELECT emp_no, MAX(salary) as MAX FROM salaries GROUP BY emp_no HAVING MAX > 150000;
SELECT emp_no, AVG(salary) as Average FROM salaries GROUP BY emp_no HAVING Average BETWEEN 80000 AND 90000;



