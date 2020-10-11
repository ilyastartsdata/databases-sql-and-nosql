-- Task 1-4

/* Fill in all DB vk tables with data (10-100 records in each table) */

-- We use database vk
USE vk;

-- Fill in the users table
INSERT INTO `users`(`id`,`firstname`,`lastname`,`email`,`phone`)
VALUES
('1', 'Peter', 'Pan', 'peterpan@example.org', '987654320'),
('2', 'Snow', 'White', 'snowwhite@example.org', '987654321'),
('3', 'Emma', 'Swan', 'emmaswan@example.org', '987654322'),
('4', 'Evil', 'Queen', 'evilqueen@example.org', '987654323'),
('5', 'Prince', 'Charming', 'princecharming@example.org', '987654324'),
('6', 'Henry', 'Mills', 'henrymills@example.org', '987654325'),
('7', 'Jiminy', 'Cricket', 'jiminycricket@example.org', '987654326'),
('8', 'Killian', 'Jones', 'killianjones@example.org', '987654327'),
('9', 'Robin', 'Hood', 'robinhood@example.org', '987654328'),
('10', 'Rumpel', 'Beast', 'rumpelbeast@example.org', '987654329');

-- Output of the firstname column without repeats and in alphabetical order
SELECT DISTINCT `firstname`
FROM `users`
ORDER BY `firstname`;

-- We fill in the profiles table, but first create a column for minors
ALTER TABLE `profiles` DROP COLUMN `adult`;

-- Adding a column with a standard value of 1
ALTER TABLE `profiles` ADD COLUMN `adult` INT DEFAULT 1;

INSERT INTO `profiles`(`user_id`,`gender`,`hometown`,`created_at`,`birthday`,`adult`)
VALUES
('1','m','Storybrooke','2020-09-14 19:45:00','15.05.1905','0'),
('2','f','Storybrooke','2020-09-14 19:45:00','15.05.1906','1'),
('3','f','Storybrooke','2020-09-14 19:45:00','15.05.1907','1'),
('4','f','Storybrooke','2020-09-14 19:45:00','15.05.1908','1'),
('5','m','Storybrooke','2020-09-14 19:45:00','15.05.1909','1'),
('6','m','Storybrooke','2020-09-14 19:45:00','15.05.1910','0'),
('7','m','Storybrooke','2020-09-14 19:45:00','15.05.1911','1'),
('8','m','Storybrooke','2020-09-14 19:45:00','15.05.1912','1'),
('9','m','Storybrooke','2020-09-14 19:45:00','15.05.1913','1'),
('10','m','Storybrooke','2020-09-14 19:45:00','15.05.1914','1');

-- Viewing the list of underage users
SELECT `firstname`, `lastname`
FROM `users`
WHERE `users.id` IN (SELECT `profiles.user_id` FROM `profiles` WHERE `adult`='0');

-- Fill in the table messages
INSERT INTO `messages`(`id`,`from_user_id`,`to_user_id`,`body`,`created_at`)
VALUES
('1', '1', '2', 'This is a message', '2020-09-14 19:45:00'),
('2', '1', '3', 'This is b message', '2020-09-14 19:45:00'),
('3', '1', '4', 'This is c message', '2020-09-14 19:45:00'),
('4', '1', '5', 'This is d message', '2020-09-14 19:45:00'),
('5', '1', '6', 'This is e message', '2020-09-14 19:45:00'),
('6', '1', '7', 'This is f message', '2020-09-14 19:45:00'),
('7', '1', '8', 'This is g message', '2020-09-14 19:45:00'),
('8', '1', '9', 'This is h message', '2020-09-14 19:45:00'),
('9', '1', '10', 'This is i message', '2021-09-20 19:45:00'),
('10', '2', '1', 'This is j message', '2021-09-20 19:45:00'),
('11', '2', '3', 'This is k message', '2021-09-20 19:45:00'),
('12', '2', '4', 'This is l message', '2021-09-20 19:45:00'),
('13', '2', '5', 'This is m message', '2020-09-14 19:45:00'),
('14', '2', '6', 'This is n message', '2020-09-14 19:45:00'),
('15', '2', '7', 'This is o message', '2020-09-14 19:45:00');

