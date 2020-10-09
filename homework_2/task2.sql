/* Task 2: Create a database example, place it in the database a table consisting of two columns, numerical id and string name */

-- Creating a database example

CREATE DATABASE example;

-- Database selection example

USE example

-- Delete the table if it exists and create a new one

DROP TABLE IF EXISTS users;

CREATE TABLE users (id INT, corresponding_name CHAR(10));

-- Checking the condition of the job

SELECT * FROM users;
