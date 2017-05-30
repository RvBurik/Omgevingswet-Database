
ALTER PROCEDURE spResetUserInformation
@gebruiker VARCHAR(255),
@postc VARCHAR(6),
@hnummer NUMERIC(5,0),
@toev VARCHAR(5),
@tel VARCHAR(20)

AS
	BEGIN
		SET NOCOUNT ON;
		DELETE FROM GEBRUIKERTEL WHERE GEBRUIKERSNAAM = @gebruiker AND TELEFOONNUMMER = @tel
		DELETE FROM ADRES_VAN_GEBRUIKER WHERE GEBRUIKERSNAAM = @gebruiker AND ADRESID = (SELECT ADRESID FROM ADRESGEGEVENS WHERE POSTCODE = @postc AND HUISNUMMER = @hnummer AND TOEVOEGING = @toev)
		DELETE FROM GEBRUIKER WHERE GEBRUIKERSNAAM = @gebruiker
	END
GO

EXEC spResetUserInformation @gebruiker = 'LocationTester', @postc = '7334AA', @hnummer = 284, @toev = 'A', @tel = '0655871782'
SELECT * FROM GEBRUIKERTEL WHERE GEBRUIKERSNAAM = 'LocationTester'
SELECT * FROM GEBRUIKER

ALTER PROCEDURE spInsertUser
@gebruikersnaam VARCHAR(255),
@voornaam VARCHAR(100),
@tussenvoegsel VARCHAR(25),
@achternaam VARCHAR(255),
@geboortedatum DATE,
@geslacht CHAR(1),
@mailadres VARCHAR(255),
@wachtwoord VARCHAR(255),
@telefoon VARCHAR(20),
@postcode VARCHAR(6),
@huisnummer NUMERIC(5,0),
@toevoeging VARCHAR(5),
@xcoordinaat FLOAT,
@ycoordinaat FLOAT

AS

	BEGIN TRY
		SET NOCOUNT ON;
		DECLARE @ADRESID int
		DECLARE @ADRESIDTOEGEVOEGD int
		DECLARE @TELEFOONNUMMER varchar(20)
		--Check of email al bestaat
		IF @mailadres IN (SELECT mailadres FROM GEBRUIKER)
			BEGIN
				RAISERROR('Email is al in gebruik', 16, 1);
				EXEC spResetUserInformation @gebruiker = @gebruikersnaam, @postc = @postcode, @hnummer = @huisnummer, @toev = @toevoeging
			END
		IF @gebruikersnaam IN (SELECT gebruikersnaam FROM GEBRUIKER)
			BEGIN
				RAISERROR('Deze gebruikersnaam is al in gebruik', 16, 1);
				EXEC spResetUserInformation @gebruiker = @gebruikersnaam, @postc = @postcode, @hnummer = @huisnummer, @toev = @toevoeging
			END
		--Check of adres al bestaat in de db, zo niet, dan wordt deze toegevoegd
		SELECT @ADRESID = adresID FROM ADRESGEGEVENS WHERE postcode = @postcode AND huisnummer = @huisnummer AND toevoeging = @toevoeging
		IF @ADRESID IS NULL
			BEGIN
				INSERT INTO ADRESGEGEVENS(POSTCODE, HUISNUMMER, TOEVOEGING, XCOORDINAAT, YCOORDINAAT)
				VALUES(@postcode, @huisnummer, @toevoeging, @xcoordinaat, @ycoordinaat)
			END
		--Toevoegen van de gebruiker zelf 
		BEGIN TRY
			INSERT INTO GEBRUIKER(GEBRUIKERSNAAM, WACHTWOORD, VOORNAAM, TUSSENVOEGSEL, ACHTERNAAM, GEBOORTEDATUM, GESLACHT, MAILADRES)
			VALUES(@gebruikersnaam, @wachtwoord, @voornaam, @tussenvoegsel, @achternaam, @geboortedatum, @geslacht, @mailadres)
		END TRY
		BEGIN CATCH
			RAISERROR('AN ERROR OCCURED ON INSERTING A USER', 16, 1)
			EXEC spResetUserInformation @gebruiker = @gebruikersnaam, @postc = @postcode, @hnummer = @huisnummer, @toev = @toevoeging
		END CATCH
		--Haal het nieuw toegevoegde adres op
		SELECT @ADRESIDTOEGEVOEGD = adresID FROM ADRESGEGEVENS WHERE postcode = @postcode AND huisnummer = @huisnummer AND toevoeging = @toevoeging
		BEGIN TRY
			INSERT INTO ADRES_VAN_GEBRUIKER(ADRESID, GEBRUIKERSNAAM)
			VALUES(@ADRESIDTOEGEVOEGD, @gebruikersnaam)
		END TRY
		BEGIN CATCH
			RAISERROR('AN ERROR OCCURED ON INSERTING ADRES', 16, 1)
			EXEC spResetUserInformation @gebruiker = @gebruikersnaam, @postc = @postcode, @hnummer = @huisnummer, @toev = @toevoeging
		END CATCH
		--Check op telefoonnummer 
		SELECT @TELEFOONNUMMER = TELEFOONNUMMER FROM TELEFOON WHERE TELEFOONNUMMER = @telefoon
		IF @TELEFOONNUMMER IS NULL
			BEGIN TRY
				INSERT INTO TELEFOON(TELEFOONNUMMER)
				VALUES(@telefoon)
			END TRY
			BEGIN CATCH
				RAISERROR('AN ERROR OCCURED ON INSERTING A TELNUMBER', 16, 1)
				EXEC spResetUserInformation @gebruiker = @gebruikersnaam, @postc = @postcode, @hnummer = @huisnummer, @toev = @toevoeging
			END CATCH

		--Koppel telefoonnummer aan gebruiker
		BEGIN TRY
			INSERT INTO GEBRUIKERTEL(TELEFOONNUMMER, GEBRUIKERSNAAM)
			VALUES(@telefoon, @gebruikersnaam)
		END TRY
		BEGIN CATCH
			RAISERROR('AN ERROR OCCURED ON INSERTING TELNUMBER', 16, 1)
			EXEC spResetUserInformation @gebruiker = @gebruikersnaam, @postc = @postcode, @hnummer = @huisnummer, @toev = @toevoeging
		END CATCH
	END TRY
	BEGIN CATCH
		THROW;	
	END CATCH
