/*Count of TV shows and Movies*/

SELECT type, count(type) FROM netflix_data
GROUP BY type


/*Average Imdb Votes for TV shows and Movies*/

SELECT type, ROUND(AVG(imdb_votes),1) FROM netflix_data
GROUP BY type

/*Most Popular TV Show and Movie by Imdb Rating*/

WITH rating AS(SELECT title, type, release_year, imdb_rating, 
RANK() OVER(PARTITION BY type 
	   ORDER BY imdb_rating DESC) AS rank_in_type
FROM netflix_data
WHERE imdb_votes > 100000)

SELECT * FROM rating
WHERE rank_in_type = 1


/*Most Popular TV and Movie Genres by Count*/

SELECT genres, COUNT(type) FROM netflix_data
WHERE type = 'tv'
GROUP BY genres
ORDER BY count(type) DESC
LIMIT 5

SELECT genres, COUNT(type) FROM netflix_data
WHERE type = 'movie'
GROUP BY genres
ORDER BY count(type) DESC
LIMIT 5


/*Most Popular TV and Movie Genres by Average Imdb Votes*/

SELECT genres, ROUND(AVG(imdb_votes),1), COUNT(genres) FROM  netflix_data
WHERE type = 'tv'
GROUP BY genres
HAVING COUNT(genres) > 20
ORDER BY AVG(imdb_votes) DESC
LIMIT 5

SELECT genres, ROUND(AVG(imdb_votes),1), COUNT(genres) FROM  netflix_data
WHERE type = 'movie'
GROUP BY genres
HAVING COUNT(genres) > 20
ORDER BY sum(imdb_votes) DESC
LIMIT 5





