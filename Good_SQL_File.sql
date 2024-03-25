SET search_path = "E-Hotel Database" 

-- 2 a)

CREATE TABLE Hotel_Chain (
	Hotel_Chain_Name VARCHAR(40) NOT NULL,
	Central_Office_Address VARCHAR(40),
	Number_of_Hotels Integer,
	PRIMARY KEY (Hotel_Chain_Name)
);

CREATE TABLE Contact_Phone_Number (
	Hotel_Chain_Name VARCHAR(40) NOT NULL,
	Contact_Phone_Number VARCHAR(20) NOT NULL,
	PRIMARY KEY (Hotel_Chain_Name, Contact_Phone_Number),
	FOREIGN KEY (Hotel_Chain_Name) REFERENCES Hotel_Chain(Hotel_Chain_Name)
);

CREATE TABLE Contact_Email_Address (
	Hotel_Chain_Name VARCHAR(40) NOT NULL,
	Contact_Email_Address VARCHAR(40) NOT NULL,
	PRIMARY KEY (Hotel_Chain_Name, Contact_Email_Address),
	FOREIGN KEY (Hotel_Chain_Name) REFERENCES Hotel_Chain(Hotel_Chain_Name)
);

CREATE TABLE Booking_History (
	Booking_History_ID SERIAL NOT NULL,
	Room_ID Integer,
	Customer_ID Integer,
	Hotel_Chain_Name VARCHAR(40),
	Booking_Date Date,
	Checkin_Date Date,
	Checkout_Date Date,
	PRIMARY KEY (Booking_History_ID),
	FOREIGN KEY (Hotel_Chain_Name) REFERENCES Hotel_Chain(Hotel_Chain_Name)
);

CREATE TABLE Renting_History (
	Renting_History_ID SERIAL NOT NULL,
	Room_ID Integer,
	Customer_ID Integer,
	Employee_ID Integer,
	Hotel_Chain_Name VARCHAR(40),
	Renting_Date Date,
	Checkin_Date Date,
	Checkout_Date Date,
	PRIMARY KEY (Renting_History_ID),
	FOREIGN KEY (Hotel_Chain_Name) REFERENCES Hotel_Chain(Hotel_Chain_Name)
);



CREATE TABLE Hotel (
	Hotel_ID SERIAL NOT NULL,
	Rating Integer,
	Number_Of_Rooms Integer,
	Address VARCHAR(20),
	Contact_Email VARCHAR(40),
	Contact_Phone_Number VARCHAR(20),
	Manager_ID Integer,
	Hotel_Chain_Name VARCHAR(40),
	PRIMARY KEY (Hotel_ID),
	FOREIGN KEY (Hotel_Chain_Name) REFERENCES Hotel_Chain(Hotel_Chain_Name)	
);

CREATE TABLE Person (
	Person_ID SERIAL NOT NULL,
	Full_Name VARCHAR(40),
	Address VARCHAR(40),
	PRIMARY KEY (Person_ID)
);

CREATE TABLE Customer (
	Customer_ID SERIAL NOT NULL,
	Person_ID Integer,
	Full_Name VARCHAR(40),
	Address VARCHAR(40),
	ID_Type VARCHAR(20) CHECK (ID_Type IN ('SIN', 'SSN', 'Driver Licence')),
	Registration_Date Date,
	FOREIGN KEY (Person_ID) REFERENCES Person(Person_ID),
	PRIMARY KEY (Customer_ID)
);

CREATE TABLE Employee (
	Employee_ID SERIAL NOT NULL,
	Person_ID Integer,
	Full_Name VARCHAR(40),
	Address VARCHAR(40),
	Hotel_ID Integer,
	SSN_Or_SIN Varchar(40),
	FOREIGN KEY (Person_ID) REFERENCES Person(Person_ID),
	FOREIGN KEY (Hotel_ID) REFERENCES Hotel(Hotel_ID),
	PRIMARY KEY (Employee_ID)
);

CREATE TABLE Role (
	Employee_ID Integer NOT NULL,
	Role Varchar(20) NOT NULL,
	FOREIGN KEY (Employee_ID) REFERENCES Employee(Employee_ID),
	PRIMARY KEY (Employee_ID, Role)
);

CREATE TABLE Room (
	Room_ID SERIAL NOT NULL,
	Hotel_ID INTEGER NOT NULL,
	Price INTEGER,
	Capacity INTEGER,
	View VARCHAR(20) CHECK (View IN ('Sea', 'Mountain')),
	Extendable BOOLEAN NOT NULL,
	FOREIGN KEY (Hotel_ID) REFERENCES Hotel(Hotel_ID),
	PRIMARY KEY (Hotel_ID, Room_ID),
	UNIQUE (Hotel_ID, Room_ID)
);

CREATE TABLE Booking (
	Booking_ID SERIAL NOT NULL,
	Customer_ID INTEGER,
	Booking_Date DATE,
	Checkin_Date DATE,
	Checkout_Date DATE,
	Hotel_ID INTEGER NOT NULL,
	Room_ID INTEGER NOT NULL,
	FOREIGN KEY (Customer_ID) REFERENCES Customer(Customer_ID),
	FOREIGN KEY (Hotel_ID, Room_ID) REFERENCES Room(Hotel_ID, Room_ID),
	PRIMARY KEY (Booking_ID, Hotel_ID, Room_ID),
	UNIQUE (Hotel_ID, Booking_ID, Room_ID)
);

CREATE TABLE Renting (
	Renting_ID SERIAL NOT NULL,
	Employee_ID Integer,
	Customer_ID INTEGER,
	Renting_Date DATE,
	Checkin_Date DATE,
	Checkout_Date DATE,
	Hotel_ID INTEGER NOT NULL,
	Booking_ID INTEGER,
	Room_ID INTEGER NOT NULL,
	FOREIGN KEY (Employee_ID) REFERENCES Employee(Employee_ID),
	FOREIGN KEY (Customer_ID) REFERENCES Customer(Customer_ID),
	FOREIGN KEY (Hotel_ID, Room_ID) REFERENCES Room(Hotel_ID, Room_ID),
	FOREIGN KEY (Booking_ID, Hotel_ID, Room_ID) REFERENCES Booking(Booking_ID, Hotel_ID, Room_ID),
	PRIMARY KEY (Renting_ID, Hotel_ID, Room_ID)
);

CREATE TABLE Problem (
	Room_ID INTEGER NOT NULL,
	Hotel_ID INTEGER NOT NULL,
	Problem VARCHAR(40) NOT NULL,
	FOREIGN KEY (Room_ID, Hotel_ID) REFERENCES Room(Room_ID, Hotel_ID),
	PRIMARY KEY (Problem, Hotel_ID, Room_ID)
);

CREATE TABLE Amenity (
	Room_ID INTEGER NOT NULL,
	Hotel_ID INTEGER NOT NULL,
	Amenity VARCHAR(40) NOT NULL,
	FOREIGN KEY (Room_ID, Hotel_ID) REFERENCES Room(Room_ID, Hotel_ID),
	PRIMARY KEY (Amenity, Hotel_ID, Room_ID)
);

------------------------------------------------------------------------------------------------------------------------------------------------------------------

ALTER TABLE Hotel ADD FOREIGN KEY (Manager_ID) REFERENCES Employee(Employee_ID)

------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- 2 b)

--Hotel Chains
INSERT INTO Hotel_Chain (Hotel_Chain_Name, Central_Office_Address, Number_Of_Hotels) VALUES ('Radisson', '701 Carlson Pkwy', 8);

INSERT INTO Hotel_Chain (Hotel_Chain_Name, Central_Office_Address, Number_Of_Hotels) VALUES ('Marriott', '7750 Wisconsin Ave', 8);

INSERT INTO Hotel_Chain (Hotel_Chain_Name, Central_Office_Address, Number_Of_Hotels) VALUES ('Holiday Inn', '3 Ravinia Drive', 8);

INSERT INTO Hotel_Chain (Hotel_Chain_Name, Central_Office_Address, Number_Of_Hotels) VALUES ('Hilton', '7930 Jones Branch Drive', 8);

INSERT INTO Hotel_Chain (Hotel_Chain_Name, Central_Office_Address, Number_Of_Hotels) VALUES ('Best Western', '6201 North 24th Parkway', 8);

--Hotels
INSERT INTO Hotel (Rating, Number_Of_Rooms, Address, Contact_Email, Contact_Phone_Number, Manager_ID, Hotel_Chain_Name)
VALUES (3, 100, '1 Main Street', 'radissonhotel1@email.com', '123-456-7890', NULL, 'Radisson');

INSERT INTO Hotel (Rating, Number_Of_Rooms, Address, Contact_Email, Contact_Phone_Number, Manager_ID, Hotel_Chain_Name)
VALUES (4, 100, '2 Main Street', 'radissonhotel2@email.com', '123-456-7890', NULL, 'Radisson');

INSERT INTO Hotel (Rating, Number_Of_Rooms, Address, Contact_Email, Contact_Phone_Number, Manager_ID, Hotel_Chain_Name)
VALUES (5, 100, '3 Main Street', 'radissonhotel3@email.com', '123-456-7890', NULL, 'Radisson');

INSERT INTO Hotel (Rating, Number_Of_Rooms, Address, Contact_Email, Contact_Phone_Number, Manager_ID, Hotel_Chain_Name)
VALUES (3, 100, '4 Main Street', 'radissonhotel4@email.com', '123-456-7890', NULL, 'Radisson');

