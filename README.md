# SQL Analysis of Pizza Orders
Under the guidance of [Mentorness](https://www.linkedin.com/company/mentorness/)

# Overview
The main aim of this project is to analyze pizza sales to gain insights into customer behaviour, popular pizza types, sales trends and overall performance.

The analysis was performed on the these table:

 - [**Order details**](/Dataset/order_details.csv)
    - **order_details_id**: Unique identifier for the order detail. 
    - **order_id**: Identifier linking to the orders table. 
    - **pizza_id**: Identifier linking to the pizza table. 
    - **quantity**: Number of pizzas ordered. 
 
 - [**Orders**](/Dataset/orders.csv)
    - **order_id**: Unique identifier for the order.
    - **date**: Date the order was placed.
    - **time**: Time the order was placed.

 - [**Pizza Type**](/Dataset/pizza_types.csv)
    - **pizza_type_id**: Unique identifier for the pizza type. 
    - **name**: Name of the pizza. 
    - **category**: Category of the pizza(vegetarian, meat, etc.) 
    - **ingredients**: List of ingredients used in the pizza. 

 - [**Pizzas**](/Dataset/pizzas.csv)
    - **pizza_id**: Unique identifier for the pizza.
    - **pizza_type_id**: Identifier linking to the pizza_type table. 
    - **size**: Size of the pizza (e.g., small, medium, large).  price: Price of the pizza. 
