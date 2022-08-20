			### Assignment 1

## QUE.1)
#Create a database called 'assignment' (Note please do the assignment tasks in this database)
CREATE DATABASE IF NOT EXISTS Assignment1;
USE Assignment1;


## QUE.2)
#Create the tables from ConsolidatedTables.sql and enter the records as specified in it.
SHOW tables;


/********************************************************************************/

### QUE.3)
#Create a table called countries with the following columns: name, population, capital  
-- choose appropriate datatypes for the columns
DROP TABLE IF EXISTS countries;

CREATE TABLE countries (
    name VARCHAR(30),
    population INT,
    capital VARCHAR(30)
);
SHOW TABLES;  #countries table structure inserted in db!

SELECT * FROM countries;
## Que. 3.a) Insert the following data into the table
INSERT INTO countries VALUES('China' , 1382, 'Beijing'),('India', 1326,'Delhi'),('United States', 324, 'Washington D.C.'),
						    ('Indonesia', 260, 'Jakarta'),('Brazil', 209, 'Brasilia'),('Pakistan', 193, 'Islamabad'),
						    ('Nigeria',187, 'Abuja'),('Bangladesh', 163, 'Dhaka'),('Russia', 143,  'Moscow'),
						    ('Mexico', 128, 'Mexico City'),('Japan', 126, 'Tokyo'),('Philippines', 102, 'Manila'),
                            ('Ethiopia', 101, 'Addis Ababa'),('Vietnam ', 94, 'Hanoi'),('Egypt', 93, 'Cairo'),
                            ('Germany', 81, 'Berlin'),('Iran', 80, 'Tehran'),('Turkey', 79, 'Ankara'),
                            ('Congo', 79, 'Kinshasa'),('France', 64, 'Paris'),('United Kingdom', 65, 'London'),
                            ('Italy', 60, 'Rome'),('South Africa', 55, 'Pretoria'),('Myanmar', 54, 'Naypyidaw');
SELECT * FROM countries;
-- All the 24 records got inserted!

-- insert into countries value('China' , 1382,  'Beijing');
-- insert into countries value('India', 1326, 'Delhi');
-- insert into countries value('United States', 324, 'Washington D.C.');
-- insert into countries value('Indonesia', 260,  'Jakarta');
-- insert into countries value('Brazil', 209,  'Brasilia');
-- insert into countries value('Pakistan', 193, 'Islamabad');
-- insert into countries value('Nigeria',187, 'Abuja');
-- insert into countries value('Bangladesh', 163, 'Dhaka');
-- insert into countries value('Russia', 143,  'Moscow');
-- insert into countries value('Mexico', 128, 'Mexico City');
-- insert into countries value('Japan', 126, 'Tokyo');
-- insert into countries value('Philippines', 102, 'Manila');
-- insert into countries value('Ethiopia', 101, 'Addis Ababa');
-- insert into countries value('Vietnam ', 94, 'Hanoi');
-- insert into countries value('Egypt', 93, 'Cairo');
-- insert into countries value('Germany', 81, 'Berlin');
-- insert into countries value('Iran', 80, 'Tehran');
-- insert into countries value('Turkey', 79, 'Ankara');
-- insert into countries value('Congo', 79, 'Kinshasa');
-- insert into countries value('France', 64, 'Paris');
-- insert into countries value('United Kingdom', 65, 'London');
-- insert into countries value('Italy', 60, 'Rome');
-- insert into countries value('South Africa', 55, 'Pretoria');
-- insert into countries value('Myanmar', 54, 'Naypyidaw');

## Que.b) Add a couple of countries of your choice
INSERT INTO countries VALUES('Ukraine', 50, 'Kyiv');
INSERT INTO countries VALUES('Australia', 49, 'Canberra');
SELECT * FROM countries; #26 rows are there! 2 rows from 24 got added!


## Que.c) Change ‘Delhi' to ‘New Delhi'
UPDATE countries
SET capital = 'New Delhi'
WHERE capital = 'Delhi';
SELECT * FROM countries; # Delhi got renamed to New Delhi
/*****************************************************/

# 4. Rename the table countries to big_countries.
ALTER TABLE countries
RENAME big_countries;


/******************************************************/
### QUE.5)
# Create the following tables. Use auto increment wherever applicable
## Que.5.a) Product
-- product_id - primary key
-- product_name - cannot be null and only unique values are allowed
-- description
-- supplier_id - foreign key of supplier table
DROP TABLE IF EXISTS Product;
CREATE TABLE Product(
    product_id INT PRIMARY KEY AUTO_INCREMENT,
    product_name VARCHAR(20) NOT NULL UNIQUE,
    description VARCHAR(50),
    supplier_id INT,
    FOREIGN KEY(supplier_id) REFERENCES Suppliers(supplier_id)
	ON DELETE CASCADE ON UPDATE CASCADE
);

