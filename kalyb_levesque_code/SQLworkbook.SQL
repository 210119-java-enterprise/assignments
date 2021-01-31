-- 2.1 Select

--select all records from Employee
select * from "Employee";

-- select all records from Employee where the last name is King
select * from "Employee" where "LastName" = 'King';

-- Select all records from the Employee table where first name is Andrew and REPORTSTO is NULL.
select * from "Employee" where "FirstName" = 'Andrew' and "ReportsTo" is null;

-- 2.2 Order By

-- Select all albums in album table and sort result set in descending order
select * from "Album" order by "AlbumId" desc;

-- Select first name from customer and sort result set in ascending order
select "FirstName" from "Customer" order by "FirstName" asc;

-- 2.3 Insert Into

-- insert two new records into Genre table
insert into "Genre" values(26,'insertValue1'), (27,'isertValue2');

-- insert two new records into Employee table

insert into "Employee" 
values(9,'value1','inserted','IT Staff',1,'1998-04-02' ,CURRENT_TIMESTAMP,'123 madeUpLane','Calgary', 'AB', 'Canada', 'T2k 1N0','+1 (403) 000-0000','+1 (403) 111-1111','dummy1@chinookcorp.com'),
(10,'value2','inserted','IT Staff',1,'1998-04-02' ,CURRENT_TIMESTAMP,'1234 madeUpLane','Calgary', 'AB', 'Canada', 'T3k 2N1','+1 (403) 111-0000','+1 (403) 222-1111','dummy2@chinookcorp.com');


-- insert two new records into Customer table
insert into "Customer" 
values(60,'insert1','value1',null,'123 madeUpLane','New York','New York','UnitedStates','12345','+1(123)456-7890',null,'dummy@dum.com',1),
(61,'insert2','value2',null,'1234 madeUpLane', 'Plano', 'Texas', 'United States','7654321','+1(123)456-7890',null,'dummy@dum.com',1);

-- 2.4 update

-- update Aaron Mitchell in Customer table to Robert Walter
update "Customer" 
set "FirstName" = 'Robert', "LastName" = 'Walter'
where "FirstName" = 'Aaron' and "LastName" = 'Mitchell';

-- update name of artist "Creedence Clearwater Revival" to "CCr"
update "Artist" 
set "Name" = 'CCR'
where "Name" = 'Creedence Clearwater Revival';

-- 2.5 Like

-- select all invoices with a billing address like "T"
select * from "Invoice" where "BillingAddress" like '%T%';

--2.6 between

-- Select all invoices that have a total between 15 and 50
select * from "Invoice" where "Total" between 15 and 50;

-- Select all employees hired betweeen 1st of june 2003 and 1st of March 2004
select * from "Employee" where "HireDate" between '2003-06-01' and '2004-03-01';

--2.7 Delete

--Delete a record in Customer table where the name is Robert Walter 
-- (There may be constraints that rely on this, find out how to resolve them)

alter table "Invoice" drop constraint "FK_InvoiceCustomerId";   -- get rid of the old constraint
ALTER TABLE "Invoice" ADD CONSTRAINT "FK_InvoiceCustomerId" FOREIGN KEY ("CustomerId")  -- remake it with delete cascade so deleting automatically goes across multiple tables
REFERENCES "Customer"("CustomerId") on delete cascade;

delete from "Customer" where "FirstName" = 'Robert' and "LastName" = 'Walter';
--select "FirstName" from "Customer" where "FirstName" = 'Robert' and "LastName" = 'Walter';

--3.0 SQL Functions

--3.1 System Defined Functions

-- Create a function that returns the current time.
--drop function CUR_TIME();
create or replace function CUR_TIME()
returns time

as $$

begin 
	return current_time;
end

$$
 			language plpgsql;
select CUR_TIME();

-- create a function that returns the length of a mediatype from the mediatype table

--drop function MEDIA_TYPE_LENGTH();
create or replace function MEDIA_TYPE_LENGTH()
returns setof int 
as $$
	
begin 
	return QUERY 
			select length("Name") from "MediaType";
end

$$

		language plpgsql;
select MEDIA_TYPE_LENGTH();

--3.2 System Defined Aggregate Functions

--Task –Create a function that returns the average total of all invoices
create or replace function AVERAGE_NUM()
returns numeric 
as $$
begin
	return avg("Total") from "Invoice";
end
$$
 			language plpgsql;

select AVERAGE_NUM();


--Task – Create a function that returns the most expensive track
create or replace function EXPENSIVE_TRACK()
returns numeric
as $$
begin 

	return max("UnitPrice") from "Track"; 
end
$$
 			language plpgsql;
select EXPENSIVE_TRACK();


--3.3 User Defined Scalar Functions

--Task – Create a function that returns the average price of invoice-line items in the invoice-line table
create or replace function AVG_PRICE()
returns numeric 
as $$
begin 
	return avg("UnitPrice") from "InvoiceLine";
end
$$
 			language plpgsql;
select AVG_PRICE();

--3.4 User Defined Table Valued Functions

--Task – Create a function that returns all employees who are born after 1968.
--drop function BORN_AFTER_1968();

create or replace function BORN_AFTER_1968()
returns setof "Employee"  
as $$
begin 
	
	return 
	query 
	select * from "Employee" where "BirthDate" > '1985-12-31';
end
$$
 			language plpgsql;
select BORN_AFTER_1968();

--5.0 JOINS


--5.1 INNER

--Task – Create an inner join that joins customers and orders and specifies the name of the customer and the invoiceId.
select "FirstName","LastName", "InvoiceId"
from "Customer" cust inner join "Invoice" inv
on cust."CustomerId" = inv."CustomerId";

--5.2 OUTER

--Task – Create an outer join that joins the customer and invoice table, specifying the CustomerId, firstname, last name, invoiceId, and total.
select c."CustomerId", "FirstName", "LastName", i."InvoiceId", "Total" 
from "Customer" c full outer join "Invoice" i on c."CustomerId" = i."CustomerId";

--5.3 RIGHT

--Task – Create a right join that joins album and artist specifying artist name and title.
select "Name", "Title"
from "Artist" a2 right join "Album" a3 
on a2."ArtistId" = a3."ArtistId";

--5.4 CROSS

--Task – Create a cross join that joins album and artist and sorts by artist name in ascending order.
select *
from "Album" a2 cross join "Artist" a3 
order by a3."Name" asc;


--5.5 SELF

--Task – Perform a self-join on the employee table, joining on the reports to column.
select *
from "Employee" e 
inner join "Employee" e2 on e."ReportsTo" = e2."EmployeeId" ;



