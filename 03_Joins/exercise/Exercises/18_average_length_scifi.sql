-- 18. The average length of movies in the "Science Fiction" genre. Name the column 'average_length'.
-- (1 row, expected result around 110-120)
SELECT avg(m.length_minutes) AS average_length
FROM movie AS m
JOIN movie_genre AS mg ON mg.movie_id = m.movie_id
JOIN genre AS g ON g.genre_id = mg.genre_id
WHERE g.genre_name = 'Science Fiction'
