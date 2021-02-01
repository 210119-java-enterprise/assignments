/* 2.1 SELECT */
select *
from "Employee" e
---------------------------------------------
select *
from "Employee" e 
where "LastName" = 'King'
---------------------------------------------
select *
from "Employee" e 
where
	"FirstName" = 'Andrew' and
	"ReportsTo" is null
	
/* 2.2 ORDER BY */
select *
from "Album" a2 
order by
	"AlbumId" desc 
----------------------------------------------------
select "FirstName" 
from "Customer" c2 
order by
	"FirstName" asc --ascending is default--

/* 2.3 INSERT INTO */
insert into "Genre" values
	('26', 'Techno'),
	('27', 'Dubstep');
-------------------------------------------------
insert into "Employee" values
	('9', )
	
/* 2.4 UPDATE */
update "Customer" set 
	"FirstName" = 'Robert',
	"LastName" = 'Walter'
	where 
	(
		"FirstName" = 'Aaron' and 
		"LastName" = 'Mitchell'
	);
--------------------------------------------------
update "Artist" set
	"Name" = 'CCR'
	where 
	(
		"Name" = 'Creedence Clearwater Revival'
	);

/* 2.5 LIKE */
select *
from "Invoice" i 
where
	(
		"BillingAddress" like 'T%'
	);

/* 2.6 BETWEEN */
select *
from "Invoice" i 
where 
	(
		"Total" between 15 and 50
	);
----------------------------------------------
select *
from "Employee" e2 
where 
	(
		"HireDate" between '01/06/2003' and '01/03/2004'
	);

/* 2.7 DELETE */
delete from "InvoiceLine" 
where "InvoiceId" = 50
returning *;

delete from "InvoiceLine" 
where "InvoiceId" = 61
returning *;

delete from "InvoiceLine" 
where "InvoiceId" = 116
returning *;

delete from "InvoiceLine" 
where "InvoiceId" = 245
returning *;

delete from "InvoiceLine" 
where "InvoiceId" = 268
returning *;

delete from "InvoiceLine" 
where "InvoiceId" = 290
returning *;

delete from "InvoiceLine" 
where "InvoiceId" = 342
returning *;

delete from "Invoice" i 
where 
	( 
		"CustomerId" = 32
	)
returning *;

delete from "Customer" 
where 
	( 
		"FirstName" = 'Robert' and 
		"LastName" = 'Walter'
	);

/* 3.1 System Defined Functions */
create or replace function getTime()
	returns timestamptz
	as 
	$$
		begin 
			return current_timestamp;
		end
	$$
	language plpgsql;

select getTime();

---------------------------------------------
drop function getLengthMedia;

create or replace function getLengthMedia(id numeric)
	returns numeric 
	as $$
		declare
			media_name text;
			result numeric;
		begin
			
			select "Name"
			into media_name
			from "MediaType"
			where "MediaTypeId" = $1;
		
			result = length(media_name);
		
			return result;
		end
	$$
	language plpgsql;

select getLengthMedia(2);

/* 3.2 System Defined Aggregate Functions */

select "Total" 
from "Invoice" i 

create or replace function avg_invoice()
	returns int
	as 
	$$
	declare 
		result int;
	begin
		select AVG("Total")
		into result
		from "Invoice";
		
		return result;
	end
	$$
	language plpgsql;

select avg_invoice();
----------------------------------------------

select *
from "Track" t 

create or replace function max_track()
	returns text
	as 
	$$
	declare 
		largest int;
		result text;
	begin
		select MAX("UnitPrice")
		into largest
		from "Track";
	
		select *
		into result
		from "Track"
		where "UnitPrice" = largest;
		
		return result;
	end
	$$
	language plpgsql;

select max_track();

commit;


















