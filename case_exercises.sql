USE employees;

-- 1. WRITE a QUERY that RETURNS ALL employees, their department number, their START DATE, their END DATE, AND a NEW COLUMN 'is_current_employee' that IS a 1 IF the employee IS still WITH the company AND 0 IF not.
SELECT emp_no, dept_no, from_date AS start_date, to_date AS end_date, to_date > NOW() AS is_current_employee
FROM dept_emp
ORDER BY emp_no;

-- 2. Write a query that returns all employee names (previous and current), and a new column 'alpha_group' that returns 'A-H', 'I-Q', or 'R-Z' depending on the first letter of their last name.
SELECT CONCAT(employees.first_name, ' ', employees.last_name) AS 'Name', 
CASE 
WHEN SUBSTR(last_name, 1, 1) BETWEEN 'A' AND 'H' THEN 'A-H'
WHEN SUBSTR(last_name, 1, 1) IN ('i', 'j', 'k', 'l', 'm', 'n', 'o', 'p', 'q') THEN 'I-Q'
ELSE 'R-Z'
END AS 'alpha_group'
FROM employees;

-- 3. How many employees (current or previous) were born in each decade?
SELECT 
COUNT(CASE WHEN birth_date LIKE '194%' THEN '1940s' ELSE NULL END) AS '1940s',
COUNT(CASE WHEN birth_date LIKE '195%' THEN '1950s' ELSE NULL END) AS '1950s',
COUNT(CASE WHEN birth_date LIKE '196%' THEN '1960s' ELSE NULL END) AS '1960s',
COUNT(CASE WHEN birth_date LIKE '197%' THEN '1970s' ELSE NULL END) AS '1970s'
FROM employees;

-- Alternate way to do #3
SELECT 
CASE 
	WHEN birth_date LIKE '195%' THEN '50s'
	WHEN birth_date LIKE '196%' THEN '60s'
	END AS decade,
	COUNT(*) AS num_in_decade
	FROM employees
	GROUP BY decade;
	
-- 4. What is the current average salary for each of the following department groups: R&D, Sales & Marketing, Prod & QM, Finance & HR, Customer Service?
/* SELECT 
CASE
WHEN dept_no LIKE '%8' OR dept_no LIKE '%5' THEN 'R&D'
WHEN dept_no LIKE '%7' OR dept_no LIKE '%1' THEN 'Sales/Marketing'
WHEN dept_no LIKE '%4' OR dept_no LIKE '%6' THEN 'Production/QM'
WHEN dept_no LIKE '%2' OR dept_no LIKE '%3' THEN 'Finance/HR'
ELSE dept_no
END AS Group
FROM departments
GROUP BY Group;

	 */
	
SELECT CASE
	WHEN d.dept_name = 'Research' OR d.dept_name = 'Development' THEN 'R&D'
	WHEN d.dept_name IN('Sales', 'Marketing') THEN 'Sales & Marketing'
	WHEN d.dept_name IN('Production', 'Quality Management') THEN 'Prod & QM'
	WHEN d.dept_name IN('Finance', 'Human Resources') THEN 'Finance & HR'
	ELSE d.dept_name
	END AS dept_group,
	AVG(s.salary) AS avg_salary
	FROM departments d
	JOIN dept_emp de USING (dept_no)
	JOIN salaries s USING (emp_no)
	WHERE s.to_date > NOW() AND de.to_date > NOW()
	GROUP BY dept_group;

	
	
	
	
	
	
	