-- A script that deletes messages from the future (if the time system is longer than the current date)
DELETE FROM `messages`
WHERE `created_at` > CURRENT_DATE();

-- Fill in the table friend_requests
INSERT INTO `friend_requests`(`id`,`initiator_user_id`,`target_user_id`,`status`,`created_at`,`updated_at`)
VALUES
('1','1','2','requested','2020-09-14 19:45:00','2020-09-14 19:45:00'),
('2','1','3','requested','2020-09-14 19:45:00','2020-09-14 19:45:00'),
('3','1','4','requested','2020-09-14 19:45:00','2020-09-14 19:45:00'),
('4','1','5','requested','2020-09-14 19:45:00','2020-09-14 19:45:00'),
('5','1','6','requested','2020-09-14 19:45:00','2020-09-14 19:45:00'),
('6','1','7','requested','2020-09-14 19:45:00','2020-09-14 19:45:00'),
('7','1','8','requested','2020-09-14 19:45:00','2020-09-14 19:45:00'),
('8','1','9','requested','2020-09-14 19:45:00','2020-09-14 19:45:00'),
('9','1','10','requested','2020-09-14 19:45:00','2020-09-14 19:45:00'),
('10','2','3','requested','2020-09-14 19:45:00','2020-09-14 19:45:00');

-- Fill in the table communities
INSERT INTO `communities`(`id`,`name`,`admin_user_id`)
VALUES
('1','news','1'),
('2','hobby','1'),
('3','fun','1'),
('4','weekend','1'),
('5','photo','1'),
('6','basketball','2'),
('7','dogs','2'),
('8','cats','2'),
('9','finance','2'),
('10','market','2');

-- Fill in the table user_communities
INSERT INTO `users_communities`(`user_id`,`community_id`)
VALUES
('1','1'),
('2','2'),
('3','1'),
('4','4'),
('5','5'),
('6','1'),
('7','2'),
('8','7'),
('1','9'),
('2','10');

-- Fill in the table media_types
INSERT INTO `media_types`(`id`,`name`)
VALUES
('1', 'mp3'),
('2', 'jpeg'),
('3', 'mp4'),
('4', 'png'),
('5', 'mp3'),
('6', 'jpeg'),
('7', 'mp4'),
('8', 'png'),
('9', 'mp3'),
('10', 'png');

-- Fill in the table media
INSERT INTO `media`(`id`,`user_id`,`media_type_id`,`body`,`filename`,`metadata`,`created_at`,`updated_at`)
VALUES
('1','1','1','This is a text with the description','draft',NULL,'2020-09-14 19:45:00','2020-09-14 19:45:00'),
('2','2','2','This is a text with the description','draft2',NULL,'2020-09-14 19:45:00','2020-09-14 19:45:00'),
('3','1','3','This is a text with the description','draft3',NULL,'2020-09-14 19:45:00','2020-09-14 19:45:00'),
('4','2','4','This is a text with the description','draft4',NULL,'2020-09-14 19:45:00','2020-09-14 19:45:00'),
('5','3','5','This is a text with the description','draft5',NULL,'2020-09-14 19:45:00','2020-09-14 19:45:00'),
('6','4','1','This is a text with the description','draft6',NULL,'2020-09-14 19:45:00','2020-09-14 19:45:00'),
('7','5','2','This is a text with the description','draft7',NULL,'2020-09-14 19:45:00','2020-09-14 19:45:00'),
('8','3','3','This is a text with the description','draft8',NULL,'2020-09-14 19:45:00','2020-09-14 19:45:00'),
('9','6','4','This is a text with the description','draft9',NULL,'2020-09-14 19:45:00','2020-09-14 19:45:00'),
('10','7','5','This is a text with the description','final',NULL,'2020-09-14 19:45:00','2020-09-14 19:45:00');

