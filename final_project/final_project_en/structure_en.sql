/* This script is responsible for creating the database structure and the tables included in it */

# Database creation

DROP DATABASE IF EXISTS stockx;
CREATE DATABASE stockx;

# Use of newly created database

USE stockx;

###############################################################################################################

# Creation of a user table where information about platform users will be stored

DROP TABLE IF EXISTS `users`;
CREATE TABLE `users` (
	`id` BIGINT NOT NULL AUTO_INCREMENT,
	`first_name` VARCHAR(100) NULL DEFAULT NULL, 	-- Name
	`last_name` VARCHAR(100) NULL DEFAULT NULL, 	-- Last name
	`phone` BIGINT UNSIGNED UNIQUE, 				-- A phone number that must be unique
	`email` VARCHAR(100) UNIQUE, 					-- An email that has to be unique
	`password` VARCHAR(100) UNIQUE, 				-- Password that should not be stored here
	`buyer` TINYINT(1) NOT NULL DEFAULT 1, 			-- Standard user role on the site - buyer
	`seller` TINYINT(1) NOT NULL DEFAULT 0, 		-- Role to which the user may apply
	`created_at` DATETIME DEFAULT NOW(), 			-- Timestamp of creating a record
	`intro` TINYTEXT NULL DEFAULT NULL, 			-- A small description to be filled in by the user
	`profile` TEXT NULL DEFAULT NULL, 				-- Full-fledged user profile
	PRIMARY KEY (`id`),
	UNIQUE KEY `user_phone` (`phone`),
	UNIQUE KEY `user_email` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

# Creation of a product table that will store information about the product items on the platform

DROP TABLE IF EXISTS `products`;
CREATE TABLE `products` (
	`id` BIGINT NOT NULL AUTO_INCREMENT,
	`user_id` BIGINT NOT NULL,						-- id, which is linked to the users table
	`name` VARCHAR(100) NOT NULL,					-- Name of the product
	`summary` TINYTEXT NULL,						-- Small product description
	`price` FLOAT NOT NULL DEFAULT 0,				-- Pride of goods
	`discount` FLOAT NOT NULL,						-- Discount
	`quantity` SMALLINT(6) NOT NULL DEFAULT 0,		-- Quantity
	`created_at` DATETIME DEFAULT NOW(),			-- Timestamp of creation of a product position
	`updated_at` DATETIME ON UPDATE CURRENT_TIMESTAMP, -- Timestamp of change in product position
	`content` TEXT NULL DEFAULT NULL,				-- Retaining additional information about the product
	`review_id` BIGINT NOT NULL,					-- id, which is linked to the review table
	`brand_id` BIGINT NOT NULL,						-- id, which is linked to the brand table
	`product_category_id` BIGINT NOT NULL,			-- id, which is linked to the product_category table
	PRIMARY KEY (`id`),
	INDEX `product_user` (`user_id`),
	FOREIGN KEY (`user_id`) REFERENCES `users`(`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

# Creation of a product review table that will contain user feedback on product items

DROP TABLE IF EXISTS `product_review`;
CREATE TABLE `product_review` (
	`id` BIGINT NOT NULL AUTO_INCREMENT,
	`product_id` BIGINT NOT NULL,					-- id, which is linked to the products table
	`user_id` BIGINT NOT NULL,						-- id, which is linked to the users table
	`title` VARCHAR(100) NOT NULL,					-- Title of the review
	`rating` SMALLINT(6) NOT NULL DEFAULT 0,		-- Rating
	`created_at` DATETIME DEFAULT NOW(),			-- Timestamp of review creation
	`content` TEXT NULL DEFAULT NULL,				-- Content of the review
	PRIMARY KEY (`id`),
	INDEX `review_product` (`product_id`),
	FOREIGN KEY (`product_id`) REFERENCES `products`(`id`),
	FOREIGN KEY (`user_id`) REFERENCES `users`(`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

# Creation of a category table where the table categories will be stored

DROP TABLE IF EXISTS `category`;
CREATE TABLE `category` (	
	`id` BIGINT NOT NULL AUTO_INCREMENT,
	`title` VARCHAR(50) NOT NULL,					-- Title of category
	`content` TEXT NULL DEFAULT NULL,				-- Contents of category
	PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

# Creation of a product category table, which will serve as a link between products and category

DROP TABLE IF EXISTS `product_category`;
CREATE TABLE `product_category` (
	`product_id` BIGINT NOT NULL,					-- id, which is linked to the products table
	`category_id` BIGINT NOT NULL,					-- id, which is linked to the category table
	FOREIGN KEY (`product_id`) REFERENCES `products`(`id`),
	FOREIGN KEY (`category_id`) REFERENCES `category`(`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

# Creating a tag table where tag information will be stored

DROP TABLE IF EXISTS `tag`;
CREATE TABLE `tag` (	
	`id` BIGINT NOT NULL AUTO_INCREMENT,
	`title` VARCHAR(50) NOT NULL,					-- Tag name
	`content` TEXT NULL DEFAULT NULL,				-- Tag content
	PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

# Creation of a product_tag table that will be the link between product and tag

DROP TABLE IF EXISTS `product_tag`;
CREATE TABLE `product_tag` (
	`product_id` BIGINT NOT NULL,					-- id, which is linked to the products table
	`tag_id` BIGINT NOT NULL,						-- id, which is linked to the tag table
	FOREIGN KEY (`product_id`) REFERENCES `products`(`id`),
	FOREIGN KEY (`tag_id`) REFERENCES `tag`(`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

# Creation of an order table in which user order information will be stored

DROP TABLE IF EXISTS `order`;
CREATE TABLE `order` (
	`id` BIGINT NOT NULL AUTO_INCREMENT,
	`user_id` BIGINT NULL DEFAULT NULL,				-- id, which is linked to the users table
	`status_order` VARCHAR(20) DEFAULT NULL,		-- Order status
	`sub_total` FLOAT NOT NULL DEFAULT 0,			-- Intermediate order amount
	`item_discount` FLOAT NOT NULL DEFAULT 0,		-- Discount on product
	`tax` FLOAT NOT NULL DEFAULT 0,					-- Tax
	`shipping` FLOAT NOT NULL DEFAULT 0,			-- Cost of shipment
	`total` FLOAT NOT NULL DEFAULT 0,				-- Final order amount
	`created_at` DATETIME DEFAULT NOW(),			-- Timestamp of order creation
	PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

# Creation of an order_item table, which will be the link between order and product

DROP TABLE IF EXISTS `order_item`;
CREATE TABLE `order_item` (
	`id` BIGINT NOT NULL AUTO_INCREMENT,
	`product_id` BIGINT NOT NULL,					-- id, which is linked to the products table
	`order_id` BIGINT NOT NULL,						-- id, which is linked to the orders table
	`price` FLOAT NOT NULL DEFAULT 0,				-- Price of product
	`discount` FLOAT NOT NULL DEFAULT 0,			-- Discount on product
	`quantity` SMALLINT(6) NOT NULL DEFAULT 0,		-- Quantity of product
	`created_at` DATETIME DEFAULT NOW(),			-- Timestamp of creation of a product position
	`updated_at` DATETIME ON UPDATE CURRENT_TIMESTAMP, -- Timestamp of change in product position
	PRIMARY KEY (`id`),
	FOREIGN KEY (`product_id`) REFERENCES `products`(`id`),
	FOREIGN KEY (`order_id`) REFERENCES `order`(`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

# Creation of a transaction table where information about transactions will be stored

DROP TABLE IF EXISTS `transaction`;
CREATE TABLE `transaction` (
	`id` BIGINT NOT NULL AUTO_INCREMENT,
	`user_id` BIGINT NOT NULL,						-- id, which is linked to the users table
	`order_id` BIGINT NOT NULL,						-- id, which is linked to the orders table
	`type` TINYINT(1) NOT NULL DEFAULT 0, 			-- Type of payment: Credit(0) or Debit(1)
	`mode` SMALLINT(6) NOT NULL DEFAULT 0, 			-- Payment mode: Offline, Cash on Delivery, Cheque, Draft, Wired and Online
	`status_payment` SMALLINT(8) NOT NULL DEFAULT 0, -- Payment status: New, Cancelled, Failed, Pending, Declined, Rejected, Success
	`created_at` DATETIME DEFAULT NOW(),			-- Timestamp of transaction creation
	`updated_at` DATETIME ON UPDATE CURRENT_TIMESTAMP, -- Timestamp of change in the transaction
	PRIMARY KEY (`id`),
	FOREIGN KEY (`user_id`) REFERENCES `users`(`id`),
	FOREIGN KEY (`order_id`) REFERENCES `order`(`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

# Creation of a brand table that will contain information about product brands

DROP TABLE IF EXISTS `brand`;
CREATE TABLE `brand` (
	`id` BIGINT NOT NULL AUTO_INCREMENT,
	`name` VARCHAR(100) NOT NULL,					-- Brand name
	PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

# Creation of a brand_product table, which is the link between the product and brand

DROP TABLE IF EXISTS `brand_product`;
CREATE TABLE `brand_product` (
	`product_id` BIGINT NOT NULL,					-- id, which is linked to the product table
	`brand_id` BIGINT NOT NULL,						-- id, which is linked to the brand table
	FOREIGN KEY (`product_id`) REFERENCES `products`(`id`),
	FOREIGN KEY (`brand_id`) REFERENCES `brand`(`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
