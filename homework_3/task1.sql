-- Task 1

/* Write a script adding 3 new tables (with a list of fields, indexes and external keys) to the vk database that was created during the webinar. */

DROP TABLE IF EXISTS documents;
CREATE TABLE documents(
	id SERIAL,
	owner_id BIGINT UNSIGNED NOT NULL,
	document_name VARCHAR(255) DEFAULT NULL,
	document_format CHAR(5),
	document_id BIGINT UNSIGNED NOT NULL,
	document_body TEXT,
	document_size BIGINT UNSIGNED NOT NULL,
	created_at DATETIME DEFAULT NOW(),
	
	INDEX(document_name),
	FOREIGN KEY(owner_id) REFERENCES users(id)
);


DROP TABLE IF EXISTS games;
CREATE TABLE games(
	id SERIAL,
	game_name VARCHAR(255) DEFAULT NULL,
	number_of_reviews BIGINT UNSIGNED NULL,
	player_id BIGINT UNSIGNED NOT NULL,
	category VARCHAR(255) DEFAULT NULL,
	average_grade INT(5) UNSIGNED NULL,
	
	INDEX(game_name, average_grade),
	FOREIGN KEY(player_id) REFERENCES users(id)
);

DROP TABLE IF EXISTS blacklist;
CREATE TABLE blacklist(
	id SERIAL,
	user_id BIGINT UNSIGNED NOT NULL,
	blocked_target_user_id BIGINT UNSIGNED NOT NULL,
	blocked_community_id BIGINT UNSIGNED NOT NULL,
	
	PRIMARY KEY(blocked_target_user_id, blocked_community_id),
	FOREIGN KEY(user_id) REFERENCES users(id),
	FOREIGN KEY(blocked_target_user_id) REFERENCES users(id),
	FOREIGN KEY(blocked_community_id) REFERENCES communities(id)
);