INSERT INTO Hotel (Rating, Number_Of_Rooms, Address, Contact_Email, Contact_Phone_Number, Manager_ID, Hotel_Chain_Name)
VALUES (4, 100, '5 Main Street', 'radissonhotel5@email.com', '123-456-7890', NULL, 'Radisson');

INSERT INTO Hotel (Rating, Number_Of_Rooms, Address, Contact_Email, Contact_Phone_Number, Manager_ID, Hotel_Chain_Name)
VALUES (5, 100, '6 Main Street', 'radissonhotel6@email.com', '123-456-7890', NULL, 'Radisson');

INSERT INTO Hotel (Rating, Number_Of_Rooms, Address, Contact_Email, Contact_Phone_Number, Manager_ID, Hotel_Chain_Name)
VALUES (3, 100, '7 Main Street', 'radissonhotel7@email.com', '123-456-7890', NULL, 'Radisson');

INSERT INTO Hotel (Rating, Number_Of_Rooms, Address, Contact_Email, Contact_Phone_Number, Manager_ID, Hotel_Chain_Name)
VALUES (4, 100, '8 Main Street', 'radissonhotel8@email.com', '123-456-7890', NULL, 'Radisson');



INSERT INTO Hotel (Rating, Number_Of_Rooms, Address, Contact_Email, Contact_Phone_Number, Manager_ID, Hotel_Chain_Name)
VALUES (3, 100, '1 Second Street', 'marriotthotel1@email.com', '123-456-7890', NULL, 'Marriott');

INSERT INTO Hotel (Rating, Number_Of_Rooms, Address, Contact_Email, Contact_Phone_Number, Manager_ID, Hotel_Chain_Name)
VALUES (4, 100, '2 Second Street', 'marriotthotel2@email.com', '123-456-7890', NULL, 'Marriott');

INSERT INTO Hotel (Rating, Number_Of_Rooms, Address, Contact_Email, Contact_Phone_Number, Manager_ID, Hotel_Chain_Name)
VALUES (5, 100, '3 Second Street', 'marriotthotel3@email.com', '123-456-7890', NULL, 'Marriott');

INSERT INTO Hotel (Rating, Number_Of_Rooms, Address, Contact_Email, Contact_Phone_Number, Manager_ID, Hotel_Chain_Name)
VALUES (3, 100, '4 Second Street', 'marriotthotel4@email.com', '123-456-7890', NULL, 'Marriott');

INSERT INTO Hotel (Rating, Number_Of_Rooms, Address, Contact_Email, Contact_Phone_Number, Manager_ID, Hotel_Chain_Name)
VALUES (4, 100, '5 Second Street', 'marriotthotel5@email.com', '123-456-7890', NULL, 'Marriott');

INSERT INTO Hotel (Rating, Number_Of_Rooms, Address, Contact_Email, Contact_Phone_Number, Manager_ID, Hotel_Chain_Name)
VALUES (5, 100, '6 Second Street', 'marriotthotel6@email.com', '123-456-7890', NULL, 'Marriott');

INSERT INTO Hotel (Rating, Number_Of_Rooms, Address, Contact_Email, Contact_Phone_Number, Manager_ID, Hotel_Chain_Name)
VALUES (3, 100, '7 Second Street', 'marriotthotel7@email.com', '123-456-7890', NULL, 'Marriott');

INSERT INTO Hotel (Rating, Number_Of_Rooms, Address, Contact_Email, Contact_Phone_Number, Manager_ID, Hotel_Chain_Name)
VALUES (4, 100, '8 Second Street', 'marriotthotel8@email.com', '123-456-7890', NULL, 'Marriott');



INSERT INTO Hotel (Rating, Number_Of_Rooms, Address, Contact_Email, Contact_Phone_Number, Manager_ID, Hotel_Chain_Name)
VALUES (3, 100, '1 Third Street', 'holidayinnhotel1@email.com', '123-456-7890', NULL, 'Holiday Inn');

INSERT INTO Hotel (Rating, Number_Of_Rooms, Address, Contact_Email, Contact_Phone_Number, Manager_ID, Hotel_Chain_Name)
VALUES (4, 100, '2 Third Street', 'holidayinnhotel2@email.com', '123-456-7890', NULL, 'Holiday Inn');

INSERT INTO Hotel (Rating, Number_Of_Rooms, Address, Contact_Email, Contact_Phone_Number, Manager_ID, Hotel_Chain_Name)
VALUES (5, 100, '3 Third Street', 'holidayinnhotel3@email.com', '123-456-7890', NULL, 'Holiday Inn');

INSERT INTO Hotel (Rating, Number_Of_Rooms, Address, Contact_Email, Contact_Phone_Number, Manager_ID, Hotel_Chain_Name)
VALUES (3, 100, '4 Third Street', 'holidayinnhotel4@email.com', '123-456-7890', NULL, 'Holiday Inn');

INSERT INTO Hotel (Rating, Number_Of_Rooms, Address, Contact_Email, Contact_Phone_Number, Manager_ID, Hotel_Chain_Name)
VALUES (4, 100, '5 Third Street', 'holidayinnhotel5@email.com', '123-456-7890', NULL, 'Holiday Inn');

INSERT INTO Hotel (Rating, Number_Of_Rooms, Address, Contact_Email, Contact_Phone_Number, Manager_ID, Hotel_Chain_Name)
VALUES (5, 100, '6 Third Street', 'holidayinnhotel6@email.com', '123-456-7890', NULL, 'Holiday Inn');

INSERT INTO Hotel (Rating, Number_Of_Rooms, Address, Contact_Email, Contact_Phone_Number, Manager_ID, Hotel_Chain_Name)
VALUES (3, 100, '7 Third Street', 'holidayinnhotel7@email.com', '123-456-7890', NULL, 'Holiday Inn');

INSERT INTO Hotel (Rating, Number_Of_Rooms, Address, Contact_Email, Contact_Phone_Number, Manager_ID, Hotel_Chain_Name)
VALUES (4, 100, '8 Third Street', 'holidayinnhotel8@email.com', '123-456-7890', NULL, 'Holiday Inn');



INSERT INTO Hotel (Rating, Number_Of_Rooms, Address, Contact_Email, Contact_Phone_Number, Manager_ID, Hotel_Chain_Name)
VALUES (3, 100, '1 Fourth Street', 'hiltonhotel1@email.com', '123-456-7890', NULL, 'Hilton');

INSERT INTO Hotel (Rating, Number_Of_Rooms, Address, Contact_Email, Contact_Phone_Number, Manager_ID, Hotel_Chain_Name)
VALUES (4, 100, '2 Fourth Street', 'hiltonhotel2@email.com', '123-456-7890', NULL, 'Hilton');

INSERT INTO Hotel (Rating, Number_Of_Rooms, Address, Contact_Email, Contact_Phone_Number, Manager_ID, Hotel_Chain_Name)
VALUES (5, 100, '3 Fourth Street', 'hiltonhotel3@email.com', '123-456-7890', NULL, 'Hilton');

INSERT INTO Hotel (Rating, Number_Of_Rooms, Address, Contact_Email, Contact_Phone_Number, Manager_ID, Hotel_Chain_Name)
VALUES (3, 100, '4 Fourth Street', 'hiltonhotel4@email.com', '123-456-7890', NULL, 'Hilton');

INSERT INTO Hotel (Rating, Number_Of_Rooms, Address, Contact_Email, Contact_Phone_Number, Manager_ID, Hotel_Chain_Name)
VALUES (4, 100, '5 Fourth Street', 'hiltonhotel5@email.com', '123-456-7890', NULL, 'Hilton');

INSERT INTO Hotel (Rating, Number_Of_Rooms, Address, Contact_Email, Contact_Phone_Number, Manager_ID, Hotel_Chain_Name)
VALUES (5, 100, '6 Fourth Street', 'hiltonhotel6@email.com', '123-456-7890', NULL, 'Hilton');

INSERT INTO Hotel (Rating, Number_Of_Rooms, Address, Contact_Email, Contact_Phone_Number, Manager_ID, Hotel_Chain_Name)
VALUES (3, 100, '7 Fourth Street', 'hiltonhotel7@email.com', '123-456-7890', NULL, 'Hilton');

INSERT INTO Hotel (Rating, Number_Of_Rooms, Address, Contact_Email, Contact_Phone_Number, Manager_ID, Hotel_Chain_Name)
VALUES (4, 100, '8 Fourth Street', 'hiltonhotel8@email.com', '123-456-7890', NULL, 'Hilton');



INSERT INTO Hotel (Rating, Number_Of_Rooms, Address, Contact_Email, Contact_Phone_Number, Manager_ID, Hotel_Chain_Name)
VALUES (3, 100, '1 Fifth Street', 'bestwesternhotel1@email.com', '123-456-7890', NULL, 'Best Western');

INSERT INTO Hotel (Rating, Number_Of_Rooms, Address, Contact_Email, Contact_Phone_Number, Manager_ID, Hotel_Chain_Name)
VALUES (4, 100, '2 Fifth Street', 'bestwesternhotel2@email.com', '123-456-7890', NULL, 'Best Western');

INSERT INTO Hotel (Rating, Number_Of_Rooms, Address, Contact_Email, Contact_Phone_Number, Manager_ID, Hotel_Chain_Name)
VALUES (5, 100, '3 Fifth Street', 'bestwesternhotel3@email.com', '123-456-7890', NULL, 'Best Western');

INSERT INTO Hotel (Rating, Number_Of_Rooms, Address, Contact_Email, Contact_Phone_Number, Manager_ID, Hotel_Chain_Name)
VALUES (3, 100, '4 Fifth Street', 'bestwesternhotel4@email.com', '123-456-7890', NULL, 'Best Western');

