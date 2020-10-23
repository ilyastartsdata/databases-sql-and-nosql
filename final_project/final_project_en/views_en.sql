/* This script is responsible for sample requests and views */

# Use of database

USE stockx;

###############################################################################################################

-- A view where prices (price) that are higher than the average are displayed

CREATE OR REPLACE VIEW `expensive_products` AS
SELECT `name`, `price`
FROM `products` AS `p`
WHERE `price` > (SELECT AVG(`price`) FROM `products`);

-- Check

SELECT * FROM `expensive_products`;

-- A view where the value of each seller's goods and the number of units are displayed

CREATE OR REPLACE VIEW `seller_info` AS
SELECT `u`.`first_name`, `u`.`last_name`, SUM(`p`.`price`) AS `lager_value`, SUM(`p`.`quantity`) AS `lager_quantity`
FROM `users` `u`
INNER JOIN `products` `p` ON `u`.`id` = `p`.`user_id`
GROUP BY `u`.`id`;

-- Check

SELECT * FROM `seller_info`;

-- View where the value of the top 3 brands on site is displayed

CREATE OR REPLACE VIEW `top_brands` AS
SELECT `b`.`name` AS `brand_name`, SUM(`p`.`price`) AS `value`
FROM `brand_product` `bp`
LEFT JOIN `brand` `b` ON `bp`.`brand_id` = `b`.`id`
RIGHT JOIN `products` `p` ON `bp`.`product_id` = `p`.`brand_id`
GROUP BY `b`.`name`
ORDER BY `value` DESC
LIMIT 3;

-- Check

SELECT * FROM `top_brands`;