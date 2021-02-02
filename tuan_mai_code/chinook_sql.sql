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
	(9, 'Mike', 'Looop', 'IT Staff', 6, '1995/12/12 11:11:35', '2020-10-02 15:00:00', '123 address here', 'City', 'TX', 'USA', '75555', '+1 (214) 546-2321', '+1 (214) 651-3215', 'mike@chinookcorp.com'),
	(10, 'Geeeed', 'king', 'IT Staff', 6, '1996/11/02 11:11:25', '20200-10-01 16:00:00', '452 adress Drive', 'City', 'TX', 'USA', '77856', '+1 (214) 352-4567', '+1 (214) 365-4154', 'geeed@chinookcorp.com');
------------------------------------------------
insert into "Customer" values
	(60, 'Lol', 'Nuke', null, '323 street', 'Garland', 'TX', 'US', null, '+216 603 6458', null, 'Lol@gmail.com', 3),
	(61, 'Look','Here', null, '574 hallway', 'Dallas', 'TX', 'US', null, '+698 546 3222', null, 'Look@gmail.com', 3);
	
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
from "Track" t ;

drop function max_track();

create or replace function max_track()
	returns table(TrackId int4, Name varchar(200), AlbumId int4, MediaTypeId int4, GenreId int4, Composer varchar(220), Milliseconds int4, Bytes int4, UnitPrice numeric(10,2))
	as 
	$$
	begin
		return Query
			select *
			from "Track"
			where "UnitPrice" >=
				(
					select max("UnitPrice")
					from "Track"
				);
			
	end
	$$
	language plpgsql;

select max_track();

-----------------------------------------
/* 3.3 User Defined Scalar Functions */
select *
from "InvoiceLine" il;

create or replace function avg_invoice_line()
	returns numeric(8,6)
	as $$
		declare 
			avgInvoiceLine numeric(8,6);
		begin 
			select avg("UnitPrice")
			into avgInvoiceLine
			from "InvoiceLine";
		
			return avgInvoiceLine;	
		end
	$$
	language plpgsql;

select avg_invoice_line();

/* 3.4 User Defined Table Valued Functions */

create or replace function born_after_1968()
	returns table(FirstName varchar(20), LastName varchar(20))
	as $$
		begin
			return Query
				select "FirstName", "LastName"
				from "Employee"
				where "BirthDate" > '1968/12/31 23:59:59';
		end
	$$
	language plpgsql;
	
select born_after_1968();

/* 5.1 INNER */

select C."FirstName", C."LastName", I."InvoiceId"
from "Customer" C
inner join "Invoice" I
on C."CustomerId" = I."CustomerId" ;

/* 5.2 OUTER */

select C."CustomerId", C."FirstName", C."LastName", I."InvoiceId", I."Total"
from "Customer" C
full outer join "Invoice" I
on C."CustomerId" = I."CustomerId"; 

/* 5.3 RIGHT */
select ar."Name", aL."Title"
from "Artist" ar
right join "Album" aL
on ar."ArtistId" = aL."ArtistId";

/* 5.4 CROSS */
select *
from "Artist" a
cross join "Album" a2
order by a."Name" asc;

/* 5.5 SELF */
select *
from "Employee" e, "Employee" e2 
where e."ReportsTo" = e."ReportsTo"

commit;


















