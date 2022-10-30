USE employees;

# 1. Find all the current employees with the same hire date as employee 101010 using a sub-query.

#	*** ANSWER ***

# No specification on what to display so I decided.
SELECT first_name, last_name, hire_date FROM employees
# Join to access 'to_date' and filter previous employees.
JOIN dept_emp USING (emp_no)
# Used subqurery to return hire_date and use in filter.
WHERE hire_date LIKE (SELECT hire_date FROM employees
WHERE employees.emp_no LIKE '101010') AND (dept_emp.to_date LIKE '9999%');

# 2. Find all the titles ever held by all current employees with the first name Aamod.

#	*** ANSWER ***

SELECT title FROM titles
#Uses a subquery to return emp_no from employees named 'Aamod'.
WHERE emp_no IN(SELECT emp_no FROM employees
WHERE first_name LIKE 'Aamod') 
# Filter previous employees.
AND to_date LIKE '9999%';

# 3. How many people in the employees table are no longer working for the company? Give the answer in a comment in your code.

# 	*** Troubleshooting ***
SELECT COUNT(emp_no) FROM dept_emp
WHERE to_date > CURDATE();
# Current employees = 240,124
SELECT COUNT(emp_no) FROM employees; 
#  300,024 records 
#- 240,124 current employees
#--------------
#  59,900
#		*** ANSWER ***

# We assume any employee number not in the subquery is a previous employee.
SELECT COUNT(emp_no) FROM employees
# Subquery searches for all current employees.
WHERE emp_no NOT IN( SELECT emp_no FROM dept_emp
WHERE to_date > CURDATE());
# 59,900

# 4. Find all the current department managers that are female. List their names in a comment in your code.
#	 *** ANSWER ***

SELECT first_name, last_name FROM employees
WHERE emp_no IN
# Subquery returns emp_no for current dept managers.
(SELECT emp_no FROM dept_manager
WHERE to_date LIKE '9999%')
# Filters employees based on gender.
AND gender LIKE 'F';

# 5. Find all the employees who currently have a higher salary than the companies overall, historical average salary.

#	*** ANSWER ***

SELECT emp_no FROM salaries
WHERE salary > (SELECT AVG(salary) FROM salaries) AND to_date > CURDATE();
# 154,543

# 6. How many current salaries are within 1 standard deviation of the current highest salary? (Hint: you can use a built in function to calculate the standard deviation.)
# Hint You will likely use multiple subqueries in a variety of ways
# Hint It's a good practice to write out all of the small queries that you can. Add a comment above the query showing the number of rows returned. You will use this number (or the query that produced it) in other, larger queries.
#		*** Working it out ***

SELECT MAX(salary) FROM salaries WHERE to_date > CURDATE();
# 158,220.00

SELECT ROUND(STD(salary), 2) FROM salaries WHERE to_date > CURDATE();
# 17,309.96

#		*** ANSWER **

SELECT COUNT(emp_no) FROM salaries
WHERE salary >
# Subquery finds Max current salary 
(SELECT MAX(salary) FROM salaries WHERE to_date > CURDATE()) 
# Subquery subtracts one standard deviation
- (SELECT ROUND(STD(salary), 2) FROM salaries WHERE to_date > CURDATE())
# This filters all previous employees.
AND to_date > CURDATE();
# 83 salaries

#What percentage of all salaries is this?

#	*** ANSWER ***

# I am having trouble getting the syntax for this:
# My plan is a SELECT (Subquery to find number of salaries in max STD) / (Subquery for total number of current salaries.);
# So far it has not worked.

#              ***BONUS***

# 1. Find all the department names that currently have female managers.

# 2. Find the first and last name of the employee with the highest salary.

# 3. Find the department name that the employee with the highest salary works in.