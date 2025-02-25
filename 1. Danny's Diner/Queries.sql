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

SELECT customer_id, COUNT(DISTINCT order_date) AS visit_count
FROM dannys_diner.sales
GROUP BY customer_id;

-- 3. What was the first item from the menu purchased by each customer?

WITH first_ord_sales AS (
  SELECT s.customer_id, s.order_date, m.product_name,
    -- ROW_NUMBER() OVER (PARTITION BY s.customer_id ORDER BY s.order_date) AS row_num
    -- using Row_number will not give Customer-A 1st orders since the order_date doesn't have timestamp, we conclude it with dense_rank()
    DENSE_RANK() OVER (PARTITION BY s.customer_id ORDER BY s.order_date) AS drnk
  FROM dannys_diner.sales AS s
  JOIN dannys_diner.menu AS m
    ON s.product_id = m.product_id
)

SELECT 
  customer_id, 
  product_name
FROM first_ord_sales
WHERE drnk = 1
GROUP BY customer_id, product_name;


-- 4. What is the most purchased item on the menu and how many times was it purchased by all customers?

SELECT m.product_name, COUNT(s.product_id) AS most_purchased_item
FROM dannys_diner.sales AS s
JOIN dannys_diner.menu AS m
  ON s.product_id = m.product_id
GROUP BY m.product_name
ORDER BY most_purchased_item DESC;


-- 5. Which item was the most popular for each customer?

WITH most_poplr AS (
  SELECT s.customer_id, m.product_name, COUNT(m.product_id) AS order_count,
    DENSE_RANK() OVER (PARTITION BY s.customer_id ORDER BY COUNT(s.customer_id) DESC) AS drnk
  FROM dannys_diner.menu AS m
  JOIN dannys_diner.sales AS s
    ON m.product_id = s.product_id
  GROUP BY s.customer_id, m.product_name
)

SELECT customer_id, product_name, order_count
FROM most_poplr 
WHERE drnk = 1;


-- 6. Which item was purchased first by the customer after they became a member?

WITH first_order_memb AS (
    SELECT s.customer_id, m.product_name,
        RANK() OVER(PARTITION BY s.customer_id ORDER BY s.order_date) AS rnk
    FROM dannys_diner.sales AS s
    JOIN dannys_diner.members AS mem
        ON s.customer_id = mem.customer_id
        AND s.order_date > mem.join_date
    JOIN dannys_diner.menu AS m
        ON s.product_id = m.product_id
    ORDER BY 1
)

SELECT customer_id, product_name
FROM first_order_memb
WHERE rnk = 1;

-- 7. Which item was purchased just before the customer became a member?

WITH b4_order_memb AS (
    SELECT s.customer_id, s.product_id, s.order_date,
        ROW_NUMBER() OVER(PARTITION BY s.customer_id ORDER BY s.order_date DESC) AS rnum
    FROM dannys_diner.sales AS s
    JOIN dannys_diner.members AS mem
        ON s.customer_id = mem.customer_id
        AND s.order_date < mem.join_date
)

SELECT b.customer_id, m.product_name
FROM b4_order_memb AS b
JOIN dannys_diner.menu AS m
  ON b.product_id = m.product_id
WHERE b.rnum = 1
ORDER BY 1;


-- 8. What is the total items and amount spent for each member before they became a member?



-- 9. If each $1 spent equates to 10 points and sushi has a 2x points multiplier — how many points would each customer have?


-- 10. In the first week after a customer joins the program (including their join date) they earn 2x points on all items, not just sushi — how many points do customer A and B have at the end of January?


-- Bonus Questions
    -- Join All The table columns with: customer_id, order_date, product_name, price, member (Y/N)

SELECT s.customer_id, s.order_date, m.product_name, m.price,
    CASE 
    WHEN mem.join_date <= s.order_date THEN 'Y'
    ELSE 'N'
    END AS member_status
FROM dannys_diner.sales AS s
LEFT JOIN dannys_diner.members AS mem
  ON s.customer_id = mem.customer_id
JOIN dannys_diner.menu AS m
  ON s.product_id = m.product_id
ORDER BY mem.customer_id, s.order_date;


    -- Rank All The Things
    /*
        Danny also requires further information about the ranking of customer products,
        but he purposely does not need the ranking for non-member purchases
        so he expects null ranking values for the records when customers are not yet part of the loyalty program.
    */

WITH customers_data AS (
    SELECT s.customer_id, s.order_date,  m.product_name, m.price,
    CASE
        WHEN mem.join_date <= s.order_date THEN 'Y'
        ELSE 'N' END AS member_status
    FROM dannys_diner.sales AS s
    LEFT JOIN dannys_diner.members AS mem
        ON s.customer_id = mem.customer_id
    JOIN dannys_diner.menu AS m
        ON s.product_id = m.product_id
)

SELECT *, CASE WHEN member_status = 'N' then NULL
  ELSE RANK () OVER (PARTITION BY customer_id, member_status ORDER BY order_date)
  END AS ranking
FROM customers_data;