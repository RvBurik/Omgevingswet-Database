
--Testvariabelen
DECLARE @gebruiker VARCHAR(255) = 'Testgebruiker'
DECLARE @gebruiker2 VARCHAR(255) = 'Testgebruiker2'
DECLARE @adres1 int = 1000
DECLARE @adres2 int = 1001
DECLARE @adres3 int = 1002
DECLARE @projectBinnen1 int = 1000
DECLARE @projectBinnen2 int = 1001
DECLARE @projectBuiten1 int = 1002
DECLARE @projectBuiten2 int = 1003
DECLARE @projectBuiten3 int = 1004

--HAN Faculteit Techniek (Arnhem)
DECLARE @adres1X float = 5.9509
DECLARE @adres1Y float = 51.9872
--Machineweg, Aalsmeer
DECLARE @adres2X float = 4.7973
DECLARE @adres2Y float = 52.2803
--Winkelcentrum Presikhaaf
DECLARE @adres3X float = 5.9516
DECLARE @adres3Y float = 51.9837
--Park Presikhaaf - Binnen 1km van adres 1 en 3
DECLARE @projectBinnen1X float = 5.9482
DECLARE @projectBinnen1Y float = 51.9860
--Albert Heijn, Poldermeesterplein 1 - Binnen 1km van adres 2
DECLARE @projectBinnen2X float = 4.7944
DECLARE @projectBinnen2Y float = 52.2746
--Schiphol Airport - Buiten 1km van adres 1, 2, 3
DECLARE @projectBuiten1X float = 4.7647
DECLARE @projectBuiten1Y float = 52.3098
--Arnhem Snackbar West - Ongeveer 1.2km noord-west van HAN
DECLARE @projectBuiten2X float = 5.9670
DECLARE @projectBuiten2Y float = 51.9925
--Arnhem Bakkerij Veenhuis - Ongeveer 1.2km zuid-oost van HAN
DECLARE @projectBuiten3X float = 5.9405
DECLARE @projectBuiten3Y float = 51.9785


--Test 1: Wanneer er 2 adressen aan een gebruiker worden toegevoegd moeten alleen de projecten binnen 1km van deze adressen worden toegevoegd.
BEGIN TRANSACTION

--Maak testdata
EXEC spTestInsertParticulier @gebruiker, NULL, NULL, NULL, NULL, NULL, NULL, NULL
EXEC spTestInsertAdresgegevens @adres1, NULL, NULL, NULL, @adres1X, @adres1Y
EXEC spTestInsertAdresgegevens @adres2, NULL, NULL, NULL, @adres2X, @adres2Y
EXEC spTestInsertProject @projectBinnen1, NULL, NULL, NULL, @projectBinnen1X, @projectBinnen1Y
EXEC spTestInsertProject @projectBinnen2, NULL, NULL, NULL, @projectBinnen2X, @projectBinnen2Y
EXEC spTestInsertProject @projectBuiten1, NULL, NULL, NULL, @projectBuiten1X, @projectBuiten1Y
EXEC spTestInsertProject @projectBuiten2, NULL, NULL, NULL, @projectBuiten2X, @projectBuiten2Y
EXEC spTestInsertProject @projectBuiten3, NULL, NULL, NULL, @projectBuiten3X, @projectBuiten3Y

--Voer de insert + trigger uit
INSERT INTO ADRES_VAN_GEBRUIKER (ADRESID, GEBRUIKERSNAAM)
  VALUES (@adres1, @gebruiker), (@adres2, @gebruiker)

--Test of de trigger geslaagd is
IF EXISTS (SELECT 1
FROM PROJECTROL_VAN_GEBRUIKER
WHERE GEBRUIKERSNAAM = @gebruiker AND PROJECTID = @projectBinnen1)

AND EXISTS (SELECT 1
FROM PROJECTROL_VAN_GEBRUIKER
WHERE GEBRUIKERSNAAM = @gebruiker AND PROJECTID = @projectBinnen2)

AND NOT EXISTS (SELECT 1
FROM PROJECTROL_VAN_GEBRUIKER
WHERE GEBRUIKERSNAAM = @gebruiker AND PROJECTID IN (@projectBuiten1, @projectBuiten2, @projectBuiten3))
  PRINT 'Test 1 geslaagd.'
ELSE
  RAISERROR ('Test 1 mislukt.', 16, 1)

