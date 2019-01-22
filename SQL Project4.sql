# SQL Project #4. - Michael Atwell

# 1.	Create view is a DDL command (True or False).

# True

# 2.	A view is a permanent structure of a schema until dropped (True or False).

# True

# 3.	A view stores data (True or False).

# False

# For the queries below, you can use any method you prefer to arrive at the answer, outer joins, 
# subqueries, views, etc. unless otherwise specified. Remember to format your output in a readable fashion.

# 4.	Find the total dollar amount ordered per customer for all customers.  Display the customer name 
# and the total dollar amount ordered.  Order by total amount in descending order. 

select customers.CustomerName as 'Customer Name',
       format(ifnull(sum(orderdetails.quantityOrdered * orderdetails.priceEach),0),2) as 'Total Orders'
       from customers left join orders on customers.customerNumber = orders.customerNumber
       left join orderdetails on orders.orderNumber = orderdetails.orderNumber
       group by customers.customerNumber
       order by sum(orderdetails.quantityOrdered * orderdetails.priceEach) desc;

# 5.	What employees report directly to the to the VP Sales?  List their name and their job title.  
# (Hint: you’ll need to alias tables to avoid ambiguity)
       
select concat (employees.firstName, ' ', employees.lastName) as 'Employee'
       from employees 
	   where employees.reportsTo = 
         (select employeeNumber 
	         from employees
			 where employees.jobTitle = 'VP Sales')
	   order by employees.lastName;       

# 6.	Assuming a sales commission of 5% on every order, calculate the sales commission due for all employees.  
# List the employee name and the sales commission they’re due.

select concat (employees.firstName, ' ', employees.lastName) as 'Employee',
       format(ifnull(sum(0.05 * orderdetails.quantityOrdered * orderdetails.priceEach),0),2) as 'Sales Commissions'
       from employees left join customers on employees.employeeNumber = customers.salesRepEmployeeNumber
       left join orders on customers.customerNumber = orders.customerNumber
       left join orderdetails on orders.orderNumber = orderdetails.orderNumber
       group by employees.employeeNumber
       order by employees.lastName;

# 7.	Create a list of customers and the amount they currently owe us.  List the customer name and 
# the amount due.  Create views to track the total amount ordered and the total amount paid.  
# Use these views to create your final query.  Important – do not format interim numeric results.  
# If you need to round numbers use the round function.  Don’t format your numbers until your final query.  
# Having imbedded commas in numeric fields can cause math problems.

create or replace view Total_Price_Per_Customer as
     select orders.customerNumber,
            sum(quantityOrdered * priceEach) as 'Total_Price'
     from orderdetails left join orders on orderdetails.orderNumber = orders.orderNumber
     group by orders.customerNumber;
     
create or replace view Total_Paid_Per_Customer as
     select customerNumber,
            sum(amount) as 'Total_Paid'
	 from payments
     group by customerNumber;
     
select customers.customerName as 'Customer',
     format((ifnull((Total_Price - Total_Paid),0)),2) as 'Amount Owed'
     from customers left join Total_Price_Per_Customer on customers.customerNumber = Total_Price_Per_Customer.customerNumber
     left join Total_Paid_Per_Customer on Total_Price_Per_Customer.customerNumber = Total_Paid_Per_Customer.customerNumber
     group by customers.customerNumber
     order by customerName;
     

             