INSERT INTO Hotel (Rating, Number_Of_Rooms, Address, Contact_Email, Contact_Phone_Number, Manager_ID, Hotel_Chain_Name)
VALUES (4, 100, '5 Fifth Street', 'bestwesternhotel5@email.com', '123-456-7890', NULL, 'Best Western');

INSERT INTO Hotel (Rating, Number_Of_Rooms, Address, Contact_Email, Contact_Phone_Number, Manager_ID, Hotel_Chain_Name)
VALUES (5, 100, '6 Fifth Street', 'bestwesternhotel6@email.com', '123-456-7890', NULL, 'Best Western');

INSERT INTO Hotel (Rating, Number_Of_Rooms, Address, Contact_Email, Contact_Phone_Number, Manager_ID, Hotel_Chain_Name)
VALUES (3, 100, '7 Fifth Street', 'bestwesternhotel7@email.com', '123-456-7890', NULL, 'Best Western');

INSERT INTO Hotel (Rating, Number_Of_Rooms, Address, Contact_Email, Contact_Phone_Number, Manager_ID, Hotel_Chain_Name)
VALUES (4, 100, '8 Fifth Street', 'bestwesternhotel8@email.com', '123-456-7890', NULL, 'Best Western');



--Rooms

INSERT INTO Room (Hotel_ID, Price, Capacity, View, Extendable)
SELECT 
    Hotel.Hotel_ID,
    150 AS Price,
    1 AS Capacity,
    'Sea' AS View,
    true AS Extendable
FROM 
    Hotel;
	
INSERT INTO Room (Hotel_ID, Price, Capacity, View, Extendable)
SELECT 
    Hotel.Hotel_ID,
    150 AS Price,
    2 AS Capacity,
    'Sea' AS View,
    true AS Extendable
FROM 
    Hotel;
	
INSERT INTO Room (Hotel_ID, Price, Capacity, View, Extendable)
SELECT 
    Hotel.Hotel_ID,
    150 AS Price,
    3 AS Capacity,
    'Mountain' AS View,
    false AS Extendable
FROM 
    Hotel;
	
INSERT INTO Room (Hotel_ID, Price, Capacity, View, Extendable)
SELECT 
    Hotel.Hotel_ID,
    150 AS Price,
    4 AS Capacity,
    'Mountain' AS View,
    false AS Extendable
FROM 
    Hotel;


--Amenities

INSERT INTO Amenity (Room_ID, Hotel_ID, Amenity)
SELECT 
    Room.Room_ID,
    Room.Hotel_ID,
    'Wifi' AS Amenity
FROM 
    Room;
	
INSERT INTO Amenity (Room_ID, Hotel_ID, Amenity)
SELECT 
    Room.Room_ID,
    Room.Hotel_ID,
    'Mini Fridge' AS Amenity
FROM 
    Room;

--Problems

INSERT INTO Problem (Room_ID, Hotel_ID, Problem)
SELECT 
    Room.Room_ID,
    Room.Hotel_ID,
    'Bed Bugs' AS Problem
FROM 
    Room
WHERE 
    Room.Room_ID % 5 = 0; --This just makes it so that only 1 in 5 rooms have bed bugs


--Booking History

INSERT INTO Booking_History (Room_ID, Customer_ID, Hotel_Chain_Name, Booking_Date, Checkin_Date, Checkout_Date)
VALUES (1, 2, 'Radisson', '2024-02-20', '2024-03-01', '2024-03-05');

INSERT INTO Booking_History (Room_ID, Customer_ID, Hotel_Chain_Name, Booking_Date, Checkin_Date, Checkout_Date)
VALUES (2, 3, 'Radisson', '2020-02-20', '2020-03-01', '2020-03-05');

INSERT INTO Booking_History (Room_ID, Customer_ID, Hotel_Chain_Name, Booking_Date, Checkin_Date, Checkout_Date)
VALUES (3, 4, 'Radisson', '2021-02-20', '2021-03-01', '2021-03-05');

INSERT INTO Booking_History (Room_ID, Customer_ID, Hotel_Chain_Name, Booking_Date, Checkin_Date, Checkout_Date)
VALUES (4, 5, 'Radisson', '2022-02-20', '2022-03-01', '2022-03-05');

INSERT INTO Booking_History (Room_ID, Customer_ID, Hotel_Chain_Name, Booking_Date, Checkin_Date, Checkout_Date)
VALUES (5, 6, 'Radisson', '2023-02-20', '2023-03-01', '2023-03-05');

INSERT INTO Booking_History (Room_ID, Customer_ID, Hotel_Chain_Name, Booking_Date, Checkin_Date, Checkout_Date)
VALUES (1, 2, 'Hilton', '2024-02-20', '2024-03-01', '2024-03-05');

INSERT INTO Booking_History (Room_ID, Customer_ID, Hotel_Chain_Name, Booking_Date, Checkin_Date, Checkout_Date)
VALUES (2, 3, 'Hilton', '2020-02-20', '2020-03-01', '2020-03-05');

INSERT INTO Booking_History (Room_ID, Customer_ID, Hotel_Chain_Name, Booking_Date, Checkin_Date, Checkout_Date)
VALUES (3, 4, 'Hilton', '2021-02-20', '2021-03-01', '2021-03-05');

INSERT INTO Booking_History (Room_ID, Customer_ID, Hotel_Chain_Name, Booking_Date, Checkin_Date, Checkout_Date)
VALUES (4, 5, 'Hilton', '2022-02-20', '2022-03-01', '2022-03-05');

INSERT INTO Booking_History (Room_ID, Customer_ID, Hotel_Chain_Name, Booking_Date, Checkin_Date, Checkout_Date)
VALUES (5, 6, 'Hilton', '2023-02-20', '2023-03-01', '2023-03-05');

INSERT INTO Booking_History (Room_ID, Customer_ID, Hotel_Chain_Name, Booking_Date, Checkin_Date, Checkout_Date)
VALUES (1, 2, 'Holiday Inn', '2024-02-20', '2024-03-01', '2024-03-05');

INSERT INTO Booking_History (Room_ID, Customer_ID, Hotel_Chain_Name, Booking_Date, Checkin_Date, Checkout_Date)
VALUES (2, 3, 'Holiday Inn', '2020-02-20', '2020-03-01', '2020-03-05');

INSERT INTO Booking_History (Room_ID, Customer_ID, Hotel_Chain_Name, Booking_Date, Checkin_Date, Checkout_Date)
VALUES (3, 4, 'Holiday Inn', '2021-02-20', '2021-03-01', '2021-03-05');

INSERT INTO Booking_History (Room_ID, Customer_ID, Hotel_Chain_Name, Booking_Date, Checkin_Date, Checkout_Date)
VALUES (4, 5, 'Holiday Inn', '2022-02-20', '2022-03-01', '2022-03-05');

INSERT INTO Booking_History (Room_ID, Customer_ID, Hotel_Chain_Name, Booking_Date, Checkin_Date, Checkout_Date)
VALUES (5, 6, 'Holiday Inn', '2023-02-20', '2023-03-01', '2023-03-05');

INSERT INTO Booking_History (Room_ID, Customer_ID, Hotel_Chain_Name, Booking_Date, Checkin_Date, Checkout_Date)
VALUES (1, 2, 'Marriott', '2024-02-20', '2024-03-01', '2024-03-05');

INSERT INTO Booking_History (Room_ID, Customer_ID, Hotel_Chain_Name, Booking_Date, Checkin_Date, Checkout_Date)
VALUES (2, 3, 'Marriott', '2020-02-20', '2020-03-01', '2020-03-05');

INSERT INTO Booking_History (Room_ID, Customer_ID, Hotel_Chain_Name, Booking_Date, Checkin_Date, Checkout_Date)
VALUES (3, 4, 'Marriott', '2021-02-20', '2021-03-01', '2021-03-05');

INSERT INTO Booking_History (Room_ID, Customer_ID, Hotel_Chain_Name, Booking_Date, Checkin_Date, Checkout_Date)
VALUES (4, 5, 'Marriott', '2022-02-20', '2022-03-01', '2022-03-05');

INSERT INTO Booking_History (Room_ID, Customer_ID, Hotel_Chain_Name, Booking_Date, Checkin_Date, Checkout_Date)
VALUES (5, 6, 'Marriott', '2023-02-20', '2023-03-01', '2023-03-05');

INSERT INTO Booking_History (Room_ID, Customer_ID, Hotel_Chain_Name, Booking_Date, Checkin_Date, Checkout_Date)
VALUES (1, 2, 'Best Western', '2024-02-20', '2024-03-01', '2024-03-05');

INSERT INTO Booking_History (Room_ID, Customer_ID, Hotel_Chain_Name, Booking_Date, Checkin_Date, Checkout_Date)
VALUES (2, 3, 'Best Western', '2020-02-20', '2020-03-01', '2020-03-05');

INSERT INTO Booking_History (Room_ID, Customer_ID, Hotel_Chain_Name, Booking_Date, Checkin_Date, Checkout_Date)
VALUES (3, 4, 'Best Western', '2021-02-20', '2021-03-01', '2021-03-05');

INSERT INTO Booking_History (Room_ID, Customer_ID, Hotel_Chain_Name, Booking_Date, Checkin_Date, Checkout_Date)
VALUES (4, 5, 'Best Western', '2022-02-20', '2022-03-01', '2022-03-05');

