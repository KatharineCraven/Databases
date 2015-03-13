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
where priceUSD < (Select avg(priceUSD) from products);