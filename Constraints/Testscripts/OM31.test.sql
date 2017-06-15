-- Testscript voor SP uspBezwaarMaken
SET NOCOUNT ON

-- Create function met het gehele voortraject.
go
create procedure testprocedure
@testvergunningstatus varchar(255),
@datumaanvraag date,
@datumuitgave date,
@datumverloop date
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

	insert into VERGUNNING (VERGUNNINGSNAAM, STATUS, PROJECTID, OMSCHRIJVING, DATUMAANVRAAG, DATUMUITGAVE, DATUMVERLOOP)
	values (@vergunningsnaam1, @testvergunningstatus, @projectid3, @omschrijving , @datumaanvraag, @datumuitgave, @datumverloop);
end
go

-- Succes scenario - vergunning aangevraagd, alleen datumaanvraag ingevuld.
go
declare @trancount int = @@trancount;
if (@trancount = 0)
	begin tran
else
	save tran savepoint;
begin try
	exec testprocedure
		@testvergunningstatus = 'Aangevraagd',
		@datumaanvraag = '2017-05-17',
		@datumuitgave = null,
		@datumverloop = null;

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

-- Faal scenario - vergunning aangevraagd, zowel datumaanvraag als datumuitgave ingevuld.
go
declare @trancount int = @@trancount;
if (@trancount = 0)
	begin tran
else
	save tran savepoint;
begin try
	exec testprocedure
		@testvergunningstatus = 'Aangevraagd',
		@datumaanvraag = '2017-05-17',
		@datumuitgave = '2017-05-18',
		@datumverloop = null;

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
	--throw;
	print 'Test 2 is geslaagd.';
end catch
go

-- Faal scenario - vergunning aangevraagd, zowel datumaanvraag als datumverloop ingevuld.
go
declare @trancount int = @@trancount;
if (@trancount = 0)
	begin tran
else
	save tran savepoint;
begin try
	exec testprocedure
		@testvergunningstatus = 'Aangevraagd',
		@datumaanvraag = '2017-05-17',
		@datumuitgave = null,
		@datumverloop = '2017-05-19';

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
	--throw;
	print 'Test 3 is geslaagd.';
end catch
go

-- Faal scenario - vergunning aangevraagd, alles ingevuld.
go
declare @trancount int = @@trancount;
if (@trancount = 0)
	begin tran
else
	save tran savepoint;
begin try
	exec testprocedure
		@testvergunningstatus = 'Aangevraagd',
		@datumaanvraag = '2017-05-17',
		@datumuitgave = '2017-05-18',
		@datumverloop = '2017-05-19';

	print 'Test 4 is gefaald.';
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
	--throw;
	print 'Test 4 is geslaagd.';
end catch
go

-- Succes scenario - vergunning afgewezen, alleen datumuitgave ingevuld.
go
declare @trancount int = @@trancount;
if (@trancount = 0)
	begin tran
else
	save tran savepoint;
begin try
	exec testprocedure
		@testvergunningstatus = 'Afgewezen',
		@datumaanvraag = '2017-05-17',
		@datumuitgave = null,
		@datumverloop = null;

	print 'Test 5 is geslaagd.';
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
	print 'Test 5 is gefaald.';
	throw;
end catch
go

-- Succes scenario, vergunning afgewezen, zowel datumaanvraag als datumuitgave correct ingevuld.
go
declare @trancount int = @@trancount;
if (@trancount = 0)
	begin tran
else
	save tran savepoint;
begin try
	exec testprocedure
		@testvergunningstatus = 'Afgewezen',
		@datumaanvraag = '2017-05-17',
		@datumuitgave = '2017-05-18',
		@datumverloop = null;

	print 'Test 6 is geslaagd.';
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
	print 'Test 6 is gefaald.';
	throw;
end catch
go

-- Faal scenario, vergunning afgewezen, datumuitgave niet ingevuld, datumverloop correct.
go
declare @trancount int = @@trancount;
if (@trancount = 0)
	begin tran
else
	save tran savepoint;
begin try
	exec testprocedure
		@testvergunningstatus = 'Afgewezen',
		@datumaanvraag = '2017-05-17',
		@datumuitgave = null,
		@datumverloop = '2017-05-19';

	print 'Test 7 is gefaald.';
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
	print 'Test 7 is geslaagd.';
end catch
go

-- Succes scenario, vergunning afgewezen, alles correct ingevuld.
go
declare @trancount int = @@trancount;
if (@trancount = 0)
	begin tran
