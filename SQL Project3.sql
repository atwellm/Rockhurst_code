/* SQL Project #3.
Please put all of these in one SQL script.  Remember to document your code.
For all the below queries, make sure to provide easily readable column names. 
 All numbers should be formatted as ‘##,###.##’.  Employee names should be returned 
 in one column as Last Name, First Name.  Remember that to_date = ‘9999-01-01’ indicates 
 the “current” record.  A graphic representation of the employees schema is available in 
 Blackboard.

These queries use the Employees database.
*/

# Write a query that returns all of the female employees currently making less than 50,000 in 
# the Customer Service department.  Columns should include name, salary, and salary effective 
# date (mm/dd/yyyy).

select 
     concat (employees.first_name, ' ', employees.last_name) as 'Name',
     format(salaries.salary, 2) as 'Employee Salary',
     date_format(salaries.from_date, '%m/%d/%Y') as 'Effective Date',
     if(gender='M','Male','Female') as 'Gender',
     dept_name as 'Department'
     from employees join salaries on employees.emp_no = salaries.emp_no
     join dept_emp on employees.emp_no = dept_emp.emp_no
     join departments on departments.dept_no = dept_emp.dept_no
     where departments.dept_name = 'Customer Service'
     and employees.gender = 'F'
     and salaries.salary < 50000
     and salaries.to_date = '9999-01-01'
     and dept_emp.to_date = '9999-01-01'
     order by employees.last_name;
	
# Write a query to return the maximum current salary in each department.  
# Columns should include department name and salary.

select departments.dept_name as 'Department', 
     format(max(salary),2) as 'Maximum Current Salary'
     from dept_emp join salaries on dept_emp.emp_no = salaries.emp_no
     join departments on departments.dept_no = dept_emp.dept_no
     where dept_emp.to_date = '9999-01-01'
     and salaries.to_date = '9999-01-01'
     group by dept_name
     order by dept_name;

# Write a query that shows the current head count in each department.  
# The only columns should be department name and the head count. 

select departments.dept_name as 'Department',
    format(count(dept_emp.dept_no),2) as 'Current Head Count'
    from dept_emp join departments on dept_emp.dept_no = departments.dept_no
    where dept_emp.to_date = '9999-01-01'
    group by dept_name
    order by dept_name;


# Write a query that shows the current average salary in each department.  
# Sort in Descending order by average salary.  Include the department and the average salary.    

select departments.dept_name as 'Department', 
     format(avg(salaries.salary),2) as 'Average Salary'
     from dept_emp join salaries on dept_emp.emp_no = salaries.emp_no
     join departments on departments.dept_no = dept_emp.dept_no
     where dept_emp.to_date = '9999-01-01'
     and salaries.to_date = '9999-01-01'
     group by dept_name
     order by avg(salaries.salary) desc;
    
# This query uses the Classic Models database
# Find the total dollar amount ordered per customer for all customers.  
# Display the customer name and the total dollar amount ordered.  Order by total amount in 
# descending order. 

# Not done per e-mail.
