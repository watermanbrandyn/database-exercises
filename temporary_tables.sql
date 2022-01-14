/* -- Temporary Tables

-- CREATE
-- what is in the table

CREATE TEMPORARY TABLE temptable1( 
col1 INT UNSIGNED NOT NULL);

-- Use the database associated with my username USE ada_674;

CREATE TEMPORARY TABLE temptable1(
col1 INT UNSIGNED NOT NULL
);

SELECT DATABASE();
SHOW TABLES;
SELECT * FROM temptable1;

-- Let's add some data
-- INSERT
DESCRIBE temptable1;
INSERT INTO temptable1(col1) VALUES (1), (2), (3), (4);

-- Using data from another database 
SELECT * FROM mall_customers.customers;

CREATE TEMPORARY TABLE fakecustomers AS (SELECT * FROM mall_customers.customers);

-- ALTERS, UPDATES, DROP
-- ALTERS: add a new field or remove a fields
-- ALTER: use in conjunction with add/drop

DROP TABLE tempttable1;
ALTER TABLE fakecustomers DROP COLUMN annual_income;
ALTER TABLE fakecustomers ADD genderage VARCHAR(40);

-- Updating: 
UPDATE fakecustomers SET genderage = CONCAT('gdr: ', gender, 'age: ', age);

DELETE FROM fakecustomers WHERE customer_id % 2 = 0;

UPDATE fakecustomers SET gender = CASE WHEN gender = 'Female' THEN 'gorl' ELSE 'not giorl' END; */
-- 1. Using the example from the lesson, create a temporary table called employees_with_departments that contains first_name, last_name, and dept_name for employees currently with that department. Be absolutely sure to create this table on your own database. If you see "Access denied for user ...", it means that the query was attempting to write a new table to a database that you can only read.
-- a. Add a column named full_name to this table. It should be a VARCHAR whose length is the sum of the lengths of the first name and last name columns
-- b. Update the table so that full name column contains the correct data
-- c. Remove the first_name and last_name columns from the table.
-- d. What is another way you could have ended up with this same table?

USE innis_1660;
SELECT DATABASE();

-- 1. 
CREATE TEMPORARY TABLE employees_with_departments AS 
(SELECT 
employees.employees.first_name AS first_name,
employees.employees.last_name AS last_name,
employees.departments.dept_name AS dept_name
FROM employees.employees
JOIN employees.dept_emp USING(emp_no)
JOIN employees.departments USING(dept_no)
WHERE employees.dept_emp.to_date > NOW()
);
DESCRIBE employees_with_departments;
SELECT * FROM employees_with_departments;

ALTER TABLE employees_with_departments ADD full_name VARCHAR(40);
UPDATE employees_with_departments SET full_name = CONCAT(employees_with_departments.first_name, ' ', employees_with_departments.last_name);
ALTER TABLE employees_with_departments DROP first_name;
ALTER TABLE employees_with_departments DROP last_name;

-- d. This could be done by pulling each table into a temp. one locally and then combine them with a separate query. Also, the 'new' version could be done with CONCAT for the first and last name from the employees table. Could create the full_name column in original query as well. 

-- 2. Create a temporary table based on the payment table from the sakila database.
-- WRITE the SQL necessary TO transform the amount COLUMN such that it IS stored AS an INTEGER representing the number of cents of the payment. FOR example, 1.99 should become 199.
SELECT DATABASE();
USE innis_1660;

CREATE TEMPORARY TABLE payment_new AS
SELECT * FROM sakila.payment;
DESCRIBE payment_new;
SELECT * FROM payment_new;
ALTER TABLE payment_new ADD amount_2 INT;
UPDATE payment_new SET amount_2 = amount * 100;
ALTER TABLE payment_new DROP amount; 
ALTER TABLE payment_new RENAME COLUMN amount_2 TO amount;

CREATE TEMPORARY TABLE payments_2 AS (
SELECT payment_id, customer_id, staff_id, rental_id, amount * 100 AS amount_in_pennies, payment_date, last_update 
FROM sakila.payment);
SELECT * FROM payments_2;

