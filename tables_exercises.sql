
-- Use the employees database. Write the SQL code necessary to do this.
USE employees;

-- List all the tables in the database. Write the SQL code necessary to accomplish this.
SHOW TABLES;

-- Explore the employees table. What different data types are present on this table?
DESCRIBE employees;

-- Question 6: "Which table(s) do you think contain a numeric type column?"
-- Answer: I think all tables will contain a numeric tpye column.

-- Question 7: "Which table(s) do you think contain a string type column?"
-- Answer: I think all tables except salaries will contain a string type column.

-- Question 8: "Which table(s) do you think contain a date type column?"
-- Answer: dept_manager, employees, salaries, and titles will have data type collumn.

-- Question 9: "What is the relationship between the employees and the departments tables?"
-- Answer: The emp_no is linked to the departments table through the dept_emp table. Specifically the emp_no and the dept_no fields.

-- Question 10: "Show the SQL that created the dept_manager table."

SHOW CREATE TABLE dept_manager;

/* CREATE TABLE `dept_manager` (
  `emp_no` int NOT NULL,
  `dept_no` char(4) NOT NULL,
  `from_date` date NOT NULL,
  `to_date` date NOT NULL,
  PRIMARY KEY (`emp_no`,`dept_no`),
  KEY `dept_no` (`dept_no`),
  CONSTRAINT `dept_manager_ibfk_1` FOREIGN KEY (`emp_no`) REFERENCES `employees` (`emp_no`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `dept_manager_ibfk_2` FOREIGN KEY (`dept_no`) REFERENCES `departments` (`dept_no`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=latin1
/*


