-- Task 1: Create a list of users who have placed at least one order at the internet shop.

SELECT 
	`u.id` AS `user_id`, `u.name`,
	`o.id` AS `order_id`
FROM
	`users` AS `u`
RIGHT JOIN
	`orders` AS `o`
ON
	`u.id` = `o.user_id`;
  
-- Task 2: Output the list of products and sections of catalogs that correspond to the product.

SELECT
	`p.id`, `p.name`, `p.price`,
	`c.id` AS `cat_id`,
	`c.name` AS `catalog`
FROM
	`products` AS `p`
JOIN
	`catalogs` AS `c`
ON
	`p.catalog_id` = `c.id`;
  
-- Task 3: (optional) Let there be a flight table (id, from, to) and a table of cities (label, name).
-- The fields from, to and label contain English city names, the field name is Russian. Print the list of flights with Russian names of cities.

-- Preparation of data for further assignment

-- CREATE TABLE IF NOT EXISTS `flights`(
-- 	`id` SERIAL PRIMARY KEY,
-- 	`from` VARCHAR(50) NOT NULL COMMENT 'en', 
-- 	`to` VARCHAR(50) NOT NULL COMMENT 'en'
-- );

-- CREATE TABLE IF NOT EXISTS `cities`(
-- 	`label` VARCHAR(50) PRIMARY KEY COMMENT 'en', 
-- 	`name` VARCHAR(50) COMMENT 'ru'
-- );

-- ALTER TABLE `flights`
-- ADD CONSTRAINT `fk_from_label`
-- FOREIGN KEY(`from`)
-- REFERENCES `cities`(`label`);

-- ALTER TABLE `flights`
-- ADD CONSTRAINT `fk_to_label`
-- FOREIGN KEY(`to`)
-- REFERENCES `cities`(`label`);

-- INSERT INTO `cities` VALUES
-- 	('Moscow', 'Москва'),
-- 	('Saint Petersburg', 'Санкт-Петербург'),
-- 	('Omsk', 'Омск'),
-- 	('Tomsk', 'Томск'),
-- 	('Ufa', 'Уфа');

-- INSERT INTO `flights` VALUES
-- 	(NULL, 'Moscow', 'Saint Petersburg'),
-- 	(NULL, 'Saint Petersburg', 'Omsk'),
-- 	(NULL, 'Omsk', 'Tomsk'),
-- 	(NULL, 'Tomsk', 'Ufa'),
-- 	(NULL, 'Ufa', 'Moscow');

-- Task solution

SELECT
	`id` AS `flight_id`,
	(SELECT `name` FROM `cities` WHERE `label` = `from`) AS `from`,
	(SELECT `name` FROM `cities` WHERE `label` = `to`) AS `to`
FROM
	`flights`
ORDER BY 
	`flight_id`;
