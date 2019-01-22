# Normalization Assignment 3 - Michael Atwell

/*

Narrative for the assignment:
You’ve been hired by the company IT Supply to create a database to track their orders.  

IT Supply is a United States company that does domestic work only, primarily in the Midwest . 
Sales staff is headquartered in Kansas City and several regional routes exist.  There are 6 different 
sales people. One VP for sales manages all territories.  Sales staff have the option of offering discounts 
on items ordered in large quantities (over 25,000).  This is fully at the discretion of the sales person 
but is subject to review by the VP for sales.  The maximum discount that can be offered is 10%.
Customers vary in size from mom & pop shops (very small) to large multi-location office supply chains.  
Databases ‘R Us for example has their HQ in Kansas, but locations in 15 different states that we ship 
directly to.  All billing goes to their Relational Kansas office.  
Multiple shipping methods are available with the most common being FOB shipping point where the customer 
pays the freight/delivery company directly.  Shipping can also be handled as FOB destination point where 
IT Supply manages the shipping. Invoices carry a 2% mark-up for FOB destination point.   
We use the USPS, UPS, and DHS for deliveries.

*/

/* Table Schema is per below.  

/* Table 1 - Customers

Customer ID (PK)
Customer Name
*/

create Table Customers (
     CustomerID Integer primary key,
	 CustomerName varchar(50)
);


/* Table 2 - Customer Billing Addresses

Customer ID FK (PK)
Customer Billing Address Number (PK)
Billing Street Address
Billing City
Billing State
Billing Zip
Billing Zip Plus 4

The addition of 'Customer Billing Address Number' allows more than one billing address per customer.

No provision was made for international addresses, since the problem statement said the company did domestic
work only.
*/

create Table CustomerBillingAddresses (
     CustomerID_FK Integer,
     CustomerBillingAddressNumber integer,
     BillingStreetAddress varchar(60),
     BillingCity varchar(40),
     BillingState char(2),
     BillingZip decimal(5,0),
     BillingZipPlus4 decimal(4,0),
primary key (CustomerID_FK, CustomerBillingAddressNumber),
foreign key (CustomerID_FK) references Customers(CustomerID)
);


/* Table 3 - Customer Phone

Customer ID FK (PK)
Customer Phone line item number (PK)
Customer Phone Description
Customer Phone Number
Customer Phone Extension

I gave phone description 50 characters below, so that a detailed entry such as 'Cleveland Office' could be used.

For phone number, I allowed 10 numbers, since the problem statement said only domestic customers, 
and domestic numbers are 10 digits long. 
*/

create Table CustomerPhone (
     CustomerID_FK integer,
     CustomerPhoneLineItemNumber integer,
     CustomerPhoneDescription varchar(50),
     CustomerPhoneNumber char(10),
     CustomerPhoneExtension varchar(10),
primary key (CustomerID_FK, CustomerPhoneLineItemNumber),
foreign key (CustomerID_FK) references Customers(CustomerID)
);

/* Table 4 - Employees

Employee ID (PK)
Employee LastName
Employee FirstName
Reports To
Regional Route Assignment
*/

create Table Employees (
     EmployeeID integer primary key,
     EmployeeLastName varchar(40),
     EmployeeFirstName varchar(40),
     ReportsTo integer,
     RegionalRouteAssignment varchar(40)
);

/* Table 5 - Shipping Addresses

Customer ID FK (PK)
Customer Shipping Site Number (PK)
Shipping Street Address
Shipping City
Shipping State
Shipping Zip
Shipping Zip Plus 4

Allows more than one shipping address per customer.  I didn't put the recipient's name here as there
could be multiple people or positions at the same receiving address. 

No provision was made for international addresses, since the problem statement said the company did domestic
work only.
*/

create Table ShippingAddresses (
     CustomerID_FK integer,
     CustomerShippingSiteNumber integer,
     ShippingStreetAddress varchar(60),
     ShippingCity varchar(40),
     ShippingState char(2),
     ShippingZip decimal(5,0),
     ShippingZipPlus4 decimal(4,0),
primary key (CustomerID_FK, CustomerShippingSiteNumber),     
foreign key (CustomerID_FK) references Customers(CustomerID)
);

