-- Verifying the imports were done

SELECT * FROM dannys_diner.sales;

SELECT * FROM dannys_diner.menu;

SELECT * FROM dannys_diner.members;


-- 1.  What is the total amount each customer spent at the restaurant?

SELECT s.customer_id, SUM(m.price) AS total_sales
FROM dannys_diner.sales AS s
JOIN dannys_diner.menu AS m
    ON s.product_id = m.product_id
GROUP BY s.customer_id
ORDER BY 1 ASC;

-- 2. How many days has each customer visited the restaurant?

