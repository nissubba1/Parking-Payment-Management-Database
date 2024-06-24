/*
Andrew Stine - Individual Feature 1
Arseniy Vasylchenko - Individual Feature 2
Ameed Saikh- Individual Feature 3
Nishan Subba- Individual Feature 4
Ansh Shah - Individual Feature 5
*/
-- Create Table:
-- Mobile Parking Database: System Design, ER Diagram

-- Dropping tables if they exist
DROP TABLE Customers CASCADE CONSTRAINTS;
DROP TABLE ParkingZones CASCADE CONSTRAINTS;
DROP TABLE Vehicles CASCADE CONSTRAINTS;
DROP TABLE ParkingSessions CASCADE CONSTRAINTS;
DROP TABLE Payments CASCADE CONSTRAINTS;
DROP TABLE Messages CASCADE CONSTRAINTS;

-- Drop Sequence
DROP SEQUENCE CustomerID_Seq;
DROP SEQUENCE ZoneID_Seq;
DROP SEQUENCE VehicleID_Seq;
DROP SEQUENCE SessionID_Seq;
DROP SEQUENCE PaymentID_Seq;
DROP SEQUENCE MessageID_Seq;

-- CREATE Sequence 
CREATE SEQUENCE CustomerID_Seq
START WITH 1
INCREMENT BY 1;

CREATE SEQUENCE ZoneID_Seq
START WITH 1
INCREMENT BY 1;

CREATE SEQUENCE VehicleID_Seq
START WITH 1
INCREMENT BY 1;

CREATE SEQUENCE SessionID_Seq
START WITH 1
INCREMENT BY 1;

CREATE SEQUENCE PaymentID_Seq
START WITH 1
INCREMENT BY 1;

CREATE SEQUENCE MessageID_Seq
START WITH 1
INCREMENT BY 1;


-- Create Customers table:
CREATE TABLE Customers (
    CustomerID NUMBER NOT NULL, -- Unique identifier for each customer
    Name VARCHAR2(255), -- Full name of the customer
    Address VARCHAR2(255), -- Address of the customer
    Zipcode VARCHAR2(10), -- Customer's address ZipCode
    State VARCHAR2(50), -- State customer lives in
    Email VARCHAR2(255) UNIQUE, -- Unique Email of the customer
    PhoneNumber VARCHAR2(15) UNIQUE, -- Customer's phone number
    PaymentCardNumber VARCHAR2(19), -- Customer's payment card number
    PRIMARY KEY (CustomerID) -- Primary Key for customer table
);

-- Inserting data into the Customers table:
INSERT INTO Customers
    (CustomerID, Name, Address, Zipcode, State, Email, PhoneNumber, PaymentCardNumber)
VALUES
    (CustomerID_Seq.NEXTVAL, 'Jeremy Renner', '702 Ben Street', '12210', 'NY', 'jeremyr@gmail.com', '518-560-0605', '4485449068733539');
    
INSERT INTO Customers
    (CustomerID, Name, Address, Zipcode, State, Email, PhoneNumber, PaymentCardNumber)
VALUES
    (CustomerID_Seq.NEXTVAL, 'Elizabeth Olsen', '2452 Willow Drive', '36104', 'AL', 'elizabetho@gmail.com', '334-301-3299', '4916348050081924');
    
INSERT INTO Customers
    (CustomerID, Name, Address, Zipcode, State, Email, PhoneNumber, PaymentCardNumber)
VALUES
    (CustomerID_Seq.NEXTVAL, 'Tom Holland', '789 N Lexington Ave', '12345', 'NY', 'tomh@gmail.com', '212-789-0123', '4716664625684956');
    
INSERT INTO Customers
    (CustomerID, Name, Address, Zipcode, State, Email, PhoneNumber, PaymentCardNumber)
VALUES
    (CustomerID_Seq.NEXTVAL, 'Chris Evans', '234 Cambridge St', '67890', 'CA', 'chrise@gmail.com', '310-123-4567', '4024007158834407');
    
INSERT INTO Customers
    (CustomerID, Name, Address, Zipcode, State, Email, PhoneNumber, PaymentCardNumber)
VALUES
    (CustomerID_Seq.NEXTVAL, 'Robert Downey', '567 E Pratt St', '21209', 'MD', 'robertd@gmail.com', '410-890-1234', '4916812562308034');

-- Create ParkingZones table:
CREATE TABLE ParkingZones (
    ZoneID NUMBER NOT NULL, -- Unique identifier for each parking zone
    Address VARCHAR2(255), -- Adress of the parking zone
    Zipcode VARCHAR2(10), -- Parking zone ZipCode
    Capacity NUMBER, -- Number of parking spots
    AvailableSpots NUMBER, -- Number of spots currently available
    HourlyRate NUMBER(5,2), -- Cost per house for parking
    MaxParkingLength INTERVAL DAY(0) TO SECOND, -- Maximum time duration allowed for parking
    StartDay NUMBER(1), -- Starting day of operation (e.g., Monday is 1)
    StartTime INTERVAL DAY(0) TO SECOND, -- Time when the parking zone opens
    EndDay NUMBER(1), -- Ending day 
    EndTime INTERVAL DAY(0) TO SECOND, -- Time when the parkig zone closed
    PRIMARY KEY (ZoneID) -- Primary key of the table
);

-- Inserting data into the ParkingZones table:
INSERT INTO ParkingZones
	(ZoneID, Address, Zipcode, Capacity, AvailableSpots, HourlyRate, MaxParkingLength, StartDay, StartTime, EndDay, EndTime)
Values
	(ZoneID_Seq.NEXTVAL, '14567 Poplar Ave', 21250, 200, 143, 1.5, INTERVAL '3' HOUR, 1, INTERVAL '07:00' HOUR TO MINUTE, 2, INTERVAL '19:00' HOUR TO MINUTE); 

INSERT INTO ParkingZones
	(ZoneID, Address, Zipcode, Capacity, AvailableSpots, HourlyRate, MaxParkingLength, StartDay, StartTime, EndDay, EndTime)
Values
	(ZoneID_Seq.NEXTVAL, '16035 Walker Ave', 21252, 250, 203, 1.25, INTERVAL '2' HOUR, 2, INTERVAL '06:00' HOUR TO MINUTE, 3, INTERVAL '10:00' HOUR TO MINUTE); 

INSERT INTO ParkingZones
	(ZoneID, Address, Zipcode, Capacity, AvailableSpots, HourlyRate, MaxParkingLength, StartDay, StartTime, EndDay, EndTime)
Values
	(ZoneID_Seq.NEXTVAL, '90456 Retriever Ln', 21345, 100, 23, 3.5, INTERVAL '2' HOUR, 1, INTERVAL '08:00' HOUR TO MINUTE, 2, INTERVAL '21:00' HOUR TO MINUTE); 

INSERT INTO ParkingZones
	(ZoneID, Address, Zipcode, Capacity, AvailableSpots, HourlyRate, MaxParkingLength, StartDay, StartTime, EndDay, EndTime)
Values
	(ZoneID_Seq.NEXTVAL, '45281 Fredrick Rd', 67824, 150, 46, 2.05, INTERVAL '3' HOUR, 2, INTERVAL '07:00' HOUR TO MINUTE, 3, INTERVAL '19:00' HOUR TO MINUTE); 

INSERT INTO ParkingZones
	(ZoneID, Address, Zipcode, Capacity, AvailableSpots, HourlyRate, MaxParkingLength, StartDay, StartTime, EndDay, EndTime)
Values
	(ZoneID_Seq.NEXTVAL, '91048 Vortex Rd', 45223, 50, 6, 1.5, INTERVAL '1' HOUR, 3, INTERVAL '07:00' HOUR TO MINUTE, 4, INTERVAL '20:00' HOUR TO MINUTE); 

-- Create Vehicles table:
CREATE TABLE Vehicles (
    VehicleID NUMBER NOT NULL, -- Unique identifier for each vehicle
    CustomerID NUMBER NOT NULL, -- Vehicle associated with customer
    LicensePlate VARCHAR2(15) NOT NULL, -- Vehicle Lincense Plate
    State VARCHAR2(50), -- State of the vehicle registration 
    Maker VARCHAR2(100), -- Vehicle maker
    Model VARCHAR2(100), -- Vehicle Model
    YearMade NUMBER(4), -- What year vehicle was made
    Color VARCHAR2(50), -- Color of the vehicle
    PRIMARY KEY (VehicleID), -- Primary Key of the table
    FOREIGN KEY (CustomerID) -- Reference to the Customers table
    	REFERENCES Customers(CustomerID)
);

