EXEC spPermitDecision @vergunningsid = 1, @status = 'AFGEKEURD', @omschrijvingNieuw = 'Er is niet voldoende bewijs', @datumverloop = '2017-07-08'

EXEC spPermitDecision @vergunningsid = 1, @status = 'GOEDGEKEURD', @omschrijvingNieuw = 'Er is niet voldoende bewijs', @datumverloop = '2017-06-08'


ALTER PROCEDURE spPermitDecision
@vergunningsid INTEGER,
@status VARCHAR(255),
@omschrijvingNieuw VARCHAR(4000),
@datumverloop DATE
AS
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
	END TRY
	BEGIN CATCH
		THROW;
		ROLLBACK
	END CATCH
GO	

DECLARE @OMSCHRIJVING VARCHAR(255)
SELECT @OMSCHRIJVING = OMSCHRIJVING FROM VERGUNNING WHERE VERGUNNINGSID = 1

UPDATE VERGUNNING
SET OMSCHRIJVING = @OMSCHRIJVING + ' ' + 'AFGEKEURD OMDAT:'
WHERE VERGUNNINGSID = 1

SELECT * FROM VERGUNNINGSINFORMATIE
