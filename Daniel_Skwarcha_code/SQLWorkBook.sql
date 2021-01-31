--2.1 SELECT
	-- Task – Select all records from the Employee table. 
select *
from "Employee" ;

	-- Task – Select all records from the Employee table where last name is King.
select *
from "Employee" e 
where "LastName"  = 'King'

	-- Task – Select all records from the Employee table where first name is Andrew and REPORTSTO is NULL.
select *
from "Employee" e 
where "FirstName" = 'Andrew' and "ReportsTo" is null 

-- 2.2 ORDER BY
	-- Task – Select all albums in album table and sort result set in descending order
select *
from "Album" a 
order by "AlbumId" desc 

	-- Task – Select first name from Customer and sort result set in ascending order
select "FirstName"
from "Customer" c 
order by "FirstName" asc

-- 2.3 INSERT INTO
	-- Task – Insert two new records into Genre table
insert into chinook.public."Genre"("GenreId","Name")
values(26, 'NewName1'),
(27, 'NewName2')

	-- Task – Insert two new records into Employee table
insert into chinook.public."Employee"
values(9, 'LastName1', 'FirstName1', 'IT Staff', 6, '1990-06-22 11:10:25', '2011-09-02 13:00:00', '111 FakeAddress Drive', 'FakeCity', 'TX', 'USA', '79594', '+1 (454) 565-6789', '+1 (780) 438-4455', 'fakeEmail@chinookcorp.com'),
(10, 'LastName2', 'FirstName2', 'IT Staff', 6, '1980-03-02 11:10:25', '2010-07-01 12:00:00', '222 FakeAddress Drive', 'FakeCity', 'TX', 'USA', '79594', '+1 (454) 232-4567', '+1 (780) 498-1122', 'myFakeEmail2@chinookcorp.com')

	-- Task – Insert two new records into Customer table
insert into chinook.public."Customer"
values(60, 'LastNameCustomer', 'FirstNameCustomer', null, '44 Chatham Street', 'Dublin', 'Dublin', 'Ireland', null, '+353 01 679333', null, 'FakeCustomerEmail@gmail.com', 3),
(61, 'LastNameCustomer2','FirstNameCustomer2', null, '25 Lupus St', 'London', null, 'United Kingdom', 'SW1V 3EN', '+44 020 7976 4211', null, 'FakeCustomerEmail2@gmail.com', 5)

-- 2.4 UPDATE
	-- Task – Update Aaron Mitchell in Customer table to Robert Walter
update "Customer" 
set  "FirstName"  = 'Robert', "LastName"  = 'Walter'
where "FirstName" = 'Aaron' and "LastName"  = 'Mitchell'

	-- Task – Update name of artist “Creedence Clearwater Revival” to “CCR”
update "Artist" 
set "Name" = 'CCR'
where "Name"  = 'Creedence Clearwater Revival'

-- 2.5 LIKE
	-- Task – Select all invoices with a billing address like “T”
select *
from "Invoice" i 
where "BillingAddress" like '%T%'

-- 2.6 BETWEEN
	-- Task – Select all invoices that have a total between 15 and 50
select *
from "Invoice" i2 
where "Total" between 15 and 50

	-- Task – Select all employees hired between 1st of June 2003 and 1st of March 2004
select *
from "Employee" e 
where "HireDate" between '2003-08-01 00:00:00' and '2004-03-01 00:00:00' 

-- 2.7 DELETE
--	Task – Delete a record in Customer table where the name is Robert Walter (There may be constraints that rely on this, find out how to resolve them).
alter table "Invoice" 
drop constraint "FK_InvoiceCustomerId";
alter table "Invoice"
add constraint FK_InvoiceCustomerId
foreign key ("CustomerId") references "Customer" ("CustomerId") on delete cascade;
alter table "InvoiceLine"
drop constraint "FK_InvoiceLineInvoiceId";
alter table "InvoiceLine"
add constraint "FK_InvoiceLineInvoiceId"
foreign key ("InvoiceId") references "Invoice" ("InvoiceId") on delete cascade;

delete from "Customer" 
where "FirstName" = 'Robert' and "LastName" = 'Walter'

