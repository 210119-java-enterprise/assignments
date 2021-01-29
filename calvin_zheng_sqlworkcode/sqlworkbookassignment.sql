--Revature Associate SQL Workbook
--PostGreSQL
--Working with Relational Datebase Management Systems

--1.0 DONE
--2.0 SQL Queries
--In this section you will be performing various queries against the Oracle Chinook database.

--2.1 SELECT
--Task � Select all records from the Employee table. 
select * from "Employee"; 

--Task � Select all records from the Employee table where last name is King.
select * from "Employee" where "LastName" = 'King'

--Task � Select all records from the Employee table where first name is Andrew and REPORTSTO is NULL.
select * from "Employee" where "FirstName" = 'Andrew' and "ReportsTo" is null ;

--2.2 ORDER BY
--Task � Select all albums in album table and sort result set in descending order
select * from "Album" order by "AlbumId" desc;

--Task � Select first name from Customer and sort result set in ascending order
select "FirstName" from "Customer" order by "FirstName" asc;

--2.3 INSERT INTO
--Task � Insert two new records into Genre table
INSERT INTO "Genre" ("GenreId", "Name") VALUES (26, N'NEWROCK');
INSERT INTO "Genre" ("GenreId", "Name") VALUES (27, N'BESTROCK');

--Task � Insert two new records into Employee table
INSERT INTO "Employee" ("EmployeeId", "LastName", "FirstName", "Title", "ReportsTo", "BirthDate", "HireDate", "Address", "City", "State", "Country", "PostalCode", "Phone", "Fax", "Email") VALUES (9, N'Doe', N'Mark', N'IT Staff', 6, '1972/12/12', '2003/2/4', N'289 10th ST', N'Cloquet', N'MN', N'USA', N'55720', N'+1 (218) 467-3351', N'+1 (218) 467-8772', N'DoeM@chinookcorp.com');
INSERT INTO "Employee" ("EmployeeId", "LastName", "FirstName", "Title", "ReportsTo", "BirthDate", "HireDate", "Address", "City", "State", "Country", "PostalCode", "Phone", "Fax", "Email") VALUES (10, N'Son', N'Nana', N'IT Staff', 6, '1969/08/20', '2003/3/12', N'720 42th ST', N'Cloquet', N'MN', N'USA', N'55720', N'+1 (218) 560-2020', N'+1 (218) 789-1277', N'SonN@chinookcorp.com');

--Task � Insert two new records into Customer table
INSERT INTO "Customer" ("CustomerId", "FirstName", "LastName", "Address", "City", "Country", "PostalCode", "Phone", "Email", "SupportRepId") VALUES (60, N'John', N'Miller', N'29 10th ST', N'Duluth', N'USA', N'55802', N'617-289-0001', N'JohnM1234@yahoo.com', 3);
INSERT INTO "Customer" ("CustomerId", "FirstName", "LastName", "Address", "City", "Country", "PostalCode", "Phone", "Email", "SupportRepId") VALUES (61, N'Austin', N'Andrew', N'70 Little Canda', N'Duluth', N'USA', N'55802', N'617-300-2020', N'AAA@yahoo.com', 3);

--2.4 UPDATE
--Task � Update Aaron Mitchell in Customer table to Robert Walter
update "Customer" set "FirstName" = 'Robert',"LastName" = 'Walter' where "FirstName" = 'Aaron' and "LastName" = 'Mitchell'

--Task � Update name of artist �Creedence Clearwater Revival� to �CCR�
update "Artist" set "Name" = 'CCR' where "Name" = 'Creedence Clearwater Revival';

--2.5 LIKE
--Task � Select all invoices with a billing address like �T�
select * from "Invoice" where "BillingAddress" like '%T%';

--2.6 BETWEEN
--Task � Select all invoices that have a total between 15 and 50
select * from "Invoice" where "Total" >=15 and "Total" <=50;
select * from "Invoice" where "Total" between 15 and 50;

--Task � Select all employees hired between 1st of June 2003 and 1st of March 2004
select * from "Employee" where "HireDate" between '2003/06/01' and '2004/03/01';

--2.7 DELETE
--Task � Delete a record in Customer table where the name is Robert Walter (There may be constraints that rely on this, find out how to resolve them).
alter table "Invoice" 
drop constraint "FK_InvoiceCustomerId",
add constraint "FK_InvoiceCustomerId"
foreign key ("CustomerId") references "Customer" ("CustomerId") on delete cascade;

