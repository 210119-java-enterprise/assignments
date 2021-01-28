-- 2.0 SQL Queries

-- 2.1 Select
-- Select all from Employee table
select * from "Employee";
-- Select all from Employee table where last name is King
select * from "Employee" e where "LastName" = 'King';
-- Select all records from the Employee table where first name is Andrew and REPORTSTO is NULL
select * from "Employee" e where ("FirstName" = 'Andrew') AND "ReportsTo" isnull; 

-- 2.2 Order by
-- Select all albums in album table and sort result set in descending order
select * from "Album" a order by "AlbumId" desc;
-- Select first name from Customer and sort result set in ascending order
select "FirstName" from "Customer" c order by "FirstName";

-- 2.3 Insert into
-- Insert two new records into Genre table
insert into "Genre" values 
(26, 'Lofi'),
(27, 'Gaming');
select * from "Genre";

-- Insert two new records into Employee table
insert into "Employee" values
(9, 'Gamble', 'Nathan'),
(10, 'Jonzz', 'Jonn');
select * from "Employee";

-- Insert two new records into Customer table
insert into "Customer" ("CustomerId", "LastName", "FirstName", "Email")
values
(60, 'Kenobi', 'General', 'hellothere@gmail.com'),
(61, 'Grevious', 'General', 'kenobi1@gmail.com');
select * from "Customer";

-- 2.4 Update
-- Update Aaron Mitchell in Customer table to Robert Walter
update "Customer"
set "FirstName" = 'Robert', "LastName" = 'Walter'
where "FirstName" = 'Aaron' and "LastName" = 'Mitchell';
select * from "Customer";

-- Update name of artist “Creedence Clearwater Revival” to “CCR”
update "Artist" 
set "Name" = 'CCR'
where "Name" = 'Creedence Clearwater Revival';
select * from "Artist";

-- 2.5 Like
-- Select all invoices with a billing address like “T”
select * from "Invoice" i where "BillingAddress" like 'T%';


-- 2.6 Between
-- Select all invoices that have a total between 15 and 50
select * from "Invoice" i where "Total" between 15 and 50;

-- Select all employees hired between 1st of June 2003 and 1st of March 2004
select * from "Employee" e where "HireDate" between timestamp '2003-06-01 00:00' and timestamp '2004-03-01 00:00';

-- 2.7 Delete
-- Delete a record in Customer table where the name is Robert Walter
alter table "Invoice" 
drop constraint "FK_InvoiceCustomerId",
add constraint "FK_InvoiceCustomerId"
foreign key ("CustomerId") references "Customer" ("CustomerId") on delete cascade;
alter table "InvoiceLine" 
drop constraint "FK_InvoiceLineInvoiceId",
add constraint "FK_InvoiceLineInvoiceId"
foreign key ("InvoiceId") references "Invoice" ("InvoiceId") on delete cascade;
delete from "Customer" where "FirstName" = 'Robert' and "LastName" = 'Walter';

--------------------------------------
-- 3.1 System defined functions
-- Create a function that returns the current time.
create or replace function currentTime()
	returns time
	language plpgsql
	as
$$
declare
begin
	return current_time;
end;
$$;
select currentTime();

-- create a function that returns the length of a mediatype from the mediatype table
--select * from "MediaType" mt ;
create or replace function mediatype_length(id int)
	returns int
	language plpgsql
	as
$$
declare
	mt_string varchar;
begin
	select "Name"
	into mt_string
	from "MediaType"
	where "MediaTypeId" = id;
	return char_length(mt_string);
end;
$$;
select mediatype_length(1);

-- 3.2 System defined aggregate functions
-- Create a function that returns the average total of all invoices
create or replace function avg_invoice_total()
	returns float
	language plpgsql
	as
$$
declare
	res float;
begin
	select avg("Total")
	into res
	from "Invoice";
	return res;
end;
$$;
select avg_invoice_total();

-- Create a function that returns the most expensive track
create or replace function max_track()
	returns "Track"
	language plpgsql
	as
$$
declare
	t "Track";
begin
	select *
	into t
	from "Track"
	where "UnitPrice" = (
		select max("UnitPrice")
		from "Track"
	);
	return t;
end;
$$;
select max_track();

-- 3.3 User defined scalar function
-- Create a function that returns the average price of invoice-line items in the invoice-line table
create or replace function avg_price()
	returns numeric
	language plpgsql
	as
$$
declare
	res numeric;
begin
	select avg("UnitPrice")
	from "InvoiceLine"
	into res;
	return res;
end;
$$;
select avg_price();

-- 3.4 User Defined Table Valued Functions
-- Create a function that returns all employees who are born after 1968.
create or replace function old_employees()
	returns refcursor
	language plpgsql
	as
$$
declare
	res refcursor := 'my_cursor'; -- gives refcursor a name to refer to later
begin
	open res for 
	select * from "Employee"
	where "BirthDate" >= '1969-01-01 00:00';
	return res;
end;
$$;

-- Need to be in a "transaction" to access the refcursor
begin;
select old_employees();
fetch all from my_cursor;
end;



--------------------------
-- 5.1 Inner join
-- Create an inner join that joins customers and orders and specifies the name of the customer and the invoiceId
select c."FirstName", c."LastName", i."InvoiceId" from "Customer" c
join "Invoice" i
using ("CustomerId");

-- 5.2 Outer join
-- Create an outer join that joins the customer and invoice table, specifying the CustomerId, firstname, last name, invoiceId, and total.
select c."CustomerId", c."FirstName", c."LastName", i."InvoiceId", i."Total"
from "Customer" c
full outer join "Invoice" i
using ("CustomerId");

