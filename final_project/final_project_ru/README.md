![Geekbrains Logo](https://github.com/ilyastartsdata/introductiontopython/blob/master/gb.png)

# Курсовой проект

Курс от Geekbrains University

> About Geekbrains: We teach people to master programming, web design and marketing from the ground up. We conduct online courses with internships and free master classes, develop the community, cooperate with employment companies and continuously test new methods to improve the effectiveness of learning.

## Требования

1. Составить общее текстовое описание БД и решаемых ею задач
2. Минимальное количество таблиц - 10
3. Скрипты создания структуры БД (с первичными ключами, индексами, внешними ключами)
4. Создать ERDiagram для БД
5. Скрипты наполнения БД данными
6. Скрипты характерных выборок (включающие группировки, JOIN, вложенные таблицы)
7. Представления (минимум 2)
8. Хранимые процедуры / триггеры

## Тема проекта

### StockX

Курсовой проект представляет собой базу данных для сайта онлайн торговли. 

В данном случае это подобие известной площадки stockX, которая выступает своеобразной биржей для следующих категорий товаров: кроссовки, уличная одежда, коллекционные предметы, сумки и часы.

Несколько ссылок:

1. https://stockx.com - сайт компании
2. https://en.wikipedia.org/wiki/StockX - Википедия
3. https://www.indigo9digital.com/blog/stockxgrowth

## Список таблиц

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

## Структура таблиц

### users

```js
`id` BIGINT NOT NULL AUTO_INCREMENT
`first_name` VARCHAR(100) NULL DEFAULT NULL 	// Имя
`last_name` VARCHAR(100) NULL DEFAULT NULL 	// Фамилия
`phone` BIGINT UNSIGNED UNIQUE 			// Номер телефона, который обязан быть уникальным
`email` VARCHAR(100) UNIQUE 			// Имейл, который обязан быть уникальным
`password` VARCHAR(100) UNIQUE 			// Пароль, который не стоило бы хранить тут
`buyer` TINYINT(1) NOT NULL DEFAULT 1 		// Стандартная роль пользователя на сайте - покупатель
`seller` TINYINT(1) NOT NULL DEFAULT 0 		// Роль, на которую пользователь может податься
`created_at` DATETIME DEFAULT NOW() 		// Время создание записи
`intro` TINYTEXT NULL DEFAULT NULL 		// Небольшое описание, которое заполняется пользователем
`profile` TEXT NULL DEFAULT NULL 		// Полноценный профиль пользователя
```

### products

```js
`id` BIGINT NOT NULL AUTO_INCREMENT,
`user_id` BIGINT NOT NULL, // id, который связывается с таблицей users
`name` VARCHAR(100) NOT NULL,	// Название товара
`summary` TINYTEXT NULL, // Небольшое описание товара
`price` FLOAT NOT NULL DEFAULT 0,	// Цена товара
`discount` FLOAT NOT NULL, // Скидка
`quantity` SMALLINT(6) NOT NULL DEFAULT 0, // Количество
`created_at` DATETIME DEFAULT NOW(), // Момент создания товарной позиции
`updated_at` DATETIME ON UPDATE CURRENT_TIMESTAMP, // Момент изменения товарной позиции
`content` TEXT NULL DEFAULT NULL, // Сохранение дополнительной информации о товаре
`review_id` BIGINT NOT NULL, // id, который связывается с таблицей reviews
`brand_id` BIGINT NOT NULL,	 // id, который связывается с таблицей brand
`product_category_id` BIGINT NOT NULL, // id, который связывается с таблицей product_category
```

## Содействие

Запросы приветствуются.

## Источник

[Geekbrains](https://geekbrains.ru)