-- 3.1 SQL Functions
	-- Task – Create a function that returns the current time.
create or replace function currenttime() 
returns time with time zone
as $$
	declare 
		currenttimereturn time with time zone;
	begin
		select current_time
		into currenttimereturn;
	
		return currenttimereturn;	
	end
$$ language plpgsql;

select currenttime()
	
	-- Task – create a function that returns the length of a mediatype from the mediatype table
create or replace function mediatypelength(id numeric) 
returns numeric
as $$
	declare
		medialength numeric;
	begin
		select length("Name")
		into medialength
		from "MediaType"
		where id = "MediaTypeId";
		
		return medialength;
	end
$$ language plpgsql;

select mediatypelength(1)


-- 3.2 System Defined Aggregate Functions
	-- Task –Create a function that returns the average total of all invoices
create or replace function averagetotalinvoices() 
returns numeric
as $$
	declare
		averageInvoice numeric;
	begin
		select avg("Total") 
		into averageInvoice
		from "Invoice" i;
		
		return averageInvoice;	
	end
$$ language plpgsql

select averagetotalinvoices()

	-- Task – Create a function that returns the most expensive track
create or replace function returnmostexpensivetrack()
returns table(TrackId int4, Name varchar(200), AlbumId int4, MediaTypeId int4, GenreId int4, Composer varchar(220), Milliseconds int4, Bytes int4, UnitPrice numeric(10,2))
as $$
	begin
		return Query
			select "TrackId", "Name", "AlbumId", "MediaTypeId", "GenreId", "Composer", "Milliseconds", "Bytes", "UnitPrice" 
			from "Track"
			where "UnitPrice" >= 
								(
									select max("UnitPrice")
									from "Track"
								);	
	end
$$ language plpgsql

select returnmostexpensivetrack()

-- 3.3 User Defined Scalar Functions
	
	-- Task – Create a function that returns the average price of invoice-line items in the invoice-line table
create or replace function averagepriceInvoiceLineItems()
returns numeric(7,5)
as $$
	declare 
	averageInvoiceLineItemPrice numeric(7,5);
	begin
			select avg("UnitPrice")
			into averageInvoiceLineItemPrice
			from "InvoiceLine" il;
			
			return averageInvoiceLineItemPrice;
	end
$$ language plpgsql

select averagepriceInvoiceLineItems()


-- 3.4 User Defined Table Valued Functions

	-- Task – Create a function that returns all employees who are born after 1968.
create or replace function employeesbornafter1968()
returns table(FirstName varchar(20), LastName varchar(20))
as $$
	begin
		return Query
		select "FirstName", "LastName"
		from "Employee"
		where "BirthDate" > '1968-12-31 23:59:59';
	end 
$$ language plpgsql

select employeesbornafter1968()
	
-- 5.1 INNER

	-- Task – Create an inner join that joins customers and orders and specifies the name of the customer and the invoiceId.
	select C."FirstName", C."LastName", I."InvoiceId"
	from "Customer" C
	inner join "Invoice" I
	on C."CustomerId" = I."CustomerId"; 
	
-- 5.2 OUTER

	-- Task – Create an outer join that joins the customer and invoice table, specifying the CustomerId, firstname, last name, invoiceId, and total.
	select C."CustomerId", C."FirstName", C."LastName", I."InvoiceId", I."Total"
	from "Customer" C
	full outer join "Invoice" I
	on C."CustomerId" = I."CustomerId";

-- 5.3 RIGHT

	-- Task – Create a right join that joins album and artist specifying artist name and title.
	select ar."Name", aL."Title"
	from "Artist" ar
	right join "Album" aL
	on ar."ArtistId" = aL."ArtistId";

-- 5.4 CROSS

	-- Task – Create a cross join that joins album and artist and sorts by artist name in ascending order.
	select *
	from "Artist" a
	cross join "Album" a2
	order by a."Name" asc;

-- 5.5 SELF

	-- Task – Perform a self-join on the employee table, joining on the reports to column.
	select *
	from "Employee" e, "Employee" e2 
	where e."ReportsTo" = e."ReportsTo"
	