else
	save tran savepoint;
begin try
	exec testprocedure
		@testvergunningstatus = 'Afgewezen',
		@datumaanvraag = '2017-05-17',
		@datumuitgave = '2017-05-18',
		@datumverloop = '2017-05-19';

	print 'Test 8 is geslaagd.';
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
	print 'Test 8 is gefaald.';
	throw;
end catch
go

-- Succes scenario, vergunning afgewezen, datumaanvraag correct ingevuld, datumuitgave incorrect.
go
declare @trancount int = @@trancount;
if (@trancount = 0)
	begin tran
else
	save tran savepoint;
begin try
	exec testprocedure
		@testvergunningstatus = 'Afgewezen',
		@datumaanvraag = '2017-05-17',
		@datumuitgave = '2017-05-15',
		@datumverloop = null;

	print 'Test 9 is gefaald.';
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
	print 'Test 9 is geslaagd.';
end catch
go

-- Faal scenario, vergunning afgewezen, datumuitgave en datumverloop incorrect ingevuld.
go
declare @trancount int = @@trancount;
if (@trancount = 0)
	begin tran
else
	save tran savepoint;
begin try
	exec testprocedure
		@testvergunningstatus = 'Afgewezen',
		@datumaanvraag = '2017-05-17',
		@datumuitgave = '2017-05-15',
		@datumverloop = '2017-05-16';

	print 'Test 10 is gefaald.';
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
	print 'Test 10 is geslaagd.';
end catch
go

-- Faal scenario, vergunning afgewezen, datumuitgave incorrect ingevuld, datumverloop correct.
go
declare @trancount int = @@trancount;
if (@trancount = 0)
	begin tran
else
	save tran savepoint;
begin try
	exec testprocedure
		@testvergunningstatus = 'Afgewezen',
		@datumaanvraag = '2017-05-17',
		@datumuitgave = '2017-05-15',
		@datumverloop = '2017-05-19';

	print 'Test 11 is gefaald.';
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
	print 'Test 11 is geslaagd.';
end catch
go

-- Faal scenario, vergunning afgewezen, datumuitgave en datumverloop incorrect ingevuld.
go
declare @trancount int = @@trancount;
if (@trancount = 0)
	begin tran
else
	save tran savepoint;
begin try
	exec testprocedure
		@testvergunningstatus = 'Afgewezen',
		@datumaanvraag = '2017-05-17',
		@datumuitgave = null,
		@datumverloop = '2017-05-16';

	print 'Test 12 is gefaald.';
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
	print 'Test 12 is geslaagd.';
end catch
go

-- Faal scenario, vergunning afgewezen, datumuitgave correct ingevuld, datumverloop incorrect.
go
declare @trancount int = @@trancount;
if (@trancount = 0)
	begin tran
else
	save tran savepoint;
begin try
	exec testprocedure
		@testvergunningstatus = 'Afgewezen',
		@datumaanvraag = '2017-05-17',
		@datumuitgave = '2017-05-21',
		@datumverloop = '2017-05-20';

	print 'Test 13 is gefaald.';
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
	print 'Test 13 is geslaagd.';
end catch
go

-- Faal scenario, vergunning Afgewezen, datumuitgave correct ingevuld, datumverloop incorrect.
go
declare @trancount int = @@trancount;
if (@trancount = 0)
	begin tran
else
	save tran savepoint;
begin try
	exec testprocedure
		@testvergunningstatus = 'Afgewezen',
		@datumaanvraag = '2017-05-17',
		@datumuitgave = '2017-05-18',
		@datumverloop = '2017-05-16';

	print 'Test 14 is gefaald.';
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
	print 'Test 14 is geslaagd.';
end catch
go

-- Succes scenario, vergunning uitgegeven, datumuitgave en datumverloop correct ingevuld.
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
		@datumverloop = '2017-05-19';

	print 'Test 15 is geslaagd.';
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
	print 'Test 15 is gefaald.';
	throw;
end catch
go

-- Faal scenario, vergunning uitgegeven, datumuitgave incorrect ingevuld, datumverloop correct.
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
		@datumuitgave = null,
		@datumverloop = null;

	print 'Test 16 is gefaald.';
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
	print 'Test 16 is geslaagd.';
end catch
go

