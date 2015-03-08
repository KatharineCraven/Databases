--Katharine Craven
--3/7/15
--Lab 5

--Question 1
--Show the cities of agents booking an order for a customer whose cid is 'c006'.

select distinct city from agents inner join orders 
on (agents.aid = orders.aid)
where cid = 'c006';

--Question 2
--Show the pids of products ordered through any agent who makes at least one order
--for a customer in Kyoto, sorted by pid from highest to lowest 

(select aid, pid, city from orders inner join customers
on (orders.cid = customers.cid));
