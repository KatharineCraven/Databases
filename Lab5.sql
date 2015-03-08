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
--no subqueries

(select aid, pid, city from orders inner join customers
on (orders.cid = customers.cid));

--NOT FINISHED :(((((((((

--Question 3
--Show the names of customers who have never placed an order
--use a subquery
select name from customers
where cid not in
(select distinct cid from orders);

--Question 4
--Show the names of customers who have never placed an order.
--use an outer join

select name from customers
where name not in(
select distinct name from customers
right outer join orders
on (customers.cid = orders.cid));

--Question 5
--Show the names of customers who placed at least one order through an agent in their
--own city, along with those agents names

select distinct customers.name, agents.name from customers inner join orders
on customers.cid = orders.cid
inner join agents
on orders.aid = agents.aid
where agents.city = customers.city;

--Question 6
--Show the names of customers and agents living in the same city, along with the name
--of the shared city, regardless of whether or not the customer has ever placed an
--order with that agent

select distinct customers.name, agents.name, customers.city, agents.city from customers inner join agents
on customers.city = agents.city;