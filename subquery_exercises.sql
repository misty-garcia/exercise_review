use employees;

-- Find all the current employees with the same hire date as employee 101010 using a sub-query.
select *
from employees
where hire_date =
	(
    select hire_date 
    from employees
    where emp_no = 101010
    )
;

-- Find all the titles ever held by all current employees with the first name Aamod.
select title, count(*)
from employees e 
	join dept_emp de
		using (emp_no)
	join titles t
		using (emp_no)
where de.to_date = '9999-01-01'
and first_name = 
	(
    select distinct first_name 
    from employees
    where first_name = 'Aamod'
    )
group by title
;

-- How many people in the employees table are no longer working for the company? Give the answer in a comment in your code.
select count(*) 
from employees
	join 
	(
    select * 
    from dept_emp
	where to_date <> '9999-01-01'
    ) de
		using (emp_no)
;

-- Find all the current department managers that are female. List their names in a comment in your code.
select *
from employees
	join dept_manager dm 
		using (emp_no)
where dm.to_date = '9999-01-01'
and first_name in
	(
    select first_name
    from employees
    where gender = 'F'
    )
;

-- Find all the employees who currently have a higher salary than the companies overall, historical average salary.
select count(*)
from employees
	join salaries
		using (emp_no)
where salary > 
	(
    select avg(salary)
    from salaries
    )
and to_date = '9999-01-01'
;

-- How many current salaries are within 1 standard deviation of the current highest salary? 
-- (Hint: you can use a built in function to calculate the standard deviation.) 
select count(*)
from salaries
where salary >
	(
    select max(salary) - stddev(salary)
    from salaries
    where to_date = '9999-01-01'
    )    
and to_date = '9999-01-01'
;

-- What percentage of all salaries is this?
-- Hint You will likely use multiple subqueries in a variety of ways
-- Hint It's a good practice to write out all of the small queries that you can. 
-- Add a comment above the query showing the number of rows returned. 
-- You will use this number (or the query that produced it) in other, larger queries.
select count(*) / (select count(*) from salaries) * 100
from salaries
where salary >
	(
    select max(salary) - stddev(salary)
    from salaries
    where to_date = '9999-01-01'
    )    
and to_date = '9999-01-01'
;

-- BONUS
-- Find all the department names that currently have female managers.
select * 
from employees
	join dept_manager
		using (emp_no)
where gender = 'F'
and to_date = '9999-01-01'


-- Find the first and last name of the employee with the highest salary.
-- Find the department name that the employee with the highest salary works in.