GO

SELECT * FROM ADRESGEGEVENS



UPDATE ADRES_VAN_GEBRUIKER
SET ADRESID = 5 
WHERE ADRESID = 1 OR ADRESID = 2

SELECT * FROM BEDRIJF
UPDATE BEDRIJF SET ADRESID = 2 WHERE ADRESID = 1


DELETE FROM ADRESGEGEVENS WHERE ADRESID = 1
SELECT * FROM ADRES_VAN_GEBRUIKER

SELECT * FROM GEBRUIKER
SELECT * FROM GEBRUIKERTEL

DELETE FROM GEBRUIKER WHERE GEBRUIKERSNAAM = 'LocationTest'

EXEC spInsertUser @gebruikersnaam = 'admin', @voornaam = 'Ricardo', @tussenvoegsel = 'van', @achternaam = 'Burik', @geboortedatum = '1996-11-29', @geslacht = 'M', @mailadres = 'ricardo@bvb-solutions.com',
				  @wachtwoord = 'test', @telefoon = '06-55871782', @postcode = '7334AA', @huisnummer = 284, @toevoeging = 'A'


@gebruikersnaam VARCHAR(255),
@voornaam VARCHAR(100),
@tussenvoegsel VARCHAR(25),
@achternaam VARCHAR(255),
@geboortedatum DATE,
@geslacht CHAR(1),telefoon, 
@mailadres VARCHAR(255),
@wachtwoord VARCHAR(255),
@telefoon VARCHAR(20),
@postcode VARCHAR(6),
@huisnummer NUMERIC(5,0),
@toevoeging VARCHAR(5)

EXEC sp_dbcmptlevel Omgevingswet, 100

CREATE PROCEDURE spTest 
@rol VARCHAR(255)

AS
	BEGIN
		INSERT INTO ROL (ROL.TYPE)
		VALUES(@rol)
	END
GO

SELECT * FROM GEBRUIKER

UPDATE GEBRUIKER
SET WACHTWOORD = 'test' 
WHERE GEBRUIKERSNAAM = 'RvBurik'

DELETE FROM GEBRUIKER WHERE GEBOORTEDATUM = '1990-01-01'
DELETE FROM GEBRUIKER WHERE GEBRUIKERSNAAM = 'Tester'
SELECT * FROM ROL
SELECT * FROM ADRESGEGEVENS
SELECT * FROM ADRES_VAN_GEBRUIKER
DELETE FROM ADRES_VAN_GEBRUIKER WHERE ADRESID = 1004
DELETE FROM GEBRUIKERTEL WHERE GEBRUIKERSNAAM = 'Tester'