-- Inserting data into the Vehicles table:
-- Vehicle by Jeremy Renner
INSERT INTO Vehicles 
	(VehicleID, CustomerID, LicensePlate, State, Maker, Model, YearMade, Color)
VALUES
	(VehicleID_Seq.NEXTVAL, 1, 'XYZ456', 'NY', 'Tesla', 'Model 3', 2022, 'Black');

-- Vehicle Elizabeth Olsen
INSERT INTO Vehicles 
	(VehicleID, CustomerID, LicensePlate, State, Maker, Model, YearMade, Color)
VALUES
	(VehicleID_Seq.NEXTVAL, 2, 'DEF789', 'AL', 'VW', 'ID.4', 2023, 'Red');

-- Vehicle owned by Tom Holland
INSERT INTO Vehicles 
	(VehicleID, CustomerID, LicensePlate, State, Maker, Model, YearMade, Color)
VALUES
	(VehicleID_Seq.NEXTVAL, 3, 'MNO123', 'NY', 'Toyota', 'RAV4', 2012, 'Blue');

-- Vehicle owned by Chris Evans
INSERT INTO Vehicles 
	(VehicleID, CustomerID, LicensePlate, State, Maker, Model, YearMade, Color)
VALUES
	(VehicleID_Seq.NEXTVAL, 4, 'GHI567', 'CA', 'Honda', 'CRV', 2017, 'White');

-- Vehicle owned by Robert Downey
INSERT INTO Vehicles 
	(VehicleID, CustomerID, LicensePlate, State, Maker, Model, YearMade, Color)
VALUES
	(VehicleID_Seq.NEXTVAL, 5, 'QRS890', 'MD', 'BMW', 'X7', 2020, 'Silver');

-- Create ParkingSessions table:
CREATE TABLE ParkingSessions (
    SessionID NUMBER NOT NULL, -- Unique identifier for each parking session
    CustomerID NUMBER NOT NULL, -- Customer identifer who is starting a session
    VehicleID NUMBER NOT NULL, -- Customer's vehicle identifier
    ZoneID NUMBER NOT NULL, -- Identifer of where customer parked
    StartTime TIMESTAMP, -- Start time of the parking session
    EstimatedEndTime TIMESTAMP, -- Estimated end time of the parking session
    TotalCharge NUMBER(7,2), -- Total charge during the parking session
    PRIMARY KEY (SessionID), -- Primary key of the table
    FOREIGN KEY (CustomerID) -- Reference to the Customers table
    	REFERENCES Customers(CustomerID),
    FOREIGN KEY (VehicleID) -- Reference to the Vehicle table
    	REFERENCES Vehicles(VehicleID), 
    FOREIGN KEY (ZoneID) -- Reference to the ParkingZone table
    	REFERENCES ParkingZones(ZoneID)
);

-- Inserting data into the ParkingSessions table:
-- Parking Session initiated by Jeremy Renner for his Tesla at 14567 Poplar Ave
INSERT INTO ParkingSessions 
    (SessionID, CustomerID, VehicleID, ZoneID, StartTime, EstimatedEndTime, TotalCharge) 
VALUES 
    (SessionID_Seq.NEXTVAL, 1, 1, 1, TIMESTAMP '2023-10-17 09:00:00', TIMESTAMP '2023-10-17 11:00:00', 3); 

-- Parking Session initiated by Elizabeth Olsen for her VW at 16035 Walker Ave
INSERT INTO ParkingSessions 
    (SessionID, CustomerID, VehicleID, ZoneID, StartTime, EstimatedEndTime, TotalCharge) 
VALUES 
    (SessionID_Seq.NEXTVAL, 2, 2, 2, TIMESTAMP '2023-10-17 08:00:00', TIMESTAMP '2023-10-17 09:00:00', 1.25);

-- Parking Session initiated by Tom Holland for his Toyota at 90456 Retriever Ln
INSERT INTO ParkingSessions 
    (SessionID, CustomerID, VehicleID, ZoneID, StartTime, EstimatedEndTime, TotalCharge) 
VALUES 
    (SessionID_Seq.NEXTVAL, 3, 3, 3, TIMESTAMP '2023-10-17 10:00:00', TIMESTAMP '2023-10-17 13:00:00', 10.5);

-- Parking Session initiated by Chris Evans for his Honda at 45281 Fredrick Rd
INSERT INTO ParkingSessions 
    (SessionID, CustomerID, VehicleID, ZoneID, StartTime, EstimatedEndTime, TotalCharge) 
VALUES 
    (SessionID_Seq.NEXTVAL, 4, 4, 4, TIMESTAMP '2023-10-17 11:00:00', TIMESTAMP '2023-10-17 12:00:00', 2.05); 

-- Parking Session initiated by Robert Downey for his BMW at 91048 Vortex Rd
INSERT INTO ParkingSessions 
    (SessionID, CustomerID, VehicleID, ZoneID, StartTime, EstimatedEndTime, TotalCharge) 
VALUES 
    (SessionID_Seq.NEXTVAL, 5, 5, 5, TIMESTAMP '2023-10-17 12:00:00', TIMESTAMP '2023-10-17 15:00:00', 4.5);

-- Insert Same customer, different time, to test multiple session
INSERT INTO ParkingSessions 
    (SessionID, CustomerID, VehicleID, ZoneID, StartTime, EstimatedEndTime, TotalCharge) 
VALUES 
    (SessionID_Seq.NEXTVAL, 3, 3, 3, TIMESTAMP '2023-10-17 11:00:00', TIMESTAMP '2023-10-17 16:00:00', 10.5);

-- Insert to check multiple session about to expire for procedure 9
INSERT INTO ParkingSessions 
    (SessionID, CustomerID, VehicleID, ZoneID, StartTime, EstimatedEndTime, TotalCharge) 
VALUES 
    (SessionID_Seq.NEXTVAL, 1, 1, 1, TIMESTAMP '2023-10-17 09:00:00', TIMESTAMP '2023-10-17 11:00:00', 3); 

-- Create Payments table:
CREATE TABLE Payments (
    PaymentID NUMBER NOT NULL, -- Unique identifier for each payment
    SessionID NUMBER NOT NULL, -- Payment for associated session
    PaymentTime TIMESTAMP, -- Time when the payment was made
    PaymentAmount NUMBER(7,2), -- Payment amount
    HoursCovered NUMBER, -- Number of hours payment covered
    PRIMARY KEY (PaymentID), -- Parimary key of the table
    FOREIGN KEY (SessionID) -- Reference to the ParkingSessions table
    	REFERENCES ParkingSessions(SessionID)
);

-- Inserting data into the Payments table
-- Payment made by Jeremy Renner for his parking session at 14567 Poplar Ave
INSERT INTO Payments 
    (PaymentID, SessionID, PaymentTime, PaymentAmount, HoursCovered) 
VALUES 
    (PaymentID_Seq.NEXTVAL, 1, TIMESTAMP '2023-10-17 10:30:00', 3, 2);

-- Payment made by Elizabeth Olsen for her parking session at 16035 Walker Ave
INSERT INTO Payments 
    (PaymentID, SessionID, PaymentTime, PaymentAmount, HoursCovered) 
VALUES 
    (PaymentID_Seq.NEXTVAL, 2, TIMESTAMP '2023-10-17 09:45:00', 1.25, 1);

-- Payment made by Tom Holland for his parking session at 90456 Retriever Ln
INSERT INTO Payments 
    (PaymentID, SessionID, PaymentTime, PaymentAmount, HoursCovered) 
VALUES 
    (PaymentID_Seq.NEXTVAL, 3, TIMESTAMP '2023-10-17 12:30:00', 10.5, 3);

-- Payment made by Chris Evans for his parking session at 45281 Fredrick Rd
INSERT INTO Payments 
    (PaymentID, SessionID, PaymentTime, PaymentAmount, HoursCovered) 