-- Succes scenario, vergunning uitgegeven, datumuitgave en datumverloop correct ingevuld.
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
		@datumverloop = null;

	print 'Test 17 is geslaagd.';
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
	print 'Test 17 is gefaald.';
	throw;
end catch
go

-- Faal scenario, vergunning uitgegeven, datumuitgave incorrect ingevuld, datumverloop correct.
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
		@datumuitgave = null,
		@datumverloop = '2017-05-19';

	print 'Test 18 is gefaald.';
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
	print 'Test 18 is geslaagd.';
end catch
go

-- Faal scenario, vergunning uitgegeven, datumuitgave en datumverloop incorrect ingevuld.
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
		@datumverloop = null;

	print 'Test 19 is gefaald.';
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
	print 'Test 19 is geslaagd.';
end catch
go

-- Faal scenario, vergunning uitgegeven, datumuitgave en datumverloop incorrect ingevuld.
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
		@datumuitgave = null,
		@datumverloop = '2017-05-16';

	print 'Test 20 is gefaald.';
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
	print 'Test 20 is geslaagd.';
end catch
go

-- Faal scenario, vergunning uitgegeven, datumuitgave en datumverloop incorrect ingevuld.
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
		@datumverloop = '2017-05-16';

	print 'Test 21 is gefaald.';
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
	print 'Test 21 is geslaagd.';
end catch
go

-- Faal scenario, vergunning uitgegeven, datumuitgave en datumverloop incorrect ingevuld.
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
		@datumverloop = '2017-05-19';

	print 'Test 22 is gefaald.';
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
	print 'Test 22 is geslaagd.';
end catch
go

-- Faal scenario, vergunning uitgegeven, datumuitgave correct ingevuld, datumverloop incorrect.
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
		@datumuitgave = '2017-05-21',
		@datumverloop = '2017-05-20';

	print 'Test 23 is gefaald.';
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
	print 'Test 23 is geslaagd.';
end catch
go

-- Faal scenario, vergunning uitgegeven, datumuitgave correct ingevuld, datumverloop incorrect.
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
		@datumverloop = '2017-05-16';

	print 'Test 24 is gefaald.';
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
	print 'Test 24 is geslaagd.';
end catch
go

-- Succes scenario, vergunning bezwaar, datumuitgave en datumverloop correct ingevuld.
go
declare @trancount int = @@trancount;
if (@trancount = 0)
	begin tran
else
	save tran savepoint;
begin try
	exec testprocedure
		@testvergunningstatus = 'Bezwaar',
		@datumaanvraag = '2017-05-17',
		@datumuitgave = '2017-05-18',
		@datumverloop = '2017-05-19';

	print 'Test 25 is geslaagd.';
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
	print 'Test 25 is gefaald.';
	throw;
end catch
go

-- Faal scenario, vergunning bezwaar, datumuitgave en datumverloop incorrect ingevuld.
go
declare @trancount int = @@trancount;
if (@trancount = 0)
	begin tran
else
	save tran savepoint;
begin try
	exec testprocedure
		@testvergunningstatus = 'Bezwaar',
		@datumaanvraag = '2017-05-17',
		@datumuitgave = null,
		@datumverloop = null;

	print 'Test 26 is gefaald.';
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
	print 'Test 26 is geslaagd.';
end catch
go

-- Succes scenario, vergunning bezwaar, datumuitgave en datumverloop correct ingevuld.
go
declare @trancount int = @@trancount;
if (@trancount = 0)
	begin tran
else
	save tran savepoint;
begin try
	exec testprocedure
		@testvergunningstatus = 'Bezwaar',
		@datumaanvraag = '2017-05-17',
		@datumuitgave = '2017-05-18',
		@datumverloop = null;

	print 'Test 27 is geslaagd.';
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
	print 'Test 27 is gefaald.';
	throw;
end catch
go

-- Faal scenario, vergunning bezwaar, datumuitgave incorrect ingevuld, datumverloop correct.
go
declare @trancount int = @@trancount;
if (@trancount = 0)
	begin tran
else
	save tran savepoint;
begin try
	exec testprocedure
		@testvergunningstatus = 'Bezwaar',
		@datumaanvraag = '2017-05-17',
		@datumuitgave = null,
		@datumverloop = '2017-05-19';

	print 'Test 28 is gefaald.';
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
	print 'Test 28 is geslaagd.';
end catch
go

