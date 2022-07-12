-- Use the join_example_db. Select all the records from both the users and roles tables.-- 
use join_example_db;

select * from users;

select * from roles;

-- Use join, left join, and right join to combine results from the users and roles tables as we did in the lesson. 
-- Before you run each query, guess the expected number of results.
select * 
from users
	join roles
		using (id) 
;

select * 
from users
	left join roles
		using (id) 
;

select * 
from users
	right join roles
		using (id) 
;


-- Although not explicitly covered in the lesson, aggregate functions like count can be used with join queries. 
-- Use count and the appropriate join type to get a list of roles along with the number of users that has the role. 
-- Hint: You will also need to use group by in the query.
select roles.name, count(*) 
from roles
	right join users
		on users.id = roles.id 
group by roles.name
;

-- Use the employees database.
use employees;

-- Using the example in the Associative Table Joins section as a guide, write a query that 
-- shows each department along with the name of the current manager for that department.
select * from employees limit 10;
select * from dept_manager limit 10;

select dept_name, concat(first_name, ' ' ,last_name) as department_manager
from employees e
	join dept_manager dm
		on e.emp_no = dm.emp_no
	join departments d 
		on d.dept_no = dm.dept_no
where dm.to_date = '9999-01-01'
order by dept_name
;

--   Department Name    | Department Manager
--  --------------------+--------------------
--   Customer Service   | Yuchang Weedman
--   Development        | Leon DasSarma
--   Finance            | Isamu Legleitner
--   Human Resources    | Karsten Sigstam
--   Marketing          | Vishwani Minakawa
--   Production         | Oscar Ghazalie
--   Quality Management | Dung Pesch
--   Research           | Hilary Kambil
--   Sales              | Hauke Zhang

-- Find the name of all departments currently managed by women.
select dept_name, concat(first_name, ' ' ,last_name) as department_manager, gender
from employees
	join dept_manager
		using (emp_no)
	join departments
		using (dept_no)
where to_date = '9999-01-01'
and gender = 'F'
order by dept_name
;

-- Department Name | Manager Name
-- ----------------+-----------------
-- Development     | Leon DasSarma
-- Finance         | Isamu Legleitner
-- Human Resources | Karsetn Sigstam
-- Research        | Hilary Kambil

-- Find the current titles of employees currently working in the Customer Service department.
select * from dept_emp;

select title, count(*) 
from employees e 
	join dept_emp de  
		on e.emp_no = de.emp_no
	join departments d 
		on d.dept_no = de.dept_no
	join titles t
		on e.emp_no = t.emp_no
where d.dept_name = 'Customer Service'
and de.to_date = '9999-01-01'
and t.to_date = '9999-01-01'
group by title
order by title
;

-- Title              | Count
-- -------------------+------
-- Assistant Engineer |    68
-- Engineer           |   627
-- Manager            |     1
-- Senior Engineer    |  1790
-- Senior Staff       | 11268
-- Staff              |  3574
-- Technique Leader   |   241

-- Find the current salary of all current managers.
select 
	dept_name
    , concat(first_name, ' ', last_name)
    , salary
from employees e
	join dept_manager dm
		using (emp_no)
	join salaries s
		using (emp_no)
	join departments
		using (dept_no)
where dm.to_date = '9999-01-01'
	and s.to_date = '9999-01-01'
order by dept_name
;

-- Department Name    | Name              | Salary
-- -------------------+-------------------+-------
-- Customer Service   | Yuchang Weedman   |  58745
-- Development        | Leon DasSarma     |  74510
-- Finance            | Isamu Legleitner  |  83457
-- Human Resources    | Karsten Sigstam   |  65400
-- Marketing          | Vishwani Minakawa | 106491
-- Production         | Oscar Ghazalie    |  56654
-- Quality Management | Dung Pesch        |  72876
-- Research           | Hilary Kambil     |  79393
-- Sales              | Hauke Zhang       | 101987


-- Find the number of current employees in each department.
select dept_no, dept_name, count(*) 
from employees e
	join dept_emp de 
		using(emp_no)
	join departments
		using (dept_no)
where de.to_date = '9999-01-01'
group by dept_name
order by dept_no
;

-- +---------+--------------------+---------------+
-- | dept_no | dept_name          | num_employees |
-- +---------+--------------------+---------------+
-- | d001    | Marketing          | 14842         |
-- | d002    | Finance            | 12437         |
-- | d003    | Human Resources    | 12898         |
-- | d004    | Production         | 53304         |
-- | d005    | Development        | 61386         |
-- | d006    | Quality Management | 14546         |
-- | d007    | Sales              | 37701         |
-- | d008    | Research           | 15441         |
-- | d009    | Customer Service   | 17569         |
-- +---------+--------------------+---------------+