VALUES 
    (PaymentID_Seq.NEXTVAL, 4, TIMESTAMP '2023-10-17 12:00:00', 2.05, 1);

-- Payment made by Robert Downey for his parking session at 91048 Vortex Rd
INSERT INTO Payments 
    (PaymentID, SessionID, PaymentTime, PaymentAmount, HoursCovered) 
VALUES 
    (PaymentID_Seq.NEXTVAL, 5, TIMESTAMP '2023-10-17 15:00:00', 4.5, 3);

-- Create Messages table:
CREATE TABLE Messages (
    MessageID NUMBER NOT NULL, -- Unique identifier for each message
    CustomerID NUMBER NOT NULL, -- Customer who is receiving the message
    MessageTime TIMESTAMP, -- Time when the message was sent
    MessageBody VARCHAR2(1000), -- What the message was
    PRIMARY KEY (MessageID), -- Primary Key of the table
    FOREIGN KEY (CustomerID) -- Reference to the Customers table
    	REFERENCES Customers(CustomerID)
);
-- Inserting data into the Messages table
-- 1. Confirmation of a parking session for Jeremy Renner at "14567 Poplar Ave"
INSERT INTO Messages 
    (MessageID, CustomerID, MessageTime, MessageBody) 
VALUES 
    (MessageID_Seq.NEXTVAL, 1, TIMESTAMP '2023-10-17 09:01:00', 'Your parking session at 14567 Poplar Ave has started. Thank you for using our service!');

-- 2. Confirmation of a parking session for Elizabeth Olsen at "16035 Walker Ave"
INSERT INTO Messages 
    (MessageID, CustomerID, MessageTime, MessageBody) 
VALUES 
    (MessageID_Seq.NEXTVAL, 2, TIMESTAMP '2023-10-17 08:01:00', 'Your parking session at 16035 Walker Ave has started. Thank you for using our service!');

-- 3. Reminder for Tom Holland about their parking session nearing its end at "90456 Retriever Ln"
INSERT INTO Messages 
    (MessageID, CustomerID, MessageTime, MessageBody) 
VALUES 
    (MessageID_Seq.NEXTVAL, 3, TIMESTAMP '2023-10-17 12:45:00', 'Reminder: Your parking session at 90456 Retriever Ln is nearing its end. Extend now if needed.');

-- 4. Feedback request for Chris Evans
INSERT INTO Messages 
    (MessageID, CustomerID, MessageTime, MessageBody) 
VALUES 
    (MessageID_Seq.NEXTVAL, 4, TIMESTAMP '2023-10-17 17:00:00', 'Please rate your parking experience with us. Your feedback matters!');

-- 5. Reminder for Robert Downey about their parking session nearing its end at "91048 Vortex Rd"
INSERT INTO Messages 
    (MessageID, CustomerID, MessageTime, MessageBody) 
VALUES 
    (MessageID_Seq.NEXTVAL, 5, TIMESTAMP '2023-10-17 11:45:00', 'Reminder: Your parking session at 91048 Vortex Rd is nearing its end. Extend now if needed.');

COMMIT;
-- Check to make sure everything is inserted
SELECT * FROM Customers;
SELECT * FROM ParkingZones;
SELECT * FROM Vehicles;
SELECT * FROM Payments;
SELECT * FROM Messages;
SELECT * FROM ParkingSessions;

-- Features Start Here

SET SERVEROUTPUT ON;

-- Individual Feature 1: Andrew Stine
create or replace procedure customer_checker(
   v_name varchar,
   v_address varchar,
   v_zipcode varchar,
   v_state varchar,
   v_email varchar,
   v_phonenum varchar,
   v_cardnum varchar
)
is v_count number;

begin
    
    dbms_output.put_line('_______Feature 1: Andrew Stine___________');
   select count(*) into v_count from Customers where Customers.PhoneNumber = v_phonenum;


   if v_count = 0 then
      
       insert into Customers (CustomerID, Name, Address, Zipcode, State, Email, PhoneNumber, PaymentCardNumber)
       values (CustomerID_Seq.NextVal, v_name, v_address, v_zipcode, v_state, v_email, v_phonenum, v_cardnum);
       dbms_output.put_line('No Account Associated with this Number, Account has been Created with Customer ID of  '|| CustomerID_seq.currval);
   else update Customers set
       address = v_address,
       state = v_state,
       zipcode = v_zipcode,
       email = v_email,
       PaymentCardNumber = v_cardnum
       where PhoneNumber = v_phonenum;
       dbms_output.put_line('User Already Exists, Information has been updated!');
   end if;
end;
/

-- End Create Procedure: customer_checker

-- Individual Feature 1: Andrew Stine
-- Check Customers table before calling procedure
SELECT * FROM Customers;

exec customer_checker('Andrew Stine', '1257 Address', '12345', 'AK', 'as@gmail.com', '1038571057', '1234432156788675');

-- Check customer table after calling procedure

--special case, if account with phone number exists, address and other attributes will be updated
exec customer_checker('Andrew Stine', '3428 Retriver Ln', '77342', 'AK', 'as@gmail.com', '1038571057', '6749109312340945');

SELECT * FROM Customers;

-- End Procedure Test: customer_checker

SET SERVEROUTPUT ON;
-- Individual Feature 2: Arseniy Vasylchenko
-- Create a procedure for adding a vehicle
CREATE OR REPLACE PROCEDURE AddVehicle(
    p_license_plate VARCHAR2,
    p_state VARCHAR2,
    p_customer_id NUMBER,
    p_maker VARCHAR2,
    p_model VARCHAR2,
    p_year NUMBER,
    p_color VARCHAR2
)
IS
    v_vehicle_id NUMBER;
    v_customer_exists NUMBER;
    v_vehicle_exists NUMBER;
BEGIN
    dbms_output.put_line('_______Feature 2: Arseniy Vasylchenko___________');

    -- Check if the customer ID exists
    SELECT COUNT(*) INTO v_customer_exists FROM Customers WHERE CustomerID = p_customer_id;

    IF v_customer_exists = 0 THEN
        DBMS_OUTPUT.PUT_LINE('Invalid customer ID');
        RETURN;
    END IF;

    -- Check if the vehicle already exists
    SELECT COUNT(*) INTO v_vehicle_exists FROM Vehicles WHERE LicensePlate = p_license_plate AND State = p_state;

    IF v_vehicle_exists > 0 THEN
        DBMS_OUTPUT.PUT_LINE('Vehicle already exists');
        RETURN;
    END IF;

    -- Insert new vehicle
    INSERT INTO Vehicles (VehicleID, CustomerID, LicensePlate, State, Maker, Model, YearMade, Color)
    VALUES (VehicleID_Seq.NEXTVAL, p_customer_id, p_license_plate, p_state, p_maker, p_model, p_year, p_color)
    RETURNING VehicleID INTO v_vehicle_id;

    -- Print the new vehicle ID
    DBMS_OUTPUT.PUT_LINE('New Vehicle ID: ' || v_vehicle_id);
END AddVehicle;
/

-- End Create procedure: AddVehicle

-- Individual Feature 2: Arseniy Vasylchenko
-- Check Vehicle table before calling procedure
SELECT * FROM Vehicles;

BEGIN
    AddVehicle('ABC123', 'NY', 1, 'Ford', 'Focus', 2021, 'Green');
END;
/

-- Special Case: Vehicle Already Exist
BEGIN
    AddVehicle('ABC123', 'NY', 1, 'Ford', 'Focus', 2021, 'Green');
END;
/
-- Check Vehicle table after calling procedure
SELECT * FROM Vehicles;

-- End procedure Test: AddVehicle

-- Individual Feature 3: Ameed Saikh
set serveroutput on;
CREATE OR REPLACE PROCEDURE SearchParkingZone(
    pZipCode IN VARCHAR2,
    pCurrentTime IN TIMESTAMP,
    pIntendedLength IN NUMBER
)
IS
    -- Create a cursor for fetching parking zones
    CURSOR ParkingZoneCursor IS
        SELECT
            pz.ZoneID,
            pz.Address,
            pz.AvailableSpots,
            pz.HourlyRate,
            pz.MaxParkingLength,
            pz.StartDay,
            pz.EndDay,
            pz.StartTime,
            pz.EndTime
        FROM ParkingZones pz
        WHERE
            pz.Zipcode = pZipCode
            AND TO_NUMBER(TO_CHAR(pCurrentTime, 'D')) BETWEEN pz.StartDay AND pz.EndDay
            AND TO_NUMBER(TO_CHAR(pCurrentTime, 'HH24')) BETWEEN EXTRACT(HOUR FROM pz.StartTime) AND EXTRACT(HOUR FROM pz.EndTime)
            AND pz.MaxParkingLength >= INTERVAL '1' HOUR * pIntendedLength;
    vAvailableZonesCount int := 0;
    zone_count int;

