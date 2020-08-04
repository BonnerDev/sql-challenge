CREATE TABLE "titles" (
    "title_id" varchar   NOT NULL,
    "title" varchar   NOT NULL,
    CONSTRAINT "pk_titles" PRIMARY KEY (
        "title_id"
     )
);

CREATE TABLE "employees" (
    "emp_no" int   NOT NULL,
    "emp_title" varchar   NOT NULL,
    "birth_date" varchar   NOT NULL,
    "first_name" varchar   NOT NULL,
    "last_name" varchar   NOT NULL,
    "sex" varchar   NOT NULL,
    "hire_date" varchar   NOT NULL,
    CONSTRAINT "pk_employees" PRIMARY KEY (
        "emp_no"
     )
);


CREATE TABLE "salaries" (
    "emp_no" int   NOT NULL,
    "salary" int   NOT NULL
);

CREATE TABLE "departments" (
    "dept_no" varchar   NOT NULL,
    "dept_name" varchar   NOT NULL,
    CONSTRAINT "pk_departments" PRIMARY KEY (
        "dept_no"
     )
);

CREATE TABLE "dept_manager" (
    "dept_no" varchar   NOT NULL,
    "emp_no" int   NOT NULL
);

CREATE TABLE "dept_emp" (
    "emp_no" int   NOT NULL,
    "dept_no" varchar   NOT NULL
);

ALTER TABLE "employees" ADD CONSTRAINT "fk_employees_emp_title" FOREIGN KEY("emp_title")
REFERENCES "titles" ("title_id");

ALTER TABLE "salaries" ADD CONSTRAINT "fk_salaries_emp_no" FOREIGN KEY("emp_no")
REFERENCES "employees" ("emp_no");

ALTER TABLE "dept_manager" ADD CONSTRAINT "fk_dept_manager_dept_no" FOREIGN KEY("dept_no")
REFERENCES "departments" ("dept_no");

ALTER TABLE "dept_manager" ADD CONSTRAINT "fk_dept_manager_emp_no" FOREIGN KEY("emp_no")
REFERENCES "employees" ("emp_no");

ALTER TABLE "dept_emp" ADD CONSTRAINT "fk_dept_emp_emp_no" FOREIGN KEY("emp_no")
REFERENCES "employees" ("emp_no");

ALTER TABLE "dept_emp" ADD CONSTRAINT "fk_dept_emp_dept_no" FOREIGN KEY("dept_no")
REFERENCES "departments" ("dept_no");

select * from dept_emp;

create view detail_employee as
select emp_no, first_name,last_name,sex 
from employees;

--List the following details of each employee: employee number, last name, first name, sex, and salary.
create view detail_join_j as
select e.emp_no,first_name,last_name,sex,salary
from employees as e
join salaries as s
on (e.emp_no = s.emp_no)
group by e.emp_no, s.salary;

select * from detail_join_j;

--List first name, last name, and hire date for employees who were hired in 1986
create view hired as
select first_name,last_name,hire_date from employees
where hire_date like '%1986';

select * from hired;

--List the manager of each department with the following information: department number, department name, the manager's employee number, last name, first name.

create view manager as
select d.dept_no,dept_name,dm.emp_no,last_name,first_name 
from employees as e 
join dept_manager as dm 
	on (e.emp_no = dm.emp_no)
	join departments as d
	on (dm.dept_no = d.dept_no);

select * from manager;

--List the department of each employee with the following information: employee number, last name, first name, and department name.

create view department as 
select de.emp_no, last_name, first_name, dept_name
from employees as e
join dept_emp as de
	on (e.emp_no = de.emp_no)
	join departments as d
	on (de.dept_no = d.dept_no);
	
select * from department;
	
--List first name, last name, and sex for employees whose first name is "Hercules" and last names begin with "B."

create view hercules as 
select first_name, last_name, sex
from employees as e 
where first_name='Hercules' and last_name like 'B%';

select * from hercules;

--List all employees in the Sales department, including their employee number, last name, first name, and department name.

create view sales_dept as 
select de.emp_no, last_name, first_name, dept_name
from employees as e
join dept_emp as de
	on (e.emp_no = de.emp_no)
	join departments as d
	on (de.dept_no = d.dept_no)
	where dept_name='Sales';
	
select * from sales_dept;

--List all employees in the Sales and Development departments, including their employee number, last name, first name, and department name

create view sales_dev as
select de.emp_no, last_name, first_name, dept_name
from employees as e
join dept_emp as de
	on (e.emp_no = de.emp_no)
	join departments as d
	on (de.dept_no = d.dept_no)
	where dept_name ='Sales' or 
	dept_name='Development';
	
select * from sales_dev;

--In descending order, list the frequency count of employee last names, i.e., how many employees share each last name.
select employees.last_name, count(employees.last_name)as "Last Name Count"
from employees
group by employees.last_name
order by "Last Name Count" DESC;

