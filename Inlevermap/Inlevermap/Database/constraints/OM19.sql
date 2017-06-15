IF EXISTS (SELECT * FROM SYS.TRIGGERS WHERE NAME = 'trgBezwaarMakenVanaf18') BEGIN
	DROP TRIGGER trgBezwaarMakenVanaf18
END
go

create trigger trgBezwaarMakenVanaf18
on Bezwaar
after insert, update
as
begin
	if @@rowcount =0
		return
	begin try
		if exists (
			select 1
			from inserted i inner join gebruiker g on i.GEBRUIKERSNAAM = g.GEBRUIKERSNAAM
			where g.GEBOORTEDATUM > DATEADD(YEAR, -18, getdate())
		) begin
			raiserror('Een gebruiker moet minimaal 18 jaar zijn om bezwaar te kunnen maken.', 16, 1);
		end
	end try
	begin catch
		throw;
	end catch
end
go