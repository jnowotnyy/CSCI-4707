with Airports as (
	SELECT id
	FROM airport
	WHERE altitude > 10000
), Departed as(
	SELECT source_airport_id
	FROM route
	INTERSECT
	SELECT id
	FROM airports
), Arrive as(
	SELECT destination_airport_id
	FROM route
	INTERSECT
	SELECT id
	FROM airports
	--
), Combine as (
	SELECT airline_id
	FROM route
	INNER JOIN Departed
		ON Departed.source_airport_id = route.source_airport_id
	INNER JOIN Arrive
		ON Arrive.destination_airport_id = route.destination_airport_id
	GROUP BY airline_id
), Solution as (
	SELECT airline.name
	FROM Combine
	INNER JOIN airline
	ON airline.id = Combine.airline_id
)SELECT * FROM Solution;

--PROBLEM 2

with Minneapolis as (
	SELECT id FROM airport
	WHERE round(latitude) = 45
	AND round(longitude) = -93
), Athens as (
	SELECT id FROM airport
	WHERE round(latitude) = 38
	AND round(longitude) = 24
), MN_Routes as (
	SELECT destination_airport_id
	FROM Minneapolis
	INNER JOIN route
	ON route.source_airport_id = Minneapolis.id
), Athens_Routes as (
	SELECT source_airport_id
	FROM Athens
	INNER JOIN route
	ON route.destination_airport_id = Athens.id
), MN_Athens_Stopover as (
	SELECT destination_airport_id
	FROM MN_Routes
	INTERSECT
	SELECT source_airport_id
	FROM Athens_Routes
), Solution as (
	SELECT name, city, country
	FROM airport
	INNER JOIN MN_Athens_Stopover
	ON airport.id = MN_Athens_Stopover.destination_airport_id
) SELECT * FROM Solution;

--Problem 3
with Minneapolis as (
	SELECT id FROM airport
	WHERE round(latitude) = 45
	AND round(longitude) = -93
), MN_Routes as (
	SELECT destination_airport_id
	FROM Minneapolis
	INNER JOIN route
	ON route.source_airport_id = Minneapolis.id
), MN_Airlines as (
	SELECT airline.name
	FROM MN_Routes
	INNER JOIN airline
	ON airline.id = MN_Routes.destination_airport_id
), Solution as (
	SELECT * FROM MN_Airlines
	WHERE MN_Airlines.name not like 'ALASKA'
) SELECT * FROM Solution;