-- Which department has the highest average salary? Hint: Use current not historic information.
select dept_name, round(avg(salary),0) as avg_salary
from employees e 
	join salaries s 
		using (emp_no)
	join dept_emp de 
		using (emp_no)
	join departments
		using (dept_no)
where s.to_date = '9999-01-01'
	and de.to_date = '9999-01-01'
group by dept_no 
order by avg_salary desc
limit 1
;

-- +-----------+----------------+
-- | dept_name | average_salary |
-- +-----------+----------------+
-- | Sales     | 88852.9695     |
-- +-----------+----------------+

-- Who is the highest paid employee in the Marketing department?
select first_name, last_name, salary 
from employees e
	join dept_emp de
		using (emp_no)
	join departments d
		using (dept_no)
	join salaries s 
		using (emp_no)
where d.dept_name = 'Marketing'
	and de.to_date = '9999-01-01'
    and s.to_date = '9999-01-01'
order by salary desc
limit 1
;

-- +------------+-----------+
-- | first_name | last_name |
-- +------------+-----------+
-- | Akemi      | Warwick   |
-- +------------+-----------+

-- Which current department manager has the highest salary?
select dept_name, first_name, last_name, salary
from employees e
	join dept_emp de
		using (emp_no)
	join departments d 
		using (dept_no)
	join dept_manager dm 
		using (emp_no)
	join salaries s
		using (emp_no)
where de.to_date = '9999-01-01'
	and dm.to_date = '9999-01-01'
    and s.to_date = '9999-01-01'
order by salary desc
limit 1 
;

-- +------------+-----------+--------+-----------+
-- | first_name | last_name | salary | dept_name |
-- +------------+-----------+--------+-----------+
-- | Vishwani   | Minakawa  | 106491 | Marketing |
-- +------------+-----------+--------+-----------+

-- Determine the average salary for each department. Use all salary information and round your results.
select dept_name, round(avg(salary),0) as avg_salary
from employees e 
	join dept_emp de 
		using (emp_no)
	join salaries s 
		using (emp_no)
	join departments d 
		using (dept_no)
-- where de.to_date = '9999-01-01'
-- 	and s.to_date = '9999-01-01'
group by dept_no
order by avg_salary desc
;

-- +--------------------+----------------+
-- | dept_name          | average_salary | 
-- +--------------------+----------------+
-- | Sales              | 80668          | 
-- +--------------------+----------------+
-- | Marketing          | 71913          |
-- +--------------------+----------------+
-- | Finance            | 70489          |
-- +--------------------+----------------+
-- | Research           | 59665          |
-- +--------------------+----------------+
-- | Production         | 59605          |
-- +--------------------+----------------+
-- | Development        | 59479          |
-- +--------------------+----------------+
-- | Customer Service   | 58770          |
-- +--------------------+----------------+
-- | Quality Management | 57251          |
-- +--------------------+----------------+
-- | Human Resources    | 55575          |
-- +--------------------+----------------+


-- Bonus Find the names of all current employees, their department name, and their current manager's name.
select * from dept_manager limit 10;

select 
	concat(e.first_name, ' ', e.last_name) as current_employee
	, dept_name
    , concat(e2.first_name, ' ', e2.last_name) as manager
from employees e
	join dept_emp de
		using (emp_no)
	join departments
		using (dept_no)
	join dept_manager dm
		using (dept_no)
	join employees e2
		on dm.emp_no = e2.emp_no
where de.to_date = '9999-01-01'
	and dm.to_date = '9999-01-01'
-- 	and e.first_name = 'Huan'
--  and e.last_name = 'Lortz'
;

select count(*)
from employees e
	join dept_emp de
		using (emp_no)
	join departments
		using (dept_no)
	join dept_manager dm
		using (dept_no)
	join employees e2
		on dm.emp_no = e2.emp_no
where de.to_date = '9999-01-01'
	and dm.to_date = '9999-01-01'
;

select 
	-- concat(e.first_name, ' ', e.last_name) as current_employee
	dept_name
    , concat(e2.first_name, ' ', e2.last_name) as manager
from employees e
	join dept_emp de
		using (emp_no)
	join departments
		using (dept_no)
	join dept_manager dm
		using (dept_no)
	join employees e2
		on dm.emp_no = e2.emp_no
where de.to_date = '9999-01-01'
	and dm.to_date = '9999-01-01'
group by dept_name, manager
;

-- 240,124 Rows

-- Employee Name | Department Name  |  Manager Name
-- --------------|------------------|-----------------
--  Huan Lortz   | Customer Service | Yuchang Weedman


-- Bonus Who is the highest paid employee within each department.
select 
	d.dept_name
    , max(s.salary) as max_salary
from employees e 
	join dept_emp de 
		using (emp_no)
	join departments d 
		using (dept_no)
	join salaries s
		using (emp_no)
	join salaries
where de.to_date = '9999-01-01'
	and s.to_date = '9999-01-01'
group by dept_name
order by max_salary desc
;