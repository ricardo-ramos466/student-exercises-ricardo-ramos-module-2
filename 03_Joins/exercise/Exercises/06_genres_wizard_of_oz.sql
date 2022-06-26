-- 6. The genres of "The Wizard of Oz" (3 rows)
select genre.genre_name
from genre
join movie_genre on movie_genre.genre_id = genre.genre_id
join movie on movie.movie_id = movie_genre.movie_id
where movie.title = 'The Wizard of Oz'