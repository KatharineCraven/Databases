--Katharine Craven
--3/7/15
--Lab 5

--Question 1
--Show the cities of agents booking an order for a customer whose cid is 'c006'.

select distinct city from agents inner join orders 
on (agents.aid = orders.aid)
where cid = 'c006';

