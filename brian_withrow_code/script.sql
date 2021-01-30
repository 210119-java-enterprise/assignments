-- 2.0 SQL Queries
-- 2.1 Select
-- Selects all records from Employee table
select *
from "Employee" e;

-- Selects all records from Employee table where last name is King
select *
from "Employee" e 
where "LastName" = 'King';

-- Selects all records from Employee table where first name is Andrew and REPORTSTO is NULL.
select *
from "Employee" e 
where "FirstName" = 'Andrew'
and "ReportsTo" is null;

-- 2.2 Order By
-- Select all albums in album table and sort result set in descending order
select "Title" 
from "Album" a 
order by "Title" desc   

-- Select first name from Customer and sort result in ascending order
select "FirstName"
from "Customer"
order by "FirstName" asc

-- 2.3 Insert Into
-- Insert two new records into Genre table
insert into "Genre" ("GenreId", "Name")
values ('26', 'Electric Swing'), ('27', 'New Age Funk');

-- Insert two new records into Employee table
insert into "Employee" ("EmployeeId", "LastName", "FirstName", "Title", "ReportsTo", "BirthDate", "HireDate", 
			"Address", "City", "State", "Country" , "PostalCode", "Phone", "Fax", "Email")
values ('9', 'Withrow', 'Brian', 'Cool Dude', '10', '1998-08-21 00:00:00', '2002-08-14 00:00:00', 
			'1717 Ashcomb Way', 'Estero','FL', 'USA', 'T5K 2N1', '+1 (780) 428-9482', '+1 (780) 428-9482', 'brian@chinookcorp.com'), 
		('10', 'Wezley', 'LastName', 'Cool Dude Instructor', '1', '1990-12-25 00:00:00', '2002-08-14 00:00:00', 
			'5555 Real Way', 'Place','RL', 'USA', 'T5K 2N1', '+1 (770) 428-9482', '+1 (770) 428-9482', 'wezley@chinookcorp.com');

-- Insert two new records into Customer table
insert into "Customer" ("CustomerId","FirstName" ,"LastName","Company","Address", 
			"City", "State", "Country", "PostalCode", "Phone", "Fax", "Email", "SupportRepId")
values ('60', 'Withrow', 'Brian', 'Revature', '1717 Ashcomb Way', 
		'Estero','FL', 'USA', 'T5K 2N1', '+1 (780) 428-9482', '+1 (780) 428-9482', 'brian@chinookcorp.com', '3'), 
		('61', 'Wezley', 'LastName', 'Revature', '5555 Real Way', 
		'Place','RL', 'USA', 'T5K 2N1', '+1 (770) 428-9482', '+1 (770) 428-9482', 'wezley@chinookcorp.com', '4');
	
-- 2.4 Update
-- Update Aaron Mitchell in Customer table to Robert Walter
update "Customer" 
set "FirstName" = 'Robert', "LastName" = 'Walter'
where "FirstName" = 'Aaron' and "LastName" = 'Mitchell';   
	
-- Update name of artist "Creedence Clearwater Revival" to "CCR"
update "Artist" 
set "Name" = 'CCR'
where "Name" = 'Creedence Clearwater Revival';   

-- 2.5 LIKE
-- Select all invoices with a billing address like "T"
select *
from "Invoice" 
where "BillingAddress" like 'T%';

--2.6 BETWEEN
-- Select all invoices that have a total between 15 and 50
select *
from "Invoice"
where "Total" between 15 and 50;

-- Select all employees hired between 1st of June 2003 and 1st of March 2004
select *
from "Employee"
where "HireDate" between '2003-06-01 00:00:00' and '2004-03-01 00:00:00';

-- 2.7 DELETE
-- Delete a record in Customer table where the name is Robert Walter (There may constraints that depend upon this, resolve them.)
-- To resolve the issue, the foreign keys are being re-added with the DELETE CASCADE option.
-- The delete cascade means that their parent being deleted will delete the entries that rely on it for a foreign key.
-- Invoice is a child table that relies on this foreign key
alter table "Invoice" 
drop constraint "FK_InvoiceCustomerId",
add constraint "FK_InvoiceCustomerId"
foreign key ("CustomerId") 
references "Customer" ("CustomerId") on delete cascade;

-- Invoice Line is also a table that relies on the CustomerID Foreign Key.
alter table "InvoiceLine" 
drop constraint "FK_InvoiceLineInvoiceId",
add constraint "FK_InvoiceLineInvoiceId"
foreign key ("InvoiceId") references "Invoice" ("InvoiceId") on delete cascade;

