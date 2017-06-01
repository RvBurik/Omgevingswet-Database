USE Omgevingswet

--Test 1: Wanneer er 2 adressen aan een gebruiker worden toegevoegd moeten alleen de projecten binnen 1km van deze adressen worden toegevoegd.
BEGIN TRANSACTION
--Testvariabelen
DECLARE @gebruiker VARCHAR(255) = 'Testgebruiker'
DECLARE @adres1 int = 1000
DECLARE @adres2 int = 1001
DECLARE @projectBinnen1 int = 1000
DECLARE @projectBinnen2 int = 1001
DECLARE @projectBuiten1 int = 1002
DECLARE @projectBuiten2 int = 1003
DECLARE @projectBuiten3 int = 1004

--HAN Faculteit Techniek
DECLARE @adres1X float = 5.9509
DECLARE @adres1Y float = 51.9872
--Machineweg, Aalsmeer
DECLARE @adres2X float = 4.7973
DECLARE @adres2Y float = 52.2803
--Park Presikhaaf
DECLARE @projectBinnen1X float = 5.9482
DECLARE @projectBinnen1Y float = 51.9860
--Albert Heijn, Poldermeesterplein 1
DECLARE @projectBinnen2X float = 4.7944
DECLARE @projectBinnen2Y float = 52.2746
--Schiphol Airport
DECLARE @projectBuiten1X float = 4.7647
DECLARE @projectBuiten1Y float = 52.3098
--Arnhem Snackbar West - Ongeveer 1.2km noord-west van HAN.
DECLARE @projectBuiten2X float = 5.9670
DECLARE @projectBuiten2Y float = 51.9925
--Arnhem Bakkerij Veenhuis - Ongeveer 1.2km zuid-oost van HAN
DECLARE @projectBuiten3X float = 5.9405
DECLARE @projectBuiten3Y float = 51.9785

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
WHERE GEBRUIKERSNAAM = 'Testgebruiker' AND PROJECTID = @projectBinnen1)

AND EXISTS (SELECT 1
FROM PROJECTROL_VAN_GEBRUIKER
WHERE GEBRUIKERSNAAM = 'Testgebruiker' AND PROJECTID = @projectBinnen2)

AND NOT EXISTS (SELECT 1
FROM PROJECTROL_VAN_GEBRUIKER
WHERE GEBRUIKERSNAAM = 'Testgebruiker' AND PROJECTID IN (@projectBuiten1, @projectBuiten2, @projectBuiten3))
    PRINT 'Test 1 geslaagd.'
ELSE
    RAISERROR ('Test 1 mislukt.', 16, 1)

ROLLBACK
