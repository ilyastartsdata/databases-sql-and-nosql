/* Этот скрипт отвечает за создание структуры базы данных и входящих в нее таблиц */

# Создание базы данных

DROP DATABASE IF EXISTS stockx;
CREATE DATABASE stockx;

# Использование только что созданной базы данных

USE stockx;

###############################################################################################################

# Создание таблицы users, в которой будет храниться информация о пользователях платформы

DROP TABLE IF EXISTS `users`;
CREATE TABLE `users` (
	`id` BIGINT NOT NULL AUTO_INCREMENT,
	`first_name` VARCHAR(100) NULL DEFAULT NULL, 	-- Имя
	`last_name` VARCHAR(100) NULL DEFAULT NULL, 	-- Фамилия
	`phone` BIGINT UNSIGNED UNIQUE, 				-- Номер телефона, который обязан быть уникальным
	`email` VARCHAR(100) UNIQUE, 					-- Имейл, который обязан быть уникальным
	`password` VARCHAR(100) UNIQUE, 				-- Пароль, который не стоило бы хранить тут
	`buyer` TINYINT(1) NOT NULL DEFAULT 1, 			-- Стандартная роль пользователя на сайте - покупатель
	`seller` TINYINT(1) NOT NULL DEFAULT 0, 		-- Роль, на которую пользователь может податься
	`created_at` DATETIME DEFAULT NOW(), 			-- Время создание записи
	`intro` TINYTEXT NULL DEFAULT NULL, 			-- Небольшое описание, которое заполняется пользователем
	`profile` TEXT NULL DEFAULT NULL, 				-- Полноценный профиль пользователя
	PRIMARY KEY (`id`),
	UNIQUE KEY `user_phone` (`phone`),
	UNIQUE KEY `user_email` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

# Создание таблицы products, в которой будет храниться информация о товарных позициях на платформе

DROP TABLE IF EXISTS `products`;
CREATE TABLE `products` (
	`id` BIGINT NOT NULL AUTO_INCREMENT,
	`user_id` BIGINT NOT NULL,						-- id, который связывается с таблицей users
	`name` VARCHAR(100) NOT NULL,					-- Название товара
	`summary` TINYTEXT NULL,						-- Небольшое описание товара
	`price` FLOAT NOT NULL DEFAULT 0,				-- Цена товара
	`discount` FLOAT NOT NULL,						-- Скидка
	`quantity` SMALLINT(6) NOT NULL DEFAULT 0,		-- Количество
	`created_at` DATETIME DEFAULT NOW(),			-- Момент создания товарной позиции
	`updated_at` DATETIME ON UPDATE CURRENT_TIMESTAMP, -- Момент изменения товарной позиции
	`content` TEXT NULL DEFAULT NULL,				-- Сохранение дополнительной информации о товаре
	`review_id` BIGINT NOT NULL,					-- id, который связывается с таблицей reviews
	`brand_id` BIGINT NOT NULL,						-- id, который связывается с таблицей brand
	`product_category_id` BIGINT NOT NULL,			-- id, который связывается с таблицей product_category
	PRIMARY KEY (`id`),
	INDEX `product_user` (`user_id`),
	FOREIGN KEY (`user_id`) REFERENCES `users`(`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

# Создание таблицы product review, в которой будут находиться отзывы от пользователей касательно товарных позиций

DROP TABLE IF EXISTS `product_review`;
CREATE TABLE `product_review` (
	`id` BIGINT NOT NULL AUTO_INCREMENT,
	`product_id` BIGINT NOT NULL,					-- id, который связывается с таблицей products
	`user_id` BIGINT NOT NULL,						-- id, который связывается с таблицей users
	`title` VARCHAR(100) NOT NULL,					-- Название отзыва
	`rating` SMALLINT(6) NOT NULL DEFAULT 0,		-- Оценка отзыва
	`created_at` DATETIME DEFAULT NOW(),			-- Момент создания отзыва
	`content` TEXT NULL DEFAULT NULL,				-- Содержание отзыва
	PRIMARY KEY (`id`),
	INDEX `review_product` (`product_id`),
	FOREIGN KEY (`product_id`) REFERENCES `products`(`id`),
	FOREIGN KEY (`user_id`) REFERENCES `users`(`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

# Создание таблицы category, в которой будут храниться категории таблиц

DROP TABLE IF EXISTS `category`;
CREATE TABLE `category` (	
	`id` BIGINT NOT NULL AUTO_INCREMENT,
	`title` VARCHAR(50) NOT NULL,					-- Название категории
	`content` TEXT NULL DEFAULT NULL,				-- Содержание категории
	PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

# Создание таблицы product category, которая будет являться связующей таблицей между products и category

DROP TABLE IF EXISTS `product_category`;
CREATE TABLE `product_category` (
	`product_id` BIGINT NOT NULL,					-- id, который связывается с таблицей products
	`category_id` BIGINT NOT NULL,					-- id, который связывается с таблицей category
	FOREIGN KEY (`product_id`) REFERENCES `products`(`id`),
	FOREIGN KEY (`category_id`) REFERENCES `category`(`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

# Создание таблицы tag, в которой будет храниться информация о тэгах

DROP TABLE IF EXISTS `tag`;
CREATE TABLE `tag` (	
	`id` BIGINT NOT NULL AUTO_INCREMENT,
	`title` VARCHAR(50) NOT NULL,					-- Название тэга
	`content` TEXT NULL DEFAULT NULL,				-- Содержание тэга
	PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

# Создание таблицы product_tag, которая будет являться связующей между product и tag

DROP TABLE IF EXISTS `product_tag`;
CREATE TABLE `product_tag` (
	`product_id` BIGINT NOT NULL,					-- id, который связывается с таблицей products
	`tag_id` BIGINT NOT NULL,						-- id, который связывается с таблицей tag
	FOREIGN KEY (`product_id`) REFERENCES `products`(`id`),
	FOREIGN KEY (`tag_id`) REFERENCES `tag`(`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

# Создание таблицы order, в которой будет храниться информация о заказе пользователя

DROP TABLE IF EXISTS `order`;
CREATE TABLE `order` (
	`id` BIGINT NOT NULL AUTO_INCREMENT,
	`user_id` BIGINT NULL DEFAULT NULL,				-- id, который связывается с таблицей users
	`status_order` VARCHAR(20) DEFAULT NULL,		-- Статус заказа
	`sub_total` FLOAT NOT NULL DEFAULT 0,			-- Промежуточная сумма заказа
	`item_discount` FLOAT NOT NULL DEFAULT 0,		-- Скидка на товар
	`tax` FLOAT NOT NULL DEFAULT 0,					-- Налог
	`shipping` FLOAT NOT NULL DEFAULT 0,			-- Стоимость отправки
	`total` FLOAT NOT NULL DEFAULT 0,				-- Финальная сумма заказа
	`created_at` DATETIME DEFAULT NOW(),			-- Момент создания заказа
	PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

# Создание таблицы order_item, которая будет являться связуещей между order и product

DROP TABLE IF EXISTS `order_item`;
CREATE TABLE `order_item` (
	`id` BIGINT NOT NULL AUTO_INCREMENT,
	`product_id` BIGINT NOT NULL,					-- id, который связывается с таблицей products
	`order_id` BIGINT NOT NULL,						-- id, который связывается с таблицей orders
	`price` FLOAT NOT NULL DEFAULT 0,				-- Стоимость товара
	`discount` FLOAT NOT NULL DEFAULT 0,			-- Скидка на товар
	`quantity` SMALLINT(6) NOT NULL DEFAULT 0,		-- Количество товара
	`created_at` DATETIME DEFAULT NOW(),			-- Момент создания товарной позиции
	`updated_at` DATETIME ON UPDATE CURRENT_TIMESTAMP, -- Момент изменения товарной позиции
	PRIMARY KEY (`id`),
	FOREIGN KEY (`product_id`) REFERENCES `products`(`id`),
	FOREIGN KEY (`order_id`) REFERENCES `order`(`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

# Создание таблицы transaction, в которой будет храниться информация о транзакциях

DROP TABLE IF EXISTS `transaction`;
CREATE TABLE `transaction` (
	`id` BIGINT NOT NULL AUTO_INCREMENT,
	`user_id` BIGINT NOT NULL,						-- id, который связывается с таблицей users	
	`order_id` BIGINT NOT NULL,						-- id, который связывается с таблицей orders
	`type` TINYINT(1) NOT NULL DEFAULT 0, 			-- Тип оплаты: Credit(0) или Debit(1)
	`mode` SMALLINT(6) NOT NULL DEFAULT 0, 			-- Способ оплаты: Offline, Cash on Delivery, Cheque, Draft, Wired and Online
	`status_payment` SMALLINT(8) NOT NULL DEFAULT 0, -- Статус оплаты: New, Cancelled, Failed, Pending, Declined, Rejected, Success
	`created_at` DATETIME DEFAULT NOW(),			-- Момент создания транзакции
	`updated_at` DATETIME ON UPDATE CURRENT_TIMESTAMP, -- Момент изменения транзакции
	PRIMARY KEY (`id`),
	FOREIGN KEY (`user_id`) REFERENCES `users`(`id`),
	FOREIGN KEY (`order_id`) REFERENCES `order`(`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

# Создание таблицы brand, в которой будет находиться информация о брендах товаров

DROP TABLE IF EXISTS `brand`;
CREATE TABLE `brand` (
	`id` BIGINT NOT NULL AUTO_INCREMENT,
	`name` VARCHAR(100) NOT NULL,					-- Название бренда
	PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

# Создание таблицы brand_product, которая является связующей между product и brand

DROP TABLE IF EXISTS `brand_product`;
CREATE TABLE `brand_product` (
	`product_id` BIGINT NOT NULL,					-- id, который связывается с таблицей product
	`brand_id` BIGINT NOT NULL,						-- id, который связывается с таблицей brand	
	FOREIGN KEY (`product_id`) REFERENCES `products`(`id`),
	FOREIGN KEY (`brand_id`) REFERENCES `brand`(`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
