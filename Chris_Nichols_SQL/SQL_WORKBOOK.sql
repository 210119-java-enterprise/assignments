-- ============ SECTION 2.1 SELECT  =============================

--Select all records from Employee
select * from "Employee" e ;

--select all recrods from Employee where last name is King
select * from "Employee" e 
where "LastName" = 'King';

--Select all records from the Employee table where first name is Andrew and REPORTSTO is NULL.
select * from "Employee" e 
where "FirstName" = 'Andrew' and "ReportsTo" IS NULL;

--=============== 2.2 ORDER BY ==========================

--select all albums in album table and sort result set in descending order
select * from "Album" a 
order by "AlbumId" desc;

--Select first name from Customer and sort result set in ascending order
select "FirstName" from "Customer" c 
order by "FirstName" asc;

-- ============== 2.3 INSERT INTO ===========================
select * from "Genre" g2 ;

--Insert two new records into Genre table
insert into "Genre" ("GenreId","Name")
values 
	(100,'Post-Rock'),
	(200,'Crazy-Frog');


--Insert two new records into Employee table
insert into "Employee" ("EmployeeId","FirstName","LastName","Title","BirthDate","HireDate","City")
values
	(10,'Chris','Nichols','Code Monkey','1989/08/23',current_date,'Oxford'),
	(11,'Lars','Smith','Boat Captain','1998/02/21',current_date,'Minnesota');


--Insert two new records into Customer table
insert into "Customer"  ("CustomerId","FirstName","LastName","Email")
values 
	(100,'Chris','Nichols','chris.nichols@revature.net'),
	(102,'Lars','Smith','LarsSmith123@email.com');


--============= 2.4 UPDATE ==========================

--Aaron Mitchell in Customer table to Robert Walter
update "Customer" 
set "LastName" = 'Walter', "FirstName" = 'Robert'
where "FirstName" = 'Aaron' and "LastName" = 'Mitchell';


--Update name of artist “Creedence Clearwater Revival” to “CCR”
update "Artist" 
set "Name"  = 'CCR'
where "Name" = 'Creedence Clearwater Revival';

--============== 2.5 LIKE ==============================

--Select all invoices with a billing address like “T”
select * from "Invoice" i 
where "BillingAddress" like 'T%';

--============== 2.6 BETWEEN ===============================

--Select all invoices that have a total between 15 and 50
select * from "Invoice" i 
where "Total" between 15 and 50;

--Select all employees hired between 1st of June 2003 and 1st of March 2004
select * from "Employee" e 
where "HireDate" between '2003-06-01 00:00:00' and '2004-03-01 00:00:00';

--========== 2.7 DELETE ============================
select * from "Invoice";
--Delete a record in Customer table where the name is Robert Walter (There may be constraints that rely on this, find out how to resolve them).
alter table "Invoice" ("CustomerId")
references "Customer"("CustomerId") on delete cascade;

delete from "Customer" 
where "FirstName" = 'Robert' and "LastName" = 'Walter';



--============== 3.0 SQL Functions =============

--In this section you will be using the PostGreSQL system functions, as well as your own functions, to perform various actions against the database
--========= 3.1 System Defined Functions =========

--Create a function that returns the current time.
select localtime;


select length("Name")  from "MediaType" mt  ;

--======== 3.2 System Defined Aggregate Functions ============

--Create a function that returns the average total of all invoices
 select AVG("Total") from "Invoice";


--Create a function that returns the most expensive track
select MAX("UnitPrice") from "Track";		


--============ 3.3 User Defined Scalar Functions =================

--Create a function that returns the average price of invoice-line items in the invoice-line table
create or replace function avgPriceInvoice()
	returns numeric 
	as 
	'
		select avg("UnitPrice") from "InvoiceLine";	
	'
language sql;

--============= 3.4 User Defined Table Valued Functions ===============

--Create a function that returns all employees who are born after 1968.
create or replace function getEmployeesBornAfter1968()
 returns table(employeeId int,LastName varchar, FirstName varchar,Title varchar,BirthDate timestamp)
	AS $$
	begin
		return query select "EmployeeId","LastName","FirstName","Title","BirthDate" 
		from "Employee"
		where "BirthDate" > '1968-12-31 00:00:00';
	end $$
	language plpgsql;

select * from getEmployeesBornAfter1968();


--===================== 5.0 JOINS ==============================
--In this section you will be working with combining various tables through the use of joins. You will work with outer, inner, right, left, cross, and self joins.


--====================== 5.1 INNER ========================

-- create an inner join that joins customers and orders and specifies the name of the customer and the invoiceId.
	select c."FirstName",c."LastName", i."InvoiceId" from "Customer" c 
	join "Invoice" as i  on c."CustomerId" = i."CustomerId";
	
commit;
--==================== 5.2 OUTER ====================
--Create an outer join that joins the customer and invoice table, specifying the CustomerId, firstname, last name, invoiceId, and total.
	select c."CustomerId",c."FirstName",c."LastName", i."InvoiceId",i."Total" from "Customer" c
	full outer join "Invoice" i
	on i."CustomerId" = c."CustomerId" ;
	

--===================== 5.3 RIGHT ===========================
--Create a right join that joins album and artist specifying artist name and title.
select alb."Title",art."Name" from "Artist" art
right join "Album" alb on alb."ArtistId" = art."ArtistId"; 

--====================== 5.4 CROSS =================================
--Create a cross join that joins album and artist and sorts by artist name in ascending order.
select art."Name",alb."Title" from "Artist" art
cross join "Album" alb
order by art."Name";

--======================== 5.5 SELF ===================================
--Perform a self-join on the employee table, joining on the reports to column.

select * from 
"Employee" e ,"Employee" e2 
where e."ReportsTo" = e2."ReportsTo" ;




