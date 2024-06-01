-- These are the Sql commands to create all the required tables for the project.Stars_In
-- As per the coverage for sprint, the foreign key concept will be covered in the next sprint.

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

INSERT INTO `Users` (`user_id`, `username`, `password`, `email`, `full_name`, `is_admin`, `created_at`)
VALUES (1, 'johndoe', 'securepassword', 'johndoe@example.com', 'John Doe', FALSE, '2024-06-01 12:34:56');

INSERT INTO `Users` (`user_id`, `username`, `password`, `email`, `full_name`, `is_admin`, `created_at`)
VALUES (2, 'sidhum', 'testpassword', 'sidhumoose@example.com', 'Sidhu Moose', TRUE, '2024-06-01 12:50:56');

-- SELECT * FROM `Users`;

-- ***************** Casts Table ****************************

CREATE TABLE IF NOT EXISTS `Casts` (
    `cast_id` INT PRIMARY KEY,
    `first_name` VARCHAR(30),
    `last_name` VARCHAR(30)
);


INSERT INTO `Casts` (`cast_id`, `first_name`, `last_name`)
VALUES (1, 'Bruce', 'Willis');

INSERT INTO `Casts` (`cast_id`, `first_name`, `last_name`)
VALUES (2, 'Daniel', 'Radcliffe');

-- SELECT * FROM `Casts`;

-- ***************** Genres Table ****************************

CREATE TABLE IF NOT EXISTS `Genres` (
    `genre_id` INT PRIMARY KEY,
    `genre_name` VARCHAR(50)
);

INSERT INTO `Genres` (`genre_id`, `genre_name`)
VALUES (1, 'Action');

INSERT INTO `Genres` (`genre_id`, `genre_name`)
VALUES (2, 'Adventure');

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

INSERT INTO `Movie_Episodes` (`movie_episode_id`, `episode_number`, `title`, `release_year`, `synopsis`, `has_episodes`)
VALUES (1, 0, 'Die Hard: 4', 2012, 'Movie about a police officer.', FALSE);

INSERT INTO `Movie_Episodes` (`movie_episode_id`, `episode_number`, `title`, `release_year`, `synopsis`, `has_episodes`)
VALUES (2, 0, 'Big Bang Theory: Season 1', 2012, 'The show about the scientists.', TRUE);

INSERT INTO `Movie_Episodes` (`movie_episode_id`, `episode_number`, `title`, `release_year`, `synopsis`, `has_episodes`)
VALUES (2, 1, 'Pilot', 2023, 'The first episode introduces the main characters and sets up the story.', FALSE);

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

INSERT INTO `Rates` (`user_id`, `movie_episode_id`, `episode_number`, `rating`, `review`, `show_username`)
VALUES
    (1, 1, 0, 5, 'Great show!', TRUE),
    (2, 2, 1, 5, 'Excellent pilot episode!', FALSE),
    (3, 2, 0, 4, 'Enjoyable show.', FALSE);

-- SELECT * FROM `Rates`;

-- ***************** Stars_In Table ****************************

CREATE TABLE IF NOT EXISTS `Stars_In` (
    `cast_id` INT,
    `movie_episode_id` INT,
    `episode_number` INT,
    PRIMARY KEY (`cast_id`, `movie_episode_id`, `episode_number`)
);

INSERT INTO `Stars_In` (`cast_id`, `movie_episode_id`, `episode_number`)
VALUES
    (1, 1, 0),
    (2, 2, 1),
    (2, 2, 0);

-- SELECT * FROM `Stars_In`;

-- ***************** Assign_Genres_to_Movie_Episodes Table ****************************

CREATE TABLE IF NOT EXISTS `Assign_Genres_to_Movie_Episodes` (
    `genre_id` INT,
    `movie_episode_id` INT,
    `episode_number` INT,
    PRIMARY KEY (`genre_id`, `movie_episode_id`, `episode_number`)
);
INSERT INTO `Assign_Genres_to_Movie_Episodes` (`genre_id`, `movie_episode_id`, `episode_number`)
VALUES
    (1, 1, 0),
    (2, 2, 1),
    (2, 2, 0);

-- SELECT * FROM `Movie_Episodes`;


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

