-- ****************** OLD CREATE TABLE SQLS ***************************

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

-- Casts Table
CREATE TABLE IF NOT EXISTS `Casts` (
    `cast_id` INT PRIMARY KEY,
    `first_name` VARCHAR(30),
    `last_name` VARCHAR(30)
);

-- Genres Table
CREATE TABLE IF NOT EXISTS `Genres` (
    `genre_id` INT PRIMARY KEY,
    `genre_name` VARCHAR(50)
);

-- Media Table
CREATE TABLE IF NOT EXISTS `Media` (
    `media_id` INT PRIMARY KEY,
    `title` VARCHAR(100),
    `synopsis` VARCHAR(255),
    `release_year` INT
);

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

-- Stars_In Table
CREATE TABLE IF NOT EXISTS `Stars_In` (
    `cast_id` INT,
    `media_id` INT,
    PRIMARY KEY (`cast_id`, `media_id`),
    FOREIGN KEY (`cast_id`) REFERENCES `Casts`(`cast_id`),
    FOREIGN KEY (`media_id`) REFERENCES `Media`(`media_id`)
);

-- Assign_Genres_To_Media Table
CREATE TABLE IF NOT EXISTS `Assign_Genres_To_Media` (
    `genre_id` INT,
    `media_id` INT,
    PRIMARY KEY (`genre_id`, `media_id`),
    FOREIGN KEY (`genre_id`) REFERENCES `Genres`(`genre_id`),
    FOREIGN KEY (`media_id`) REFERENCES `Media`(`media_id`)
);

-- ****************** INHERITANCE AND WEAK ENTITY ***************************

-- Movies Table (Inherits from Media)
CREATE TABLE IF NOT EXISTS `Movies` (
    `media_id` INT PRIMARY KEY,
    `duration` INT,
    FOREIGN KEY (`media_id`) REFERENCES `Media`(`media_id`)
);

-- Shows Table (Inherits from Media)
CREATE TABLE IF NOT EXISTS `Shows` (
    `media_id` INT PRIMARY KEY,
    `season_number` INT,
    FOREIGN KEY (`media_id`) REFERENCES `Media`(`media_id`)
);

-- Episodes Table (Weak Entity)
CREATE TABLE IF NOT EXISTS `Episodes` (
    `media_id` INT,
    `episode_number` INT,
    `episode_title` VARCHAR(100),
    PRIMARY KEY (`media_id`, `episode_number`),
    FOREIGN KEY (`media_id`) REFERENCES `Media`(`media_id`)
);

-- Constraints so far

- ALTER TABLE `Users`
- ADD UNIQUE (`username`),
- ADD UNIQUE (`email`);

- ALTER TABLE Genres
- ADD UNIQUE (`genre_name`);

- ALTER TABLE `Rates`
- ADD CONSTRAINT `check_rating` CHECK (`rating` >=0 AND `rating` <=5);


-- ****************** CHECK CONSTRAINTS AND TRIGGERS ***************************

