/* Script file for the first assignment*/
--There are a few queries that I sued to make sure updates went through, may not delete them all

/*Problem 2.1*/
/*Task – Select all records from the Employee table.*/
select *
from "Employee" e;

/*Task – Select all records from the Employee table where last name is King.*/
select *
from "Employee" e 
where "LastName" = 'King';

/*Task – Select all records from the Employee table where first name is Andrew and REPORTSTO is NULL.*/
select *
from "Employee" e 
where "FirstName" = 'Andrew' and "ReportsTo" = null;

/*Problem 2.2*/
/*Task – Select all albums in album table and sort result set in descending order*/
select *
from "Album" a
order by "Title" desc;

/*Task – Select first name from Customer and sort result set in ascending order*/
select "FirstName"
from "Customer" c 
order by "FirstName" asc;

/*Problem 2.3*/
/*Task – Insert two new records into Genre table*/
INSERT INTO "Genre" ("GenreId", "Name") VALUES (26, N'Deathcore');
delete from "Genre" where "Name" = 'Deathcore';
INSERT INTO "Genre" ("GenreId", "Name") VALUES (27, N'Aliencore');
delete from "Genre" where "Name" = 'Aliencore';

/*Task – Insert two new records into Employee table*/
INSERT INTO "Employee" ("EmployeeId", "LastName", "FirstName") VALUES (9, N'Barber', N'Tom');
--delete from "Employee" where "LastName" = 'Barber' and "FirstName" = 'Tom';
INSERT INTO "Employee" ("EmployeeId", "LastName", "FirstName") VALUES (10, N'Warren', N'Adam');
--delete from "Employee" where "LastName" = 'Warren' and "FirstName" = 'Adam';

/*Task – Insert two new records into Customer table*/
INSERT INTO "Customer" ("CustomerId", "FirstName", "LastName", "Email") VALUES (60, N'Bob', N'Green', N'luisg@embraer.com.br');
--delete from "Customer" where "FirstName" = 'Bob' and "LastName" = 'Green';
INSERT INTO "Customer" ("CustomerId", "FirstName", "LastName", "Email") VALUES (61, N'Bib', N'Blue', N'luisg@embraer.com.br');
--delete from "Customer" where "FirstName" = 'Bib' and "LastName" = 'Blue';

/*Problem 2.4*/

/*Task – Update Aaron Mitchell in Customer table to Robert Walter*/
update "Customer"
set "FirstName" = 'Robert', "LastName" = 'Walter'
where "FirstName" = 'Aaron' and "LastName" = 'Mitchell';

--select *
--from "Customer" c
--where "FirstName" = 'Robert' and "LastName" = 'Walter';

/*Task – Update name of artist “Creedence Clearwater Revival” to “CCR”*/
update "Artist"
set "Name" = 'CCR'
where "Name" = 'Creedence Clearwater Revival';
--select *
--from "Artist" a 
--where "Name" = 'CCR';

/*Problem 2.5*/

/*Task – Select all invoices with a billing address like “T”*/
select *
from "Invoice" i 
where "BillingAddress" like 'T%';

/*Problem 2.6*/

/*Task – Select all invoices that have a total between 15 and 50*/
select *
from "Invoice" i 
where "Total" between 15 and 50;

/*Task – Select all employees hired between 1st of June 2003 and 1st of March 2004*/
select *
from "Employee" e 
where "HireDate" between '2003/6/1' and '2004/3/1'

/*Problem 2.7*/

/*Task – Delete a record in Customer table where the name is Robert Walter */
--NEED TO DO

alter table "Invoice" drop constraint "FK_InvoiceCustomerId",
					add constraint "FK_InvoiceCustomerId" foreign key ("CustomerId") references "Customer" ("CustomerId") on delete cascade;

alter table "InvoiceLine" drop constraint "FK_InvoiceLineInvoiceId",
	add constraint "FK_InvoiceLineInvoiceId" foreign key ("InvoiceId") references "Invoice" ("InvoiceId") on delete cascade;

delete from "Customer"
where "FirstName" = 'Robert' and "LastName" = 'Walter';

