-- Testscript voor SP uspBezwaarMaken
SET NOCOUNT ON

-- Succes scenario
go
declare @trancount int = @@trancount;
if (@trancount = 0)
	begin tran
else
	save tran savepoint;
begin try
	-- Aanmaken van enkele randvoorwaarden.
	declare @rol1 varchar(255) = 'CEO';
	declare @vergunningstatus1 varchar(255) = 'Aangevraagd';
	declare @vergunningstatus2 varchar(255) = 'Uitgegeven';
	declare @vergunningstatus3 varchar(255) = 'Bezwaar';
	declare @vergunningsnaam1 varchar(255) = 'Evenementenvergunning';

	insert into ROL (TYPE)
	values (@rol1);

	insert into VERGUNNINGSTATUS (STATUS)
	values (@vergunningstatus1);

	insert into VERGUNNINGSTATUS (STATUS)
	values (@vergunningstatus2);

	insert into VERGUNNINGSTATUS (STATUS)
	values (@vergunningstatus3);

	insert into VERGUNNINGSTYPE (VERGUNNINGSNAAM)
	values (@vergunningsnaam1);

	-- Aanmaken testdata van bezwaarmaker.
	declare @postcode1 varchar(255) = '6951BH';
	declare @huisnummer1 int = 13;
	declare @gebruikersnaam1 varchar(255) = 'dncn';
	declare @wachtwoord1 varchar(255) = 'wachtwoord';
	declare @voornaam1 varchar(255) = 'Duncan';
	declare @achternaam1 varchar(255) = 'Luiten';
	declare @geboortedatum1 date = '1994-10-03';
	declare @geslacht1 char(1) = 'M';
	declare @mailadres1 varchar(255) = 'lyraeduncan@hotmail.com';
	declare @telefoonnummer1 varchar(255) = '0683058120';
	declare @bezwaarreden1 varchar(4000) = 'Testbezwaar';
	
	/*
	insert into ADRESGEGEVENS (POSTCODE, HUISNUMMER)
	values (@postcode1, @huisnummer1);

	declare @adresid1 int scope_identity();
	*/
	insert into GEBRUIKER (GEBRUIKERSNAAM, WACHTWOORD, VOORNAAM, ACHTERNAAM, GEBOORTEDATUM, GESLACHT, MAILADRES)
	values (@gebruikersnaam1, @wachtwoord1, @voornaam1, @achternaam1, @geboortedatum1, @geslacht1, @mailadres1);
	/*
	insert into ADRES_VAN_GEBRUIKER (GEBRUIKERSNAAM, ADRESID)
	values (@gebruikersnaam1, @adresid1);
	
	insert into TELEFOON (TELEFOONNUMMER)
	values (@telefoonnummer1);

	insert into GEBRUIKERTEL (GEBRUIKERSNAAM, TELEFOONNUMMER)
	values (@gebruikersnaam1, @telefoonnummer1);
	*/

	-- Aanmaken testdata van werknemer van testbedrijf.
	declare @postcode2 varchar(255) = '1234AA';
	declare @huisnummer2 int = 2;
	declare @gebruikersnaam2 varchar(255) = 'testaccount';
	declare @wachtwoord2 varchar(255) = 'wachtwoord';
	declare @voornaam2 varchar(255) = 'Test';
	declare @achternaam2 varchar(255) = 'Account';
	declare @geboortedatum2 date = '1990-01-01';
	declare @geslacht2 char(1) = 'O';
	declare @mailadres2 varchar(255) = 'test@account.nl';
	declare @telefoonnummer2 varchar(255) = '0612345678';
	/*
	insert into ADRESGEGEVENS (POSTCODE, HUISNUMMER)
	values (@postcode2, @huisnummer2);

	declare @adresid2 int = scope_identity();
	*/
	insert into GEBRUIKER (GEBRUIKERSNAAM, WACHTWOORD, VOORNAAM, ACHTERNAAM, GEBOORTEDATUM, GESLACHT, MAILADRES)
	values (@gebruikersnaam2, @wachtwoord2, @voornaam2, @achternaam2, @geboortedatum2, @geslacht2, @mailadres2);

	/*
	insert into ADRES_VAN_GEBRUIKER (GEBRUIKERSNAAM, ADRESID)
	values (@gebruikersnaam2, @adresid2);
	
	insert into TELEFOON (TELEFOONNUMMER)
	values (@telefoonnummer2);

	insert into GEBRUIKERTEL (GEBRUIKERSNAAM, TELEFOONNUMMER)
	values (@gebruikersnaam2, @telefoonnummer3);
	*/

	-- Aanmaken testdata van bedrijf met werknemer(s).
	declare @postcode3 varchar(255) = '1111BB';
	declare @huisnummer3 int = 1337;
	declare @kvknummer3 int = 12345678;
	declare @bedrijfsnaam3 varchar(255) = 'DatabaseFactory5';
	declare @bedrijfswachtwoord3 varchar(255) = 'wachtwoord';
	declare @telefoonnummer3 varchar(255) = '0611111111';
	
	insert into ADRESGEGEVENS (POSTCODE, HUISNUMMER)
	values (@postcode3, @huisnummer3);

	declare @adresid3 int = scope_identity();

	insert into BEDRIJF (KVKNUMMER, ADRESID, BEDRIJFSNAAM, BEDRIJFSWACHTWOORD)
	values (@kvknummer3, @adresid3, @bedrijfsnaam3, @bedrijfswachtwoord3);

	/*
	insert into TELEFOON (TELEFOONNUMMER)
	values (@telefoonnummer3);

	insert into TELEFOON_VAN_BEDRIJF (KVKNUMMER, TELEFOONNUMMER)
	values (@kvknummer3, @telefoonnummer3);
	*/

	insert into WERKNEMER (GEBRUIKERSNAAM, KVKNUMMER, TYPE)
	values (@gebruikersnaam2, @kvknummer3, @rol1);

	-- Aanmaken testdata van project en vergunning waarop bezwaar gemaakt wordt.
	declare @aangemaaktop date = getdate();
	declare @werkzaamheid varchar(4000) = 'Dit is een testwerkzaamheid.';
	declare @xcoordinaat float = 12.15468;
	declare @ycoordinaat float = 12.6875213;

	declare @uitleg varchar(4000) = 'Dit bestand is aangemaakt om de software te testen.';
	declare @datum date = getdate();
	declare @locatie varchar(4000) = 'C:\TEST';

	declare @testvergunningstatus varchar(255) = 'Uitgegeven';
	declare @omschrijving varchar(4000) = 'Vergunningsomschrijving';
	declare @datumaanvraag date = getdate();
	declare @datumuitgave date = dateadd(day, 1, getdate());

	insert into PROJECT (KVKNUMMER, GEBRUIKERSNAAM, AANGEMAAKTOP, WERKZAAMHEID, XCOORDINAAT, YCOORDINAAT)
	values (@kvknummer3, @gebruikersnaam2, @aangemaaktop, @werkzaamheid, @xcoordinaat, @ycoordinaat);

	declare @projectid3 int = scope_identity();

	insert into VERGUNNINGSINFORMATIE (PROJECTID, VOLGNUMMER, GEBRUIKERSNAAM, UITLEG, DATUM, LOCATIE)
	values (@projectid3, 1, @gebruikersnaam2, @uitleg, @datum, @locatie);

	insert into VERGUNNING (VERGUNNINGSNAAM, STATUS, PROJECTID, OMSCHRIJVING, DATUMAANVRAAG, DATUMUITGAVE)
	values (@vergunningsnaam1, @testvergunningstatus, @projectid3, @omschrijving , @datumaanvraag, @datumuitgave);

	declare @vergunningsid1 int = scope_identity();

	exec uspBezwaarMaken
		@gebruikersnaam = @gebruikersnaam1,
		@vergunningsid = @vergunningsid1,
		@bezwaarreden = @bezwaarreden1;

	print 'Test 1 is geslaagd.';
	if (@trancount = 0)
		rollback tran
	else
		rollback tran savepoint;
