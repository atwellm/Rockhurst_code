# Homework 2- Atwell

# Create a table or tables to track employees and their contact information.  Normalize the tables to 3rd normal form.  Provide appropriate keys.

# Data elements necessary:
# Last Name, First Name, Middle Initial, prefix, suffix, gender

# Address information
# Address Line 1, Address Line 2, City, State, Zip
# There will be multiple addresses including work and home address.
# Phone information
# Area Code, 7 Digit Number, Extension
# There will be multiple addresses including work, cell, home, fax and potentially others.
# Email information
# email address.  There will be multiple, home, work, alternate, etc.
# Emergency Contact
# Name, relationship, Address Line 1, Address Line 2, City, State, Zip, Telephone #.

# If you split the above into multiple tables, please explain the relationships between the tables.

# Table 1: Employee_List
# Columns: ID_Number, Last_Name, First_Name, Middle_Initial, prefix, suffix, gender

create Table Employee_List (
     ID_Number Integer primary key, 
     Last_Name varchar(30), 
     First_Name varchar(30), 
     Middle_Initial varchar(1), 
     prefix varchar(4), 
     suffix varchar(4), 
     gender varchar(1)
);     

# Table 2: Employee_Address
# Columns: ID_Number_FK, Address_Type, Address_Line1, Address_Line2, City_FK, Zip_FK

create Table Employee_Address (
     ID_Number_FK Integer primary key, 
     Address_Type varchar(9), 
     Address_Line1 varchar(60), 
     Address_Line2 varchar(60), 
     City_FK varchar(40), 
     Zip_FK integer
);

# Table 3: Employee_Phone
# Columns: ID_Number_FK, Phone_Type, Area_Code, Phone_Number, Extension

create Table Employee_Phone (
     ID_Number_FK Integer primary key, 
     Phone_Type varchar(6), 
     Area_Code smallint, 
     Phone_Number varchar(8), 
     Extension smallint
);

# Table 4: Employee_Email
# Columns: ID_Number_FK, Email_Type, Email_Address

create Table Employee_Email (
     ID_Number_FK Integer primary key, 
     Email_Type varchar(8), 
     Email_Address varchar(80)
);

# Table 5: Emergency_Contact
# Columns: ID_Number_FK, EC_First_Name, EC_Last_Name, relationship, EC_Address_Line1, EC_Address_Line2, City_FK, Zip_FK, EC_Area_Code, EC_Number, EC_Extension
# Assumes only one address and phone number per emergency contact. 
# By breaking this out in a separate table, allows more than one emergency contact per employee.

create table Emergency_Contact (
     ID_Number_FK Integer primary key, 
     EC_First_Name varchar(30), 
     EC_Last_Name varchar(30), 
     relationship varchar(10), 
     EC_Address_Line1 varchar(60), 
     EC_Address_Line2 varchar(60), 
     City_FK varchar(40), 
     Zip_FK integer, 
     EC_Area_Code smallint, 
     EC_Number varchar(8), 
     EC_Extension smallint
);

# Table 6: City_State_ZIP
# Columns: City, State, ZIP

create Table City_State_ZIP (
     City varchar(40) primary key, 
     State varchar(2), 
     ZIP integer primary key
);

# Relationships: Tables 2-5 use the ID_Number in table 1 as a foreign key.  
# Additionally, since ZIP and city determine state, the employee and the ermergency contact's
# addresses use the city and state in Table 6 as a foreign key.

# Write queries to return the appropriate data.
# For the queries below, remember that a “current” record is defined as one having ‘9999-01-01’ in the to_date field.

# How many employees are older than 55?
 
select count(birth_date) as 'Employees Older Than 55' from employees 
     where timestampdiff(YEAR,birth_date,now()) > 55; 

# How many employees were hired in 1994?

select count(hire_date) as '1994 Hirees' from employees where year(hire_date) = 1994;

# How many employees were hired per year?  Columns should include the year and the number hired that year.

select year(hire_date) as 'Year', count(hire_date) as 'Hirees'
     from employees
     group by year(hire_date);
     