INSERT INTO Booking_History (Room_ID, Customer_ID, Hotel_Chain_Name, Booking_Date, Checkin_Date, Checkout_Date)
VALUES (5, 6, 'Best Western', '2023-02-20', '2023-03-01', '2023-03-05');



--Renting History
INSERT INTO Renting_History (Room_ID, Customer_ID, Hotel_Chain_Name, Renting_Date, Checkin_Date, Checkout_Date)
VALUES (1, 2, 'Radisson', '2024-02-20', '2024-03-01', '2024-03-05');

INSERT INTO Renting_History (Room_ID, Customer_ID, Hotel_Chain_Name, Renting_Date, Checkin_Date, Checkout_Date)
VALUES (2, 3, 'Radisson', '2020-02-20', '2020-03-01', '2020-03-05');

INSERT INTO Renting_History (Room_ID, Customer_ID, Hotel_Chain_Name, Renting_Date, Checkin_Date, Checkout_Date)
VALUES (3, 4, 'Radisson', '2021-02-20', '2021-03-01', '2021-03-05');

INSERT INTO Renting_History (Room_ID, Customer_ID, Hotel_Chain_Name, Renting_Date, Checkin_Date, Checkout_Date)
VALUES (4, 5, 'Radisson', '2022-02-20', '2022-03-01', '2022-03-05');

INSERT INTO Renting_History (Room_ID, Customer_ID, Hotel_Chain_Name, Renting_Date, Checkin_Date, Checkout_Date)
VALUES (5, 6, 'Radisson', '2023-02-20', '2023-03-01', '2023-03-05');

INSERT INTO Renting_History (Room_ID, Customer_ID, Hotel_Chain_Name, Renting_Date, Checkin_Date, Checkout_Date)
VALUES (1, 2, 'Hilton', '2024-02-20', '2024-03-01', '2024-03-05');

INSERT INTO Renting_History (Room_ID, Customer_ID, Hotel_Chain_Name, Renting_Date, Checkin_Date, Checkout_Date)
VALUES (2, 3, 'Hilton', '2020-02-20', '2020-03-01', '2020-03-05');

INSERT INTO Renting_History (Room_ID, Customer_ID, Hotel_Chain_Name, Renting_Date, Checkin_Date, Checkout_Date)
VALUES (3, 4, 'Hilton', '2021-02-20', '2021-03-01', '2021-03-05');

INSERT INTO Renting_History (Room_ID, Customer_ID, Hotel_Chain_Name, Renting_Date, Checkin_Date, Checkout_Date)
VALUES (4, 5, 'Hilton', '2022-02-20', '2022-03-01', '2022-03-05');

INSERT INTO Renting_History (Room_ID, Customer_ID, Hotel_Chain_Name, Renting_Date, Checkin_Date, Checkout_Date)
VALUES (5, 6, 'Hilton', '2023-02-20', '2023-03-01', '2023-03-05');

INSERT INTO Renting_History (Room_ID, Customer_ID, Hotel_Chain_Name, Renting_Date, Checkin_Date, Checkout_Date)
VALUES (1, 2, 'Holiday Inn', '2024-02-20', '2024-03-01', '2024-03-05');

INSERT INTO Renting_History (Room_ID, Customer_ID, Hotel_Chain_Name, Renting_Date, Checkin_Date, Checkout_Date)
VALUES (2, 3, 'Holiday Inn', '2020-02-20', '2020-03-01', '2020-03-05');

INSERT INTO Renting_History (Room_ID, Customer_ID, Hotel_Chain_Name, Renting_Date, Checkin_Date, Checkout_Date)
VALUES (3, 4, 'Holiday Inn', '2021-02-20', '2021-03-01', '2021-03-05');

INSERT INTO Renting_History (Room_ID, Customer_ID, Hotel_Chain_Name, Renting_Date, Checkin_Date, Checkout_Date)
VALUES (4, 5, 'Holiday Inn', '2022-02-20', '2022-03-01', '2022-03-05');

INSERT INTO Renting_History (Room_ID, Customer_ID, Hotel_Chain_Name, Renting_Date, Checkin_Date, Checkout_Date)
VALUES (5, 6, 'Holiday Inn', '2023-02-20', '2023-03-01', '2023-03-05');

INSERT INTO Renting_History (Room_ID, Customer_ID, Hotel_Chain_Name, Renting_Date, Checkin_Date, Checkout_Date)
VALUES (1, 2, 'Marriott', '2024-02-20', '2024-03-01', '2024-03-05');

INSERT INTO Renting_History (Room_ID, Customer_ID, Hotel_Chain_Name, Renting_Date, Checkin_Date, Checkout_Date)
VALUES (2, 3, 'Marriott', '2020-02-20', '2020-03-01', '2020-03-05');

INSERT INTO Renting_History (Room_ID, Customer_ID, Hotel_Chain_Name, Renting_Date, Checkin_Date, Checkout_Date)
VALUES (3, 4, 'Marriott', '2021-02-20', '2021-03-01', '2021-03-05');

INSERT INTO Renting_History (Room_ID, Customer_ID, Hotel_Chain_Name, Renting_Date, Checkin_Date, Checkout_Date)
VALUES (4, 5, 'Marriott', '2022-02-20', '2022-03-01', '2022-03-05');

INSERT INTO Renting_History (Room_ID, Customer_ID, Hotel_Chain_Name, Renting_Date, Checkin_Date, Checkout_Date)
VALUES (5, 6, 'Marriott', '2023-02-20', '2023-03-01', '2023-03-05');

INSERT INTO Renting_History (Room_ID, Customer_ID, Hotel_Chain_Name, Renting_Date, Checkin_Date, Checkout_Date)
VALUES (1, 2, 'Best Western', '2024-02-20', '2024-03-01', '2024-03-05');

INSERT INTO Renting_History (Room_ID, Customer_ID, Hotel_Chain_Name, Renting_Date, Checkin_Date, Checkout_Date)
VALUES (2, 3, 'Best Western', '2020-02-20', '2020-03-01', '2020-03-05');

INSERT INTO Renting_History (Room_ID, Customer_ID, Hotel_Chain_Name, Renting_Date, Checkin_Date, Checkout_Date)
VALUES (3, 4, 'Best Western', '2021-02-20', '2021-03-01', '2021-03-05');

INSERT INTO Renting_History (Room_ID, Customer_ID, Hotel_Chain_Name, Renting_Date, Checkin_Date, Checkout_Date)
VALUES (4, 5, 'Best Western', '2022-02-20', '2022-03-01', '2022-03-05');

INSERT INTO Renting_History (Room_ID, Customer_ID, Hotel_Chain_Name, Renting_Date, Checkin_Date, Checkout_Date)
VALUES (5, 6, 'Best Western', '2023-02-20', '2023-03-01', '2023-03-05');


--Contact Email

INSERT INTO Contact_Email_Address (Hotel_Chain_Name, Contact_Email_Address)
VALUES ('Radisson', 'email1@radisson.com');

INSERT INTO Contact_Email_Address (Hotel_Chain_Name, Contact_Email_Address)
VALUES ('Radisson', 'email2@radisson.com');

INSERT INTO Contact_Email_Address (Hotel_Chain_Name, Contact_Email_Address)
VALUES ('Hilton', 'email1@hilton.com');

INSERT INTO Contact_Email_Address (Hotel_Chain_Name, Contact_Email_Address)
VALUES ('Hilton', 'email2@hilton.com');

INSERT INTO Contact_Email_Address (Hotel_Chain_Name, Contact_Email_Address)
VALUES ('Holiday Inn', 'email1@holidayinn.com');

INSERT INTO Contact_Email_Address (Hotel_Chain_Name, Contact_Email_Address)
VALUES ('Holiday Inn', 'email2@holidayinn.com');

INSERT INTO Contact_Email_Address (Hotel_Chain_Name, Contact_Email_Address)
VALUES ('Marriott', 'email1@marriott.com');

INSERT INTO Contact_Email_Address (Hotel_Chain_Name, Contact_Email_Address)
VALUES ('Marriott', 'email2@marriott.com');

INSERT INTO Contact_Email_Address (Hotel_Chain_Name, Contact_Email_Address)
VALUES ('Best Western', 'email1@bestwestern.com');

INSERT INTO Contact_Email_Address (Hotel_Chain_Name, Contact_Email_Address)
VALUES ('Best Western', 'email2@bestwestern.com');


--Contact Phone Number

INSERT INTO Contact_Phone_Number (Hotel_Chain_Name, Contact_Phone_Number)
VALUES ('Radisson', '123-456-7890');

INSERT INTO Contact_Phone_Number (Hotel_Chain_Name, Contact_Phone_Number)
VALUES ('Radisson', '987-654-3210');

INSERT INTO Contact_Phone_Number (Hotel_Chain_Name, Contact_Phone_Number)
VALUES ('Hilton', '123-456-7890');

INSERT INTO Contact_Phone_Number (Hotel_Chain_Name, Contact_Phone_Number)
VALUES ('Hilton', '987-654-3210');

INSERT INTO Contact_Phone_Number (Hotel_Chain_Name, Contact_Phone_Number)
VALUES ('Holiday Inn', '123-456-7890');

INSERT INTO Contact_Phone_Number (Hotel_Chain_Name, Contact_Phone_Number)
VALUES ('Holiday Inn', '987-654-3210');

INSERT INTO Contact_Phone_Number (Hotel_Chain_Name, Contact_Phone_Number)
VALUES ('Marriott', '123-456-7890');

INSERT INTO Contact_Phone_Number (Hotel_Chain_Name, Contact_Phone_Number)
VALUES ('Marriott', '987-654-3210');

