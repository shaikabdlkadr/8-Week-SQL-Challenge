CREATE DATABASE dannys_diner;

CREATE SCHEMA dannys_diner;
SET search_path = dannys_diner;

CREATE TABLE sales (
  "customer_id" VARCHAR(1),
  "order_date" DATE,
  "product_id" INTEGER
);

INSERT INTO sales
  ("customer_id", "order_date", "product_id")
VALUES
  ('A', '2021-01-01', '1'),
  ('A', '2021-01-01', '2'),
  ('A', '2021-01-07', '2'),
  ('A', '2021-01-10', '3'),
  ('A', '2021-01-11', '3'),
  ('A', '2021-01-11', '3'),
  ('B', '2021-01-01', '2'),
  ('B', '2021-01-02', '2'),
  ('B', '2021-01-04', '1'),
  ('B', '2021-01-11', '1'),
  ('B', '2021-01-16', '3'),
  ('B', '2021-02-01', '3'),
  ('C', '2021-01-01', '3'),
  ('C', '2021-01-01', '3'),
  ('C', '2021-01-07', '3');
 

CREATE TABLE menu (
  "product_id" INTEGER,
  "product_name" VARCHAR(5),
  "price" INTEGER
);

INSERT INTO menu
  ("product_id", "product_name", "price")
VALUES
  ('1', 'sushi', '10'),
  ('2', 'curry', '15'),
  ('3', 'ramen', '12');
  

CREATE TABLE members (
  "customer_id" VARCHAR(1),
  "join_date" DATE
);

INSERT INTO members
  ("customer_id", "join_date")
VALUES
  ('A', '2021-01-07'),
  ('B', '2021-01-09');


-- Additional sales data  
INSERT INTO sales
  ("customer_id", "order_date", "product_id")
VALUES
  ('A', '2021-01-15', '1'),
  ('A', '2021-01-17', '2'),
  ('B', '2021-02-05', '1'),
  ('B', '2021-02-10', '2'),
  ('B', '2021-02-15', '3'),
  ('C', '2021-01-10', '1'),
  ('C', '2021-01-12', '2'),
  ('C', '2021-01-15', '3'),
  ('C', '2021-02-01', '1'),
  ('D', '2021-01-02', '1'),
  ('D', '2021-01-04', '3'),
  ('D', '2021-01-06', '2'),
  ('D', '2021-02-20', '3'),
  ('E', '2021-01-03', '2'),
  ('E', '2021-01-07', '3'),
  ('E', '2021-01-08', '1');

-- Additional menu items  
INSERT INTO menu
  ("product_id", "product_name", "price")
VALUES
  ('4', 'steak', '20'),
  ('5', 'pizza', '18'),
  ('6', 'pasta', '14');

-- Additional member registrations  
INSERT INTO members
  ("customer_id", "join_date")
VALUES
  ('C', '2021-01-10'),
  ('D', '2021-01-15'),
  ('E', '2021-02-01');

-- Additional sales data with newly added menu items  
INSERT INTO sales
  ("customer_id", "order_date", "product_id")
VALUES
  ('A', '2021-01-20', '4'), -- steak
  ('A', '2021-01-25', '5'), -- pizza
  ('A', '2021-01-30', '6'), -- pasta
  ('B', '2021-02-07', '4'), -- steak
  ('B', '2021-02-12', '6'), -- pasta
  ('B', '2021-02-18', '5'), -- pizza
  ('C', '2021-01-14', '4'), -- steak
  ('C', '2021-01-20', '6'), -- pasta
  ('C', '2021-01-25', '5'), -- pizza
  ('C', '2021-02-03', '2'), -- curry
  ('D', '2021-01-10', '6'), -- pasta
  ('D', '2021-01-15', '5'), -- pizza
  ('D', '2021-01-22', '4'), -- steak
  ('D', '2021-02-05', '3'), -- ramen
  ('E', '2021-01-04', '4'), -- steak
  ('E', '2021-01-06', '5'), -- pizza
  ('E', '2021-01-09', '6'), -- pasta
  ('E', '2021-02-10', '1'), -- sushi
  ('E', '2021-02-12', '2'); -- curry
