-- 15. The title of the movie and the name of director for movies where the director was also an actor in the same movie (73 rows)
SELECT movie.title, person.person_name
FROM person
JOIN movie on movie.director_id = person.person_id
JOIN movie_actor on movie_actor.movie_id = movie.movie_id
where movie_actor.actor_id = movie.director_id
