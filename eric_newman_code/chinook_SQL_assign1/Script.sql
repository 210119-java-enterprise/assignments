--Revature Associate SQL Workbook

--PostGreSQL

--Working with Relational Database Management Systems

--Part I – Working with an existing database

--test calls
select * FROM "Customer" c ;


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
update "Customer" set "FirstName" = 'Robert', "LastName" = 'Walter' where "FirstName" = 'Aaron' and "LastName" = 'Mitchell';
--Task – Update name of artist “Creedence Clearwater Revival” to “CCR”
update "Artist" set "Name" = 'CCR' where "Name" = 'Creedence Clearwater Revival';
--2.5 LIKE
--Task – Select all invoices with a billing address like “T”
select * from "Invoice" where "BillingAddress" like 'T%';
--2.6 BETWEEN
--Task – Select all invoices that have a total between 15 and 50
select * from "Invoice" where "Total" >= 15 and "Total" <= 50;
--Task – Select all employees hired between 1st of June 2003 and 1st of March 2004
select * from "Employee" where "HireDate" >= '2003-06-01 00:00:00' and "HireDate" <= '2004-03-01 00:00:00';
--2.7 DELETE
--Task – Delete a record in Customer table where the name is Robert Walter (There may be constraints that rely on this, find out how to resolve them).
-- alter table "Customer" delete constraints 
alter table "Invoice" drop constraint "FK_InvoiceCustomerId";
ALTER TABLE "Invoice" ADD CONSTRAINT "FK_InvoiceCustomerId" FOREIGN KEY ("CustomerId") REFERENCES "Customer"("CustomerId") on delete cascade;
alter table "InvoiceLine" drop constraint "FK_InvoiceLineInvoiceId";
ALTER TABLE "Invoice" ADD CONSTRAINT "FK_InvoiceLineInvoiceId" FOREIGN KEY ("CustomerId") REFERENCES "Customer"("CustomerId") on delete cascade;

delete from "Customer" where "FirstName" = 'Robert' and "LastName" = 'Walter';
--3.0 SQL Functions
--In this section you will be using the PostGreSQL system functions, as well as your own functions, to perform various actions against the database
--3.1 System Defined Functions
--Task – Create a function that returns the current time.
create or replace function curTime()
returns time
as $$
begin 
    return current_time;
end
$$ language plpgsql;
select curTime();
--Task – create a function that returns the length of a mediatype from the mediatype table
--drop function mediaLen();
create or replace function mediaLen()
returns table (media_name varchar, media_len int)
as $$
begin 
   	return query 
		select "Name", length("Name") as "Media Length" from "MediaType";
end
$$ language plpgsql;

select * from mediaLen();
--3.2 System Defined Aggregate Functions
--Task –Create a function that returns the average total of all invoices
--drop function avgInvoice();

create or replace function avgInvoice()
returns table (average numeric)
as $$
begin 
   	return query 
		select avg("Total") as "Avg all invoices" from "Invoice";
end
$$ language plpgsql;

select avgInvoice();
--Task – Create a function that returns the most expensive track
--drop function expTrack();

create or replace function expTrack()
returns table (TrackName varchar, UnitPrice numeric)
as $$
begin 
   	return query 
		select "Name" , "UnitPrice" from "Track" where "UnitPrice" = (select max("UnitPrice") from "Track");
end
$$ language plpgsql;

select * from expTrack();


--3.3 User Defined Scalar Functions
--Task – Create a function that returns the average price of invoice-line items in the invoice-line table
--select * from "InvoiceLine";
--select avg("UnitPrice") as "Average Price" from "InvoiceLine";
--drop function getAvg();
create or replace function getAvg()
returns numeric
as $$
	declare 
		average numeric;
	begin
		select avg("UnitPrice")
		into average 
		from "InvoiceLine";
		return average;
	end
$$ 
language plpgsql;
select getAvg() as "average price";
--3.4 User Defined Table Valued Functions
--Task – Create a function that returns all employees who are born after 1968.
--select * from "Employee";
--drop function getYoung();
create or replace function getYoung()
returns setof "Employee"
as $$
	begin
		return query
			select * 
			from "Employee" where "BirthDate" >= '1968-01-01 00:00:00'; 
	end
$$ language plpgsql;
select getYoung();
--5.0 JOINS
--In this section you will be working with combining various tables through the use of joins. You will work with outer, inner, right, left, cross, and self joins.
--5.1 INNER
--Task – Create an inner join that joins customers and orders and specifies the name of the customer and the invoiceId.
select * from "Customer";
select * from "Invoice";

select cus."FirstName", cus."LastName", ord."InvoiceId"
from "Customer" cus -- finds the table identifier before resolving the select clause! 
join "Invoice" ord -- keyword inner is always implied if nothing specified
on cus."CustomerId" = ord."CustomerId";
--5.2 OUTER
--Task – Create an outer join that joins the customer and invoice table, specifying the CustomerId, firstname, last name, invoiceId, and total.
SELECT Cus."CustomerId", Cus."FirstName", Cus."LastName", inv."InvoiceId", inv."Total"
FROM "Customer" cus
FULL OUTER JOIN "Invoice" inv ON Cus."CustomerId" = inv."CustomerId";
--5.3 RIGHT
--Task – Create a right join that joins album and artist specifying artist name and title
select art."Name", alb."Title"
from "Artist" art
right join "Album" alb
on art."ArtistId" = alb."ArtistId";
--5.4 CROSS
--Task – Create a cross join that joins album and artist and sorts by artist name in ascending order
select *
from "Album"
cross join "Artist" art
order by art."Name" asc;
--5.5 SELF
--Task – Perform a self-join on the employee table, joining on the reports to column.
SELECT *
FROM "Employee" e1, "Employee" e2
where e1."ReportsTo" = e2."ReportsTo"
order by e1."ReportsTo";

select e1."FirstName", e1."LastName", e1."Title", e2."FirstName", e2."LastName", e2."Title" 
from "Employee" e1
join "Employee" e2
on e1."ReportsTo" = e2."EmployeeId"; 

