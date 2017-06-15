IF EXISTS (SELECT * FROM sys.procedures WHERE name = 'spMakeObjection') BEGIN
	DROP PROCEDURE spMakeObjection
END
GO

/****** Object:  StoredProcedure [dbo].[spMakeObjection]    Script Date: 31-5-2017 11:24:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
	CREATE PROCEDURE [dbo].[spMakeObjection]
	@GEBRUIKERSNAAM VARCHAR(255),
	@PROJECTID INTEGER,
	@VERGUNNINGSID INTEGER, 
	@BEZWAARREDEN VARCHAR(4000)
	AS
	BEGIN
		DECLARE @trancount INT = @@trancount;
		IF (@trancount = 0)
			BEGIN TRAN
		ELSE
			SAVE TRAN savepoint;
			BEGIN TRY
				IF @VERGUNNINGSID IS NOT NULL
					BEGIN TRY
						SELECT @PROJECTID = PROJECTID FROM VERGUNNING WHERE VERGUNNINGSID = @VERGUNNINGSID
					END TRY
					BEGIN CATCH
						THROW;
					END CATCH
				IF((SELECT GEBRUIKERSNAAM FROM PROJECTROL_VAN_GEBRUIKER WHERE PROJECTID = @PROJECTID AND ROLNAAM = 'INITIATIEFNEMER') = @GEBRUIKERSNAAM)
				BEGIN
					RAISERROR('U kan niet bezwaar maken op uw eigen project/vergunning', 16, 1)
				END
				IF EXISTS (
					SELECT 1 
					FROM VERGUNNING
					WHERE VERGUNNINGSID = @VERGUNNINGSID AND STATUS = 'Verlopen'
					)
					BEGIN
						RAISERROR('Er kan geen bezwaar gemaakt worden op een vergunning die reeds verlopen is', 16, 1)
					END
				
					COMMIT TRAN
			
				BEGIN
					INSERT INTO BEZWAAR (GEBRUIKERSNAAM, PROJECTID, VERGUNNINGSID, BEZWAARREDEN)
					VALUES(@GEBRUIKERSNAAM, @PROJECTID, @VERGUNNINGSID, @BEZWAARREDEN)
				END	
			IF (@trancount = 0)
				COMMIT
		END TRY
		BEGIN catch
			IF (@trancount = 0)
				ROLLBACK TRAN
			ELSE
				ROLLBACK TRAN savepoint;
			THROW;
		END CATCH
	END
GO