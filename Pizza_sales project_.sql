-- Retrieve the total number of orders placed.


select count(order_id) from orders

order by count(order_id);

-- Calculate the total revenue generated from pizza sales.

select
sum(order_details.quantity * pizzas.price) as total_sale
from order_details join pizzas
on pizzas.pizza_id = order_details.pizza_id;

-- Identify the highest-priced pizza.

select pizza_types.name, pizzas.price
from pizza_types join pizzas
on pizza_types.pizza_type_id = pizzas.pizza_type_id
order by pizzas.price desc limit 1;

-- Identify the most common pizza size ordered.

SELECT 
    pizzas.size,
    COUNT(order_details.order_details_id) AS order_detailss
FROM
    pizzas
        JOIN
    order_details ON pizzas.pizza_id = order_details.pizza_id
GROUP BY pizzas.size
ORDER BY order_detailss DESC
LIMIT 1;

-- List the top 5 most ordered pizza types along with their quantities.

SELECT 
    pizza_types.name, SUM(order_details.quantity) AS order_count
FROM
    pizza_types
        JOIN
    pizzas ON pizza_types.pizza_type_id = pizzas.pizza_type_id
        JOIN
    order_details ON order_details.pizza_id = pizzas.pizza_id
GROUP BY pizza_types.name;

-- Find the total quantity of each pizza category ordered 


select pizza_types.category, sum(order_details.quantity) as count
FROM pizza_types JOIN pizzas 
ON pizza_types.pizza_type_id = pizzas.pizza_type_id 
join order_details
ON order_details.pizza_id = pizzas.pizza_id
group by pizza_types.category order by count desc;

-- Determine the distribution of orders by hour of the day.

select hour(time), count(order_id) from orders
group by hour(time);

-- Find the category-wise distribution of pizzas (to understand customer behaviour)

select pizza_types.category, sum(order_details.quantity)
from pizza_types join pizzas
on pizza_types.pizza_type_id = pizzas.pizza_type_id
join order_details
on order_details.pizza_id = pizzas.pizza_id
group by pizza_types.category;

-- Group the orders by date and calculate the average number of pizzas ordered per day.
SELECT 
    AVG(order_detail)
FROM
    (SELECT 
        orders.date, SUM(order_details.quantity) AS order_detail
    FROM
        orders
    JOIN order_details ON orders.order_id = order_details.order_id
    GROUP BY orders.date) AS qual;
    
    -- Determine the top 3 most ordered pizza types based on revenue 


select pizza_types.name, sum(order_details.quantity * pizzas.price) as revenue
from pizza_types join pizzas
on pizza_types.pizza_type_id = pizzas.pizza_type_id
join order_details
on order_details.pizza_id = pizzas.pizza_id
group by pizza_types.name order by revenue desc limit 3;