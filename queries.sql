# creating a database 
CREATE DATABASE RealEstateDB;

# Defining the database
use RealEstateDB;

# Creating owner table 
create table Owner (
	OwnerID int Primary key not null auto_increment,
    FirstName varchar(100) not null,
    LastName varchar(100) not null,
    ContactNumber varchar(12) not null,
    Email varchar(100) not null check (Email like '^[^@]+@[^@]+\.[^@]{2,}$')
);

## Creating index for owner table based on the last name 
create index idx_owner_lastname on owner(LastName);

# create table properties 
create table Properties (
	PropertyID int primary key not null auto_increment,
    OwnerID int Not null,
    Address varchar(255) not null,
    PropertyType varchar(100) check (PropertyType in ("House","Condo","Apartment","Townhouse")),
    Status varchar(100) check (status in ("Available","Not Available")),
    Foreign key (OwnerID) references Owner(OwnerID)
);

## creating index for properties status 
create index idx_properties_status on Properties(status);

# Create a table tenants 
create table tenants (
	TenantID int primary key not null auto_increment,
    FirstName varchar(100) not null,
    LastName varchar(100) not null,
    ContactNumber varchar(15) check (ContactNumber like '[0-9][0-9][0-9]-[0-9][0-9][0-9]-[0-9][0-9][0-9][0-9][0-9][0-9]'),
    Email varchar(100) not null check (Email like '^[A-Za-z0-9._%-]+@[A-Za-z0-9.-]+\\.[A-Za-z0-9]{2,10}$')
);

## creating index on tenants lastName
create index idx_tenants_lastname on tenants(LastName);

## creating table for agent 
create table Agent(
	AgentID int primary key not null auto_increment,
    FirstName varchar(100) not null,
    LastName varchar(100) not null,
    ContactNumber varchar(15) check (ContactNumber like '[0-9][0-9][0-9]-[0-9][0-9][0-9]-[0-9][0-9][0-9][0-9][0-9][0-9]'),
    Email varchar(100) not null check (Email like '^[A-Za-z0-9._%-]+@[A-Za-z0-9.-]+\\.[A-Za-z0-9]{2,10}$')
);

## creating index for agent lastname 
create index idx_agent_lastname on Agent(LastName);

### create table for rental contract 
create table RetnalContracts(
	ContractID int primary key not null auto_increment,
    PropertyID int not null,
    TenantID int not null,
    AgentID int not null,
    StartDate date not null,
    EndDate date not null,
    RentAmount Decimal(9,2) check (RentAmount > 0),
    DepositAmount decimal(9,2) check (DepositAmount >= 0),
    AgentPercentage decimal not null,
    foreign key (PropertyID) references Properties(PropertyID),
    foreign key (TenantID) references tenants(TenantID),
    foreign key (AgentID) references Agent(AgentID)
);

## creating index on the contract based on the startdate 
create index idx_contracts_startdate on RetnalContracts(StartDate);

## Creating table MaintenanceRequests
create table MaintenanceRequests (
	RequestID int primary key not null auto_increment,
    PropertyID int not null,
    TenantID int not null,
    AgentID int not null,
    RequestDate date not null,
    IssueDescription varchar(1000) not null,
    Status varchar(100) check (status in ("Open","In Progress","Closed")),
    foreign key (PropertyID) references Properties(PropertyID),
    foreign key (TenantID) references tenants(TenantID),
    foreign key (AgentID) references Agent(AgentID)
);

## creating index for maintances requests 
create index idx_requests_status on MaintenanceRequests(Status);

## Creating payment table 
create table payment (
	PaymentID int primary key not null auto_increment,
    ContractID int not null,
    PaymentDate Date not null,
    Amount Decimal(9,2) check (Amount > 0),
    Foreign key (ContractID) references RetnalContracts(ContractID)
);

### creating index for payment table 
create index idx_payments_paymentDate on payment(PaymentDate);

###

ALTER TABLE Properties ADD CONSTRAINT OwnerID FOREIGN KEY (OwnerID) REFERENCES owner(OwnerID);


