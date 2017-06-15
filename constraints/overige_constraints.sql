alter table vergunningsinformatie
add constraint DF_VERGUNNINGSINFORMATIE_DATUM DEFAULT GETDATE() FOR DATUM
GO