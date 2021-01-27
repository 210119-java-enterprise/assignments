--Revature Associate SQL Workbook

--PostGreSQL

--Working with Relational Database Management Systems

--Part I – Working with an existing database

--Setting up Chinook
--In this section you will begin the process of working with the Chinook database
--Task – Set up the Chinook DB by executing the script found here
--2.0 SQL Queries In this section you will be performing various queries against the Oracle Chinook database.
--2.1 SELECT
--Task – Select all records from the Employee table. 

select * FROM "Employee" 

--Task – Select all records from the Employee table where last name is King.

select * FROM "Employee"
	where "LastName" = 'King';

--Task – Select all records from the Employee table where first name is Andrew and REPORTSTO is NULL.

select * FROM "Employee"
	where "FirstName" = 'Andrew' and "ReportsTo" is NULL;

--2.2 ORDER BY
--Task – Select all albums in album table and sort result set in descending order

select * FROM "Album"
	order by "AlbumId" desc; 

--Task – Select first name from Customer and sort result set in ascending order

select "FirstName" FROM "Customer" order by "FirstName" asc;

--2.3 INSERT INTO
--Task – Insert two new records into Genre table
insert into "Genre" ("GenreId", "Name") values ('27', 'testrock'), ('28', 'morerock');
--Task – Insert two new records into Employee table
insert into "Employee" ("EmployeeId","FirstName", "LastName") values ('11', 'jeff', 'newman'), ('10', 'ellen', 'newman');
--Task – Insert two new records into Customer table
insert into "Customer" ("CustomerId","FirstName", "LastName", "Email") values ('61', 'ellen', 'newman', 'ellenmail'), ('62', 'jeff', 'newman', 'jeffmail');
--2.4 UPDATE
--Task – Update Aaron Mitchell in Customer table to Robert Walter
--Task – Update name of artist “Creedence Clearwater Revival” to “CCR”
--2.5 LIKE
--Task – Select all invoices with a billing address like “T”
--2.6 BETWEEN
--Task – Select all invoices that have a total between 15 and 50
--Task – Select all employees hired between 1st of June 2003 and 1st of March 2004
--2.7 DELETE
--Task – Delete a record in Customer table where the name is Robert Walter (There may be constraints that rely on this, find out how to resolve them).


--3.0 SQL Functions
--In this section you will be using the PostGreSQL system functions, as well as your own functions, to perform various actions against the database
--3.1 System Defined Functions

--Task – Create a function that returns the current time.
--Task – create a function that returns the length of a mediatype from the mediatype table
--3.2 System Defined Aggregate Functions
--Task –Create a function that returns the average total of all invoices
--Task – Create a function that returns the most expensive track
--3.3 User Defined Scalar Functions
--Task – Create a function that returns the average price of invoice-line items in the invoice-line table
--3.4 User Defined Table Valued Functions
--Task – Create a function that returns all employees who are born after 1968.
--5.0 JOINS
--In this section you will be working with combining various tables through the use of joins. You will work with outer, inner, right, left, cross, and self joins.
--5.1 INNER
--Task – Create an inner join that joins customers and orders and specifies the name of the customer and the invoiceId.
--5.2 OUTER
--Task – Create an outer join that joins the customer and invoice table, specifying the CustomerId, firstname, last name, invoiceId, and total.
--5.3 RIGHT
--Task – Create a right join that joins album and artist specifying artist name and title.
--5.4 CROSS
--Task – Create a cross join that joins album and artist and sorts by artist name in ascending order.
--5.5 SELF
--Task – Perform a self-join on the employee table, joining on the reports to column.