BEGIN
        dbms_output.put_line('_______Feature 3: Ameed Saikh___________');
        SELECT COUNT(*) into zone_count from ParkingZones Where ZipCode = pZipCode;
        
        
        if zone_count = 0 then
            DBMS_OUTPUT.PUT_LINE('Invalid ZipCode');
            return;
        end if;
        
        if pIntendedLength > 3 then
            DBMS_OUTPUT.PUT_LINE('You cannot park more than 3 hours');
            return;
        end if;
            
        
        -- List available parking zones
        DBMS_OUTPUT.PUT_LINE('Available Parking Zones:');
        DBMS_OUTPUT.PUT_LINE('------------------------');
        FOR zone IN ParkingZoneCursor 
        LOOP
            DBMS_OUTPUT.PUT_LINE(
                'Zone ID: ' || zone.ZoneID ||
                ', Address: ' || zone.Address ||
                ', Available Spots: ' || zone.AvailableSpots ||
                ', Hourly Rate: $' || zone.HourlyRate ||
                ', Max Parking Length: ' || zone.MaxParkingLength ||
                ', Effective Period: ' || 
                'Start Day: ' || zone.StartDay || 
                ', End Day: ' || zone.EndDay || 
                ', Start Time: ' || TO_CHAR(zone.StartTime, 'HH24:MI') || 
                ', End Time: ' || TO_CHAR(zone.EndTime, 'HH24:MI')
            );
                    vAvailableZonesCount := vAvailableZonesCount + 1;

        END LOOP;
    
        if vAvailableZonesCount = 0 then
        -- No available parking zones message
            DBMS_OUTPUT.PUT_LINE('No available parking zones in the specified area.');
    end if;

END SearchParkingZone;
/
-- End Create procedure: SearchParkingZone

-- Individual Feature 3: Ameed Saikh
SELECT * FROM ParkingZones;

EXEC SearchParkingZone('21250', TIMESTAMP '2023-10-16 09:00:00', 2);

-- Special Case: invalid zip code
EXEC SearchParkingZone('21227', TIMESTAMP '2023-10-16 09:00:00', 2);

-- Special Case: invalid length
EXEC SearchParkingZone('21250', TIMESTAMP '2023-10-16 09:00:00', 5);
-- End procedure Test: SearchParkingZone

-- Individual Feature : 4 Nishan Subba
-- IS448 Feature 4 - List all parking sessions in a period for a customer.
/*
Member 4:
Feature 4: list all parking sessions in a period for a customer. Input is 
customer ID, astart date and an end date. It does the following:
Input: Customer ID, Start Date, and End Date

1) This feature first checks whether the customer ID is valid 
(whether there is acustomer with that ID). If not it prints out an error message 'No such customer').

2) If the customer exists, this feature prints out all parking sessions of 
the customerwithin the start and end date, and print out each parking session's 
session id, startand end time, zone id, vehicle ID, and total charge.

3) Finally print out a total charge of all these parking sessions.
*/

SET SERVEROUTPUT ON;

-- Procedure Code Start Here
CREATE OR REPLACE PROCEDURE List_all_sessions (e_customerID IN INT, 
e_startDate IN DATE, 
e_endDate IN DATE)
IS
-- Create a cursor to fetch parking session details
CURSOR c1 IS 
SELECT ps.SessionID, ps.StartTime, ps.EstimatedEndTime, ps.ZoneID, 
ps.VehicleID, ps.TotalCharge 
FROM ParkingSessions ps
WHERE ps.CustomerID = e_customerID
-- Make sure given session date is within customer's session date
AND ps.StartTime >= e_startDate
AND ps.EstimatedEndTime <= e_endDate;

-- Variables to store the fetched data from the cursor.
v_SessionID ParkingSessions.SessionID%type;
v_StartTime ParkingSessions.StartTime%type;
v_EstimatedEndTime ParkingSessions.EstimatedEndTime%type;
v_ZoneID ParkingSessions.ZoneID%type;
v_VehicleID ParkingSessions.VehicleID%type;
v_Charge ParkingSessions.TotalCharge%type;

-- Variables to count the number of customers and sessions.
v_customerID_Counter NUMBER;
v_sessionTime_count NUMBER;

-- Variable to store all sessions total charge
v_totalCharge NUMBER := 0;

BEGIN -- Begin procedure

    DBMS_OUTPUT.PUT_LINE('_______Feature 4: Nishan Subba___________');

    -- Check if the customer exists in the Customers table.
    SELECT COUNT(*) INTO v_customerID_Counter
    FROM Customers c
    WHERE c.CustomerID = e_customerID;
    
    -- Count the number of sessions for the customer within the date range.
    SELECT COUNT(*) INTO v_sessionTime_count 
    FROM ParkingSessions ps
    WHERE ps.CustomerID = e_customerID
    AND ps.StartTime >= e_startDate
    AND ps.EstimatedEndTime <= e_endDate;
    
    -- Checking for Special Cases
    -- If customer does not exist, show special message
    IF v_customerID_Counter = 0 THEN
        DBMS_OUTPUT.PUT_LINE('No such customer exist.');
    -- If start date is after end date, show special message
    ELSIF e_startDate > e_endDate THEN
        DBMS_OUTPUT.PUT_LINE('Invalid Session start date, start date is after end date.');
    -- If start date is exactly same as end date, show special message since its zero length
    ELSIF e_startDate = e_endDate THEN
        DBMS_OUTPUT.PUT_LINE('Invalid Time, you cannot have same start and end time');
    -- If session does not exist for that customer, show special message
    ELSIF v_sessionTime_count = 0 THEN
        DBMS_OUTPUT.PUT_LINE('No such session exists for customer ' ||e_customerID || ' in given date.');
    ELSE -- If all special cases are checked, move to getting sessions details
        OPEN c1; -- Open cursor
        DBMS_OUTPUT.PUT_LINE('-----------Session Details-----------:');
        --DBMS_OUTPUT.PUT_LINE('------------------------');
        LOOP -- Start looping
            -- Fetch data into variables
            FETCH c1 INTO v_SessionID, v_StartTime, v_EstimatedEndTime, v_ZoneID, 
            v_VehicleID, v_Charge;
            EXIT WHEN c1%NOTFOUND; -- Exit once data is not found
            -- Show all sessions details
            DBMS_OUTPUT.PUT_LINE(CHR(10) || 'Session ID: ' || v_SessionID || CHR(10) || 'Start Time: ' 
            || v_StartTime || CHR(10) || 'End Time: ' || v_EstimatedEndTime || CHR(10) || 'ZoneID: ' 
            || v_ZoneID || CHR(10) ||'VehicleID: ' || v_VehicleID || CHR(10) || 'Charge: $' 
            || v_Charge);
            -- Add each sessions charge with total charge
            v_totalCharge := v_totalCharge + v_Charge;
        END LOOP; -- End loop
            -- Show total charge for all sessions
            DBMS_OUTPUT.PUT_LINE('Total Sessions Charge: $' || v_totalCharge);
        CLOSE c1; -- Close cursor
    END IF; -- End if statement
END; -- End procedure
/

-- End Create Procedure: List_all_sessions

-- Individual Feature : 4 Nishan Subba
-- Procedure: List_all_sessions:
-- Description:
-- The purpose of this procedure is to print all sessions details for specific customers
-- Input: Customer ID, Start Date, and End Date in Timestamp format
-- Output/Display: Customer's Session ID, Start Time, End Time, Zone ID, 
-- Vehicle ID, and session's Charge
-- Finally, calculate and show all total session's charge

