USE albums_db;
DESCRIBE albums;
-- 3. structure tab or describe query: Primary key, id. Some numeric inputs (id, release_date, sales). Some string inputs (artist, name, genre)
-- a. There are 31 rows of data in albums table (looking at content tab)
SELECT DISTINCT artist FROM albums;
-- b. There are 23 unique artists in the albums table.
-- c. The primary key is the id variable (DESCRIBE query). 
-- d. Oldest release date is 1967 (sorting by release date in content tab), Most recent is 2011. 
SELECT artist, name FROM albums WHERE artist = "Pink Floyd";
-- 4. a. The Dark Side of the Moon, The Wall
SELECT name, release_date FROM albums WHERE name = "Sgt. Pepper's Lonely Hearts Club Band";
-- b. 1967
SELECT name, genre FROM albums WHERE name = "Nevermind";
-- c. Grunge, Alternative Rock
SELECT name, release_date FROM albums WHERE release_date > 1989 AND release_date < 2000;
SELECT name, release_date FROM albums WHERE release_date BETWEEN 1990 and 1999;
-- d. 11 Total albums in 1990s: The Bodyguard, Jagged Little Pill, Come On Over, Falling into You, Let's Talk About Love, Dangerous, The Immaculate Collection, Titanic: Music from the Motion Picture, Metallica, Nevermind, Supernatural 
SELECT name, sales FROM albums WHERE sales < 20;
-- e. Grease, Bad, Sgt. Pepper's..., Dirty Dancing, Let's Talk About Love, Dangerous, The Immaculate Collection, Abbey Road, Born in the USA, Brothers in Arms,  Titanic, Nevermind, The Wall
SELECT name, genre FROM albums WHERE genre = "Rock";
-- f. Sgt. Pepper's.., 1, Abbey Road, Borne in the USA, Supernatural. It does not show other genres with 'rock' included bc string queries are looking for an exact match.

