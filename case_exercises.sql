-- Use CASE statements or IF() function to explore information in the employees database
-- Create a file named case_exercises.sql and craft queries to return the results for the following criteria.
use employees;

-- Write a query that returns all employees, their department number, their start date, 
-- their end date, and a new column 'is_current_employee' that is a 1 if the employee is still with the company and 0 if not.
select
	emp_no
	, first_name
    , last_name
    , dept_no
    , hire_date
    , to_date
    , case
		when to_date = '9999-01-01' then 1 
        else 0
	end as is_current_employee
from employees
	join dept_emp
		using (emp_no)
	join departments
		using (dept_no)
order by emp_no
;


-- Write a query that returns all employee names (previous and current), and a new column 'alpha_group' that 
-- returns 'A-H', 'I-Q', or 'R-Z' depending on the first letter of their last name.

-- How many employees (current or previous) were born in each decade?

-- What is the current average salary for each of the following department groups: 
-- R&D, Sales & Marketing, Prod & QM, Finance & HR, Customer Service?