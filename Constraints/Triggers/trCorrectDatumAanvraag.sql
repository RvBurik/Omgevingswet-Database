--Deze trigger werkt momenteel niet. Niet uitvoeren.

IF EXISTS (SELECT * FROM SYS.TRIGGERS WHERE NAME = 'trCorrectDatumAanvraag') BEGIN
	DROP TRIGGER trCorrectDatumAanvraag
END
go

CREATE TRIGGER trCorrectDatumAanvraag
ON PROJECTROL_VAN_GEBRUIKER

AFTER INSERT, UPDATE
AS
	BEGIN TRY
		IF( (SELECT AANGEMAAKTOP FROM PROJECT AS P) > (SELECT DISTINCT DATUMAANVRAAG
												      FROM INSERTED AS I
													  INNER JOIN PROJECT AS PR
													  ON PR.PROJECTID = I.PROJECTID
													 ))
			BEGIN
				RAISERROR('De aanvraagdatum kan niet voor de projectdatum liggen!', 16, 1)
				ROLLBACK
			END
	END TRY
	BEGIN CATCH
		THROW
	END CATCH
GO

