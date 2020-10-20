![Geekbrains Logo](https://github.com/ilyastartsdata/introductiontopython/blob/master/gb.png)

# Final project

Course from Geekbrains University

> About Geekbrains: We teach people to master programming, web design and marketing from the ground up. We conduct online courses with internships and free master classes, develop the community, cooperate with employment companies and continuously test new methods to improve the effectiveness of learning.

## Requirements

1. Draw up a general text description of the database and the tasks to be performed by it
2. Minimum number of tables - 10
3. Database structure creation scripts (with primary keys, indexes, external keys)
4. Create ERDiagram for DB
5. Scripts for filling the database with data
6. Characteristic sample scripts (including groupings, JOIN, nested tables)
7. Views (minimum 2)
8. Stored procedures / triggers

### Files in repository

- [structure_en.sql](https://github.com/ilyastartsdata/databases_sql/blob/main/final_project/final_project_en/structure_en.sql) -> Database and table creation
- [data_en.sql](https://github.com/ilyastartsdata/databases_sql/blob/main/final_project/final_project_en/data_en.sql) -> Adding data to tables
- [views.sql](https://github.com/ilyastartsdata/databases_sql/blob/main/final_project/final_project_en/views_en.sql) -> Creation of views
- [procedures_triggers_en.sql](https://github.com/ilyastartsdata/databases_sql/blob/main/final_project/final_project_en/procedures_triggers_en.sql) -> Creation of procedures and triggers
- [stockx_dump_en.sql](https://github.com/ilyastartsdata/databases_sql/blob/main/final_project/final_project_en/stockx_dump_en.sql) -> Dump

## Project topic

### StockX

The final project is a database for an online trading site. 

In this case it is akin to the well-known stockX platform, which acts as a kind of exchange for the following categories of goods: sneakers, streetwear, collectibles, bags and watches.

Several links:

1. https://stockx.com - company website
2. https://en.wikipedia.org/wiki/StockX - Wikipedia
3. https://www.indigo9digital.com/blog/stockxgrowth

## ERDiagram

![ERD](https://github.com/ilyastartsdata/databases_sql/blob/main/final_project/final_project_ru/stockX_ERD.png)

## List of tables

- users
- products
- product_review
- category
- product_category
- tag
- product_tag
- order
- order_item
- transaction
- brand
- brand_product

## Table structure

### users

```js
`id` BIGINT NOT NULL AUTO_INCREMENT
`first_name` VARCHAR(100) NULL DEFAULT NULL 	// Name
`last_name` VARCHAR(100) NULL DEFAULT NULL 	// Last name
`phone` BIGINT UNSIGNED UNIQUE 			// A phone number that must be unique
`email` VARCHAR(100) UNIQUE 			// An email that has to be unique
`password` VARCHAR(100) UNIQUE 			// Password that should not be stored here
`buyer` TINYINT(1) NOT NULL DEFAULT 1 		// Standard user role on the site - buyer
`seller` TINYINT(1) NOT NULL DEFAULT 0 		// Role to which the user may apply
`created_at` DATETIME DEFAULT NOW() 		// Timestamp of creating a record
`intro` TINYTEXT NULL DEFAULT NULL 		// A small description to be filled in by the user
`profile` TEXT NULL DEFAULT NULL 		// Full-fledged user profile
```

### products

```js
`id` BIGINT NOT NULL AUTO_INCREMENT
`user_id` BIGINT NOT NULL                         // id, which is linked to the users table
`name` VARCHAR(100) NOT NULL                      // Name of the product
`summary` TINYTEXT NULL                           // Small product description
`price` FLOAT NOT NULL DEFAULT 0                  // Price of goods
`discount` FLOAT NOT NULL                         // Discount
`quantity` SMALLINT(6) NOT NULL DEFAULT 0         // Quantity
`created_at` DATETIME DEFAULT NOW()               // Timestamp of creation of a product position
`updated_at` DATETIME ON UPDATE CURRENT_TIMESTAMP // Timestamp of change in commodity position
`content` TEXT NULL DEFAULT NULL                  // Retaining additional information about the product
`review_id` BIGINT NOT NULL                       // id, which is linked to the review table
`brand_id` BIGINT NOT NULL                        // id, which is linked to the brand table
`product_category_id` BIGINT NOT NULL             // id, which is linked to the product_category table
```

### product_review

```js
`id` BIGINT NOT NULL AUTO_INCREMENT
`product_id` BIGINT NOT NULL              // id, which is linked to the products table
`user_id` BIGINT NOT NULL                 // id, which is linked to the users table
`title` VARCHAR(100) NOT NULL	           // Title of the review
`rating` SMALLINT(6) NOT NULL DEFAULT 0	  // Rating
`created_at` DATETIME DEFAULT NOW()       // Timestamp of review creation
`content` TEXT NULL DEFAULT NULL          // Content of the review
```

### category

```js
`id` BIGINT NOT NULL AUTO_INCREMENT
`title` VARCHAR(50) NOT NULL          // Title of category
`content` TEXT NULL DEFAULT NULL      // Contents of category
```

### product_category

```js
`product_id` BIGINT NOT NULL	// id, which is linked to the products table
`category_id` BIGINT NOT NULL	// id, which is linked to the category table
```

### tag

```js
`id` BIGINT NOT NULL AUTO_INCREMENT
`title` VARCHAR(50) NOT NULL        // Tag name
`content` TEXT NULL DEFAULT NULL    // Tag content
```

### product_tag

```js
`product_id` BIGINT NOT NULL  // id, which is linked to the products table
`tag_id` BIGINT NOT NULL      // id, which is linked to the tag table
```

### order

```js
`id` BIGINT NOT NULL AUTO_INCREMENT
`user_id` BIGINT NULL DEFAULT NULL        // id, which is linked to the users table
`status_order` VARCHAR(20) DEFAULT NULL   // Order status
`sub_total` FLOAT NOT NULL DEFAULT 0      // Intermediate order amount
`item_discount` FLOAT NOT NULL DEFAULT 0  // Discount on product
`tax` FLOAT NOT NULL DEFAULT 0            // Tax
`shipping` FLOAT NOT NULL DEFAULT 0       // Cost of shipment
`total` FLOAT NOT NULL DEFAULT 0          // Final order amount
`created_at` DATETIME DEFAULT NOW()       // Timestamp of order creation
```

### order_item

```js
`id` BIGINT NOT NULL AUTO_INCREMENT
`product_id` BIGINT NOT NULL                        // id, which is linked to the products table
`order_id` BIGINT NOT NULL                          // id, which is linked to the orders table
`price` FLOAT NOT NULL DEFAULT 0                    // Price of product
`discount` FLOAT NOT NULL DEFAULT 0                 // Discount on product
`quantity` SMALLINT(6) NOT NULL DEFAULT 0           // Quantity of product
`created_at` DATETIME DEFAULT NOW()                 // Timestamp of creation of a product position
`updated_at` DATETIME ON UPDATE CURRENT_TIMESTAMP   // Timestamp of change in product position
```

### transaction

```js
`id` BIGINT NOT NULL AUTO_INCREMENT
`user_id` BIGINT NOT NULL                         // id, which is linked to the users table	
`order_id` BIGINT NOT NULL                        // id, which is linked to the orders table
`type` TINYINT(1) NOT NULL DEFAULT 0              // Type of payment: Credit(0) or Debit(1)
`mode` SMALLINT(6) NOT NULL DEFAULT 0             // Payment mode: Offline, Cash on Delivery, Cheque, Draft, Wired and Online
`status_payment` SMALLINT(8) NOT NULL DEFAULT 0   // Payment status: New, Cancelled, Failed, Pending, Declined, Rejected, Success
`created_at` DATETIME DEFAULT NOW()               // Timestamp of transaction creation
`updated_at` DATETIME ON UPDATE CURRENT_TIMESTAMP // Timestamp of change in the transaction
```

### brand

```js
`id` BIGINT NOT NULL AUTO_INCREMENT
`name` VARCHAR(100) NOT NULL        // Brand name
```

### brand_product

```js
`product_id` BIGINT NOT NULL  // id, which is linked to the product table
`brand_id` BIGINT NOT NULL    // id, which is linked to the brand table
```

## Contributing

Pull requests are welcome.

## Source

- [Geekbrains](https://geekbrains.ru)
- [StockX](https://stockx.com)
- [FillDB](http://filldb.info)
