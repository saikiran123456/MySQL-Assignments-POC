					### Assignment 3
        
USE Assignment;
### QUE.1)
-- Write a stored procedure that accepts the month and year as inputs 
-- and prints the ordernumber, orderdate and status of the orders placed in that month. 
-- Example:  call order_status(2005, 11);
SELECT * FROM orders; #orderNumber, orderDate, requiredDate, shippedDate, status, comments, customerNumber
Delimiter //
CREATE PROCEDURE order_status(IN year1 INT, IN month1 varchar(10))
BEGIN
	select ordernumber, orderdate, status from orders 
	where YEAR(orderdate)=year1 and MONTH(orderdate)=month1;
END //
# Call the Above Procedure by Giving YEAR and Month as Input!
call order_status(2004, 11);
#Ans: ordernumber, orderdate,  status
--    10316	     2004-11-01	   Shipped...


# To Extract Month and Year from DATE column!
SELECT ordernumber, orderdate, status, MONTH(orderdate) AS Month, YEAR(orderdate) AS YEAR 
FROM  orders;




### QUE.2)
-- Write a stored procedure to insert a record into the cancellations table for all cancelled orders.
# STEPS: 
## a.Create a table called cancellations with the following fields
-- id (primary key), 
-- customernumber (foreign key - Table customers), 
-- ordernumber (foreign key - Table Orders), 
-- comments
# All values except id should be taken from the order table.
## b. Read through the orders table . 
## If an order is cancelled, then put an entry in the cancellations table.
-- Solution:
SELECT * FROM customers; #customerNumber, customerName, phone, city, state, postalCode, country, salesRepEmployeeNumber, creditLimit
SELECT * FROM orders;  #orderNumber, orderDate, requiredDate, shippedDate, status, comments, customerNumber

DELIMITER //
CREATE PROCEDURE procedure_2()
BEGIN
	CREATE TABLE IF NOT EXISTS cancellations(
	ID INT PRIMARY KEY AUTO_INCREMENT,
	customerNumber INT NOT NULL,
	orderNumber INT NOT NULL, 
	comments TEXT DEFAULT NULL,
	FOREIGN KEY(customerNumber) REFERENCES customers(customerNumber) ,
	FOREIGN KEY(orderNumber) REFERENCES orders(orderNumber)
	ON UPDATE CASCADE
	ON DELETE CASCADE
);
INSERT INTO cancellations(customerNumber,orderNumber,comments)
SELECT customerNumber, orderNumber, comments from orders where status='Cancelled';
END //
-- Result: Call the procedure_2
CALL procedure_2;
-- See the Result by Retrieving cancellations table
SELECT * FROM cancellations;
-- All the Values of Exccept ID is inserted in cancellation table from orders!
-- and only the Cancelled Orders are read and Inserted in the cancellation Table from Orders table!





### QUE.3)
# 3.a] 
-- Write function that takes the customerNumber as Input 
-- and returns the purchase_status based on the following criteria.[table:Payments]
-- if the 'total' purchase amount for the customer is < 25000 status = Silver, 
-- amount between 25000 and 50000, status = Gold
-- if amount > 50000 Platinum
SELECT * FROM payments; #customerNumber, checkNumber, paymentDate, amountcustomerNumber, checkNumber, paymentDate, amount
SELECT SUM(amount) AS total_amount FROM payments; # 8853839.23

DELIMITER //
CREATE FUNCTION Function_purchase_status(
fcustomerNumber INT)
RETURNS VARCHAR(20)
DETERMINISTIC
BEGIN

	DECLARE status VARCHAR(20);
    DECLARE credit DECIMAL DEFAULT 0;
    
    SET credit = (SELECT SUM(amount) FROM payments WHERE customerNumber = fcustomerNumber);
    
    IF credit > 50000 THEN
		SET status = 'PLATINUM';
	ELSEIF (credit >= 25000 AND credit <= 50000) THEN
		SET status = 'GOLD';
	ELSEIF credit < 25000 THEN
		SET status = 'SILVER';
	END IF;
    RETURN (status);
    
END //
# Result;
# customerNumbers.: 103(22314.36), 112, 119 etc
select DISTINCT(Function_purchase_status(103)) FROM payments;  # SILVER  (22314.36)
select DISTINCT(Function_purchase_status(112)) FROM payments;  #Platinum
select DISTINCT(Function_purchase_status(489)) FROM payments;  #GOLD