-- Logic Flow:
-- 1. Validates the existence of the customer by checking the Customers table. 
--    If the customer does not exist, it outputs an error message.
-- 2. Checks if the start date is later than the end date, 
--    which is considered an invalid input. If so, it outputs an appropriate error message.
-- 3. Checks if the start date is equal to the end date, 
--    which is also invalid since it implies a zero-length time range.
-- 4. Counts the number of parking sessions for the customer within the specified date range.
-- 5. If valid sessions exist, the procedure opens a cursor to fetch and list details of each session
-- 6. Calculates the total charge for all listed sessions and displays it after listing individual session details.

-- Show whats in the table before calling procedure
SELECT * FROM ParkingSessions;

-- Call procedure
-- Test Cases

-- Regular Test Cases
-- Description: Retrieves parking sessions for customer IDs 1 to 5 for the entire day of October 17, 2023.
-- Expected Output: Lists all sessions for each customer on October 17, 2023, and displays the total charge.
EXEC List_all_sessions(1, DATE '2023-10-17',DATE '2023-10-18');
EXEC List_all_sessions(2, DATE '2023-10-17', DATE '2023-10-18');
EXEC List_all_sessions(3, DATE '2023-10-17', DATE '2023-10-18');
EXEC List_all_sessions(4, DATE '2023-10-17', DATE '2023-10-18');
EXEC List_all_sessions(5, DATE '2023-10-17', DATE '2023-10-18');

-- Special Tests
-- Special Test Case: Wrong Customer ID
-- Description: Get sessions details for a non-existent customer ID 8.
-- Expected Output: Outputs "No such customer exist." indicating the customer ID is invalid.
SELECT * FROM ParkingSessions;

EXEC List_all_sessions(99, DATE '2023-10-17', DATE '2023-10-18');

-- Special Test Case: Wrong Session Time (Does Not Exist)
-- Description: Get sessions details for customer ID 1 for a period where sessions does exist.
-- Expected Output: If no sessions are found, outputs "No such session exists for customer 1 in given date."
SELECT * FROM ParkingSessions;

EXEC List_all_sessions(1, DATE '2023-10-18', DATE '2023-10-19');

-- Special Test Case: Same Session Time
-- Description: Tests the procedure with identical start and end timestamps.
-- Expected Output: Outputs "Invalid Time, you cannot have same start and end time" due to zero-length time range.
SELECT * FROM ParkingSessions;

EXEC List_all_sessions(1, DATE '2023-10-17', DATE '2023-10-17');

-- Special Test Case: Start Time Greater Than End Time
-- Description: Tests the procedure with start time being later than end time, an invalid input.
-- Expected Output: Outputs "Invalid Session start date, start date is after end date."
SELECT * FROM ParkingSessions;

EXEC List_all_sessions(1, DATE '2023-10-18', DATE '2023-10-17');

-- End Procedure Test: List_all_sessions

-- Individual Feature : 5 Ansh Shah
SET SERVEROUTPUT ON;

-- Create or replace the procedure
CREATE OR REPLACE PROCEDURE ListVehiclesInZone(
    p_zone_id NUMBER,
    p_current_time TIMESTAMP
)
IS
    v_exists NUMBER;
BEGIN

    DBMS_OUTPUT.PUT_LINE('_______Feature 5: Ansh Shah___________');
    -- Step 1: Check if the zone ID is valid
    SELECT COUNT(*) INTO v_exists FROM ParkingZones WHERE ZoneID = p_zone_id;

    IF v_exists = 0 THEN
        DBMS_OUTPUT.PUT_LINE('Incorrect zone ID');
        RETURN;
    ELSE
        DBMS_OUTPUT.PUT_LINE('Zone ID is valid');
    END IF;

    -- Step 2: List all vehicles with an active parking session in the specified zone
    FOR v_vehicle IN (
        SELECT
            V.VehicleID,
            V.CustomerID,
            V.LicensePlate,
            V.State,
            V.Maker,
            V.Model,
            V.Color
        FROM
            ParkingSessions PS
            JOIN Vehicles V ON PS.VehicleID = V.VehicleID
        WHERE
            PS.ZoneID = p_zone_id
            AND p_current_time BETWEEN PS.StartTime AND PS.EstimatedEndTime
    )
    LOOP
        DBMS_OUTPUT.PUT_LINE('Vehicle ID: ' || v_vehicle.VehicleID ||
                             ', Customer ID: ' || v_vehicle.CustomerID ||
                             ', License Plate: ' || v_vehicle.LicensePlate ||
                             ', State: ' || v_vehicle.State ||
                             ', Maker: ' || v_vehicle.Maker ||
                             ', Model: ' || v_vehicle.Model ||
                             ', Color: ' || v_vehicle.Color);
    END LOOP;

    -- Display a message in the SQL Worksheet
    DBMS_OUTPUT.PUT_LINE('Procedure executed successfully.');

END;
/

-- End Create procedure: ListVehiclesInZone

-- Individual Feature : 5 Ansh Shah
SELECT * FROM ParkingZones;
-- Call the procedure
EXECUTE ListVehiclesInZone(1, TIMESTAMP '2023-10-17 10:30:00');

-- Special Test Case
SELECT * FROM ParkingZones;

EXECUTE ListVehiclesInZone(-1, TIMESTAMP '2023-10-17 10:30:00');

-- End procedure Test: ListVehiclesInZone

-- Group Feature 6
CREATE OR REPLACE PROCEDURE startparkingsession(
v_cid number,
v_vid number,
v_zid number,
v_starttime timestamp,
v_numhours number
) is
v_hourlyrate number;
v_parking_length interval day to second;
v_spots_available number;
v_estarttime INTERVAL DAY TO SECOND;
v_estendtime INTERVAL DAY TO SECOND;
v_totalcharge number := 0; -- set it to 0 at first
v_endtime timestamp;
v_s_hour int;
v_count_c int;
v_count_v int;
v_count_z int;
v_StartDay NUMBER;
v_EndDay NUMBER;
Begin
    DBMS_OUTPUT.PUT_LINE('_________Group Feature 6 ___________');
    
-- check if customer, vehicle and parking zone IDs are valid
    Select count(*) into v_count_c from customers where CustomerID = v_cid;
    Select count(*) into v_count_v from vehicles where VehicleID = v_vid;
    Select count(*) into v_count_z from parkingzones where ZoneID = v_zid;

    if v_count_c = 0 then
        dbms_output.put_line('No Such Customer ID');
        return;
        end if;
    
    if v_count_v = 0 then
        dbms_output.put_line('No Such Vehicle ID');
        return;
        end if;
    
    if v_count_z = 0 then
        dbms_output.put_line('No Such Zone ID');
        return;
        end if;
    
    select hourlyrate, maxparkinglength, availablespots, starttime, endtime, startday, endday
    into v_hourlyrate, v_parking_length, v_spots_available, v_estarttime, v_estendtime, v_StartDay, v_EndDay
    from parkingzones where ZoneID = v_zid;
    
     -- Check if there are available spots
       IF v_spots_available = 0 THEN
           DBMS_OUTPUT.PUT_LINE('Parking session is not possible due to no available spot.');
           RETURN;
       ELSIF v_starttime + NUMTODSINTERVAL(v_numhours, 'HOUR') > v_starttime + v_parking_length THEN
           DBMS_OUTPUT.PUT_LINE('Parking length exceeds maximal length.');
           RETURN;
       END IF;
    
    
       -- Check if start time is in operational day and hour
       v_s_hour := EXTRACT(HOUR FROM v_starttime);
       IF TO_NUMBER(TO_CHAR(v_starttime, 'D')) BETWEEN v_StartDay AND v_EndDay
          AND v_s_hour BETWEEN EXTRACT(HOUR FROM v_estarttime) AND EXTRACT(HOUR FROM v_estendtime) THEN
           v_totalcharge := v_totalcharge + (v_hourlyrate * v_numhours);
       ELSE
           DBMS_OUTPUT.PUT_LINE('Parking is free now!');
           RETURN;
       END IF;
       
       -- Set an end time
        v_endtime := v_starttime + NUMTODSINTERVAL(v_numhours, 'HOUR');
        
      insert into ParkingSessions (SessionID, CustomerID, VehicleID, ZoneID, StartTime, EstimatedEndTime, TotalCharge)
          values (SessionID_Seq.nextval, v_cid, v_vid, v_zid, v_starttime, v_endtime, v_totalcharge);
           dbms_output.put_line('Data inserted for parking sessions table');
    
      insert into messages (messageID, customerID, messagetime, messagebody)
          values (MessageID_Seq.nextval, v_cid, v_starttime, 'A new parking session with ID '|| SessionID_Seq.currval ||' has been created');
                  dbms_output.put_line('Data inserted for messages table');
     
        update parkingzones set availablespots = availablespots -1 where zoneid = v_zid;
        
          if v_totalcharge >0 then
        
              insert into payments (paymentid, sessionid, paymenttime, paymentamount, hourscovered)
                  values (PaymentID_Seq.nextval, SessionID_Seq.currval, v_starttime, v_totalcharge, v_numhours);
                       dbms_output.put_line('Data inserted for payments table');
        
          end if;
               exception when no_data_found then
                   dbms_output.put_line('No data found for the Entered IDs');
