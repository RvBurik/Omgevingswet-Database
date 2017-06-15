CREATE PROCEDURE spAddUserToProject
@gebruikersnaam VARCHAR(255), 
@projectid INTEGER, 
@rolnaam VARCHAR(255)
AS
BEGIN
	DECLARE @trancount INT = @@trancount;
  IF (@trancount = 0)
    BEGIN TRAN
  ELSE
    SAVE TRAN savepoint;
	BEGIN TRY
		INSERT INTO PROJECTROL_VAN_GEBRUIKER (GEBRUIKERSNAAM, PROJECTID, ROLNAAM, DATUMAANVRAAG, AUTOMATISCHTOEGEVOEGD)
		VALUES(@gebruikersnaam, @projectid, @rolnaam, GETDATE(), 0)
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