alter table "InvoiceLine" 
drop constraint "FK_InvoiceLineInvoiceId",
add constraint "FK_InvoiceLineInvoiceId"
foreign key ("InvoiceId") references "Invoice" ("InvoiceId") on delete cascade;
delete from "Customer" where "FirstName" = 'Robert' and "LastName" = 'Walter';

--3.0 SQL Functions
--In this section you will be using the PostGreSQL system functions, as well as your own functions, to perform various actions against the database

--3.1 System Defined Functions
--Task � Create a function that returns the current time.
create or replace function OUTPUTDATE() 
returns time
as $$
	begin 
		return current_time;
	end
$$
language plpgsql;

select OUTPUTDATE();

--Task � create a function that returns the length of a mediatype from the mediatype table
--The function returns the length of a mediatype when entered id number
create or replace function LENGTHTYPE(idnumber int)
returns varchar(120)
as $$
	declare 
		lengthoftype int;
	begin 
		
		select length("Name") into lengthoftype from "MediaType" m where m."MediaTypeId" = idnumber;
		return lengthoftype;
	end
$$
language plpgsql;

select LENGTHTYPE(1);
--3.2 System Defined Aggregate Functions
--Task �Create a function that returns the average total of all invoices
create or replace function averagetotal()
returns numeric(10,2)
as $$
	declare
		avgtotal numeric(10,2);
	begin 
		select AVG("Total") into avgtotal from "Invoice";
		return avgtotal;
	end
$$
language plpgsql;

select averagetotal();


--Task � Create a function that returns the most expensive track
create or replace function mostexpen()
returns numeric(10,2)
as $$
	declare
		mostexpenT NUMERIC(10,2);
	begin 
		select Max(t."UnitPrice") into mostexpenT from "Track" t;
		return mostexpenT;
	end
$$
language plpgsql;

select mostexpen();

--3.3 User Defined Scalar Functions
--Task � Create a function that returns the average price of invoice-line items in the invoice-line table
create or replace function avgpriceilitems()
returns numeric(10,2)
as $$
	declare
		avgprice NUMERIC(10,2);
	begin 
		select AVG(I."UnitPrice") into avgprice from "InvoiceLine" I;
		return avgprice;
	end
$$
language plpgsql;

select avgpriceilitems();

--3.4 User Defined Table Valued Functions
--Task � Create a function that returns all employees who are born after 1968.
create or replace function employe_after_born_after_1968()
returns setof "Employee"
as $$
	
	begin 
		return query
		select * from "Employee" e where e."BirthDate" > '1968/12/31';
		
	end
$$
language plpgsql;

select * from employe_after_born_after_1968();

--5.0 JOINS
--In this section you will be working with combining various tables through the use of joins. You will work with outer, inner, right, left, cross, and self joins.
--5.1 INNER
--Task � Create an inner join that joins customers and orders and specifies the name of the customer and the invoiceId.
select c."FirstName", c."LastName" , i."InvoiceId" from "Customer" c inner join "Invoice" i on i."CustomerId" = c."CustomerId" ;

--5.2 OUTER
--Task � Create an outer join that joins the customer and invoice table, specifying the CustomerId, firstname, last name, invoiceId, and total.
select c."CustomerId" , c."FirstName",c."LastName" ,i."InvoiceId", i."Total" from "Customer" c full outer join "Invoice" i on c."CustomerId" = i."CustomerId" ;

--5.3 RIGHT
--Task � Create a right join that joins album and artist specifying artist name and title.
select a1."Name" , a2."Title" from "Artist" a1 right join "Album" a2 on a1."ArtistId" = a2."ArtistId" ;

--5.4 CROSS
--Task � Create a cross join that joins album and artist and sorts by artist name in ascending order.
select a1."Name" from "Artist" a1 cross join "Album" a2 order by a1."Name" asc;

--5.5 SELF
--Task � Perform a self-join on the employee table, joining on the reports to column.
select e1."EmployeeId" , e1."ReportsTo" , e2."EmployeeId" ,e2."ReportsTo" from "Employee" e1 join "Employee" e2 on e1."ReportsTo" = e2."ReportsTo" ;