end try

begin catch
	if (@trancount = 0)
		rollback tran
	else
		rollback tran savepoint;
	print 'Test 1 is gefaald.';
	throw;
end catch
go

-- Faal scenario, bezwaar maken op een vergunning die reeds is verlopen is onmogelijk.
go
declare @trancount int = @@trancount;
if (@trancount = 0)
	begin tran
else
	save tran savepoint;
begin try
	-- Aanmaken van enkele randvoorwaarden.
	declare @rol1 varchar(255) = 'CEO';
	declare @vergunningstatus1 varchar(255) = 'Aangevraagd';
	declare @vergunningstatus2 varchar(255) = 'Uitgegeven';
	declare @vergunningstatus3 varchar(255) = 'Bezwaar';
	declare @vergunningstatus4 varchar(255) = 'Verlopen';
	declare @vergunningsnaam1 varchar(255) = 'Evenementenvergunning';

	insert into ROL (TYPE)
	values (@rol1);

	insert into VERGUNNINGSTATUS (STATUS)
	values (@vergunningstatus1);

	insert into VERGUNNINGSTATUS (STATUS)
	values (@vergunningstatus2);

	insert into VERGUNNINGSTATUS (STATUS)
	values (@vergunningstatus3);

	insert into VERGUNNINGSTATUS (STATUS)
	values (@vergunningstatus4);

	insert into VERGUNNINGSTYPE (VERGUNNINGSNAAM)
	values (@vergunningsnaam1);

	-- Aanmaken testdata van bezwaarmaker.
	declare @postcode1 varchar(255) = '6951BH';
	declare @huisnummer1 int = 13;
	declare @gebruikersnaam1 varchar(255) = 'dncn';
	declare @wachtwoord1 varchar(255) = 'wachtwoord';
	declare @voornaam1 varchar(255) = 'Duncan';
	declare @achternaam1 varchar(255) = 'Luiten';
	declare @geboortedatum1 date = '1994-10-03';
	declare @geslacht1 char(1) = 'M';
	declare @mailadres1 varchar(255) = 'lyraeduncan@hotmail.com';
	declare @telefoonnummer1 varchar(255) = '0683058120';
	declare @bezwaarreden1 varchar(4000) = 'Testbezwaar';
	
	/*
	insert into ADRESGEGEVENS (POSTCODE, HUISNUMMER)
	values (@postcode1, @huisnummer1);

	declare @adresid1 int scope_identity();
	*/
	insert into GEBRUIKER (GEBRUIKERSNAAM, WACHTWOORD, VOORNAAM, ACHTERNAAM, GEBOORTEDATUM, GESLACHT, MAILADRES)
	values (@gebruikersnaam1, @wachtwoord1, @voornaam1, @achternaam1, @geboortedatum1, @geslacht1, @mailadres1);
	/*
	insert into ADRES_VAN_GEBRUIKER (GEBRUIKERSNAAM, ADRESID)
	values (@gebruikersnaam1, @adresid1);
	
	insert into TELEFOON (TELEFOONNUMMER)
	values (@telefoonnummer1);

	insert into GEBRUIKERTEL (GEBRUIKERSNAAM, TELEFOONNUMMER)
	values (@gebruikersnaam1, @telefoonnummer1);
	*/

	-- Aanmaken testdata van werknemer van testbedrijf.
	declare @postcode2 varchar(255) = '1234AA';
	declare @huisnummer2 int = 2;
	declare @gebruikersnaam2 varchar(255) = 'testaccount';
	declare @wachtwoord2 varchar(255) = 'wachtwoord';
	declare @voornaam2 varchar(255) = 'Test';
	declare @achternaam2 varchar(255) = 'Account';
	declare @geboortedatum2 date = '1990-01-01';
	declare @geslacht2 char(1) = 'O';
	declare @mailadres2 varchar(255) = 'test@account.nl';
	declare @telefoonnummer2 varchar(255) = '0612345678';
	/*
	insert into ADRESGEGEVENS (POSTCODE, HUISNUMMER)
	values (@postcode2, @huisnummer2);

	declare @adresid2 int = scope_identity();
	*/
	insert into GEBRUIKER (GEBRUIKERSNAAM, WACHTWOORD, VOORNAAM, ACHTERNAAM, GEBOORTEDATUM, GESLACHT, MAILADRES)
	values (@gebruikersnaam2, @wachtwoord2, @voornaam2, @achternaam2, @geboortedatum2, @geslacht2, @mailadres2);

	/*
	insert into ADRES_VAN_GEBRUIKER (GEBRUIKERSNAAM, ADRESID)
	values (@gebruikersnaam2, @adresid2);
	
	insert into TELEFOON (TELEFOONNUMMER)
	values (@telefoonnummer2);

	insert into GEBRUIKERTEL (GEBRUIKERSNAAM, TELEFOONNUMMER)
	values (@gebruikersnaam2, @telefoonnummer3);
	*/

	-- Aanmaken testdata van bedrijf met werknemer(s).
	declare @postcode3 varchar(255) = '1111BB';
	declare @huisnummer3 int = 1337;
	declare @kvknummer3 int = 12345678;
	declare @bedrijfsnaam3 varchar(255) = 'DatabaseFactory5';
	declare @bedrijfswachtwoord3 varchar(255) = 'wachtwoord';
	declare @telefoonnummer3 varchar(255) = '0611111111';
	
	insert into ADRESGEGEVENS (POSTCODE, HUISNUMMER)
	values (@postcode3, @huisnummer3);

	declare @adresid3 int = scope_identity();

	insert into BEDRIJF (KVKNUMMER, ADRESID, BEDRIJFSNAAM, BEDRIJFSWACHTWOORD)
	values (@kvknummer3, @adresid3, @bedrijfsnaam3, @bedrijfswachtwoord3);

	/*
	insert into TELEFOON (TELEFOONNUMMER)
	values (@telefoonnummer3);

	insert into TELEFOON_VAN_BEDRIJF (KVKNUMMER, TELEFOONNUMMER)
	values (@kvknummer3, @telefoonnummer3);
	*/

	insert into WERKNEMER (GEBRUIKERSNAAM, KVKNUMMER, TYPE)
	values (@gebruikersnaam2, @kvknummer3, @rol1);

	-- Aanmaken testdata van project en vergunning waarop bezwaar gemaakt wordt.
	declare @aangemaaktop date = getdate();
	declare @werkzaamheid varchar(4000) = 'Dit is een testwerkzaamheid.';
	declare @xcoordinaat float = 12.15468;
	declare @ycoordinaat float = 12.6875213;

	declare @uitleg varchar(4000) = 'Dit bestand is aangemaakt om de software te testen.';
	declare @datum date = getdate();
	declare @locatie varchar(4000) = 'C:\TEST';

	declare @testvergunningstatus varchar(255) = 'Verlopen';
	declare @omschrijving varchar(4000) = 'Vergunningsomschrijving';
	declare @datumaanvraag date = getdate();
	declare @datumuitgave date = dateadd(day, 1, getdate());
	declare @datumverloop date = dateadd(day, 2, getdate());

	insert into PROJECT (KVKNUMMER, GEBRUIKERSNAAM, AANGEMAAKTOP, WERKZAAMHEID, XCOORDINAAT, YCOORDINAAT)
	values (@kvknummer3, @gebruikersnaam2, @aangemaaktop, @werkzaamheid, @xcoordinaat, @ycoordinaat);

	declare @projectid3 int = scope_identity();

	insert into VERGUNNINGSINFORMATIE (PROJECTID, VOLGNUMMER, GEBRUIKERSNAAM, UITLEG, DATUM, LOCATIE)
	values (@projectid3, 1, @gebruikersnaam2, @uitleg, @datum, @locatie);

	insert into VERGUNNING (VERGUNNINGSNAAM, STATUS, PROJECTID, OMSCHRIJVING, DATUMAANVRAAG, DATUMUITGAVE, DATUMVERLOOP)
	values (@vergunningsnaam1, @testvergunningstatus, @projectid3, @omschrijving , @datumaanvraag, @datumuitgave, @datumverloop);

	declare @vergunningsid1 int = scope_identity();

	exec uspBezwaarMaken
		@gebruikersnaam = @gebruikersnaam1,
		@vergunningsid = @vergunningsid1,
		@bezwaarreden = @bezwaarreden1;

	print 'Test 2 is gefaald.';
	if (@trancount = 0)
		rollback tran
	else
		rollback tran savepoint;
end try

begin catch
	if (@trancount = 0)
		rollback tran
	else
		rollback tran savepoint;
	print 'Test 2 is geslaagd.';
end catch
go
SET NOCOUNT OFF