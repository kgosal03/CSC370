-- ****************** INDEXES ***************************

-- Casts Table
CREATE INDEX idx_first_name ON Casts(first_name);
CREATE INDEX idx_last_name ON Casts(last_name);

-- Movie_Episodes Table
CREATE INDEX idx_title ON Movie_Episodes(title);
CREATE INDEX idx_release_year ON Movie_Episodes(release_year);

-- Rates Table
CREATE INDEX idx_user_id ON Rates(user_id);
CREATE INDEX idx_movie_episode ON Rates(movie_episode_id, episode_number);

-- Stars_In Table
CREATE INDEX idx_cast_id ON Stars_In(cast_id);
CREATE INDEX idx_movie_episode ON Stars_In(movie_episode_id, episode_number);

-- Assign_Genres_to_Movie_Episodes Table
CREATE INDEX idx_genre_id ON Assign_Genres_to_Movie_Episodes(genre_id);
CREATE INDEX idx_movie_episode ON Assign_Genres_to_Movie_Episodes(movie_episode_id, episode_number);

-- Using EXPLAIN

EXPLAIN SELECT `user_id`
FROM `Rates`
GROUP BY `user_id`
ORDER BY COUNT(*) DESC
LIMIT 1;

-- ****************** USER AUTHORIZATION ***************************
-- Admin
CREATE USER 'sidhum' IDENTIFIED BY 'Iamtheadmin123!';

-- Movie/Cast Manager
CREATE USER 'johndoe' IDENTIFIED BY 'Iamthemoviemanager123!';

-- Reviews Manager
CREATE USER 'reviewManager' IDENTIFIED BY 'Iamthereviewmanager123!';

-- So the admin can use and also create some users as required the Database
GRANT ALL PRIVILEGES ON Movie_Rating_System.* TO 'sidhum'@'%';
FLUSH PRIVILEGES;

-- By root user to the admin
GRANT CREATE USER ON *.* TO 'sidhum'@'%' WITH GRANT OPTION;
GRANT SUPER ON *.* TO 'sidhum'@'%';

-- By admin user to johndoe(Movie_cast_manager) and reviewManager
GRANT CREATE USER ON *.* TO 'johndoe'@'%' WITH GRANT OPTION;
GRANT CREATE USER ON *.* TO 'reviewManager'@'%' WITH GRANT OPTION;

-- Granting privileges

-- Privileges for managing movies and related data to johndoe(Movie_cast_manager)
GRANT SELECT, INSERT, UPDATE ON movie_rating_system.Casts TO 'johndoe'@'%' WITH GRANT OPTION;
GRANT DELETE ON movie_rating_system.Casts TO 'johndoe'@'%';
GRANT SELECT, INSERT, UPDATE ON movie_rating_system.Genres TO 'johndoe'@'%' WITH GRANT OPTION;
GRANT DELETE ON movie_rating_system.Genres TO 'johndoe'@'%';
GRANT SELECT, INSERT, UPDATE ON movie_rating_system.Movie_Episodes TO 'johndoe'@'%' WITH GRANT OPTION;
GRANT DELETE ON movie_rating_system.Movie_Episodes TO 'johndoe'@'%';
GRANT SELECT, INSERT, UPDATE ON movie_rating_system.Stars_In TO 'johndoe'@'%' WITH GRANT OPTION;
GRANT DELETE ON movie_rating_system.Stars_In TO 'johndoe'@'%';
GRANT SELECT, INSERT, UPDATE ON movie_rating_system.Assign_Genres_to_Movie_Episodes TO 'johndoe'@'%' WITH GRANT OPTION;
GRANT DELETE ON movie_rating_system.Assign_Genres_to_Movie_Episodes TO 'johndoe'@'%';
GRANT REFERENCES ON movie_rating_system.* TO 'johndoe'@'%' WITH GRANT OPTION;

-- Privileges for managing reviews to the review manager
GRANT SELECT, UPDATE ON movie_rating_system.Rates TO 'reviewManager'@'%' WITH GRANT OPTION;
GRANT DELETE ON movie_rating_system.Rates TO 'reviewManager'@'%';
GRANT REFERENCES ON movie_rating_system.* TO 'reviewManager'@'%' WITH GRANT OPTION;

-- USER johndoe

-- Adding another users for help out
-- Movie/Cast Manager
CREATE USER 'movieManagerAssistant' IDENTIFIED BY 'Iamthemoviemanagerassistant123!';

-- Granting only the required privileges
GRANT SELECT, INSERT, UPDATE ON movie_rating_system.Casts TO 'movieManagerAssistant'@'%';
GRANT SELECT, INSERT, UPDATE ON movie_rating_system.Genres TO 'movieManagerAssistant'@'%';
GRANT SELECT, INSERT, UPDATE ON movie_rating_system.Movie_Episodes TO 'movieManagerAssistant'@'%';
GRANT SELECT, INSERT, UPDATE ON movie_rating_system.Stars_In TO 'movieManagerAssistant'@'%';
GRANT SELECT, INSERT, UPDATE ON movie_rating_system.Assign_Genres_to_Movie_Episodes TO 'movieManagerAssistant'@'%';
GRANT REFERENCES ON movie_rating_system.* TO 'movieManagerAssistant'@'%';


-- USER Reviews Manager(reviewManager)

-- Adding another users for help out
-- Reviews Manager
CREATE USER 'reviewManagerAssistant' IDENTIFIED BY 'Iamthereviewmanagerassistant123!';

-- Granting only the required privileges
GRANT SELECT, UPDATE ON movie_rating_system.Rates TO 'reviewManagerAssistant'@'%';
GRANT REFERENCES ON movie_rating_system.* TO 'reviewManagerAssistant'@'%';

