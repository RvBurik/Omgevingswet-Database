IF EXISTS (SELECT * FROM sys.procedures WHERE name = 'spTestInsertGebruiker') BEGIN
	DROP PROCEDURE spTestInsertGebruiker
END
go

CREATE PROCEDURE spTestInsertGebruiker
  @gebruikersnaam VARCHAR(255),
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
        WHEN 0 THEN 'F'
      END
    IF (@mailadres IS NULL)
      SET @mailadres = 'test' + CAST(@row AS VARCHAR) + '@mail.net'
    INSERT INTO GEBRUIKER (GEBRUIKERSNAAM, WACHTWOORD, VOORNAAM, TUSSENVOEGSEL, ACHTERNAAM, GEBOORTEDATUM, GESLACHT, MAILADRES)
      VALUES (@gebruikersnaam, @wachtwoord, @voornaam, @tussenvoegsel, @achternaam, @geboortedatum, @geslacht, @mailadres)
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
  @adresid        INTEGER,
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
      SET @postcode = RIGHT('0000' + CAST((@maxid % 1000) AS VARCHAR(4)), 4) + CHAR(65 + (@maxid / 1000) / 26) + CHAR(65 + (@maxid / 1000) % 26)
    IF (@huisnummer IS NULL)
      SET @huisnummer = @maxid % 100
    IF (@xcoordinaat IS NULL)
      SET @xcoordinaat = @maxid + 50
    IF (@ycoordinaat IS NULL)
      SET @ycoordinaat = @maxid + 150
    SET IDENTITY_INSERT ADRESGEGEVENS ON
    INSERT INTO ADRESGEGEVENS (ADRESID, POSTCODE, HUISNUMMER, TOEVOEGING, XCOORDINAAT, YCOORDINAAT)
      VALUES (@adresid, @postcode, @huisnummer, @toevoeging, @xcoordinaat, @ycoordinaat)
    SET IDENTITY_INSERT ADRESGEGEVENS OFF
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


BEGIN TRANSACTION
EXEC spTestInsertAdresgegevens NULL, NULL, NULL, NULL, NULL, NULL
EXEC spTestInsertAdresgegevens NULL, NULL, NULL, NULL, NULL, NULL
EXEC spTestInsertAdresgegevens NULL, NULL, NULL, NULL, NULL, NULL
SELECT * FROM ADRESGEGEVENS
ROLLBACK TRANSACTION

DECLARE @getal INT
SET @getal = 200000
WHILE @getal > 0 BEGIN
  EXEC spTestInsertAdresgegevens NULL, NULL, NULL, NULL, NULL, NULL
  SET @getal = @getal - 1
END

DELETE FROM ADRESGEGEVENS
/*EXEC spTestInsertGebruiker 'Michiel', NULL, NULL, NULL, NULL, NULL, 'M', 'michiel@bos.net'
EXEC spTestInsertGebruiker NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL
EXEC spTestInsertGebruiker NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL
EXEC spTestInsertGebruiker NULL, NULL, NULL, NULL, NULL, '2001-05-06', NULL, NULL
EXEC spTestInsertGebruiker NULL, NULL, 'Peter', 'van', 'Pan', NULL, NULL, NULL
SELECT * FROM GEBRUIKER*/