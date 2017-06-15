-- Testscript voor SP uspBezwaarMaken met multiple inserts.
SET NOCOUNT ON

-- Create function met het gehele voortraject.
go
create procedure testprocedure
@testvergunningstatus varchar(255),
@datumaanvraag date,
@datumuitgave date,
@datumverloop date,
@datumaanvraag2 date,
@datumuitgave2 date,
@datumverloop2 date
as begin
	-- Aanmaken van enkele randvoorwaarden.
	declare @rol1 varchar(255) = 'CEO';
	declare @vergunningstatus1 varchar(255) = 'Aangevraagd';
	declare @vergunningstatus2 varchar(255) = 'Uitgegeven';
	declare @vergunningstatus3 varchar(255) = 'Bezwaar';
	declare @vergunningstatus4 varchar(255) = 'Afgewezen';
	declare @vergunningstatus5 varchar(255) = 'Verlopen';
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

	insert into VERGUNNINGSTATUS (STATUS)
	values (@vergunningstatus5);

	insert into VERGUNNINGSTYPE (VERGUNNINGSNAAM)
	values (@vergunningsnaam1);

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

	-- Aanmaken testdata van project en vergunning.
	declare @aangemaaktop date = getdate();
	declare @werkzaamheid varchar(4000) = 'Dit is een testwerkzaamheid.';
	declare @xcoordinaat float = 12.15468;
	declare @ycoordinaat float = 12.6875213;

	declare @uitleg varchar(4000) = 'Dit bestand is aangemaakt om de software te testen.';
	declare @datum date = getdate();
	declare @locatie varchar(4000) = 'C:\TEST';

	declare @omschrijving varchar(4000) = 'Vergunningsomschrijving';

	insert into PROJECT (KVKNUMMER, GEBRUIKERSNAAM, AANGEMAAKTOP, WERKZAAMHEID, XCOORDINAAT, YCOORDINAAT)
	values (@kvknummer3, @gebruikersnaam2, @aangemaaktop, @werkzaamheid, @xcoordinaat, @ycoordinaat);

	declare @projectid3 int = scope_identity();

	insert into VERGUNNINGSINFORMATIE (PROJECTID, VOLGNUMMER, GEBRUIKERSNAAM, UITLEG, DATUM, LOCATIE)
	values (@projectid3, 1, @gebruikersnaam2, @uitleg, @datum, @locatie);

	insert into VERGUNNING (VERGUNNINGSNAAM, STATUS, PROJECTID, OMSCHRIJVING, DATUMAANVRAAG, DATUMUITGAVE, DATUMVERLOOP) values
	(@vergunningsnaam1, @testvergunningstatus, @projectid3, @omschrijving, @datumaanvraag, @datumuitgave, @datumverloop),
	(@vergunningsnaam1, @testvergunningstatus, @projectid3, @omschrijving, @datumaanvraag2, @datumuitgave2, @datumverloop2);
end
go

-- Succes scenario, twee toegestane inserts
go
declare @trancount int = @@trancount;
if (@trancount = 0)
	begin tran
else
	save tran savepoint;
begin try
	exec testprocedure
		@testvergunningstatus = 'Uitgegeven',
		@datumaanvraag = '2017-05-17',
		@datumuitgave = '2017-05-18',
		@datumverloop = '2017-05-19',
		@datumaanvraag2 = '2017-05-17',
		@datumuitgave2 = '2017-05-20',
		@datumverloop2 = '2017-05-21';

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

-- Faal scenario, één toegestane insert, één niet toegestane
go
declare @trancount int = @@trancount;
if (@trancount = 0)
	begin tran
else
	save tran savepoint;
begin try
	exec testprocedure
		@testvergunningstatus = 'Uitgegeven',
		@datumaanvraag = '2017-05-17',
		@datumuitgave = '2017-05-18',
		@datumverloop = '2017-05-19',
		@datumaanvraag2 = '2017-05-17',
		@datumuitgave2 = '2017-05-15',
		@datumverloop2 = '2017-05-16';

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

-- Faal scenario, twee niet toegestane inserts
go
declare @trancount int = @@trancount;
if (@trancount = 0)
	begin tran
else
	save tran savepoint;
begin try
	exec testprocedure
		@testvergunningstatus = 'Uitgegeven',
		@datumaanvraag = '2017-05-17',
		@datumuitgave = '2017-05-15',
		@datumverloop = '2017-05-16',
		@datumaanvraag2 = '2017-05-17',
		@datumuitgave2 = '2017-05-21',
		@datumverloop2 = '2017-05-20';

	print 'Test 3 is gefaald.';
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
	print 'Test 3 is geslaagd.';
end catch
go

IF EXISTS (SELECT * FROM sys.procedures WHERE name = 'testprocedure') BEGIN
	DROP PROCEDURE testprocedure
END
go


SET NOCOUNT OFF