ROLLBACK


--Test 2: Wanneer er 3 adressen aan een gebruiker worden toegevoegd waarvan er 2 worden verwijderd, moeten de projecten
--binnen 1km van de verwijderde adressen die niet binnen 1km van de andere adressen liggen worden verwijderd.
BEGIN TRANSACTION

--Maak testdata
EXEC spTestInsertParticulier @gebruiker, NULL, NULL, NULL, NULL, NULL, NULL, NULL
EXEC spTestInsertAdresgegevens @adres1, NULL, NULL, NULL, @adres1X, @adres1Y
EXEC spTestInsertAdresgegevens @adres2, NULL, NULL, NULL, @adres2X, @adres2Y
EXEC spTestInsertAdresgegevens @adres3, NULL, NULL, NULL, @adres3X, @adres3Y
EXEC spTestInsertProject @projectBinnen1, NULL, NULL, NULL, @projectBinnen1X, @projectBinnen1Y
EXEC spTestInsertProject @projectBinnen2, NULL, NULL, NULL, @projectBinnen2X, @projectBinnen2Y

--Voer de insert + trigger uit
INSERT INTO ADRES_VAN_GEBRUIKER (ADRESID, GEBRUIKERSNAAM)
  VALUES (@adres1, @gebruiker), (@adres2, @gebruiker), (@adres3, @gebruiker)

--Voer de delete + trigger uit
DELETE FROM ADRES_VAN_GEBRUIKER WHERE ADRESID = @adres1 OR ADRESID = @adres2

--Test of de trigger geslaagd is.
--Project 2 lag binnen alleen het verwijderde adres 2 en moet dus verwijderd zijn.
IF NOT EXISTS (
    SELECT 1
    FROM PROJECTROL_VAN_GEBRUIKER
    WHERE GEBRUIKERSNAAM = @gebruiker AND PROJECTID = @projectBinnen2)
--Project 1 lag binnen het verwijderde adres 1, maar ook binnen het niet-verwijderde adres 3 en moet dus niet verwijderd zijn.
AND EXISTS (
    SELECT 1
    FROM PROJECTROL_VAN_GEBRUIKER
    WHERE GEBRUIKERSNAAM = @gebruiker AND PROJECTID = @projectBinnen1
)
    PRINT 'Test 2 geslaagd.'
ELSE
    RAISERROR ('Test 2 mislukt.', 16, 1)

ROLLBACK


--Test 3: Wanneer er 3 adressen aan een gebruiker worden toegevoegd waarvan er 2 worden verwijderd, mogen de handmatig
--toegevoegde projecten binnen 1km van de verwijderde adressen niet worden verwijderd.
BEGIN TRANSACTION

--Maak testdata
EXEC spTestInsertParticulier @gebruiker, NULL, NULL, NULL, NULL, NULL, NULL, NULL
EXEC spTestInsertAdresgegevens @adres1, NULL, NULL, NULL, @adres1X, @adres1Y
EXEC spTestInsertAdresgegevens @adres2, NULL, NULL, NULL, @adres2X, @adres2Y
EXEC spTestInsertAdresgegevens @adres3, NULL, NULL, NULL, @adres3X, @adres3Y
EXEC spTestInsertProject @projectBinnen1, NULL, NULL, NULL, @projectBinnen1X, @projectBinnen1Y
EXEC spTestInsertProject @projectBinnen2, NULL, NULL, NULL, @projectBinnen2X, @projectBinnen2Y

--Voer de insert + trigger uit
INSERT INTO ADRES_VAN_GEBRUIKER (ADRESID, GEBRUIKERSNAAM)
  VALUES (@adres1, @gebruiker), (@adres2, @gebruiker)

--Maak de abonnementen "handmatig" toegevoegd.
UPDATE PROJECTROL_VAN_GEBRUIKER
SET AUTOMATISCHTOEGEVOEGD = 0
WHERE GEBRUIKERSNAAM = @gebruiker

--Voer de delete + trigger uit
DELETE FROM ADRES_VAN_GEBRUIKER WHERE ADRESID = @adres1 OR ADRESID = @adres2

--Test of de trigger geslaagd is.
--Project 2 lag binnen alleen het verwijderde adres 2, maar mag niet verwijderd worden.
IF EXISTS (
  SELECT 1
  FROM PROJECTROL_VAN_GEBRUIKER
  WHERE GEBRUIKERSNAAM = @gebruiker AND PROJECTID = @projectBinnen2)
