SET datestyle = "ISO, MDY";
SHOW datestyle;
--I import birth_date and hire_date columns from csv file as string 
--add two new columns with "real date type" for employees table. 
alter table employees add birth_date date;
alter table employees add hire_date date;
--convert string to date into new column "birth_date, hire_date" 
--from "birth_date_s and hire_date_s"
UPDATE employees
SET birth_date=CAST(birth_date_s AS date) ;
UPDATE employees
SET hire_date=CAST(hire_date_s AS date) ;

--remove two coumns 
ALTER TABLE employees DROP COLUMN birth_date_s;
ALTER TABLE employees DROP COLUMN hire_date_s;

--------------------------------------------------------------
--1. List the following details of each employee: 
--employee number, last name, first name, sex, and salary.
SELECT e.emp_no as "Employee number", 
		e.last_name as "Last name", 
		e.first_name as "First name", 
		e.sex as "Sex", 
		s.salary as "Salary"
FROM employees as e 
JOIN salaries as s 
ON e.emp_no = s.emp_no;
--------------------------------------------------------------
--2. List first name, last name, and hire date 
--for employees who were hired in 1986.

SELECT first_name as "First name", 
		last_name as "Last name", 
		hire_date as "Hire Date"
FROM employees 
WHERE hire_date
BETWEEN '1986-01-01' AND '1986-12-31'
Order by hire_date asc;
--------------------------------------------------------------
--3. List the manager of each department with the following information: 
--department number, department name, the manager's employee number, last name, first name.
SELECT d.dept_no as "Department Number", 
	   d.dept_name as "Department Name",  
	   m.emp_no as "Manager''s employee number", 
	   e.last_name as "Manager''s last name", 
	   e.first_name as "Manager''s first name"
FROM departments as d
JOIN dept_manager as m  ON d.dept_no = m.dept_no
JOIN employees as e ON m.emp_no = e.emp_no;
--------------------------------------------------------------
--4 List the department of each employee with the following information: 
--employee number, last name, first name, and department name.
SELECT e.emp_no as "Employee Number", 
	   e.last_name as "Last name",  
	   e.first_name as "First name", 
	   d.dept_name as "Department name"
FROM departments as d
JOIN dept_emp as de  ON d.dept_no = de.dept_no
JOIN employees as e ON de.emp_no = e.emp_no;
--------------------------------------------------------------
--5. List first name, last name, and sex for employees whose 
--first name is "Hercules" and last names begin with "B."

SELECT first_name as "First Name", 
		last_name as "Last Name",
		sex as "Sex"
FROM employees WHERE first_name = 'Hercules' AND last_name LIKE 'B%';
--------------------------------------------------------------
--6. List all employees in the Sales department, including their 
--employee number, last name, first name, and department name.

SELECT e.emp_no as "Employee Number", 
	   e.last_name as "Last name",  
	   e.first_name as "First name", 
	   d.dept_name as "Department name"
FROM departments as d
JOIN dept_emp as de  ON d.dept_no = de.dept_no
JOIN employees as e ON de.emp_no = e.emp_no
WHERE d.dept_name = 'Sales';
--------------------------------------------------------------
--7. List all employees in the Sales and Development departments, 
--including their employee number, last name, first name, and department name.

SELECT e.emp_no as "Employee Number", 
	   e.last_name as "Last name",  
	   e.first_name as "First name", 
	   d.dept_name as "Department name"
FROM departments as d
JOIN dept_emp as de  ON d.dept_no = de.dept_no
JOIN employees as e ON de.emp_no = e.emp_no
WHERE d.dept_name = 'Sales' or d.dept_name = 'Development';
--------------------------------------------------------------
--8. In descending order, list the frequency count of employee last names, i.e., 
--how many employees share each last name.

SELECT last_name as "Last Name", count(last_name) as "Frequency"
FROM employees
GROUP BY last_name
ORDER BY 2 desc;