end;
/

-- regular case!!
exec STARTPARKINGSESSION(1, 1, 1, TIMESTAMP '2023-10-16 09:00:00', 2);

-- Check parking session table and you should new a new entry created
SELECT * FROM ParkingSessions;
-- Check message table and you should be able to see new message added 
-- message should say new session has been started
SELECT * FROM Messages;


-- Special Case: Invalid ID's
exec STARTPARKINGSESSION(53, 47, 47, TIMESTAMP '2023-10-16 09:00:00',2);
-- Check customer table and you should see there is no id with 53
SELECT * FROM Customers;

-- Special Case: Parking Length Exceeds Maximal Length
exec STARTPARKINGSESSION(1, 1, 1, TIMESTAMP '2023-10-16 09:00:00', 7);
-- Check parking zone table to see max parking length
SELECT * FROM ParkingZones;

--free parking
exec STARTPARKINGSESSION(2, 2, 2, TIMESTAMP '2023-10-16 05:00:00', 2);
-- Check parking zone table and you should see its within free zone limit
SELECT * FROM ParkingZones;
-- End procedure 6

-- Group Feature 7
-- The procedure does the following steps:
-- 1) it checks whether there is a parking_session with the input ID. If not, print a message 'Invalid session ID' and stop.
-- 2) it then checks whether the extended parking session length will exceed the maximal length of the parking zone. 
-- If so, print a message: 'Cannot extend the session becausemaximal length reached' and stop 
-- 3) it then checks whether current_time is before session's end_time. If not print a
-- message 'You can only extend a session before it expires.' and stop.
-- 4) if current time is before the session's end time, update the row in the parking sessionmatching the input session ID
-- 5) insert a message into message table
-- 6) insert a row into payment table
SET SERVEROUTPUT ON;

CREATE OR REPLACE PROCEDURE ExtendParkingSession(
  p_SessionID IN NUMBER,
  p_CurrentTime IN TIMESTAMP,
  p_ExtendHours IN NUMBER
) AS
  v_StartTime TIMESTAMP;
  v_EndTime TIMESTAMP;
  v_MaxParkingLength INTERVAL DAY(0) TO SECOND;
  v_HourlyRate NUMBER;
  v_CustomerID NUMBER;
  v_ExistingDuration INTERVAL DAY(0) TO SECOND;
  v_ExtendedDuration INTERVAL DAY(0) TO SECOND;
  v_PaymentAmount NUMBER;
BEGIN
    DBMS_OUTPUT.PUT_LINE('_________Group Feature 7 ___________');
    
  -- Step 1: Check if the parking session with the given ID exists
  BEGIN
    SELECT ps.StartTime, ps.EstimatedEndTime, HourlyRate, MaxParkingLength
    INTO v_StartTime, v_EndTime, v_HourlyRate, v_MaxParkingLength
    FROM ParkingSessions PS
    JOIN ParkingZones PZ ON PS.ZoneID = PZ.ZoneID
    WHERE SessionID = p_SessionID;
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      DBMS_OUTPUT.PUT_LINE('Invalid session ID');
      RETURN;
  END;

  -- Step 2: Check if current time is before session's end time
  IF p_CurrentTime >= v_EndTime THEN
    DBMS_OUTPUT.PUT_LINE('You can only extend a session before it expires.');
    RETURN;
  END IF;

  -- Step 3: Check if the extended length exceeds the maximum parking length
  v_ExistingDuration := v_EndTime - v_StartTime;
  v_ExtendedDuration := INTERVAL '0' HOUR + p_ExtendHours * INTERVAL '1' HOUR;

  IF v_ExistingDuration + v_ExtendedDuration > v_MaxParkingLength THEN
    DBMS_OUTPUT.PUT_LINE('Cannot extend the session because maximal length reached');
    RETURN;
  END IF;

  -- Step 4: Update the parking session
  BEGIN
    UPDATE ParkingSessions
    SET EstimatedEndTime = v_EndTime + v_ExtendedDuration,
        TotalCharge = TotalCharge + v_HourlyRate * p_ExtendHours
    WHERE SessionID = p_SessionID;
  EXCEPTION
    WHEN OTHERS THEN
      DBMS_OUTPUT.PUT_LINE('Failed to extend parking session');
      ROLLBACK;
      RETURN;
  END;

  -- Step 5: Insert a message into the Messages table
  SELECT CustomerID
  INTO v_CustomerID
  FROM ParkingSessions
  WHERE SessionID = p_SessionID;

  INSERT INTO Messages (MessageID, CustomerID, MessageTime, MessageBody)
  VALUES (MessageID_Seq.NEXTVAL, v_CustomerID, p_CurrentTime, 'Parking session ' || p_SessionID || ' extended to ' || (v_EndTime + v_ExtendedDuration));

  -- Step 6: Insert a row into the Payments table
  v_PaymentAmount := v_HourlyRate * p_ExtendHours;

  INSERT INTO Payments (PaymentID, SessionID, PaymentTime, PaymentAmount, HoursCovered)
  VALUES (PaymentID_Seq.NEXTVAL, p_SessionID, p_CurrentTime, v_PaymentAmount, p_ExtendHours);

  COMMIT;
  
  DBMS_OUTPUT.PUT_LINE('The session has been extended by ' || p_ExtendHours || ' hours.');
  
END;
/

-- Normal Case: Extend the parking session for session id 1
-- Check tables before any updates are made
select * from parkingsessions;
select * from messages;
select * from payments;
-- Successfully extend the parking session for Session 1
EXEC ExtendParkingSession(1, TIMESTAMP '2023-10-17 10:30:00', 1);

-- Check tables to see the updated parking sessions informaton
-- You should see end time for session id of 1 to change to 12 pm
select * from parkingsessions;
-- You should see new message added to the table saying end time has been updated for session id 1
select * from messages;
-- You should see a new payment record for session id of 1
select * from payments;

-- Special Cases
-- Special Case 1: Trying to extend session beyond max limit
-- Cannot extend the session because maximal length reached
EXEC ExtendParkingSession(2, TIMESTAMP '2023-10-17 08:30:00', 3);

-- Special Case 2: Trying to extend session after session has expired
-- You can only extend a session before it expires.
EXEC ExtendParkingSession(3, TIMESTAMP '2023-10-17 14:00:00', 1);

-- Special Case 1: Trying to extend session for session id that does not exist
-- Invalid session ID
EXEC ExtendParkingSession(999, TIMESTAMP '2023-10-17 10:30:00', 2);

-- End procedure 7: ExtendParkingSession

-- Group Feature 8
/*
Feature 8: stop a session. 

Input includes session ID and a current time.The procedure does the following:
1) it first checks whether the session ID is valid (there is a parking session with that ID).If not, print a message 'Invalid session ID' and stop.
2) it then checks whether the current time is after the end time of the session. If so,insert into message table a row w
--ith a new message ID, the customer ID for the customer associated with the session, current time, and message body saying 
--'SessionX expired. You may get a ticket.' where X is the session ID.
3) if current time is no later than the end time of the session, update the parking session row's end time to the current time and
-- insert into message table a row with a new message ID, the associated customer ID, current time, and message body'Session X ends at Y' where X is session ID, Y is time.

*/
-- Create Procedure
SET SERVEROUTPUT ON;

