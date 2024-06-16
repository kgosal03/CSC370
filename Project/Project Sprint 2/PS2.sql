-- NATURAL JOIN

-- SELECT * FROM Casts NATURAL JOIN Stars_In;

-- CONSTRAINTS AND REFERENTIAL INTEGRITY

-- ALTER TABLE `Users`
-- ADD UNIQUE (`username`),
-- ADD UNIQUE (`email`);

-- ALTER TABLE Genres
-- ADD UNIQUE (`genre_name`);

-- ALTER TABLE `Rates`
-- ADD CONSTRAINT `check_rating` CHECK (`rating` >=0 AND `rating` <=5);

-- FOREIGN KEY

-- ALTER TABLE `Rates`
-- ADD FOREIGN KEY (`user_id`) REFERENCES `Users` (`user_id`);

-- ALTER TABLE `Rates`
-- ADD FOREIGN KEY (`movie_episode_id`, `episode_number`) REFERENCES `Movie_Episodes` (`movie_episode_id`, `episode_number`);

-- ALTER TABLE `Stars_In`
-- ADD FOREIGN KEY (`cast_id`) REFERENCES `Casts` (`cast_id`),
-- ADD FOREIGN KEY (`movie_episode_id`, `episode_number`) REFERENCES `Movie_Episodes` (`movie_episode_id`, `episode_number`);

-- ALTER TABLE `Assign_Genres_to_Movie_Episodes`
-- ADD FOREIGN KEY (`genre_id`) REFERENCES `Genres` (`genre_id`),
-- ADD FOREIGN KEY (`movie_episode_id`, `episode_number`) REFERENCES `Movie_Episodes` (`movie_episode_id`, `episode_number`);

-- GROUPING AND AGGREGATION

-- SELECT DISTINCT `movie_episode_id`
-- FROM `Stars_In`;

-- SELECT `cast_id` from `Stars_In` GROUP BY `cast_id`;

-- SELECT MIN(`cast_id`) from `Stars_In` GROUP BY `episode_number`;

-- SELECT MAX(`cast_id`) from `Stars_In` GROUP BY `episode_number`;

-- SELECT AVG(`cast_id`) from `Stars_In` GROUP BY `episode_number`;

-- SELECT SUM(`cast_id`) from `Stars_In` GROUP BY `episode_number`;

-- SELECT COUNT(`cast_id`) from `Stars_In` GROUP BY `episode_number`;

-- SELECT ANY(`cast_id`) from `Stars_In` GROUP BY `episode_number`;


-- Casts that have performed more than once in any show.

-- SELECT cast_id
-- FROM Stars_In
-- GROUP BY cast_id, movie_episode_id
-- HAVING COUNT(*) > 1;

-- LIKE
-- SELECT * FROM `Casts` WHERE `first_name` LIKE '%im%';

-- COMPLEX QUERY

-- 1. Get the display names of users who have rated the most.

-- SELECT `full_name`
-- FROM `Users`
-- JOIN
-- (
--  SELECT `user_id`
--  FROM `Rates`
--  GROUP BY `user_id`
--  ORDER BY COUNT(*) DESC
--  LIMIT 1
-- ) AS `TopRater`
-- ON `Users`.`user_id` = `TopRater`.`user_id`;


-- 2. Get the cast members who have starred in the most episodes.

-- SELECT `first_name`, `last_name`
-- FROM `Casts`
-- JOIN
-- (
--  SELECT `cast_id`
--  FROM `Stars_In`
--  GROUP BY `cast_id`
--  ORDER BY COUNT(*) DESC
--  LIMIT 1
-- ) AS `TopCast`
-- ON `Casts`.`cast_id` = `TopCast`.`cast_id`;

-- 3. For each user, get the highest rating they have given.

-- SELECT `Users`.`full_name`, MAX(`Rates`.`rating`) AS `HighestRating`
-- FROM `Users`
-- JOIN `Rates` ON `Users`.`user_id` = `Rates`.`user_id`
-- GROUP BY `Users`.`user_id`, `Users`.`full_name`;


-- 4. For each cast member, get the maximum number of episodes they have starred in one show.

-- SELECT `Casts`.`first_name`, `Casts`.`last_name`, MAX(`EpisodeCount`) AS `MaxEpisodesInOneShow`
-- FROM `Casts`
-- JOIN
-- (
--  SELECT `cast_id`, `movie_episode_id`, COUNT(*) AS `EpisodeCount`
--  FROM `Stars_In`
--  WHERE `episode_number` <> 0
--  GROUP BY `cast_id`, `movie_episode_id`
-- ) AS `CastEpisodeCounts`
-- ON `Casts`.`cast_id` = `CastEpisodeCounts`.`cast_id`
-- GROUP BY `Casts`.`cast_id`, `Casts`.`first_name`, `Casts`.`last_name`;


-- 5. Get the title of the shows or movies with rating 5.

-- SELECT `title`
-- FROM `Movie_Episodes`
--JOIN `Rates`
--	ON (`Movie_Episodes`.`episode_number` = `Rates`.`episode_number`
--        AND `Movie_Episodes`.`movie_episode_id` = `Rates`.`movie_episode_id`)
-- WHERE `Rates`.`rating` = 5;

-- 6. Get the Cast Members Not in Die Hard.

-- SELECT `Casts`.`first_name`, `Casts`.`last_name`
-- FROM `Casts`
-- WHERE `Casts`.`cast_id` NOT IN (
--     SELECT `cast_id`
--     FROM `Stars_In`
--     WHERE `movie_episode_id` = 1
-- )
-- ORDER BY `Casts`.`last_name`;




