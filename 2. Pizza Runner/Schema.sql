/*

CREATE DATABASE pizza_runner
    WITH
    OWNER = "SQLTools"
    ENCODING = 'UTF8'
    LOCALE_PROVIDER = 'libc'
    CONNECTION LIMIT = -1
    IS_TEMPLATE = False;

COMMENT ON DATABASE pizza_runner
    IS 'Pizza Runner DB for 8 Week SQL Challenge : Week 2';

*/

CREATE SCHEMA pizza_runner;
SET search_path = pizza_runner;

DROP TABLE IF EXISTS runners;
CREATE TABLE runners (
  "runner_id" INTEGER,
  "registration_date" DATE
);
INSERT INTO runners
  ("runner_id", "registration_date")
VALUES
  (1, '2021-01-01'),
  (2, '2021-01-03'),
  (3, '2021-01-08'),
  (4, '2021-01-15');


DROP TABLE IF EXISTS customer_orders;
CREATE TABLE customer_orders (
  "order_id" INTEGER,
  "customer_id" INTEGER,
  "pizza_id" INTEGER,
  "exclusions" VARCHAR(4),
  "extras" VARCHAR(4),
  "order_time" TIMESTAMP
);

INSERT INTO customer_orders
  ("order_id", "customer_id", "pizza_id", "exclusions", "extras", "order_time")
VALUES
  ('1', '101', '1', '', '', '2020-01-01 18:05:02'),
  ('2', '101', '1', '', '', '2020-01-01 19:00:52'),
  ('3', '102', '1', '', '', '2020-01-02 23:51:23'),
  ('3', '102', '2', '', NULL, '2020-01-02 23:51:23'),
  ('4', '103', '1', '4', '', '2020-01-04 13:23:46'),
  ('4', '103', '1', '4', '', '2020-01-04 13:23:46'),
  ('4', '103', '2', '4', '', '2020-01-04 13:23:46'),
  ('5', '104', '1', 'null', '1', '2020-01-08 21:00:29'),
  ('6', '101', '2', 'null', 'null', '2020-01-08 21:03:13'),
  ('7', '105', '2', 'null', '1', '2020-01-08 21:20:29'),
  ('8', '102', '1', 'null', 'null', '2020-01-09 23:54:33'),
  ('9', '103', '1', '4', '1, 5', '2020-01-10 11:22:59'),
  ('10', '104', '1', 'null', 'null', '2020-01-11 18:34:49'),
  ('10', '104', '1', '2, 6', '1, 4', '2020-01-11 18:34:49');

-- Addtional data from ChatGPT

INSERT INTO customer_orders
    ("order_id", "customer_id", "pizza_id", "exclusions", "extras", "order_time") 
