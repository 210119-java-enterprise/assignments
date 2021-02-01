						--2.1 select
						
--Task – Select all records from the Employee table. 
select * from "Employee";

--Task – Select all records from the Employee table where last name is King.
select * from "Employee"
where "LastName" = 'King';

--Task – Select all records from the Employee table where first name is Andrew and REPORTSTO is NULL.
select * from "Employee" 
where "FirstName" = 'Andrew' and "ReportsTo" is null; 


						--2.2 ORDER BY

--Task – Select all albums in album table and sort result set in descending order
select "Title" from "Album" 
order by "Title" desc; 

--Task – Select first name from Customer and sort result set in ascending order
select "FirstName" from "Customer"
order by "FirstName";


						--2.3 INSERT INTO

--Task – Insert two new records into Genre table
insert into "Genre" 
values ('26', 'Instrumental'),
	   ('27', 'Country');

--Task – Insert two new records into Employee table
insert into "Employee" 
values (
	'9',
    'Smith',
    'Adam',
    'IT Staff',
    '6',
    '1977-09-19 00:00:00',
    '2010-11-19 00:00:00',
    '113 Smith',
    'Charlotte',
    'North Carolina',
    'USA',
    '20289',
    '910-330-2342',
    '452-436-8642',
    'adam@chinook.com'
    ),
   (
	'10',
    'Jose',
    'Torres',
    'IT Staff',
    '6',
    '1979-02-11 00:00:00',
    '2010-10-01 00:00:00',
    '32423 Smith',
    'Charlotte',
    'North Carolina',
    'USA',
    '20289',
    '910-024-9782',
    '193-924-1624',
    'jose@chinook.com'
    );
--Task – Insert two new records into Customer table
insert into "Customer" (
	"CustomerId",
    "FirstName",
    "LastName",
    "Address",
    "City",
    "State",
    "Country",
    "PostalCode",
    "Phone",
    "Email",
    "SupportRepId"
)
values (
	'60',
    'Bob',
    'Joe',
    '535 Smith st',
    'Harrisburg',
    'North Carolina',
    'USA',
    '23982',
    '910-423-2328',
    'bob@gmail.com',
    '3'
),
(
	'61',
    'Jamie',
    'Cucoa',
    '923 Adams st',
    'Jacksonville',
    'North Carolina',
    'USA',
    '20923',
    '980-612-2328',
    'jamie@gmail.com',
    '3'
);


						--2.4 UPDATE

--Task – Update Aaron Mitchell in Customer table to Robert Walter
update "Customer" 
set "FirstName" = 'Robert', "LastName" = 'Walter'
where "CustomerId" = 32;

--Task – Update name of artist “Creedence Clearwater Revival” to “CCR”
update "Artist" 
set "Name" = 'CCR'
where "ArtistId" = 76;


						--2.5 LIKE

--Task – Select all invoices with a billing address like “T”
select * from "Invoice"
where "BillingAddress" like 'T%';


						--2.6 BETWEEN

--Task – Select all invoices that have a total between 15 and 50
select * from "Invoice"
where "Total" between 15 and 50;


--Task – Select all employees hired between 1st of June 2003 and 1st of March 2004
select * from "Employee"
where "HireDate" between '2003-06-01 00:00:00' and '2004-03-01 00:00:00';


						--2.7 DELETE

--Task – Delete a record in Customer table where the name is Robert Walter (There may be constraints that rely on this, find out how to resolve them).

alter table "Invoice" 
	drop constraint "FK_InvoiceCustomerId",
	add constraint "FK_InvoiceCustomerId"
		foreign key ("CustomerId") references "Customer" ("CustomerId") on delete cascade;

alter table "InvoiceLine" 
	drop constraint "FK_InvoiceLineInvoiceId",
	add constraint "FK_InvoiceLineInvoiceId"
		foreign key ("InvoiceId") references "Invoice" ("InvoiceId") on delete cascade;
	
delete from "Customer"
where "FirstName" = 'Robert' and "LastName" = 'Walter';

						--3.0 SQL Functions

--In this section you will be using the PostGreSQL system functions, as well as your own functions, to perform various actions against the database


						--3.1 System Defined Functions

--Task – Create a function that returns the current time.
create or replace function currTime()
returns time
as '
	begin 
	return now();
	end
' 
language plpgsql;

select currTime(); -- test currTime() function 

--Task – create a function that returns the length of a mediatype from the mediatype table
create or replace function mediaLength()
returns table (mName   varchar   
               , mLength   int)
as $$

	begin
		return query select "Name", length("Name")
		from "MediaType";
		
	end
	$$
language plpgsql;

select mediaLength();  -- test mediaLength() fuction 


						--3.2 System Defined Aggregate Functions

--Task –Create a function that returns the average total of all invoices
create or replace function avgInvoice()
returns numeric
as $$
	begin 
		return AVG ("Total")
		from "Invoice";	
	end
	$$
language plpgsql;

select avgInvoice(); --tests avgInvoice()

--Task – Create a function that returns the most expensive track
create or replace function maxInvoice()
returns numeric
as $$
	begin 
		return MAX ("Total")
		from "Invoice";	
	end
	$$
language plpgsql;

select maxInvoice(); --tests maxInvoice()


						--3.3 User Defined Scalar Functions

--Task – Create a function that returns the average price of invoice-line items in the invoice-line table
create or replace function avgInvoiceLine()
returns numeric
as $$
	begin 
		return AVG ("UnitPrice")
		from "InvoiceLine";	
	end
	$$
language plpgsql;

select avgInvoiceLine(); --tests avgInvoice()


						--3.4 User Defined Table Valued Functions

--Task – Create a function that returns all employees who are born after 1968.
create or replace function employeesBefore1968()
returns setof "Employee"
as $$
	begin 
		return query select *
		from "Employee"
		where "BirthDate" >= '1969-01-01 00:00:00';
	end
	$$
language plpgsql;

select employeesBefore1968();  -- test employeesBefore1968() function


						--5.0 JOINS
--In this section you will be working with combining various tables through the use of joins. You will work with outer, inner, right, left, cross, and self joins.


						--5.1 INNER

--Task – Create an inner join that joins customers and orders and specifies the name of the customer and the invoiceId.
select c."FirstName", c."LastName", i."CustomerId"
from "Customer" c 
inner join "Invoice" i on c."CustomerId" = i."CustomerId";


						--5.2 OUTER

--Task – Create an outer join that joins the customer and invoice table, specifying the CustomerId, firstname, last name, invoiceId, and total.
select c2."CustomerId", c2."FirstName", c2."LastName", i2."InvoiceId", i2."Total"
from "Customer" c2
left join "Invoice" i2 on c2."CustomerId" = i2."CustomerId"; 

						--5.3 RIGHT

--Task – Create a right join that joins album and artist specifying artist name and title.
select alb."Title", art."Name"
from "Album" alb
right join "Artist" art on alb."ArtistId" = art."ArtistId";

						--5.4 CROSS

--Task – Create a cross join that joins album and artist and sorts by artist name in ascending order.
select * 
from "Album"
cross join "Artist"
order by "Name";

						--5.5 SELF

--Task – Perform a self-join on the employee table, joining on the reports to column.
select E1."ReportsTo", E2."ReportsTo"
from "Employee" E1, "Employee" E2;


