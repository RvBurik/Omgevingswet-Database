alter table adres_van_gebruiker
add constraint CKC_GEBRUIKERSNAAM_ADRES_VA check (len(GEBRUIKERSNAAM) >= '4')
go

alter table bedrijf
add constraint CKC_KVKNUMMER_BEDRIJF check (len(KVKNUMMER) = 8)
go

alter table gebruiker
add constraint CKC_GEBRUIKERSNAAM_GEBRUIKE2 check (len(GEBRUIKERSNAAM) >= '4')
go

alter table gebruiker
add constraint CKC_GEBOORTEDATUM_GEBRUIKE check (GEBOORTEDATUM between '01-01-1900' and dateadd(year, -18, getdate()))
go

alter table gebruiker
add constraint CKC_GESLACHT_GEBRUIKE check (GESLACHT in ('M','V','O'))
go

alter table gebruikertel
add constraint CKC_TELEFOONNUMMER_GEBRUIKE check (len(TELEFOONNUMMER) >= '8')
go

alter table gebruikertel
add constraint CKC_GEBRUIKERSNAAM_GEBRUIKE check (len(GEBRUIKERSNAAM) >= '4')

alter table project
add constraint CKC_KVKNUMMER_PROJECT check (KVKNUMMER is null or (len(KVKNUMMER) = 8))
go

alter table project
add constraint CKC_GEBRUIKERSNAAM_PROJECT check (len(GEBRUIKERSNAAM) >= '4')
go

alter table project
add constraint CKC_AANGEMAAKTOP_PROJECT check (AANGEMAAKTOP >= '01-01-1900')
go

alter table telefoon
add constraint CKC_TELEFOONNUMMER_TELEFOON2 check (len(TELEFOONNUMMER) >= '8')
go

alter table telefoon_van_bedrijf
add constraint CKC_TELEFOONNUMMER_TELEFOON check (len(TELEFOONNUMMER) >= '8')
go

alter table telefoon_van_bedrijf
add constraint CKC_KVKNUMMER_TELEFOON check (len(KVKNUMMER) = 8)
go

alter table vergunning
add constraint CKC_STATUS_VERGUNNI2 check (STATUS in ('Aangevraagd','Afgewezen','Uitgegeven','Verlopen','Bezwaar'))
go

alter table vergunning
add constraint CKC_DATUMAANVRAAG_VERGUNNI check (DATUMAANVRAAG >= '01-01-1900')
go

alter table vergunning
add constraint CKC_DATUMUITGAVE_VERGUNNI check (DATUMUITGAVE is null or (DATUMUITGAVE >= '01-01-1900'))
go

alter table vergunning
add constraint CKC_DATUMVERLOOP_VERGUNNI check (DATUMVERLOOP is null or (DATUMVERLOOP >= '01-01-1990'))
go

alter table vergunningsinformatie
add constraint CKC_GEBRUIKERSNAAM_VERGUNNI check (len(GEBRUIKERSNAAM) >= '4')
go

alter table vergunningsinformatie
add constraint CKC_DATUM_VERGUNNI check (DATUM >= '01-01-1900')
go

alter table vergunningstatus
add constraint CKC_STATUS_VERGUNNI check (STATUS in ('Aangevraagd','Afgewezen','Uitgegeven','Verlopen','Bezwaar'))
go

alter table werknemer
add constraint CKC_GEBRUIKERSNAAM_WERKNEME check (len(GEBRUIKERSNAAM) >= '4')
go

alter table werknemer
add constraint CKC_KVKNUMMER_WERKNEME check (len(KVKNUMMER) = 8)
go

alter table abonnement
add constraint CKC_UITGIFTE_VOOR_AANVRAAG check (datumuitgave >= datumaanvraag)
go

alter table abonnement
add constraint CKC_DATUM_AUTOMATISCHE_UITGIFTE check (automatischtoegevoegd = 0 OR datumuitgave = datumaanvraag)
go