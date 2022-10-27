USE employees;
DESCRIBE employees;
# emp_no, birth_date, first_name, last_name, gender, hire_date
DESCRIBE titles;
# emp_no, title, from_date, to_date


# 1. In your script, use DISTINCT to find the unique titles in the titles table. How many unique titles have there ever been? Answer that in a comment in your SQL file.
SELECT title FROM titles
GROUP BY title; # There are seven unique titles.

# 2. Write a query to to find a list of all unique last names of all employees that start and end with 'E' using GROUP BY.

SELECT last_name FROM employees
WHERE last_name LIKE 'E%E'
GROUP BY last_name;
# Erde, Eldridge, Etalle, Erie, Erbe


# 3. Write a query to find all unique combinations of first and last names of all employees whose last names start and end with 'E'.

SELECT DISTINCT last_name, first_name FROM employees
WHERE last_name LIKE 'E%E'
GROUP BY last_name, first_name;
# 846 combinations

# 4. Write a query to find the unique last names with a 'q' but not 'qu'. Include those names in a comment in your sql code.

SELECT last_name FROM employees
WHERE last_name LIKE '%q%' AND last_name NOT LIKE '%qu%'
GROUP BY last_name;
# Chleq, Lindqvist, Qiwen

# 5. Add a COUNT() to your results (the query above) to find the number of employees with the same last name.
SELECT last_name, COUNT(last_name) FROM employees
WHERE last_name LIKE '%q%' AND last_name NOT LIKE '%qu%'
GROUP BY last_name;

# 6. Find all all employees with first names 'Irena', 'Vidya', or 'Maya'. Use COUNT(*) and GROUP BY to find the number of employees for each gender with those names.

SELECT first_name, COUNT(first_name), gender FROM employees
WHERE first_name LIKE 'Irena' OR first_name LIKE 'Vidya' OR first_name LIKE 'Maya'
GROUP BY first_name, gender;

# 7. Using your query that generates a username for all of the employees, generate a count employees for each unique username. Are there any duplicate usernames? BONUS: How many duplicate usernames are there?

SELECT LOWER(CONCAT(SUBSTR(first_name, 1, 1 /*first initial*/), SUBSTR(last_name, 1, 4 /* 4 char of last */), '_', SUBSTR(birth_date, 6,2)/* ## - Birth Month*/, SUBSTR(birth_date, 3, 2) /* ## Birth Year*/)) AS username, COUNT(*)
FROM employees
GROUP BY username HAVING COUNT(username) > 1;
# There are 13251 rows with duplicate usernames.


# Bonus: More practice with aggregate functions:

# Determine the historic average salary for each employee. When you hear, read, or think "for each" with regard to SQL, you'll probably be grouping by that exact column.
# Using the dept_emp table, count how many current employees work in each department. The query result should show 9 rows, one for each department and the employee count.
# Determine how many different salaries each employee has had. This includes both historic and current.
# Find the maximum salary for each employee.
# Find the minimum salary for each employee.
# Find the standard deviation of salaries for each employee.
# Now find the max salary for each employee where that max salary is greater than $150,000.
# Find the average salary for each employee where that average salary is between $80k and $90k.