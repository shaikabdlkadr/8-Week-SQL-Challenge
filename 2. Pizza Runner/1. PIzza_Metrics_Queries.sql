SELECT * FROM pizza_runner.customer_orders;

SELECT * FROM pizza_runner.pizza_names;

SELECT * FROM pizza_runner.pizza_recipes;

SELECT * FROM pizza_runner.pizza_toppings;

SELECT * FROM pizza_runner.runner_orders;

SELECT * FROM pizza_runner.runners;


-- A : Pizza Metrics

-- How many pizzas were ordered?

SELECT COUNT(*) AS pizza_order
FROM pizza_runner.customer_orders;

-- How many unique customer orders were made?

SELECT COUNT(DISTINCT(order_id)) AS unique_customer_order
FROM pizza_runner.customer_orders;

-- How many successful orders were delivered by each runner?

-- Used to find the distinct cancellation messages from the runner_orders table
SELECT DISTINCT cancellation
FROM pizza_runner.runner_orders;


SELECT ro.runner_id, COUNT(ro.order_id) AS delivered_successful_orders
FROM pizza_runner.customer_orders co
JOIN pizza_runner.runner_orders ro
    ON co.order_id = ro.order_id
WHERE ro.distance NOT IN ('', 'null')
GROUP BY 1
ORDER BY 2 DESC;

-- How many of each type of pizza was delivered?

SELECT DISTINCT pname.pizza_name, COUNT(co.pizza_id) AS count
FROM pizza_runner.customer_orders co
JOIN pizza_runner.runner_orders ro
    ON co.order_id = ro.order_id
JOIN pizza_runner.pizza_names pname
    ON co.pizza_id = pname.pizza_id
WHERE ro.distance NOT IN ('null', '')  -- Exclude string 'null' and '' Empty String
GROUP BY 1;

-- How many Vegetarian and Meatlovers were ordered by each customer?

SELECT co.customer_id, pname.pizza_name, COUNT(co.order_id) AS ord_count
FROM pizza_runner.customer_orders co
JOIN pizza_runner.pizza_names pname
    ON co.pizza_id = pname.pizza_id
WHERE pname.pizza_name IN ('Vegetarian', 'Meatlovers')
GROUP BY 1, 2
ORDER BY 1;

-- What was the maximum number of pizzas delivered in a single order?

SELECT co.order_id, co.customer_id, ro.runner_id, COUNT(co.order_id) AS delivrd_pizza_per_order
FROM pizza_runner.runner_orders ro
JOIN pizza_runner.customer_orders co
	USING(order_id)
WHERE ro.distance NOT IN ('0', 'null')
GROUP BY 1, 2, 3
ORDER BY 4 DESC;

-- For each customer, how many delivered pizzas had at least 1 change and how many had no changes?

WITH orders_cleaned AS (
    SELECT co.order_id, co.customer_id,
        -- Clean exclusions (handle NULL, 'null', empty string)
        CASE WHEN co.exclusions IS NULL OR co.exclusions = 'null' OR co.exclusions = ''
            THEN NULL ELSE co.exclusions END AS exclusions,
        -- Clean extras (handle NULL, 'null', empty string)
        CASE WHEN co.extras IS NULL OR co.extras = 'null' OR co.extras = ''
            THEN NULL ELSE co.extras END AS extras,
        ro.runner_id,
        ro.distance,
        ro.cancellation
    FROM pizza_runner.customer_orders co
    JOIN pizza_runner.runner_orders ro 
        ON co.order_id = ro.order_id
    WHERE ro.distance NOT IN ('0', 'null')
)

SELECT customer_id,
    SUM(CASE WHEN exclusions IS NULL AND extras IS NULL THEN 1 ELSE 0 END) AS pizzas_with_no_changes,
    SUM(CASE WHEN exclusions IS NOT NULL OR extras IS NOT NULL THEN 1 ELSE 0 END) AS pizzas_with_changes,
    COUNT(*) AS total_delivered_pizzas
FROM orders_cleaned
GROUP BY 1
ORDER BY 1;

-- How many pizzas were delivered that had both exclusions and extras?

WITH orders_cleaned AS (
    SELECT co.order_id, co.customer_id, co.pizza_id,
        -- Clean exclusions (handle NULL, 'null', empty string)
        CASE
            WHEN co.exclusions IS NULL OR co.exclusions = 'null' OR co.exclusions = ''
                THEN NULL ELSE co.exclusions END AS exclusions,
        -- Clean extras (handle NULL, 'null', empty string)
        CASE
            WHEN co.extras IS NULL OR co.extras = 'null' OR co.extras = ''
                THEN NULL ELSE co.extras END AS extras,
        ro.runner_id,
        ro.pickup_time,
        ro.distance,
        ro.cancellation
    FROM pizza_runner.customer_orders co
    JOIN pizza_runner.runner_orders ro ON co.order_id = ro.order_id
    WHERE ro.distance NOT IN ('0', 'null')
)

SELECT customer_id,
    SUM(CASE WHEN exclusions IS NOT NULL AND extras IS NOT NULL THEN 1 ELSE 0 END) AS pizzas_deilvered_with_extras_exclusions,
    COUNT(*) AS total_delivered_pizzas
FROM orders_cleaned
GROUP BY 1
HAVING SUM(CASE WHEN exclusions IS NOT NULL AND extras IS NOT NULL THEN 1 ELSE 0 END) > 0
ORDER BY 1;

-- What was the total volume of pizzas ordered for each hour of the day?

SELECT EXTRACT(HOURS FROM order_time) AS ord_hrs, COUNT(order_id) AS total_pizzas_ordered
FROM pizza_runner.customer_orders
GROUP BY 1;

-- What was the volume of orders for each day of the week?

SELECT to_char(order_time, 'Day') AS orders_dayof_week, COUNT(order_id) AS total_pizzas_ordered
FROM pizza_runner.customer_orders
GROUP BY 1
ORDER BY 2 DESC;