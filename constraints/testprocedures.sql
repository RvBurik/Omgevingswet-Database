USE Omgevingswet

IF EXISTS (SELECT * FROM sys.procedures WHERE name = 'spTestInsertParticulier') BEGIN
	DROP PROCEDURE spTestInsertParticulier
END
go

CREATE PROCEDURE spTestInsertParticulier
  @gebruikersnaam VARCHAR(255) OUTPUT,
  @wachtwoord     VARCHAR(255),
  @voornaam       VARCHAR(100),
  @tussenvoegsel  VARCHAR(25),
  @achternaam     VARCHAR(255),
  @geboortedatum  DATE,
  @geslacht       CHAR,
  @mailadres      VARCHAR(255)
AS
BEGIN
  DECLARE @trancount INT = @@trancount;
  IF (@trancount = 0)
    BEGIN TRAN
  ELSE
    SAVE TRAN savepoint;
  BEGIN TRY
    DECLARE @row INTEGER
    SELECT  @row = count(*)
    FROM    GEBRUIKER
    IF (@gebruikersnaam IS NULL)
      SET @gebruikersnaam = 'Testgebruiker' + CAST(@row AS VARCHAR)
    IF (@wachtwoord IS NULL)
      SET @wachtwoord = 'Wachtwoord' + CAST(@row AS VARCHAR)
    IF (@voornaam IS NULL)
      SET @voornaam = 'Voornaam' + CAST(@row AS VARCHAR)
    IF (@achternaam IS NULL)
      SET @achternaam = 'Achternaam' + CAST(@row AS VARCHAR)
    IF (@geboortedatum IS NULL) BEGIN
      SET @geboortedatum = DATEADD(day, @row, '1960-01-01')
      if (@geboortedatum > '2000-01-01')
        SET @geboortedatum = '2000-01-01'
    END
    IF (@geslacht IS NULL)
      SET @geslacht = CASE @row % 2
        WHEN 1 THEN 'M'
        WHEN 0 THEN 'V'
      END
    IF (@mailadres IS NULL)
      SET @mailadres = 'test' + CAST(@row AS VARCHAR) + '@mail.net'
    INSERT INTO GEBRUIKER (GEBRUIKERSNAAM, WACHTWOORD, MAILADRES)
      VALUES (@gebruikersnaam, @wachtwoord, @mailadres)
    INSERT INTO PARTICULIER (GEBRUIKERSNAAM, VOORNAAM, TUSSENVOEGSEL, ACHTERNAAM, GEBOORTEDATUM, GESLACHT)
      VALUES (@gebruikersnaam, @voornaam, @tussenvoegsel, @achternaam, @geboortedatum, @geslacht)
    COMMIT TRANSACTION
  END TRY
  BEGIN catch
    IF (@trancount = 0)
      ROLLBACK TRAN
    ELSE
      ROLLBACK TRAN savepoint;
    THROW;
  END CATCH
END
GO


IF EXISTS (SELECT * FROM sys.procedures WHERE name = 'spTestInsertAdresgegevens') BEGIN
	DROP PROCEDURE spTestInsertAdresgegevens
END
go

CREATE PROCEDURE spTestInsertAdresgegevens
  @adresid        INTEGER OUTPUT,
  @postcode       VARCHAR(6),
  @huisnummer     NUMERIC(5),
  @toevoeging     NUMERIC(5),
  @xcoordinaat    FLOAT,
  @ycoordinaat    FLOAT
AS
BEGIN
  DECLARE @trancount INT = @@trancount;
  IF (@trancount = 0)
    BEGIN TRAN
  ELSE
    SAVE TRAN savepoint;
  BEGIN TRY
    DECLARE @maxid INTEGER
    SELECT  @maxid = ISNULL(MAX(ADRESID), 0) + 1
    FROM    ADRESGEGEVENS
    IF (@adresid IS NULL)
      SET @adresid = @maxid
    IF (@postcode IS NULL)
      SET @postcode = RIGHT('0000' + CAST((@adresid % 1000) AS VARCHAR(4)), 4) + CHAR(65 + (@adresid / 1000) / 26) + CHAR(65 + (@adresid / 1000) % 26)
    IF (@huisnummer IS NULL)
      SET @huisnummer = @adresid % 100 + 1
    IF (@xcoordinaat IS NULL)
      SET @xcoordinaat = @adresid + 0.5
    IF (@ycoordinaat IS NULL)
      SET @ycoordinaat = @adresid + 0.15
    SET IDENTITY_INSERT ADRESGEGEVENS ON
    INSERT INTO ADRESGEGEVENS (ADRESID, POSTCODE, HUISNUMMER, TOEVOEGING, XCOORDINAAT, YCOORDINAAT)
      VALUES (@adresid, @postcode, @huisnummer, @toevoeging, @xcoordinaat, @ycoordinaat)
    SET IDENTITY_INSERT ADRESGEGEVENS OFF
    COMMIT TRANSACTION
  END TRY
  BEGIN catch
    IF (@trancount = 0)
      ROLLBACK TRAN
    ELSE
      ROLLBACK TRAN savepoint;
    THROW;
  END CATCH
END
GO


IF EXISTS (SELECT * FROM sys.procedures WHERE name = 'spTestInsertProject') BEGIN
	DROP PROCEDURE spTestInsertProject
END
go

CREATE PROCEDURE spTestInsertProject
  @projectId        INTEGER OUTPUT,
  @projecttitel     VARCHAR(255),
  @aangemaaktOp     DATETIME,
  @werkzaamheid     VARCHAR(4000),
  @xcoordinaat      FLOAT,
  @ycoordinaat      FLOAT
AS
BEGIN
  DECLARE @trancount INT = @@trancount;
  IF (@trancount = 0)
    BEGIN TRAN
  ELSE
    SAVE TRAN savepoint;
  BEGIN TRY
    DECLARE @maxid INTEGER
    SELECT  @maxid = ISNULL(MAX(PROJECTID), 0) + 1
    FROM    PROJECT
    IF (@projectid IS NULL)
      SET @projectid = @maxid
    IF (@projecttitel IS NULL)
      SET @projecttitel = 'Testproject ' + CAST(@projectId AS VARCHAR)
    IF (@aangemaaktOp IS NULL)
      SET @aangemaaktOp = DATEADD(hour, @maxid, '2016-01-01')
      if (@aangemaaktOp > '2017-01-01')
        SET @aangemaaktOp = '2017-01-01'
    IF (@werkzaamheid IS NULL)
      SET @werkzaamheid = 'Dit is een project met id ' + CAST(@projectId AS VARCHAR) + '.'
    IF (@xcoordinaat IS NULL)
      SET @xcoordinaat = @projectid + 0.35
    IF (@ycoordinaat IS NULL)
      SET @ycoordinaat = @projectid + 0.105
    SET IDENTITY_INSERT PROJECT ON
    INSERT INTO PROJECT (PROJECTID, PROJECTTITEL, AANGEMAAKTOP, WERKZAAMHEID, XCOORDINAAT, YCOORDINAAT)
      VALUES (@projectId, @projecttitel, @aangemaaktOp, @werkzaamheid, @xcoordinaat, @ycoordinaat)
    SET IDENTITY_INSERT PROJECT OFF
    COMMIT TRANSACTION
  END TRY
  BEGIN catch
    IF (@trancount = 0)
      ROLLBACK TRAN
    ELSE
      ROLLBACK TRAN savepoint;
    THROW;
  END CATCH
END
GO
