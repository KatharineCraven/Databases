--Katharine Craven
--Lab 6
--3/13/15

--Question 1
--Display the name and city of
-- customers who live in any city
--that makes the most different kinds of products

select customers.name, customers.city from customers inner join (
select city from (select max(count) from(
      select products.city,
      count(products.pid)
      from products
      group by products.city
      order by count(products.pid)
) minny) maxie inner join (
select products.city,
      count(products.pid)
      from products
      group by products.city
      order by count(products.pid)
) minny
on max = count) maxcity
on customers.city = maxcity.city;

--Question 2
--Display the names of products whopse priceUSD is below the average
--in alphabetical order

select name from products 
where priceUSD < (Select avg(priceUSD) from products)
order by name asc;

--Question 3
--Display the customer name, pid, order id, and the dollars for all orders
--sorted by dollas from high to low

select customers.name, orders.pid, orders.ordno, orders.dollars
from customers inner join orders
on customers.cid = orders.cid
order by dollars desc;

--Question 4
--Display all customers names in reverse alphabetical order
--and their total ordered
--nothing more
--use coalesce

select customers.name, coalesce(sum, 0) from customers left outer join (
select cid, sum(dollars)
from orders
group by cid
) summy
on customers.cid = summy.cid


--Question 5 
--Display the names of all customers who brought products
--from agents based in Tokyo
--along with the names of the products they ordered
--and the names of the agents who sold it to them

select cota.customername, products.name, cota.name from products inner join(
select (customers.name) customername, ota.pid, ota.name from customers inner join(
select orders.cid, orders.pid, tokyoagents.aid, tokyoagents.name from orders inner join (
select aid, name from agents
where agents.city = 'Tokyo') tokyoagents
on orders.aid = tokyoagents.aid) ota
on ota.cid = customers.cid) cota
on cota.pid = products.pid;

--Question 6
--Write a query to check the accuracy of the dollars column in the
--Orders table. This means calculating Orders.dollars from data in other tables and
--comparing those values to the values in Orders.dollars. Display all rows in orders
--where orders.dollars is incorrect, if any

--get price usd from products, multiply by qty in orders

select orders.ordno, mon, cid, aid, pid, qty, dollars
from orders left outer join (
select ordpro.ordno, (ordpro.qty*ordpro.priceUSD)checker
from (
select orders.ordno, orders.pid, orders.qty, orders.dollars, pro.priceUSD
from orders inner join(
select products.pid, products.priceUSD from products) pro
on pro.pid = orders.pid) ordpro) chkr
on chkr.ordno = orders.ordno
where chkr.checker != orders.dollars

--What's the difference between a LEFT OUTER JOIN and a RIGHT OUTER JOIN? Give example queries in sql to demonstrate.

--In a left outer join, the rows that will all be retained are from the table specified to the left of the “join” keyword.
--In a right outer join, the row that will be retained are from the table specified to the right of the “join” keyword.
--For example consider the following code:

--select customers.cid, orders.ordno from customers right outer join orders
--on customers.cid = orders.cid

--We get the following table: 
--"c001";1011
--"c002";1013
--"c003";1015
--"c006";1016
--"c001";1017
--"c001";1018
--"c001";1019
--"c006";1020
--"c004";1021
--"c001";1022
--"c001";1023
--"c006";1024
--"c001";1025
--"c002";1026

--conversely, if we put this code:

--select customers.cid, orders.ordno from customers left outer join orders
--on customers.cid = orders.cid

--We get this table: 
--"c001";1011
--"c002";1013
--"c003";1015
--"c006";1016
--"c001";1017
--"c001";1018
--"c001";1019
--"c006";1020
--"c004";1021
--"c001";1022
--"c001";1023
--"c006";1024
--"c001";1025
--"c002";1026
--"c005";

--Even though c005 has no ordno associated with it, it is not dropped from the table here.