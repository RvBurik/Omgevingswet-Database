
--Constraint ...: Iedere gebruiker moet minimaal één telefoonnummer hebben.
--Test 1: Insert een gebruiker met telefoonnummer.
DECLARE
  aantalGebruikers INTEGER;
  aantalTelefoonnummers INTEGER;
BEGIN
  SP_MAAK_GEBRUIKER ('Testgebruiker', 1, 'Test', 'de', 'Gebruiker', TO_DATE('1913-03-07', 'YYYY-MM-DD'), 'M', 'gebruiker@test.nl', 0310000001);
  SELECT COUNT(GEBRUIKERSNAAM)
  INTO aantalGebruikers
  FROM GEBRUIKER
  WHERE GEBRUIKERSNAAM = 'Testgebruiker'
    AND ADRESID = 1
    AND VOORNAAM = 'Test'
    AND TUSSENVOEGSEL = 'de'
    AND ACHTERNAAM = 'Gebruiker'
    AND GEBOORTEDATUM = TO_DATE('1913-03-07', 'YYYY-MM-DD')
    AND GESLACHT = 'M'
    AND MAILADRES = 'gebruiker@test.nl';
  SELECT COUNT(TELEFOONNUMMER)
  INTO aantalTelefoonnummers
  FROM TELEFOON
  WHERE TELEFOONNUMMER = 0310000001
    AND GEBRUIKERSNAAM = 'Testgebruiker';
  IF aantalGebruikers != 1
    THEN RAISE_APPLICATION_ERROR(-20001, 'SP_MAAK_GEBRUIKER moet een GEBRUIKER rij toevoegen met de opgegeven waarden.');
  END IF;
  IF aantalTelefoonnummers != 1
    THEN RAISE_APPLICATION_ERROR(-20001, 'SP_MAAK_GEBRUIKER moet een TELEFOON rij toevoegen voor de opgegeven gebruiker.');
  END IF;
  ROLLBACK;
END;


--Voor later:
/*BEGIN
  INSERT INTO TESTTABEL (GETAL) VALUES (1/0);
  ROLLBACK;
EXCEPTION  -- exception handlers begin
  WHEN NO_DATA_FOUND THEN  -- handles 'division by zero' error
    INSERT INTO TESTTABEL (GETAL) VALUES (2);
    ROLLBACK ;
  WHEN OTHERS THEN  -- handles all other errors
    RAISE_APPLICATION_ERROR(-20001, 'error testing');
    ROLLBACK;
END;  -- exception handlers and block end here*/