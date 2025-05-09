1. Count the number of Movies vs TV ShowsSELECT type,
COUNT(*) as content from netflix
group by type;

2. Find the most common rating for movies and TV shows
select type,
rating
from
(select type,
rating,
count(*),
rank() over(partition by type order by count(*) desc) as ranking
from netflix
group by 1,2) as T1
where
ranking = 1;

3.List all movies released in a specific year (e.g., 2020)
select * from netflix
where type='Movie'
and
release_year=2020;

4.Find the top 5 countries with the most content on Netflix
Select
unnest(string_to_array(country,',')) as new_country,
count(show_id) as total_content from netflix
group by 1
order by 2
limit 5;

5.Identify the longest movie
select * from netflix
where
type='Movie'
AND
duration=(select max(duration) from netflix);

6.Find content added in the last 5 years
select * from netflix
where
to_date(date_added,'month dd,yyyy') >= current_date - interval '5 years';


7.Find all the movies/TV shows by director 'Rajiv Chilaka'!
select * from  netflix
where
director like '%Rajiv Chilaka%';

8.List all TV shows with more than 5 seasons
select * from netflix
where
type='TV Show'
AND
split_part(duration,' ',1)::numeric > 5;

9.Count the number of content items in each genre
select unnest(string_to_array(listed_in,',')) as genre,
count(show_id) as total_content from netflix
group by 1
order by 2 DESC
limit 5;

10.Find each year and the average numbers of content release by India on netflix. Return top 5 year with highest avg content release !
select
extract(year from to_date(date_added,'month dd,yyyy')) as year,
count(*) as total_content,
Round(count(*):: numeric/(select count(*) from netflix where country='India'):: numeric *100
,2) as avg_content
from netflix
where country='India'
group by 1;

11.List all movies that are documentaries
select * from netflix
where
listed_in ilike '%documentaries%';

12.Find all content without a director
select * from netflix
where
director is null;

13.Find how many movies actor 'Salman Khan' appeared in last 10 years!
select * from netflix
where
casts ilike '%salman khan%'
and
release_year > extract(year from current_date)-10;

14.Find the top 10 actors who have appeared in the highest number of movies produced in India.
select unnest(string_to_array(casts,',')) as actors,
count(*) as total_content
from netflix
where country ilike '%india'
group by 1
order by 2 desc
limit 10;
