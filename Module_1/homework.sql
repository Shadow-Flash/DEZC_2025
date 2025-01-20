SELECT 
cast(lpep_pickup_datetime as date) as date,
sum(trip_distance),
count(lpep_pickup_datetime) 
FROM public.green_taxi_data
where lpep_pickup_datetime >= '2019-10-01'::date and lpep_pickup_datetime < '2019-11-01'::date and trip_distance <= 10 and trip_distance > 7
Group by cast(lpep_pickup_datetime as date)
Order by count asc


select tzd."Zone", sum(gtd.total_amount), cast(gtd.lpep_pickup_datetime as date) as pickup from public.green_taxi_data as gtd
join public.taxi_zone_data as tzd
on gtd."PULocationID" = tzd."LocationID"
where cast(lpep_pickup_datetime as date) = '2019-10-18'::date
group by tzd."Zone", cast(gtd.lpep_pickup_datetime as date)
order by sum desc

select tz."Zone", max(gtd.tip_amount) from public.green_taxi_data as gtd
join public.taxi_zone_data as tzd
on gtd."PULocationID" = tzd."LocationID"
join public.taxi_zone_data as tz
on gtd."DOLocationID" = tz."LocationID" 
where cast(lpep_pickup_datetime as date) >= '2019-10-01'::date 
and cast(lpep_pickup_datetime as date) <= '2019-10-31'::date
and tzd."Zone" = 'East Harlem North'
group by gtd.tip_amount, tz."Zone"
order by max desc



select * from public.taxi_zone_data
select * from public.green_taxi_data limit 10

SELECT cast(lpep_pickup_datetime as date) as date, max(trip_distance) FROM public.green_taxi_data 
Group by cast(lpep_pickup_datetime as date)
Order by max desc
limit 10