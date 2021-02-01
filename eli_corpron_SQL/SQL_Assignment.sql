-- Author: Eli Corpron
-- SQL Workbook

-- 2.1 Select
-- Task: Select all records from the Employee table
select * from "Employee";

-- Task – Select all records from the Employee table where last name is King.
select * from "Employee"
where "LastName"='King';

-- Task – Select all records from the Employee table where first name is Andrew and REPORTSTO is NULL.
select * from "Employee"
where "FirstName" = 'Andrew' and "ReportsTo" is null;

-- 2.2 ORDER BY
-- Task – Select all albums in album table and sort result set in descending order
select * from "Album"
order by "Title" desc;

-- Task – Select first name from Customer and sort result set in ascending order
select "FirstName" from "Customer"
order by "FirstName" asc;

-- 2.3 INSERT INTO
-- Task – Insert two new records into Genre table
insert into "Genre"
values
	(26, 'Action'),
	(27, 'Adventure');

-- Task – Insert two new records into Employee table
insert into "Employee"
values
	(9, 'Corpron', 'Eli', 'IT Staff', 6, '1962/4/26', '2002/8/20', '123 test street road SW', 'Portland', 'OR', 'United States', '99999', '+1 (503) 555-5555', '+1 (503) 999-9999', 'eli.corpron@revature.net');
	(10, 'Test', 'Person', 'New Position', 6, '1966/4/26', '2005/8/20', '123 test street ave NW', 'Salem', 'OR', 'United States', '88888', '+1 (503) 111-1111', '+1 (503) 888-8888', 'test.email@domain.com');

-- Task – Insert two new records into Customer table
insert into "Customer"
values
	(60, 'New', 'Person', null, null, 'Portland', 'OR', 'US', 98888, null, null, 3),
	(61, 'Test', 'Customer', null, null, 'Salem', 'OR', 'US', 99999, null, null, 5);

--  2.4 UPDATE
-- Task – Update Aaron Mitchell in Customer table to Robert Walter
update "Customer"
set "FirstName" = 'Robert', "LastName" = 'Walter'
where "FirstName" = 'Aaron' and "LastName" = 'Mitchell';

-- Task – Update name of artist “Creedence Clearwater Revival” to “CCR”
update "Artist"
set "Name" = 'CCR'
where "Name" = 'Creedence Clearwater Revival';

-- 2.5 LIKE
-- Task – Select all invoices with a billing address like “T”
select *
from "Invoice" i
where "BillingAddress" like 'T%';

-- 2.6 BETWEEN
-- Task – Select all invoices that have a total between 15 and 50
select *
from "Invoice"
where "Total" > 15 and "Total" < 50;

-- Task – Select all employees hired between 1st of June 2003 and 1st of March 2004
select *
from "Employee"
where "HireDate" > '2003-06-01' and "HireDate" < '2004-03-01';

-- 2.7 DELETE
-- Task – Delete a record in Customer table where the name is Robert Walter (There may be constraints that rely on this, find out how to resolve them).
alter table "Invoice" 
drop constraint "FK_InvoiceCustomerId";

alter table "Invoice"
add constraint "FK_InvoiceCustomerId"
	foreign key ("CustomerId")
	references "Customer" ("CustomerId") 
	on delete cascade;

alter table "InvoiceLine" 
drop constraint "FK_InvoiceLineInvoiceId";

alter table "InvoiceLine"
add constraint "FK_InvoiceLineInvoiceId"
	foreign key ("InvoiceId")
	references "Invoice" ("InvoiceId")
	on delete cascade;

delete from "Customer"
where "FirstName" = 'Robert' and "LastName" = 'Walter';

-- 3.0 SQL Functions
-- In this section you will be using the PostGreSQL system functions, as well as your own functions, to perform various actions against the database
-- 3.1 System Defined Functions

-- Task – Create a function that returns the current time.
create or replace function currentTime()
returns time
as $$
	begin
		return current_time;
	end;
