alter table abonnement
add constraint DF_DATUMAANVRAAG DEFAULT getdate() FOR DATUMAANVRAAG
go