-- Faal scenario, vergunning bezwaar, datumuitgave incorrect ingevuld, datumverloop correct.
go
declare @trancount int = @@trancount;
if (@trancount = 0)
	begin tran
else
	save tran savepoint;
begin try
	exec testprocedure
		@testvergunningstatus = 'Bezwaar',
		@datumaanvraag = '2017-05-17',
		@datumuitgave = '2017-05-15',
		@datumverloop = null;

	print 'Test 29 is gefaald.';
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
	print 'Test 29 is geslaagd.';
end catch
go

-- Faal scenario, vergunning bezwaar, datumuitgave en datumverloop incorrect ingevuld.
go
declare @trancount int = @@trancount;
if (@trancount = 0)
	begin tran
else
	save tran savepoint;
begin try
	exec testprocedure
		@testvergunningstatus = 'Bezwaar',
		@datumaanvraag = '2017-05-17',
		@datumuitgave = null,
		@datumverloop = '2017-05-16';

	print 'Test 30 is gefaald.';
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
	print 'Test 30 is geslaagd.';
end catch
go

-- Faal scenario, vergunning bezwaar, datumuitgave en datumverloop incorrect ingevuld.
go
declare @trancount int = @@trancount;
if (@trancount = 0)
	begin tran
else
	save tran savepoint;
begin try
	exec testprocedure
		@testvergunningstatus = 'Bezwaar',
		@datumaanvraag = '2017-05-17',
		@datumuitgave = '2017-05-15',
		@datumverloop = '2017-05-16';

	print 'Test 31 is gefaald.';
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
	print 'Test 31 is geslaagd.';
end catch
go

-- Faal scenario, vergunning bezwaar, datumuitgave incorrect ingevuld, datumverloop correct.
go
declare @trancount int = @@trancount;
if (@trancount = 0)
	begin tran
else
	save tran savepoint;
begin try
	exec testprocedure
		@testvergunningstatus = 'Bezwaar',
		@datumaanvraag = '2017-05-17',
		@datumuitgave = '2017-05-15',
		@datumverloop = '2017-05-19';

	print 'Test 32 is gefaald.';
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
	print 'Test 32 is geslaagd.';
end catch
go

-- Faal scenario, vergunning bezwaar, datumuitgave correct ingevuld, datumverloop incorrect.
go
declare @trancount int = @@trancount;
if (@trancount = 0)
	begin tran
else
	save tran savepoint;
begin try
	exec testprocedure
		@testvergunningstatus = 'Bezwaar',
		@datumaanvraag = '2017-05-17',
		@datumuitgave = '2017-05-21',
		@datumverloop = '2017-05-20';

	print 'Test 33 is gefaald.';
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
	print 'Test 33 is geslaagd.';
end catch
go

-- Faal scenario, vergunning bezwaar, datumuitgave correct ingevuld, datumverloop incorrect.
go
declare @trancount int = @@trancount;
if (@trancount = 0)
	begin tran
else
	save tran savepoint;
begin try
	exec testprocedure
		@testvergunningstatus = 'Bezwaar',
		@datumaanvraag = '2017-05-17',
		@datumuitgave = '2017-05-18',
		@datumverloop = '2017-05-16';

	print 'Test 34 is gefaald.';
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
	print 'Test 34 is geslaagd.';
end catch
go

-- Succes scenario, vergunning verlopen, datumuitgave en datumverloop correct ingevuld.
go
declare @trancount int = @@trancount;
if (@trancount = 0)
	begin tran
else
	save tran savepoint;
begin try
	exec testprocedure
		@testvergunningstatus = 'Verlopen',
		@datumaanvraag = '2017-05-17',
		@datumuitgave = '2017-05-18',
		@datumverloop = '2017-05-19';

	print 'Test 35 is geslaagd.';
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
	print 'Test 35 is gefaald.';
	throw;
end catch
go

-- Faal scenario, vergunning verlopen, datumuitgave en datumverloop incorrect ingevuld.
go
declare @trancount int = @@trancount;
if (@trancount = 0)
	begin tran
else
	save tran savepoint;
begin try
	exec testprocedure
		@testvergunningstatus = 'Verlopen',
		@datumaanvraag = '2017-05-17',
		@datumuitgave = null,
		@datumverloop = null;

	print 'Test 36 is gefaald.';
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
	print 'Test 36 is geslaagd.';
end catch
go

-- Succes scenario, vergunning verlopen, datumuitgave en datumverloop correct ingevuld.
go
declare @trancount int = @@trancount;
if (@trancount = 0)
	begin tran
