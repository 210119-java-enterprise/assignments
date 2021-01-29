-- 2.0 SQL Queries
-- 2.1 Select
-- Selects all records from Employee table
select *
from "Employee" e;

-- Selects all records from Employee table where last name is King
select *
from "Employee" e 
where "LastName" = 'King';

-- Selects all records from Employee table where first name is Andrew and REPORTSTO is NULL.
select *
from "Employee" e 
where "FirstName" = 'Andrew'
and "ReportsTo" is null;

-- 2.2 Order By
-- Select all albums in album table and sort result set in descending order
select "Title" 
from "Album" a 
order by "Title" desc   

-- Select first name from Customer and sort result in ascending order
select "FirstName"
from "Customer"
order by "FirstName" asc

-- 2.3 Insert Into
-- Insert two new records into Genre table
insert into "Genre" ("GenreId", "Name")
values ('26', 'Electric Swing'), ('27', 'New Age Funk');

-- Insert two new records into Employee table
insert into "Employee" ("EmployeeId", "LastName", "FirstName", "Title", "ReportsTo", "BirthDate", "HireDate", 
			"Address", "City", "State", "Country" , "PostalCode", "Phone", "Fax", "Email")
values ('9', 'Withrow', 'Brian', 'Cool Dude', '1', '1998-08-21 00:00:00', 'Wezley', 'Singleton', 'Wezley',
			'Wezley', 'Singleton', 'Wezley', 'Singleton', 'Wezley', 'Singleton', 'Wezley', 'Singleton'), 
		('10', 'Singleton', 'Wezley', 'Singleton', 'Wezley', 'Singleton', 'Wezley', 'Singleton', 'Wezley',
			'Wezley', 'Singleton', 'Wezley', 'Singleton', 'Wezley', 'Singleton', 'Wezley', 'Singleton');

-- Insert two new records into Customer table
insert into demo_customers(fn, ln)
values ('Wezley', 'Singleton'), ('Nick', 'Jurczak'), ('Mehrab', 'Rahman');