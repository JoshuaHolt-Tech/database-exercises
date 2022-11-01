#Using the example from the lesson, create a temporary table called employees_with_departments that contains first_name, last_name, and dept_name for employees currently with that department. Be absolutely sure to create this table on your own database. If you see "Access denied for user ...", it means that the query was attempting to write a new table to a database that you can only read.
USE employees;

DROP TEMPORARY TABLE IF EXISTS noether_2025.employees_with_departments;
CREATE TEMPORARY TABLE noether_2025.employees_with_departments AS (SELECT first_name, last_name, dept_name FROM employees
JOIN dept_emp USING (emp_no)
JOIN departments USING (dept_no));

USE noether_2025;

#Add a column named full_name to this table. It should be a VARCHAR whose length is the sum of the lengths of the first name and last name columns
#Update the table so that full name column contains the correct data
#Remove the first_name and last_name columns from the table.
#What is another way you could have ended up with this same table?
-- Use a different command like MERGE or UNION.
-- Created full_name on creation using a CONCAT()

ALTER TABLE employees_with_departments ADD full_name VARCHAR(30);
SELECT * FROM noether_2025.employees_with_departments;

USE employees;
UPDATE noether_2025.employees_with_departments SET full_name = CONCAT(first_name, ' ', last_name);
ALTER TABLE noether_2025.employees_with_departments DROP first_name;
ALTER TABLE noether_2025.employees_with_departments DROP last_name;

SELECT * FROM noether_2025.employees_with_departments;

#Create a temporary table based on the payment table from the sakila database.
USE sakila;
DROP TEMPORARY TABLE IF EXISTS noether_2025.sakila_payment;

CREATE TEMPORARY TABLE noether_2025.sakila_payment AS (SELECT * FROM sakila.payment);

#Write the SQL necessary to transform the amount column such that it is stored as an integer representing the number of cents of the payment. For example, 1.99 should become 199.
USE noether_2025;
SELECT amount FROM sakila_payment
LIMIT 10;
SELECT CAST(amount* 100 as unsigned) AS cents FROM noether_2025.sakila_payment;


# SELECT CONVERT(INT, '888');
#Find out how the current average pay in each department compares to the overall current pay for everyone at the company. In order to make the comparison easier, you should use the Z-score for salaries. In terms of salary, what is the best department right now to work for? The worst?

#Hint Consider that the following code will produce the z score for current salaries.


-- Returns the historic z-scores for each salary
-- Notice that there are 2 separate scalar subqueries involved
#SELECT salary,
    #(salary - (SELECT AVG(salary) FROM salaries))
    #/
    #(SELECT stddev(salary) FROM salaries) AS zscore
#FROM salaries;
#BONUS To your work with current salary zscores, determine the overall historic average departement average salary, the historic overall average, and the historic zscores for salary. Do the zscores for current department average salaries tell a similar or a different story than the historic department salary zscores?