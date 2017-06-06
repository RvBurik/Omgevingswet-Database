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


IF EXISTS (SELECT * FROM SYS.TRIGGERS WHERE NAME = 'trgAutomatischAbonnerenAdres') BEGIN
  DROP TRIGGER trgAutomatischAbonnerenAdres
END
GO

CREATE TRIGGER trgAutomatischAbonnerenAdres
ON ADRES_VAN_GEBRUIKER
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
  IF @@rowcount = 0
    RETURN
  BEGIN TRY
    DELETE FROM PROJECTROL_VAN_GEBRUIKER
    WHERE GEBRUIKERSNAAM + '|' + CAST(PROJECTID AS VARCHAR) IN (
      SELECT d.GEBRUIKERSNAAM + '|' + CAST(pg.PROJECTID AS VARCHAR)
      FROM DELETED d INNER JOIN ADRESGEGEVENS a
          ON d.ADRESID = a.ADRESID
        INNER JOIN PROJECTROL_VAN_GEBRUIKER pg
          ON d.GEBRUIKERSNAAM = pg.GEBRUIKERSNAAM
        INNER JOIN PROJECT p
          ON pg.PROJECTID = p.PROJECTID
      WHERE pg.AUTOMATISCHTOEGEVOEGD = 1 AND dbo.fnAfstandKMTussenCoordinaten(a.XCOORDINAAT, a.YCOORDINAAT, p.XCOORDINAAT, p.YCOORDINAAT) <= 1
      EXCEPT
      SELECT GEBRUIKERSNAAM + '|' + CAST(PROJECTID AS VARCHAR)
      FROM ADRES_VAN_GEBRUIKER ag INNER JOIN ADRESGEGEVENS a
          ON ag.ADRESID = a.ADRESID
        CROSS JOIN PROJECT p
      WHERE dbo.fnAfstandKMTussenCoordinaten(a.XCOORDINAAT, a.YCOORDINAAT, p.XCOORDINAAT, p.YCOORDINAAT) <= 1
    )
    INSERT INTO PROJECTROL_VAN_GEBRUIKER (GEBRUIKERSNAAM, PROJECTID, ROLNAAM, DATUMAANVRAAG, DATUMUITGAVE, AUTOMATISCHTOEGEVOEGD) (
        SELECT	GEBRUIKERSNAAM, PROJECTID, 'Belanghebbende' AS ROLNAAM, GETDATE() AS DATUMAANVRAAG, GETDATE() AS DATUMUITGAVE, 1 AS AUTOMATISCHTOEGEVOEGD
				FROM		INSERTED i INNER JOIN ADRESGEGEVENS a
					ON  i.ADRESID = a.ADRESID
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


IF EXISTS (SELECT * FROM SYS.TRIGGERS WHERE NAME = 'trgAbonnementBijwerkenAdresgegevens') BEGIN
  DROP TRIGGER trgAbonnementBijwerkenAdresgegevens
END
GO

CREATE TRIGGER trgAbonnementBijwerkenAdresgegevens
ON ADRESGEGEVENS
AFTER UPDATE
AS
BEGIN
  IF @@rowcount = 0
    RETURN
  BEGIN TRY
    DELETE FROM PROJECTROL_VAN_GEBRUIKER
    WHERE GEBRUIKERSNAAM + '|' + CAST(PROJECTID AS VARCHAR) IN (
      SELECT ag.GEBRUIKERSNAAM + '|' + CAST(pg.PROJECTID AS VARCHAR)
      FROM DELETED d INNER JOIN ADRES_VAN_GEBRUIKER ag
          ON d.ADRESID = ag.ADRESID
        INNER JOIN PROJECTROL_VAN_GEBRUIKER pg
          ON ag.GEBRUIKERSNAAM = pg.GEBRUIKERSNAAM
        INNER JOIN PROJECT p
          ON pg.PROJECTID = p.PROJECTID
      WHERE pg.AUTOMATISCHTOEGEVOEGD = 1 AND dbo.fnAfstandKMTussenCoordinaten(d.XCOORDINAAT, d.YCOORDINAAT, p.XCOORDINAAT, p.YCOORDINAAT) <= 1
      EXCEPT
      SELECT GEBRUIKERSNAAM + '|' + CAST(PROJECTID AS VARCHAR)
      FROM ADRES_VAN_GEBRUIKER ag INNER JOIN ADRESGEGEVENS a
          ON ag.ADRESID = a.ADRESID
        CROSS JOIN PROJECT p
      WHERE dbo.fnAfstandKMTussenCoordinaten(a.XCOORDINAAT, a.YCOORDINAAT, p.XCOORDINAAT, p.YCOORDINAAT) <= 1
    )
    INSERT INTO PROJECTROL_VAN_GEBRUIKER (GEBRUIKERSNAAM, PROJECTID, ROLNAAM, DATUMAANVRAAG, DATUMUITGAVE, AUTOMATISCHTOEGEVOEGD) (
        SELECT	GEBRUIKERSNAAM, PROJECTID, 'Belanghebbende' AS ROLNAAM, GETDATE() AS DATUMAANVRAAG, GETDATE() AS DATUMUITGAVE, 1 AS AUTOMATISCHTOEGEVOEGD
				FROM		INSERTED i INNER JOIN ADRES_VAN_GEBRUIKER ag
					ON  i.ADRESID = ag.ADRESID
					CROSS JOIN PROJECT p
				WHERE dbo.fnAfstandKMTussenCoordinaten (i.XCOORDINAAT, i.YCOORDINAAT, p.XCOORDINAAT, p.YCOORDINAAT) <= 1
        EXCEPT
        SELECT GEBRUIKERSNAAM, PROJECTID, ROLNAAM, GETDATE() AS DATUMAANVRAAG, GETDATE() AS DATUMUITGAVE, 1 AS AUTOMATISCHTOEGEVOEGD FROM PROJECTROL_VAN_GEBRUIKER
    )
  END TRY
  BEGIN CATCH
    throw;
  END CATCH
END
GO