### inserting records into the owner table
INSERT INTO Owner (FirstName, LastName, ContactNumber, Email) 
VALUES 
('John', 'Doe', '1234567890', 'john.doe@example.com'),
('Jane', 'Smith', '0987654321', 'jane.smith@example.com'),
('Michael', 'Johnson', '5551234567', 'michael.johnson@example.com'),
('Emily', 'Davis', '4449876543', 'emily.davis@example.com'),
('David', 'Miller', '3338765432', 'david.miller@example.com'),
('Sophia', 'Wilson', '1112223333', 'sophia.wilson@example.com'),
('James', 'Brown', '2223334444', 'james.brown@example.com'),
('Olivia', 'Jones', '3334445555', 'olivia.jones@example.com'),
('Liam', 'Garcia', '4445556666', 'liam.garcia@example.com'),
('Mason', 'Martinez', '5556667777', 'mason.martinez@example.com'),
('Isabella', 'Rodriguez', '6667778888', 'isabella.rodriguez@example.com'),
('Ethan', 'Hernandez', '7778889999', 'ethan.hernandez@example.com'),
('Ava', 'Lopez', '8889991111', 'ava.lopez@example.com'),
('Alexander', 'Gonzalez', '9991112222', 'alexander.gonzalez@example.com'),
('Mia', 'Perez', '1113334444', 'mia.perez@example.com'),
('Charlotte', 'Clark', '2224445555', 'charlotte.clark@example.com'),
('Amelia', 'Lewis', '3335556666', 'amelia.lewis@example.com'),
('Elijah', 'Lee', '4446667777', 'elijah.lee@example.com'),
('William', 'Walker', '5557778888', 'william.walker@example.com'),
('Benjamin', 'Hall', '6668889999', 'benjamin.hall@example.com');

## inserting records into properties table
INSERT INTO Properties (OwnerID, Address, PropertyType, Status) 
VALUES 
(1, '123 Elm Street, Berlin', 'House', 'Available'),
(2, '456 Oak Avenue, Berlin', 'Condo', 'Available'),
(3, '789 Pine Street, Berlin', 'Apartment', 'Not Available'),
(4, '321 Maple Street, Berlin', 'Townhouse', 'Available'),
(5, '654 Cedar Road, Berlin', 'House', 'Not Available'),
(6, '987 Birch Lane, Berlin', 'Condo', 'Available'),
(7, '246 Spruce Drive, Berlin', 'Apartment', 'Available'),
(8, '135 Willow Way, Berlin', 'Townhouse', 'Not Available'),
(9, '753 Aspen Street, Berlin', 'House', 'Available'),
(10, '159 Elmwood Avenue, Berlin', 'Condo', 'Not Available'),
(11, '753 Redwood Drive, Berlin', 'Apartment', 'Available'),
(12, '951 Fir Street, Berlin', 'House', 'Available'),
(13, '159 Oakwood Boulevard, Berlin', 'Condo', 'Not Available'),
(14, '753 Willow Street, Berlin', 'Townhouse', 'Available'),
(15, '369 Cherry Lane, Berlin', 'House', 'Not Available'),
(16, '852 Birchwood Avenue, Berlin', 'Apartment', 'Available'),
(17, '951 Maplewood Drive, Berlin', 'Condo', 'Available'),
(18, '159 Pinewood Street, Berlin', 'House', 'Not Available'),
(19, '753 Cedarwood Lane, Berlin', 'Townhouse', 'Available'),
(20, '258 Firwood Drive, Berlin', 'Apartment', 'Not Available');

## inserting records into tenants table
INSERT INTO tenants (FirstName, LastName, ContactNumber, Email)
VALUES
('John', 'Doe', '123-456-7890', 'john.doe@example.com'),
('Jane', 'Smith', '234-567-8901', 'jane.smith@example.com'),
('Michael', 'Johnson', '345-678-9012', 'michael.johnson@example.com'),
('Emily', 'Davis', '456-789-0123', 'emily.davis@example.com'),
('David', 'Miller', '567-890-1234', 'david.miller@example.com'),
('Sophia', 'Wilson', '678-901-2345', 'sophia.wilson@example.com'),
('James', 'Brown', '789-012-3456', 'james.brown@example.com'),
('Olivia', 'Jones', '890-123-4567', 'olivia.jones@example.com'),
('Liam', 'Garcia', '901-234-5678', 'liam.garcia@example.com'),
('Mason', 'Martinez', '012-345-6789', 'mason.martinez@example.com'),
('Isabella', 'Rodriguez', '123-456-7891', 'isabella.rodriguez@example.com'),
('Ethan', 'Hernandez', '234-567-8902', 'ethan.hernandez@example.com'),
('Ava', 'Lopez', '345-678-9013', 'ava.lopez@example.com'),
('Alexander', 'Gonzalez', '456-789-0124', 'alexander.gonzalez@example.com'),
('Mia', 'Perez', '567-890-1235', 'mia.perez@example.com'),
('Charlotte', 'Clark', '678-901-2346', 'charlotte.clark@example.com'),
('Amelia', 'Lewis', '789-012-3457', 'amelia.lewis@example.com'),
('Elijah', 'Lee', '890-123-4568', 'elijah.lee@example.com'),
('William', 'Walker', '901-234-5679', 'william.walker@example.com'),
('Benjamin', 'Hall', '012-345-6780', 'benjamin.hall@example.com');