VALUES
  ('11', '106', '3', '', '', '2020-01-12 12:10:05'),
  ('12', '107', '2', '4', '', '2020-01-12 13:15:32'),
  ('13', '108', '1', 'null', '2, 3', '2020-01-12 15:45:12'),
  ('14', '109', '3', '', '1', '2020-01-13 19:25:56'),
  ('15', '110', '2', '1', '3, 4', '2020-01-14 22:30:21'),
  ('16', '111', '1', '', '2', '2020-01-15 17:05:43'),
  ('17', '112', '3', 'null', '5', '2020-01-15 18:40:27'),
  ('18', '113', '2', '2, 3', '4', '2020-01-16 20:55:33'),
  ('19', '114', '1', '3', '', '2020-01-17 23:10:47'),
  ('20', '115', '3', '4, 5', '1', '2020-01-18 09:12:35'),
  ('21', '116', '2', '', '', '2020-01-19 11:50:14'),
  ('22', '117', '1', 'null', 'null', '2020-01-20 13:33:22'),
  ('23', '118', '2', '1, 3', '4, 5', '2020-01-21 15:55:30'),
  ('24', '119', '3', 'null', '2', '2020-01-22 17:45:40'),
  ('25', '120', '1', '', '1, 3', '2020-01-23 19:12:56'),
  ('26', '121', '3', '4', '', '2020-01-24 20:30:21'),
  ('27', '122', '2', '1, 5', '3', '2020-01-25 21:55:33'),
  ('28', '123', '1', '', '2', '2020-01-26 22:40:27'),
  ('29', '124', '3', 'null', 'null', '2020-01-27 23:30:47'),
  ('30', '125', '2', '4, 5', '', '2020-01-28 09:12:35'),
  ('31', '101', '3', '', '', '2020-01-29 18:05:02'),
  ('32', '102', '2', '', NULL, '2020-01-30 23:51:23'),
  ('33', '103', '1', '4', '', '2020-01-31 13:23:46'),
  ('34', '104', '1', 'null', '1', '2020-02-01 21:00:29'),
  ('35', '105', '2', 'null', '1', '2020-02-02 21:20:29'),
  ('36', '106', '1', 'null', 'null', '2020-02-03 23:54:33'),
  ('37', '107', '3', 'null', 'null', '2020-02-04 11:22:59'),
  ('38', '108', '2', '2, 6', '1, 4', '2020-02-05 18:34:49'),
  ('39', '109', '1', 'null', 'null', '2020-02-06 19:15:00'),
  ('40', '110', '3', '1', '', '2020-02-07 20:20:12');


DROP TABLE IF EXISTS runner_orders;
CREATE TABLE runner_orders (
  "order_id" INTEGER,
  "runner_id" INTEGER,
  "pickup_time" VARCHAR(19),
  "distance" VARCHAR(7),
  "duration" VARCHAR(10),
  "cancellation" VARCHAR(23)
);

INSERT INTO runner_orders
  ("order_id", "runner_id", "pickup_time", "distance", "duration", "cancellation")
VALUES
  ('1', '1', '2020-01-01 18:15:34', '20km', '32 minutes', ''),
  ('2', '1', '2020-01-01 19:10:54', '20km', '27 minutes', ''),
  ('3', '1', '2020-01-03 00:12:37', '13.4km', '20 mins', NULL),
  ('4', '2', '2020-01-04 13:53:03', '23.4', '40', NULL),
  ('5', '3', '2020-01-08 21:10:57', '10', '15', NULL),
  ('6', '3', 'null', 'null', 'null', 'Restaurant Cancellation'),
  ('7', '2', '2020-01-08 21:30:45', '25km', '25mins', 'null'),
  ('8', '2', '2020-01-10 00:15:02', '23.4 km', '15 minute', 'null'),
  ('9', '2', 'null', 'null', 'null', 'Customer Cancellation'),
  ('10', '1', '2020-01-11 18:50:20', '10km', '10minutes', 'null');


-- Added additional data from ChatGPT

INSERT INTO runner_orders 
  ("order_id", "runner_id", "pickup_time", "distance", "duration", "cancellation") 
