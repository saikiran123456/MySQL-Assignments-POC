					# Assignment Number 2
                    
USE Assignment;

						## QUE 1. 
-- select all employees in department 10 whose salary is greater than 3000. [table: employee]
SELECT * FROM employee
WHERE deptno = 10
HAVING salary > 3000.00;
## Result:
-- 800, George, Clooney, 10, 10000.00



						## QUE 2. 
-- The grading of students based on the marks they have obtained is done as follows: [table: students]
-- 40 to 50 -> Second Class
-- 50 to 60 -> First Class
-- 60 to 80 -> First Class
-- 80 to 100 -> Distinctions
# a. How many students have graduated with first class?
SELECT 
	CASE 
		WHEN marks BETWEEN 81 AND 100 then 'Distinction' 
		WHEN marks BETWEEN 51 AND 80 then 'First Class' 
		WHEN marks BETWEEN 40 AND 50 then 'Second class'  
		ELSE 'No Grade Available' 
	END AS Grade,
COUNT(*) AS stud_count
FROM students
WHERE marks BETWEEN 51 AND 80  
GROUP BY 
	CASE 
		WHEN marks BETWEEN 81 AND 100 then 'Distinction' 
		WHEN marks BETWEEN 51 AND 80 then 'First Class' 
		WHEN marks BETWEEN 40 AND 50 then 'Second class'  
		ELSE 'No Grade Available' 
	END;
## Result:
-- First Class, 13

# b. How many students have obtained distinction? [table: students]
SELECT 
	CASE 
		WHEN marks BETWEEN 81 AND 100 then 'Distinction' 
		WHEN marks BETWEEN 51 AND 80 then 'First Class' 
		WHEN marks BETWEEN 40 AND 50 then 'Second class'  
		ELSE 'No Grade Available' 
	END AS Grade,
COUNT(*) AS stud_count
FROM students
WHERE marks > 80  
GROUP BY 
	CASE 
		WHEN marks BETWEEN 81 AND 100 then 'Distinction' 
		WHEN marks BETWEEN 51 AND 80 then 'First Class' 
		WHEN marks BETWEEN 40 AND 50 then 'Second class'  
		ELSE 'No Grade Available' 
	END;
#Result:
-- Distinction, 10





						## QUE 3
-- Get a list of city names from station with even ID numbers only. 
-- Exclude duplicates from your answer.[table: station]
SELECT * FROM station; # Total 501 rows:   id, city, state, lat_n, long_w
SELECT DISTINCT(city) AS Unique_City_Names
FROM station
WHERE MOD(station.id, 2) = 0
ORDER BY City;
-- 230 Rows
SELECT DISTINCT CITY 
FROM STATION 
WHERE (ID % 2) = 0 
ORDER BY CITY ASC;




		### QUE 4
-- Find the difference between the total number of city entries in the table and the number of distinct city entries in the table. 
-- In other words, if N is the number of city entries in station, and N1 is the number of distinct city names in station, 
-- write a query to find the value of N-N1 from station. [table: station]
SELECT COUNT(city) AS N
FROM station;  # N = 501
SELECT COUNT(DISTINCT city) AS N1
FROM station; #N1 = 471

SELECT COUNT(city) - COUNT(DISTINCT city)
FROM station;  
-- Result:30  #(501 - 471)





	### QUE.5 Answer the following
SELECT * FROM station;

## a. Query the list of CITY names starting with vowels (i.e., a, e, i, o, or u) from STATION. 
# Your result cannot contain duplicates. [Hint: Use RIGHT() / LEFT() methods ]
SELECT DISTINCT(city) FROM station WHERE city LIKE 'a%';  
-- Result: 26(a)+18(e)+1(i)+12(o)+5(u) = 62

SELECT DISTINCT(city) AS CITY
FROM station 
WHERE LEFT(city,1) IN ('a','e','i','o','u');
-- 62 Rows

SELECT DISTINCT CITY 
FROM STATION 
WHERE CITY LIKE 'A%' OR CITY LIKE 'E%' OR CITY LIKE 'I%' OR CITY LIKE 'O%' OR CITY LIKE 'U%';
-- Result:  62

SELECT DISTINCT CITY
FROM STATION 
WHERE CITY REGEXP '^[aeiouAEIOU]';
-- Result:  62



## b. Query the list of CITY names from STATION which have vowels (i.e., a, e, i, o, and u) as both their first and last characters. Your result cannot contain duplicates.
SELECT DISTINCT CITY
FROM STATION
WHERE LOWER(LEFT(CITY,1)) IN ('a', 'e', 'i', 'o', 'u') AND
      LOWER(RIGHT(CITY,1)) IN ('a', 'e', 'i', 'o', 'u');
-- 26 Rows

