# Homework #5 :atom:

Homework for the class **'Operators, filtering, sorting and restriction. Data aggregation'**

Databases. SQL & NoSQL - Geekbrains

# List of the tasks

## Task #1

#### Ru

Пусть в таблице users поля created_at и updated_at оказались незаполненными. Заполните их текущими датой и временем

#### En

Let the created_at and updated_at fields in the user table be blank. Fill them in with the current date and time

## Task #2

#### Ru

Таблица users была неудачно спроектирована. Записи created_at и updated_at были заданы типом VARCHAR и в них долгое время помещались значения в формате "20.10.2017 8:10". Необходимо преобразовать поля к типу DATETIME, сохранив введеные ранее значения

#### En

The table of users was poorly designed. The created_at and updated_at entries were set to the VARCHAR type and have long placed values in the format "20.10.2017 8:10". It is necessary to convert the fields to the DATETIME type, retaining the values entered earlier

## Task #3

#### Ru

В таблице складских запасов storehouses_products в поле value могут встречаться самые разные цифры: 0, если товар закончился и выше нуля, если на складе имеются запасы. Необходимо отсортировать записи таким образом, чтобы они выводились в порядке увеличения значения value. Однако, нулевые запасы должны выводиться в конце, после всех записей

#### En

In the storehouses_products inventory table in the value field there can be a wide variety of figures: 0 if the goods are out of stock and above zero if the stock is in stock. The entries must be sorted in such a way that they are displayed in the order in which the value is increased. However, zero stocks must be displayed at the end, after all entries

## Task #4 (Optional)

#### Ru

Из таблицы users необходимо извлечь пользователей, родившихся в августе и мае. Месяцы заданы в виде списка английских названий ('may', 'august')

#### En

Users born in August and May should be taken out of the table. The months are given as a list of English names ('may', 'august')

## Task #5 (Optional)

#### Ru

Из таблицы catalogs извлекаются записи при помощи запроса. SELECT * FROM catalogs WHERE id IN (5, 1, 2); Отсортируйте записи в порядке, заданном в списке IN

#### En

Records are extracted from the catalogs table using a query. SELECT * FROM catalogs WHERE id IN (5, 1, 2); sort the records in the order given in the IN list

## Task #6

#### Ru

Подсчитайте средний возраст пользователей в таблице users

#### En

Calculate the average age of users in the users table

## Task #7

#### Ru

Подсчитайте количество дней рождения, которые приходятся на каждый из дней недели. Следует учесть, что необходимы дни недели текущего года, а не года рождения

#### En

Calculate the number of birthdays that fall on each day of the week. Note that you need the days of the week of the current year, not the year of birth

## Task #8 (Optional)

#### Ru

Подсчитайте произведение чисел в столбце таблицы

#### En

Calculate the product of numbers in the table column

# Contributing

Pull requests are welcome.

# Source

[Geekbrains](https://geekbrains.ru)