else
	save tran savepoint;
begin try
	exec testprocedure
		@testvergunningstatus = 'Verlopen',
		@datumaanvraag = '2017-05-17',
		@datumuitgave = '2017-05-18',
		@datumverloop = null;

	print 'Test 37 is gefaald.';
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
	print 'Test 37 is geslaagd.';
end catch
go

-- Faal scenario, vergunning verlopen, datumuitgave incorrect ingevuld, datumverloop correct.
go
declare @trancount int = @@trancount;
if (@trancount = 0)
	begin tran
else
	save tran savepoint;
begin try
	exec testprocedure
		@testvergunningstatus = 'Verlopen',
		@datumaanvraag = '2017-05-17',
		@datumuitgave = null,
		@datumverloop = '2017-05-19';

	print 'Test 38 is gefaald.';
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
	print 'Test 38 is geslaagd.';
end catch
go

-- Faal scenario, vergunning verlopen, datumuitgave incorrect ingevuld, datumverloop correct.
go
declare @trancount int = @@trancount;
if (@trancount = 0)
	begin tran
else
	save tran savepoint;
begin try
	exec testprocedure
		@testvergunningstatus = 'Verlopen',
		@datumaanvraag = '2017-05-17',
		@datumuitgave = '2017-05-15',
		@datumverloop = null;

	print 'Test 39 is gefaald.';
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
	print 'Test 39 is geslaagd.';
end catch
go

-- Faal scenario, vergunning verlopen, datumuitgave en datumverloop incorrect ingevuld.
go
declare @trancount int = @@trancount;
if (@trancount = 0)
	begin tran
else
	save tran savepoint;
begin try
	exec testprocedure
		@testvergunningstatus = 'Verlopen',
		@datumaanvraag = '2017-05-17',
		@datumuitgave = null,
		@datumverloop = '2017-05-16';

	print 'Test 40 is gefaald.';
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
	print 'Test 40 is geslaagd.';
end catch
go

-- Faal scenario, vergunning verlopen, datumuitgave en datumverloop incorrect ingevuld.
go
declare @trancount int = @@trancount;
if (@trancount = 0)
	begin tran
else
	save tran savepoint;
begin try
	exec testprocedure
		@testvergunningstatus = 'Verlopen',
		@datumaanvraag = '2017-05-17',
		@datumuitgave = '2017-05-15',
		@datumverloop = '2017-05-16';

	print 'Test 41 is gefaald.';
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
	print 'Test 41 is geslaagd.';
end catch
go

-- Faal scenario, vergunning verlopen, datumuitgave incorrect ingevuld, datumverloop correct.
go
declare @trancount int = @@trancount;
if (@trancount = 0)
	begin tran
else
	save tran savepoint;
begin try
	exec testprocedure
		@testvergunningstatus = 'Verlopen',
		@datumaanvraag = '2017-05-17',
		@datumuitgave = '2017-05-15',
		@datumverloop = '2017-05-19';

	print 'Test 42 is gefaald.';
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
	print 'Test 42 is geslaagd.';
end catch
go

-- Faal scenario, vergunning verlopen, datumuitgave correct ingevuld, datumverloop incorrect.
go
declare @trancount int = @@trancount;
if (@trancount = 0)
	begin tran
else
	save tran savepoint;
begin try
	exec testprocedure
		@testvergunningstatus = 'Verlopen',
		@datumaanvraag = '2017-05-17',
		@datumuitgave = '2017-05-21',
		@datumverloop = '2017-05-20';

	print 'Test 43 is gefaald.';
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
	print 'Test 43 is geslaagd.';
end catch
go

-- Faal scenario, vergunning verlopen, datumuitgave correct ingevuld, datumverloop incorrect.
go
declare @trancount int = @@trancount;
if (@trancount = 0)
	begin tran
else
	save tran savepoint;
begin try
	exec testprocedure
		@testvergunningstatus = 'Verlopen',
		@datumaanvraag = '2017-05-17',
		@datumuitgave = '2017-05-18',
		@datumverloop = '2017-05-16';

	print 'Test 44 is gefaald.';
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
	print 'Test 44 is geslaagd.';
end catch
go



IF EXISTS (SELECT * FROM sys.procedures WHERE name = 'testprocedure') BEGIN
	DROP PROCEDURE testprocedure
END
go


SET NOCOUNT OFF