USE albums_db;
DESCRIBE albums;

select * from albums;

# 3(a) 31 Rows

# 3(b) 23 unique artists
select distinct artist from albums;

#3(c) id 

#3(d) 1967

#4(a)
select * from albums where artist = 'Pink Floyd';

#4(b)
select name, release_date from albums where name = 'Sgt. Pepper''s Lonely Hearts Club Band';

#4(c)
select genre, name from albums where name = 'Nevermind';

#4(d)
select name, release_date from albums where release_date < 2000 AND release_date > 1989;

#4(e)
select name, sales from albums where sales < 20.0;

#4(f)
select name, genre from albums where genre = 'Rock';
# 'Rock', 'Hard Rock', and 'Progressive Rock' are all different strings and do not
# equal each other, so only 'Rock' is selected. 


