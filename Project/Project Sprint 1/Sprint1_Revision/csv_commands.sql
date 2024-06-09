-- These are the Sql commands to create all the required tables for the project.Stars_In
-- As per the coverage for sprint, the foriegn key concept will be covered in the next sprint.

-- ***************** Users Table ****************************

CREATE TABLE IF NOT EXISTS `Users` (
    `user_id` INT PRIMARY KEY,
    `username` VARCHAR(30),
    `password` VARCHAR(30),
    `email` VARCHAR(40),
    `full_name` VARCHAR(30),
    `is_admin` BOOLEAN DEFAULT FALSE,
    `created_at` DATETIME
);


-- SELECT * FROM `Users`;

-- ***************** Casts Table ****************************

CREATE TABLE IF NOT EXISTS `Casts` (
    `cast_id` INT PRIMARY KEY,
    `first_name` VARCHAR(30),
    `last_name` VARCHAR(30)
);


-- SELECT * FROM `Casts`;

-- ***************** Genres Table ****************************

CREATE TABLE IF NOT EXISTS `Genres` (
    `genre_id` INT PRIMARY KEY,
    `genre_name` VARCHAR(50)
);


-- SELECT * FROM `Genres`;

-- ***************** Movie_Episodes Table ****************************

CREATE TABLE IF NOT EXISTS `Movie_Episodes` (
    `movie_episode_id` INT,
    `episode_number` INT,
    `title` VARCHAR(30),
    `release_year` INT,
    `synopsis` VARCHAR(255),
    `has_episodes` BOOLEAN DEFAULT FALSE,
    PRIMARY KEY (`movie_episode_id`, `episode_number`)
);


-- SELECT * FROM `Movie_Episodes`;

-- ***************** Rates Table ****************************
CREATE TABLE IF NOT EXISTS `Rates` (
    `user_id` INT,
    `movie_episode_id` INT,
    `episode_number` INT,
    `rating` INT,
    `review` VARCHAR(255),
    `show_username` BOOLEAN DEFAULT FALSE,
    PRIMARY KEY (`user_id`, `movie_episode_id`, `episode_number`)
);

-- SELECT * FROM `Rates`;

-- ***************** Stars_In Table ****************************

CREATE TABLE IF NOT EXISTS `Stars_In` (
    `cast_id` INT,
    `movie_episode_id` INT,
    `episode_number` INT,
    PRIMARY KEY (`cast_id`, `movie_episode_id`, `episode_number`)
);


-- SELECT * FROM `Stars_In`;

-- ***************** Assign_Genres_to_Movie_Episodes Table ****************************

CREATE TABLE IF NOT EXISTS `Assign_Genres_to_Movie_Episodes` (
    `genre_id` INT,
    `movie_episode_id` INT,
    `episode_number` INT,
    PRIMARY KEY (`genre_id`, `movie_episode_id`, `episode_number`)
);


-- SELECT * FROM `Movie_Episodes`;

-- **** UPLOAD DATA AS CSV ****

LOAD DATA LOCAL INFILE '/Users/karangosal/Downloads/UVIC/SUMMER_2024/CSC_370/Project/Csv_Files/Users.csv' INTO TABLE `Users` FIELDS TERMINATED BY ',' ENCLOSED
BY '"' LINES TERMINATED BY '\r\n' IGNORE 1 LINES (user_id, username, password, email, full_name, @is_admin, created_at)
SET is_admin = IF(@is_admin = 'TRUE', 1, 0);

LOAD DATA LOCAL INFILE '/Users/karangosal/Downloads/UVIC/SUMMER_2024/CSC_370/Project/Csv_Files/Genres.csv' INTO TABLE `Genres` FIELDS TERMINATED BY ',' ENCLOSED
BY '"' LINES TERMINATED BY '\r\n' IGNORE 1 LINES;

LOAD DATA LOCAL INFILE '/Users/karangosal/Downloads/UVIC/SUMMER_2024/CSC_370/Project/Csv_Files/Casts.csv' INTO TABLE `Casts` FIELDS TERMINATED BY ',' ENCLOSED
BY '"' LINES TERMINATED BY '\r\n' IGNORE 1 LINES;

LOAD DATA LOCAL INFILE '/Users/karangosal/Downloads/UVIC/SUMMER_2024/CSC_370/Project/Csv_Files/Movie_Episodes.csv' INTO TABLE `Movie_Episodes` FIELDS TERMINATED BY ',' ENCLOSED
BY '"' LINES TERMINATED BY '\r\n' IGNORE 1 LINES;

LOAD DATA LOCAL INFILE '/Users/karangosal/Downloads/UVIC/SUMMER_2024/CSC_370/Project/Csv_Files/Assign_Genres_to_Movie_Episodes.csv' INTO TABLE `Assign_Genres_to_Movie_Episodes` FIELDS TERMINATED BY ',' ENCLOSED
BY '"' LINES TERMINATED BY '\r\n' IGNORE 1 LINES;

LOAD DATA LOCAL INFILE '/Users/karangosal/Downloads/UVIC/SUMMER_2024/CSC_370/Project/Csv_Files/Stars_In.csv' INTO TABLE `Stars_In` FIELDS TERMINATED BY ',' ENCLOSED
BY '"' LINES TERMINATED BY '\r\n' IGNORE 1 LINES;

LOAD DATA LOCAL INFILE '/Users/karangosal/Downloads/UVIC/SUMMER_2024/CSC_370/Project/Csv_Files/Rates.csv' INTO TABLE `Rates` FIELDS TERMINATED BY ',' ENCLOSED BY '"' 
LINES TERMINATED BY '\r\n' IGNORE 1 LINES (user_id, movie_episode_id, episode_number, rating, review, @show_username)
SET show_username = IF(@show_username = 'TRUE', 1, 0);


-- Commands usage

-- **** ALTER **** 

-- ALTER TABLE `Users` ADD `last_name` VARCHAR(20);
-- SELECT * FROM `Users`;
-- ALTER TABLE `Users` DROP `last_name`;
-- SELECT * FROM `Users`;

-- ALTER TABLE `Users` MODIFY `user_id` VARCHAR(10);
-- DESCRIBE `Users`;
-- ALTER TABLE `Users` MODIFY `user_id` INT;
-- DESCRIBE `Users`;


-- **** DROP TABLES **** 

-- CREATE TABLE `test_drop`(`id` INT);
-- DROP TABLE `test_drop`;

-- **** DROP ADD COLUMNS **** 

-- ALTER TABLE `Users` ADD `last_name` VARCHAR(20);
-- SELECT * FROM `Users`;
-- ALTER TABLE `Users` DROP `last_name`;
-- SELECT * FROM `Users`;

-- **** WHERE **** 

-- Finding all the movies which are not series i.e. no episodes but just a movie
-- SELECT * FROM `Movie_Episodes`;
-- SELECT * FROM `Movie_Episodes`
-- WHERE `episode_number` = 0 AND `has_episodes` = 0;

-- **** LIMIT and ORDER BY **** 

-- Finding all the movies or series only no episodes and ordering by title

-- SELECT * FROM `Movie_Episodes`;
-- SELECT * FROM `Movie_Episodes`
-- WHERE `episode_number` = 0
-- ORDER BY `title`;

-- SELECT DISTINCT * FROM `Movie_Episodes`
-- WHERE `episode_number` = 0
-- ORDER BY `title` LIMIT 1;

-- **** JOIN **** 

-- SELECT Users.user_id, Users.username
-- FROM Users
-- JOIN Rates ON Users.user_id = Rates.user_id    
-- WHERE Users.`user_id` = 1;