## Que.5.b) Suppliers "PARENT TABLE"
-- supplier_id - primary key
-- supplier_name
-- location
CREATE TABLE Suppliers (
    supplier_id INT PRIMARY KEY AUTO_INCREMENT,
    supplier_name VARCHAR(10),
    location VARCHAR(10)
);

## Que.5.c) Stock
-- id - primary key
-- product_id - foreign key of product table
-- balance_stock
CREATE TABLE Stock(
id INT PRIMARY KEY AUTO_INCREMENT,
product_id INT,
balance_stock INT,
FOREIGN KEY(product_id) REFERENCES Product(product_id)
ON DELETE CASCADE ON UPDATE CASCADE
);

/*************************************************************************/

### QUE.6)
# Enter some records into the three tables.

-- 6.a) First insert in PARENT TABLE which is "Suppliers" Table
INSERT INTO Suppliers(supplier_name, location)
VALUES('A1','Delhi'),('B1','Mumbai'),('C1','Chennai'),('D1','Hyderabad');

-- Now Inserting in CHILD Tables:- Product and Stock
-- 6.b) Product:
INSERT INTO Product(product_name, description, supplier_id)
VALUES ('Laptop', 'Lenovo Laptops','3'),('SonyPS', 'Sony Playstation Consoles','2'),('Smart-Phones', 'Samsung Phones','1');
-- 6.c) Stock:
INSERT INTO Stock(product_id)
VALUES (1),(3),(2);
-- Results:
SELECT * FROM Product; #All 3 records inserted!
SELECT * FROM Suppliers; #All 4 records inserted!
SELECT * FROM Stock; #All 3 records inserted!


UPDATE Stock
SET balance_stock = 1211
WHERE id = 1;
UPDATE Stock
SET balance_stock = 3000
WHERE id = 2;
UPDATE Stock
SET balance_stock = 2309
WHERE id = 3;

/************************************************/

### QUE.7)
#Modify the supplier table to make supplier name unique and not null.
SELECT * FROM Suppliers; # As of Now: `supplier_name` has varchar(10) DEFAULT NULL,
#7.a) ADD UNIQUE Constraint
ALTER TABLE Suppliers
ADD CONSTRAINT UNIQUE(supplier_name); # UNIQUE KEY `supplier_name` (`supplier_name`)
-- Result: Unique Constraint added to supplier_name column!

-- 7.b) Change supplier_name column NULL to NOT NULL
ALTER TABLE Suppliers
MODIFY supplier_name VARCHAR(10) NOT NULL; #supplier_name` varchar(10) NOT NULL
-- Result:  UNIQUE Key constraint added to supplier_name column

alter table suppliers modify suppliers_name varchar(255) unique not null;


/*************************************************/
### QUE.8) 
#Modify the emp table as follows:-
# 8.a] Add a column called deptno
# 8.b] Set the value of deptno in the following order
-- deptno = 20 where emp_id is divisible by 2
-- deptno = 30 where emp_id is divisible by 3
-- deptno = 40 where emp_id is divisible by 4
-- deptno = 50 where emp_id is divisible by 5
-- deptno = 10 for the remaining records.
-- ANS : First Create Employee table with some Columns
CREATE TABLE emp(
emp_id INT(10) PRIMARY KEY AUTO_INCREMENT,
first_name VARCHAR(50),
last_name VARCHAR(50),
birth_date  date NOT NULL,
gender  enum('M','F') NOT NULL,
hire_date  date NOT NULL,
salary float(8,2) DEFAULT 25000.00 #CHECK(salary > 25000.00) 
)AUTO_INCREMENT = 100;

SELECT * FROM emp; #emp_id, first_name, last_name, birth_date, gender, hire_date, salary
DESC emp;

-- Now Inserting Some Values in employee table!
INSERT INTO emp(first_name, last_name,birth_date,gender,hire_date) #, salary
VALUES('Kedar', 'Das', '1953-09-19','M', '2020-05-31' ),  # ,25000.01
	  ('Keil', 'Mas', '1953-06-14','F', '2021-06-30'),  # ,35000.00
      ('Frid', 'Las', '1953-02-17','M', '2018-02-28'), #, 45000.00
      ('Fond', 'Meg', '1953-08-25','F', '2019-01-31'), #, 55000.00
      ('Jebra', 'Nas', '1953-07-21','M', '2017-12-31'), #, 65000.00
      ('Tod', 'Lopez', '1945-01-19','F', '2015-11-30'), #,'65000'
      ('Sunny', 'Nant', '1955-12-02','M', '2014-08-31'); #,'65000'
      
