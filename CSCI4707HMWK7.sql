--with SelectedAirports as (
	--SELECT id
	--FROM airport
	--WHERE altitude > 10000
--), SelectedId1 as(
	--SELECT route.airline_id
	--FROM SelectedAirports
	--INNER JOIN route
	--ON route.source_airport_id = SelectedAirports.id
	--AND route.destination_airport_id = SelectedAirports.id
	--GROUP BY airline_id
--), Solution as (
	--SELECT airline.name
	--FROM CombineIds
	--INNER JOIN airline
	--ON airline.id = CombineIds.airline_id
--)
--SELECT * FROM Solution;

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
	WHERE airport.id = MN_Athens_Stopover.destination_airport_id
) SELECT * FROM Solution;
