/*
Test data
*/


-- succes
insert into ADRESGEGEVENS (POSTCODE, HUISNUMMER)
values ('6951BH', 13);

-- succes
insert into GEBRUIKER (GEBRUIKERSNAAM, WACHTWOORD, VOORNAAM, ACHTERNAAM, GEBOORTEDATUM, GESLACHT, MAILADRES)
values ('dncn', 'wachtwoord', 'Duncan', 'Luiten', '1994-10-03', 'M', 'lyraeduncan@hotmail.com');

-- faalt vanwege ongeldige geboortedatum (te oud)
insert into GEBRUIKER (GEBRUIKERSNAAM, WACHTWOORD, VOORNAAM, ACHTERNAAM, GEBOORTEDATUM, GESLACHT, MAILADRES)
values ('test', 'wachtwoord', 'test', 'failed', '1894-10-03', 'M', 'test@test.com');

-- faalt vanwege ongeldig geslacht
insert into GEBRUIKER (GEBRUIKERSNAAM, WACHTWOORD, VOORNAAM, ACHTERNAAM, GEBOORTEDATUM, GESLACHT, MAILADRES)
values ('test', 'wachtwoord', 'test', 'failed', '1994-10-03', 'A', 'test@test.com');

-- faalt vanwege ongeldige geb.datum (te jong) -- gaat nog fout, constraint nog niet af
insert into GEBRUIKER (GEBRUIKERSNAAM, WACHTWOORD, VOORNAAM, ACHTERNAAM, GEBOORTEDATUM, GESLACHT, MAILADRES)
values ('test', 'wachtwoord', 'test', 'failed', '2004-10-03', 'M', 'test@test.com');

-- faalt vanwege ongeldige geb.naam (te kort)
insert into GEBRUIKER (GEBRUIKERSNAAM, WACHTWOORD, VOORNAAM, ACHTERNAAM, GEBOORTEDATUM, GESLACHT, MAILADRES)
values ('te', 'wachtwoord', 'test', 'failed', '1994-10-03', 'M', 'test@test.com');

-- select * from adresgegevens where postcode = '6951BH' and huisnummer = 13
-- succes
insert into ADRES_VAN_GEBRUIKER (GEBRUIKERSNAAM, ADRESID)
values ('dncn', 1);

-- succes
insert into TELEFOON (TELEFOONNUMMER)
values ('0683058120');

-- faalt vanwege te kort tel.num
insert into TELEFOON (TELEFOONNUMMER)
values ('0650000');

-- succes
insert into GEBRUIKERTEL (GEBRUIKERSNAAM, TELEFOONNUMMER)
values ('dncn', '0683058120');

-- succes
insert into ADRESGEGEVENS (POSTCODE, HUISNUMMER)
values ('ABCD12', 1);

-- select * from ADRESGEGEVENS where postcode = 'ABCD12' and huisnummer = 1
-- succes
insert into BEDRIJF (KVKNUMMER, ADRESID, BEDRIJFSNAAM, BEDRIJFSWACHTWOORD)
values (12345678, 2, 'DatabaseFactory5', 'Wachtwoord');

-- faalt vanwege ongeldig kvknummer (te kort)
insert into BEDRIJF (KVKNUMMER, ADRESID, BEDRIJFSNAAM, BEDRIJFSWACHTWOORD)
values (12345, 2, 'TestBedrijf', 'Wachtwoord');

-- faalt vanwege ongeldig kvknummer (te lang)
insert into BEDRIJF (KVKNUMMER, ADRESID, BEDRIJFSNAAM, BEDRIJFSWACHTWOORD)
values (123456789, 2, 'TestBedrijf', 'Wachtwoord');

-- succes
insert into TELEFOON (TELEFOONNUMMER)
values ('0612345678');

-- succes
insert into TELEFOON_VAN_BEDRIJF (KVKNUMMER, TELEFOONNUMMER)
values (12345678, '0612345678');

-- succes
insert into ROL (TYPE)
values ('CEO');

-- succes
insert into WERKNEMER (GEBRUIKERSNAAM, KVKNUMMER, TYPE)
values ('dncn', 12345678, 'CEO');

-- succes
insert into VERGUNNINGSTATUS (STATUS)
values ('Aangevraagd');

-- succes
insert into VERGUNNINGSTYPE (VERGUNNINGSNAAM)
values ('Evenementenvergunning');

-- succes
insert into PROJECT (KVKNUMMER, GEBRUIKERSNAAM, AANGEMAAKTOP, WERKZAAMHEID, XCOORDINAAT, YCOORDINAAT)
values (12345678, 'dncn', now(), 'Dit is een testwerkzaamheid.', 12.15468, 12.6875213);

-- select * from project
-- succes
insert into VERGUNNINGSINFORMATIE (PROJECTID, VOLGNUMMER, GEBRUIKERSNAAM, UITLEG, DATUM, LOCATIE)
values (1, 1, 'dncn', 'Dit bestand is aangemaakt om de software te testen.', now(), 'C:\TEST');

-- succes
insert into VERGUNNING (VERGUNNINGSNAAM, STATUS, PROJECTID, OMSCHRIJVING, DATUMAANVRAAG)
values ('Evenementenvergunning', 'Aangevraagd', 1, 'Vergunningsomschrijving.', now());




/*
select * from adres_van_gebruiker
select * from adresgegevens
select * from bedrijf
select * from gebruiker
select * from gebruikertel
select * from project
select * from rol
select * from telefoon
select * from telefoon_van_bedrijf
select * from vergunning
select * from vergunningsinformatie
select * from vergunningstatus
select * from vergunningstype
select * from werknemer
*/