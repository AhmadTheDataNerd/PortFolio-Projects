

--Checking and drooping duplicates--



with CTE as (SELECT *, 
ROW_NUMBER()OVER
				( PARTITION BY  First_Name,
								Last_Name,
								profession,
								age,
								working_experience
								ORDER BY age
				) as Row_Num
FROM EmployeesRecord)

DELETE FROM CTE
WHERE Row_Num > 1



--Standerdazing Date of Employment(DOE) To Date Format--


ALTER TABLE Employeesrecord
ADD Date_Of_Employment DATE

UPDATE EmployeesRecord
SET Date_Of_Employment = CONVERT(DATE,DOE)




--Cleaning Extra Spaces and Special Characters from first Name Column



UPDATE EmployeesRecord
SET First_Name = TRIM(First_Name)

UPDATE EmployeesRecord
SET First_Name =	REPLACE(
					REPLACE(
					REPLACE(First_name, '/',''),
										'...',''),
										'_','')

UPDATE EmployeesRecord
SET Full_Name = UPPER(Full_Name)
										

--Cleaning Extra Spaces and Special Characters from Last_name Column


UPDATE EmployeesRecord
SET Last_Name = TRIM(Last_Name)

UPDATE EmployeesRecord
SET Last_Name =	REPLACE(
					REPLACE(
					REPLACE(Last_Name, '/',''),
										'...',''),
										'_','')


--Cleaning Gender, hobbies and  professionColumn


UPDATE EmployeesRecord
SET profession = Upper(profession)


UPDATE EmployeesRecord
SET Hobbies = upper(Hobbies)


UPDATE EmployeesRecord
SET Gender = UPPER(gender)


--Concatenating First_Name and Last_Name as Full Name--

ALTER TABLE employeesRecord
ADD Full_Name varchar(50)

UPDATE EmployeesRecord
SET Full_Name = CONCAT(First_Name, ' ', Last_Name)



--Exracting Countty and states Column into diffrent Columns--

ALTER TABLE EmployeesRecord
ADD state VARCHAR(50)


UPDATE EmployeesRecord
SET State = PARSENAME(REPLACE(counttyandstate, ',','.'),1)



ALTER TABLE EmployeesRecord
ADD Country VARCHAR(50)


UPDATE EmployeesRecord
SET Country = PARSENAME(REPLACE(Counttyandstate,',','.'),2)



UPDATE EmployeesRecord
SET country = UPPER(country)


--Changing indebt,ishomeOwer and owns_car to Yes Or No instead of 0 and 1


ALTER TABLE EmployeesRecord
ADD In_Debt VARCHAR(50)


UPDATE EmployeesRecord
SET in_debt = CASE 
				WHEN indebt = 0 THEN 'Yes'
				ELSE 'No'
			 END
FROM EmployeesRecord


ALTER TABLE EmployeesRecord
ADD Home_owner VARCHAR(50)


UPDATE EmployeesRecord
SET Home_owner =  CASE 
				WHEN isHomeOwner = 0 THEN 'Yes'
				ELSE 'No'
			 END
FROM EmployeesRecord

 
 ALTER TABLE EmployeesRecord
ADD Have_a_carCar VARCHAR(50)


UPDATE EmployeesRecord
SET Have_a_carcar = CASE 
				WHEN Have_a_carCar = 0 THEN 'Yes'
				ELSE 'No'
			   END
FROM EmployeesRecord


--dropping unwanted columns--


ALTER TABLE EmployeesRecord
DROP COLUMN DOE,
First_name,
Last_Name,
Counttyandstate,
demographics


ALTER TABLE EmployeesRecord
DROP COLUMN indebt,
isHomeowner,
Owns_car


ALTER TABLE EmployeesRecord
DROP COLUMN Phone


--Done!--


SELECT * FROM EmployeesRecord
order by id