--Readd Aaron Mitchell and change his name again
--INSERT INTO "Customer" ("CustomerId","FirstName","LastName","Company","Address","City","State","Country","PostalCode","Phone","Fax","Email","SupportRepId") values (32,'Aaron','Mitchell',NULL,'696 Osborne Street','Winnipeg','MB','Canada','R3L 2B9','+1 (204) 452-6452',NULL,'aaronmitchell@yahoo.ca',4);
--update "Customer"
--set "FirstName" = 'Robert', "LastName" = 'Walter'
--where "FirstName" = 'Aaron' and "LastName" = 'Mitchell';
--
--select *
--from "Customer" c
--where c."FirstName" = 'Robert' and c."LastName" = 'Walter';


/*Problem 3.1*/

/*Task – Create a function that returns the current time.*/
create or replace function time_current()
returns text
as
$$
	begin 
		return current_time;
	end
$$
language plpgsql;

select time_current();

/*Task – create a function that returns the length of a mediatype from the mediatype table*/
create or replace function length_of_mediatype()
returns table (media_length int)
as
$$
	begin 
		return query
			select length("Name")
			from "MediaType";
	end
$$
language plpgsql;

select length_of_mediatype();

/*Problem 3.2*/

/*Task –Create a function that returns the average total of all invoices*/
create or replace function average_invoice()
returns numeric
as 
$$
	declare 
		avg_result numeric;
	begin 
		select AVG("Total")
		into avg_result
		from "Invoice" i;
	
		return avg_result;
	end
$$
language plpgsql;

select average_invoice();

/*Task – Create a function that returns the most expensive track*/
create or replace function most_expensive_track()
returns numeric
as
$$
	declare
		max_result numeric;
	begin
		
		select MAX("UnitPrice")
		into max_result
		from "Track" t;
	
		return max_result;
	end
$$
language plpgsql;

select most_expensive_track();

/*Problem 3.3*/

/*Task – Create a function that returns the average price of invoice-line items in the invoice-line table*/

create or replace function average_invoice_unit_price ()
	returns numeric
	language plpgsql
	as
	$$
	declare
		average numeric;
	begin
		select avg("UnitPrice")
		into average
		from "InvoiceLine";
	
		return average;
	end;
	$$;

select public.average_invoice_unit_price(); 

/*Problem 3.4*/

/*Task – Create a function that returns all employees who are born after 1968.*/
create or replace function emp_born_after_1968()
returns setof "Employee"
as
$$
	begin
		return query
			select *
			from "Employee" e
			where e."BirthDate" > '12/31/1968';
	end
$$
language plpgsql;

select emp_born_after_1968();

/*Problem 5.1*/

/*Task – Create an inner join that joins customers and orders and specifies the name of the customer and the invoiceId.*/
select c."FirstName", c."LastName", i."InvoiceId"
from "Customer" c
join "Invoice" i
on c."CustomerId" = i."CustomerId"
order by c."FirstName" asc;

/*Problem 5.2*/

/*Task – Create an outer join that joins the customer and invoice table, specifying the CustomerId, firstname, last name, invoiceId, and total.*/
select c."CustomerId", c."FirstName", c."LastName", i."InvoiceId", i."Total"
from "Customer" c
full outer join "Invoice" i
on c."CustomerId" = i."CustomerId"
order by c."CustomerId" asc;

/*Problem 5.3*/

/*Task – Create a right join that joins album and artist specifying artist name and title*/
select art."Name", alb."Title"
from "Artist" art
right join "Album" alb
on art."ArtistId" = alb."ArtistId"
order by art."Name" asc;

/*Problem 5.4*/

/*Task – Create a cross join that joins album and artist and sorts by artist name in ascending order.*/
--reread the problem
select *
from "Album" alb
cross join "Artist" art
where alb."ArtistId" = art."ArtistId"
order by art."Name" asc;

/*Problem 5.5*/

/*Task – Perform a self-join on the employee table, joining on the reports to column.*/
select e1."FirstName", e1."LastName", e1."Title", e2."FirstName", e2."LastName", e2."Title"
from "Employee" e1
join "Employee" e2
on e1."ReportsTo" = e2."EmployeeId";

