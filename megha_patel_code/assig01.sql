
-- SQL ASSIGNMENT

--2.1 
-- Select all records from the Employee table.
select * from "Employee" ;

-- Select all records from the Employee table where last name is King.
select * from "Employee" where "LastName" = 'King' ;

--  Select all records from the Employee table where first name is Andrew and REPORTSTO is NULL.
select * from "Employee" where "FirstName" = 'Andrew' and "ReportsTo" is NULL ;

--2.2
--Select all albums in album table and sort result set in descending order
select * from "Album" order by "AlbumId" desc;

--Select first name from Customer and sort result set in ascending order
select "FirstName" from "Customer" order by "FirstName" asc; 

--2.3
-- Insert two new records into Genre table
insert into "Genre" values (26, 'abc');
insert into "Genre" values (27,'xyz');

-- Insert two new records into Employee table
insert into "Employee" values (13, 'Priya', 'Patel', 'General Manager', 3,'1958/12/8', '2002/5/1', '11 Malvern Ave NW', 'Trenton', 'NJ', 'USA', '09557', '+1 (780) 428-5682', '+1 (780) 528-3987', 'priya@chinookcorp.com');
insert into "Employee" values (14, 'Ali', 'Azar', 'IT Staff', 2,' 1996/4/26',  ' 2000/2/04 ', '101 Bloomfield Ave', 'Scranton', 'PA', 'USA', '09547', '+1 (870) 438-9682', '+1 (721) 569-3987', 'ali@chinookcorp.com');

--Insert two new records into Customer table
insert into "Customer" values (19, 'Marc', 'Harris', 'Google Inc.', '1623 Amphitheatre Parkway', 'Mountain View', 'CA', 'USA', '94123-1351', '+1 (620) 243-4500', '+1 (650) 353-0000', 'marc@google.com', 4);
insert into "Customer" values (64, 'Mac', 'Awez', 'Tesla', 'Oak Tree Road', 'Edison', 'NJ', 'USA', '46685-1351', '+1 (620) 764-4500', '+1 (235) 353-0000', 'awez@google.com', 1);

--2.4 UPDATE
-- Update Aaron Mitchell in Customer table to Robert Walter
update "Customer" set "FirstName"= 'Robert', "LastName" = 'Walter' where "FirstName"= 'Aaron' and "LastName" = 'Mitchell';

--Update name of artist “Creedence Clearwater Revival” to “CCR”
update "Artist" set "Name"= 'CCR' where "Name" = 'Creedence Clearwater Revival';

-- 2.5 LIKE
--Select all invoices with a billing address like “T”
select * from "Invoice"  where "BillingAddress" like 'T%';

--2.6 BETWEEN
-- Select all invoices that have a total between 15 and 50
select * from "Invoice" where "Total" between 15 and 50;

-- Select all employees hired between 1st of June 2003 and 1st of March 2004
select * from "Employee" where "HireDate" between '2003/6/1' and '2004/3/1';

--2.7
-- Delete a record in Customer table where the name is Robert Walter 
 
-- delete from "Customer" where "FirstName" ='Robert' and "LastName" = 'Walter';

alter table "Invoice"
drop constraint "FK_InvoiceCustomerId";

alter table "Invoice"
add constraint "FK_InvoiceCustomerId"
FOREIGN KEY ("CustomerId") REFERENCES "Customer" ("CustomerId") ON DELETE cascade;

alter table "InvoiceLine"
drop constraint "FK_InvoiceLineInvoiceId";

alter table "InvoiceLine"
add constraint "FK_InvoiceLineInvoiceId"
FOREIGN KEY ("InvoiceId") REFERENCES "Invoice" ("InvoiceId") ON delete cascade;

delete from "Customer" where "FirstName" ='Robert' and "LastName" = 'Walter';


--3.0
--3.1
--Create a function that returns the current time.	
create or replace function get_time()
returns text
as '
	begin
		return current_time;
	end
'language plpgsql;

select get_time(); 


-- create a function that returns the length of a mediatype from the mediatype table
create or replace function getlength(x int)
returns int
as '
	declare
		length int;
	begin
		select length("Name") 
		into length
		from "MediaType"
		where "MediaTypeId" = x;
		return length;
	end
'language plpgsql;


select getlength(1); 

--3.2
--Create a function that returns the average total of all invoices
create or replace function averagetotal()
returns numeric
as '
		declare
			average numeric;
		begin
			select avg("Total")
			into average
			from "Invoice";
			return average; 
		end

'language plpgsql;

select averagetotal() ;


--Create a function that returns the most expensive track
create or replace function mostexpensive()
returns text 
as
'
	declare
		exp text;
	begin
		select "Name" from "Track" into exp
		where "UnitPrice" = ( select max("UnitPrice") from "Track");
		return exp;

	end
'language plpgsql;
 
select mostexpensive();


--3.3
-- Create a function that returns the average price of invoice-line items in the invoice-line table
create or replace function averageprice()
returns numeric 
as 
'
	begin
		 return (select avg("UnitPrice") from "InvoiceLine");
	end

'language plpgsql;

select averageprice();


--3.4
-- Create a function that returns all employees who are born after 1968.

create or replace function born()
returns setof "Employee" as $$
begin
    return query (select * from "Employee" where "BirthDate" > '1968-12-31');
end;
$$ language plpgsql;

select born();


--5.0

--5.1 Create an inner join that joins customers and orders and specifies the name of the customer and the invoiceId.
select "FirstName", "LastName", "InvoiceId" 
 from "Customer" c inner join "Invoice" i on c."CustomerId" = i."InvoiceId";

--5.2 Create an outer join that joins the customer and invoice table, specifying the CustomerId, firstname, last name, invoiceId, and total.
select "FirstName", "LastName", "InvoiceId", "Total"
from "Customer" c  full outer join "Invoice" i on c."CustomerId" = i."InvoiceId";

--5.3 Create a right join that joins album and artist specifying artist name and title.
select "Name", "Title" 
from "Album" a right join "Artist" ar on ar."ArtistId" = a."ArtistId" ;

--5.4 Create a cross join that joins album and artist and sorts by artist name in ascending order.
select "Name" as name, "Title" as title from "Artist" a cross join "Album" ar where ar."ArtistId" = a."ArtistId" order by "Name";

--5.5 Perform a self-join on the employee table, joining on the reports to column.
select a."EmployeeId" as id, a."FirstName" as firstname, a."LastName" as lastname, a."Title", b."LastName" as "ReportsTo" from "Employee" a, "Employee" b where a."ReportsTo" = b."EmployeeId";

