USE [OMGEVINGSWET]
GO
/****** Object:  StoredProcedure [dbo].[spAddProject]    Script Date: 31-5-2017 11:07:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spAddProject]
@gebruikersnaam VARCHAR(255),
@titel VARCHAR(255),
@werkzaamheid VARCHAR(4000),
@xcoordinaat FLOAT,
@ycoordinaat FLOAT
AS
BEGIN
	DECLARE @trancount INT = @@trancount;
  IF (@trancount = 0)
    BEGIN TRAN
  ELSE
    SAVE TRAN savepoint;
	BEGIN TRY
		DECLARE @datum DATETIME
		SELECT @datum = CURRENT_TIMESTAMP

		INSERT INTO PROJECT(PROJECTTITEL, AANGEMAAKTOP, WERKZAAMHEID, XCOORDINAAT, YCOORDINAAT)
		VALUES(@titel, @datum, @werkzaamheid, @xcoordinaat, @ycoordinaat)

		INSERT INTO PROJECTROL_VAN_GEBRUIKER(GEBRUIKERSNAAM, PROJECTID, ROLNAAM, DATUMAANVRAAG, DATUMUITGAVE, AUTOMATISCHTOEGEVOEGD)
		VALUES(@gebruikersnaam, (SELECT SCOPE_IDENTITY() FROM PROJECT 
							     WHERE AANGEMAAKTOP = @datum), 'INITIATIEFNEMER', @datum, @datum, 1)
		IF (@trancount = 0)
      COMMIT
	END TRY
	BEGIN CATCH
		IF (@trancount = 0)
      ROLLBACK TRAN
    ELSE
      ROLLBACK TRAN savepoint;
    THROW;
	END CATCH
END