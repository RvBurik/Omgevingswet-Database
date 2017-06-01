USE Omgevingswet

IF EXISTS (SELECT *
           FROM   SYS.OBJECTS
           WHERE  object_id = OBJECT_ID(N'[dbo].[fnAfstandKMTussenCoordinaten]')
                  AND type IN ( N'FN', N'IF', N'TF', N'FS', N'FT' )) BEGIN
  DROP FUNCTION fnAfstandKMTussenCoordinaten
END
GO

CREATE FUNCTION dbo.fnAfstandKMTussenCoordinaten (@x1 FLOAT, @y1 FLOAT, @x2 FLOAT, @y2 FLOAT)
RETURNS FLOAT
AS
BEGIN
    RETURN ACOS(SIN(PI()*@y1/180.0)*SIN(PI()*@y2/180.0)+COS(PI()*@y1/180.0)*COS(PI()*@y2/180.0)*COS(PI()*@x2/180.0-PI()*@x1/180.0))*6371
END
GO


IF EXISTS (SELECT * FROM SYS.TRIGGERS WHERE NAME = 'trgAutomatischAbonnerenNieuwAdres') BEGIN
  DROP TRIGGER trgAutomatischAbonnerenNieuwAdres
END
GO

CREATE TRIGGER trgAutomatischAbonnerenNieuwAdres
ON ADRES_VAN_GEBRUIKER
AFTER INSERT --TODO: UPDATE, DELETE
AS
BEGIN
  IF @@rowcount = 0
    RETURN
  BEGIN TRY
/*i.GEBRUIKERSNAAM, PROJECTTITEL, a.XCOORDINAAT AS AdresX, a.YCOORDINAAT AS AdresY, p.XCOORDINAAT AS ProjectX, a.YCOORDINAAT AS ProjectY, dbo.fnAfstandKMTussenCoordinaten (a.XCOORDINAAT, a.YCOORDINAAT, p.XCOORDINAAT, p.YCOORDINAAT) AS Afstand*/
    INSERT INTO PROJECTROL_VAN_GEBRUIKER (GEBRUIKERSNAAM, PROJECTID, ROLNAAM, DATUMAANVRAAG, DATUMUITGAVE, AUTOMATISCHTOEGEVOEGD) (
        SELECT	GEBRUIKERSNAAM, PROJECTID, 'Belanghebbende' AS ROLNAAM, GETDATE() AS DATUMAANVRAAG, GETDATE() AS DATUMUITGAVE, 1 AS AUTOMATISCHTOEGEVOEGD
				FROM		INSERTED i INNER JOIN ADRESGEGEVENS a
					ON i.ADRESID = a.ADRESID
					CROSS JOIN PROJECT p
				WHERE dbo.fnAfstandKMTussenCoordinaten (a.XCOORDINAAT, a.YCOORDINAAT, p.XCOORDINAAT, p.YCOORDINAAT) <= 1
        EXCEPT
        SELECT GEBRUIKERSNAAM, PROJECTID, ROLNAAM, GETDATE() AS DATUMAANVRAAG, GETDATE() AS DATUMUITGAVE, 1 AS AUTOMATISCHTOEGEVOEGD FROM PROJECTROL_VAN_GEBRUIKER
    )

  END TRY
  BEGIN CATCH
    throw;
  END CATCH
END
GO