## inserting records into agent table 
INSERT INTO Agent (FirstName, LastName, ContactNumber, Email)
VALUES
('Robert', 'Taylor', '123-456-7890', 'robert.taylor@example.com'),
('Jessica', 'Williams', '234-567-8901', 'jessica.williams@example.com'),
('Charles', 'Anderson', '345-678-9012', 'charles.anderson@example.com'),
('Linda', 'Thomas', '456-789-0123', 'linda.thomas@example.com'),
('Matthew', 'Jackson', '567-890-1234', 'matthew.jackson@example.com'),
('Sarah', 'White', '678-901-2345', 'sarah.white@example.com'),
('Christopher', 'Harris', '789-012-3456', 'christopher.harris@example.com'),
('Emily', 'Moore', '890-123-4567', 'emily.moore@example.com'),
('Daniel', 'Martin', '901-234-5678', 'daniel.martin@example.com'),
('Lisa', 'Thompson', '012-345-6789', 'lisa.thompson@example.com'),
('Anthony', 'Garcia', '123-456-7891', 'anthony.garcia@example.com'),
('Michelle', 'Martinez', '234-567-8902', 'michelle.martinez@example.com'),
('Steven', 'Rodriguez', '345-678-9013', 'steven.rodriguez@example.com'),
('Laura', 'Clark', '456-789-0124', 'laura.clark@example.com'),
('Kevin', 'Lewis', '567-890-1235', 'kevin.lewis@example.com'),
('Amanda', 'Walker', '678-901-2346', 'amanda.walker@example.com'),
('Brian', 'Young', '789-012-3457', 'brian.young@example.com'),
('Jennifer', 'Allen', '890-123-4568', 'jennifer.allen@example.com'),
('Joshua', 'King', '901-234-5679', 'joshua.king@example.com'),
('Rachel', 'Scott', '012-345-6780', 'rachel.scott@example.com');

## inserting records into the rentalcontract table 
INSERT INTO RetnalContracts(PropertyID, TenantID, AgentID, StartDate, EndDate, RentAmount, DepositAmount, AgentPercentage)
VALUES
(1, 1, 1, '2024-01-01', '2025-01-01', 1200.00, 1200.00, 5.00),
(2, 2, 2, '2024-02-01', '2025-02-01', 1500.00, 1500.00, 5.00),
(3, 3, 3, '2024-03-01', '2025-03-01', 1000.00, 1000.00, 5.00),
(4, 4, 4, '2024-04-01', '2025-04-01', 1800.00, 1800.00, 5.00),
(5, 5, 5, '2024-05-01', '2025-05-01', 900.00, 900.00, 5.00),
(6, 6, 6, '2024-06-01', '2025-06-01', 1100.00, 1100.00, 5.00),
(7, 7, 7, '2024-07-01', '2025-07-01', 1300.00, 1300.00, 5.00),
(8, 8, 8, '2024-08-01', '2025-08-01', 1600.00, 1600.00, 5.00),
(9, 9, 9, '2024-09-01', '2025-09-01', 1400.00, 1400.00, 5.00),
(10, 10, 10, '2024-10-01', '2025-10-01', 950.00, 950.00, 5.00),
(11, 11, 1, '2024-01-01', '2025-01-01', 1250.00, 1250.00, 5.00),
(12, 12, 2, '2024-02-01', '2025-02-01', 1150.00, 1150.00, 5.00),
(13, 13, 3, '2024-03-01', '2025-03-01', 1750.00, 1750.00, 5.00),
(14, 14, 4, '2024-04-01', '2025-04-01', 1350.00, 1350.00, 5.00),
(15, 15, 5, '2024-05-01', '2025-05-01', 1600.00, 1600.00, 5.00),
(16, 16, 6, '2024-06-01', '2025-06-01', 1700.00, 1700.00, 5.00),
(17, 17, 7, '2024-07-01', '2025-07-01', 900.00, 900.00, 5.00),
(18, 18, 8, '2024-08-01', '2025-08-01', 1900.00, 1900.00, 5.00),
(19, 19, 9, '2024-09-01', '2025-09-01', 1250.00, 1250.00, 5.00),
(20, 20, 10, '2024-10-01', '2025-10-01', 1350.00, 1350.00, 5.00);

