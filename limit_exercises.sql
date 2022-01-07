SELECT DISTINCT last_name FROM employees ORDER BY last_name DESC LIMIT 10; 
-- 2. Zykh, Zyda, Zwicker, Zweizig, Zumaque, Zultner, Zucker, Zuberek, Zschoche, Zongker
SELECT * FROM employees WHERE (hire_date BETWEEN '1990/01/01' AND '1999/12/31') AND birth_date LIKE '%12-25' ORDER BY hire_date LIMIT 5;
-- 3. First 5 employees returned: Alselm Cappello, Utz Mandell, Bouchung Schreiter, Baocai Kushner, Petter Stroustrup
SELECT * FROM employees WHERE (hire_date BETWEEN '1990/01/01' AND '1999/12/31') AND birth_date LIKE '%12-25' ORDER BY hire_date LIMIT 5 OFFSET 45;
-- 4. The relationship between Page number (P), Limit (L) and Offset (O) is that P = (L + O) / L


  





