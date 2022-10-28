#Join Example Database
#Use the join_example_db. Select all the records from both the users and roles tables.
USE join_example_db;
SELECT *
FROM users
JOIN roles
ON users.role_id = roles.id;

#Use join, left join, and right join to combine results from the users and roles tables as we did in the lesson. Before you run each query, guess the expected number of results.
SELECT *
FROM users
JOIN roles
ON users.role_id = roles.id;

#Left JOIN
SELECT *
FROM users
LEFT JOIN roles
ON users.role_id = roles.id;

#Right JOIN
SELECT *
FROM users
RIGHT JOIN roles
ON users.role_id = roles.id;

#Although not explicitly covered in the lesson, aggregate functions like count can be used with join queries. Use count and the appropriate join type to get a list of roles along with the number of users that has the role. Hint: You will also need to use group by in the query.

DESCRIBE users;
# id, name, email, role_id
DESCRIBE roles;
# id, name

SELECT roles.name, COUNT(role_id)
FROM users
JOIN roles
ON users.role_id = roles.id
GROUP BY roles.name;


#Employees Database
#Use the employees database.
USE employees;

/* 2. Using the example in the Associative Table Joins section as a guide, write a query that shows each department along with the name of the current manager for that department.

  Department Name    | Department Manager
 --------------------+--------------------
  Customer Service   | Yuchang Weedman
  Development        | Leon DasSarma
  Finance            | Isamu Legleitner
  Human Resources    | Karsten Sigstam
  Marketing          | Vishwani Minakawa
  Production         | Oscar Ghazalie
  Quality Management | Dung Pesch
  Research           | Hilary Kambil
  Sales              | Hauke Zhang
*/  

DESCRIBE departments;
# dept_no, dept_name
DESCRIBE dept_emp;
# emp_no, dept_no, from_date, to_date
DESCRIBE dept_manager;
# emp_no, dept_no, from_date, to_date
DESCRIBE employees; # dept_manager are in employees
# emp_no, birth_date, first_name, last_name, gender, hire_date
DESCRIBE salaries;
# emp_no, salary, from_date, to_date
DESCRIBE titles;
# emp_no, title, from_date, to_date

#            ***ANSWER***

# Select grabs the three fields we want to display and changes them to display as desired:
SELECT dept_name AS "Department Name", CONCAT(first_name, ' ', last_name) AS "Manager Name" FROM departments
#This is a triple join that uses dept_no -> dept_manager -> emp_no to map the manager id to employee name.
JOIN dept_manager ON departments.dept_no = dept_manager.dept_no
JOIN employees ON employees.emp_no = dept_manager.emp_no
# The WHERE filters previous managers, leaving the current manager.
WHERE dept_manager.to_date LIKE '9999%'
ORDER BY dept_name;

/* 3. Find the name of all departments currently managed by women.

Department Name | Manager Name
----------------+-----------------
Development     | Leon DasSarma
Finance         | Isamu Legleitner
Human Resources | Karsetn Sigstam
Research        | Hilary Kambil
*/

#            ***ANSWER***

# Select grabs the three fields we want to display and changes them to display as desired:
SELECT dept_name AS "Department Name", CONCAT(first_name, ' ', last_name) AS "Manager Name" FROM departments
#This is a triple join that uses dept_no -> dept_manager -> emp_no to map the manager id to employee name.
JOIN dept_manager ON departments.dept_no = dept_manager.dept_no
JOIN employees ON employees.emp_no = dept_manager.emp_no
# The WHERE filters previous managers and males, leaving the current female managers.
WHERE dept_manager.to_date LIKE '9999%' AND employees.gender like 'F'
ORDER BY dept_name;


/* 4. Find the current titles of employees currently working in the Customer Service department.

Title              | Count
-------------------+------
Assistant Engineer |    68
Engineer           |   627
Manager            |     1
Senior Engineer    |  1790
Senior Staff       | 11268
Staff              |  3574
Technique Leader   |   241
*/

#            ***ANSWER***