## inserting records into the maintenancerequests table
INSERT INTO MaintenanceRequests (PropertyID, TenantID, AgentID, RequestDate, IssueDescription, Status)
VALUES
(1, 1, 1, '2024-01-15', 'Leaky faucet in the kitchen.', 'Open'),
(2, 2, 2, '2024-01-16', 'Heating system not working.', 'In Progress'),
(3, 3, 3, '2024-01-17', 'Broken window in the living room.', 'Open'),
(4, 4, 4, '2024-01-18', 'Mold found in the bathroom.', 'Closed'),
(5, 5, 5, '2024-01-19', 'Pest control needed in the basement.', 'Open'),
(6, 6, 6, '2024-01-20', 'Light fixture not working in hallway.', 'In Progress'),
(7, 7, 7, '2024-01-21', 'Water heater leaking.', 'Closed'),
(8, 8, 8, '2024-01-22', 'Noise complaint from neighbors.', 'Open'),
(9, 9, 9, '2024-01-23', 'Stove not heating up.', 'In Progress'),
(10, 10, 10, '2024-01-24', 'AC unit making strange noises.', 'Open'),
(11, 11, 1, '2024-01-25', 'Garage door not opening.', 'Closed'),
(12, 12, 2, '2024-01-26', 'Roof leak during rain.', 'Open'),
(13, 13, 3, '2024-01-27', 'Broken shower head.', 'In Progress'),
(14, 14, 4, '2024-01-28', 'Cracks in the walls.', 'Closed'),
(15, 15, 5, '2024-01-29', 'Worn-out carpet in the living room.', 'Open'),
(16, 16, 6, '2024-01-30', 'Faulty electrical outlet.', 'In Progress'),
(17, 17, 7, '2024-01-31', 'Garage light not working.', 'Closed'),
(18, 18, 8, '2024-02-01', 'Faucet leaking in bathroom.', 'Open'),
(19, 19, 9, '2024-02-02', 'Window screen needs replacement.', 'In Progress'),
(20, 20, 10, '2024-02-03', 'Dishwasher not draining.', 'Open');

## inserting records into the payment table
INSERT INTO payment (ContractID, PaymentDate, Amount)
VALUES
(1, '2024-01-01', 1500.00),
(2, '2024-01-02', 1200.00),
(3, '2024-01-03', 1800.00),
(4, '2024-01-04', 900.00),
(5, '2024-01-05', 1600.00),
(6, '2024-01-06', 1400.00),
(7, '2024-01-07', 1300.00),
(8, '2024-01-08', 1100.00),
(9, '2024-01-09', 2000.00),
(10, '2024-01-10', 1700.00),
(11, '2024-01-11', 1500.00),
(12, '2024-01-12', 1250.00),
(13, '2024-01-13', 1650.00),
(14, '2024-01-14', 1350.00),
(15, '2024-01-15', 1450.00),
(16, '2024-01-16', 1550.00),
(17, '2024-01-17', 1750.00),
(18, '2024-01-18', 1550.00),
(19, '2024-01-19', 1650.00),
(20, '2024-01-20', 1300.00);


## trigger for insert on properties table
DELIMITER $$

CREATE TRIGGER before_properties_insert
BEFORE INSERT ON Properties
FOR EACH ROW
BEGIN
    IF NEW.Status NOT IN ('Available', 'Not Available') THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Invalid Status. Status must be either "Available" or "Not Available".';
    END IF;
END $$

DELIMITER ;

## trigger for update on properties table
DELIMITER $$

CREATE TRIGGER before_properties_update
BEFORE UPDATE ON Properties
FOR EACH ROW
BEGIN
    IF NEW.Status NOT IN ('Available', 'Not Available') THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Invalid Status. Status must be either "Available" or "Not Available".';
    ELSEIF OLD.Status != NEW.Status THEN
        -- Log or handle the status change, e.g., insert into a log table (not mandatory, for demo)
        INSERT INTO PropertyStatusLog(PropertyID, OldStatus, NewStatus, ChangeDate)
        VALUES (OLD.PropertyID, OLD.Status, NEW.Status, NOW());
    END IF;
END $$

DELIMITER ;

## Select perticuler attributes form the properties table
SELECT PropertyID, Address, PropertyType FROM Properties;

##### select unique values from properties
SELECT DISTINCT PropertyType FROM Properties;

#Select All Tenants with Specific Last Name
SELECT * FROM Tenants WHERE LastName = 'Smith';

## Select Properties that are 'Available'
SELECT * FROM Properties WHERE Status = 'Available';

## Select a rental contract which start from a particular date 
SELECT * FROM RetnalContracts WHERE StartDate > '2024-01-01';


