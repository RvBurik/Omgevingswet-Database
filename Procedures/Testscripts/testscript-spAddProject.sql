USE OMGEVINGSWETLOCAL
GO

--Testscript spAddProject
SET NOCOUNT ON

-- Succes scenario
GO
DECLARE @TRANCOUNT INTEGER = @@TRANCOUNT;
IF (@TRANCOUNT = 0)
	BEGIN TRAN
ELSE
	SAVE TRAN savepoint;
BEGIN TRY
	
	--Aanmaken van de voorbeelddata

	--GEBRUIKER
	DECLARE @GEBRUIKERSNAAM VARCHAR(255) = 'CEO'
	DECLARE @WACHTWOORD VARCHAR(255) = 'WACHTWOORD'
	DECLARE @MAILADRES VARCHAR(255) = 'MAILADRES'


	INSERT INTO GEBRUIKER(GEBRUIKERSNAAM, WACHTWOORD, MAILADRES)
	VALUES(@GEBRUIKERSNAAM, @WACHTWOORD, @MAILADRES)

	--PARTICULIER
	DECLARE @VOORNAAM VARCHAR(255) = 'Ricardo'
	DECLARE @TUSSENVOEGSEL VARCHAR(25) = 'van'
	DECLARE @ACHTERNAAM VARCHAR(255) = 'BuriK'
	DECLARE @GEBOORTEDATUM DATE = '1996-11-29'
	DECLARE @GESLACHT CHAR(1) = 'M'
	
	INSERT INTO PARTICULIER
	VALUES(@GEBRUIKERSNAAM, @VOORNAAM, @TUSSENVOEGSEL, @ACHTERNAAM, @GEBOORTEDATUM, @GESLACHT)

	--ROL
	DECLARE @ROLNAAM VARCHAR(255) = 'INITIATIEFNEMER'
	DECLARE @ROLBESCHRIJVING VARCHAR(255) = 'TESTWAARDE VOOR EEN INITIATIEFNEMER'

	INSERT INTO ROL
	VALUES(@ROLNAAM, @ROLBESCHRIJVING)

	--PROJECT
	DECLARE @PROJECTTITEL VARCHAR(255) =  'TITEL'
	DECLARE @AANGEMAAKTOP DATE = GETDATE()
	DECLARE @WERKZAAMHEID VARCHAR(255) = 'Het testen van de procedure'
	DECLARE @XCOORDINAAT FLOAT = 12.15468
	DECLARE @YCOORDINAAT FLOAT = 12.6875213


	--Daadwerkelijke test
	EXEC spAddProject @gebruikersnaam = @GEBRUIKERSNAAM, @titel = @PROJECTTITEL, @werkzaamheid = @WERKZAAMHEID, @xcoordinaat = @XCOORDINAAT, @ycoordinaat = @YCOORDINAAT
	
	PRINT 'Test 1 is geslaagd!'
	IF (@TRANCOUNT = 0)
		ROLLBACK TRAN
	ELSE
		ROLLBACK TRAN savepoint;
END TRY
BEGIN CATCH
PRINT 'Test 1 is gefaald!'
	IF (@TRANCOUNT = 0)
		ROLLBACK TRAN
	ELSE
		ROLLBACK TRAN savepoint;
	THROW;
END CATCH
GO

--Test zal falen, geen rol 'INITIATIEFNEMER' aanwezig

SET NOCOUNT ON

-- Succes scenario
GO
DECLARE @TRANCOUNT INTEGER = @@TRANCOUNT;
IF (@TRANCOUNT = 0)
	BEGIN TRAN
ELSE
	SAVE TRAN savepoint;
BEGIN TRY
	
	--Aanmaken van de voorbeelddata

	--GEBRUIKER
	DECLARE @GEBRUIKERSNAAM VARCHAR(255) = 'CEO'
	DECLARE @WACHTWOORD VARCHAR(255) = 'WACHTWOORD'
	DECLARE @MAILADRES VARCHAR(255) = 'MAILADRES'


	INSERT INTO GEBRUIKER(GEBRUIKERSNAAM, WACHTWOORD, MAILADRES)
	VALUES(@GEBRUIKERSNAAM, @WACHTWOORD, @MAILADRES)

	--PARTICULIER
	DECLARE @VOORNAAM VARCHAR(255) = 'Ricardo'
	DECLARE @TUSSENVOEGSEL VARCHAR(25) = 'van'
	DECLARE @ACHTERNAAM VARCHAR(255) = 'BuriK'
	DECLARE @GEBOORTEDATUM DATE = '1996-11-29'
	DECLARE @GESLACHT CHAR(1) = 'M'
	
	INSERT INTO PARTICULIER
	VALUES(@GEBRUIKERSNAAM, @VOORNAAM, @TUSSENVOEGSEL, @ACHTERNAAM, @GEBOORTEDATUM, @GESLACHT)

	--PROJECT
	DECLARE @PROJECTTITEL VARCHAR(255) =  'TITEL'
	DECLARE @AANGEMAAKTOP DATE = GETDATE()
	DECLARE @WERKZAAMHEID VARCHAR(255) = 'Het testen van de procedure'
	DECLARE @XCOORDINAAT FLOAT = 12.15468
	DECLARE @YCOORDINAAT FLOAT = 12.6875213


	--Daadwerkelijke test
	EXEC spAddProject @gebruikersnaam = @GEBRUIKERSNAAM, @titel = @PROJECTTITEL, @werkzaamheid = @WERKZAAMHEID, @xcoordinaat = @XCOORDINAAT, @ycoordinaat = @YCOORDINAAT
	
	PRINT 'Test 2 is gefaald!'
	IF (@TRANCOUNT = 0)
		ROLLBACK TRAN
	ELSE
		ROLLBACK TRAN savepoint;
END TRY
BEGIN CATCH
PRINT 'Test 2 is geslaagd Foutmelding: Foreign key (PROJECTROL_VAN_GEBRUIKER)!'
	IF (@TRANCOUNT = 0)
		ROLLBACK TRAN
	ELSE
		ROLLBACK TRAN savepoint;
	THROW;
END CATCH
GO


