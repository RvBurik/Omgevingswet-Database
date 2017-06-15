IF EXISTS (SELECT * FROM sys.procedures WHERE name = 'procToevoegenVergunningsinformatie') BEGIN
	DROP PROCEDURE procToevoegenVergunningsinformatie
END

go
create procedure procToevoegenVergunningsinformatie
@projectid int,
@gebruikersnaam varchar(255),
@uitleg varchar(4000),
@datum datetime,
@locatie varchar(255)
as begin
	begin try
		declare @volgnummer int;
		select @volgnummer = max(volgnummer) + 1
		from vergunningsinformatie
		where projectid = @projectid;

		if (@volgnummer is null) begin
			select @volgnummer = 1
		end

		if (@datum is null) begin
			select @datum = getdate();
		end

		insert into VERGUNNINGSINFORMATIE (projectid, volgnummer, gebruikersnaam, uitleg, datum, locatie)
		values (@projectid, @volgnummer, @gebruikersnaam, @uitleg, @datum, @locatie);
	end try

	begin catch
		raiserror('Toevoegen van vergunningsinformatie is mislukt.', 16, 1);
		throw;
	end catch
end