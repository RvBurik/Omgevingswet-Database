USE Omgevingswet

--De datum van een informatiestuk mag niet vóór de aanmaakdatum van het bijbehorende project liggen.
IF EXISTS (SELECT * FROM SYS.TRIGGERS WHERE NAME = 'trgDatumVergunningsInformatie') BEGIN
  DROP TRIGGER trgDatumVergunningsInformatie
END
GO

CREATE TRIGGER trgDatumVergunningsInformatie
ON VERGUNNINGSINFORMATIE
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
  IF @@rowcount = 0
    RETURN
  BEGIN TRY

  END TRY
  BEGIN CATCH
    throw;
  END CATCH
END
GO

--De aanvraagdatum van een abonnement mag niet vóór de aanmaakdatum van het bijbehorende project liggen.