-- 9. The titles of movies directed by James Cameron (6 rows)
select movie.title
from movie
join person on person.person_id = movie.director_id
where person.person_name = 'James Cameron'

