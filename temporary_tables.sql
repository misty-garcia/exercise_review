-- Create a file named temporary_tables.sql to do your work for this exercise.


-- Using the example from the lesson, create a temporary table called employees_with_departments that contains first_name, 
-- last_name, and dept_name for employees currently with that department. Be absolutely sure to create this table on your own database. 
-- If you see "Access denied for user ...", it means that the query was attempting to write a new table to a database that you can only read.
use employees;
select 
	first_name
	, last_name 
	, dept_name
from employees
	join dept_emp
		using (emp_no)
	join departments
		using (dept_no)
;

use bayes_811;
create temporary table employees_with_departments as
	select 
		first_name
        , last_name 
        , dept_name
	from employees.employees
		join employees.dept_emp
			using (emp_no)
		join employees.departments
			using (dept_no)
;

drop table employees_with_departments;
select * from employees_with_departments;


-- Add a column named full_name to this table. It should be a VARCHAR whose length is the sum of the lengths of the first name and last name columns
-- Update the table so that full name column contains the correct data.
describe employees_with_departments;

alter table employees_with_departments
add full_name varchar(30)
;

select * from employees_with_departments;

update employees_with_departments
set full_name = concat(first_name, ' ', last_name)
;

-- Remove the first_name and last_name columns from the table.

-- What is another way you could have ended up with this same table?
-- Create a temporary table based on the payment table from the sakila database.

-- Write the SQL necessary to transform the amount column such that it is stored as an integer 
-- representing the number of cents of the payment. For example, 1.99 should become 199.

-- Find out how the current average pay in each department compares to the overall current pay for everyone 
-- at the company. In order to make the comparison easier, you should use the Z-score for salaries. In terms of salary, 
-- what is the best department right now to work for? The worst?

-- Hint Consider that the following code will produce the z score for current salaries.


-- Returns the historic z-scores for each salary
-- Notice that there are 2 separate scalar subqueries involved
-- SELECT salary,
--     (salary - (SELECT AVG(salary) FROM salaries))
--     /
--     (SELECT stddev(salary) FROM salaries) AS zscore
-- FROM salaries;

-- BONUS To your work with current salary zscores, determine the overall historic average departement average salary, 
-- the historic overall average, and the historic zscores for salary. Do the zscores for current department average salaries 
-- tell a similar or a different story than the historic department salary zscores?