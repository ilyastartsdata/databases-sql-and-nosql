/* Этот скрипт отвечает за скрипты характерных выборок и представления */

# Использование базы данных

USE stockx;

###############################################################################################################

-- Представление, где отображаются цены (price), которые больше среднего значения

CREATE OR REPLACE VIEW `expensive_products` AS
SELECT `name`, `price`
FROM `products` AS `p`
WHERE `price` > (SELECT AVG(`price`) FROM `products`);

-- Проверка

SELECT * FROM `expensive_products`;

-- Представление, где отображается стоимость товаров каждого из продавцов и количество единиц товара

CREATE OR REPLACE VIEW `seller_info` AS
SELECT `u`.`first_name`, `u`.`last_name`, SUM(`p`.`price`) AS `lager_value`, SUM(`p`.`quantity`) AS `lager_quantity`
FROM `users` `u`
INNER JOIN `products` `p` ON `u`.`id` = `p`.`user_id`
GROUP BY `u`.`id`;

-- Проверка

SELECT * FROM `seller_info`;

-- Представление, где отображается стоимость топ 3х брендов на площадке

CREATE OR REPLACE VIEW `top_brands` AS
SELECT `b`.`name` AS `brand_name`, SUM(`p`.`price`) AS `value`
FROM `brand_product` `bp`
LEFT JOIN `brand` `b` ON `bp`.`brand_id` = `b`.`id`
RIGHT JOIN `products` `p` ON `bp`.`product_id` = `p`.`brand_id`
GROUP BY `b`.`name`
ORDER BY `value` DESC
LIMIT 3;

-- Проверка

SELECT * FROM `top_brands`;