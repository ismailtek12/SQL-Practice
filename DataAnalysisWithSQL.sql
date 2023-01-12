--What were Total Rental for Family Movies
select count(rental.rental_id) from rental
inner join payment on payment.rental_id=rental.rental_id
inner join inventory on inventory.inventory_id=rental.inventory_id
inner join film_category on film_category.film_id=inventory.film_id
inner join category on category.category_id=film_category.category_id
where category.name='Animation'


--How many movies in each category devided by duration quartile?
select category.name,count(category.category_id) from film
inner join film_category on film_category.film_id=film.film_id
inner join category on category.category_id=film_category.category_id
group by category.name

--What is the number of rentals  for each store

select count(rental_id),store.store_id from rental
inner join inventory on inventory.inventory_id=rental.inventory_id
inner join store on store.store_id=inventory.store_id
group by store.store_id


--How much did our top customers pay in each month in 2007

select sum(amount), customer.customer_id from payment
inner join customer on customer.customer_id=payment.customer_id
group by customer.customer_id
order by sum(amount) desc
limit 10


--Which Category of Family Friendly films had the highest total Rental Orders (Animation,Family,Children)
select title,count(rental.rental_id) from film
inner join film_category on film_category.film_id=film.film_id
inner join category on category.category_id=film_category.category_id
inner join inventory on inventory.film_id=film.film_id
inner join rental on rental.inventory_id=inventory.inventory_id
inner join payment on payment.rental_id=rental.rental_id
where category.name='Family'
group by title
order by count(payment.rental_id) desc



--What are the top and least rented (in-demand) genres and what are what are their total sales
--payment,inventory,film_category,category
select category.name,count(payment.rental_id),sum(payment.amount) from payment
inner join rental on rental.rental_id=payment.rental_id
inner join inventory on inventory.inventory_id=rental.inventory_id
inner join film_category on film_category.category_id=inventory.film_id
inner join category on category.category_id=film_category.category_id
group by category.name
order by count(payment.rental_id) desc
limit 1



--Can we know how many distinct users have rented each genre? In short, yes we can
--rental-payment-customer-inventory-film_category-category
select count(customer.customer_id),first_name,last_name from customer
inner join payment on payment.customer_id=customer.customer_id
inner join rental on rental.rental_id=payment.rental_id
inner join inventory on inventory.inventory_id=rental.inventory_id
inner join film_category on film_category.film_id=inventory.film_id
inner join category on category.category_id=film_category.category_id
where category.name in (select category.name from category )
group by customer.customer_id,first_name,last_name
order by count(customer.customer_id) desc

--What is the Average rental rate for each genre
select avg(film.rental_rate),category.name from film
inner join film_category on film_category.film_id=film.film_id
inner join category on category.category_id=film_category.category_id
group by category.name
order by avg(rental_rate) desc


--In which countries do Rent A Film have a presence in and what is the customer base in each country? What are the total sales in each country?
select country.country,count(distinct customer.customer_id),sum(amount) from payment
inner join customer on customer.customer_id=payment.customer_id
inner join address on address.address_id=customer.address_id
inner join city on city.city_id=address.city_id
inner join country on country.country_id=city.country_id
group by country.country
order by count(distinct customer.customer_id) desc


--Who are the top 5 customers per total sales and can we get their detail just in case Rent A Film wants to reward them
select customer.first_name,customer.last_name,address.address,address.phone,sum(payment.amount) from payment
inner join customer on customer.customer_id=payment.customer_id
inner join address on address.address_id=customer.address_id
group by customer.first_name,customer.last_name,address.address,address.phone
order by sum(payment.amount) desc
limit 5










