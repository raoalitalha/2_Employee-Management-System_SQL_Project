-- Project: Employee Management System

-- Description:
-- The Employee Management System project aims to create a comprehensive database system to manage employee information for a company. This project involves designing tables to store employee details such as employee ID, name, position, and department. It also includes managing employee salaries and bonuses, tracking employee attendance, and generating reports.

-- Purpose:
-- The purpose of this project is to demonstrate my proficiency in SQL and showcase my skills in database design, data manipulation, and generating reports. By implementing an Employee Management System, I can effectively manage employee data, track attendance, and calculate salaries for better organizational management.

-- What you can learn:
-- By reviewing this project, you can learn the following SQL concepts and techniques:
-- - Creating and designing tables to store data efficiently.
-- - Inserting data into tables using INSERT statements.
-- - Applying constraints and foreign keys to maintain data integrity.
-- - Performing basic selection queries to retrieve data from tables.
-- - Filtering data using the WHERE clause based on specific criteria.
-- - Sorting result sets using the ORDER BY clause.
-- - Performing aggregations and calculations using aggregate functions.
-- - Utilizing DISTINCT to retrieve unique values from a column.
-- - Joining tables to retrieve related data.
-- - Generating reports based on specific requirements.
-- - Applying formatting and readability best practices in SQL code.

-- -Feel free to explore the code and experiment with various SQL queries to enhance your understanding of database management and SQL concepts. If you have any questions or need assistance, please don't hesitate to ask.


--We are going to CREATE a DATABASE

DROP DATABASE IF EXISTS EMPLOYEE_MANAGEMENT_SYSTEM ;  --Always a good practice to check if that database exist before

CREATE DATABASE EMPLOYEE_MANAGEMENT_SYSTEM ; 

DROP TABLE IF EXISTS EMPLOYEE;

-- Creating Table. We will create 4 tables. i.e 'employee', 'departments', 'salaries', 'attendance'
CREATE TABLE EMPLOYEE (EMPLOYEE_ID int UNIQUE PRIMARY KEY,
					   FIRST_NAME text, LAST_NAME text, DESIGNATION text, DEPARTMENT_ID int );

DROP TABLE IF EXISTS Salaries;

CREATE TABLE Salaries (Salary_id int PRIMARY KEY, employee_id int REFERENCES employee (employee_id), 
					   salary_amount numeric, effective_date DATE);

DROP TABLE IF EXISTS attendance;
					   
CREATE TABLE Attendance(attendance_id int Primary Key, empployee_id int REFERENCES employee (employee_id), 
						attenance_date date, attendance_status boolean)	;
						
-- while creating the "table named "attendence" some spelling mistakes were made, which can be "ALTER" as folllowing
ALTER TABLE attendance RENAME COLUMN empployee_id to employee_id;
ALTER TABLE attendance RENAME COLUMN attenance_date TO attendance_date;
						
					   
DROP TABLE IF EXISTS Departments;

CREATE TABLE departments (department_id int PRIMARY KEY, department_name text)
 -- In the "Department Table" we have two column. We do not want to add employee_id column in it.
 --Now, the question is how we can make it REALATIONAL 
 --The solution is to make it RELATIONAL, we have to define a constraint.
 
 ALTER TABLE employee ADD CONSTRAINT fk_employee_departments FOREIGN KEY (department_id) REFERENCES departments (department_id);
 
-- The breakdown of the query is as follow:
-- ALTER TABLE EMPLOYEE: Specifies that you want to modify the "EMPLOYEE" table.
-- ADD CONSTRAINT fk_employee_department: Defines a new constraint and gives it a name "fk_employee_department".
-- FOREIGN KEY (DEPARTMENT_ID): Specifies the column in the "EMPLOYEE" table on which the foreign key constraint will be added.
-- REFERENCES departments(department_id): Specifies the referenced table and column to which the foreign key constraint refers.
 --There are two more alternatives to make "departments table" relational
 -- First:
 		--We can add column in the table "departments" named ("employee_id") and make it refrences to th employee (employee_id)
 --Second:
 		--We can add a constraint "UNIQUE" in the Table "employee" and column (department_id) and make it reference to departments (department_id)
		--But we did'nt do that. Because ONE DEPARTMENT ID has many different employees 
		--e.g ALI and EKA may work in HR departpent , and department_id is '1' in that case the column name  (department_id) cannot be UNIQUE
					   
