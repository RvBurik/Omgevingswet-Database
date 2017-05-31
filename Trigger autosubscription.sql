ALTER TRIGGER trAutomaticSubscription
ON PROJECT

AFTER INSERT, UPDATE
AS
	DECLARE @radius INTEGER
	SELECT @radius = 1
	BEGIN TRY
		INSERT INTO ABONNEMENT(GEBRUIKERSNAAM, PROJECTID, DATUMAANVRAAG, DATUMUITGAVE, AUTOMATISCHTOEGEVOEGD)
			SELECT GEBRUIKERSNAAM, (SELECT PROJECTID FROM INSERTED), GETDATE(), GETDATE(), 1
			FROM ADRES_VAN_GEBRUIKER
			WHERE ADRESID NOT IN (
				SELECT ADRESID
				FROM ADRESGEGEVENS
				EXCEPT
				SELECT ADRESID
				FROM ADRESGEGEVENS
				WHERE XCOORDINAAT < (SELECT XCOORDINAAT - @radius
									 FROM PROJECT
									 WHERE PROJECTID = (SELECT PROJECTID FROM INSERTED) 
									)
				OR XCOORDINAAT > (SELECT XCOORDINAAT + @radius
								   FROM PROJECT
								   WHERE PROJECTID = (SELECT PROJECTID FROM INSERTED)
								  )
				AND YCOORDINAAT < (SELECT YCOORDINAAT - @radius
								   FROM PROJECT
								   WHERE PROJECTID = (SELECT PROJECTID FROM INSERTED)
								   )
				OR YCOORDINAAT > (SELECT YCOORDINAAT + @radius
								   FROM PROJECT
								   WHERE PROJECTID = (SELECT PROJECTID FROM INSERTED)
								  )
				)
			END TRY
			BEGIN CATCH
				THROW;
				ROLLBACK
			END CATCH
GO


--Nieuwe user wordt via een SP toegevoegd, dus trigger hoeft niet getest te worden op multiple inserts
CREATE TRIGGER trAutomaticSubscriptionForNewUsers
ON ADRES_VAN_GEBRUIKER

AFTER INSERT, UPDATE
AS
	DECLARE @radius INTEGER
	SELECT @radius = 1
	BEGIN TRY
		INSERT INTO ABONNEMENT(GEBRUIKERSNAAM, PROJECTID, DATUMAANVRAAG, DATUMUITGAVE, AUTOMATISCHTOEGEVOEGD)
			SELECT GEBRUIKERSNAAM, (SELECT PROJECTID FROM INSERTED), GETDATE(), GETDATE(), 1
			FROM ADRES_VAN_GEBRUIKER
			WHERE ADRESID IN (
			
				SELECT ADRESID
				FROM ADRESGEGEVENS
				EXCEPT
				SELECT ADRESID
				FROM ADRESGEGEVENS
				WHERE XCOORDINAAT < (SELECT XCOORDINAAT - @radius
									 FROM PROJECT
									 WHERE PROJECTID = 32
									)
				OR XCOORDINAAT > (SELECT XCOORDINAAT + @radius
								   FROM PROJECT
								   WHERE PROJECTID = 32
								  )
				AND YCOORDINAAT < (SELECT YCOORDINAAT - @radius
								   FROM PROJECT
								   WHERE PROJECTID = 32
								   )
				OR YCOORDINAAT > (SELECT YCOORDINAAT + @radius
								   FROM PROJECT
								   WHERE PROJECTID = 32
								  )
				)				
	END TRY
	BEGIN CATCH
		THROW;
	END CATCH
GO


SELECT * FROM ADRES_VAN_GEBRUIKER

INSERT INTO ABONNEMENT(GEBRUIKERSNAAM, PROJECTID, DATUMAANVRAAG, DATUMUITGAVE, AUTOMATISCHTOEGEVOEGD)
	SELECT GEBRUIKERSNAAM, (SELECT PROJECTID FROM INSERTED), GETDATE(), GETDATE(), 1
	FROM ADRES_VAN_GEBRUIKER
	WHERE A


	SELECT * 
	FROM ADRESGEGEVENS
	WHERE ADRESID IN (
		SELECT ADRESID 
		FROM ADRES_VAN_GEBRUIKER AS I --INSERTED
	)





INSERT INTO ABONNEMENT(GEBRUIKERSNAAM, PROJECTID, DATUMAANVRAAG, DATUMUITGAVE, AUTOMATISCHTOEGEVOEGD)
			SELECT GEBRUIKERSNAAM, (SELECT PROJECTID FROM INSERTED), GETDATE(), GETDATE(), 1
			FROM ADRES_VAN_GEBRUIKER
			WHERE ADRESID IN (
			
				SELECT ADRESID
				FROM ADRESGEGEVENS
				EXCEPT
				SELECT ADRESID
				FROM ADRESGEGEVENS
				WHERE XCOORDINAAT < (SELECT XCOORDINAAT - @radius
									 FROM PROJECT
									 WHERE PROJECTID = 32
									)
				OR XCOORDINAAT > (SELECT XCOORDINAAT + @radius
								   FROM PROJECT
								   WHERE PROJECTID = 32
								  )
				AND YCOORDINAAT < (SELECT YCOORDINAAT - @radius
								   FROM PROJECT
								   WHERE PROJECTID = 32
								   )
				OR YCOORDINAAT > (SELECT YCOORDINAAT + @radius
								   FROM PROJECT
								   WHERE PROJECTID = 32
								  )
				)