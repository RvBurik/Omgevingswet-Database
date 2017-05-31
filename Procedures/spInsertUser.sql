USE [OMGEVINGSWETLOCAL]
GO
/****** Object:  StoredProcedure [dbo].[spInsertUser]    Script Date: 31-5-2017 11:15:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spInsertUser]
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
		IF @mailadres IN (SELECT MAILADRES FROM GEBRUIKER)
			BEGIN
				RAISERROR('Email is al in gebruik', 16, 1);
			END
		IF @gebruikersnaam IN (SELECT gebruikersnaam FROM GEBRUIKER)
			BEGIN
				RAISERROR('Deze gebruikersnaam is al in gebruik', 16, 1);
			END
		--Check of adres al bestaat in de db, zo niet, dan wordt deze toegevoegd
		SELECT @ADRESID = adresID FROM ADRES WHERE POSTCODE = @postcode AND HUISNUMMER  = @huisnummer AND toevoeging = @toevoeging
		IF @ADRESID IS NULL
			BEGIN
				INSERT INTO ADRES(POSTCODE, HUISNUMMER, TOEVOEGING, XCOORDINAAT, YCOORDINAAT)
				VALUES(@postcode, @huisnummer, @toevoeging, @xcoordinaat, @ycoordinaat)
			END
		--Toevoegen van de gebruiker zelf 
		BEGIN
			INSERT INTO PARTICULIER(GEBRUIKERSNAAM, VOORNAAM, TUSSENVOEGSEL, ACHTERNAAM, GEBOORTEDATUM, GESLACHT)
			VALUES(@gebruikersnaam, @voornaam, @tussenvoegsel, @achternaam, @geboortedatum, @geslacht)

			INSERT INTO GEBRUIKER(GEBRUIKERSNAAM, WACHTWOORD, MAILADRES)
			VALUES(@gebruikersnaam, @wachtwoord, @mailadres)
		END

		--Haal het nieuw toegevoegde adres op
		SELECT @ADRESIDTOEGEVOEGD = ADRESID FROM ADRES WHERE POSTCODE = @postcode AND HUISNUMMER = @huisnummer AND TOEVOEGING = @toevoeging
		BEGIN
			INSERT INTO ADRES_VAN_GEBRUIKER(ADRESID, GEBRUIKERSNAAM)
			VALUES(@ADRESIDTOEGEVOEGD, @gebruikersnaam)
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


EXEC spInsertUser @gebruikersnaam = 'Testuser', @voornaam = 'Ricardo', @tussenvoegsel = 'van', @achternaam = 'Burik',
				  @geboortedatum = '1996-11-09', @geslacht = 'M', @mailadres = 'test@hotmail.com', 
				  @wachtwoord = 'Bushokje1', @telefoon = '0655871782', @postcode = '7334A', @huisnummer = 284, @toevoeging = 'A',
				  @xcoordinaat = 50, @ycoordinaat = 50


DELETE FROM ADRES_VAN_GEBRUIKER WHERE GEBRUIKERSNAAM = 'RvBurik'
DELETE FROM ADRES WHERE ADRESID = 1
DELETE FROM GEBRUIKER WHERE GEBRUIKERSNAAM = 'RvBurik'
DELETE FROM PARTICULIER WHERE GEBRUIKERSNAAM = 'RvBurik'


SELECT * FROM GEBRUIKER
SELECT * FROM TELEFOON
SELECT * FROM TELEFOON_VAN_GEBRUIKER
SELECT * FROM ADRES
SELECT * FROM ADRES_VAN_GEBRUIKER