CREATE OR REPLACE PROCEDURE Stop_Session 
(v_SessionID IN INT, v_Current_Time IN TIMESTAMP)
IS
-- Declare variables
v_SessionID_Count NUMBER; -- To check if session id exist
v_CustomerID INT; -- Get a customer id
v_EstEndTime TIMESTAMP; -- To check with current time

BEGIN
    DBMS_OUTPUT.PUT_LINE('_______Group Feature 8___________');
    
    -- Check if session id exist
	SELECT COUNT(*) INTO v_SessionID_Count
    FROM ParkingSessions
    WHERE SessionID = v_SessionID;

    -- If session ID does not exist, show message and stop
    IF v_SessionID_Count = 0 THEN
	    DBMS_OUTPUT.PUT_LINE('Invalid Session ID');
    ELSE
        -- If exist, get customer id and their session end tim
        SELECT CustomerID, EstimatedEndTime INTO v_CustomerID, v_EstEndTime
        FROM ParkingSessions 
        WHERE SessionID = v_SessionID;
    
    -- Check if current time is after end tim
	IF v_Current_Time > v_EstEndTime THEN
	    -- If so, insert a message into message table
	    -- Say session has expired, please get ticket
		INSERT INTO Messages
			(MessageID, CustomerID, MessageTime, MessageBody )
		VALUES
		    (MessageID_Seq.NEXTVAL, v_CustomerID, v_Current_Time, 'Session ' || v_SessionID || ' expired. You may get a ticket.');
	
	-- Check If current time is before end time
	ELSIF v_Current_Time <= v_EstEndTime THEN
        -- If so, update the session end time to current time
        -- Where session id equals given session id
		UPDATE ParkingSessions
		SET  EstimatedEndTime = v_Current_Time
		WHERE SessionID = v_SessionID;
		
		-- Insert a message into a message table saying end time have been updated
		INSERT INTO Messages
			(MessageID, CustomerID, MessageTime, MessageBody )
		VALUES (MessageID_Seq.NEXTVAL, v_CustomerID, v_Current_Time, 'Session ' || v_SessionID || ' ends at ' || v_Current_Time);
    END IF; -- End if statement
    END IF; -- End if statement
END; -- End procedure
/

-- End of Procedure: Stop_Session

-- Group Feature 8 Test

-- Procedure: Stop_Session
-- Description: 
-- The purpose of this procedure is to stop a session if current time is before end time
-- Input: Session ID, Current Time
-- Output/Display: Message indicating session end time have been updated
-- And message is added to a message table

-- Logic Flow:
-- 1. Validate that session id exist, else end it
-- 2. Then, Check if current time is after end time
-- 3. If so, then add a message to message table saying session has expired, please get ticket
-- 4. If current time is before end time, update end time to current time
-- 5. Add a message saying end time have been updated

-- Check Tables before calling procedure
SELECT * FROM ParkingSessions;
SELECT * FROM Messages;

-- Special Test Case:
-- Special Test Case: Wrong Session ID
-- Expected Outcome: Say invalid Session ID
SELECT * FROM ParkingSessions;
EXEC stop_session (50, TIMESTAMP '2023-10-17 00:00:00');

-- Normal Test Cases: 
-- Normal Test Case: Session expired
-- Expected Outcome: Say your session has expired, please get a ticket
SELECT * FROM ParkingSessions;

EXEC stop_session (4, TIMESTAMP '2023-10-18 00:00:00');
SELECT * FROM Messages;


-- Normal Test Case: Update Session End time
-- Expected Outcome: Nothing to display, but puts a message on the message table
-- Message table should show that your session end time have been updated
SELECT * FROM ParkingSessions;

EXEC stop_session (2, TIMESTAMP '2023-10-17 08:30:00');

-- Check ParkingSession table to see updated time
SELECT * FROM ParkingSessions;

-- Check Message table after procedure to see changes
SELECT * FROM Messages;

-- End of Procedure: Stop_Session

/*
Feature 9: create a reminder for all sessions about to expire in 15 minutes. 
Input includes: a current time. It does the following:
1) The procedure goes over every session whose end time is between current time minus 15 minutes to 
current time, and insert a message to the message table with a newly generated message ID, 
the customer ID associated with the session, message time as current time, and message body as
'Session X will expire in Y minutes, please extend it if necessary.'.
Here X is session ID. Y is the number of minutes between the current time and end timeof the session.
2) The procedure also prints a message saying 'Message generated for session X'where X is session ID.
Hint: the number of minutes between the current time and end time of the session can be computed as
EXTRACT(HOUR FROM x) * 60 + EXTRACT(MINUTE FROM x)where x=end time of session - current time.
*/

-- Create procedure
SET SERVEROUTPUT ON;

CREATE OR REPLACE PROCEDURE Session_Reminder
(v_Current_Time IN TIMESTAMP)
IS
-- Create a cursor to get session id and end time
CURSOR C1 IS SELECT SessionID, EstimatedEndTime
FROM ParkingSessions
-- Only get session where end time is between current time and 15 before endtime
WHERE EstimatedEndTime <=v_Current_Time + INTERVAL '15' MINUTE
AND EstimatedEndTime >= v_Current_Time;

-- Declare variables
v_Session_Record C1%ROWTYPE; -- Variable to store row type from cursor
v_SessionID INT; -- to store session id
v_EstEndTime TIMESTAMP; --  to store end time
v_TimeDiff INTERVAL DAY TO SECOND; -- variable to store time difference between end time and current time
v_MinutesRemain NUMBER; -- To store how many minutes is remaining
v_CustomerID INT; -- to store customer id
v_Session_Count INT := 0; -- to check if there is no session about to expire
BEGIN
    DBMS_OUTPUT.PUT_LINE('_______Group Feature 9___________');
    -- Begin procedure
    OPEN C1; -- open loop
    LOOP -- loop through the session
	    FETCH C1 INTO v_Session_Record; -- fetch the record into a row type 
	    EXIT WHEN C1%NOTFOUND; -- exit condition 
	    
        v_SessionID  := v_Session_Record.sessionid; -- Store each session id from the loop
        v_EstEndTime := v_Session_Record.EstimatedEndTime; -- store each session's end time from the loop
	
        SELECT CustomerID INTO v_CustomerID -- get the customer id
        FROM parkingsessions
        WHERE SessionID = v_SessionID; -- only customer id who have session

        v_TimeDiff := v_EstEndTime - v_current_time; -- calculate time difference from end time and current time
        -- Calculate how time remainging
        v_MinutesRemain := EXTRACT(HOUR FROM v_TimeDiff) * 60 + EXTRACT(MINUTE FROM v_TimeDiff);
        
        -- Insert a message into message table
        -- Where session is about to expire 
        INSERT INTO Messages
            (messageID, customerid, messagetime, messagebody )
	    VALUES
	        (MessageID_Seq.NEXTVAL, v_CustomerID, v_Current_Time, 'Session ' ||v_SessionID|| ' will expire in ' ||v_MinutesRemain || ' minutes, please extend it if necessary.');
	        
	    -- Tell message is created
        DBMS_OUTPUT.PUT_LINE('Message generated for session ' ||v_SessionID );
        -- Increment count per message generated
        v_Session_Count := v_Session_Count +1;
        
	END LOOP; -- end lop
    CLOSE C1; -- close the cursor
    -- Check if any message was generated
    -- If not, say no session is about to expire
    IF v_Session_Count = 0 THEN
	    DBMS_OUTPUT.PUT_LINE('No session about to expire');
    END IF; -- End if statement
END;
/
-- End of Create Procedure: Session_Reminder

-- Procedure : Session_Reminder
-- Description:
-- Input: Current Time
-- Output: Check if session is about to expire, if so then, send a message

-- Logic Flow:
-- Create cursor to get session id and session end time
-- Between current time and end time 
-- Create variables to store cursors information
-- Loop through the cursor
-- Exit when data is not found
-- Loop through every session and see if they are about to expire
-- If the time different between end time and current time is 15 mins or less
-- Send a reminder message indicating that session is about to expire and extend if necessary
-- Insert this message into the message table
-- Show that message has been created for that session
-- If current time does not create any reminder, say no session about to expire

-- Check Message table before calling procedure
SELECT * FROM Messages;

-- Normal Cases: Message generated
-- Expected Outcome: Say message have been generated for that session id
-- Session 2 is about to expire. Session 2 expires at 8, so generate message when its 7:45
SELECT * FROM ParkingSessions;
EXEC Session_Reminder(TIMESTAMP '2023-10-17 07:45:00');
SELECT * FROM Messages;