ALTER TABLE payments_2 MODIFY amount_in_pennies INT NOT NULL;

-- 3. Find out how the current average pay in each department compares to the overall, historical average pay. In order to make the comparison easier, you should use the Z-score for salaries. In terms of salary, what is the best department right now to work for? The worst?

USE innis_1660;
SELECT DATABASE();

-- Historic avg/dept.
SELECT dept_name, AVG(salaries.salary) AS Average_Salary_Hist_PerDept
FROM departments
JOIN dept_emp USING(dept_no)
JOIN salaries USING(emp_no)
GROUP BY dept_name
ORDER BY Average_Salary_Hist_PerDept DESC;

-- Historic Avg, store as own temp. table
SELECT AVG(salary) FROM salaries;

-- Curr. avg/dept
SELECT dept_name, AVG(salaries.salary) AS Average_Salary_Curr_PerDept
FROM departments
JOIN dept_emp USING(dept_no)
JOIN salaries USING(emp_no)
WHERE salaries.to_date > now() AND dept_emp.to_date > now()
GROUP BY dept_name
ORDER BY Average_Salary_Curr_PerDept DESC;

-- Historic z-score 
SELECT salary,
    (salary - (SELECT AVG(salary) FROM salaries))
    /
    (SELECT stddev(salary) FROM salaries) AS zscore
FROM salaries;

-- Attempt at putting it together
USE innis_1660;
SELECT DATABASE();
-- Historic Avg (overall) temptable
CREATE TEMPORARY TABLE hist_avg_stuff AS ( 
SELECT AVG(salary) AS avg_salary, std(salary) AS std_salary FROM employees.salaries);

-- Curr. Avg/Dept temptable
CREATE TEMPORARY TABLE curr_avg_pay AS (
SELECT employees.departments.dept_name, AVG(employees.salaries.salary) AS Average_Salary_Curr_PerDept
FROM employees.departments
JOIN employees.dept_emp USING(dept_no)
JOIN employees.salaries USING(emp_no)
WHERE employees.salaries.to_date > now() AND employees.dept_emp.to_date > now()
GROUP BY dept_name
ORDER BY Average_Salary_Curr_PerDept DESC); 

ALTER TABLE curr_avg_pay ADD historic_avg FLOAT(10,2);
ALTER TABLE curr_avg_pay ADD historic_std FLOAT(10,2);
ALTER TABLE curr_avg_pay ADD zscore FLOAT(10,2);

UPDATE curr_avg_pay SET historic_avg = (SELECT avg_salary FROM hist_avg_stuff);
UPDATE curr_avg_pay SET historic_std = (SELECT std_salary FROM hist_avg_stuff);
UPDATE curr_avg_pay SET zscore = (Average_Salary_Curr_PerDept - historic_avg) / historic_std;
SELECT * FROM current_info ORDER BY zscore DESC;
-- Class solution
CREATE TEMPORARY TABLE historic_aggregates AS (
SELECT AVG(salary) AS avg_salary, std(salary) AS std_salary FROM employees.salaries);

CREATE TEMPORARY TABLE current_info AS (
SELECT dept_name, AVG(salary) AS department_curr_avg
FROM employees.salaries
JOIN employees.dept_emp USING(emp_no)
JOIN employees.departments USING(dept_no)
WHERE employees.dept_emp.to_date > curdate()
AND employees.salaries.to_date > curdate()
GROUP BY dept_name
);

ALTER TABLE current_info ADD historic_avg FLOAT(10,2);
ALTER TABLE current_info ADD historic_std FLOAT(10,2);
ALTER TABLE current_info ADD zscore FLOAT(10,2);

UPDATE current_info SET historic_avg = (SELECT avg_salary FROM historic_aggregates);
UPDATE current_info SET historic_std = (SELECT std_salary FROM historic_aggregates);
UPDATE current_info SET zscore = (department_curr_avg - historic_avg) / historic_std;

SELECT * FROM current_info
ORDER BY zscore DESC;

