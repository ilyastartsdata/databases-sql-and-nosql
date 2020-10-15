-- Practical assignment on the topic "Transactions, variables, representations".

-- Task 1: The same tables, the same training database, are present in the shop and sample databases. 
-- Move the id = 1 entry from the shop.users table to the tab.лицу sample.users. Use transactions.

DROP DATABASE IF EXISTS `sample`;
CREATE DATABASE `sample`;
USE `sample`;

DROP TABLE IF EXISTS `users`;
CREATE TABLE `users`(
	`id` INT(11) NOT NULL AUTO_INCREMENT PRIMARY KEY,
	`name` VARCHAR(45) NOT NULL,
	`birthday_at` DATE DEFAULT NULL,
	`created_at` DATETIME DEFAULT CURRENT_TIMESTAMP,
	`updated_at` DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

SELECT * FROM `users`;

START TRANSACTION;
INSERT INTO `sample.users` SELECT * FROM `shop_online.users` WHERE `id` = 1;
COMMIT;

SELECT * FROM `users`;


-- Task 2: Create a view that displays the name of a product item from the products table and the corresponding catalogue name from the catalogues table.

USE `shop_online`;
CREATE OR REPLACE VIEW `prods_desc`(`prod_id`, `prod_name`, `cat_name`) AS
SELECT `p.id` AS `prod_id`, `p.name`, `cat.name`
FROM `products` AS `p`
LEFT JOIN `catalogs` AS `cat` 
ON `p.catalog_id` = `cat.id`;

SELECT * FROM `prods_desc`;


-- Practical task on the topic "MySQL Administration"

-- Task 1: Create two users who have access to the shop database. 
-- The first shop_read user should have access only to data reading requests, the second shop user should have access to any operations within the shop database.

-- shop_read data reading requests
DROP USER IF EXISTS 'shop_reader'@'localhost';
CREATE USER 'shop_reader'@'localhost' IDENTIFIED WITH sha256_password BY '123';
GRANT SELECT ON `shop_online.*` TO 'shop_reader'@'localhost';

-- testing
INSERT INTO `catalogs`(`name`)
 -- denied for this user
VALUES('New catalog');
 -- success
SELECT * FROM `catalogs`;

-- shop all operations
DROP USER IF EXISTS 'shop'@'localhost';
CREATE USER 'shop'@'localhost' IDENTIFIED WITH sha256_password BY '123';
GRANT ALL ON `shop_online.*` TO 'shop'@'localhost';
GRANT GRANT OPTION ON `shop_online.*` TO 'shop'@'localhost';

-- testing
INSERT INTO `catalogs`(`name`)
 -- success
VALUES('New catalog');
 -- have new catalog
SELECT * FROM `catalogs`;



-- Practical task on the topic "Stored procedures and functions, triggers".

-- Task 1: Create a stored hello() function that will return the greeting, depending on the current time of day. 
-- From 6:00 to 12:00 the function must return the phrase "Good morning", from 12:00 to 18:00 the function must return the phrase "Good afternoon", с 18:00 до 00:00 — "Good evening", с 00:00 до 6:00 — "Good night".

DROP PROCEDURE IF EXISTS hello;
delimiter //
CREATE PROCEDURE hello()
BEGIN
	CASE 
		WHEN CURTIME() BETWEEN '06:00:00' AND '12:00:00' THEN
			SELECT 'Good morning';
		WHEN CURTIME() BETWEEN '12:00:00' AND '18:00:00' THEN
			SELECT 'Good afternoon';
		WHEN CURTIME() BETWEEN '18:00:00' AND '00:00:00' THEN
			SELECT 'Good evening';
		ELSE
			SELECT 'Good might';
	END CASE;
END //
delimiter ;

CALL hello();

-- Task 2: The product table has two text fields: name with the product name and description with the product description. 
-- The presence of both fields or one of them is allowed. The situation where both fields take an undefined NULL value is unacceptable. Use triggers to ensure that one or both of these fields are filled in. 
-- When trying to assign a NULL value to fields, you must cancel the operation.

DROP TRIGGER IF EXISTS nullTrigger;
delimiter //
CREATE TRIGGER nullTrigger BEFORE INSERT ON `products`
FOR EACH ROW
BEGIN
	IF(ISNULL(NEW.`name`) AND ISNULL(NEW.`description`)) THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Trigger Warning! NULL in both fields!';
	END IF;
END //
delimiter ;

INSERT INTO `products` (`name`, `description`, `price`, `catalog_id`)
VALUES (NULL, NULL, 5000, 2); -- Trigger

INSERT INTO `products` (`name`, `description`, `price`, `catalog_id`)
VALUES ("GeForce GTX 1080", NULL, 5000, 2); -- Done

INSERT INTO `products` (`name`, `description`, `price`, `catalog_id`)
VALUES ("GeForce GTX 1080", "Мощная видеокарта", 15000, 2); -- Done


