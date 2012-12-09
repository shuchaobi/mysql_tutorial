
-- All tables used for PLC monitoring database

DELIMITER $$

CREATE PROCEDURE createDB()
BEGIN

IF 
	SELECT Versions.id = 1 THEN
	CREATE TABLE IF NOT EXISTS PLCs(
		id 				INT AUTO_INCREMENT,
		serialNumber 	VARCHAR(32) NOT NULL,
		friendlyName 	VARCHAR(32),
		locName			VARCHAR(64) 
		
		PRIMARY KEY(id),
		UNIQUE INDEX(serialNumber),
		UNIQUE INDEX(friendlyName),
		
		FOREIGN KEY(locName) REFERENCES
			Locations(locName) ON DELETE RESTRICT
	)$$

	CREATE TABLE IF NOT EXISTS Locations(
		id				INT AUTO_INCREMENT,
		name			VARCHAR(64) 
		
		PRIMARY KEY(id)
	)$$

	CREATE TABLE IF NOT EXISTS Installations(
		plcID			INT NOT NULL,
		engID			INT NOT NULL,
		
		PRIMARY KEY (plcID, engID),
		UNIQUE INDEX(plcID, engID),
		
		FOREIGN KEY (plcID) REFERENCES
			(PLCs.id) ON DELETE RESTRICT,
		FOREIGN KEY (engID) REFERENCES
			(Engineers.id) ON DELETE RESTRICT
	)$$

	CREATE TABLE IF NOT EXISTS Engineers(
		id				INT AUTO_INCREMENT,
		fName			VARCHAR(64) NOT NULL,
		lName			VARCHAR(64) NOT NULL,
		
		PRIMARY KEY(id)
	)$$

END IF$$

END$$

DELIMITER ;

CREATE TABLE IF NOT EXISTS Versions(
	id				INT PRIMARY KEY
);

CALL createDB();