INSERT INTO Contact_Phone_Number (Hotel_Chain_Name, Contact_Phone_Number)
VALUES ('Best Western', '123-456-7890');

INSERT INTO Contact_Phone_Number (Hotel_Chain_Name, Contact_Phone_Number)
VALUES ('Best Western', '987-654-3210');

--Person

INSERT INTO Person (Full_Name, Address) VALUES ('John Doe', '1 Person Street');
INSERT INTO Person (Full_Name, Address) VALUES ('Jane Dow', '2 Person Street');
INSERT INTO Person (Full_Name, Address) VALUES ('Bill Dor', '3 Person Street');
INSERT INTO Person (Full_Name, Address) VALUES ('Betty Dot', '4 Person Street');
INSERT INTO Person (Full_Name, Address) VALUES ('Alex Doy', '5 Person Street');
INSERT INTO Person (Full_Name, Address) VALUES ('Anna Doo', '6 Person Street');
INSERT INTO Person (Full_Name, Address) VALUES ('Chris Dop', '7 Person Street');
INSERT INTO Person (Full_Name, Address) VALUES ('Cathy Dos', '8 Person Street');
INSERT INTO Person (Full_Name, Address) VALUES ('Dave Dod', '9 Person Street');
INSERT INTO Person (Full_Name, Address) VALUES ('Diana Dog', '10 Person Street');
INSERT INTO Person (Full_Name, Address) VALUES ('Ethan Doh', '11 Person Street');
INSERT INTO Person (Full_Name, Address) VALUES ('Erika Dok', '12 Person Street');
INSERT INTO Person (Full_Name, Address) VALUES ('Frank Dol', '13 Person Street');
INSERT INTO Person (Full_Name, Address) VALUES ('Frances Dox', '14 Person Street');
INSERT INTO Person (Full_Name, Address) VALUES ('Garry Dob', '15 Person Street');
INSERT INTO Person (Full_Name, Address) VALUES ('Grace Don', '16 Person Street');
INSERT INTO Person (Full_Name, Address) VALUES ('Ivan Dom', '17 Person Street');
INSERT INTO Person (Full_Name, Address) VALUES ('Ivy Die', '18 Person Street');
INSERT INTO Person (Full_Name, Address) VALUES ('Kai Dip', '19 Person Street');
INSERT INTO Person (Full_Name, Address) VALUES ('Kate Dim', '20 Person Street');
INSERT INTO Person (Full_Name, Address) VALUES ('Lenny Din', '21 Person Street');
INSERT INTO Person (Full_Name, Address) VALUES ('Laura Dib', '22 Person Street');
INSERT INTO Person (Full_Name, Address) VALUES ('Micky Div', '23 Person Street');
INSERT INTO Person (Full_Name, Address) VALUES ('Mini Dix', '24 Person Street');
INSERT INTO Person (Full_Name, Address) VALUES ('Nancy Did', '25 Person Street');

INSERT INTO Person (Full_Name, Address) VALUES ('John Boe', '26 Person Street');
INSERT INTO Person (Full_Name, Address) VALUES ('Jane Bow', '27 Person Street');
INSERT INTO Person (Full_Name, Address) VALUES ('Bill Bor', '28 Person Street');
INSERT INTO Person (Full_Name, Address) VALUES ('Betty Bot', '29 Person Street');
INSERT INTO Person (Full_Name, Address) VALUES ('Alex Boy', '30 Person Street');
INSERT INTO Person (Full_Name, Address) VALUES ('Anna Boo', '31 Person Street');
INSERT INTO Person (Full_Name, Address) VALUES ('Chris Bop', '32 Person Street');
INSERT INTO Person (Full_Name, Address) VALUES ('Cathy Bos', '34 Person Street');
INSERT INTO Person (Full_Name, Address) VALUES ('Dave Bod', '35 Person Street');
INSERT INTO Person (Full_Name, Address) VALUES ('Diana Bog', '36 Person Street');
INSERT INTO Person (Full_Name, Address) VALUES ('Ethan Boh', '37 Person Street');
INSERT INTO Person (Full_Name, Address) VALUES ('Erika Bok', '38 Person Street');
INSERT INTO Person (Full_Name, Address) VALUES ('Frank Bol', '39 Person Street');
INSERT INTO Person (Full_Name, Address) VALUES ('Frances Box', '40 Person Street');
INSERT INTO Person (Full_Name, Address) VALUES ('Garry Bob', '41 Person Street');
INSERT INTO Person (Full_Name, Address) VALUES ('Grace Bon', '42 Person Street');
INSERT INTO Person (Full_Name, Address) VALUES ('Ivan Bom', '43 Person Street');
INSERT INTO Person (Full_Name, Address) VALUES ('Ivy Bie', '44 Person Street');
INSERT INTO Person (Full_Name, Address) VALUES ('Kai Bip', '45 Person Street');
INSERT INTO Person (Full_Name, Address) VALUES ('Kate Bim', '46 Person Street');
INSERT INTO Person (Full_Name, Address) VALUES ('Lenny Bin', '47 Person Street');
INSERT INTO Person (Full_Name, Address) VALUES ('Laura Bib', '48 Person Street');
INSERT INTO Person (Full_Name, Address) VALUES ('Micky Biv', '49 Person Street');
INSERT INTO Person (Full_Name, Address) VALUES ('Mini Bix', '50 Person Street');
INSERT INTO Person (Full_Name, Address) VALUES ('Nancy Bid', '51 Person Street');

INSERT INTO Person (Full_Name, Address) VALUES ('John Coe', '61 Person Street');
INSERT INTO Person (Full_Name, Address) VALUES ('Jane Cow', '62 Person Street');
INSERT INTO Person (Full_Name, Address) VALUES ('Bill Cor', '63 Person Street');
INSERT INTO Person (Full_Name, Address) VALUES ('Betty Cot', '64 Person Street');
INSERT INTO Person (Full_Name, Address) VALUES ('Alex Coy', '65 Person Street');
INSERT INTO Person (Full_Name, Address) VALUES ('Anna Coo', '66 Person Street');
INSERT INTO Person (Full_Name, Address) VALUES ('Chris Cop', '67 Person Street');
INSERT INTO Person (Full_Name, Address) VALUES ('Cathy Cos', '68 Person Street');
INSERT INTO Person (Full_Name, Address) VALUES ('Dave Cod', '69 Person Street');
INSERT INTO Person (Full_Name, Address) VALUES ('Diana Cog', '70 Person Street');
INSERT INTO Person (Full_Name, Address) VALUES ('Ethan Coh', '71 Person Street');
INSERT INTO Person (Full_Name, Address) VALUES ('Erika Cok', '72 Person Street');
INSERT INTO Person (Full_Name, Address) VALUES ('Frank Col', '73 Person Street');
INSERT INTO Person (Full_Name, Address) VALUES ('Frances Cox', '74 Person Street');
INSERT INTO Person (Full_Name, Address) VALUES ('Garry Cob', '75 Person Street');
INSERT INTO Person (Full_Name, Address) VALUES ('Grace Con', '76 Person Street');
INSERT INTO Person (Full_Name, Address) VALUES ('Ivan Com', '77 Person Street');
INSERT INTO Person (Full_Name, Address) VALUES ('Ivy Cie', '78 Person Street');
INSERT INTO Person (Full_Name, Address) VALUES ('Kai Cip', '79 Person Street');
INSERT INTO Person (Full_Name, Address) VALUES ('Kate Cim', '80 Person Street');
INSERT INTO Person (Full_Name, Address) VALUES ('Lenny Cin', '81 Person Street');
INSERT INTO Person (Full_Name, Address) VALUES ('Laura Cib', '82 Person Street');
INSERT INTO Person (Full_Name, Address) VALUES ('Micky Civ', '83 Person Street');
INSERT INTO Person (Full_Name, Address) VALUES ('Mini Cix', '84 Person Street');
INSERT INTO Person (Full_Name, Address) VALUES ('Nancy Cid', '85 Person Street');

INSERT INTO Person (Full_Name, Address) VALUES ('John Foe', '86 Person Street');
INSERT INTO Person (Full_Name, Address) VALUES ('Jane Fow', '87 Person Street');
INSERT INTO Person (Full_Name, Address) VALUES ('Bill For', '88 Person Street');
INSERT INTO Person (Full_Name, Address) VALUES ('Betty Fot', '89 Person Street');
INSERT INTO Person (Full_Name, Address) VALUES ('Alex Foy', '90 Person Street');
INSERT INTO Person (Full_Name, Address) VALUES ('Anna Foo', '91 Person Street');
INSERT INTO Person (Full_Name, Address) VALUES ('Chris Fop', '92 Person Street');
INSERT INTO Person (Full_Name, Address) VALUES ('Cathy Fos', '94 Person Street');
INSERT INTO Person (Full_Name, Address) VALUES ('Dave Fod', '95 Person Street');
INSERT INTO Person (Full_Name, Address) VALUES ('Diana Fog', '96 Person Street');
INSERT INTO Person (Full_Name, Address) VALUES ('Ethan Foh', '97 Person Street');
INSERT INTO Person (Full_Name, Address) VALUES ('Erika Fok', '98 Person Street');
INSERT INTO Person (Full_Name, Address) VALUES ('Frank Fol', '99 Person Street');
INSERT INTO Person (Full_Name, Address) VALUES ('Frances Fox', '100 Person Street');
INSERT INTO Person (Full_Name, Address) VALUES ('Garry Fob', '101 Person Street');
INSERT INTO Person (Full_Name, Address) VALUES ('Grace Fon', '102 Person Street');
INSERT INTO Person (Full_Name, Address) VALUES ('Ivan Fom', '103 Person Street');
INSERT INTO Person (Full_Name, Address) VALUES ('Ivy Fie', '104 Person Street');
INSERT INTO Person (Full_Name, Address) VALUES ('Kai Fip', '105 Person Street');
INSERT INTO Person (Full_Name, Address) VALUES ('Kate Fim', '106 Person Street');
INSERT INTO Person (Full_Name, Address) VALUES ('Lenny Fin', '107 Person Street');
INSERT INTO Person (Full_Name, Address) VALUES ('Laura Fib', '108 Person Street');
INSERT INTO Person (Full_Name, Address) VALUES ('Micky Fiv', '109 Person Street');
INSERT INTO Person (Full_Name, Address) VALUES ('Mini Fix', '110 Person Street');
INSERT INTO Person (Full_Name, Address) VALUES ('Nancy Fid', '111 Person Street');

