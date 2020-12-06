with Airports as (
	SELECT id
	FROM airport
	WHERE altitude > 10000
), Departed as(
	SELECT route.airline_id
	FROM SelectedAirports
	INNER JOIN route
	ON route.source_airport_id = Airports.id
), Arrive as(
	SELECT route.airline_id
	FROM SelectedAirports
	INNER JOIN route
	ON route.destination_airport_id = Airports.id
), Combine as (
	SELECT Departed.source_airport_id
	FROM Departed
	INNER JOIN Arrive
	ON departed.source_airport_id  = arrive.source_airport_id
	GROUP BY source_airport_id
Solution as (
	SELECT airline.name
	FROM Combine
	INNER JOIN airline
	ON airline.id = Combine.airline_id
)
SELECT * FROM Solution;

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
	SELECT * FROM MN_Airline
	WHERE airline.name not like 'ALASKA'
	GROUP BY airline.name
) SELECT * FROM Solution;