$$ language plpgsql;

select currentTime()

-- Task – create a function that returns the length of a mediatype from the mediatype table
create or replace function get_mediatype_length(media numeric)
returns numeric
as $$
	declare
		mediatype text;
	begin 
		select "Name"
		into mediatype
		from "MediaType"
		where "MediaTypeId" = media;
		
		return length(mediatype);
	end;
$$ language plpgsql;

select get_mediatype_length(5);

-- 3.2 System Defined Aggregate Functions
-- Task – Create a function that returns the average total of all invoices
create or replace function average_invoice()
returns numeric 
as $$
	declare 
		ave numeric;
	
	begin 
		select avg("Total")
		into ave
		from "Invoice";
		
		return ave;
	end;
$$ language plpgsql;

select average_invoice();

-- Task – Create a function that returns the most expensive track
create or replace function most_expensive_track()
returns text
as $$
	declare
		most_expensive numeric;
		track_name text;
		result text;
	
	begin
		select max("UnitPrice")
		into most_expensive
		from "Track";
	
		select "Name"
		into track_name
		from "Track"
		where "UnitPrice" = most_expensive;
	
		result := most_expensive || ' - ' || track_name;
	
		return result;
	end;
$$ language plpgsql;

select most_expensive_track();

-- 3.3 User Defined Scalar Functions
-- Task – Create a function that returns the average price of invoice-line items in the invoice-line table
create or replace function ave_invoice_price()
returns numeric
as $$
	declare 
		ave numeric;
	begin
		select avg("UnitPrice")
		into ave
		from "InvoiceLine";
		
		return ave;
	end;
$$ language plpgsql;

select ave_invoice_price();

-- 3.4 User Defined Table Valued Functions
-- Task – Create a function that returns all employees who are born after 1968.
drop function employees_after_1968();

create or replace function employees_after_1968()
returns table (employees int)
as $$
	begin
		return query
			select "EmployeeId"
			from "Employee"
			where "BirthDate" > '1968-12-31';
	end;
$$ language plpgsql;

select * from employees_after_1968();

-- OR if create or replace function employees_after_1968()
create or replace function employeeInfo_after_1968()
returns setof "Employee" 
as $$
	begin
		return query
			select *
			from "Employee"
			where "BirthDate" > '1968-12-31';
	end;
$$ language plpgsql;

select * from employeeInfo_after_1968();

-- 5.0 JOINS
-- In this section you will be working with combining various tables through the use of joins. You will work with outer, inner, right, left, cross, and self joins.

-- 5.1 INNER
-- Task – Create an inner join that joins customers and orders and specifies the name of the customer and the invoiceId.
select cust."FirstName", cust."LastName", inv."InvoiceId"
from "Customer" cust
inner join "Invoice" inv
on cust."CustomerId" = inv."CustomerId" ;

-- 5.2 OUTER
-- Task – Create an outer join that joins the customer and invoice table, specifying the CustomerId, firstname, last name, invoiceId, and total.
select cust."CustomerId", cust."FirstName", cust."LastName", inv."InvoiceId", inv."Total"
from "Customer" cust
full outer join "Invoice" inv
on cust."CustomerId" = inv."CustomerId";

-- 5.3 RIGHT
-- Task – Create a right join that joins album and artist specifying artist name and title.
select art."Name" as artistName, alb."Title" as AlbumTitle
from "Album" alb
right join "Artist" art
on alb."ArtistId" = art."ArtistId";

-- 5.4 CROSS
-- Task – Create a cross join that joins album and artist and sorts by artist name in ascending order.
select *
from "Album" alb
cross join "Artist" art
order by art."Name" asc;

-- 5.5 SELF
-- Task – Perform a self-join on the employee table, joining on the reports to column.
select *
from "Employee" e1
join "Employee" e2
on e1."ReportsTo" = e2."ReportsTo";
