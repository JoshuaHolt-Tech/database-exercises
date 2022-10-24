-- This is the begging of the question three answers:

USE albums_db;

-- Explore the structures of the albums table
DESCRIBE albums;

--  How many rows are in the albums table?
SELECT COUNT(*)
FROM albums;

-- How many unique artist names are in the albums table?
SELECT DISTINCT artist
FROM albums;

-- What is the primary key for the albums table?
SELECT id
FROM albums;

-- What is the oldest release date for any album in the albums table?
SELECT min(release_date) FROM albums;

-- What is the most recent release date?
SELECT max(release_date) FROM albums;

-- This is the beginning of the question four answers:

-- The name of all albums by Pink Floyd
SELECT name
FROM albums
WHERE artist = 'Pink Floyd';

-- The year Sgt. Pepper's Lonely Hearts Club Band was released
SELECT release_date
FROM albums
WHERE name = 'Sgt. Pepper\'s Lonely Hearts Club Band';

-- The genre for the album Nevermind
SELECT genre
FROM albums
WHERE name = 'Nevermind';

-- Which albums were released in the 1990s
SELECT name, release_date
FROM albums
WHERE release_date BETWEEN 1990 AND 1999;

-- Which albums had less than 20 million certified sales
SELECT name, sales
FROM albums
WHERE sales < 20.0;

-- All the albums with a genre of "Rock". Why do these query results not include albums with a genre of "Hard rock" or "Progressive rock"?

SELECT name
FROM albums
WHERE genre = 'Rock';

-- Our search evaluates if a string is equivalent to 'Rock' but not if a longer string contains the sequence 'Rock'. The lower case 'r' does not matter.