VALUES
  ('11', '2', '2020-01-12 12:20:10', '15km', '22 minutes', ''),
  ('12', '3', '2020-01-12 13:40:50', '10.5km', '18 mins', ''),
  ('13', '1', '2020-01-12 16:30:22', '18km', '30 minutes', ''),
  ('14', '2', '2020-01-13 20:25:15', '22km', '35 mins', ''),
  ('15', '3', '2020-01-14 23:50:47', '9km', '14 minutes', ''),
  ('16', '1', '2020-01-15 18:10:30', '20.3km', '29 minutes', ''),
  ('17', '2', '2020-01-15 19:50:45', '30km', '40 minutes', ''),
  ('18', '3', '2020-01-16 22:15:37', '12km', '16 minutes', ''),
  ('19', '1', '2020-01-17 10:10:52', '25km', '32 minutes', ''),
  ('20', '2', '2020-01-18 09:20:18', '21.4km', '27 minutes', ''),
  ('21', '3', '2020-01-19 14:35:48', '13km', '20 minutes', ''),
  ('22', '1', '2020-01-20 15:20:10', '17km', '25 minutes', ''),
  ('23', '2', '2020-01-21 16:50:30', '11km', '15 mins', ''),
  ('24', '3', '2020-01-22 18:25:55', '9.7km', '12 minutes', ''),
  ('25', '1', '2020-01-23 19:45:13', '14km', '20 minutes', ''),
  ('26', '2', '2020-01-24 21:30:27', '23km', '33 minutes', ''),
  ('27', '3', '2020-01-25 22:40:05', '28km', '42 minutes', ''),
  ('28', '1', '2020-01-26 11:10:15', '19km', '28 minutes', ''),
  ('29', '2', '2020-01-27 13:30:40', '16km', '24 minutes', ''),
  ('30', '3', '2020-01-28 15:50:55', '21km', '29 minutes', ''),
  ('31', '1', '2020-01-29 18:15:34', '20km', '32 minutes', ''),
  ('32', '1', '2020-01-30 19:10:54', '20km', '27 minutes', ''),
  ('33', '1', '2020-01-31 00:12:37', '13.4km', '20 mins', NULL),
  ('34', '2', '2020-02-01 13:53:03', '23.4', '40', NULL),
  ('35', '3', '2020-02-02 21:10:57', '10', '15', NULL),
  ('36', '3', NULL, NULL, NULL, 'Restaurant Cancellation'),
  ('37', '2', '2020-02-03 21:30:45', '25km', '25mins', 'null'),
  ('38', '2', '2020-02-04 00:15:02', '23.4 km', '15 minute', 'null'),
  ('39', '2', NULL, NULL, NULL, 'Customer Cancellation'),
  ('40', '1', '2020-02-05 18:50:20', '10km', '10minutes', 'null');


DROP TABLE IF EXISTS pizza_names;
CREATE TABLE pizza_names (
  "pizza_id" INTEGER,
  "pizza_name" TEXT
);
INSERT INTO pizza_names
  ("pizza_id", "pizza_name")
VALUES
  (1, 'Meatlovers'),
  (2, 'Vegetarian');

-- Added more addtional data from ChatGPT

INSERT INTO pizza_names  
  ("pizza_id", "pizza_name")  
VALUES  
  (3, 'Pepperoni'),  
  (4, 'BBQ Chicken'),  
  (5, 'Margherita'),  
  (6, 'Hawaiian'),  
  (7, 'Supreme');  


DROP TABLE IF EXISTS pizza_recipes;
CREATE TABLE pizza_recipes (
  "pizza_id" INTEGER,
  "toppings" TEXT
);
INSERT INTO pizza_recipes
  ("pizza_id", "toppings")
VALUES
  (1, '1, 2, 3, 4, 5, 6, 8, 10'),
  (2, '4, 6, 7, 9, 11, 12');

-- Add pizza_recipes with Chat_GPT
 
INSERT INTO pizza_recipes
    ("pizza_id", "toppings")
VALUES
    (3, '2, 4, 8, 10'),              -- Pepperoni
    (4, '2, 4, 5, 6, 11'),           -- BBQ Chicken
    (5, '4, 6, 11, 12'),             -- Margherita
    (6, '4, 6, 7, 11, 12'),          -- Hawaiian
    (7, '1, 3, 4, 6, 7, 8, 9, 11');  -- Supreme

DROP TABLE IF EXISTS pizza_toppings;
CREATE TABLE pizza_toppings (
  "topping_id" INTEGER,
  "topping_name" TEXT
);
INSERT INTO pizza_toppings
  ("topping_id", "topping_name")
VALUES
  (1, 'Bacon'),
  (2, 'BBQ Sauce'),
  (3, 'Beef'),
  (4, 'Cheese'),
  (5, 'Chicken'),
  (6, 'Mushrooms'),
  (7, 'Onions'),
  (8, 'Pepperoni'),
  (9, 'Peppers'),
  (10, 'Salami'),
  (11, 'Tomatoes'),
  (12, 'Tomato Sauce');