--Project 1 lag binnen het verwijderde adres 1, maar ook binnen het niet-verwijderde adres 3 en moet dus niet verwijderd zijn.
AND EXISTS (
  SELECT 1
  FROM PROJECTROL_VAN_GEBRUIKER
  WHERE GEBRUIKERSNAAM = @gebruiker AND PROJECTID = @projectBinnen1
)
  PRINT 'Test 3 geslaagd.'
ELSE
  RAISERROR ('Test 3 mislukt.', 16, 1)

ROLLBACK

--Test 4: Wanneer er 2 adressen via een update aan een gebruiker worden toegevoegd, moet er geabonneerd worden op de
--projecten binnen 1km van deze "nieuwe" adressen.
BEGIN TRANSACTION

--Maak testdata
EXEC spTestInsertParticulier @gebruiker, NULL, NULL, NULL, NULL, NULL, NULL, NULL
EXEC spTestInsertParticulier @gebruiker2, NULL, NULL, NULL, NULL, NULL, NULL, NULL
EXEC spTestInsertAdresgegevens @adres1, NULL, NULL, NULL, @adres1X, @adres1Y
EXEC spTestInsertAdresgegevens @adres2, NULL, NULL, NULL, @adres2X, @adres2Y
EXEC spTestInsertProject @projectBinnen1, NULL, NULL, NULL, @projectBinnen1X, @projectBinnen1Y
EXEC spTestInsertProject @projectBinnen2, NULL, NULL, NULL, @projectBinnen2X, @projectBinnen2Y
EXEC spTestInsertProject @projectBuiten1, NULL, NULL, NULL, @projectBuiten1X, @projectBuiten1Y
EXEC spTestInsertProject @projectBuiten2, NULL, NULL, NULL, @projectBuiten2X, @projectBuiten2Y
EXEC spTestInsertProject @projectBuiten3, NULL, NULL, NULL, @projectBuiten3X, @projectBuiten3Y

--Voer de insert + trigger uit
INSERT INTO ADRES_VAN_GEBRUIKER (ADRESID, GEBRUIKERSNAAM)
  VALUES (@adres1, @gebruiker2), (@adres2, @gebruiker2)

--Voer de update + trigger uit
UPDATE ADRES_VAN_GEBRUIKER
SET GEBRUIKERSNAAM = @gebruiker
WHERE ADRESID = @adres1
  OR  ADRESID = @adres2

--Test of de trigger geslaagd is
IF EXISTS (SELECT 1
FROM PROJECTROL_VAN_GEBRUIKER
WHERE GEBRUIKERSNAAM = @gebruiker AND PROJECTID = @projectBinnen1)

AND EXISTS (SELECT 1
FROM PROJECTROL_VAN_GEBRUIKER
WHERE GEBRUIKERSNAAM = @gebruiker AND PROJECTID = @projectBinnen2)

AND NOT EXISTS (SELECT 1
FROM PROJECTROL_VAN_GEBRUIKER
WHERE GEBRUIKERSNAAM = @gebruiker AND PROJECTID IN (@projectBuiten1, @projectBuiten2, @projectBuiten3))
  PRINT 'Test 4 geslaagd.'
ELSE
  RAISERROR ('Test 4 mislukt.', 16, 1)

ROLLBACK


--Test 5: Wanneer er 3 adressen aan een gebruiker worden toegevoegd waarvan er 2 via een update worden "verwijderd", moeten
--de projecten binnen 1km van de verwijderde adressen die niet binnen 1km van de andere adressen liggen worden verwijderd.
BEGIN TRANSACTION

--Maak testdata
EXEC spTestInsertParticulier @gebruiker, NULL, NULL, NULL, NULL, NULL, NULL, NULL
EXEC spTestInsertParticulier @gebruiker2, NULL, NULL, NULL, NULL, NULL, NULL, NULL
EXEC spTestInsertAdresgegevens @adres1, NULL, NULL, NULL, @adres1X, @adres1Y
EXEC spTestInsertAdresgegevens @adres2, NULL, NULL, NULL, @adres2X, @adres2Y
EXEC spTestInsertAdresgegevens @adres3, NULL, NULL, NULL, @adres3X, @adres3Y
EXEC spTestInsertProject @projectBinnen1, NULL, NULL, NULL, @projectBinnen1X, @projectBinnen1Y
EXEC spTestInsertProject @projectBinnen2, NULL, NULL, NULL, @projectBinnen2X, @projectBinnen2Y

