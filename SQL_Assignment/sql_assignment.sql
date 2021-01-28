-- SECTION 2.0 SQL QUERIES
-- 2.1 SELECT

-- TASK: Select all records from Employees table
select * 
from "Employee"

-- TASK: Select all from Employees table where last name is King
select *
from "Employee"
where "LastName" = 'King'

-- TASK: Select all from Employees table where first name is Andrew and ReportsTo is null
select *
from "Employee"
where "FirstName" = 'Andrew' and "ReportsTo" is null

-- 2.2 ORDER BY

-- TASK: Select all albums in album table and sort result set in descending order
select * 
from "Album"
order by "AlbumId" desc  

-- TASK: Select first name from Customer and sort result set in ascending order
select "FirstName"
from "Customer"
order by "FirstName" asc

-- 2.3 INSERT INTO

-- TASK: Insert two new records into Genre table
insert into "Genre"
values (26,'Googe Rock'),(27,'Googe Jazz')

-- TASK: Insert two new records into Employee table
insert into "Employee" 
values (9,'Googe','Alex','Full Stack Java Developer',6,timestamp '1996-08-13 00:00:00',CURRENT_TIMESTAMP,'1234 New Road SE','Marietta','GA','United States','30060','+1 (123) 456-7890','+1 (234) 567-8901','alex@chinookcorp.com'),
(10,'Employee', 'New','SQL Employee',1,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,'1234 Test Road SW','Kennesaw','GA','United States','30060','+1 (111) 111-1111','+1 (222) 222-2222','sql@chinookcorp.com')

-- TASK: Insert two new records into Customer table
insert into "Customer"
values (60,'Googe','Ray','Googes Inc','90 New Street','Sometown','GA','United States','31539','+1 (321) 654-0987',null,'ray.googe@googes.com',3),
(61,'Googe','Lynne','Happiness Forever','91 New Street','Sometown','GA','Unites States','31539','+1 (321) 654-7980',null,'happiness@forever.com',3)

-- 2.4 UPDATE

-- TASK: Update Aaron Mitchell in Customer table to Robert Walter
update "Customer" 
set "FirstName" = 'Robert', "LastName" = 'Walter'
where "FirstName" = 'Aaron' and "LastName" = 'Mitchell'

-- TASK: Update name of artist “Creedence Clearwater Revival” to “CCR”
update "Artist" 
set "Name" = 'CCR'
where "Name" = 'Creedence Clearwater Revival'

-- 2.5 LIKE

-- TASK: Select all invoices with a billing address like “T”
select *
from "Invoice"
where "BillingAddress" like 'T%'

-- 2.6 BETWEEN

-- TASK: Select all invoices that have a total between 15 and 50
select *
from "Invoice"
where "Total" between 15 and 50 

-- TASK: Select all employees hired between 1st of June 2003 and 1st of March 2004
select *
from "Employee"
where "HireDate" between '2003-06-01' and '2004-03-01'

-- 2.7 DELETE

-- TASK: Delete a record in Customer table where the name is Robert Walter (There may be constraints that rely on this, find out how to resolve them).

-- Alters the invoice table to drop the current foreign key: invoicecustomerid
alter table "Invoice"
drop constraint "FK_InvoiceCustomerId";

-- Alters the table to add a new foreign key constraint with a delete cascade for the customerid
alter table "Invoice"
add constraint "FK_InvoiceCustomerId"
foreign key ("CustomerId") 
references "Customer" ("CustomerId") on delete cascade;

-- Alters the invoiceline table to drop the current foreign key
alter table "InvoiceLine" 
drop constraint "FK_InvoiceLineInvoiceId";

-- Alters the invoiceline table to add a new constraint for the foreign key with a delete cascade
alter table "InvoiceLine"
add constraint "FK_InvoiceLineInvoiceId"
foreign key ("InvoiceId") 
references "Invoice" ("InvoiceId") on delete cascade;

-- Delete a customer with the correct first / last name, which should then use the cascading deletes from foreign keys
-- on the invoice and invoiceline tables to correctly delete all records pertaining to that record in the customer table
delete 
from "Customer"
where "FirstName" = 'Robert' and "LastName" = 'Walter';


-- 3.0 SQL Functions
-- 3.1 System Defined Functions

-- TASK: Create a function that returns the current time
create function get_current_time()
returns text
as '
	begin
		return current_time;
	end
'
language plpgsql;

select currentTime();


-- TASK: Create a function that returns the length of a mediatype from the mediatype table.
create or replace function media_length(idinput int)
returns int as '
	begin
		return (select length("Name")
				from "MediaType"
				where "MediaTypeId" = idinput);
	end
'
language plpgsql;

select media_length(1);

-- 3.2 System Defined Aggregate Functions

-- TASK: Create a function that returns the average total of all invoices
create or replace function get_avg()
returns numeric 
as $$
	
	begin 
		return avg("Total")
		from "Invoice";
	end
$$ language plpgsql;

select get_avg();

-- TASK: Create a function that returns the most expensive track
create or replace function get_most_expensive()
returns text
as $$
	begin
		return (select "Name"
		from "Track"
		where "UnitPrice" = (select max("UnitPrice") from "Track") limit 1);
	end
$$ language plpgsql;

select get_most_expensive();

-- 3.3 User Defined Scalar Functions

-- TASK: Create a function that returns the average price of invoice-line items in the invoice-line table
create or replace function get_average_line_item()
returns numeric
as $$
	begin 
		return (select avg("UnitPrice") from "InvoiceLine");
	end
$$ language plpgsql;

select get_average_line_item();

-- 3.4 User Defined Table Valued Functions

-- TASK: Create a function that returns all employees who are born after 1968.
create or replace function born_after_68()
returns setof "Employee"
as $$
	begin 
		return query (select *
				from "Employee"
				where "BirthDate" > '1968-12-31');
	end
$$ language plpgsql;

select born_after_68();

-- 5.0 JOINS
-- 5.1 INNER

-- TASK: Create an inner join that joins customers and orders and specifies the name of the customer and invoiceId
select "FirstName", "LastName", "InvoiceId"
from "Customer" c
inner join "Invoice" i
on c."CustomerId" = i."CustomerId";

-- 5.2 OUTER

-- TASK: Create an outer join that joins the customer and invoice table, specifying the CustomerId, firstname, last name, invoiceId, and total
select c."CustomerId", "FirstName", "LastName", "InvoiceId", "Total"
from "Customer" c
full outer join "Invoice" i
on c."CustomerId" = i."CustomerId";


-- 5.3 RIGHT

-- TASK: Create a right join that joins album and artist specifying artist name and title
select "Name" as "Artist Name", "Title" as "Album Title"
from "Album" alb
right join "Artist" art
on alb."ArtistId" = art."ArtistId"; 

-- 5.4 CROSS

-- TASK: Create a cross join that joins album and artist and sorts by artist name in ascending order
select art."Name" as "Artist Name", alb."Title" as "Album Title"
from "Album" alb
cross join "Artist" art
where art."ArtistId" = alb."ArtistId"
order by art."Name"; 


-- 5.5 SELF

-- TASK: Perform a self-join on the employee table, join on the reports to column
select e1."FirstName", e1."LastName", e1."Title", 
e2."FirstName" as "Supervisor FirstName", e2."LastName" as "Supervisor LastName", e2."Title" as "Supervisor Title"
from "Employee" e1
join "Employee" e2
on e1."ReportsTo" = e2."EmployeeId";