--Inseert the data in the table and columns you created					   
INSERT INTO DEPARTMENTS (department_id, department_name)
			      VALUES (1, 'IT'),
				         (2, 'HR'),
				         (3, 'ADMIN');
				  
INSERT INTO EMPLOYEE (employee_id, first_name, last_name, designation, department_id)
			VALUES   (1, 'Ali', 'Talha', 'computer_operator', 1);
			
--If you wanted to add multiple values in the table at once and quickly you can do the following:

INSERT INTO EMPLOYEE (employee_id, first_name, last_name, designation, department_id)
		    VALUES   (2, 'Eka', 'Lemar', 'Manager', 2),
					 (3, 'Mazhar', 'Khan', 'Accountant', 1),
					 (4, 'Osama', 'Malik', 'Supervisor', 3),
					 (5, 'Wasi', 'Rehman', 'Assitant', 2),
					 (6, 'Fadi', 'Mirza', 'Assistant Manager', 3);
					 
					 
INSERT INTO Salaries (salary_id, employee_id, salary_amount, effective_date)
			VALUES   (1,1,10000, '2018-01-01'),
					 (2,2,12000,' 2019-01-01'),
					 (3,3,10000, '2020-01-01'),
					 (4,4,9000, '2023-01-01'),
					 (5,5,10000, '2018-01-01'),
					 (6,6,10000, '2018-01-01');
					 
INSERT INTO Attendance (attendance_id, employee_id, attendance_date, attendance_status )
				VALUES (1,1, '2018-01-01', 't'),
					   (2,2,' 2019-01-01', 't'),
					   (3,3, '2020-01-01', 'f'),
					   (4,4, '2023-01-01', 'f'),
					   (5,5, '2018-01-01', 't'),
					   (6,6, '2018-01-01', 't');


--Using the SELECT command for different purposes:
SELECT 
*
FROM
attendance;  -- This wil display all the column and data from the "table" named "attendance"

SELECT
attendance_id
FROM
attendance;  -- This wil display only the column (attendance_id) and its data from the "table" named "attendance"

SELECT
attendance_id, attendance_date
FROM
attendance; -- This wil display two column (attendance_id),(attendance_date) and its data from the "table" named "attendance"

SELECT 
	DISTINCT attendance_date
FROM
    attendance; -- Using DISTNIT will not display "DUPLICATE" values in that column 

SELECT
*
FROM
employee
LIMIT
3;     --LIMIT commant is use to diplsya the number of rows. from the requested table


--Order By command is used to arrange the column in "ASCENDING" AND "DECENDING" order either they are nummeric or alphatec. By default it is ASCENTING.
SELECT
*
FROM
employee
ORDER BY
designation desc;  --All the rows in the table "employee" will be displayed but they will be arranged in descenting order w.r.t column "Designation"  

SELECT
*
FROM
employee
ORDER BY
last_name ASC;  --All the rows in the table "employee" will be displayed but they will be arranged in ascending order w.r.t column "last_name"


SELECT
*
FROM
employee
ORDER BY 
3;        --you can write the column number in  the sequence and use it in ORDER BY clause


-- To create a DUPLICATE table using the SELECT command
CREATE TABLE employee_2 AS (SELECT
						    *
						   FROM employee);

--Aggregate functions can be used in SELECT command. Basic aggregate functions are "SUM", "COUNT", "AVG", "MIN", "MAX"

--To calulate the total SUM of a colum. The values in the colum should be numeric.
SELECT 
	sum(salary_amount)
FROM
salaries;   

--To calulate the AVERAGE or MEAN of a column we use "AVG". The values in the colum should be numeric.
SELECT
	AVG(salary_amount)
FROM
    salaries;

--To COUNT  a column we use "COUNT" function.

SELECT
count(department_id)
FROM
employee -- This wul count all the not-null value and give you total number by addingn. It is not SUM . It is counting

-- To get the minimum value in a column use "MIN"
SELECT
	 MIN(salary_amount)
FROM
   salaries;

-- To get the minimum value in a column use "MAX"
SELECT
	 MAX(salary_amount)
FROM
   salaries;

-- USING 'ALIS"  in SELECT command. As we use aggregate duntion the name of the column is changed like "count".
--We can provide Alias to that column in short a new name by using the 'AS'