# Start with title
SELECT title as "Title", COUNT(title) AS Count FROM dept_emp
# Joining departments and titles to link.
JOIN departments USING (dept_no)
JOIN titles USING (emp_no)
# Filter for Customer Service and ensure they are currently in the dept.
WHERE dept_name LIKE "Customer Service" AND titles.to_date LIKE "9999%"
GROUP BY title
ORDER BY title ASC; 

/* 5. Find the current salary of all current managers.

Department Name    | Name              | Salary
-------------------+-------------------+-------
Customer Service   | Yuchang Weedman   |  58745
Development        | Leon DasSarma     |  74510
Finance            | Isamu Legleitner  |  83457
Human Resources    | Karsten Sigstam   |  65400
Marketing          | Vishwani Minakawa | 106491
Production         | Oscar Ghazalie    |  56654
Quality Management | Dung Pesch        |  72876
Research           | Hilary Kambil     |  79393
Sales              | Hauke Zhang       | 101987
*/

#            ***ANSWER***

# Select grabs the three fields we want to display and changes them to display as desired:
SELECT dept_name AS "Department Name", CONCAT(first_name, ' ', last_name) AS "Manager Name", salaries.salary AS "Salary" FROM departments
#This is a triple join that uses dept_no -> dept_manager -> emp_no to map the manager id to employee name.
#This looks ugly. Could I do a triple join just on emp_no?
JOIN dept_manager ON departments.dept_no = dept_manager.dept_no
JOIN employees ON employees.emp_no = dept_manager.emp_no
JOIN salaries ON dept_manager.emp_no = salaries.emp_no
# The WHERE filters previous managers, leaving the current manager.
WHERE dept_manager.to_date LIKE '9999%' AND salaries.to_date LIKE '9999%'
ORDER BY dept_name;

/* 6. Find the number of current employees in each department.

+---------+--------------------+---------------+
| dept_no | dept_name          | num_employees |
+---------+--------------------+---------------+
| d001    | Marketing          | 14842         |
| d002    | Finance            | 12437         |
| d003    | Human Resources    | 12898         |
| d004    | Production         | 53304         |
| d005    | Development        | 61386         |
| d006    | Quality Management | 14546         |
| d007    | Sales              | 37701         |
| d008    | Research           | 15441         |
| d009    | Customer Service   | 17569         |
+---------+--------------------+---------------+
*/

#            ***ANSWER***

SELECT dept_no, dept_name, COUNT(dept_no) FROM departments
LEFT JOIN dept_emp USING (dept_no) WHERE to_date LIKE '9999%'
GROUP BY dept_no, dept_name
ORDER BY dept_no ASC;

/* 7. Which department has the highest average salary? Hint: Use current not historic information.

+-----------+----------------+
| dept_name | average_salary |
+-----------+----------------+
| Sales     | 88852.9695     |
+-----------+----------------+
*/
DESCRIBE departments;
# dept_no, dept_name
DESCRIBE dept_emp;
# emp_no, dept_no, from_date, to_date
DESCRIBE dept_manager;
# emp_no, dept_no, from_date, to_date
DESCRIBE employees; # dept_manager are in employees
# emp_no, birth_date, first_name, last_name, gender, hire_date
DESCRIBE salaries;
# emp_no, salary, from_date, to_date
DESCRIBE titles;
# emp_no, title, from_date, to_date


#      *** Troubleshooting ***
/*
Notes:
COUNT(salary) = 240124. 

Sales dept_id= d007

COUNT(dept_no) = d007 is 37701 COUNT Not (d007) is 202423 => Total = 240124

SUM(salary) of current Sales employees = 32204777445
*/

SELECT COUNT(dept_no) FROM dept_emp
WHERE to_date LIKE "9999%" AND dept_no LIKE 'd007';
# 37701

SELECT SUM(salary) FROM salaries
FULL JOIN dept_emp USING (emp_no)
WHERE dept_emp.to_date LIKE '9999%' AND dept_no LIKE 'd007';
# 32204777445

SELECT 32204777445 / 37701;
# 854,215.4703 - way too high. I'm missing a filter somewhere.

#            ***ANSWER***

