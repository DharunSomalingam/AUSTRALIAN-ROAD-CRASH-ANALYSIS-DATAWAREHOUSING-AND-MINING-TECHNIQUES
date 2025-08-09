-- Create a dimension table named 'dimlocation' to store location-related information
CREATE TABLE dimlocation(
	LocationID INTEGER PRIMARY KEY,                 -- Unique identifier for each location
	State VARCHAR(3),                               -- Australian state code (e.g., NSW, VIC)
	NationalRemotenessAreas VARCHAR(25),            -- Classification of remoteness (e.g., Major Cities, Remote)
	SA4Name VARCHAR(38),                             -- Statistical Area Level 4 name (used for large region classification)
	NationalLGA VARCHAR(37)                          -- Local Government Area name
);

-- Populate the 'dimlocation' table from a CSV file
COPY dimlocation
FROM '/private/tmp/project/Dim_Location.csv'        -- Path to the CSV file
WITH (
    FORMAT csv,                                     -- Specify the format of the file as CSV
    DELIMITER ',',                                  -- Comma-separated values
    HEADER true,                                    -- First row in the file contains column headers
    NULL 'Unknown'                                  -- Treat the string 'Unknown' as NULL
);


select * from dimlocation;


CREATE TABLE dimroad(
	RoadID INTEGER PRIMARY KEY,
	NationalRoadType VARCHAR(25)
);



COPY dimroad
FROM '/private/tmp/project/Dim_RoadTypes.csv'
WITH (
    FORMAT csv,
    DELIMITER ',',
    HEADER true,
    NULL 'Unknown'  
);

select * from dimroad;

CREATE TABLE dimdate(
	DateID INTEGER PRIMARY KEY,
	Dayweek VARCHAR(9),
	Month INTEGER,
	Year INTEGER
);


COPY dimdate
FROM '/private/tmp/project/Dim_Date.csv'
WITH (
    FORMAT csv,
    DELIMITER ',',
    HEADER true,
    NULL 'Unknown'  
);

select * from dimdate;

CREATE TABLE dimperiod(
	PeriodID INTEGER PRIMARY KEY,
	Timeofday VARCHAR(5),
	Dayofweek VARCHAR(7)
);


COPY dimperiod
FROM '/private/tmp/project/Dim_Period.csv'
WITH (
    FORMAT csv,
    DELIMITER ',',
    HEADER true,
    NULL 'Unknown'  
);

select * from dimperiod;

CREATE TABLE dimvacation(
	VacationID INTEGER PRIMARY KEY,
	ChristmasPeriod VARCHAR(3),
    EasterPeriod VARCHAR(3)
);


COPY dimvacation
FROM '/private/tmp/project/Dim_Vacation.csv'
WITH (
    FORMAT csv,
    DELIMITER ',',
    HEADER true,
    NULL 'Unknown'  
);

select * from dimvacation;

CREATE TABLE dimcrash (
	InvolvementID INTEGER PRIMARY KEY,
	BusInvolvement VARCHAR(3),
	HeavyRidgidTruckInvolvement VARCHAR(3),
	ArticulateTruckInvolvement VARCHAR(3)
);



COPY dimcrash
FROM '/private/tmp/project/Dim_Crash.csv'
WITH (
    FORMAT csv,
    DELIMITER ',',
    HEADER true,
    NULL 'Unknown'  
);

select * from dimcrash;

CREATE TABLE dimcrashtype(
	TypeID INTEGER PRIMARY KEY,
	CrashType VARCHAR(20)
);


COPY dimcrashtype
FROM '/private/tmp/project/Dim_CrashType.csv'
WITH (
    FORMAT csv,
    DELIMITER ',',
    HEADER true,
    NULL 'Unknown'  
);

select * from dimcrashtype;


CREATE TABLE dimroaduser(
	UserID INTEGER PRIMARY KEY,
	Roaduser VARCHAR(28),
	Gender VARCHAR(6),
	Age INTEGER,
	AgeGroup VARCHAR(11)	
);

COPY dimroaduser
FROM '/private/tmp/project/Dim_User.csv'
WITH (
    FORMAT csv,
    DELIMITER ',',
    HEADER true,
    NULL 'Unknown'  
);

CREATE TABLE dimspeed(
	SpeedID INTEGER PRIMARY KEY,
	SpeedLimit INTEGER
);


COPY dimspeed
FROM '/private/tmp/project/Dim_Speed.csv'
WITH (
	FORMAT csv,
	DELIMITER ',',
	HEADER true,
	NULL 'Unknown'
);

select * from dimspeed;

-- Create the fact table 'FactAccident' to store accident event data
CREATE TABLE FactAccident (
    FactID INTEGER PRIMARY KEY,                     -- Unique identifier for each accident record (fact)
    CrashID INTEGER,                                -- Unique ID for the crash event (may link to external crash systems)
    Time TIME,                                      -- Time of the accident
    NumberFatalities INTEGER,                       -- Number of fatalities in the accident
    -- Foreign keys referencing dimension tables
    LocationID INTEGER,                             -- Links to dimlocation table
    RoadID INTEGER,                                 -- Links to dimroad table
    DateID INTEGER,                                 -- Links to dimdate table
    UserID INTEGER,                                 -- Links to dimroaduser table
    PeriodID INTEGER,                               -- Links to dimperiod table
    VacationID INTEGER,                             -- Links to dimvacation table
    TypeID INTEGER,                                 -- Links to dimcrashtype table
    SpeedID INTEGER,                                -- Links to dimspeed table
    InvolvementID INTEGER,                          -- Links to dimcrash table
    -- Defining the foreign key constraints
    FOREIGN KEY (LocationID) REFERENCES dimlocation(LocationID),
    FOREIGN KEY (RoadID) REFERENCES dimroad(RoadID),
    FOREIGN KEY (DateID) REFERENCES dimdate(DateID),
    FOREIGN KEY (UserID) REFERENCES dimroaduser(UserID),
    FOREIGN KEY (PeriodID) REFERENCES dimperiod(PeriodID),
    FOREIGN KEY (VacationID) REFERENCES dimvacation(VacationID),
    FOREIGN KEY (TypeID) REFERENCES dimcrashtype(TypeID),
    FOREIGN KEY (SpeedID) REFERENCES dimspeed(SpeedID),
    FOREIGN KEY (InvolvementID) REFERENCES dimcrash(InvolvementID)
);

-- Load data into the 'FactAccident' table from the CSV file
COPY factAccident
FROM '/private/tmp/project/Fact_Table.csv'         -- Path to the fact data CSV file
WITH (
    FORMAT csv,                                    -- CSV file format
    DELIMITER ',',                                 -- Values separated by commas
    HEADER true,                                   -- Skip the first row (column headers)
    NULL 'Unknown'                                 -- Treat the string 'Unknown' as NULL
);

select * from dimlocation;

