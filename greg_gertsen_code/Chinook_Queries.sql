Greg Gertsen

--2.1 SELECT
--Task – Select all records from the Employee table.
select * from "Employee";

--Task – Select all records from the Employee table where last name is King.

select * from "Employee" where "LastName" = 'King';

--Task – Select all records from the Employee table where first name is Andrew and REPORTSTO is NULL.

select * from "Employee" where "FirstName" = 'Andrew' and "ReportsTo" is null ;

--2.2 ORDER BY
--Task – Select all albums in album table and sort result set in descending order 
select * from "Album" order by "AlbumId" desc;

--Task – Select first name from Customer and sort result set in ascending order
select "FirstName" from "Customer" order by  "FirstName"  asc;

--2.3 INSERT INTO
--Task – Insert two new records into Genre table
insert into "Genre" ("GenreId","Name") values 
	(26,'Whale Sounds'),
	(27, 'Cricket Sounds');

--Task – Insert two new records into Employee table

insert into "Employee" values 
	(9, 'Greg', 'Donno', 'Boss', 3,'1983/12/8', '2020/5/1', '3303 NW 199th', 'Vancouver', 'WA', 'USA', '98642', '+1 (360) 234-2343', '+1 (360) 345-2343', 'greg@gmail.com'),
	(10, 'Bill', 'Bar', 'Manager', 3,'1975/11/8', '2019/5/1', '3313 SW 200th', 'Portland', 'OR', 'USA', '98234', '+1 (360) 344-2334', '+1 (360) 334-2234', 'bill@gmail.com');


 
--Task – Insert two new records into Customer table
insert into "Customer" values (60,'Mike', 'Barker','534', 'Bourke Avenue','Hobart', 'NSW', 'Australia','2011','+61 (02) 9334 3623', 'mike.barker@yahoo.au','3'),
								(61,'Bill', 'Taylor','431', 'Berry Street','Sidney', 'NSW', 'Australia','2018','+61 (02) 9123 3233', 'bill.taylor@yahoo.au','4');

--2.4 UPDATE
--Task – Update Aaron Mitchell in Customer table to Robert Walter

update "Customer" set "FirstName"= 'Robert', "LastName" = 'Walter' where "FirstName"= 'Aaron' and "LastName" = 'Mitchell';

--Task – Update name of artist “Creedence Clearwater Revival” to “CCR”

update "Artist" set "Name"='CCR' where "Name" ='Creedence Clearwater Revival';

--2.5 LIKE
--Task – Select all invoices with a billing address like “T”
select * from "Invoice" where "BillingAddress" like 'T%';

--2.6 BETWEEN
--Task – Select all invoices that have a total between 15 and 50​
select * from "Invoice" where "Total" between 15 and 50;

--Task – Select all employees hired between 1st​ of June 2003 and 1st​ of March 2004
select * from "Employee" where "HireDate"  between '2003-06-01 00:00:00' and '2004-03-01 00:00:00'; 

--2.7 DELETE
--Task – Delete a record in Customer table where the name is Robert Walter 
--(There may be constraints that rely on this, find out how to resolve them).


alter table "Invoice"
drop constraint "FK_InvoiceCustomerId";


alter table "Invoice"
add constraint "FK_InvoiceCustomerId"
foreign key ("CustomerId") 
references "Customer" ("CustomerId") on delete cascade;


alter table "InvoiceLine" 
drop constraint "FK_InvoiceLineInvoiceId";


alter table "InvoiceLine"
add constraint "FK_InvoiceLineInvoiceId"
foreign key ("InvoiceId") 
references "Invoice" ("InvoiceId") on delete cascade;


delete from "Customer" where "FirstName" = 'Robert' and "LastName" = 'Walter';



--3.0 SQL Functions
--In this section you will be using the PostGreSQL system functions, 
--as well as your own functions, to perform various actions against the database



--3.1 System Defined Functions
--Task – Create a function that returns the current time.

create or replace function time_return() returns text as
'

begin 
	return current_timestamp;
end
'
language plpgsql;

select time_return();


--Task – create a function that returns the length of a mediatype 
--from the mediatype table

create or replace function length_media_type(id int) returns int as 
$$
	begin
		return (select length("Name")
				from "MediaType"
				where "MediaTypeId" = id);
	end
$$
language plpgsql;

select length_media_type(1);
--3.2 System Defined Aggregate Functions
--Task –Create a function that returns the average total of all invoices 


create or replace function av_total() returns numeric 
as 
$$
begin
	return (select avg("Total")from "Invoice");
end
$$
language plpgsql;

select av_total();
--Task – Create a function that returns the most expensive track

create or replace function most_exp() returns text as 
$$
begin 
	return (select "Name" from "Track" t where t."UnitPrice" =(select max("UnitPrice") from "Track") limit 1);
end
$$

language plpgsql;

select most_exp();

--3.3 User Defined Scalar Functions
--Task – Create a function that returns the average price of invoice-line
-- items in the invoice-line table

create or replace function av_price_invoice_li()
returns numeric
as
$$
begin 
	return (select avg("UnitPrice") from "InvoiceLine");
end
$$

language plpgsql;

select av_price_invoice_li();

--3.4 User Defined Table Valued Functions
--Task – Create a function that returns all employees who are born after 1968.

create or replace function born_after_1968()

returns setof "Employee"
as 
$$
	begin 
		return query (select *
				from "Employee"
				where "BirthDate" > '1968-12-31');
	end
$$ language plpgsql;

select born_after_1968();

--5.0 JOINS
--In this section you will be working with combining various tables through the use of joins. 

--You will work with outer, inner, right, left, cross, and self joins.

--5.1 INNER
--Task – Create an inner join that joins customers and orders and specifies the name of 
--the customer and the invoiceId.

select c."FirstName", c."LastName" , i."InvoiceId" from "Customer" c join "Invoice" i 
on c."CustomerId"=i."CustomerId" order by c."FirstName" asc;

--5.2 OUTER
--Task – Create an outer join that joins the customer and invoice table, 
--specifying the CustomerId, firstname, last name, invoiceId, and total.

select c."CustomerId", c."FirstName", c."LastName", i."InvoiceId", i."Total" from "Customer" c full outer join "Invoice" i 
on c."CustomerId"=i."CustomerId" order by "FirstName" asc;

--5.3 RIGHT
--Task – Create a right join that joins album and artist specifying artist 
--name and title.

select a."Title", ar."Name" from "Album" a right join "Artist" ar on a."ArtistId" =ar."ArtistId";

--5.4 CROSS
--Task – Create a cross join that joins album and artist and sorts by
-- artist name in ascending order.

select * from "Album" al cross join "Artist" ar
order by ar."Name" asc;


--5.5 SELF
--Task – Perform a self-join on the employee table, joining on the reports to column.

SELECT * FROM "Employee" a, "Employee" b 
WHERE a."ReportsTo" = b."ReportsTo" ;






