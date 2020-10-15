# Homework #9 :atom:

Homework for the class **'Complex requests'**

Databases. SQL & NoSQL - Geekbrains

# List of the tasks

## Task #1

#### Ru

В базе данных shop и sample присутствуют одни и те же таблицы, учебной базы данных. Переместите запись id = 1 из таблицы shop.users в таблицу sample.users. Используйте транзакции.

#### En

The same tables, the same training database and the same sample database are available. Move the id = 1 entry from the shop.users table to the sample.users table. Use the transactions.

## Task #2

#### Ru

Создайте представление, которое выводит название name товарной позиции из таблицы products и соответствующее название каталога name из таблицы catalogs.

#### En

Create a view that displays the name of the product item from the product table and the corresponding catalogue name from the catalogues table.

------------------------------------------------------

Homework for the class **'Administration of MySQL'**

Databases. SQL & NoSQL - Geekbrains

# List of the tasks

## Task #1

#### Ru

Создайте двух пользователей которые имеют доступ к базе данных shop. 
Первому пользователю shop_read должны быть доступны только запросы на чтение данных, второму пользователю shop — любые операции в пределах базы данных shop.

#### En

Create two users who have access to the shop database. 
The first shop_read user should have access only to data reading requests, the second shop user should have access to any operations within the shop database.

------------------------------------------------------

Homework for the class **'Stored procedures and functions, triggers'**

Databases. SQL & NoSQL - Geekbrains

# List of the tasks

## Task #1

#### Ru

Создайте хранимую функцию hello(), которая будет возвращать приветствие, в зависимости от текущего времени суток. 
С 6:00 до 12:00 функция должна возвращать фразу "Доброе утро", с 12:00 до 18:00 функция должна возвращать фразу "Добрый день", с 18:00 до 00:00 — "Добрый вечер", с 00:00 до 6:00 — "Доброй ночи".

#### En

Create a stored hello() function that will return the greeting, depending on the current time of day. 
From 6:00 to 12:00 the function should return the phrase "Good morning", from 12:00 to 18:00 the function should return the phrase "Good afternoon", from 18:00 to 00:00 the function should return "Good evening", from 00:00 to 6:00 the function should return "Good night".

## Task #2

#### Ru

В таблице products есть два текстовых поля: name с названием товара и description с его описанием. 
Допустимо присутствие обоих полей или одно из них. Ситуация, когда оба поля принимают неопределенное значение NULL неприемлема. Используя триггеры, добейтесь того, чтобы одно из этих полей или оба поля были заполнены. 
При попытке присвоить полям NULL-значение необходимо отменить операцию.

#### En

The products table has two text fields: name with the product name and description with the product description. 
The presence of both fields or one of them is allowed. The situation where both fields take an undefined NULL value is unacceptable. Use triggers to ensure that one or both of these fields are filled in. 
When trying to assign a NULL value to fields, you must cancel the operation.

# Contributing

Pull requests are welcome.

# Source

[Geekbrains](https://geekbrains.ru)