-- REVOKING PRIVILEGE
REVOKE UPDATE ON movie_rating_system.Casts FROM 'johndoe'@'%';

UPDATE `Casts`
SET `last_name` = 'G'
WHERE `cast_id` = 1;


-- ****************** VIEWS ***************************
-- VIEW SCENARIO 1

-- Create a view that pulls up only user_id, username and full_name
CREATE VIEW UserNames AS
SELECT user_id, username, full_name
FROM Users;

GRANT SELECT ON Movie_Rating_System.UserNames TO 'johndoe'@'%' WITH GRANT OPTION;
GRANT SELECT ON Movie_Rating_System.UserNames TO 'reviewManager'@'%' WITH GRANT OPTION;


-- VIEW SCENARIO 2
-- We can write this complex query using views as well to simplify

-- Get the display names of users who have rated the most.

-- SELECT full_name
-- FROM Users
-- JOIN
-- (
--  SELECT user_id
--  FROM Rates
--  GROUP BY user_id
--  ORDER BY COUNT(*) DESC
--  LIMIT 1
-- ) AS TopRater
-- ON Users.user_id = TopRater.user_id;

-- Step 1: Create a view to aggregate the user ratings
CREATE VIEW UserRatingCounts AS
SELECT user_id, COUNT(*) AS rating_count
FROM Rates
GROUP BY user_id;

-- Step 2: Create a view to get the top rater
CREATE VIEW TopRater AS
SELECT user_id
FROM UserRatingCounts
ORDER BY rating_count DESC LIMIT 1;

-- Step 3: Query the TopRater view to get the full name of the top rater
SELECT Users.full_name
FROM Users
JOIN TopRater ON Users.user_id = TopRater.user_id;

-- VIEW SCENARIO 3

CREATE VIEW `TopRatedMovies` AS
SELECT * FROM `Rates` WHERE `rating` > 4;

-- Caution: We need to ensure the `user_id` and `movie_episode_id` exist in the respective tables.
INSERT INTO `TopRatedMovies` (`user_id`, `movie_episode_id`, `episode_number`, `rating`, `review`, `show_username`)
VALUES (2, 2, 1, 5, 'Amazing episode!', TRUE);

DROP VIEW IF EXISTS `TopRatedMovies`;

-- VIEW SCENARIO 4
-- View that joins Users and Rates using a natural join
CREATE VIEW `UserRatings` AS
SELECT *
FROM `Users` NATURAL JOIN `Rates`;

-- See the ratings given by each user
SELECT * FROM `UserRatings`;

-- VIEW SCENARIO 5
-- View for Movie_Episodes
CREATE VIEW `View_Movie_Episodes` AS
SELECT `movie_episode_id`, `episode_number`, `title`, `release_year`, `synopsis`, `has_episodes`
FROM `Movie_Episodes`;

-- View for Stars_In
CREATE VIEW `View_Stars_In` AS
SELECT `cast_id`, `movie_episode_id`, `episode_number`
FROM `Stars_In`;

-- Natural join on the views
CREATE VIEW `View_EpisodeCasts` AS
SELECT *
FROM `View_Movie_Episodes` NATURAL JOIN `View_Stars_In`;

-- Query combined view
SELECT * FROM `View_EpisodeCasts`;

-- ****************** TRANSACTION ATOMICITY ***************************

START TRANSACTION;

-- Update date_created for user with id = 1 to a past date
UPDATE Users
SET created_at = '2023-01-15 10:00:00'
WHERE user_id = 1;

-- Update date_created for user with id = 2 to a different past date
UPDATE Users
SET created_at = '2023-02-20 12:00:00'
WHERE user_id = 2;

COMMIT;


-- ANOTHER JUST AN EXAMPLE TRANSACTON WE WANT. THIS IS JUST A CONCEPT NOT AN ACTUAL
-- AS THE SYNTAX WILL BE DIFFERENT TO WRITE AN ACTUAL
START TRANSACTION;

-- Update date_created for user with id = 1 to a past date
UPDATE Users
SET created_at = '2023-01-15 10:00:00'
WHERE user_id = 1;

-- Update date_created for user with id = 2 to a different past date
UPDATE Users
SET created_at = '2023-02-20 12:00:00'
WHERE user_id = 2;

-- Check if both updates were successful
SELECT ROW_COUNT() INTO @numAffected;
IF @numAffected = 2 THEN
    COMMIT;
ELSE
    ROLLBACK;
END IF;


-- ****************** CONCURRENCY AND ISOLATION LEVELS ***************************

-- Start a transaction with Serializable isolation level
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;
START TRANSACTION;

-- Update user information and fetch latest ratings
UPDATE Users
SET full_name = 'John Doe Jr.'
WHERE user_id = 1;

SELECT *
FROM Rates
WHERE movie_episode_id = 1;

-- Commit the transaction
COMMIT;


-- Start a transaction with Repeatable Read isolation level
SET TRANSACTION ISOLATION LEVEL REPEATABLE READ;
START TRANSACTION;

-- Calculate total ratings for a movie
SELECT SUM(rating) AS total_ratings
FROM Rates
WHERE movie_episode_id = 2;

-- Commit the transaction
COMMIT;

-- Start a transaction with Read Committed isolation level
SET TRANSACTION ISOLATION LEVEL READ COMMITTED;
START TRANSACTION;

-- Fetch latest reviews for a movie
SELECT *
FROM Rates
WHERE movie_episode_id = 2
ORDER BY rating DESC
LIMIT 10;

-- Commit the transaction
COMMIT;

-- Start a transaction with Read Uncommitted isolation level
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
START TRANSACTION;

-- Display basic movie information without locking
SELECT movie_episode_id, title
FROM Movie_Episodes;

-- Commit the transaction
COMMIT;
