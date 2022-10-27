USE employees;

# 1. Find all current or previous employees with first names 'Irena', 'Vidya', or 'Maya' using IN. Enter a comment with the number of records returned.

SELECT *
FROM employees
WHERE first_name IN ('Irena', 'Vidya', 'Maya')
ORDER BY first_name; 
# At the bottom it says 709 rows affected.

# 2. Find all current or previous employees with first names 'Irena', 'Vidya', or 'Maya', as in Q2, but use OR instead of IN. Enter a comment with the number of records returned. Does it match number of rows from Q2?

SELECT *
FROM employees
WHERE first_name = 'Irena' OR first_name = 'Vidya' OR first_name = 'Maya'; 
# At the bottom it says 709 rows affected, same as above.

# 3. Find all current or previous employees with first names 'Irena', 'Vidya', or 'Maya', using OR, and who is male. Enter a comment with the number of records returned.

SELECT *
FROM employees
WHERE first_name IN ('Irena', 'Vidya', 'Maya') AND gender = 'M'; 
# At the bottom it says 441 rows affected.

# 4. Find all current or previous employees whose last name starts with 'E'. Enter a comment with the number of employees whose last name starts with E.

SELECT *
FROM employees
WHERE last_name LIKE 'E%'; 
#At the bottom it says 7330 rows affected.

# 5. Find all current or previous employees whose last name starts or ends with 'E'. Enter a comment with the number of employees whose last name starts or ends with E. How many employees have a last name that ends with E, but does not start with E?

SELECT *
FROM employees
WHERE last_name LIKE 'E%' OR last_name LIKE '%E'; 
#At the bottom it says 30,723 rows affected. There is a diffence of 23,395 records.

# 6. Find all current or previous employees employees whose last name starts and ends with 'E'. Enter a comment with the number of employees whose last name starts and ends with E. How many employees' last names end with E, regardless of whether they start with E?

SELECT *
FROM employees
WHERE last_name LIKE 'E%' AND last_name LIKE '%E';
# At the bottom it says 899 rows affected.

# 7. This is the query to find how many employee last names end with 'e'.
SELECT *
FROM employees
WHERE last_name LIKE '%E'; 
#At the bottom it says 24292 rows affected. 

# 8. Find all current or previous employees hired in the 90s. Enter a comment with the number of employees returned.

SELECT *
FROM employees
WHERE hire_date BETWEEN '1990-01-01' AND '1999-12-31'; 
#At the bottom it says 135214 rows affected.

# 9. Find all current or previous employees born on Christmas. Enter a comment with the number of employees returned.

SELECT * # SELECT count(*) is another option. Returns the number and not the names.
FROM employees
WHERE birth_date LIKE '%-12-25'; 
#At the bottom it says 842 rows affected.

# 10. Find all current or previous employees hired in the 90s and born on Christmas. Enter a comment with the number of employees returned.

SELECT *
FROM employees
WHERE hire_date BETWEEN '1990-01-01' AND '1999-12-31'
	AND (birth_date LIKE '%-12-25');
#At the bottom it says 362 rows affected.

# 11. Find all current or previous employees with a 'q' in their last name. Enter a comment with the number of records returned.

SELECT *
FROM employees
WHERE last_name LIKE '%q%'; # Count: 1873

# 12. Find all current or previous employees with a 'q' in their last name but not 'qu'. How many employees are found?

SELECT *
FROM employees
WHERE last_name LIKE '%q%' AND NOT last_name LIKE '%qu%'; #Count: 547