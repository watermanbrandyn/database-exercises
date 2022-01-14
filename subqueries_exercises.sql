USE employees;
-- 1. 
SELECT * FROM employees
WHERE employees.emp_no IN(
	SELECT dept_emp.emp_no FROM dept_emp
	WHERE to_date = '9999-01-01'
) AND employees.hire_date = (SELECT hire_date FROM employees WHERE emp_no = 101010);
-- 55 results

-- 2. 
SELECT * FROM titles
WHERE titles.emp_no IN(
	SELECT employees.emp_no FROM employees
	WHERE first_name = 'Aamod')
	AND titles.emp_no IN(
	SELECT dept_emp.emp_no FROM dept_emp
	WHERE to_date = '9999-01-01'
	);
-- 251 results (possibly review this? Should it display just the literal titles held, to produce 5 results?)	

-- 3. 
SELECT COUNT(employees.emp_no) AS 'No Longer With Company' FROM employees
WHERE employees.emp_no IN(
	SELECT dept_emp.emp_no FROM dept_emp
	WHERE to_date NOT LIKE '9999%'
);
-- Result is 85108 people no longer with the company

-- 4. 
SELECT * FROM employees
WHERE gender = 'f' AND emp_no IN(
	SELECT emp_no FROM dept_manager
	WHERE to_date = '9999-01-01'
);
-- There are four results: Isamu Legleitner, Karsten Sigstam, Leon DasSarma, Hilary Kambil

-- 5. 
SELECT emp_no, salary FROM salaries
WHERE to_date = '9999-01-01'
AND salary > (SELECT AVG(salary) FROM salaries);
-- 154543 results

-- 6. How many current salaries are within 1 standard deviation of the current highest salary? (Hint: you can use a built in function to calculate the standard deviation.) What percentage of all salaries is this?

USE employees;
SELECT stddev(salary) FROM salaries;

/* SELECT COUNT(
salary > (SELECT
			MAX(salary) - STDDEV(salary) FROM salaries 
			WHERE to_date > NOW()) 
) FROM salaries 
WHERE to_date > NOW()  */
--

-- 240,124 results for first part (how many curr > curr stddev from highest) this is not correct, and the below is a correct version reviewed in class

SELECT count(*) AS 1_standard_deviation_of_current_highest_salary FROM salaries
WHERE to_date > now() AND salary > (
SELECT max(salary) - std(salary) FROM salaries
WHERE to_date > now());

SELECT (100 * (SELECT count(*) FROM salaries
WHERE to_date > now() AND salary > (
SELECT max(salary) - std(salary) FROM salaries
WHERE to_date > now()))
	/
(SELECT count(salary) FROM salaries
WHERE to_date > now())
) AS percent;
-- .0346%
SELECT count(salary) FROM salaries WHERE to_date > now();

SELECT 8300 / 240124;





SELECT COUNT(*) FROM salaries
WHERE to_date > now() AND salary > (
SELECT max(salary) - std(salary) FROM salaries) 
	/
	(SELECT COUNT(salary) FROM salaries)
	)
	WHERE to_date > now();

SELECT salary,
    (salary - (SELECT AVG(salary) FROM salaries))
    /
    (SELECT stddev(salary) FROM salaries) AS zscore
FROM salaries;










