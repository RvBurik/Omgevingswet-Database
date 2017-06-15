-- Testscript voor SP trgBezwaarMakenVanaf18
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
	declare @vergunningsnaam1 varchar(255) = 'Evenementenvergunning';

	insert into VERGUNNINGSTATUS (STATUS)
	values (@vergunningstatus1);

	insert into VERGUNNINGSTATUS (STATUS)
	values (@vergunningstatus2);

	insert into VERGUNNINGSTYPE (VERGUNNINGSNAAM)
	values (@vergunningsnaam1);

	-- Aanmaken testdata van bezwaarmaker.
	declare @gebruikersnaam1 varchar(255) = 'dncn';
	declare @geboortedatum1 date = '1994-10-03';
	declare @bezwaarreden1 varchar(4000) = 'Testbezwaar';

	EXEC spTestInsertGebruiker @gebruikersnaam1, NULL, NULL, NULL, NULL, @geboortedatum1, NULL, NULL

	-- Aanmaken testdata van werknemer van testbedrijf.
	declare @gebruikersnaam2 varchar(255) = 'testaccount';
	declare @geboortedatum2 date = '1990-01-01';

	EXEC spTestInsertGebruiker @gebruikersnaam2, NULL, NULL, NULL, NULL, @geboortedatum2, NULL, NULL

	-- Aanmaken testdata van bedrijf met werknemer(s).
	declare @adresid3 int = 5000;
	declare @kvknummer3 int = 12345678;
	declare @bedrijfsnaam3 varchar(255) = 'DatabaseFactory5';
	declare @bedrijfswachtwoord3 varchar(255) = 'wachtwoord';

	EXEC spTestInsertAdresgegevens  @adresid3, NULL, NULL, NULL, NULL, NULL

	/*insert into BEDRIJF (KVKNUMMER, ADRESID, BEDRIJFSNAAM, BEDRIJFSWACHTWOORD)
	values (@kvknummer3, @adresid3, @bedrijfsnaam3, @bedrijfswachtwoord3);

	insert into WERKNEMER (GEBRUIKERSNAAM, KVKNUMMER, TYPE)
	values (@gebruikersnaam2, @kvknummer3, @rol1);*/

	-- Aanmaken testdata van project en vergunning waarop bezwaar gemaakt wordt.
	declare @projectid3 int = 2000;
	declare @uitleg varchar(4000) = 'Dit bestand is aangemaakt om de software te testen.';
	declare @datum date = getdate();
	declare @locatie varchar(4000) = 'C:\TEST';

	declare @testvergunningstatus varchar(255) = 'Uitgegeven';
	declare @omschrijving varchar(4000) = 'Vergunningsomschrijving';
	declare @datumaanvraag date = getdate();

	EXEC spTestInsertProject @projectid3, NULL, NULL, NULL, NULL, NULL

	insert into VERGUNNINGSINFORMATIE (PROJECTID, VOLGNUMMER, GEBRUIKERSNAAM, UITLEG, DATUM, LOCATIE)
	values (@projectid3, 1, @gebruikersnaam2, @uitleg, @datum, @locatie);

	insert into VERGUNNING (VERGUNNINGSNAAM, STATUS, PROJECTID, OMSCHRIJVING, DATUMAANVRAAG)
	values (@vergunningsnaam1, @testvergunningstatus, @projectid3, @omschrijving , @datumaanvraag);

	declare @vergunningsid3 int = scope_identity();

	insert into BEZWAAR (PROJECTID, BEZWAARREDEN, BESLUIT, BESLUITREDEN)
	values (@gebruikersnaam1, @projectid3, @vergunningsid3, @bezwaarreden1);

	print 'Test is geslaagd.';

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
	throw;
	print 'Test is gefaald.';
end catch
go


-- Faal scenario - bezwaar makende gebruiker is te jong.
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
	declare @vergunningsnaam1 varchar(255) = 'Evenementenvergunning';

	insert into ROL (TYPE)
	values (@rol1);

	insert into VERGUNNINGSTATUS (STATUS)
	values (@vergunningstatus1);

	insert into VERGUNNINGSTATUS (STATUS)
	values (@vergunningstatus2);

	insert into VERGUNNINGSTYPE (VERGUNNINGSNAAM)
	values (@vergunningsnaam1);
	
	-- Aanmaken testdata van bezwaarmaker.
	declare @gebruikersnaam1 varchar(255) = 'dncn';
	declare @geboortedatum1 date = dateadd(year, -17, getdate());
	declare @bezwaarreden1 varchar(4000) = 'Testbezwaar';

	EXEC spTestInsertGebruiker @gebruikersnaam1, NULL, NULL, NULL, NULL, @geboortedatum1, NULL, NULL

	-- Aanmaken testdata van werknemer van testbedrijf.
	declare @gebruikersnaam2 varchar(255) = 'testaccount';
	declare @geboortedatum2 date = '1990-01-01';

	EXEC spTestInsertGebruiker @gebruikersnaam2, NULL, NULL, NULL, NULL, @geboortedatum2, NULL, NULL

	-- Aanmaken testdata van bedrijf met werknemer(s).
	declare @adresid3 int = 5001
	declare @kvknummer3 int = 12345678;
	declare @bedrijfsnaam3 varchar(255) = 'DatabaseFactory5';
	declare @bedrijfswachtwoord3 varchar(255) = 'wachtwoord';

	EXEC spTestInsertAdresgegevens  @adresid3, NULL, NULL, NULL, NULL, NULL

	insert into BEDRIJF (KVKNUMMER, ADRESID, BEDRIJFSNAAM, BEDRIJFSWACHTWOORD)
	values (@kvknummer3, @adresid3, @bedrijfsnaam3, @bedrijfswachtwoord3);

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

	insert into PROJECT (KVKNUMMER, GEBRUIKERSNAAM, AANGEMAAKTOP, WERKZAAMHEID, XCOORDINAAT, YCOORDINAAT)
	values (@kvknummer3, @gebruikersnaam2, @aangemaaktop, @werkzaamheid, @xcoordinaat, @ycoordinaat);

	declare @projectid3 int = scope_identity();

	insert into VERGUNNINGSINFORMATIE (PROJECTID, VOLGNUMMER, GEBRUIKERSNAAM, UITLEG, DATUM, LOCATIE)
	values (@projectid3, 1, @gebruikersnaam2, @uitleg, @datum, @locatie);

	insert into VERGUNNING (VERGUNNINGSNAAM, STATUS, PROJECTID, OMSCHRIJVING, DATUMAANVRAAG)
	values (@vergunningsnaam1, @testvergunningstatus, @projectid3, @omschrijving , @datumaanvraag);

	declare @vergunningsid3 int = scope_identity();

	insert into BEZWAAR (GEBRUIKERSNAAM, PROJECTID, VERGUNNINGSID, BEZWAARREDEN)
	values (@gebruikersnaam1, @projectid3, @vergunningsid3, @bezwaarreden1);

	print 'Test is gefaald.';

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
	IF (ERROR_NUMBER() = 50018)
		print 'Test is geslaagd.';
	ELSE
		THROW
end catch
go
SET NOCOUNT OFF