SELECT
	SUM(salary_amount) AS total_salaries
FROM
	salaries;

-- Above we provided the ALIAS (total_salaries) so , the output column will be named as (total_salaries)


-- Using( where) clause to to return the row which have employee_id =5
SELECT
   	*
 FROM 
 	employee
WHERE
	employee_id = 5;
	
-- Using( where) with a  (between) constraint clause to to return the row i the (employee_id) columns from emloyee_id 2 to 3
--It should be rember when you mention BETWEEN clause like below, [employee_id BETWEEN 2 AND 3]. This will include 2 and 3 as well
SELECT
	*
FROM
	employee
WHERE
	employee_id BETWEEN 2 AND 3
	
-- Operateor like (>, <, >=, <=, <>, !=) can be used in WHERE clause lets take a look one by one wih example

-- First we will try the ">" "greater then" operaator
SELECT
*
FROM
employee
WHERE
employee_id > 1;  --Only rows where employee_id is greater then "1" will be displayed

-- Second we will try the "<" "less then" operaator
SELECT
*
FROM
employee
WHERE
employee_id < 2;  --Only rows where employee_id is less then or before "2" will be displayed

-- Third we will try the ">=" "grater and equal to" operaator
SELECT
*
FROM
employee
WHERE
employee_id >= 2;  --Only rows where employee_id is "2" and greater then "2" will be displayed

-- Fourth, we will try the "<=" "less then and equal to" operaator
SELECT
*
FROM
employee
WHERE
employee_id <= 2;  --Only rows where employee_id is "2" and below then "2" will be displayed. e.g employee_id= 1 will be displayed


-- Fifth, we will try the "<>" a.k.s "!="    "not equal to" operaator
SELECT
*
FROM
employee
WHERE
employee_id != 2;  --All the rows of the table excluding the employee_id is "2" will be displayed

SELECT
*
FROM
employee
WHERE
employee_id <> 2;   -- "<>" it works same as (!=) .menas not equal to


-- USE of "IN" and "NOT IN" operator in WHERE clause


-- We use "IN" while useing "WHERE" clause to display muliple rows at once and saving the time. e.g. we want to get the list of employee
-- from certain department only. and we know their id's departemnt_id 1 & 2 
SELECT
	*
FROM
	employee
WHERE 
	department_id IN (1,2); --All the rows will be returned from the table where department_id = 1&2

-- We use "NOT IN" while useing "WHERE" clause to NOT TO  display muliple rows at once and saving the time. e.g. we do not want to get the list of employee
-- from certain department . and we know their id's departemnt_id 1 & 2 

SELECT
	*
FROM
	employee
WHERE
	department_id NOT IN (1,3);  --All the rows from the table will be returned except the rows where (department_id) = 1 & 3



-- USING "AND" and "OR" operators in the "WHERE" clause

--WHEN we use "AND" operator both the condition should be "TRUE" in a single row. The both conditions might be true in several rows
--If the both "conditions " are not true. Nothing will be displayed. If TRUE, only those rows wil be displayer which meet the conditions
SELECT
   	*
 FROM 
 	attendance
WHERE 
	employee_id = 3 AND
	attendance_date = '2020-01-01';  --Only those ROWS will be displayed which have "emplyee_id=3" as well as "attendence_date= '2020-01-01'"
	
--When we use "OR" operator in "WHERE" clause . is used when you want to retrieve rows that meet at least one of the specified conditions. Here's an example
SELECT
   	*
 FROM 
 	attendance
WHERE
	employee_id =3 OR
	attendance_date = '2018-01-01';  --ALL those ROWS will be displayed which have "emplyee_id=3" .other then that those rows wil also be displayer which have "attendence_date= '2018-01-01'"



SELECT
	salary_id, employee_id, SUM(salary_amount), effective_date
FROM
	salaries
	
	
--DROP, DELETE and TRUNCATE

-- WE use DELETE command to delete data from the ROWS of a TABLE 
DELETE FROM
attendance
WHERE
attendance_status = 'TRUE'; 

--Truncate Table is used to delete all the data from the table except the columns

TRUNCATE TABLE attendance;

--Drop Table will copletelty remove the TABLE from the DATABASE including rows and columns names. 

DROP TABLE attendance;