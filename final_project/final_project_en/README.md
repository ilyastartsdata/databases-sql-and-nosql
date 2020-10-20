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
`product_id` BIGINT NOT NULL              // id, который связывается с таблицей products
`user_id` BIGINT NOT NULL                 // id, который связывается с таблицей users
`title` VARCHAR(100) NOT NULL	           // Название отзыва
`rating` SMALLINT(6) NOT NULL DEFAULT 0	  // Оценка отзыва
`created_at` DATETIME DEFAULT NOW()       // Момент создания отзыва
`content` TEXT NULL DEFAULT NULL          // Содержание отзыва
```

### category

```js
`id` BIGINT NOT NULL AUTO_INCREMENT
`title` VARCHAR(50) NOT NULL          // Название категории
`content` TEXT NULL DEFAULT NULL      // Содержание категории
```

### product_category

```js
`product_id` BIGINT NOT NULL	// id, который связывается с таблицей products
`category_id` BIGINT NOT NULL	// id, который связывается с таблицей category
```

### tag

```js
`id` BIGINT NOT NULL AUTO_INCREMENT
`title` VARCHAR(50) NOT NULL        // Название тэга
`content` TEXT NULL DEFAULT NULL    //Содержание тэга
```

### product_tag

```js
`product_id` BIGINT NOT NULL  // id, который связывается с таблицей products
`tag_id` BIGINT NOT NULL      // id, который связывается с таблицей tag
```

### order

```js
`id` BIGINT NOT NULL AUTO_INCREMENT
`user_id` BIGINT NULL DEFAULT NULL        // id, который связывается с таблицей users
`status_order` VARCHAR(20) DEFAULT NULL   // Статус заказа
`sub_total` FLOAT NOT NULL DEFAULT 0      // Промежуточная сумма заказа
`item_discount` FLOAT NOT NULL DEFAULT 0  // Скидка на товар
`tax` FLOAT NOT NULL DEFAULT 0            // Налог
`shipping` FLOAT NOT NULL DEFAULT 0       // Стоимость отправки
`total` FLOAT NOT NULL DEFAULT 0          // Финальная сумма заказа
`created_at` DATETIME DEFAULT NOW()       // Момент создания заказа
```

### order_item

```js
`id` BIGINT NOT NULL AUTO_INCREMENT
`product_id` BIGINT NOT NULL                        // id, который связывается с таблицей products
`order_id` BIGINT NOT NULL                          // id, который связывается с таблицей orders
`price` FLOAT NOT NULL DEFAULT 0                    // Стоимость товара
`discount` FLOAT NOT NULL DEFAULT 0                 // Скидка на товар
`quantity` SMALLINT(6) NOT NULL DEFAULT 0           // Количество товара
`created_at` DATETIME DEFAULT NOW()                 // Момент создания товарной позиции
`updated_at` DATETIME ON UPDATE CURRENT_TIMESTAMP   // Момент изменения товарной позиции
```

### transaction

```js
`id` BIGINT NOT NULL AUTO_INCREMENT
`user_id` BIGINT NOT NULL                         // id, который связывается с таблицей users	
`order_id` BIGINT NOT NULL                        // id, который связывается с таблицей orders
`type` TINYINT(1) NOT NULL DEFAULT 0              // Тип оплаты: Credit(0) или Debit(1)
`mode` SMALLINT(6) NOT NULL DEFAULT 0             // Способ оплаты: Offline, Cash on Delivery, Cheque, Draft, Wired and Online
`status_payment` SMALLINT(8) NOT NULL DEFAULT 0   // Статус оплаты: New, Cancelled, Failed, Pending, Declined, Rejected, Success
`created_at` DATETIME DEFAULT NOW()               // Момент создания транзакции
`updated_at` DATETIME ON UPDATE CURRENT_TIMESTAMP // Момент изменения транзакции
```

### brand

```js
`id` BIGINT NOT NULL AUTO_INCREMENT
`name` VARCHAR(100) NOT NULL        // Название бренда
```

### brand_product

```js
`product_id` BIGINT NOT NULL  // id, который связывается с таблицей product
`brand_id` BIGINT NOT NULL    // id, который связывается с таблицей brand
```

## Contributing

Pull requests are welcome.

## Source

- [Geekbrains](https://geekbrains.ru)
- [StockX](https://stockx.com)
- [FillDB](http://filldb.info)
