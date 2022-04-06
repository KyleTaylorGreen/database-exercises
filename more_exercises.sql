/********************************************** Exercise 1 *********************************************************/
# a) Select all columns from the actor table.
USE sakila;

SELECT * 
FROM actor;

# b) Select only the last_name column from the actor table.

SELECT last_name
FROM actor;

# c) Select only the film_id, title, and release_year columns from the film table.

SELECT film_id, title, release_year
FROM film;


/********************************************** Exercise 2 *********************************************************/

# a) Select all distinct (different) last names from the actor table.

SELECT DISTINCT last_name
FROM actor;

# b) Select all distinct (different) postal codes from the address table.

SELECT DISTINCT postal_code
FROM address;

# c) Select all distinct (different) ratings from the film table.

SELECT DISTINCT rating
FROM film;