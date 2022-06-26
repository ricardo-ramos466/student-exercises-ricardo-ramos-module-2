-- 13. The directors of the movies in the "Harry Potter Collection" (4 rows)
select distinct person.person_name
from person
join movie on movie.director_id = person.person_id
join collection on collection.collection_id = movie.collection_id
where collection.collection_name = 'Harry Potter Collection'
