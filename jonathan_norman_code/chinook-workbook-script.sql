/******************
 * Section 2.1
 * select statements
 ******************/

select * from "Employee";
select * from "Employee" where "LastName" = 'King';
select * from "Employee" where "FirstName" = 'Andrew' and "ReportsTo" is null;

/**********************
* Section 2.2
* order by statements
***********************/

select "Title" from "Album" order by "Title" desc;
select "FirstName" from "Customer" order by "FirstName" asc;

/**********************
* Section 2.3
* insert into statements
***********************/

insert into "Genre" values
(26, 'TRVE NORWEGIAN BLACK METAL'),
(27, 'New Orleans Bounce');

insert into "Employee" values
(9, 'Norman', 'Jonathan'),
(10, 'Hughes', 'Genevieve');

insert into "Customer" values
(60, 'Some', 'Smuck',null,null,null,null,null,null,null,null, 'somesmuck@gmail.com', null),
(61, 'Some', 'Schmoe',null,null,null,null,null,null,null,null, 'someschmoe@gmail.com', null);

/**********************
* Section 2.4
* update statements
***********************/

update "Customer" set "FirstName" = 'Robert', "LastName" = 'Walter'
where "FirstName" = 'Aaron' and "LastName" = 'Mitchell';

update "Artist" set "Name" = 'CCR' where "Name" = 'Creedence Clearwater Revival';

/**********************
* Section 2.5
* like statements
***********************/

select * from "Invoice" where "BillingAddress" like 'T%';

/**********************
* Section 2.6
* between statements
***********************/

select * from "Invoice" where "Total" between 15 and 50;
select * from "Employee" e where "HireDate" between '2003-06-01 00:00:00' and '2004-03-01 00:00:00';

delete from "Customer" where "FirstName" = 'Robert' and "LastName" = 'Walker';

/**********************
* Section 3
* SQL functions
***********************/

select current_time;
select mt."Name", length(mt."Name") from "MediaType" mt;

select avg(i."Total")  as "Average invoice total" from "Invoice" i;
select max(t."UnitPrice") as "Highest_price", t."Name" from "Track" t
group by t."Name"
order by max(t."UnitPrice") desc;

create or replace function averagePriceInvoiceLine()
returns numeric as $apil$
	select avg(il."UnitPrice") from "InvoiceLine" il
$apil$ language sql;

select averagePriceInvoiceLine();
	
create or replace function bornAfter1968() 
returns table (firstname varchar, lastname varchar, date timestamp) as $emp$
	select e."FirstName" , e."LastName", e."BirthDate" from "Employee" e
		where (select extract(isoyear from e."BirthDate")) > 1968
$emp$ language sql;

select bornAfter1968();

/**********************
* Section 5
* join statements
***********************/

select c."FirstName", c."LastName", i."InvoiceId" from "Customer" c
join "Invoice" i using ("CustomerId");

select c."CustomerId", c."FirstName", c."LastName", i."InvoiceId", i."Total" from "Customer" c
left outer join "Invoice" i using ("CustomerId");

select art."Name", alb."Title" from "Artist" art
right outer join "Album" alb using ("ArtistId");

select art."Name" from "Artist" art
cross join "Album" alb
order by art."Name" asc;

select supervisor."FirstName" as "Supervisor FirstName", 
supervisor."LastName" as "Supervisor LastName", supervisor."Title", 
subordinate."FirstName" as "Subordinate FirstName", subordinate."LastName" as "Subordinate LastName",
subordinate."Title"
from "Employee" as supervisor 
join "Employee" as subordinate on (subordinate."ReportsTo" = supervisor."EmployeeId")
order by supervisor."FirstName" asc;



