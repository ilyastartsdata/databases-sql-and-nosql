/* This script is responsible for the stored procedures and triggers. */

# Use of database

USE stockx;

###############################################################################################################

# Procedures

-- A procedure that displays all products

DROP PROCEDURE IF EXISTS get_all_products;

DELIMITER //

CREATE PROCEDURE get_all_products()
BEGIN
	SELECT * FROM products;
END //

DELIMITER ;

-- Procedure check

CALL get_all_products;

-- Procedure that creates an additional table with product information (product pictures)

DROP PROCEDURE IF EXISTS create_table_images;

DELIMITER //

CREATE PROCEDURE create_table_images()
BEGIN
	DROP TABLE IF EXISTS `product_images`;
	CREATE TABLE `product_images` (
		`id` BIGINT NOT NULL AUTO_INCREMENT,
		`product_id` BIGINT NOT NULL,
		`link` VARCHAR(100) NOT NULL,
		PRIMARY KEY (`id`),
		FOREIGN KEY (`product_id`) REFERENCES `products`(`id`)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
	) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
END //

DELIMITER ;

-- Procedure check

CALL create_table_images();

-- A procedure that shows the most expensive goods (10)

DROP PROCEDURE IF EXISTS max_price_product;

DELIMITER //

CREATE PROCEDURE max_price_product()
BEGIN
	SELECT `name`, `price`, `summary`
	FROM `products`
	ORDER BY `price` DESC
	LIMIT 10;
END //

DELIMITER ;

-- Procedure check

CALL max_price_product();

###############################################################################################################

# Triggers

-- The idea is that the user has a standard role (1) when using the platform (values 1-0). If the user also uses (1), then values 1-1.
-- Checking that there is no 0-1 or 0-0 value.
-- Due to the uncritical nature of the audit, I use AFTER INSERT.

DROP TRIGGER IF EXISTS role_check;
DELIMITER $$
CREATE TRIGGER role_check AFTER INSERT ON `users`
FOR EACH ROW
BEGIN
	IF(((NEW.`buyer` = 0) AND (NEW.`seller` = 1)) OR ((NEW.`buyer` = 0) AND (NEW.`seller` = 0))) THEN 
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Trigger Warning! Please check the roles';
	END IF;
END $$
DELIMITER ;

-- Trigger check

INSERT INTO `users` (`id`, `first_name`, `last_name`, `phone`, `email`, `password`, `buyer`, `seller`, `created_at`, `intro`, `profile`)
VALUES ('51', 'Bartina', 'Niko', '125', 'max.gislason@example.net', '7a35e17a17eb7d913425ee80fbeb1a9301d31d', '0', '0', '2009-09-02 12:14:31', 'k', 'k'); -- Trigger, both roles have a value of 0

INSERT INTO `users` (`id`, `first_name`, `last_name`, `phone`, `email`, `password`, `buyer`, `seller`, `created_at`, `intro`, `profile`)
VALUES ('51', 'Bartina', 'Niko', '125', 'max.gislason@example.net', '7a35e17a17eb7d913425ee80fbeb1a9301d31d', '0', '1', '2009-09-02 12:14:31', 'k', 'k'); -- Trigger, value 0-1

INSERT INTO `users` (`id`, `first_name`, `last_name`, `phone`, `email`, `password`, `buyer`, `seller`, `created_at`, `intro`, `profile`)
VALUES ('51', 'Bartina', 'Niko', '125', 'max.gislason@example.net', '7a35e17a17eb7d913425ee80fbeb1a9301d31d', '1', '0', '2009-09-02 12:14:31', 'k', 'k'); -- Everything has passed

-- Trigger that prevents the introduction of NULL into the brand table

DROP TRIGGER IF EXISTS null_in_brand;
DELIMITER $$
CREATE TRIGGER null_in_brand BEFORE INSERT ON `brand`
FOR EACH ROW
BEGIN
	IF(ISNULL(NEW.`id`) OR ISNULL(NEW.`name`)) THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Trigger Warning! Do not insert NULL, please!';
	END IF;
END $$
DELIMITER ;

-- Trigger check

INSERT INTO `brand` (`id`, `name`)
VALUES ('11', NULL); -- Trigger worked

INSERT INTO `brand` (`id`, `name`)
VALUES ('11', 'Gucci'); -- Everything has passed