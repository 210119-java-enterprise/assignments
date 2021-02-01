--Gabrielle Luna
---------------------------------------------------------------
---2.0 SQL Queries
---------------------------------------------------------------

---2.1 SELECT
select * from "Employee";
select * from "Employee" where "LastName" = 'King';
select * from "Employee" where "FirstName" = 'Andrew' and "ReportsTo" is null;

---2.2 ORDER BY
select * from "Album" order by "Title" desc;
select "FirstName" from "Customer" order by "FirstName" asc; 

---2.3 INSERT INTO
insert into  "Genre"
values 
		(30, 'Musical Theater'),
		(31, 'Funk');
	

insert into "Employee" 
values
	(9, 'Wilkins', 'Keri', 'Sales Support', 1, date '1980-06-13', date '2002-07-09', 
	'25 West Main St', 'Reston', 'Virginia', 'United States', '703', '1(904)245-1698', 
	null, 'keri@chinookcorp.com'),
	(10, 'Williams', 'Charles', 'Sales Support', 1, date '1972-08-08', date '2002-07-16', 
	'1601 Lakeport Dr', 'Reston', 'Virginia', 'United States', '703', '1(904)246-0865', 
	null, 'charles@chinookcorp.com');
	

insert into "Customer" 
values
	(60, 'Thompson', 'Jacob', null, '1338 Maple St', 'Newport Beach', 'CA', 
	'United States', '92653', '+1(949)947-8700', null, 'jacobTh@aol.com', 3),
	(61, 'McFearson', 'Mike', null, '608 Broken Gate Dr', 'Compton', 'CA', 
	'United States', '90220', '+1(949)666-6969', null, 'fearmcmike@apple.ie', 4);
	
--delete from "Customer" 
--where "CustomerId" >= 60;

--2.4 UPDATE
update "Customer" 
set "FirstName" = 'Robert', "LastName" = 'Walter'
where "CustomerId" = 32;

update "Artist" 
set "Name" = 'CCR'
where "ArtistId" = 76;

--2.5 LIKE
select * 
from "Invoice" i2
where "BillingAddress" like '%T%';

--2.6 BETWEEN
select * 
from "Invoice" i 
where "Total" between 15 and 50; 

select *
from "Employee" e 
where "HireDate" between date '01-07-2003' and date '01-03-2004';

--2.7 DELETE
select * from "Customer" c 
where "FirstName" = 'Robert' and "LastName" = 'Walter';

alter table "Invoice" 
drop constraint "FK_InvoiceCustomerId",
add constraint "FK_InvoiceCustomerId"
foreign key ("CustomerId") references "Customer" ("CustomerId") on delete cascade;

alter table "InvoiceLine" 
drop constraint "FK_InvoiceLineInvoiceId",
add constraint "FK_InvoiceLineInvoiceId"
foreign key ("InvoiceId") references "Invoice" ("InvoiceId") on delete cascade;

delete from "Customer" where "FirstName" = 'Robert' and "LastName" = 'Walter';

---------------------------------------------------------------
---3.0 SQL Functions
---------------------------------------------------------------

--3.1 System Defined Functions

create function get_time()
	returns time
	language plpgsql	
	as
	$$
	declare
		clock_time time;
	begin
		clock_time = current_time;
		return clock_time;
	end;
	$$;

select get_time();

create function len_mediatype(i int)
	returns int
	language plpgsql	
	as
	$$
	declare
		media varchar;
	begin
			select "Name"
			into media 
			from "MediaType"
			where "MediaTypeId" = i;
	
		return 	LENGTH(media);
	end;
	$$;

select len_mediatype(1);

--3.2 System Defined Aggregate Functions

create function avg_InvoiceTotal()
	returns int
	language plpgsql	
	as
	$$
	declare
		avg_t int;
	begin
			select avg("Total")
			into avg_t 
			from "Invoice";
	
		return 	avg_t;
	end;
	$$;

select avg_InvoiceTotal();

create or replace function expensive_tracks_f()
	returns table ("TrackName" varchar, "TrackUnitPrice" numeric(10,2) )
	language plpgsql	
	as	$$
	begin
		return query
			select "Name", "UnitPrice" 
			from "Track"
			where "UnitPrice" = (
									select max("UnitPrice")
									from "Track"
								);
		
	end;
	$$;

select expensive_tracks_f();

--3.3 User Defined Scalar Functions
create or replace function invoiceline_averageprice()
	returns numeric(5,2)
	language plpgsql	
	as	
	$$
	declare 
		avg_p numeric(5,2);
	begin
			select AVG("UnitPrice" )
			into avg_p
			from "InvoiceLine";
		return avg_p;
	end;
	$$;

select invoiceline_averageprice();

--3.4 User Defined Table Valued Functions
create or replace function employees_1968()
	returns table ("First" varchar, "Last" varchar)
	language plpgsql	
	as	$$
	begin 
		return query
			select "FirstName", "LastName" 
			from "Employee"
			where "BirthDate" >= date '01-01-1968';
		
	end;
	$$;

select employees_1968();


---------------------------------------------------------------
---5.0 JOINS
---------------------------------------------------------------

--5.1 INNER
select "FirstName", "LastName", "InvoiceId"
from "Customer" c 
inner join "Invoice" i 
on c."CustomerId" = i."CustomerId"; 

--5.2 Outer
select c."CustomerId", "FirstName", "LastName", "InvoiceId", "Total"
from "Customer" c 
full outer join "Invoice" i 
on c."CustomerId" = i."CustomerId";

--5.3 RIGHT
select a2."Name", a."Title" 
from "Album" a 
right join "Artist" a2 
on a."ArtistId" =a2."ArtistId"; 


--5.4 CROSS
select a2."Name", a."Title" 
from "Album" a 
cross join "Artist" a2 
order by a2."Name" asc; 


--5.5 SELF
select  sub."FirstName", sub."LastName", sub."Title" , 
		sup."FirstName" as "Supervisor's FirstName", sup."LastName" as "Supervisor's LastName"
from "Employee" sub 
left join "Employee" sup 
on sub."ReportsTo" = sup."EmployeeId" ; 























