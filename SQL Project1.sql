# Michael Atwell - SQL Project #1

/*
List 5 different variable types below.  Explain what can go in them and any limitations they have.
1. Char(x): A fixed string of x number of characters, up to 255 long. 
2. Varchar(c): A variable string up to x number of characters long, up to a maximum of 65,535.
3. Date: The date in YYYY-MM-DD format.
4. Int: an integer, with a range of values +/- 2,147,483,648 
5. Unsigned Int: a positive integer, with a range of values 0 to 4,294,967,295


If you want to make sure a field always has a value in it, what constraint would you use in the column definition?

Not  Null

*/

# Please put all of the queries below in one SQL script.  Remember to document your code.

# Write a query to select all of the columns and rows from the departments table.

select * from departments; 

# Write a query to select employee number, first name, and last name.

select 
    emp_no as 'Employee Number',
    first_name as 'First Name',
    last_name as 'Last Name'
from employees;

# Write a query to select employee’s names and ages.  Age should be calculated in years.

select
    concat(first_name, ' ',last_name) as 'Name',
    timestampdiff(year,birth_date,curdate()) as 'Age'
from employees;

# Write a query to return the current date in the format mm/dd/yyyy.

select date_format(curdate(),'%m/%d/%Y') as 'Current Date';

# Write a query that returns the number of days until July 4th, 2016.

select timestampdiff(day,curdate(),'2016-07-04') as 'Days until July 4th, 2016';

# For the queries below, remember that a “current” record is defined as one having ‘9999-01-01’ in the to_date field.

# Write a query that shows the number of rows in the employees table

select count(*) as 'Rows in Employee table' from employees;

# Write a query that shows all of the salary history of employee # 10911  Casley Shay.  Columns should include salary (##,###.##), effective date (Month dd, Year) and end date (Month dd, Year).

select 
    emp_no as 'Employee Number',
    date_format(from_date,'%M %d, %Y') as 'Effective Date',
    if(to_date='9999-01-01','Present',(date_format(to_date,'%M %d, %Y'))) as 'End Date',
    format(salary,2) as 'Salary'
from salaries where emp_no='10911';

# Write a query that shows the current salary of employee #10607 Rosalyn Hambrick.  Columns should include salary (##,###) and effective date (mm/dd/yy).

select 
    emp_no as 'Employee Number',
    date_format(from_date,'%m/%d/%y') as 'Effective Date',
    format(salary,0) as 'Salary'
from salaries where emp_no='10607' and to_date='9999-01-01';

# Write a query that returns all of the female employees currently making less than 50,000 in the Customer Service department.  Columns should include name (last, first) salary (##,###), and salary effective date (YYYY-MM-DD).  Sort the data in alphabetical order by last name.

# Not done per e-mail.