INSERT INTO Person (Full_Name, Address) VALUES ('John Goe', '112 Person Street');
INSERT INTO Person (Full_Name, Address) VALUES ('Jane Gow', '113 Person Street');
INSERT INTO Person (Full_Name, Address) VALUES ('Bill Gor', '114 Person Street');
INSERT INTO Person (Full_Name, Address) VALUES ('Betty Got', '115 Person Street');
INSERT INTO Person (Full_Name, Address) VALUES ('Alex Goy', '116 Person Street');
INSERT INTO Person (Full_Name, Address) VALUES ('Anna Goo', '117 Person Street');
INSERT INTO Person (Full_Name, Address) VALUES ('Chris Gop', '118 Person Street');
INSERT INTO Person (Full_Name, Address) VALUES ('Cathy Gos', '119 Person Street');
INSERT INTO Person (Full_Name, Address) VALUES ('Dave God', '120 Person Street');
INSERT INTO Person (Full_Name, Address) VALUES ('Diana Gog', '121 Person Street');
INSERT INTO Person (Full_Name, Address) VALUES ('Ethan Goh', '122 Person Street');
INSERT INTO Person (Full_Name, Address) VALUES ('Erika Gok', '123 Person Street');
INSERT INTO Person (Full_Name, Address) VALUES ('Frank Gol', '124 Person Street');
INSERT INTO Person (Full_Name, Address) VALUES ('Frances Gox', '125 Person Street');
INSERT INTO Person (Full_Name, Address) VALUES ('Garry Gob', '126 Person Street');
INSERT INTO Person (Full_Name, Address) VALUES ('Grace Gon', '127 Person Street');
INSERT INTO Person (Full_Name, Address) VALUES ('Ivan Gom', '128 Person Street');
INSERT INTO Person (Full_Name, Address) VALUES ('Ivy Gie', '129 Person Street');
INSERT INTO Person (Full_Name, Address) VALUES ('Kai Gip', '130 Person Street');
INSERT INTO Person (Full_Name, Address) VALUES ('Kate Gim', '131 Person Street');
INSERT INTO Person (Full_Name, Address) VALUES ('Lenny Gin', '132 Person Street');
INSERT INTO Person (Full_Name, Address) VALUES ('Laura Gib', '133 Person Street');
INSERT INTO Person (Full_Name, Address) VALUES ('Micky Giv', '134 Person Street');
INSERT INTO Person (Full_Name, Address) VALUES ('Mini Gix', '135 Person Street');
INSERT INTO Person (Full_Name, Address) VALUES ('Nancy Gid', '136 Person Street');



--Customer
INSERT INTO Customer (Person_ID, Full_Name, Address, ID_Type, Registration_Date)
VALUES ((SELECT Person_ID FROM Person WHERE Full_Name = 'Anna Foo'), 'Anna Foo', (SELECT Address FROM Person WHERE Full_Name = 'Anna Foo'), 'SSN', '2024-02-25');

INSERT INTO Customer (Person_ID, Full_Name, Address, ID_Type, Registration_Date)
VALUES ((SELECT Person_ID FROM Person WHERE Full_Name = 'Chris Fop'), 'Chris Fop', (SELECT Address FROM Person WHERE Full_Name = 'Chris Fop'), 'SSN', '2024-02-25');

INSERT INTO Customer (Person_ID, Full_Name, Address, ID_Type, Registration_Date)
VALUES ((SELECT Person_ID FROM Person WHERE Full_Name = 'Cathy Fos'), 'Cathy Fos', (SELECT Address FROM Person WHERE Full_Name = 'Cathy Fos'), 'SSN', '2024-02-25');

INSERT INTO Customer (Person_ID, Full_Name, Address, ID_Type, Registration_Date)
VALUES ((SELECT Person_ID FROM Person WHERE Full_Name = 'Dave Fod'), 'Dave Fod', (SELECT Address FROM Person WHERE Full_Name = 'Dave Fod'), 'SSN', '2024-02-25');

INSERT INTO Customer (Person_ID, Full_Name, Address, ID_Type, Registration_Date)
VALUES ((SELECT Person_ID FROM Person WHERE Full_Name = 'Diana Fog'), 'Diana Fog', (SELECT Address FROM Person WHERE Full_Name = 'Diana Fog'), 'SSN', '2024-02-25');

INSERT INTO Customer (Person_ID, Full_Name, Address, ID_Type, Registration_Date)
VALUES ((SELECT Person_ID FROM Person WHERE Full_Name = 'Ethan Foh'), 'Ethan Foh', (SELECT Address FROM Person WHERE Full_Name = 'Ethan Foh'), 'SSN', '2024-02-25');

INSERT INTO Customer (Person_ID, Full_Name, Address, ID_Type, Registration_Date)
VALUES ((SELECT Person_ID FROM Person WHERE Full_Name = 'Erika Fok'), 'Erika Fok', (SELECT Address FROM Person WHERE Full_Name = 'Erika Fok'), 'SSN', '2024-02-25');

INSERT INTO Customer (Person_ID, Full_Name, Address, ID_Type, Registration_Date)
VALUES ((SELECT Person_ID FROM Person WHERE Full_Name = 'Frank Fol'), 'Frank Fol', (SELECT Address FROM Person WHERE Full_Name = 'Frank Fol'), 'SSN', '2024-02-25');

INSERT INTO Customer (Person_ID, Full_Name, Address, ID_Type, Registration_Date)
VALUES ((SELECT Person_ID FROM Person WHERE Full_Name = 'Frances Fox'), 'Frances Fox', (SELECT Address FROM Person WHERE Full_Name = 'Frances Fox'), 'SSN', '2024-02-25');

INSERT INTO Customer (Person_ID, Full_Name, Address, ID_Type, Registration_Date)
VALUES ((SELECT Person_ID FROM Person WHERE Full_Name = 'Garry Fob'), 'Garry Fob', (SELECT Address FROM Person WHERE Full_Name = 'Garry Fob'), 'SSN', '2024-02-25');

INSERT INTO Customer (Person_ID, Full_Name, Address, ID_Type, Registration_Date)
VALUES ((SELECT Person_ID FROM Person WHERE Full_Name = 'Grace Fon'), 'Grace Fon', (SELECT Address FROM Person WHERE Full_Name = 'Grace Fon'), 'SSN', '2024-02-25');

INSERT INTO Customer (Person_ID, Full_Name, Address, ID_Type, Registration_Date)
VALUES ((SELECT Person_ID FROM Person WHERE Full_Name = 'Ivan Fom'), 'Ivan Fom', (SELECT Address FROM Person WHERE Full_Name = 'Ivan Fom'), 'SSN', '2024-02-25');

INSERT INTO Customer (Person_ID, Full_Name, Address, ID_Type, Registration_Date)
VALUES ((SELECT Person_ID FROM Person WHERE Full_Name = 'Ivy Fie'), 'Ivy Fie', (SELECT Address FROM Person WHERE Full_Name = 'Ivy Fie'), 'SSN', '2024-02-25');

INSERT INTO Customer (Person_ID, Full_Name, Address, ID_Type, Registration_Date)
VALUES ((SELECT Person_ID FROM Person WHERE Full_Name = 'Kai Fip'), 'Kai Fip', (SELECT Address FROM Person WHERE Full_Name = 'Kai Fip'), 'SSN', '2024-02-25');

INSERT INTO Customer (Person_ID, Full_Name, Address, ID_Type, Registration_Date)
VALUES ((SELECT Person_ID FROM Person WHERE Full_Name = 'Kate Fim'), 'Kate Fim', (SELECT Address FROM Person WHERE Full_Name = 'Kate Fim'), 'SSN', '2024-02-25');

INSERT INTO Customer (Person_ID, Full_Name, Address, ID_Type, Registration_Date)
VALUES ((SELECT Person_ID FROM Person WHERE Full_Name = 'Lenny Fin'), 'Lenny Fin', (SELECT Address FROM Person WHERE Full_Name = 'Lenny Fin'), 'SSN', '2024-02-25');

INSERT INTO Customer (Person_ID, Full_Name, Address, ID_Type, Registration_Date)
VALUES ((SELECT Person_ID FROM Person WHERE Full_Name = 'Laura Fib'), 'Laura Fib', (SELECT Address FROM Person WHERE Full_Name = 'Laura Fib'), 'SSN', '2024-02-25');

INSERT INTO Customer (Person_ID, Full_Name, Address, ID_Type, Registration_Date)
VALUES ((SELECT Person_ID FROM Person WHERE Full_Name = 'Micky Fiv'), 'Micky Fiv', (SELECT Address FROM Person WHERE Full_Name = 'Micky Fiv'), 'SSN', '2024-02-25');