--Voer de insert + trigger uit
INSERT INTO ADRES_VAN_GEBRUIKER (ADRESID, GEBRUIKERSNAAM)
  VALUES (@adres1, @gebruiker), (@adres2, @gebruiker), (@adres3, @gebruiker)

--Voer de update + trigger uit
UPDATE ADRES_VAN_GEBRUIKER
SET GEBRUIKERSNAAM = @gebruiker2
WHERE ADRESID = @adres1
  OR  ADRESID = @adres2

--Test of de trigger geslaagd is.
--Project 2 lag binnen alleen het verwijderde adres 2 en moet dus verwijderd zijn.
IF NOT EXISTS (
    SELECT 1
    FROM PROJECTROL_VAN_GEBRUIKER
    WHERE GEBRUIKERSNAAM = @gebruiker AND PROJECTID = @projectBinnen2)
--Project 1 lag binnen het verwijderde adres 1, maar ook binnen het niet-verwijderde adres 3 en moet dus niet verwijderd zijn.
AND EXISTS (
    SELECT 1
    FROM PROJECTROL_VAN_GEBRUIKER
    WHERE GEBRUIKERSNAAM = @gebruiker AND PROJECTID = @projectBinnen1
)
    PRINT 'Test 5 geslaagd.'
ELSE
    RAISERROR ('Test 5 mislukt.', 16, 1)

ROLLBACK


--Test 6: Wanneer de locaties van 2 adressen bijgewerkt worden, moeten de projecten hierbuiten worden verwijderd, en de
--projecten daarbinnen worden toegevoegd.
BEGIN TRANSACTION

--Maak testdata
EXEC spTestInsertParticulier @gebruiker, NULL, NULL, NULL, NULL, NULL, NULL, NULL
EXEC spTestInsertAdresgegevens @adres1, NULL, NULL, NULL, @adres1X, @adres1Y
EXEC spTestInsertAdresgegevens @adres2, NULL, NULL, NULL, @adres2X, @adres2Y
EXEC spTestInsertProject @projectBinnen1, NULL, NULL, NULL, @projectBinnen1X, @projectBinnen1Y
EXEC spTestInsertProject @projectBinnen2, NULL, NULL, NULL, @projectBinnen2X, @projectBinnen2Y
EXEC spTestInsertProject @projectBuiten1, NULL, NULL, NULL, @projectBuiten1X, @projectBuiten1Y
EXEC spTestInsertProject @projectBuiten2, NULL, NULL, NULL, @projectBuiten2X, @projectBuiten2Y

--Voer de insert + trigger uit
INSERT INTO ADRES_VAN_GEBRUIKER (ADRESID, GEBRUIKERSNAAM)
  VALUES (@adres1, @gebruiker), (@adres2, @gebruiker)

--Voer de update + trigger uit
UPDATE ADRESGEGEVENS
SET XCOORDINAAT = @projectBuiten1X, YCOORDINAAT = @projectBuiten1Y
WHERE ADRESID = @adres1
UPDATE ADRESGEGEVENS
SET XCOORDINAAT = @projectBuiten2X, YCOORDINAAT = @projectBuiten2Y
WHERE ADRESID = @adres2

--Test of de trigger geslaagd is
IF EXISTS (SELECT 1
FROM PROJECTROL_VAN_GEBRUIKER
WHERE GEBRUIKERSNAAM = @gebruiker AND PROJECTID = @projectBuiten1)

AND EXISTS (SELECT 1
FROM PROJECTROL_VAN_GEBRUIKER
WHERE GEBRUIKERSNAAM = @gebruiker AND PROJECTID = @projectBuiten2)

AND NOT EXISTS (SELECT 1
FROM PROJECTROL_VAN_GEBRUIKER
WHERE GEBRUIKERSNAAM = @gebruiker AND PROJECTID IN (@projectBinnen1, @projectBinnen2))
  PRINT 'Test 6 geslaagd.'
ELSE
  RAISERROR ('Test 6 mislukt.', 16, 1)

ROLLBACK