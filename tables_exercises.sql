USE employees;

SHOW TABLES;

DESCRIBE employees;

-- Question 6: "Which table(s) do you think contain a numeric type column?"
-- Answer: emp_no - int.

-- Question 7: "Which table(s) do you think contain a string type column?"
-- Answer: first_name, last_name and gender tables.

-- Question 8: "Which table(s) do you think contain a date type column?"
-- Answer: birth_date and hire_date tables.

-- Question 9: "What is the relationship between the employees and the departments tables?"
-- Answer: The emp_no is linked to the departments table through the dept_emp table. Specifically the emp_no and the dept_no fields.

-- Question 10: "Show the SQL that created the dept_manager table."

SHOW CREATE TABLE dept_manager;



