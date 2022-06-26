-- 14. The names of actors who've appeared in the movies in the "Back to the Future Collection" (28 rows)
select distinct person.person_name
from person
join movie_actor on movie_actor.actor_id = person.person_id
join movie on movie.movie_id = movie_actor.movie_id
join collection on collection.collection_id = movie.collection_id
where collection.collection_name = 'Back to the Future Collection'