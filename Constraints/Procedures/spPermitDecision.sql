IF EXISTS (SELECT * FROM sys.procedures WHERE name = 'spPermitDecision') BEGIN
	DROP PROCEDURE spPermitDecision
END
GO

CREATE PROCEDURE spPermitDecision
@vergunningsid INTEGER,
@status VARCHAR(255),
@omschrijvingNieuw VARCHAR(4000),
@datumverloop DATE
AS
BEGIN
	DECLARE @trancount INT = @@trancount;
	IF (@trancount = 0)
		BEGIN TRAN
	ELSE
		SAVE TRAN savepoint;
	BEGIN TRY
		DECLARE @OMSCHRIJVING VARCHAR(4000)
		SELECT @OMSCHRIJVING = OMSCHRIJVING 
		FROM VERGUNNING	WHERE VERGUNNINGSID = @vergunningsid

		UPDATE VERGUNNING
		SET OMSCHRIJVING = @OMSCHRIJVING + ' | ' + @STATUS + ': ' + @omschrijvingNieuw

		IF(@status = 'GOEDGEKEURD')
			BEGIN
				UPDATE VERGUNNING
				SET DATUMUITGAVE = GETDATE(), DATUMVERLOOP = @datumverloop
				WHERE VERGUNNINGSID = @vergunningsid	
			END
		IF(@status = 'AFGEKEURD')
			BEGIN
				UPDATE VERGUNNING
				SET DATUMUITGAVE = NULL, DATUMVERLOOP = NULL
				WHERE VERGUNNINGSID = @vergunningsid
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
