-- ****************** UPDATED CREATE TABLE SQL ***************************

-- Users Table
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


-- Casts Table
CREATE TABLE IF NOT EXISTS `Casts` (
    `cast_id` INT PRIMARY KEY,
    `first_name` VARCHAR(30),
    `last_name` VARCHAR(30)
);

INSERT INTO `Casts` (`cast_id`, `first_name`, `last_name`)
VALUES (1, 'Bruce', 'Willis');

INSERT INTO `Casts` (`cast_id`, `first_name`, `last_name`)
VALUES (2, 'Daniel', 'Radcliffe');

-- Genres Table
CREATE TABLE IF NOT EXISTS `Genres` (
    `genre_id` INT PRIMARY KEY,
    `genre_name` VARCHAR(50)
);

INSERT INTO `Genres` (`genre_id`, `genre_name`)
VALUES (1, 'Action');

INSERT INTO `Genres` (`genre_id`, `genre_name`)
VALUES (2, 'Adventure');

-- Media Table
CREATE TABLE IF NOT EXISTS `Media` (
    `media_id` INT PRIMARY KEY,
    `title` VARCHAR(100),
    `synopsis` VARCHAR(255),
    `release_year` INT
);

INSERT INTO `Media` (`media_id`, `title`, `synopsis`, `release_year`)
VALUES (1, 'Die Hard', 'Movie about a police officer.', 2012);

INSERT INTO `Media` (`media_id`, `title`, `synopsis`, `release_year`)
VALUES (2, 'The Big Bang Theory', 'The show about the scientists.', 2007);

-- Rates Table
CREATE TABLE IF NOT EXISTS `Rates` (
    `user_id` INT,
    `media_id` INT,
    `rating` INT,
    `review` VARCHAR(255),
    `show_user` BOOLEAN DEFAULT FALSE,
    PRIMARY KEY (`user_id`, `media_id`),
    FOREIGN KEY (`user_id`) REFERENCES `Users`(`user_id`),
    FOREIGN KEY (`media_id`) REFERENCES `Media`(`media_id`)
);

INSERT INTO `Rates` (`user_id`, `media_id`, `rating`, `review`, `show_user`)
VALUES
    (1, 1, 5, 'Great movie!', TRUE),
    (2, 2, 4, 'Enjoyable show.', FALSE);

-- Stars_In Table
CREATE TABLE IF NOT EXISTS `Stars_In` (
    `cast_id` INT,
    `media_id` INT,
    PRIMARY KEY (`cast_id`, `media_id`),
    FOREIGN KEY (`cast_id`) REFERENCES `Casts`(`cast_id`),
    FOREIGN KEY (`media_id`) REFERENCES `Media`(`media_id`)
);

INSERT INTO `Stars_In` (`cast_id`, `media_id`)
VALUES
    (1, 1),
    (2, 2);

-- Assign_Genres_To_Media Table
CREATE TABLE IF NOT EXISTS `Assign_Genres_To_Media` (
    `genre_id` INT,
    `media_id` INT,
    PRIMARY KEY (`genre_id`, `media_id`),
    FOREIGN KEY (`genre_id`) REFERENCES `Genres`(`genre_id`),
    FOREIGN KEY (`media_id`) REFERENCES `Media`(`media_id`)
);

INSERT INTO `Assign_Genres_To_Media` (`genre_id`, `media_id`)
VALUES
    (1, 1),
    (2, 2);

-- ALTER TABLE `Users`
-- ADD UNIQUE (`username`),
-- ADD UNIQUE (`email`);

-- ALTER TABLE Genres
-- ADD UNIQUE (`genre_name`);

-- ALTER TABLE `Rates`
-- ADD CONSTRAINT `check_rating` CHECK (`rating` >=0 AND `rating` <=5);

-- ****************** INHERITANCE AND WEAK ENTITY ***************************

-- Movies Table (Inherits from Media)
CREATE TABLE IF NOT EXISTS `Movies` (
    `media_id` INT PRIMARY KEY,
    `duration` INT,
    FOREIGN KEY (`media_id`) REFERENCES `Media`(`media_id`)
);

INSERT INTO `Movies` (`media_id`, `duration`)
VALUES (1, 120);

-- Shows Table (Inherits from Media)
CREATE TABLE IF NOT EXISTS `Shows` (
    `media_id` INT PRIMARY KEY,
    `season_number` INT,
    FOREIGN KEY (`media_id`) REFERENCES `Media`(`media_id`)
);

INSERT INTO `Shows` (`media_id`, `season_number`)
VALUES (2, 1);

-- Episodes Table (Weak Entity)
CREATE TABLE IF NOT EXISTS `Episodes` (
    `media_id` INT,
    `episode_number` INT,
    `episode_title` VARCHAR(100),
    PRIMARY KEY (`media_id`, `episode_number`),
    FOREIGN KEY (`media_id`) REFERENCES `Media`(`media_id`)
);

INSERT INTO `Episodes` (`media_id`, `episode_number`, `episode_title`)
VALUES (2, 1, 'Pilot');
