-- Task 1_8

-- We use table vk
USE vk;

-- Task 1.1: Let the created_at and updated_at fields in the user table be blank. Fill them in with the current date and time.
-- First I suggest adding the columns created_at and updated_at and setting the current DATETIME as the standard values.

ALTER TABLE `users`
	ADD `created_at` DATETIME DEFAULT NOW(),
	ADD `updated_at` DATETIME DEFAULT NOW();
  
-- Or
UPDATE `products`
    SET `created_at` = NULL where `id` = 3;

UPDATE `products`
    SET `created_at` = NULL where `id` = 1;

UPDATE `products`
    SET `created_at` = NOW() where `created_at` is NULL;

UPDATE `products`
    SET `created_at` = NOW() where `id` = 3;
    
-- Task 2.1: The users table was poorly designed. The created_at and updated_at entries were defined by the VARCHAR type and have been in them for a long time.
-- the values were placed in the format "20.10.2017 8:10". It is necessary to convert fields to the DATETIME type, retaining the values entered earlier.

-- Firstly, created_at
UPDATE `users`
SET `created_at` = STR_TO_DATE(`created_at`, "%YYYY-%MM-%DD %HH:%MM:%SS");

ALTER TABLE `users`
MODIFY COLUMN `created_at` DATETIME;

- - Теперь updated_at
UPDATE `users`
SET `updated_at` = STR_TO_DATE(`updated_at`, "%YYYY-%MM-%DD %HH:%MM:%SS");

ALTER TABLE `users`
MODIFY COLUMN `updated_at` DATETIME;

/* Task 3.1: A wide variety of figures can be found in the value field in the storehouses_products inventory table:
0 if the goods have run out and above zero if there are stocks in the warehouse. The entries must be sorted in this way,
so that they can be output in the order of increasing the value. However, zero stocks must be printed out at the end, after all entries have been made. */

SELECT `value`
FROM `storehouses_products`
ORDER BY `value` = 0, `value`;

-- Or
SELECT 
    `value`
FROM
    `storehouses_products` ORDER BY CASE WHEN `value` = 0 THEN 1 ELSE 0 END, `value`;
    
-- Task 1.2: Calculate the average age of users in the users table

-- Suppose we have an additional bithday_at column in the users table
SELECT ROUND(AVG(TIMESTAMPDIFF(YEAR, `birthday_at`, NOW())), 0) AS `AVG_Age`
FROM users;

/* Task 2.2: Calculate the number of birthdays that fall on each day of the week.
Please note that the days of the week of the current year are required, not the year of birth. */

SELECT
	DATE_FORMAT(DATE(CONCAT_WS('-', YEAR(NOW()), MONTH(`birthday_at`), DAY(`birthday_at`))), '%W') AS `day`,
	COUNT(*) AS `total`
FROM
	`users`
GROUP BY
	`day`
ORDER BY
	`total` DESC;