## 3.b] 
-- Write a query that displays customerNumber, customername and purchase_status from customers table.
SELECT customerNumber, customername, status AS purchase_status 
FROM customers
INNER JOIN orders
USING(customerNumber);
select * from customers;

DELIMITER //
CREATE PROCEDURE Procedure_3b()
BEGIN
	SELECT customers.customerNumber, customerName,
	CASE
		WHEN amount < 25000 THEN 'SILVER'
		WHEN amount BETWEEN 25000 AND 50000 THEN 'GOLD'
		WHEN amount > 50000 THEN 'PLATINUM'
	END AS purchaseStatus
	FROM payments
	INNER JOIN customers ON payments.customerNumber = customers.customerNumber;
END //
# Result: Call the function
CALL assignment.Procedure_3b(); 
#273 records retrieved with customerNumber, customerName, purchaseStatus



	
## QUE.4)
# 4. Replicate the functionality of 'ON DELETE CASCADE' and 'ON UPDATE CASCADE' 
-- using TRIGGERS on movies and rentals tables. 
-- **Note: Both tables - movies and rentals - don't have primary or foreign keys. 
-- Use only Triggers to implement the above.
SELECT * FROM movies; # id, title, category
SELECT * FROM rentals; # memid, first_name, last_name, movieid
# 4.a] 
-- Using Timing=AFTER and Event=UPDATE
DELIMITER //     
CREATE  TRIGGER UPDATE_cascade1
AFTER UPDATE 
ON movies FOR EACH ROW
BEGIN
	UPDATE rentals SET movieid = NEW.id
	WHERE movieid = OLD.id;
END //
# Result:
-- UPDATE the Movies Table and see the changes in Rentals table
SELECT * FROM movies;
#  id, title,  category   (Sample)
-- 5,  Safe,   Action
-- Updating Action Category having IDs 7,8,9 to 5 and see the result in rentals table having any of movieid 7,8,9 changed to 5
UPDATE movies 
SET id = 5
WHERE category = '18+';  # 
-- See in Rentals table for changes
SELECT * FROM rentals;  #here  movieid=8 changed to 5


# 4.b]  
-- Using Timing=BEFORE and Event=DELETE
DELIMITER //
CREATE TRIGGER DELETE_cascade1
BEFORE DELETE 
ON movies FOR EACH ROW 
BEGIN
	DELETE from rentals 
    WHERE movieid = OLD.id;
END //
SELECT * FROM rentals;
SELECT * FROM movies;
-- Tring to delete id=1 from Movies table
DELETE FROM movies
WHERE id = 1;
SELECT * FROM rentals; #Now here movieid = 1 got deleted successfully(i.e movieid has 1)

DELETE FROM movies
WHERE id = 3;
SELECT * FROM rentals; #nothing got deleted for id= because no movid=3 in rentals table!

DELETE FROM movies
WHERE id = 2;
SELECT * FROM rentals; #Now here movieid = 2 got deleted successfully(i.e movieid was 1)



## QUE.5)
-- Select the first name of the employee who gets the third highest salary. [table: employee]
select * from employee; #empid, fname, lname, deptno, salary
SELECT fname, salary AS ThirdHighest_Salary
FROM employee
ORDER BY salary DESC
LIMIT 2,1;
# Result:  Gregory, 3500.00




## QUE.6)
-- Assign a rank to each employee  based on their salary. 
-- The person having the highest salary has rank 1. [table: employee]
select * from employee; #empid, fname, lname, deptno, salary

SELECT DENSE_RANK() OVER(ORDER BY salary DESC) AS Ranks, salary, fname 
FROM employee;
#Result:
-- Ranks, salary,   fname
-- 1	  10000.00	George
-- 2	  7500.00	Hugh
-- 3	  3500.00	Gregory
-- 4	  3000.00	Tom
-- 4	  3000.00	Henry
-- 5	  2700.00	Jean
-- 6	  2000.00	Jon
-- 7	  1300.00	Johnny
-- 8	  850.00	Hugh
-- 9	  750.00	Tom
-- 10	  75.00	    Ben