/* Table 6 - Sale Details

Invoice Number (PK)
Sale Date
Employee ID FK
Customer ID FK
Customer Billing Address Number FK
Customer Shipping Site Number FK
Customer Phone Line Item Number FK 
Payment Due Date
Payment Terms

This table ties together all of the other tables we've seen so far.  The invoice is now linked to
which sales rep, which customer, which billing address for that customer, which shipping address for that 
customer, and which shipping phone for that customer.

One option not programmed in: the ability to ship or bill to multiple addresses within the same invoice.

*/

create table SaleDetails (
     InvoiceNumber integer primary key,
     SaleDate date,
     EmployeeID_FK integer,
     CustomerID_FK integer,
     CustomerBillingAddressNumber_FK integer,
     CustomerShippingSiteNumber_FK integer,
     CustomerPhoneLineItemNumber_FK integer,
     PaymentDueDate date,
     PaymentTerms varchar(40),
foreign key (EmployeeID_FK) references Employees(EmployeeID),
foreign key (CustomerID_FK) references Customers(CustomerID),
foreign key (CustomerID_FK, CustomerBillingAddressNumber_FK) references CustomerBillingAddresses(CustomerID_FK, CustomerBillingAddressNumber),
foreign key (CustomerID_FK, CustomerShippingSiteNumber_FK) references ShippingAddresses(CustomerID_FK, CustomerShippingSiteNumber),
foreign key (CustomerID_FK, CustomerPhoneLineItemNumber_FK) references CustomerPhone(CustomerID_FK, CustomerPhoneLineItemNumber)
);


/* Table 7 - Shipping Details

Invoice Number FK (PK)
Recipient Name
Shipping Method
Shipping Terms
Shipping Markup
Shipping Cost
Delivery Date

Shipping Markup is the extra cost for FOB destination point invoices.  You could conceivably leave this 
column out and program the interface (or select statement) to add the 2% premium if Shipping Terms has 
FOB Destination Point in it.  

Though the longest Shipping Method currently used is 4 characters long, I used 40 as the max length to 
allow for a new, longer shipper name if needed.

Again, no provision was made to ship to multiple addresses within the same invoice.
*/

create Table ShippingDetails (
     InvoiceNumber_FK integer primary key,
     RecipientName varchar(50),
     ShippingMethod varchar(40),
     ShippingTerms varchar(30),
     ShippingMarkup decimal(8,2),
     ShippingCost decimal(8,2),
     DeliveryDate date,
foreign key (InvoiceNumber_FK) references SaleDetails(InvoiceNumber)
);

/* Table 8 - Item List

Item Number (PK)
Item Description

*/

create Table ItemList (
     ItemNumber integer primary key,
	 ItemDescription varchar(50)
);


/* Table 9 - Item Prices

Item Number (PK)
Unit Price Start Date (PK)
Unit Price End Date
Unit Price

This table provides a record of what price was charged for each item on what dates.  I'm assuming that the
same price for a given item is charged for all customers, i.e. there's no tailored pricing for different 
customers going on.  The bulk discount mentioned in the problem statement is accounted for in a later table.

*/

create Table ItemPrices (
     ItemNumber_FK integer,
     UnitPriceStartDate date,
     UnitPriceEndDate date,
     UnitPrice decimal(8,2),
primary key (ItemNumber_FK, UnitPriceStartDate),     
foreign key (ItemNumber_FK) references ItemList(ItemNumber)
);

/* Table 10 - Order Items

Invoice Number FK (PK)
Invoice Line Item (PK)
Item Number FK
Quantity Ordered
Discount

I judged 'line total' and 'order total' to be unnecessary columns since these are merely the output of math 
done on other pieces of data. 

Discount is a decimal(2,2), so for instance a 10% discount would be .10.  A 'check' statement enforces the
'no greater than 10% discount' rule.  

I didn't put the unit price here as the interface (or select statement) would reference the sale date and 
the Item Prices table to get the unit price.

*/

create Table OrderItems (
     InvoiceNumber_FK integer,
     InvoiceLineItem integer,
     ItemNumber_FK integer,
     QuantityOrdered integer,
     Discount decimal(2,2),
check(Discount <= 0.1),
primary key (InvoiceNumber_FK, InvoiceLineItem),
foreign key (InvoiceNumber_FK) references SaleDetails(InvoiceNumber),
foreign key (ItemNumber_FK) references ItemList(ItemNumber)
);


