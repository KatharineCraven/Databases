--Katharine Craven
--Lab 4

--Question 1
--get cities of
-- agents booking an order for a customer cid c006

select city from agents
where aid in
(select aid from orders
where cid = 'c006');

--Question 2
--Get the pids of products ordered through 
--any agent who takes at least one order from
-- a customer in Kyoto, 
--sorted by pid from highest to lowest

select distinct pid from orders 
where aid in (
select aid from orders
where cid in (select cid from customers
where city = 'Kyoto'))
Order by pid Asc;

--Question 3
----Get the cids and names of 
--customers who did not 
--place an order through agent a03

select cid, name from customers
where cid not in 
(select distinct cid from orders
where aid = 'a03');

--Question 4
--Get the cids of 
--customers who ordered both product p01 and p07

select distinct cid from customers
where cid in
(select distinct cid from orders
where pid = 'p01')
and cid in
(select cid from orders
where pid = 'p07');