-- 5.3 Right join
-- Create a right join that joins album and artist specifying artist name and title.
select art."Name", alb."Title"
from "Album" alb
right outer join "Artist" art
using ("ArtistId");

-- 5.4 Cross join
-- Create a cross join that joins album and artist and sorts by artist name in ascending order
select * from "Album" alb
cross join "Artist" art
order by art."Name" ;

-- 5.5 Self join
-- Perform a self-join on the employee table, joining on the reports to column.
select e1.*, e2."FirstName" as manager_first_name, e2."LastName" as manager_last_name, e2."Title" as manager_title
from "Employee" e1
join "Employee" e2
on e1."ReportsTo" = e2."EmployeeId";



-- Tidying up
delete from "Genre" where "GenreId" > 25;
delete from "Employee" where "EmployeeId" > 8;
delete from "Customer" where "CustomerId" > 59;
--update "Customer"
--set "FirstName" = 'Aaron',  "LastName" = 'Mitchell'
--where "FirstName" = 'Robert' and "LastName" = 'Walter';
update "Artist" 
set "Name" = 'Creedence Clearwater Revival'
where "Name" = 'CCR';
INSERT INTO "Customer" ("CustomerId","FirstName","LastName","Company","Address","City","State","Country","PostalCode","Phone","Fax","Email","SupportRepId") VALUES
	 (32,'Aaron','Mitchell',NULL,'696 Osborne Street','Winnipeg','MB','Canada','R3L 2B9','+1 (204) 452-6452',NULL,'aaronmitchell@yahoo.ca',4);
INSERT INTO "Invoice" ("InvoiceId","CustomerId","InvoiceDate","BillingAddress","BillingCity","BillingState","BillingCountry","BillingPostalCode","Total") VALUES
	 (50,32,'2009-08-06 00:00:00.000','696 Osborne Street','Winnipeg','MB','Canada','R3L 2B9',1.98),
	 (61,32,'2009-09-16 00:00:00.000','696 Osborne Street','Winnipeg','MB','Canada','R3L 2B9',13.86),
	 (116,32,'2010-05-17 00:00:00.000','696 Osborne Street','Winnipeg','MB','Canada','R3L 2B9',8.91),
	 (245,32,'2011-12-22 00:00:00.000','696 Osborne Street','Winnipeg','MB','Canada','R3L 2B9',1.98),
	 (268,32,'2012-03-25 00:00:00.000','696 Osborne Street','Winnipeg','MB','Canada','R3L 2B9',3.96),
	 (290,32,'2012-06-27 00:00:00.000','696 Osborne Street','Winnipeg','MB','Canada','R3L 2B9',5.94),
	 (342,32,'2013-02-15 00:00:00.000','696 Osborne Street','Winnipeg','MB','Canada','R3L 2B9',0.99);
INSERT INTO "InvoiceLine" ("InvoiceLineId","InvoiceId","TrackId","UnitPrice","Quantity") VALUES
	 (267,50,1626,0.99,1),
	 (268,50,1628,0.99,1),
	 (326,61,1955,0.99,1),
	 (327,61,1964,0.99,1),
	 (328,61,1973,0.99,1),
	 (329,61,1982,0.99,1),
	 (330,61,1991,0.99,1),
	 (331,61,2000,0.99,1),
	 (332,61,2009,0.99,1),
	 (333,61,2018,0.99,1);
INSERT INTO "InvoiceLine" ("InvoiceLineId","InvoiceId","TrackId","UnitPrice","Quantity") VALUES
	 (334,61,2027,0.99,1),
	 (335,61,2036,0.99,1),
	 (336,61,2045,0.99,1),
	 (337,61,2054,0.99,1),
	 (338,61,2063,0.99,1),
	 (339,61,2072,0.99,1),
	 (621,116,251,0.99,1),
	 (622,116,257,0.99,1),
	 (623,116,263,0.99,1),
	 (624,116,269,0.99,1);
INSERT INTO "InvoiceLine" ("InvoiceLineId","InvoiceId","TrackId","UnitPrice","Quantity") VALUES
	 (625,116,275,0.99,1),
	 (626,116,281,0.99,1),
	 (627,116,287,0.99,1),
	 (628,116,293,0.99,1),
	 (629,116,299,0.99,1),
	 (1329,245,1113,0.99,1),
	 (1330,245,1114,0.99,1),
	 (1447,268,1816,0.99,1),
	 (1448,268,1818,0.99,1),
	 (1449,268,1820,0.99,1);
INSERT INTO "InvoiceLine" ("InvoiceLineId","InvoiceId","TrackId","UnitPrice","Quantity") VALUES
	 (1450,268,1822,0.99,1),
	 (1565,290,2522,0.99,1),
	 (1566,290,2526,0.99,1),
	 (1567,290,2530,0.99,1),
	 (1568,290,2534,0.99,1),
	 (1569,290,2538,0.99,1),
	 (1570,290,2542,0.99,1),
	 (1860,342,857,0.99,1);
alter table "Invoice" 
drop constraint "FK_InvoiceCustomerId",
add constraint "FK_InvoiceCustomerId"
foreign key ("CustomerId") references "Customer" ("CustomerId");
alter table "InvoiceLine" 
drop constraint "FK_InvoiceLineInvoiceId",
add constraint "FK_InvoiceLineInvoiceId"
foreign key ("InvoiceId") references "Invoice" ("InvoiceId");