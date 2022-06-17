-- Open MySQL Workbench and login to the database server

-- Save your work in a file named tables_exercises.sql

-- Use the employees database. Write the SQL code necessary to do this.
use employees;

-- List all the tables in the database. Write the SQL code necessary to accomplish this.
show tables;

-- Explore the employees table. What different data types are present on this table?
describe employees;

-- Which table(s) do you think contain a numeric type column? (Write this question and your answer in a comment)

-- Which table(s) do you think contain a string type column? (Write this question and your answer in a comment)

-- Which table(s) do you think contain a date type column? (Write this question and your answer in a comment)

-- What is the relationship between the employees and the departments tables? (Write this question and your answer in a comment)
describe departments;

-- Show the SQL that created the dept_manager table. Write the SQL it takes to show this as your exercise solution.
show create table dept_manager;