-- LATEST CREATE TABLE STATEMENTS WITH CONSTRAINTS
-- Users Table
CREATE TABLE IF NOT EXISTS `Users` (
    `user_id` INT PRIMARY KEY,
    `username` VARCHAR(30) UNIQUE,
    `password` VARCHAR(30),
    `email` VARCHAR(40) UNIQUE,
    `full_name` VARCHAR(30),
    `is_admin` BOOLEAN DEFAULT FALSE,
    `created_at` DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- Casts Table
CREATE TABLE IF NOT EXISTS `Casts` (
    `cast_id` INT PRIMARY KEY,
    `first_name` VARCHAR(30),
    `last_name` VARCHAR(30)
);

-- Genres Table
CREATE TABLE IF NOT EXISTS `Genres` (
    `genre_id` INT PRIMARY KEY,
    `genre_name` VARCHAR(50) UNIQUE
);

-- Media Table
CREATE TABLE IF NOT EXISTS `Media` (
    `media_id` INT PRIMARY KEY,
    `title` VARCHAR(100),
    `synopsis` VARCHAR(255),
    `release_year` INT CHECK (`release_year` >= 1888)
);

-- Rates Table
CREATE TABLE IF NOT EXISTS `Rates` (
    `user_id` INT,
    `media_id` INT,
    `rating` INT CHECK (`rating` >= 0 AND `rating` <= 5),
    `review` VARCHAR(255),
    `show_user` BOOLEAN DEFAULT FALSE,
    PRIMARY KEY (`user_id`, `media_id`),
    FOREIGN KEY (`user_id`) REFERENCES `Users`(`user_id`) ON DELETE CASCADE,
    FOREIGN KEY (`media_id`) REFERENCES `Media`(`media_id`) ON DELETE CASCADE
);

-- Stars_In Table
CREATE TABLE IF NOT EXISTS `Stars_In` (
    `cast_id` INT,
    `media_id` INT,
    PRIMARY KEY (`cast_id`, `media_id`),
    FOREIGN KEY (`cast_id`) REFERENCES `Casts`(`cast_id`) ON DELETE CASCADE,
    FOREIGN KEY (`media_id`) REFERENCES `Media`(`media_id`) ON DELETE CASCADE
);

-- Assign_Genres_To_Media Table
CREATE TABLE IF NOT EXISTS `Assign_Genres_To_Media` (
    `genre_id` INT,
    `media_id` INT,
    PRIMARY KEY (`genre_id`, `media_id`),
    FOREIGN KEY (`genre_id`) REFERENCES `Genres`(`genre_id`) ON DELETE CASCADE,
    FOREIGN KEY (`media_id`) REFERENCES `Media`(`media_id`) ON DELETE CASCADE
);

-- Movies Table (Inherits from Media)
CREATE TABLE IF NOT EXISTS `Movies` (
    `media_id` INT PRIMARY KEY,
    `duration` INT CHECK (`duration` > 0),
    FOREIGN KEY (`media_id`) REFERENCES `Media`(`media_id`) ON DELETE CASCADE
);

-- Shows Table (Inherits from Media)
CREATE TABLE IF NOT EXISTS `Shows` (
    `media_id` INT PRIMARY KEY,
    `season_number` INT CHECK (`season_number` > 0),
    FOREIGN KEY (`media_id`) REFERENCES `Media`(`media_id`) ON DELETE CASCADE
);

-- Episodes Table (Weak Entity)
CREATE TABLE IF NOT EXISTS `Episodes` (
    `media_id` INT,
    `episode_number` INT,
    `episode_title` VARCHAR(100),
    PRIMARY KEY (`media_id`, `episode_number`),
    FOREIGN KEY (`media_id`) REFERENCES `Media`(`media_id`) ON DELETE CASCADE
);

-- SAMPLE DATA

INSERT INTO Users (user_id, username, password, email, full_name, is_admin)
VALUES (1, 'john_doe', 'password123', 'john@example.com', 'John Doe', FALSE),
(2, 'jane_smith', 'password456', 'jane@example.com', 'Jane Smith', TRUE),
(3, 'sam_brown', 'password789', 'sam@example.com', 'Sam Brown', FALSE);

INSERT INTO Casts (cast_id, first_name, last_name)
VALUES (1, 'Robert', 'Downey Jr.'),
(2, 'Scarlett', 'Johansson'),
(3, 'Chris', 'Hemsworth');

INSERT INTO Genres (genre_id, genre_name)
VALUES (1, 'Action'),
(2, 'Adventure'),
(3, 'Drama'),
(4, 'Comedy'),
(5, 'Thriller');

INSERT INTO Media (media_id, title, synopsis, release_year)
VALUES (1, 'Avengers: Endgame', 'The Avengers assemble once more...', 2019),
(2, 'The Shawshank Redemption', 'Two imprisoned men bond over a number of years...', 1994),
(3, 'The Dark Knight', 'When the menace known as The Joker emerges...', 2008),
(4, 'Friends', 'Follows the personal and professional lives of six twenty to thirty...', 1994);

INSERT INTO Rates (user_id, media_id, rating, review, show_user)
VALUES (1, 1, 5, 'Amazing movie!', TRUE),
(2, 2, 4, 'Great movie, a bit slow at times.', FALSE),
(3, 3, 5, 'The best superhero movie ever.', TRUE),
(1, 4, 4, 'A fun and nostalgic show.', TRUE);

INSERT INTO Stars_In (cast_id, media_id)
VALUES (1, 1), -- Robert Downey Jr. stars in Avengers: Endgame
(2, 1), -- Scarlett Johansson stars in Avengers: Endgame
(3, 1), -- Chris Hemsworth stars in Avengers: Endgame
(2, 3); -- Scarlett Johansson stars in The Dark Knight

INSERT INTO Assign_Genres_To_Media (genre_id, media_id)
VALUES (1, 1), -- Avengers: Endgame is an Action movie
(2, 1), -- Avengers: Endgame is an Adventure movie
(3, 2), -- The Shawshank Redemption is a Drama movie
(4, 4); -- Friends is a Comedy show

INSERT INTO Movies (media_id, duration)
VALUES (1, 181), -- Avengers: Endgame duration in minutes
(2, 142), -- The Shawshank Redemption duration in minutes
(3, 152); -- The Dark Knight duration in minutes

INSERT INTO Shows (media_id, season_number)
VALUES 
(4, 1);

INSERT INTO Episodes (media_id, episode_number, episode_title)
VALUES 
(4, 1, 'The One Where Monica Gets a Roommate'),
(4, 2, 'The One with the Sonogram at the End');

-- CONSTRAINT EXAMPLE FOR RATING TABLE

-- Passing commands as the rating 4 is in range
INSERT INTO Rates (user_id, media_id, rating, review, show_user)
VALUES (2, 3, 4, 'Another great movie.', TRUE);

-- Failing commands as the rating 6 is in range: Constraint violation
INSERT INTO Rates (user_id, media_id, rating, review, show_user)
VALUES (3, 3, 6, 'Another great movie.', TRUE);


-- TRIGGERS

-- Backup Table for the Users table
CREATE TABLE IF NOT EXISTS `DeletedUsers` (
    `user_id` INT PRIMARY KEY,
    `username` VARCHAR(30),
    `password` VARCHAR(30),
    `email` VARCHAR(40),
    `full_name` VARCHAR(30),
    `is_admin` BOOLEAN,
    `created_at` DATETIME,
    `deleted_at` DATETIME DEFAULT CURRENT_TIMESTAMP
);


DELIMITER //

CREATE TRIGGER after_user_delete
AFTER DELETE ON Users
FOR EACH ROW
BEGIN
    INSERT INTO DeletedUsers (
        user_id,
        username,
        password,
        email,
        full_name,
        is_admin,
        created_at,
        deleted_at
    )
    VALUES (
        OLD.user_id,
        OLD.username,
        OLD.password,
        OLD.email,
        OLD.full_name,
        OLD.is_admin,
        OLD.created_at,
        NOW()
    );
END;

//

DELIMITER ;

DELETE FROM Users WHERE user_id = 1;

-- ****************** NULL VALUES ***************************

ALTER TABLE Users 
MODIFY COLUMN `username` VARCHAR(30) NOT NULL,
MODIFY COLUMN `password` VARCHAR(30) NOT NULL,
MODIFY COLUMN `email` VARCHAR(40) NOT NULL,
MODIFY COLUMN `full_name` VARCHAR(30) NULL,
MODIFY COLUMN `is_admin` BOOLEAN DEFAULT FALSE NOT NULL,
MODIFY COLUMN `created_at` DATETIME DEFAULT CURRENT_TIMESTAMP NOT NULL;

ALTER TABLE Casts 
MODIFY COLUMN `first_name` VARCHAR(30) NOT NULL,
MODIFY COLUMN `last_name` VARCHAR(30) NOT NULL;

ALTER TABLE Genres 
MODIFY COLUMN `genre_name` VARCHAR(50) NOT NULL;

ALTER TABLE Media 
MODIFY COLUMN `title` VARCHAR(100) NOT NULL,
MODIFY COLUMN `synopsis` VARCHAR(255) NULL,
MODIFY COLUMN `release_year` INT NOT NULL;

ALTER TABLE Rates 
MODIFY COLUMN `rating` INT NOT NULL,
MODIFY COLUMN `review` VARCHAR(255) NULL,
MODIFY COLUMN `show_user` BOOLEAN DEFAULT FALSE NOT NULL;

ALTER TABLE Stars_In
MODIFY COLUMN `cast_id` INT NOT NULL,
MODIFY COLUMN `media_id` INT NOT NULL;

ALTER TABLE Assign_Genres_To_Media
MODIFY COLUMN `genre_id` INT NOT NULL,
MODIFY COLUMN `media_id` INT NOT NULL;

ALTER TABLE Movies 
MODIFY COLUMN `duration` INT NOT NULL;

ALTER TABLE Shows 
MODIFY COLUMN `season_number` INT NOT NULL;

ALTER TABLE Episodes 
MODIFY COLUMN `episode_title` VARCHAR(100) NULL;

-- WHEN NULL VALUE IS ALLOWED

INSERT INTO Users (user_id, username, password, email)
VALUES (4, 'alice_wonder', 'password321', 'alice@example.com');

-- WHEN NULL VALUE IS NOT ALLOWED AND HENCE ERROR

INSERT INTO Users (user_id, password, email, full_name)
VALUES (5, 'password654', 'bob@example.com', 'Bob Builder');

-- ****************** TESTING SQL ***************************

-- Users Table

-- VALID:

-- Insert a new user
INSERT INTO Users (user_id, username, password, email, full_name, is_admin)
VALUES (6, 'alicecooper1', 'password123', 'alice@example1234.com', 'Alice Coop', FALSE);

-- INVALID

-- Duplicate username
INSERT INTO Users (user_id, username, password, email, full_name, is_admin)
VALUES (5, 'john_doe', 'password123', 'john_doe@example.com', 'John Doe', FALSE);

-- Duplicate email
INSERT INTO Users (user_id, username, password, email, full_name, is_admin)
VALUES (7, 'charlie_brown', 'password123', 'john@example.com', 'Charlie Brown', FALSE);

-- NULL username
INSERT INTO Users (user_id, username, password, email, full_name, is_admin)
VALUES (8, NULL, 'password123', 'charlie@example.com', 'Charlie Brown', FALSE);


-- Casts Table

-- VALID:

-- Insert a new cast member
INSERT INTO Casts (cast_id, first_name, last_name)
VALUES (4, 'Chris', 'Evans');


-- INVALID

-- NULL first name
INSERT INTO Casts (cast_id, first_name, last_name)
VALUES (5, NULL, 'Pine');

-- Genres Table

-- VALID:

-- Insert a new genre
INSERT INTO Genres (genre_id, genre_name)
VALUES (6, 'Sci-Fi');

-- INVALID

-- Duplicate genre name
INSERT INTO Genres (genre_id, genre_name)
VALUES (7, 'Action');

-- Media Table

-- VALID:

-- Insert new media
INSERT INTO Media (media_id, title, synopsis, release_year)
VALUES (5, 'Inception', 'A thief who steals corporate secrets...', 2010);

-- INVALID

-- NULL title
INSERT INTO Media (media_id, title, synopsis, release_year)
VALUES (6, NULL, 'A thief who steals corporate secrets...', 2010);

-- release year less than 1888
INSERT INTO Media (media_id, title, synopsis, release_year)
VALUES (7, 'Metropolis', 'A futuristic city...', 1887);


-- Rates Table

-- VALID:

-- Insert a valid rating
INSERT INTO Rates (user_id, media_id, rating, review, show_user)
VALUES (2, 3, 4, 'Another great movie.', TRUE);

-- INVALID

-- Rating greater than 5
INSERT INTO Rates (user_id, media_id, rating, review, show_user)
VALUES (3, 2, 6, 'This should fail.', TRUE);

-- User ID not existing in Users
INSERT INTO Rates (user_id, media_id, rating, review, show_user)
VALUES (10, 1, 4, 'Nonexistent user.', TRUE);

-- Stars_In Table

-- VALID:

-- Insert a valid star in relation
INSERT INTO Stars_In (cast_id, media_id)
VALUES (4, 1);

-- INVALID

-- Cast ID not existing in Casts
INSERT INTO Stars_In (cast_id, media_id)
VALUES (10, 1);


-- Assign_Genres_To_Media Table

-- VALID:

-- Assign a valid genre to media
INSERT INTO Assign_Genres_To_Media (genre_id, media_id)
VALUES (1, 2);

-- INVALID

-- Genre ID not existing in Genres
INSERT INTO Assign_Genres_To_Media (genre_id, media_id)
VALUES (10, 1);

-- Movies Table

-- VALID:

-- Insert a valid movie
INSERT INTO Movies (media_id, duration)
VALUES (5, 148);

-- INVALID

-- Duration less than or equal to 0
INSERT INTO Movies (media_id, duration)
VALUES (6, -120);

-- Shows Table

-- VALID:

-- Insert a valid show
INSERT INTO Shows (media_id, season_number)
VALUES (5, 3);

-- INVALID

-- Season number less than or equal to 0
INSERT INTO Shows (media_id, season_number)
VALUES (6, 0);

-- Episodes Table

-- VALID:

-- Insert a valid episode
INSERT INTO Episodes (media_id, episode_number, episode_title)
VALUES (4, 3, 'The One with the Thumb');

-- INVALID

-- Media ID not existing in Media
INSERT INTO Episodes (media_id, episode_number, episode_title)
VALUES (10, 1, 'A New Beginning');

-- ****************** TESTING SQL ***************************

-- COMPOSED

-- Original
SELECT Media.title, Rates.rating
FROM Media
JOIN Rates ON Media.media_id = Rates.media_id
WHERE Rates.rating > 4 AND Media.release_year > 2000;

-- Composed
SELECT recent_media.title, high_ratings.rating
FROM (
    SELECT media_id, rating
    FROM Rates
    WHERE rating > 4
) AS high_ratings
JOIN (
    SELECT media_id, title
    FROM Media
    WHERE release_year > 2000
) AS recent_media ON high_ratings.media_id = recent_media.media_id;

-- ASSOCIATIVITY

-- Original
SELECT M.title, R.rating, C.first_name, C.last_name
FROM Media M
JOIN Rates R ON M.media_id = R.media_id
JOIN Stars_In S ON M.media_id = S.media_id
JOIN Casts C ON S.cast_id = C.cast_id
WHERE R.rating > 4;

-- Optimized
SELECT M.title, R.rating, C.first_name, C.last_name
FROM Rates R
JOIN Media M ON R.media_id = M.media_id
JOIN Stars_In S ON M.media_id = S.media_id
JOIN Casts C ON S.cast_id = C.cast_id
WHERE R.rating > 4;

-- DISTRIBUTIVE

-- Original
SELECT M.title, G.genre_name
FROM Media M
JOIN Assign_Genres_To_Media AGM ON M.media_id = AGM.media_id
JOIN Genres G ON AGM.genre_id = G.genre_id
WHERE G.genre_name = 'Action' AND M.release_year > 2000;

-- Simplified Using Distributive Law

SELECT M.title, G.genre_name
FROM (
    SELECT media_id, title, release_year
    FROM Media
    WHERE release_year > 2000
) M
JOIN Assign_Genres_To_Media AGM ON M.media_id = AGM.media_id
JOIN (
    SELECT genre_id, genre_name
    FROM Genres
    WHERE genre_name = 'Action'
) G ON AGM.genre_id = G.genre_id;

-- EQUIVALENT

-- Original
SELECT DISTINCT M.title, R.rating
FROM Media M
JOIN Rates R ON M.media_id = R.media_id
WHERE R.rating >= 4;

-- Using Equivalent Operators
SELECT M.title, R.rating
FROM Media M
JOIN Rates R ON M.media_id = R.media_id
WHERE R.rating >= 4
GROUP BY M.title, R.rating;


-- COMBINED USE OF THESE METHODS

-- Original
SELECT M.title, C.first_name, C.last_name, R.rating
FROM Media M
JOIN Stars_In S ON M.media_id = S.media_id
JOIN Casts C ON S.cast_id = C.cast_id
JOIN Rates R ON M.media_id = R.media_id
WHERE R.rating >= 4 AND M.release_year > 2000;

-- After
-- Sub-query for recent media
WITH recent_media AS (
    SELECT media_id, title
    FROM Media
    WHERE release_year > 2000
),
-- Sub-query for high ratings
high_ratings AS (
    SELECT media_id, rating
    FROM Rates
    WHERE rating >= 4
)
-- Final query
SELECT rm.title, C.first_name, C.last_name, hr.rating
FROM recent_media rm
JOIN high_ratings hr ON rm.media_id = hr.media_id
JOIN Stars_In S ON rm.media_id = S.media_id
JOIN Casts C ON S.cast_id = C.cast_id;


