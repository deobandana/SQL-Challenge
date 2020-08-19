--drop exist tables 
drop table dept_emp;
drop table dept_manager;
drop table departments;
drop table salaries;
drop table employees;
drop table titles;
--------------------------------------------------------------
-- Exported from QuickDBD: https://www.quickdatabasediagrams.com/
-- NOTE! If you have used non-SQL datatypes in your design, you will have to change these here.
-- create 6 tables 
CREATE TABLE   departments   (
      dept_no   VARCHAR(20)   NOT NULL,
      dept_name   VARCHAR(20)   NOT NULL,
    CONSTRAINT   pk_departments   PRIMARY KEY (
          dept_no  
     )
);

CREATE TABLE   dept_emp   (
	 emp_no   VARCHAR(20)   NOT NULL,
     dept_no   VARCHAR(20)   NOT NULL,
    CONSTRAINT   pk_dept_emp   PRIMARY KEY (
          dept_no  ,  emp_no  
     )
);

CREATE TABLE   dept_manager   (
      dept_no   VARCHAR(20)   NOT NULL,
      emp_no   VARCHAR(20)   NOT NULL,
    CONSTRAINT   pk_dept_manager   PRIMARY KEY (
          dept_no  ,  emp_no  
     )
);

CREATE TABLE   employees   (
      emp_no   VARCHAR(20)   NOT NULL,
	  emp_title_id   VARCHAR(20)   NOT NULL,
      birth_date_s   VARCHAR(20)    NOT NULL,
      first_name   VARCHAR(20)   NOT NULL,
      last_name   VARCHAR(20)   NOT NULL,
      sex   VARCHAR(6)   NOT NULL,
      hire_date_s    VARCHAR(20)   NOT NULL,
     
    CONSTRAINT   pk_employees   PRIMARY KEY (
          emp_no  
     )
);


CREATE TABLE   salaries   (
      emp_no   VARCHAR(20)   NOT NULL,
      salary   INTEGER   NOT NULL,
    CONSTRAINT   pk_salaries   PRIMARY KEY (
          emp_no  
     )
);

CREATE TABLE   titles   (
      title_id   VARCHAR(20)   NOT NULL,
      title   VARCHAR(20)   NOT NULL,
    CONSTRAINT   pk_titles   PRIMARY KEY (
          title_id  
     )
);

--add constraint for foreign key
ALTER TABLE   dept_emp   ADD CONSTRAINT   fk_dept_emp_dept_no   FOREIGN KEY(  dept_no  )
REFERENCES   departments   (  dept_no  );

ALTER TABLE   dept_emp   ADD CONSTRAINT   fk_dept_emp_emp_no   FOREIGN KEY(  emp_no  )
REFERENCES   employees   (  emp_no  );

ALTER TABLE   dept_manager   ADD CONSTRAINT   fk_dept_manager_dept_no   FOREIGN KEY(  dept_no  )
REFERENCES   departments   (  dept_no  );

ALTER TABLE   dept_manager   ADD CONSTRAINT   fk_dept_manager_emp_no   FOREIGN KEY(  emp_no  )
REFERENCES   employees   (  emp_no  );

ALTER TABLE   employees   ADD CONSTRAINT   fk_employees_emp_title_id   FOREIGN KEY(  emp_title_id  )
REFERENCES   titles   (  title_id  );

ALTER TABLE   salaries   ADD CONSTRAINT   fk_salaries_emp_no   FOREIGN KEY(  emp_no  )
REFERENCES   employees   (  emp_no  );

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
