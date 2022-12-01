
-- 1. Get all pairs of actors that worked together.

select a1.actor_id, a1.film_id, a2.actor_id from film_actor a1
join film_actor a2
on a1.film_id=a2.film_id
and a1.actor_id<a2.actor_id;

-- 2. Get all pairs of customers that have rented the same film more than 3 times.

select a1.customer_id, a1.count, a1.film_id, a2.customer_id, a2.count

from (
select customer_id, film_id, count(rental_id) as count from rental
join inventory using(inventory_id)
group by customer_id, film_id
having count(rental_id)>1 ) a1

join (
select customer_id, film_id, count(rental_id) as count from rental
join inventory using(inventory_id)
group by customer_id, film_id
having count(rental_id)>1 ) a2

on a1.film_id=a2.film_id
and a1.customer_id<>a2.customer_id;

-- 3. Get all possible pairs of actors and films.

select * from (
	select distinct actor_id from film_actor
    join actor using(actor_id)
) a1
cross join (
	select distinct film_id from film_actor
    join actor using(actor_id)
) a2;