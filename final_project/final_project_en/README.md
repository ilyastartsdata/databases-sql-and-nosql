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

### Файлы в репозитории

- [structure.sql](https://github.com/ilyastartsdata/databases_sql/blob/main/final_project/final_project_ru/structure.sql) -> Создание БД и таблиц
- [data.sql](https://github.com/ilyastartsdata/databases_sql/blob/main/final_project/final_project_ru/data.sql) -> Добавление данных в таблицы
- [views.sql](https://github.com/ilyastartsdata/databases_sql/blob/main/final_project/final_project_ru/views.sql) -> Создание представлений
- [procedures_triggers.sql](https://github.com/ilyastartsdata/databases_sql/blob/main/final_project/final_project_ru/procedures_triggers.sql) -> Создание процедур и триггеров
- [stockx_dump.sql](https://github.com/ilyastartsdata/databases_sql/blob/main/final_project/final_project_ru/stockx_dump.sql) -> Dump

## Тема проекта

### StockX

Курсовой проект представляет собой базу данных для сайта онлайн торговли. 

В данном случае это подобие известной площадки stockX, которая выступает своеобразной биржей для следующих категорий товаров: кроссовки, уличная одежда, коллекционные предметы, сумки и часы.

Несколько ссылок:

1. https://stockx.com - сайт компании
2. https://en.wikipedia.org/wiki/StockX - Википедия
3. https://www.indigo9digital.com/blog/stockxgrowth

## ERDiagram

![ERD](https://github.com/ilyastartsdata/databases_sql/blob/main/final_project/final_project_ru/stockX_ERD.png)

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
`id` BIGINT NOT NULL AUTO_INCREMENT
`user_id` BIGINT NOT NULL                         // id, который связывается с таблицей users
`name` VARCHAR(100) NOT NULL                      // Название товара
`summary` TINYTEXT NULL                           // Небольшое описание товара
`price` FLOAT NOT NULL DEFAULT 0                  // Цена товара
`discount` FLOAT NOT NULL                         // Скидка
`quantity` SMALLINT(6) NOT NULL DEFAULT 0         // Количество
`created_at` DATETIME DEFAULT NOW()               // Момент создания товарной позиции
`updated_at` DATETIME ON UPDATE CURRENT_TIMESTAMP // Момент изменения товарной позиции
`content` TEXT NULL DEFAULT NULL                  // Сохранение дополнительной информации о товаре
`review_id` BIGINT NOT NULL                       // id, который связывается с таблицей reviews
`brand_id` BIGINT NOT NULL                        // id, который связывается с таблицей brand
`product_category_id` BIGINT NOT NULL             // id, который связывается с таблицей product_category
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

## Содействие

Запросы приветствуются.

## Источники

- [Geekbrains](https://geekbrains.ru)
- [StockX](https://stockx.com)
- [FillDB](http://filldb.info)
