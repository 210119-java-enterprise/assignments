-->SQL Queries

-->2.1
SELECT * FROM employee;
SELECT * FROM employee WHERE last_name ='King';
SELECT * FROM employee WHERE first_name='Andrew' AND reports_to IS NULL;

-->2.2
SELECT * FROM album ORDER BY title DESC;
SELECT first_name FROM customer ORDER BY first_name ASC;

-->2.3
INSERT INTO genre ("name") VALUES('ska');
INSERT INTO genre("name") VALUES('bluegrass');

INSERT INTO employee ("last_name","first_name","title","reports_to","birth_date","hire_date","address","city","state","country","postal_code","phone","fax","email") VALUES('Wilson','Philip','IT Staff','6',null,null,'555 7Ave SW','Calgary','AB','canada','T2P 23M','1234567890','0987654321','phil@chinookcorp.com');
INSERT INTO employee ("last_name","first_name","title","reports_to","birth_date","hire_date","address","city","state","country","postal_code","phone","fax","email") VALUES('Nolte','katherine','IT Staff','6',null,null,'551 7Ave SW','Calgary','AB','canada','T2P 23z','1234567891','0987654322','kno@chinookcorp.com');

INSERT INTO customer (first_name,last_name,company,address,city,state,country,postal_code,phone,fax,email,support_rep_id) VALUES('Philip','Wilson','Revature','221 baker st','Gotham',null,'Canada','23452345','2784659023',null,'phil@chinookcorp.com','3');
INSERT INTO customer (first_name,last_name,company,address,city,state,country,postal_code,phone,fax,email,support_rep_id) VALUES('Katherine','Nolte','Revature','221 baker st','Gotham',null,'Canada','23452348','2784659028',null,'kno@chinookcorp.com','3');

-->2.4
SELECT * FROM customer WHERE first_name ='Aaron';
UPDATE customer SET first_name ='Robert',last_name ='Walter' WHERE customer_id ='32';
UPDATE artist SET name ='CCR'WHERE name='Creedence Clearwater Revival';

-->2.5
SELECT * FROM invoice WHERE billing_address LIKE 'T%';

-->2.6
SELECT * FROM invoice WHERE total BETWEEN '15' AND '50';
SELECT * FROM employee WHERE hire_date BETWEEN '2003-01-06 00:00:00' AND '2004-01-03';

-->2.7
DELETE FROM customer WHERE first_name ='Robert'AND last_name ='Walter';


-->SQL Functions

-->3.1
SELECT current_timestamp;
SELECT * FROM media_type ;
SELECT name, length(name) FROM media_type;

-->3.2
SELECT avg(total) FROM invoice;
SELECT *FROM playlist_track;
SELECT max(unit_price) FROM track;

-->3.3
SELECT avg(unit_price) FROM invoice_line;

-->3.4
SELECT * FROM employee WHERE birth_date >= '1968-30-12' ;

-->joins

-->inner join
SELECT * FROM invoice i ;
SELECT customer.customer_id ,invoice_line.invoice_id FROM customer INNER JOIN invoice_line ON customer .customer_id =invoice_line .invoice_id;

-->outer join
SELECT customer.customer_id ,customer.first_name, customer.last_name,invoice.invoice_id, invoice.total FROM customer FULL OUTER JOIN invoice ON customer .customer_id =invoice.invoice_id;

-->Right join 

SELECT album.title, artist.name FROM album RIGHT JOIN artist ON album.title =artist.name;

-->cross
SELECT album.title, artist.name FROM album CROSS JOIN artist ORDER BY artist.name ASC ;

-->self
SELECT e1.reports_to AS reportsto1,e2.reports_to AS reportsto2 FROM employee e1,employee e2 WHERE e1.reports_to =e2.reports_to;