# My average for Sales was 88842.1590 which is $10ish low. I had to look at the answer on GitHub and did not think to use both 'to_date's from salaries and dept_emp.
SELECT dept_name, AVG(salary) AS average_salary FROM salaries
JOIN dept_emp USING (emp_no)
JOIN departments USING (dept_no)
# My error was not using both "to_date"s to filter current salaries in sales.
WHERE salaries.to_date > CURDATE() AND dept_emp.to_date > CURDATE()
GROUP BY dept_no
ORDER BY AVG(salary) DESC
LIMIT 1;

/*8. Who is the highest paid employee in the Marketing department?

+------------+-----------+
| first_name | last_name |
+------------+-----------+
| Akemi      | Warwick   |
+------------+-----------+
*/

#                 *** ANSWER ***

SELECT first_name, last_name FROM employees
# Joining desired tables on emp_no and dept_no
JOIN dept_emp USING (emp_no)
JOIN departments USING (dept_no)
JOIN salaries USING (emp_no)
# My filter for current employees in Marketing
WHERE salaries.to_date > CURDATE() AND dept_emp.to_date > CURDATE() AND departments.dept_name LIKE "Marketing"
ORDER BY salaries.salary DESC
# This feels like lazy programing but allows flexability to change the amount returned.
LIMIT 1; 

/*9. Which current department manager has the highest salary?

+------------+-----------+--------+-----------+
| first_name | last_name | salary | dept_name |
+------------+-----------+--------+-----------+
| Vishwani   | Minakawa  | 106491 | Marketing |
+------------+-----------+--------+-----------+
*/

# Select grabs the three fields we want to display and changes them to display as desired:
SELECT first_name, last_name, salaries.salary, dept_name FROM departments
# Join using dept_no and emp_no to map accross tables.
JOIN dept_manager ON departments.dept_no = dept_manager.dept_no
JOIN employees ON employees.emp_no = dept_manager.emp_no
JOIN salaries ON dept_manager.emp_no = salaries.emp_no
# The WHERE filters previous managers, leaving the current manager and salary.
WHERE dept_manager.to_date LIKE '9999%' AND salaries.to_date LIKE '9999%'
ORDER BY salary DESC
LIMIT 1;

/*10. Determine the average salary for each department. Use all salary information and round your results.

+--------------------+----------------+
| dept_name          | average_salary | 
+--------------------+----------------+
| Sales              | 80668          | 
+--------------------+----------------+
| Marketing          | 71913          |
+--------------------+----------------+
| Finance            | 70489          |
+--------------------+----------------+
| Research           | 59665          |
+--------------------+----------------+
| Production         | 59605          |
+--------------------+----------------+
| Development        | 59479          |
+--------------------+----------------+
| Customer Service   | 58770          |
+--------------------+----------------+
| Quality Management | 57251          |
+--------------------+----------------+
| Human Resources    | 55575          |
+--------------------+----------------+
*/


#     *** ANSWER ***

# The value of money changes over time. This doesn't seem correct but I can't form a solid counter argument.
SELECT dept_name, ROUND(AVG(salary)) AS average_salary FROM salaries
JOIN dept_emp USING (emp_no)
JOIN departments USING (dept_no)
# My error was not using both "to_date"s to filter current salaries in sales.
# WHERE salaries.to_date > CURDATE() AND dept_emp.to_date > CURDATE()
GROUP BY dept_no
ORDER BY AVG(salary) DESC;

/*Bonus Find the names of all current employees, their department name, and their current manager's name.

240,124 Rows
Employee Name | Department Name  |  Manager Name
--------------|------------------|-----------------
 Huan Lortz   | Customer Service | Yuchang Weedman

 .....
*/
DESCRIBE departments;
# dept_no, dept_name
DESCRIBE dept_emp;
# emp_no, dept_no, from_date, to_date
DESCRIBE dept_manager;
# emp_no, dept_no, from_date, to_date
DESCRIBE employees; # dept_manager are in employees
# emp_no, birth_date, first_name, last_name, gender, hire_date
DESCRIBE salaries;
# emp_no, salary, from_date, to_date
DESCRIBE titles;
# emp_no, title, from_date, to_date



# Bonus Who is the highest paid employee within each department.