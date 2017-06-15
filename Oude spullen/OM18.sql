IF EXISTS (SELECT * FROM sys.procedures WHERE name = 'uspBezwaarMaken') BEGIN
	DROP PROCEDURE uspBezwaarMaken
END
go

create procedure uspBezwaarMaken
@gebruikersnaam varchar(255),
@vergunningsid int,
@bezwaarreden varchar(4000)
as
begin
	declare @trancount int = @@trancount;
	if (@trancount = 0)
		begin tran
	else
		save tran savepoint;
	begin try
		insert into bezwaar (GEBRUIKERSNAAM, VERGUNNINGSID, BEZWAARREDEN)
		values (@gebruikersnaam, @vergunningsid, @bezwaarreden);

		if exists (
			select 1
			from vergunning
			where vergunningsid = @vergunningsid and status = 'Verlopen'
		) begin
			raiserror('Er kan geen bezwaar gemaakt worden op een vergunning die reeds verlopen is.', 16, 1);
		end

		update vergunning
		set status = 'Bezwaar'
		where VERGUNNINGSID = @vergunningsid;

		if (@trancount = 0)
			commit tran
	end try

	begin catch
		if (@trancount = 0)
			rollback tran
		else
			rollback tran savepoint;
		throw;
	end catch
end
go
