-- 11. The titles of the movies in the "Star Wars Collection" ordered by release date, most recent to earliest (9 rows)
select movie.title
from movie
join collection on collection.collection_id = movie.collection_id
where collection.collection_name ='Star Wars Collection'
order by movie.release_date desc
