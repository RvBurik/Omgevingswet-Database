USE [OMGEVINGSWET]
GO
/****** Object:  StoredProcedure [dbo].[spInsertUser]    Script Date: 31-5-2017 11:15:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[spInsertUser]
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
		DECLARE @TOEGEVOEGD int
		DECLARE @TELEFOONNUMMER varchar(20)
		--Check of email al bestaat
		IF @mailadres IN (SELECT MAILADRES FROM GEBRUIKER)
			BEGIN
				RAISERROR('Email is al in gebruik', 16, 1);
			END
		IF @gebruikersnaam IN (SELECT gebruikersnaam FROM GEBRUIKER)
			BEGIN
				RAISERROR('Deze gebruikersnaam is al in gebruik', 16, 1);
			END
		--Check of adres al bestaat in de db, zo niet, dan wordt deze toegevoegd
		SELECT @ADRESID = adresID FROM ADRESGEGEVENS WHERE POSTCODE = @postcode AND HUISNUMMER  = @huisnummer AND toevoeging = @toevoeging
		IF @ADRESID IS NULL
			BEGIN
				INSERT INTO ADRESGEGEVENS(POSTCODE, HUISNUMMER, TOEVOEGING, XCOORDINAAT, YCOORDINAAT)
				VALUES(@postcode, @huisnummer, @toevoeging, @xcoordinaat, @ycoordinaat)
			END
		--Toevoegen van de gebruiker zelf 
			
		INSERT INTO GEBRUIKER(GEBRUIKERSNAAM, WACHTWOORD, MAILADRES)
		VALUES(@gebruikersnaam, @wachtwoord, @mailadres)
			
		INSERT INTO PARTICULIER(GEBRUIKERSNAAM, VOORNAAM, TUSSENVOEGSEL, ACHTERNAAM, GEBOORTEDATUM, GESLACHT)
		VALUES(@gebruikersnaam, @voornaam, @tussenvoegsel, @achternaam, @geboortedatum, @geslacht)
		--Haal het nieuw toegevoegde adres op
		SELECT @TOEGEVOEGD = adresID FROM ADRESGEGEVENS WHERE POSTCODE = @postcode AND HUISNUMMER  = @huisnummer AND toevoeging = @toevoeging

		IF @TOEGEVOEGD IS NOT NULL
		BEGIN
			INSERT INTO ADRES_VAN_GEBRUIKER(ADRESID, GEBRUIKERSNAAM)
			VALUES(@TOEGEVOEGD, @gebruikersnaam)
		END
		ELSE
			BEGIN
				INSERT INTO ADRES_VAN_GEBRUIKER
				VALUES(@ADRESID, @gebruikersnaam)
			END
								
		--Check op telefoonnummer 
		SELECT @TELEFOONNUMMER = TELEFOONNUMMER FROM TELEFOON WHERE TELEFOONNUMMER = @telefoon
		IF @TELEFOONNUMMER IS NULL
			BEGIN 
				INSERT INTO TELEFOON(TELEFOONNUMMER)
				VALUES(@telefoon)
			END


		--Koppel telefoonnummer aan gebruiker
		BEGIN
			INSERT INTO TELEFOON_VAN_GEBRUIKER(TELEFOONNUMMER, GEBRUIKERSNAAM)
			VALUES(@telefoon, @gebruikersnaam)
		END
	END TRY
	BEGIN CATCH
		THROW;	
		ROLLBACK
	END CATCH


EXEC spInsertUser @gebruikersnaam = 'KLDKG', @voornaam = 'Ricardo', @tussenvoegsel = 'van', @achternaam = 'Burik',
				  @geboortedatum = '1996-11-09', @geslacht = 'M', @mailadres = 'LKDFGD', 
				  @wachtwoord = 'Bushokje1', @telefoon = '0655871782', @postcode = '7334A', @huisnummer = 284, @toevoeging = 'A',
				  @xcoordinaat = 50, @ycoordinaat = 50


DELETE FROM ADRES_VAN_GEBRUIKER WHERE GEBRUIKERSNAAM = 'RvBurik'
DELETE FROM ADRESGEGEVENS WHERE ADRESID = 1
DELETE FROM GEBRUIKER WHERE GEBRUIKERSNAAM = 'Testuser'
DELETE FROM PARTICULIER WHERE GEBRUIKERSNAAM = 'Testuser'
DELETE FROM TELEFOON
DELETE FROM TELEFOON_VAN_GEBRUIKER

SELECT * FROM GEBRUIKER
SELECT * FROM TELEFOON
SELECT * FROM TELEFOON_VAN_GEBRUIKER
SELECT * FROM ADRESGEGEVENS
SELECT * FROM ADRES_VAN_GEBRUIKER

UPDATE GEBRUIKER
SET WACHTWOORD = '$2y$10$/.nX8riuzKf0wpDbOvnUl.XK4HDrAGIvVS4qABYag97WXCyDIc.ui'
WHERE GEBRUIKERSNAAM = 'Testuser'