-- Special Case: Multiple Session about to expire
-- Expected Outcome: Shows multiple session about to expire
-- Check message before calling procedure
SELECT * FROM Messages;

EXEC Session_Reminder (TIMESTAMP '2023-10-17 10:45:00')
-- Check parking session table after calling procedure
SELECT * FROM ParkingSessions;
-- Two message is added to message table for session 1 and 7
SELECT * FROM Messages;


-- Special Case: No session
-- Expected Outcome: Say no session is about to expire
SELECT * FROM ParkingSessions;
EXEC Session_Reminder (TIMESTAMP '2023-10-12 10:45:00');

-- Check Message table after calling procedure
SELECT * FROM Messages;

-- End of Procedure Test: Session_Reminder

-- Feature 10: Showing statistics
CREATE OR REPLACE PROCEDURE Show_All_Statistics (	
	v_StartDate DATE, 
	v_EndDate DATE
)
IS 

-- Cursor to get Zone ID and Capacity
CURSOR C1 IS 
	SELECT ZoneID, Capacity FROM ParkingZones;

-- Declare Variables
v_CountCustomers NUMBER;
v_CountVehicles NUMBER;
v_CountZones NUMBER;
v_CountSessions NUMBER;
v_TotalSessionCharge NUMBER;
v_AvgCharge NUMBER;
v_AvgParkingLength NUMBER;
v_NumOfSessions NUMBER;
v_ZoneRevenue NUMBER;
v_OccupancyRate NUMBER;
v_CountDays NUMBER;
v_CountHours NUMBER;

-- Row type to store cursor record
Zone_Record C1%ROWTYPE;
BEGIN
    DBMS_OUTPUT.PUT_LINE('_______Group Feature 10___________');
    DBMS_OUTPUT.PUT_LINE('----------Parking Statistics----------');

	-- Get the total number of customers
	SELECT COUNT(*) INTO v_CountCustomers FROM Customers;
    DBMS_OUTPUT.PUT_LINE('Total Customers: ' || v_CountCustomers);
	
	-- Get the total number of vehicles
	SELECT COUNT(*) INTO v_CountVehicles FROM Vehicles;
    DBMS_OUTPUT.PUT_LINE('Total Vehicles: ' || v_CountVehicles);

	-- Get the total number of zones
	SELECT COUNT(*) INTO v_CountZones FROM ParkingZones;
    DBMS_OUTPUT.PUT_LINE('Total Parking Zones: ' || v_CountZones);
    
    -- Check the condition to make sure the end date is after the start date
    IF v_EndDate < v_StartDate THEN
        DBMS_OUTPUT.PUT_LINE('Invalid Date. End date cannot be before start date');
        RETURN;
    END IF;
    
    -- Check to make sure the start and end date are not the same to avoid 0 length day
    IF v_EndDate = v_StartDate THEN
        DBMS_OUTPUT.PUT_LINE('Invalid Date. End date cannot equal start date. 0 day length');
        RETURN;
    END IF;
	
	-- Get the total sessions and their total charge
	SELECT COUNT(*), SUM(TotalCharge) INTO v_CountSessions, v_TotalSessionCharge
	FROM ParkingSessions
	WHERE StartTime >= v_StartDate
	AND EstimatedEndTime <= v_EndDate;
    
    -- Check to see if there is no session
    -- If no session, stop and show a message
    IF v_CountSessions = 0 THEN
        DBMS_OUTPUT.PUT_LINE('No valid session in the given period.');
        RETURN;
    END IF;
	
	-- Get average charge per session
	SELECT AVG(TotalCharge), AVG(EXTRACT(HOUR FROM (EstimatedEndTime - StartTime))
	+ EXTRACT(MINUTE FROM (EstimatedEndTime - StartTime)) / 60)
	INTO v_AvgCharge, v_AvgParkingLength
	FROM ParkingSessions
	WHERE StartTime >= v_StartDate
	AND EstimatedEndTime <= v_EndDate;
	
	-- Print out packing session statistics 
    DBMS_OUTPUT.PUT_LINE('Total Parking Sessions: ' || v_CountSessions);
    DBMS_OUTPUT.PUT_LINE('Total Revenue: $' || v_TotalSessionCharge);
    DBMS_OUTPUT.PUT_LINE('Average Charge per Session: $' || v_AvgCharge);
    DBMS_OUTPUT.PUT_LINE('Average Parking Length (Hours): ' || v_AvgParkingLength);
    
    OPEN C1;
        LOOP
        FETCH C1 INTO Zone_Record;
        EXIT WHEN C1%NOTFOUND;
        
        SELECT COUNT(*), SUM(TotalCharge)
        INTO v_NumOfSessions, v_ZoneRevenue
        FROM ParkingSessions
        WHERE ZoneID = Zone_Record.ZoneID
        AND StartTime >= v_StartDate AND EstimatedEndTime <= v_EndDate;

        SELECT SUM(EXTRACT(HOUR FROM (EstimatedEndTime - StartTime)) + 
                   EXTRACT(MINUTE FROM (EstimatedEndTime - StartTime))/60)
        INTO v_CountHours
        FROM ParkingSessions
        WHERE ZoneID = Zone_Record.ZoneID
        AND StartTime >= v_StartDate AND EstimatedEndTime <= v_EndDate;
        
        -- Convert interval to the number of days
        v_CountDays := v_EndDate - v_StartDate;
        
        -- Calculate the occupancy rate
        -- Check to avoid 0 calculation
        IF v_CountDays > 0 AND Zone_Record.Capacity > 0 THEN
            v_OccupancyRate := v_CountHours / (Zone_Record.Capacity * 24 * v_CountDays);
        ELSE
            v_OccupancyRate := 0;
        END IF;
        
        -- Zones statistics
        DBMS_OUTPUT.PUT_LINE('____________Zones Statistics_____________');
        DBMS_OUTPUT.PUT_LINE('Zone ID: ' || Zone_Record.ZoneID);
        DBMS_OUTPUT.PUT_LINE('Capacity: ' || Zone_Record.Capacity 
        || CHR(10) || 'Sessions: ' || v_NumOfSessions 
        || CHR(10) || 'Revenue: $' || v_ZoneRevenue 
        || CHR(10) || 'Occupancy Rate: $' || v_OccupancyRate);

        END LOOP;
    CLOSE C1;

END;
/
-- End of Create Procedure: Show_All_Statistics
-- Normal Test case: This will display the statistics for the given date range
-- It will count the number of customers, vehicles, parking zones, parking sessions,
-- total revenue, average charge per session, and average parking length
-- It will also show statistics for each zone such as capacity, sessions,
-- zone revenue, and occupancy rate
EXEC Show_All_Statistics(DATE '2023-10-17', DATE '2023-10-18');
-- Call tables to prove the result.
-- Parking sessions table to check session details and Statistics
SELECT * FROM ParkingSessions;
-- Parking Zones table to check zone details and Statistics
SELECT * FROM ParkingZones;
-- Customers table to check the number of customers
SELECT * FROM Customers;

-- Special Test Cases
-- Special Test case 1: End date before start date
-- This is an invalid date as you cannot have an end date before the start date
-- This is will total customers, vehicles, and parking zones, but not session details
-- Show a message indicating an invalid date
EXEC Show_All_Statistics(DATE '2023-10-17', DATE '2023-10-16');

-- Special Test case 2: End date equal start date
-- This is the invalid date as you cannot have an end date that is equal start date
-- This is will total customers, vehicles, and parking zones, but not session details
-- Show a message indicating an invalid date as there is no range, 0 length
EXEC Show_All_Statistics(DATE '2023-10-17', DATE '2023-10-17');

-- Special Test case 3: No valid session in the given period
-- There are no active sessions in the given period
-- This is will total customers, vehicles, and parking zones, but not session details as there is none
-- Show a message indicating invalid sessions as there are no active sessions
EXEC Show_All_Statistics(DATE '2023-10-25', DATE '2023-10-26');
-- Call table to prove inactive sessions
SELECT * FROM ParkingSessions;

-- End of Procedure Test: Show_All_Statistics

COMMIT;

