
-- 1) Creating the tables 
CREATE TABLE PASSENGER
(Passenger_name varchar(50),
Category varchar(15),
Gender varchar(1),
Boarding_City varchar(25),
Destination_City varchar(25),
Distance int,
Bus_Type varchar(10)
);


CREATE TABLE PRICE
(
Bus_Type varchar(10),
Distance int,
Price int
);

--- 2) Insert data in Tables  
INSERT INTO PASSENGER (Passenger_name, Category, Gender, Boarding_City, Destination_City, Distance, Bus_Type) VALUES ('Sejal', 'AC', 'F', 'Bengaluru', 'Chennai', 350, 'Sleeper');
INSERT INTO PASSENGER (Passenger_name, Category, Gender, Boarding_City, Destination_City, Distance, Bus_Type) VALUES ('Anmol', 'Non-AC' ,'M','Mumbai', 'Hyderabad', 700, 'Sitting');
INSERT INTO PASSENGER (Passenger_name, Category, Gender, Boarding_City, Destination_City, Distance, Bus_Type) VALUES ('Pallavi', 'AC', 'F', 'Panaji', 'Bengaluru', 600, 'Sleeper');
INSERT INTO PASSENGER (Passenger_name, Category, Gender, Boarding_City, Destination_City, Distance, Bus_Type) VALUES ('Khusboo', 'AC', 'F', 'Chennai', 'Mumbai', 1500, 'Sleeper');
INSERT INTO PASSENGER (Passenger_name, Category, Gender, Boarding_City, Destination_City, Distance, Bus_Type) VALUES ('Udit', 'Non-AC', 'M', 'Trivandrum', 'panaji', 1000, 'Sleeper');
INSERT INTO PASSENGER (Passenger_name, Category, Gender, Boarding_City, Destination_City, Distance, Bus_Type) VALUES ('Ankur', 'AC', 'M' ,'Nagpur', 'Hyderabad', 500 ,'Sitting');
INSERT INTO PASSENGER (Passenger_name, Category, Gender, Boarding_City, Destination_City, Distance, Bus_Type) VALUES ('Hemant', 'Non-AC' ,'M', 'panaji', 'Mumbai', 700 ,'Sleeper');
INSERT INTO PASSENGER (Passenger_name, Category, Gender, Boarding_City, Destination_City, Distance, Bus_Type) VALUES ('Manish', 'Non-AC', 'M', 'Hyderabad', 'Bengaluru', 500 ,'Sitting');
INSERT INTO PASSENGER (Passenger_name, Category, Gender, Boarding_City, Destination_City, Distance, Bus_Type) VALUES ('Piyush', 'AC', 'M', 'Pune', 'Nagpur', 700, 'Sitting');

INSERT INTO PRICE (Bus_Type, Distance, Price,category) VALUES ('Sleeper', 350, 770);
INSERT INTO PRICE (Bus_Type, Distance, Price) VALUES ('Sleeper', 500, 1100);
INSERT INTO PRICE (Bus_Type, Distance, Price) VALUES ('Sleeper', 600, 1320);
INSERT INTO PRICE (Bus_Type, Distance, Price) VALUES ('Sleeper', 700, 1540);
INSERT INTO PRICE (Bus_Type, Distance, Price) VALUES ('Sleeper', 1000, 2200);
INSERT INTO PRICE (Bus_Type, Distance, Price) VALUES ('Sleeper', 1200, 2640);
INSERT INTO PRICE (Bus_Type, Distance, Price) VALUES ('Sleeper', 350, 434);
INSERT INTO PRICE (Bus_Type, Distance, Price) VALUES ('Sitting', 500, 620);
INSERT INTO PRICE (Bus_Type, Distance, Price) VALUES ('Sitting', 500, 620);
INSERT INTO PRICE (Bus_Type, Distance, Price) VALUES ('Sitting', 600, 744);
INSERT INTO PRICE (Bus_Type, Distance, Price) VALUES ('Sitting', 700, 868);
INSERT INTO PRICE (Bus_Type, Distance, Price) VALUES ('Sitting', 1000, 1240);
INSERT INTO PRICE (Bus_Type, Distance, Price) VALUES ('Sitting', 1200, 1488);
INSERT INTO PRICE (Bus_Type, Distance, Price) VALUES ('Sitting', 1500, 1860);

---3) How many females and how many male passengers travelled for a minimum distance of 600 KM s?

SELECT  GENDER,COUNT(*)
FROM PASSENGER 
WHERE DISTANCE >=600 
GROUP BY GENDER;

--4) Find the minimum ticket price for Sleeper Bus.

SELECT min(price) FROM PRICE
WHERE bus_type='Sleeper';

--5) Select passenger names whose names start with character 'S'

SELECT * FROM PASSENGER
WHERE passenger_name like 'S%';


--6) Calculate price charged for each passenger displaying Passenger name, Boarding City, Destination City, Bus_Type, Price in the output

SELECT psng.passenger_name, psng.Boarding_city,psng.Destination_city,psng.category, psng.Bus_type
, max(prc.price)
FROM passenger psng 
INNER JOIN price prc
USING (bus_type, distance)
group by psng.passenger_name, psng.Boarding_city,psng.Destination_city,psng.category, psng.Bus_type ;

--7) What is the passenger name and his/her ticket price who travelled in Sitting bus for a distance of 1000 KM s 

SELECT psng.passenger_name, psng.Boarding_city,psng.Destination_city,psng.category, psng.Bus_type
, prc.price
FROM passenger psng 
INNER JOIN price prc
USING (bus_type, distance)
where psng.distance=1000
and psng.Bus_type='Sitting' ;

---8) What will be the Sitting and Sleeper bus charge for Pallavi to travel from Bangalore to Panaji?

SELECT psng.passenger_name, psng.Boarding_city,psng.Destination_city,psng.category, prc.Bus_type
, prc.price
FROM passenger psng 
INNER JOIN price prc
USING (distance)
where 
 ( (psng.Boarding_city='Bengaluru' and psng.Destination_city='Panaji')
or (psng.Boarding_city='Panaji' and psng.Destination_city='Bengaluru') ) ;


---9) List the distances from the "Passenger" table which are unique (non-repeated distances) in descending order.
SELECT distinct(distance)
from passenger  ;


--- 10) Display the passenger name and percentage of distance travelled by that passenger from the total distance travelled by all passengers without using user variables

select psng.passenger_name, (psng.distance/(SELECT sum(distance) from passenger))*100 dist_percent
from passenger psng;

/* 11)Display the distance, price in three categories in table Price
a) Expensive if the cost is more than 1000
b) Average Cost if the cost is less than 1000 and greater than 500
c) Cheap otherwise */

select prc.distance ,prc.price ,
case 
when prc.price >1000 then 'expensive' 
when (prc.price >500 and prc.price<1000) then 'average'
else 'cheap' end  prc_category 
from price prc;


