SELECT * FROM emp; #All the 7 records got inserted in 'emp' table
      
# 8.a)
-- Add a column called deptno
ALTER TABLE emp
ADD deptno INT(10);  #deptno got added with NULL values!
SELECT * FROM emp; #New column 'deptno' got added!


# 8.b)
-- Set the value of deptno in the following order
-- deptno = 20 where emp_id is divisible by 2
SELECT * FROM emp; #As of now all 7 rows are NULL
UPDATE emp
SET deptno = 20
WHERE emp_id%2=0;
#Result:  'dept_no' column row numbers: 1,3,5,7 got inserted by 20 and rest all NULL
-- deptno = 30 where emp_id is divisible by 3
UPDATE emp
SET deptno = 30
WHERE emp_id%3=0;
SELECT * FROM emp;  #deptno columns row:3,6 got updated with 30!

-- deptno = 40 where emp_id is divisible by 4
UPDATE emp
SET deptno = 40
WHERE emp_id%4=0;
SELECT * FROM emp; #deptno columns row:1,5 got updated with 40!

-- deptno = 50 where emp_id is divisible by 5
UPDATE emp
SET deptno = 50
WHERE emp_id%5=0;
SELECT * FROM emp; #deptno columns row:1,6 got updated with 50!

-- deptno = 10 for the remaining records.
UPDATE emp
SET deptno = 10
WHERE emp_id%1=0;
SELECT * FROM emp; #deptno columns All the rows got updated with 10!

/**************************************************************************/

### QUE.9)
# Create a unique index on the emp_id column.
SELECT * FROM emp;
DESC emp; #-> As of now: emp_id is: NOT NULL, PRIMARY_KEY, & Auto_Increment
-- 9.a DROP the PK first, and Modify it to INT and NULL
ALTER TABLE emp
DROP PRIMARY KEY, MODIFY emp_id INT NULL;
DESC emp; ## Result: Null and no key assigned and Auto_Increment removed!

-- To Assign 'UNIQUE KEY' Constraint
ALTER TABLE emp 
ADD CONSTRAINT UNIQUE(emp_id);
DESC emp; #Result: noy UNIQUE is added to emp_id column in emp table!

-- MODIFY to NOT NULL
-- ALTER TABLE emp
-- MODIFY emp_id INT NULL;

/***************************************************************************************************/

## QUE.10)
# Create a view called emp_sal on the emp table by selecting 
--  the following fields in the order of highest salary to the lowest salary.
-- emp_no, first_name, last_name, salary
SELECT * FROM emp;
CREATE VIEW EMP_SAL AS
SELECT emp_id, first_name, last_name, salary
FROM emp
ORDER BY salary DESC;
#Result: VIEW got created!
#Call the View by Executing from LHS Tab or by;
SELECT * FROM assignment1.emp_sal;

-- Below Script written from scratch to create a new table inserting the values and creating the View for same!
CREATE TABLE Employee1(
emp_id INT(10) PRIMARY KEY AUTO_INCREMENT,
first_name VARCHAR(50),
last_name VARCHAR(50),
birth_date  date NOT NULL,
gender  enum('M','F') NOT NULL,
hire_date  date NOT NULL,
salary float(8,2) CHECK(salary > 25000.00) 
)AUTO_INCREMENT = 100;

select * from employee1;
desc employee1;

ALTER TABLE employee1
CHANGE COLUMN emp_id emp_no INT(10) AUTO_INCREMENT;

INSERT INTO Employee1(first_name, last_name,birth_date,gender,hire_date,salary) #, salary
VALUES('Kedar', 'Das', '1953-09-19','M', '2020-05-31',25000.01),  # 
	  ('Keil', 'Mas', '1953-06-14','F', '2021-06-30',35000.00),  # 
      ('Frid', 'Las', '1953-02-17','M', '2018-02-28',45000), #
      ('Fond', 'Meg', '1953-08-25','F', '2019-01-31',55000), #
      ('Jebra', 'Nas', '1953-07-21','M', '2017-12-31',30000), #
      ('Tod', 'Lopez', '1945-01-19','F', '2015-11-30',65000), #
      ('Sunny', 'Nant', '1955-12-02','M', '2014-08-31',60000); #

CREATE VIEW emp_salVIEW AS
SELECT emp_no, first_name, last_name, salary
FROM employee1
ORDER BY salary DESC;






