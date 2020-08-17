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