-- Deleting this entry will make those previous two foreign keys delete all entries tied to this entry.
delete from "Customer" where "FirstName" = 'Robert' and "LastName" = 'Walter';

-- 3.0 SQL Functions
-- 3.1 System Defined Functions
-- Create a function that returns the current time.
create or replace function get_time()
returns varchar 
as $$
	begin

		return current_time;
	end

$$ language plpgsql;

select get_time();

-- Create a function that returns the length of a mediatype from the mediatype table.
create or replace function media_length()
returns text 
as	$$
	declare
		mediatype text;
	begin

		select "Name" 
		into mediatype
		from "MediaType"
		where "MediaTypeId" = 1;
		return length(mediatype);
	end
$$ language plpgsql;

select media_length();

-- 3.2 System Defined Aggregate Functions
-- Create a function that returns the average total of all invoices
create or replace function avg_invoices()
returns numeric
as $$
	declare 
		aver numeric;
		cnt numeric;
		total_row numeric;
	begin 
		aver := 0;
		cnt := 0;
		
		for total_row in 
			select "Total"
			from "Invoice"
		loop
	 		aver := aver + total_row;
	 		cnt := cnt + 1; 
		end loop;
		
		aver := aver / cnt;
		return aver;
	end
$$ language plpgsql;

select avg_invoices();

-- Create a function that returns the most expensive track
create or replace function exp_track()
returns numeric
as $$
	declare 
		highest numeric(10,2);
		track_row numeric(10,2);
	begin 
		highest := 0;
		
		for track_row in 
			select "UnitPrice" 
			from "Track"
		loop
	 		if track_row > highest then
	 			highest := track_row;
	 		end if;
		end loop;
		
		return highest;
	end
$$ language plpgsql;

select exp_track();

--3.3 User Defined Scalar Functions
-- Create a function that returns the average price of invoice-line items in the invoice-line table.
create or replace function avg_invoice_line()
returns numeric
as $$
	declare 
		aver numeric(10,2);
		cnt numeric;
		total_row numeric(10,2);
	begin 
		aver := 0;
		cnt := 0;
		
		for total_row in 
			select "UnitPrice" 
			from "InvoiceLine"
		loop
	 		aver := aver + total_row;
	 		cnt := cnt + 1; 
		end loop;
		
		aver := aver / cnt;
		return aver;
	end
$$ language plpgsql;

select avg_invoice_line();

-- 3.4 User Defined Table Valued Functions
--create a function that returns all employees who are born after 1968
drop function get_emp_after_68();
create or replace function get_emp_after_68()
returns table (firstName varchar, lastName varchar, birthdate timestamp)
as $$
	begin 
		return query
			select "FirstName" , "LastName" , "BirthDate" 
			from "Employee"
			where "BirthDate" > '1968-12-31';
	end;
$$ language plpgsql;

select get_emp_after_68();

-- 5.0 Joins
-- 5.1 Inner
-- Create an inner join that joins customers and orders and specifies the name of the customer and the invoiceid
select c."FirstName" , c."LastName" , i."InvoiceId" 
from "Customer" c
inner join "Invoice" i
on i."CustomerId" = c."CustomerId";

-- 5.2 Outer
-- Create an outer join that joins the customer and invoice table, specifying the CustomerId, firstname, last name, invoiceId, and total.
select c."CustomerId" , c."FirstName" , c."LastName" , i."InvoiceId" , i."Total" 
from "Customer" c
full outer join "Invoice" i 
on i."CustomerId" = c."CustomerId" ;

-- 5.3 Right
-- Create a right join that joins album and artist specifying artist name and title.
SELECT a."Title" , a1."Name" 
FROM "Album" a
RIGHT JOIN "Artist" a1 
ON a."ArtistId" = a1."ArtistId";

-- 5.4 Cross
-- Create a cross join that joins album and artist and sorts by artist name in ascending order
select a1."Name" , a."Title" 
FROM "Artist" a1
CROSS JOIN "Album" a 
order by a1."Name" asc;

-- 5.5 Self
-- Perform a self join on the employee table, joining on the reports to column.
select e."FirstName" as worker, e2."FirstName" as boss
from "Employee" e , "Employee" e2 
where e."ReportsTo" = e2."EmployeeId";