-- Fill in the table likes
INSERT INTO `likes`(`id`,`user_id`,`media_id`,`created_at`)
VALUES
('1','1','1','2020-09-14 19:45:00'),
('2','10','2','2020-09-14 19:45:00'),
('3','2','3','2020-09-14 19:45:00'),
('4','9','4','2020-09-14 19:45:00'),
('5','3','5','2020-09-14 19:45:00'),
('6','8','6','2020-09-14 19:45:00'),
('7','4','1','2020-09-14 19:45:00'),
('8','7','2','2020-09-14 19:45:00'),
('9','5','6','2020-09-14 19:45:00'),
('10','6','7','2020-09-14 19:45:00');

-- Fill in the table photo_albums
INSERT INTO `photo_albums`(`id`,`name`,`user_id`)
VALUES
('1','summer 2020','1'),
('2','summer 2019','2'),
('3','summer 2018','3'),
('4','summer 2017','4'),
('5','summer 2016','5'),
('6','summer 2015','1'),
('7','summer 2014','2'),
('8','summer 2013','7'),
('9','summer 2012','8'),
('10','summer 2011','3');

-- Fill in the table photos
INSERT INTO `photos`(`id`,`album_id`,`media_id`)
VALUES
('1','2','1'),
('2','3','2'),
('3','4','3'),
('4','1','4'),
('5','5','5'),
('6','7','1'),
('7','8','2'),
('8','1','7'),
('9','5','8'),
('10','1','3');

-- Fill in the table documents
INSERT INTO `documents`(`id`,`owner_id`,`document_name`,`document_format`,`document_id`,`document_body`,`document_size`,`created_at`)
VALUES
('1','1','draft','pdf','1','This is a document','1000','2020-09-14 19:45:00'),
('2','2','draft1','pdf','2','This is b document','1000','2020-09-14 19:45:00'),
('3','3','draft2','pdf','3','This is c document','1000','2020-09-14 19:45:00'),
('4','4','draft3','pdf','4','This is d document','1000','2020-09-14 19:45:00'),
('5','2','draft4','pdf','5','This is e document','1000','2020-09-14 19:45:00'),
('6','6','draft5','pdf','6','This is f document','1000','2020-09-14 19:45:00'),
('7','7','draft6','pdf','7','This is g document','1000','2020-09-14 19:45:00'),
('8','5','draft7','pdf','8','This is h document','1000','2020-09-14 19:45:00'),
('9','9','draft8','pdf','9','This is i document','1000','2020-09-14 19:45:00'),
('10','10','draft9','pdf','10','This is j document','1000','2020-09-14 19:45:00');

-- Fill in the table games
INSERT INTO `games`(`id`,`game_name`,`number_of_reviews`,`player_id`,`category`,`average_grade`)
VALUES
('1','Candy Crush','1000','1','strategy','5'),
('2','Candy Crush 2','1000','2','action','4'),
('3','Candy Crush 4','1000','1','action','2'),
('4','Candy Crush 7','1000','2','strategy','3'),
('5','Candy','1000','1','action','5'),
('6','Candy Crush 12','1000','3','strategy','1'),
('7','Candy Crush 5','1000','2','action','0'),
('8','Candy Crush 3','1000','5','strategy','3'),
('9','Candy Crush 9','1000','3','action','3'),
('10','Candy Crush 10','1000','1','strategy','2');

-- Fill in the table blacklist
INSERT INTO `blacklist`(`id`,`user_id`,`blocked_target_user_id`,`blocked_community_id`)
VALUES
('1','1','2','1'),
('2','1','3','2'),
('3','1','4','2'),
('4','2','1','2'),
('5','2','5','3'),
('6','2','6','3'),
('7','3','2','3'),
('8','3','1','3'),
('9','3','7','4'),
('10','4','1','1');