INSERT INTO Customer (Person_ID, Full_Name, Address, ID_Type, Registration_Date)
VALUES ((SELECT Person_ID FROM Person WHERE Full_Name = 'Mini Fix'), 'Mini Fix', (SELECT Address FROM Person WHERE Full_Name = 'Mini Fix'), 'SSN', '2024-02-25');

INSERT INTO Customer (Person_ID, Full_Name, Address, ID_Type, Registration_Date)
VALUES ((SELECT Person_ID FROM Person WHERE Full_Name = 'Nancy Fid'), 'Nancy Fid', (SELECT Address FROM Person WHERE Full_Name = 'Nancy Fid'), 'SSN', '2024-02-25');

INSERT INTO Customer (Person_ID, Full_Name, Address, ID_Type, Registration_Date)
VALUES ((SELECT Person_ID FROM Person WHERE Full_Name = 'John Goe'), 'John Goe', (SELECT Address FROM Person WHERE Full_Name = 'John Goe'), 'SSN', '2024-02-25');

INSERT INTO Customer (Person_ID, Full_Name, Address, ID_Type, Registration_Date)
VALUES ((SELECT Person_ID FROM Person WHERE Full_Name = 'Jane Gow'), 'Jane Gow', (SELECT Address FROM Person WHERE Full_Name = 'Jane Gow'), 'SSN', '2024-02-25');

INSERT INTO Customer (Person_ID, Full_Name, Address, ID_Type, Registration_Date)
VALUES ((SELECT Person_ID FROM Person WHERE Full_Name = 'Bill Gor'), 'Bill Gor', (SELECT Address FROM Person WHERE Full_Name = 'Bill Gor'), 'SSN', '2024-02-25');

INSERT INTO Customer (Person_ID, Full_Name, Address, ID_Type, Registration_Date)
VALUES ((SELECT Person_ID FROM Person WHERE Full_Name = 'Betty Got'), 'Betty Got', (SELECT Address FROM Person WHERE Full_Name = 'Betty Got'), 'SSN', '2024-02-25');

INSERT INTO Customer (Person_ID, Full_Name, Address, ID_Type, Registration_Date)
VALUES ((SELECT Person_ID FROM Person WHERE Full_Name = 'Alex Goy'), 'Alex Goy', (SELECT Address FROM Person WHERE Full_Name = 'Alex Goy'), 'SSN', '2024-02-25');

INSERT INTO Customer (Person_ID, Full_Name, Address, ID_Type, Registration_Date)
VALUES ((SELECT Person_ID FROM Person WHERE Full_Name = 'Anna Goo'), 'Anna Goo', (SELECT Address FROM Person WHERE Full_Name = 'Anna Goo'), 'SSN', '2024-02-25');

INSERT INTO Customer (Person_ID, Full_Name, Address, ID_Type, Registration_Date)
VALUES ((SELECT Person_ID FROM Person WHERE Full_Name = 'Chris Gop'), 'Chris Gop', (SELECT Address FROM Person WHERE Full_Name = 'Chris Gop'), 'SSN', '2024-02-25');

INSERT INTO Customer (Person_ID, Full_Name, Address, ID_Type, Registration_Date)
VALUES ((SELECT Person_ID FROM Person WHERE Full_Name = 'Cathy Gos'), 'Cathy Gos', (SELECT Address FROM Person WHERE Full_Name = 'Cathy Gos'), 'SSN', '2024-02-25');

INSERT INTO Customer (Person_ID, Full_Name, Address, ID_Type, Registration_Date)
VALUES ((SELECT Person_ID FROM Person WHERE Full_Name = 'Dave God'), 'Dave God', (SELECT Address FROM Person WHERE Full_Name = 'Dave God'), 'SSN', '2024-02-25');

INSERT INTO Customer (Person_ID, Full_Name, Address, ID_Type, Registration_Date)
VALUES ((SELECT Person_ID FROM Person WHERE Full_Name = 'Diana Gog'), 'Diana Gog', (SELECT Address FROM Person WHERE Full_Name = 'Diana Gog'), 'SSN', '2024-02-25');

INSERT INTO Customer (Person_ID, Full_Name, Address, ID_Type, Registration_Date)
VALUES ((SELECT Person_ID FROM Person WHERE Full_Name = 'Ethan Goh'), 'Ethan Goh', (SELECT Address FROM Person WHERE Full_Name = 'Ethan Goh'), 'SSN', '2024-02-25');

INSERT INTO Customer (Person_ID, Full_Name, Address, ID_Type, Registration_Date)
VALUES ((SELECT Person_ID FROM Person WHERE Full_Name = 'Erika Gok'), 'Erika Gok', (SELECT Address FROM Person WHERE Full_Name = 'Erika Gok'), 'SSN', '2024-02-25');

INSERT INTO Customer (Person_ID, Full_Name, Address, ID_Type, Registration_Date)
VALUES ((SELECT Person_ID FROM Person WHERE Full_Name = 'Frank Gol'), 'Frank Gol', (SELECT Address FROM Person WHERE Full_Name = 'Frank Gol'), 'SSN', '2024-02-25');

INSERT INTO Customer (Person_ID, Full_Name, Address, ID_Type, Registration_Date)
VALUES ((SELECT Person_ID FROM Person WHERE Full_Name = 'Frances Gox'), 'Frances Gox', (SELECT Address FROM Person WHERE Full_Name = 'Frances Gox'), 'SSN', '2024-02-25');

INSERT INTO Customer (Person_ID, Full_Name, Address, ID_Type, Registration_Date)
VALUES ((SELECT Person_ID FROM Person WHERE Full_Name = 'Garry Gob'), 'Garry Gob', (SELECT Address FROM Person WHERE Full_Name = 'Garry Gob'), 'SSN', '2024-02-25');

INSERT INTO Customer (Person_ID, Full_Name, Address, ID_Type, Registration_Date)
VALUES ((SELECT Person_ID FROM Person WHERE Full_Name = 'Grace Gon'), 'Grace Gon', (SELECT Address FROM Person WHERE Full_Name = 'Grace Gon'), 'SSN', '2024-02-25');

INSERT INTO Customer (Person_ID, Full_Name, Address, ID_Type, Registration_Date)
VALUES ((SELECT Person_ID FROM Person WHERE Full_Name = 'Ivan Gom'), 'Ivan Gom', (SELECT Address FROM Person WHERE Full_Name = 'Ivan Gom'), 'SSN', '2024-02-25');

INSERT INTO Customer (Person_ID, Full_Name, Address, ID_Type, Registration_Date)
VALUES ((SELECT Person_ID FROM Person WHERE Full_Name = 'Ivy Gie'), 'Ivy Gie', (SELECT Address FROM Person WHERE Full_Name = 'Ivy Gie'), 'SSN', '2024-02-25');

INSERT INTO Customer (Person_ID, Full_Name, Address, ID_Type, Registration_Date)
VALUES ((SELECT Person_ID FROM Person WHERE Full_Name = 'Kai Gip'), 'Kai Gip', (SELECT Address FROM Person WHERE Full_Name = 'Kai Gip'), 'SSN', '2024-02-25');

INSERT INTO Customer (Person_ID, Full_Name, Address, ID_Type, Registration_Date)
VALUES ((SELECT Person_ID FROM Person WHERE Full_Name = 'Kate Gim'), 'Kate Gim', (SELECT Address FROM Person WHERE Full_Name = 'Kate Gim'), 'SSN', '2024-02-25');



--Employee

INSERT INTO Employee (Person_ID, Full_Name, Address, Hotel_ID, SSN_Or_SIN) --Inserts the first round of employees
SELECT 
    p.Person_ID,
    p.Full_Name,
    p.Address,
    h.Hotel_ID,
    '123-45-6789' AS SSN_Or_SIN
FROM 
    (SELECT *, ROW_NUMBER() OVER () AS row_num FROM Person) AS p
CROSS JOIN
    (SELECT *, ROW_NUMBER() OVER () AS row_num FROM Hotel) AS h
WHERE
    p.row_num = h.row_num
AND
    p.row_num <= 80;


INSERT INTO Employee (Person_ID, Full_Name, Address, Hotel_ID, SSN_Or_SIN) --Inserts the second round of employees
SELECT 
    p.Person_ID,
    p.Full_Name,
    p.Address,
    h.Hotel_ID,
    '123-45-6789' AS SSN_Or_SIN
FROM 
    (SELECT *, ROW_NUMBER() OVER () AS row_num FROM Person) AS p
CROSS JOIN
    (SELECT *, ROW_NUMBER() OVER () AS row_num FROM Hotel) AS h
WHERE
    p.row_num >= 40
AND
    p.row_num = h.row_num + 40
AND
    p.row_num <= 80; --Makes sure only half of the people are turned into employees (the other half become customers)



--Booking

INSERT INTO Booking (Customer_ID, Booking_Date, Checkin_Date, Checkout_Date, Hotel_ID, Room_ID)
SELECT 
    Customer.Customer_ID,
    '2024-02-28' AS Booking_Date,
    '2024-03-10' AS Checkin_Date,
    '2024-03-15' AS Checkout_Date,
    Room.Hotel_ID,
    Room.Room_ID
FROM 
    (SELECT Customer_ID, ROW_NUMBER() OVER () AS row_num FROM Customer) AS Customer
CROSS JOIN 
    (SELECT Hotel_ID, Room_ID, ROW_NUMBER() OVER () AS row_num FROM Room) AS Room
WHERE
    Customer.row_num = Room.row_num;


--Role

