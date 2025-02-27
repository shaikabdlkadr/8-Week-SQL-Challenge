# The given tables are - 

 - Sales Table → Customer_id, Order_data and Product_id
 - Menu Table → Product_id, Product_name, price
 - Members Table → Customer_id, Join_date

# Each of the following case study questions can be answered using a single SQL statement:

* What is the total amount each customer spent at the restaurant?

* How many days has each customer visited the restaurant?

* What was the first item from the menu purchased by each customer?

* What is the most purchased item on the menu and how many times was it purchased by all customers?

* Which item was the most popular for each customer?

* Which item was purchased first by the customer after they became a member?

* Which item was purchased just before the customer became a member?

* What is the total items and amount spent for each member before they became a member?

* If each $1 spent equates to 10 points and sushi has a 2x points multiplier - how many points would each customer have?

* In the first week after a customer joins the program (including their join date) they earn 2x points on all items, not just sushi - how many points do customer A and B have at the end of January?


### Bonus Questions to Solve:

- Join All The tables to create a new table with the following columns as : customer_id, order_date, product_name, price, member (Y/N)

Output should be like below :

#### Joined all the Data Table

| customer_id | order_date  | product_name | price | member |
|------------|------------|--------------|-------|--------|
| A          | 2021-01-01 | sushi        | 10    | N      |
| A          | 2021-01-01 | curry        | 15    | N      |
| A          | 2021-01-07 | curry        | 15    | Y      |
| A          | 2021-01-10 | ramen        | 12    | Y      |
| A          | 2021-01-11 | ramen        | 12    | Y      |
| A          | 2021-01-11 | ramen        | 12    | Y      |
| B          | 2021-01-01 | curry        | 15    | N      |
| B          | 2021-01-02 | curry        | 15    | N      |
| B          | 2021-01-04 | sushi        | 10    | N      |
| B          | 2021-01-11 | sushi        | 10    | Y      |
| B          | 2021-01-16 | ramen        | 12    | Y      |
| B          | 2021-02-01 | ramen        | 12    | Y      |
| C          | 2021-01-01 | ramen        | 12    | N      |
| C          | 2021-01-01 | ramen        | 12    | N      |
| C          | 2021-01-07 | ramen        | 12    | N      |


- Rank All The Things
    - Danny also requires further information about the ranking of customer products, but he purposely does not need the ranking for non-member purchases so he expects null ranking values for the records when customers are not yet part of the loyalty program.

Output should be like below :

#### Ranked all the things

| customer_id | order_date  | product_name | price | member | ranking |
|------------|------------|--------------|-------|--------|---------|
| A          | 2021-01-01 | sushi        | 10    | N      | NULL    |
| A          | 2021-01-01 | curry        | 15    | N      | NULL    |
| A          | 2021-01-07 | curry        | 15    | Y      | 1       |
| A          | 2021-01-10 | ramen        | 12    | Y      | 2       |
| A          | 2021-01-11 | ramen        | 12    | Y      | 3       |
| A          | 2021-01-11 | ramen        | 12    | Y      | 3       |
| B          | 2021-01-01 | curry        | 15    | N      | NULL    |
| B          | 2021-01-02 | curry        | 15    | N      | NULL    |
| B          | 2021-01-04 | sushi        | 10    | N      | NULL    |
| B          | 2021-01-11 | sushi        | 10    | Y      | 1       |
| B          | 2021-01-16 | ramen        | 12    | Y      | 2       |
| B          | 2021-02-01 | ramen        | 12    | Y      | 3       |
| C          | 2021-01-01 | ramen        | 12    | N      | NULL    |
| C          | 2021-01-01 | ramen        | 12    | N      | NULL    |
| C          | 2021-01-07 | ramen        | 12    | N      | NULL    |

