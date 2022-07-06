-- Create a file named where_exercises.sql. Make sure to use the employees database.
use employees;

-- Find all current or previous employees with first names 'Irena', 'Vidya', or 'Maya' using IN. 
-- Enter a comment with the number of records returned.
select *
from employees
where first_name in ('Irena', 'Vidya', 'Maya')
;

-- Find all current or previous employees with first names 'Irena', 'Vidya', or 'Maya', as in Q2, but use OR instead of IN. 
-- Enter a comment with the number of records returned. Does it match number of rows from Q2?
select *
from employees
where first_name ='Irena'
or first_name = 'Vidya'
or first_name = 'Maya'
;

-- Find all current or previous employees with first names 'Irena', 'Vidya', or 'Maya', using OR, and who is male. 
-- Enter a comment with the number of records returned.
select *
from employees
where first_name ='Irena'
or first_name = 'Vidya'
or first_name = 'Maya'
and gender = 'M'
;

-- Find all current or previous employees whose last name starts with 'E'. 
-- Enter a comment with the number of employees whose last name starts with E.
select *
from employees
where last_name like 'e%'
;

-- Find all current or previous employees whose last name starts or ends with 'E'. 
-- Enter a comment with the number of employees whose last name starts or ends with E. 
-- How many employees have a last name that ends with E, but does not start with E?
select *
from employees
where last_name like 'e%'
or last_name like '%e';

select *
from employees
where last_name not like 'e%'
and last_name like '%e';

-- Find all current or previous employees employees whose last name starts and ends with 'E'. 
-- Enter a comment with the number of employees whose last name starts and ends with E. 
-- How many employees' last names end with E, regardless of whether they start with E?
select * 
from employees
where last_name like 'e%e'
;

select * 
from employees
where last_name like '%e'
;

-- Find all current or previous employees hired in the 90s. 
-- Enter a comment with the number of employees returned.
select *
from employees
where hire_date between '1990-01-01' and '2020-01-01'
;

-- Find all current or previous employees born on Christmas. 
-- Enter a comment with the number of employees returned.
select *
from employees
where birth_date like '%12-25'
;

-- Find all current or previous employees hired in the 90s and born on Christmas. 
-- Enter a comment with the number of employees returned.
select *
from employees
where hire_date between '1990-01-01' and '2020-01-01'
and birth_date like '%12-25'
;

-- Find all current or previous employees with a 'q' in their last name. 
-- Enter a comment with the number of records returned.
select *
from employees
where last_name like '%q%'
;

-- Find all current or previous employees with a 'q' in their last name but not 'qu'. 
-- How many employees are found?
select *
from employees
where last_name like '%q%'
and last_name not like '%qu%'
;