/* Этот скрипт отвечает за хранимые процедуры и триггеры */

# Использование базы данных

USE stockx;

###############################################################################################################

# Процедуры

-- Процедура, которая выводит все товары

DROP PROCEDURE IF EXISTS get_all_products;

DELIMITER //

CREATE PROCEDURE get_all_products()
BEGIN
	SELECT * FROM products;
END //

DELIMITER ;

-- Проверка процедуры

CALL get_all_products;

-- Процедура, которая создает дополнительную таблицу с информацией о product (картинки товаров)

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

-- Проверка процедуры

CALL create_table_images();

-- Процедура, которая показывает наиболее дорогие товары (10)

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

-- Проверка процедуры

CALL max_price_product();

###############################################################################################################

# Триггеры

-- По задумке, пользователь имеет стандартную роль buyer (1), когда пользуется платформой (значения 1-0). В случае, если пользователь еще и seller (1), тогда значения 1-1.
-- Проверка, чтобы не было значения 0-1 или 0-0
-- Ввиду некритичности проверки, я использую AFTER INSERT

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

-- Проверка триггера

INSERT INTO `users` (`id`, `first_name`, `last_name`, `phone`, `email`, `password`, `buyer`, `seller`, `created_at`, `intro`, `profile`)
VALUES ('51', 'Bartina', 'Niko', '125', 'max.gislason@example.net', '7a35e17a17eb7d913425ee80fbeb1a9301d31d', '0', '0', '2009-09-02 12:14:31', 'k', 'k'); -- Tриггер, обе роли имеют значение 0

INSERT INTO `users` (`id`, `first_name`, `last_name`, `phone`, `email`, `password`, `buyer`, `seller`, `created_at`, `intro`, `profile`)
VALUES ('51', 'Bartina', 'Niko', '125', 'max.gislason@example.net', '7a35e17a17eb7d913425ee80fbeb1a9301d31d', '0', '1', '2009-09-02 12:14:31', 'k', 'k'); -- Триггер, значение 0-1

INSERT INTO `users` (`id`, `first_name`, `last_name`, `phone`, `email`, `password`, `buyer`, `seller`, `created_at`, `intro`, `profile`)
VALUES ('51', 'Bartina', 'Niko', '125', 'max.gislason@example.net', '7a35e17a17eb7d913425ee80fbeb1a9301d31d', '1', '0', '2009-09-02 12:14:31', 'k', 'k'); -- Все прошло

-- Триггер, который предотвращает внедрение NULL в таблицу brand

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

-- Проверка триггера

INSERT INTO `brand` (`id`, `name`)
VALUES ('11', NULL); -- Триггер сработал

INSERT INTO `brand` (`id`, `name`)
VALUES ('11', 'Gucci'); -- Все прошло
