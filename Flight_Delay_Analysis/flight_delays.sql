/*The dataset used in the below analysis contained only late flights. For further late 
flightexploration and greater detail, on-time flight data during the same time period should be 
used in conjunction with the plane_data.csv data to identify percentages of late flights by 
flight categories*/


/*Percentage of Carrier and Late Aircraft 
Delays Contributing to Total Delay Time*/

SELECT ROUND(SUM(CAST(carrierdelay AS DECIMAL(10,2)))/
			SUM(CAST(arrdelay AS DECIMAL (10,2))),2) * 100 as carrier_delay_perc
			FROM plane_data
			
SELECT ROUND(SUM(CAST(lateaircraftdelay AS DECIMAL(10,2)))/
			SUM(CAST(arrdelay AS DECIMAL (10,2))),2) * 100 as airtcraft_delay_perc
			FROM plane_data

/*Average Lateness in Minutes*/

SELECT ROUND(AVG(arrdelay),2) FROM plane_data

/*Latest Flights*/

SELECT * FROM plane_data
ORDER BY arrdelay DESC
LIMIT 5

/*Late Flights by Month*/

SELECT EXTRACT(MONTH FROM date) as month,
COUNT(EXTRACT(MONTH FROM date))FROM plane_data
GROUP BY EXTRACT(MONTH FROM date)
ORDER BY COUNT(EXTRACT(MONTH FROM date)) DESC

/*Late Flights by Day of The Week*/

SELECT dayofweek, COUNT(dayofweek) FROM plane_data
GROUP BY dayofweek
ORDER BY COUNT(dayofweek) DESC

/*Late Flights by Departure Airport*/

SELECT org_airport, COUNT(org_airport) FROM plane_data
GROUP BY org_airport
ORDER BY COUNT(org_airport) DESC

/*Late Flights by Airline*/

SELECT airline, COUNT(airline) FROM plane_data
GROUP BY airline
ORDER BY COUNT(airline) DESC

/*Late Flights by Length of Flight*/

WITH flight_length AS (SELECT CASE 
	 WHEN distance < 500 THEN 'short'
	 WHEN distance >= 500 AND distance <= 2000 THEN 'moderate'
	 ELSE 'long' END as length FROM plane_data)

SELECT length, COUNT(length) FROM flight_length
GROUP BY length
ORDER BY COUNT(length) DESC
		
	   



