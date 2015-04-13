-- Katharine Craven --
-- 4/12/15 --
-- Databases Lab 8 --

DROP TABLE IF EXISTS subOrders;
DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS suppliers;
DROP TABLE IF EXISTS addresses;
DROP TABLE IF EXISTS retailClothes;

-- Part 2 --

--Clothes for Sale--

CREATE TABLE retailClothes (
  sku            integer,
  stock          integer,
  retailPriceUSD numeric(10,2),
  description    text,
  primary key(sku)
);

-- Places ---

CREATE TABLE addresses (
  aid    integer,
  stAddress  text,
  city       text,
  state      text,
  postalcode integer,
  primary key(aid)
);

-- Suppliers --

CREATE TABLE suppliers (
  sid        integer,
  sName      text,
  aid        integer references addresses(aid),
  contact    text,
  payTerms   text,
  primary key(sid)
);

-- Purchase Orders --

CREATE TABLE orders (
  ordId            integer,
  sid              integer references suppliers(sid),
  dateofPurchase   date,
  purchaseComments text,
  primary key(ordId)
);

-- Suborders for Purchase Orders --

CREATE TABLE subOrders (
  subOrdId  integer,
  sku       integer references retailClothes(sku),
  priceUSD  numeric(10,2),
  quantity  integer,
  ordId     integer references orders(ordId),
  primary key(subOrdId)
);

-- Part 3 --

INSERT INTO RetailClothes(sku, stock, retailPriceUSD, description)
  VALUES(1, 3, 9.00, 'yellow dress');

INSERT INTO RetailClothes(sku, stock, retailPriceUSD, description)
  VALUES(2, 5, 3.00, 'blue sandals');

INSERT INTO RetailClothes(sku, stock, retailPriceUSD, description)
  VALUES(3, 2, 10.00, 'blue dress');

INSERT INTO RetailClothes(sku, stock, retailPriceUSD, description)
  VALUES(4, 3, 3.00, 'orange sandals');

INSERT INTO Addresses(aid, stAddress, city, state, postalCode)
  VALUES(1, '55 Astreet Road', 'Atown', 'CT', 55555);

INSERT INTO Addresses(aid, stAddress, city, state, postalCode)
  VALUES(2, '3 Courage Lane', 'ThaMiddlONowhur', 'WY', 33333);

INSERT INTO Addresses(aid, stAddress, city, state, postalCode)
  VALUES(3, '66 Main Street', 'New York City', 'NY', 53553);

INSERT INTO Suppliers(sid, sName, aid, contact, payTerms)
  VALUES(1, 'InStitches', 1, 'phone: 555-555-5555', 'mail check');

INSERT INTO Suppliers(sid, sName, aid, contact, payTerms)
  VALUES(2, 'RusticNeedle', 2, 'postal mail only', 'mail cash');

INSERT INTO Suppliers(sid, sName, aid, contact, payTerms)
  VALUES(3, 'InStitches', 3, 'phone: 555-555-3355', 'Have your people contact my people');

INSERT INTO Orders(ordId, sid, dateOfPurchase, purchaseComments)
  VALUES(1, 2, '2015-03-30', 'N/A');

INSERT INTO Orders(ordId, sid, dateOfPurchase, purchaseComments)
  VALUES(2, 2, '2015-04-11', 'rush order');

INSERT INTO Orders(ordId, sid, dateOfPurchase, purchaseComments)
  VALUES(3, 1, '2015-04-11', 'rush order');

INSERT INTO Orders(ordId, sid, dateOfPurchase, purchaseComments)
  VALUES(4, 3, '2015-04-13', 'N/A');

INSERT INTO SubOrders(subOrdId, sku, priceUSD, quantity, ordId)
  VALUES (1, 3, 9.00, 1, 1);

INSERT INTO SubOrders(subOrdId, sku, priceUSD, quantity, ordId)
  VALUES (2, 1, 8.00, 3, 1);

INSERT INTO SubOrders(subOrdId, sku, priceUSD, quantity, ordId)
  VALUES (3, 2, 2.00, 5, 2);

INSERT INTO SubOrders(subOrdId, sku, priceUSD, quantity, ordId)
  VALUES (4, 4, 2.00, 5, 3);

 INSERT INTO SubOrders(subOrdId, sku, priceUSD, quantity, ordId)
  VALUES (5, 3, 7.00, 2, 4);


-- Part 5 --

--Hardcoded SKU of 3

select SUM(stock + squantity) as totalForSale
from retailClothes
Full Outer Join
(select sku, sum(quantity) as squantity
  from SubOrders
  group by sku) subQuants
ON subQuants.sku = retailClothes.sku
where subQuants.sku = 3;
