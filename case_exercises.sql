USE employees;
/* 
# 1. Write a query that returns: 
-all employees, 
-their department number, 
-their start date, 
-their end date
-a new column 'is_current_employee' that is a 1 if the employee is still with the company and 0 if not.
*/
#		*** ANSWER during review ***
SELECT first_name, last_name, dept_no, to_date, to_date > NOW() AS 'is_current_employee' 

FROM employees

JOIN dept_emp USING (emp_no);
-- *has duplicate values for when employees change departments.


# 2. Write a query that returns all employee names (previous and current), and a new column 'alpha_group' that returns 'A-H', 'I-Q', or 'R-Z' depending on the first letter of their last name.

SELECT first_name, last_name,
	CASE
		WHEN last_name >= "R" THEN "R-Z"
		WHEN last_name >= "I" THEN "I-Q"
		ELSE "A-H" 
	END AS alpha_group
FROM employees
GROUP BY emp_no;


# 3. How many employees (current or previous) were born in each decade?
SELECT MIN(birth_date), max(birth_date) FROM employees;


SELECT COUNT(*),
	CASE
		WHEN birth_date >= '1960-01-01' THEN '60s'
		WHEN birth_date >= '1950-01-01' THEN '50s'
	END AS 'birth_decade'
FROM employees
GROUP BY birth_decade;
	

# 4. What is the current average salary for each of the following department groups: R&D, Sales & Marketing, Prod & QM, Finance & HR, Customer Service?


SELECT
	CASE
		WHEN dept_name IN ('Research', 'Develpment') THEN 'R&D'
		WHEN dept_name IN ('Sales', 'Marketing') THEN 'Sales & Marketing'
		WHEN dept_name IN ('Production', 'Quality Management') THEN 'Prod & QM'
		WHEN dept_name IN ('Finance', 'Human Resources') THEN 'Finance & HR'
		ELSE 'Customer Service'
	END AS 'new_dept', ROUND(AVG(salary)) AS 'Average Salary'
FROM departments
	JOIN dept_emp USING(dept_no)
	JOIN salaries USING(emp_no)
WHERE dept_emp.to_date > NOW() AND salaries.to_date > NOW()
group by new_dept;