SELECT DISTINCT city
FROM  station
WHERE city RLIKE '^[aeiouAEIOU].*[aeiouAEIOU]$';
-- 26 rows



## c. Query the list of CITY names from STATION that do not start with vowels. Your result cannot contain duplicates.
SELECT DISTINCT City
FROM station
WHERE LEFT(city, 1) NOT IN ('a','e','i','o','u');
-- 409 rows

SELECT DISTINCT CITY 
FROM STATION 
WHERE CITY NOT RLIKE '^[aeiouAEIOU].*$';
-- 409 rows



## d. Query the list of CITY names from STATION that either do not start with vowels or do not end with vowels. 
-- Your result cannot contain duplicates. [table: station]
SELECT DISTINCT(city) AS CITY
FROM station 
WHERE LEFT(city,1) NOT IN ('a','e','i','o','u') OR
	  RIGHT(city,1) NOT IN ('a','e','i','o','u');
-- 445 Rows

SELECT DISTINCT CITY 
FROM STATION 
WHERE CITY NOT RLIKE '^[aeiouAEIOU].*[aeiouAEIOU]$';
-- 445 Rows

SELECT DISTINCT city
FROM   station
WHERE  city REGEXP '^[^aeiouAEIOU]|[^aeiouAEIOU]$';
-- 445 Rows




### QUE 6)
-- Write a query that prints a list of employee names having a salary greater than $2000 per month 
-- who have been employed for less than 36 months. 
-- Sort your result by descending order of salary. [table: emp]
SELECT * FROM Emp 
WHERE Salary > 2000
	AND Hire_Date >= DATE_SUB(CURRENT_DATE, INTERVAL 36 MONTH)
ORDER BY salary DESC;
-- 31 rows




## QUE. 7)
-- How much money does the company spend every month on salaries for each department? [table: employee]
# Expected Result
-- +--------+--------------+
-- | deptno | total_salary |
-- +--------+--------------+
-- |     10 |     20700.00 |
-- |     20 |     12300.00 |
-- |     30 |      1675.00 |
-- +--------+--------------+
-- 3 rows in set (0.002 sec)
SELECT * FROM employee; #empid, fname, lname, deptno, salary

SELECT deptno, SUM(salary) AS total_salary
FROM employee
GROUP BY deptno
ORDER BY total_salary DESC;
#Result:
-- deptno, total_salary
-- '10',  '20700.00'
-- '20',  '12300.00'
-- '30',  '1675.00'





## QUE.8)
-- How many cities in the CITY table have a Population larger than 100000. [table: city]
SELECT * FROM city; #id, name, countrycode, district, population
SELECT name, population FROM city WHERE population > 100000;  # 11 cities
SELECT COUNT(name) AS Population_GreaterThan_100000
FROM city
WHERE population > 100000;
-- 11 rows




## QUE.9)
-- What is the total population of California? [table: city]
SELECT district, SUM(population) AS Total_population
FROM city
WHERE district = 'California';
-- California, 339002



## QUE.10)
-- What is the average population of the districts in each country? [table: city]
SELECT * FROM city; #id, name, countrycode, district, population
SELECT countrycode, district, AVG(population) AS AveragePopulation
FROM city
GROUP BY countrycode;
#Result:
-- NLD	Zuid-Holland	593321.0000
-- USA	Arizona			120225.8750
-- JPN	Osaka			175839.2000




## QUE.11)
-- Find the ordernumber, status, customernumber, customername 
-- and comments for all orders that are ‘Disputed=  [table: orders, customers]

SELECT * FROM orders; #orderNumber, orderDate, requiredDate, shippedDate, status, comments, customerNumber
SELECT * FROM customers; #customerNumber, customerName, phone, city, state, postalCode, country, salesRepEmployeeNumber, creditLimit

SELECT o.orderNumber, o.status, o.customernumber, c.customername, o.comments
FROM orders o
INNER JOIN customers c
ON c.customerNumber = o.customerNumber
WHERE o.status = 'Disputed';
-- # orderNumber, status,     customernumber, customername,                   comments
--   '10406', 	  'Disputed',  '145',         'Danish Wholesale Imports',     'Customer claims container with shipment was damaged during shipping and some items were missing. I am talking to FedEx about this.'
--   '10415', 	  'Disputed',  '471',         'Australian Collectables, Ltd', 'Customer claims the scales of the models don\'t match what was discussed. I keep all the paperwork though to prove otherwise'
--   '10417',     'Disputed',  '141',         'Euro+ Shopping Channel',       'Customer doesn\'t like the colors and precision of the models.'

		# USING clause JOINS
SELECT orderNumber, status, customernumber, customername, comments
FROM orders 
INNER JOIN customers 
USING(customernumber)
WHERE status = 'Disputed';




