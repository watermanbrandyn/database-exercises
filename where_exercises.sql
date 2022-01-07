USE employees;
SELECT * FROM employees WHERE first_name IN ('Irena', 'Vidya', 'Maya');
-- 2. Result is 709 entires
SELECT * FROM employees WHERE first_name = 'Irena' OR first_name = 'Vidya' OR first_name = 'Maya';
-- 3. Result is 709 entries, same as the use of IN for quesetion 2. 
SELECT * FROM employees WHERE (first_name = 'Irena' OR first_name = 'Vidya' OR first_name = 'Maya') AND gender = 'M';
-- 4. Result is 441 entries. 
SELECT * FROM employees WHERE last_name LIKE 'E%';
-- 5. Result is 7330 entries. 
SELECT * FROM employees WHERE last_name LIKE 'E%' OR last_name LIKE '%E';
-- 6. a. Result is 30723 entries
SELECT * FROM employees WHERE last_name LIKE '%E' AND last_name  NOT LIKE 'E%';
-- 6. b. Result is 23393 entries. 
SELECT * FROM employees WHERE last_name LIKE '%E' AND last_name LIKE 'E%';
-- 7. a. Result is 899 entries.
SELECT * FROM employees WHERE last_name LIKE '%E';
-- 7. b. Result is 24292 entries.
SELECT * FROM employees WHERE hire_date BETWEEN '1990/01/01' AND '1999/12/31';
-- 8. Result is 135,214 entries.
SELECT * FROM employees WHERE birth_date LIKE '%12-25';
-- 9. Result is 842 entries.
SELECT * FROM employees WHERE (hire_date BETWEEN '1990/01/01' AND '1999/12/31') AND birth_date LIKE '%12-25';
-- 10. Result is 362 entries.
SELECT * FROM employees WHERE last_name LIKE '%q%';
-- 11. Result is 1873 entries.
SELECT * FROM employees WHERE last_name LIKE '%q%' AND last_name NOT LIKE '%qu%';
-- 12. Result is 547 entries.