INSERT INTO Role (Employee_ID, Role) SELECT Employee_ID, 'Housekeeping' FROM Employee;


--Renting
INSERT INTO Renting (Employee_ID, Customer_ID, Renting_Date, Checkin_Date, Checkout_Date, Hotel_ID, Booking_ID, Room_ID)
SELECT 
    Employee.Employee_ID,
    Customer.Customer_ID,
    '2024-03-01' AS Renting_Date,
    '2024-03-10' AS Checkin_Date,
    '2024-03-15' AS Checkout_Date,
    Room.Hotel_ID,
    NULL AS Booking_ID,
    Room.Room_ID
FROM 
    (SELECT Customer_ID, ROW_NUMBER() OVER () AS row_num FROM Customer) AS Customer
CROSS JOIN 
    (SELECT Hotel_ID, Room_ID, ROW_NUMBER() OVER () AS row_num FROM Room) AS Room
JOIN 
    Employee ON Employee.Hotel_ID = Room.Hotel_ID
WHERE
    Customer.row_num = Room.row_num;



------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- 2 c)

SELECT Hotel_ID, Address, Rating, Number_Of_Rooms FROM Hotel WHERE Hotel_Chain_Name = 'Radisson'; --Finds all of the hotels belonging to a hotel chain

SELECT * FROM Amenity WHERE Room_ID = 10 AND Hotel_ID = 1; --Lists all of the amenities associated with a given hotel room in a given hotel

SELECT * FROM Problem WHERE Room_ID = 10 AND Hotel_ID = 1; --Lists all of the problems associated with a given hotel room in a given hotel

SELECT c.Hotel_Chain_Name, COUNT(e.Employee_ID) AS Number_of_Employees FROM Hotel_Chain c JOIN Hotel h ON c.Hotel_Chain_Name = h.Hotel_Chain_Name JOIN Employee e ON h.Hotel_ID = e.Hotel_ID 
WHERE c.Hotel_Chain_Name = 'Radisson' GROUP BY c.Hotel_Chain_Name; --Finds how many employees work at a given hotel chain via aggregation (Count)

SELECT Room_ID, Price, Capacity, View FROM Room WHERE Room_ID IN (
	SELECT DISTINCT r.Room_ID FROM Booking b JOIN Room r ON b.Hotel_ID = r.Hotel_ID AND b.Room_ID = r.Room_ID
    WHERE b.Hotel_ID = 1
); --Finds the rooms in a given hotel that have been booked by customers using a nested query





-- 2d
-- Trigger to enforce a constraint on the Room table ensuring that the Hotel_Name is valid, ensuring that the Manager_ID is valid, and ensuring that the rating is valid.
CREATE OR REPLACE FUNCTION validate_hotel_chain_name_function()
RETURNS TRIGGER AS $$
BEGIN
    IF NOT EXISTS (SELECT 1 FROM Hotel_Chain WHERE Hotel_Chain_Name = NEW.Hotel_Chain_Name) THEN
        RAISE EXCEPTION 'Invalid Hotel_Chain_Name: %', NEW.Hotel_Chain_Name;
	END IF;
	IF NOT EXISTS (SELECT 1 FROM Employee WHERE Employee_ID = NEW.Manager_ID) THEN
        RAISE EXCEPTION 'Invalid Manager_ID: %', NEW.Manager_ID;
    END IF;
	IF NEW.rating > 5 OR NEW.rating < 1 THEN
        RAISE EXCEPTION 'Invalid rating: %. Must be between 1 and 5', NEW.rating;
    END IF;
	RETURN NULL;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER validate_hotel_chain_name_trigger
BEFORE INSERT OR UPDATE ON Hotel
FOR EACH ROW
EXECUTE FUNCTION validate_hotel_chain_name_function();

-- Trigger to enforce a constraint on the Room table ensuring that the Hotel_ID is valid and ensuring that the view is 'mountain' or 'sea'.
CREATE OR REPLACE FUNCTION validate_hotel_id_function()
RETURNS TRIGGER AS $$
BEGIN
    IF NOT EXISTS (SELECT 1 FROM Hotel WHERE Hotel_ID = NEW.Hotel_ID) THEN
        RAISE EXCEPTION 'Invalid Hotel_ID: %', NEW.Hotel_ID;
    END IF;
	IF NEW.view != 'Sea' AND NEW.view != 'Mountain' THEN
        RAISE EXCEPTION 'Invalid view: %. Must be "Sea" or "Mountain"', NEW.view;
    END IF;
	RETURN NULL;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER validate_hotel_id_trigger
BEFORE INSERT OR UPDATE ON Room
FOR EACH ROW
EXECUTE FUNCTION validate_hotel_id_function();

-- Trigger to enforce a constraint on the Booking table ensuring that the Room_ID is valid.
CREATE OR REPLACE FUNCTION validate_room_id_function_booking()
RETURNS TRIGGER AS $$
BEGIN
    IF NOT EXISTS (SELECT 1 FROM Room WHERE Room_ID = NEW.Room_ID) THEN
        RAISE EXCEPTION 'Invalid Room_ID: %', NEW.Room_ID;
    END IF;
	RETURN NULL;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER validate_room_id_trigger_booking
BEFORE INSERT OR UPDATE ON Booking
FOR EACH ROW
EXECUTE FUNCTION validate_room_id_function_booking();

-- Trigger to enforce a constraint on the Renting table ensuring that the Room_ID is valid.
CREATE OR REPLACE FUNCTION validate_room_id_function_renting()
RETURNS TRIGGER AS $$
BEGIN
    IF NOT EXISTS (SELECT 1 FROM Room WHERE Room_ID = NEW.Room_ID) THEN
        RAISE EXCEPTION 'Invalid Room_ID: %', NEW.Room_ID;
    END IF;
	RETURN NULL;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER validate_room_id_trigger_renting
BEFORE INSERT OR UPDATE ON Renting
FOR EACH ROW
EXECUTE FUNCTION validate_room_id_function_renting();

-- Trigger to increment/decrement the number of hotels. DONE
CREATE OR REPLACE FUNCTION update_hotel_chain_count_function()
RETURNS TRIGGER AS $$
BEGIN
    IF TG_OP = 'INSERT' THEN
        UPDATE Hotel_Chain 
        SET Number_of_Hotels = Number_of_Hotels + 1 
        WHERE Hotel_Chain_Name = NEW.Hotel_Chain_Name;
    ELSIF TG_OP = 'DELETE' THEN
        UPDATE Hotel_Chain 
        SET Number_of_Hotels = Number_of_Hotels - 1 
        WHERE Hotel_Chain_Name = OLD.Hotel_Chain_Name;
    END IF;
	RETURN NULL;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER update_hotel_chain_count_trigger
AFTER INSERT OR DELETE ON Hotel
FOR EACH ROW
EXECUTE FUNCTION update_hotel_chain_count_function();

-- Trigger to increment/decrement the number of rooms. DONE
CREATE OR REPLACE FUNCTION update_hotel_room_count_function()
RETURNS TRIGGER AS $$
BEGIN
    IF TG_OP = 'INSERT' THEN
        UPDATE Hotel 
        SET Number_of_Rooms = Number_of_Rooms + 1 
        WHERE Hotel_ID = NEW.Hotel_ID;
    ELSIF TG_OP = 'DELETE' THEN
        UPDATE Hotel 
        SET Number_of_Rooms = Number_of_Rooms - 1 
        WHERE Hotel_ID = OLD.Hotel_ID;
    END IF;
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER update_hotel_room_count_trigger
AFTER INSERT OR DELETE ON Room
FOR EACH ROW
EXECUTE FUNCTION update_hotel_room_count_function();

-- 2e DONE

CREATE INDEX hotel_chain_name_index ON Hotel (Hotel_Chain_Name);
-- Expected queries: Queries that involve filtering or joining based on the Hotel_Chain_Name column, such as finding all hotels belonging to a specific hotel chain. Additionally, displaying hotel information utilizes queries that need to search for hotels by their hotel chain name.

CREATE INDEX person_full_name_index ON Person (Full_Name);
-- Expected queries: Queries that involve searching for a person by their full name, such as looking up customer information or employee details. Additionally, creating a customer account or employee profile utilize queries that need to search for a person by their full name.

CREATE INDEX room_hotel_id_index ON Room (Hotel_ID);
-- Expected queries: Queries that involve displaying or filtering rooms based on the hotel they are a part of, such as finding all available rooms in a specific hotel.

/*
All of these indexs would allow data to be retrieved more quickly as the queries would not have to search through the entire table to find the relevant data. Instead, the index would allow the query to quickly locate the relevant data based on the indexed column.
These columns (Hotel_Chain_Name, Full_Name, Hotel_ID) are likely to be used in WHERE clauses or JOIN conditions, making them good candidates for indexing.
In addition, they values in these columns are likely to not need to be updated frequently, making them good candidates for indexing.
*/

-- 2f DONE
-- View 1: AvailableRoomsPerHotel
CREATE VIEW AvailableRoomsPerArea AS
SELECT r.View, COUNT(*) AS NumAvailableRooms
FROM Room r
LEFT JOIN Booking b ON r.Room_ID = b.Room_ID
LEFT JOIN Renting rt ON r.Room_ID = rt.Room_ID
WHERE b.Room_ID IS NULL AND rt.Room_ID IS NULL
GROUP BY r.View;

-- View 2:  capacityOfRooms
CREATE VIEW capacityOfRooms AS
SELECT  SUM(Capacity) AS TotalCapacity
FROM Room WHERE Hotel_ID = 3;