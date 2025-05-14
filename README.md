# E-commerce Database SQL

This repository contains SQL scripts for creating and managing a simple e-commerce database system. The database includes tables for customers, products, orders, and order items, along with sample data and common queries.

## Database Schema

### Tables

1. **customers**
   - `id`: Primary key
   - `name`: Customer's full name
   - `email`: Unique email address
   - `address`: Shipping address

2. **products**
   - `id`: Primary key
   - `name`: Product name
   - `price`: Product price
   - `description`: Product description
   - `discount`: Discount amount (default: 0.00)

3. **orders**
   - `id`: Primary key
   - `customer_id`: Foreign key referencing customers
   - `order_date`: Date of order
   - `total_amount`: Total order amount

4. **order_items**
   - `id`: Primary key
   - `order_id`: Foreign key referencing orders
   - `product_id`: Foreign key referencing products
   - `quantity`: Number of items ordered
   - `unit_price`: Price per unit

## Sample Queries

The database includes several example queries:

1. Find customers who placed orders in the last 30 days
2. Calculate total spending per customer
3. List top 3 most expensive products
4. Find customers who ordered a specific product
5. View order dates for each customer
6. List orders with total amount over $150
7. Calculate average order total

## Sample Data

The database comes pre-populated with:
- 3 customers
- 5 products with varying prices
- 4 orders
- 4 order items

## Usage

1. Connect to MySQL:
   ```bash
   mysql -u root
   ```

2. Execute the SQL file:
   ```bash
   source ecommerce.sql
   ```

3. Start querying the database:
   ```sql
   USE ecommerce;
   SHOW TABLES;
   ```

## Features

- Normalized database design
- Foreign key constraints for data integrity
- Sample data for testing
- Common e-commerce queries
- Product discount support

## Requirements

- MySQL Server
- Command-line interface or MySQL client