## Count the number of properties own by each owner 
SELECT OwnerID, COUNT(PropertyID) AS PropertyCount FROM Properties GROUP BY OwnerID;

## Find the maximum rent amount in the rent contract 
SELECT MAX(RentAmount) AS MaxRent FROM RetnalContracts;

## Calculate the average amount for all the contract 
SELECT AVG(RentAmount) AS AvgRent FROM RetnalContracts;

## Inner Join Properties and Owner to get properties address with the owner information  
SELECT p.PropertyID, p.Address, o.FirstName, o.LastName 
FROM Properties p 
JOIN Owner o ON p.OwnerID = o.OwnerID;

## Join Rentalcontracts and Tenants to get contract details with tenants' information  
SELECT rc.ContractID, rc.StartDate, rc.EndDate, t.FirstName, t.LastName FROM RetnalContracts rc
JOIN Tenants t ON rc.TenantID = t.TenantID;

## Left Join Properties and MaintenanceRequests to List All Properties with maintenance requests  
SELECT p.PropertyID, p.Address, m.RequestID, m.Status
FROM Properties p
LEFT JOIN MaintenanceRequests m ON p.PropertyID = m.PropertyID;

## Get the payment information with the agent information 
SELECT py.PaymentID, py.Amount, py.PaymentDate, a.FirstName AS AgentFirstName, a.LastName AS AgentLastName
FROM payment py
JOIN RetnalContracts rc ON py.ContractID = rc.ContractID
JOIN Agent a ON rc.AgentID = a.AgentID;

## Group Payments by ContractID and Count the Number of Payments for Each Contract
SELECT ContractID, COUNT(PaymentID) AS PaymentCount
FROM payment
GROUP BY ContractID;

## Group Contracts by Agent and Sum of the Rent Amount cared by Each Agent 
SELECT AgentID, SUM(RentAmount) AS TotalRentHandled
FROM RetnalContracts
GROUP BY AgentID
HAVING TotalRentHandled > 5000;

## Select all the properties where the Ower has more than 2 properties  
SELECT * FROM Properties WHERE OwnerID IN (
    SELECT OwnerID
    FROM Properties
    GROUP BY OwnerID
    HAVING COUNT(PropertyID) > 2
);

## Select Tenants Who Have a Contract with a Rent Amount Above the Average 
SELECT t.FirstName, t.LastName FROM Tenants t WHERE t.TenantID IN (
    SELECT rc.TenantID
    FROM RetnalContracts rc
    WHERE rc.RentAmount > (SELECT AVG(RentAmount) FROM RetnalContracts)
);

## Select top 5 most recent payment
SELECT * FROM payment ORDER BY PaymentDate DESC LIMIT 5;

## Select all agents and sort them by their last name
SELECT * FROM Agent ORDER BY LastName ASC;

## Select 15 contracts but skip the first 5 contracts 
SELECT * FROM RetnalContracts ORDER BY StartDate DESC LIMIT 15 OFFSET 5;

## CROSS JOIN Example: Get a Cartesian product between Properties and Agents
SELECT p.PropertyID, p.Address, a.AgentID, a.FirstName, a.LastName FROM Properties p
CROSS JOIN Agent a;

## INNER JOIN Example: Find all Rental Contracts with Tenant and Agent Information 
SELECT rc.ContractID, t.FirstName AS TenantFirstName, t.LastName AS TenantLastName, a.FirstName AS AgentFirstName, a.LastName AS AgentLastName, rc.RentAmount FROM RetnalContracts rc
INNER JOIN Tenants t ON rc.TenantID = t.TenantID
INNER JOIN Agent a ON rc.AgentID = a.AgentID;

## LEFT JOIN Example: List all Properties and their Maintenance Requests (if any)
SELECT p.PropertyID, p.Address, m.RequestID, m.IssueDescription FROM Properties p
LEFT JOIN MaintenanceRequests m ON p.PropertyID = m.PropertyID;

## RIGHT JOIN Example: Get all Agents and the Properties they manage (even if they haven't managed any property)
SELECT a.AgentID, a.FirstName, a.LastName, p.PropertyID, p.Address FROM Properties p
RIGHT JOIN Agent a ON p.AgentID = a.AgentID;

## Select Top 5 Most Recent Payments
SELECT * FROM payment
ORDER BY PaymentDate DESC
LIMIT 5;

## Select All Agents and Sort Them by Last Name
SELECT * FROM Agent
ORDER BY LastName ASC;

## Select 15 Contracts, Skipping the First 5
SELECT * FROM RetnalContracts
ORDER BY StartDate DESC
LIMIT 15 OFFSET 5;
