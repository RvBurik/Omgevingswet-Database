/*==============================================================*/
/* DBMS name:      Microsoft SQL Server 2014                    */
/* Created on:     31-5-2017 11:47:48                           */
/*==============================================================*/


if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('ADRES_VAN_GEBRUIKER') and o.name = 'FK_ADRES_VA_ADRES_VAN_ADRES')
alter table ADRES_VAN_GEBRUIKER
   drop constraint FK_ADRES_VA_ADRES_VAN_ADRES
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('ADRES_VAN_GEBRUIKER') and o.name = 'FK_ADRES_VA_ADRES_VAN_GEBRUIKE')
alter table ADRES_VAN_GEBRUIKER
   drop constraint FK_ADRES_VA_ADRES_VAN_GEBRUIKE
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('BEDRIJF') and o.name = 'FK_BEDRIJF_GEBRUIKER_GEBRUIKE')
alter table BEDRIJF
   drop constraint FK_BEDRIJF_GEBRUIKER_GEBRUIKE
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('BEZWAAR') and o.name = 'FK_BEZWAAR_PROJECT_V_PROJECT')
alter table BEZWAAR
   drop constraint FK_BEZWAAR_PROJECT_V_PROJECT
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('GEMEENTE_GEBRUIKER') and o.name = 'FK_GEMEENTE_REFERENCE_GEBRUIKE')
alter table GEMEENTE_GEBRUIKER
   drop constraint FK_GEMEENTE_REFERENCE_GEBRUIKE
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('GEMEENTE_GEBRUIKER') and o.name = 'FK_GEMEENTE_REFERENCE_RECHT')
alter table GEMEENTE_GEBRUIKER
   drop constraint FK_GEMEENTE_REFERENCE_RECHT
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('PARTICULIER') and o.name = 'FK_PARTICUL_GEBRUIKER_GEBRUIKE')
alter table PARTICULIER
   drop constraint FK_PARTICUL_GEBRUIKER_GEBRUIKE
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('PROJECTROL_VAN_GEBRUIKER') and o.name = 'FK_PROJECTR_PROJECTRO_GEBRUIKE')
alter table PROJECTROL_VAN_GEBRUIKER
   drop constraint FK_PROJECTR_PROJECTRO_GEBRUIKE
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('PROJECTROL_VAN_GEBRUIKER') and o.name = 'FK_PROJECTR_PROJECTRO_PROJECT')
alter table PROJECTROL_VAN_GEBRUIKER
   drop constraint FK_PROJECTR_PROJECTRO_PROJECT
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('PROJECTROL_VAN_GEBRUIKER') and o.name = 'FK_PROJECTR_REFERENCE_ROL')
alter table PROJECTROL_VAN_GEBRUIKER
   drop constraint FK_PROJECTR_REFERENCE_ROL
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('TELEFOON_VAN_GEBRUIKER') and o.name = 'FK_TELEFOON_TELEFOON__TELEFOON')
alter table TELEFOON_VAN_GEBRUIKER
   drop constraint FK_TELEFOON_TELEFOON__TELEFOON
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('TELEFOON_VAN_GEBRUIKER') and o.name = 'FK_TELEFOON_TELEFOON__GEBRUIKE')
alter table TELEFOON_VAN_GEBRUIKER
   drop constraint FK_TELEFOON_TELEFOON__GEBRUIKE
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('VERGUNNING') and o.name = 'FK_VERGUNNI_PROJECT_V_PROJECT2')
alter table VERGUNNING
   drop constraint FK_VERGUNNI_PROJECT_V_PROJECT2
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('VERGUNNING') and o.name = 'FK_VERGUNNI_VERGUNNIN_VERGUNNI')
alter table VERGUNNING
   drop constraint FK_VERGUNNI_VERGUNNIN_VERGUNNI
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('VERGUNNING') and o.name = 'FK_VERGUNNI_VERGUNNIN_VERGUNNI2')
alter table VERGUNNING
   drop constraint FK_VERGUNNI_VERGUNNIN_VERGUNNI2
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('VERGUNNINGSINFORMATIE') and o.name = 'FK_VERGUNNI_GEBRUIKER_GEBRUIKE')
alter table VERGUNNINGSINFORMATIE
   drop constraint FK_VERGUNNI_GEBRUIKER_GEBRUIKE
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('VERGUNNINGSINFORMATIE') and o.name = 'FK_VERGUNNI_PROJECT_V_PROJECT')
alter table VERGUNNINGSINFORMATIE
   drop constraint FK_VERGUNNI_PROJECT_V_PROJECT
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('WERKNEMER') and o.name = 'FK_WERKNEME_WERKNEMER_PARTICUL')
alter table WERKNEMER
   drop constraint FK_WERKNEME_WERKNEMER_PARTICUL
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('WERKNEMER') and o.name = 'FK_WERKNEME_WERKNEMER_BEDRIJF')
alter table WERKNEMER
   drop constraint FK_WERKNEME_WERKNEMER_BEDRIJF
go

if exists (select 1
            from  sysobjects
           where  id = object_id('ADRES')
            and   type = 'U')
   drop table ADRES
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('ADRES_VAN_GEBRUIKER')
            and   name  = 'ADRES_VAN_GEBRUIKER2_FK'
            and   indid > 0
            and   indid < 255)
   drop index ADRES_VAN_GEBRUIKER.ADRES_VAN_GEBRUIKER2_FK
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('ADRES_VAN_GEBRUIKER')
            and   name  = 'ADRES_VAN_GEBRUIKER_FK'
            and   indid > 0
            and   indid < 255)
   drop index ADRES_VAN_GEBRUIKER.ADRES_VAN_GEBRUIKER_FK
go

if exists (select 1
            from  sysobjects
           where  id = object_id('ADRES_VAN_GEBRUIKER')
            and   type = 'U')
   drop table ADRES_VAN_GEBRUIKER
go

if exists (select 1
            from  sysobjects
           where  id = object_id('BEDRIJF')
            and   type = 'U')
   drop table BEDRIJF
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('BEZWAAR')
            and   name  = 'BEZWAAR_VAN_PROJECT_FK'
            and   indid > 0
            and   indid < 255)
   drop index BEZWAAR.BEZWAAR_VAN_PROJECT_FK
go

if exists (select 1
            from  sysobjects
           where  id = object_id('BEZWAAR')
            and   type = 'U')
   drop table BEZWAAR
go

if exists (select 1
            from  sysobjects
           where  id = object_id('GEBRUIKER')
            and   type = 'U')
   drop table GEBRUIKER
go

if exists (select 1
            from  sysobjects
           where  id = object_id('GEMEENTE_GEBRUIKER')
            and   type = 'U')
   drop table GEMEENTE_GEBRUIKER
go

if exists (select 1
            from  sysobjects
           where  id = object_id('PARTICULIER')
            and   type = 'U')
   drop table PARTICULIER
go

if exists (select 1
            from  sysobjects
           where  id = object_id('PROJECT')
            and   type = 'U')
   drop table PROJECT
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('PROJECTROL_VAN_GEBRUIKER')
            and   name  = 'GEBRUIKER_ROL_VAN_PROJECT2_FK'
            and   indid > 0
            and   indid < 255)
   drop index PROJECTROL_VAN_GEBRUIKER.GEBRUIKER_ROL_VAN_PROJECT2_FK
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('PROJECTROL_VAN_GEBRUIKER')
            and   name  = 'GEBRUIKER_ROL_VAN_PROJECT_FK'
            and   indid > 0
            and   indid < 255)
   drop index PROJECTROL_VAN_GEBRUIKER.GEBRUIKER_ROL_VAN_PROJECT_FK
go

if exists (select 1
            from  sysobjects
           where  id = object_id('PROJECTROL_VAN_GEBRUIKER')
            and   type = 'U')
   drop table PROJECTROL_VAN_GEBRUIKER
go

if exists (select 1
            from  sysobjects
           where  id = object_id('RECHT')
            and   type = 'U')
   drop table RECHT
go

if exists (select 1
            from  sysobjects
           where  id = object_id('ROL')
            and   type = 'U')
   drop table ROL
go

if exists (select 1
            from  sysobjects
           where  id = object_id('TELEFOON')
            and   type = 'U')
   drop table TELEFOON
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('TELEFOON_VAN_GEBRUIKER')
            and   name  = 'TELEFOON_VAN_GEBRUIKER2_FK'
            and   indid > 0
            and   indid < 255)
   drop index TELEFOON_VAN_GEBRUIKER.TELEFOON_VAN_GEBRUIKER2_FK
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('TELEFOON_VAN_GEBRUIKER')
            and   name  = 'TELEFOON_VAN_GEBRUIKER_FK'
            and   indid > 0
            and   indid < 255)
   drop index TELEFOON_VAN_GEBRUIKER.TELEFOON_VAN_GEBRUIKER_FK
go

if exists (select 1
            from  sysobjects
           where  id = object_id('TELEFOON_VAN_GEBRUIKER')
            and   type = 'U')
   drop table TELEFOON_VAN_GEBRUIKER
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('VERGUNNING')
            and   name  = 'VERGUNNING_VAN_PROJECT_FK'
            and   indid > 0
            and   indid < 255)
   drop index VERGUNNING.VERGUNNING_VAN_PROJECT_FK
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('VERGUNNING')
            and   name  = 'VERGUNNINGSTATUS_VAN_VERGUNNING_FK'
            and   indid > 0
            and   indid < 255)
   drop index VERGUNNING.VERGUNNINGSTATUS_VAN_VERGUNNING_FK
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('VERGUNNING')
            and   name  = 'VERGUNNINGSTYPE_VAN_VERGUNNING_FK'
            and   indid > 0
            and   indid < 255)
   drop index VERGUNNING.VERGUNNINGSTYPE_VAN_VERGUNNING_FK
go

if exists (select 1
            from  sysobjects
           where  id = object_id('VERGUNNING')
            and   type = 'U')
   drop table VERGUNNING
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('VERGUNNINGSINFORMATIE')
            and   name  = 'GEBRUIKER_VAN_VERGUNNINGSINFORMATIE_FK'
            and   indid > 0
            and   indid < 255)
   drop index VERGUNNINGSINFORMATIE.GEBRUIKER_VAN_VERGUNNINGSINFORMATIE_FK
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('VERGUNNINGSINFORMATIE')
            and   name  = 'VERGUNNINGSINFORMATIE_VAN_PROJECT_FK'
            and   indid > 0
            and   indid < 255)
   drop index VERGUNNINGSINFORMATIE.VERGUNNINGSINFORMATIE_VAN_PROJECT_FK
go

if exists (select 1
            from  sysobjects
           where  id = object_id('VERGUNNINGSINFORMATIE')
            and   type = 'U')
   drop table VERGUNNINGSINFORMATIE
go

if exists (select 1
            from  sysobjects
           where  id = object_id('VERGUNNINGSTATUS')
            and   type = 'U')
   drop table VERGUNNINGSTATUS
go

if exists (select 1
            from  sysobjects
           where  id = object_id('VERGUNNINGSTYPE')
            and   type = 'U')
   drop table VERGUNNINGSTYPE
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('WERKNEMER')
            and   name  = 'WERKNEMER2_FK'
            and   indid > 0
            and   indid < 255)
   drop index WERKNEMER.WERKNEMER2_FK
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('WERKNEMER')
            and   name  = 'WERKNEMER_FK'
            and   indid > 0
            and   indid < 255)
   drop index WERKNEMER.WERKNEMER_FK
go

if exists (select 1
            from  sysobjects
           where  id = object_id('WERKNEMER')
            and   type = 'U')
   drop table WERKNEMER
go

if exists(select 1 from systypes where name='AANGEMAAKTOP')
   execute sp_unbindrule AANGEMAAKTOP
go

if exists(select 1 from systypes where name='AANGEMAAKTOP')
   drop type AANGEMAAKTOP
go

if exists(select 1 from systypes where name='ACHTERNAAM')
   drop type ACHTERNAAM
go

if exists(select 1 from systypes where name='ADRESID')
   drop type ADRESID
go

if exists(select 1 from systypes where name='BEDRIJFSNAAM')
   drop type BEDRIJFSNAAM
go

if exists(select 1 from systypes where name='BEDRIJFSWACHTWOORD')
   drop type BEDRIJFSWACHTWOORD
go

if exists(select 1 from systypes where name='BESLUITREDEN')
   drop type BESLUITREDEN
go

if exists(select 1 from systypes where name='BESTANDSLOCATIE')
   drop type BESTANDSLOCATIE
go

if exists(select 1 from systypes where name='BEZWAARBESLUIT')
   drop type BEZWAARBESLUIT
go

if exists(select 1 from systypes where name='BEZWAARREDEN')
   drop type BEZWAARREDEN
go

if exists(select 1 from systypes where name='COORDINAAT')
   drop type COORDINAAT
go

if exists(select 1 from systypes where name='DATUMAANVRAAG')
   execute sp_unbindrule DATUMAANVRAAG
go

if exists(select 1 from systypes where name='DATUMAANVRAAG')
   drop type DATUMAANVRAAG
go

if exists(select 1 from systypes where name='DATUMINFORMATIETOEGEVOEGD')
   execute sp_unbindrule DATUMINFORMATIETOEGEVOEGD
go

if exists(select 1 from systypes where name='DATUMINFORMATIETOEGEVOEGD')
   drop type DATUMINFORMATIETOEGEVOEGD
go

if exists(select 1 from systypes where name='DATUMUITGAVE')
   execute sp_unbindrule DATUMUITGAVE
go

if exists(select 1 from systypes where name='DATUMUITGAVE')
   drop type DATUMUITGAVE
go

if exists(select 1 from systypes where name='DATUMVERLOOP')
   execute sp_unbindrule DATUMVERLOOP
go

if exists(select 1 from systypes where name='DATUMVERLOOP')
   drop type DATUMVERLOOP
go

if exists(select 1 from systypes where name='GEBOORTEDATUM')
   execute sp_unbindrule GEBOORTEDATUM
go

if exists(select 1 from systypes where name='GEBOORTEDATUM')
   drop type GEBOORTEDATUM
go

if exists(select 1 from systypes where name='GEBRUIKERSNAAM')
   execute sp_unbindrule GEBRUIKERSNAAM
go

if exists(select 1 from systypes where name='GEBRUIKERSNAAM')
   drop type GEBRUIKERSNAAM
go

if exists(select 1 from systypes where name='GESLACHT')
   execute sp_unbindrule GESLACHT
go

if exists(select 1 from systypes where name='GESLACHT')
   drop type GESLACHT
go

if exists(select 1 from systypes where name='HUISNUMMER')
   drop type HUISNUMMER
go

if exists(select 1 from systypes where name='KVKNUMMER')
   drop type KVKNUMMER
go

if exists(select 1 from systypes where name='MAILADRES')
   drop type MAILADRES
go

if exists(select 1 from systypes where name='OMSCHRIJVING')
   drop type OMSCHRIJVING
go

if exists(select 1 from systypes where name='POSTCODE')
   drop type POSTCODE
go

if exists(select 1 from systypes where name='PROJECTID')
   drop type PROJECTID
go

if exists(select 1 from systypes where name='PROJECTTITEL')
   drop type PROJECTTITEL
go

if exists(select 1 from systypes where name='ROL')
   drop type ROL
go

if exists(select 1 from systypes where name='ROLTYPE')
   drop type ROLTYPE
go

if exists(select 1 from systypes where name='STATUS')
   drop type STATUS
go

if exists(select 1 from systypes where name='TELEFOONNUMMER')
   execute sp_unbindrule TELEFOONNUMMER
go

if exists(select 1 from systypes where name='TELEFOONNUMMER')
   drop type TELEFOONNUMMER
go

if exists(select 1 from systypes where name='TOEVOEGING')
   drop type TOEVOEGING
go

if exists(select 1 from systypes where name='TUSSENVOEGSEL')
   drop type TUSSENVOEGSEL
go

if exists(select 1 from systypes where name='TYPE')
   drop type TYPE
go

if exists(select 1 from systypes where name='UITLEG')
   drop type UITLEG
go

if exists(select 1 from systypes where name='VERGUNNINGSID')
   drop type VERGUNNINGSID
go

if exists(select 1 from systypes where name='VERGUNNINGSNAAM')
   drop type VERGUNNINGSNAAM
go

if exists(select 1 from systypes where name='VOLGNUMMER')
   drop type VOLGNUMMER
go

if exists(select 1 from systypes where name='VOORNAAM')
   drop type VOORNAAM
go

if exists(select 1 from systypes where name='WACHTWOORD')
   drop type WACHTWOORD
go

if exists(select 1 from systypes where name='WERKZAAMHEID')
   drop type WERKZAAMHEID
go

if exists (select 1 from sysobjects where id=object_id('R_AANGEMAAKTOP') and type='R')
   drop rule  R_AANGEMAAKTOP
go

if exists (select 1 from sysobjects where id=object_id('R_DATUMAANVRAAG') and type='R')
   drop rule  R_DATUMAANVRAAG
go

if exists (select 1 from sysobjects where id=object_id('R_DATUMINFORMATIETOEGEVOEGD') and type='R')
   drop rule  R_DATUMINFORMATIETOEGEVOEGD
go

if exists (select 1 from sysobjects where id=object_id('R_DATUMUITGAVE') and type='R')
   drop rule  R_DATUMUITGAVE
go

if exists (select 1 from sysobjects where id=object_id('R_DATUMVERLOOP') and type='R')
   drop rule  R_DATUMVERLOOP
go

if exists (select 1 from sysobjects where id=object_id('R_GEBOORTEDATUM') and type='R')
   drop rule  R_GEBOORTEDATUM
go

if exists (select 1 from sysobjects where id=object_id('R_GEBRUIKERSNAAM') and type='R')
   drop rule  R_GEBRUIKERSNAAM
go

if exists (select 1 from sysobjects where id=object_id('R_GESLACHT') and type='R')
   drop rule  R_GESLACHT
go

if exists (select 1 from sysobjects where id=object_id('R_TELEFOONNUMMER') and type='R')
   drop rule  R_TELEFOONNUMMER
go

create rule R_AANGEMAAKTOP as
      @column >= '01-01-1900'
go

create rule R_DATUMAANVRAAG as
      @column >= '01-01-1900'
go

create rule R_DATUMINFORMATIETOEGEVOEGD as
      @column >= '01-01-1900'
go

create rule R_DATUMUITGAVE as
      @column >= '01-01-1900'
go

create rule R_DATUMVERLOOP as
      @column >= '01-01-1990'
go

create rule R_GEBOORTEDATUM as
      @column >= '01-01-1900'
go

create rule R_GEBRUIKERSNAAM as
      @column >= '4'
go

create rule R_GESLACHT as
      @column in ('M','V','O')
go

create rule R_TELEFOONNUMMER as
      @column >= '8'
go

/*==============================================================*/
/* Domain: AANGEMAAKTOP                                         */
/*==============================================================*/
create type AANGEMAAKTOP
   from datetime
go

execute sp_bindrule R_AANGEMAAKTOP, AANGEMAAKTOP
go

/*==============================================================*/
/* Domain: ACHTERNAAM                                           */
/*==============================================================*/
create type ACHTERNAAM
   from varchar(255)
go

/*==============================================================*/
/* Domain: ADRESID                                              */
/*==============================================================*/
create type ADRESID
   from int
go

/*==============================================================*/
/* Domain: BEDRIJFSNAAM                                         */
/*==============================================================*/
create type BEDRIJFSNAAM
   from varchar(255)
go

/*==============================================================*/
/* Domain: BEDRIJFSWACHTWOORD                                   */
/*==============================================================*/
create type BEDRIJFSWACHTWOORD
   from varchar(255)
go

/*==============================================================*/
/* Domain: BESLUITREDEN                                         */
/*==============================================================*/
create type BESLUITREDEN
   from varchar(4000)
go

/*==============================================================*/
/* Domain: BESTANDSLOCATIE                                      */
/*==============================================================*/
create type BESTANDSLOCATIE
   from varchar(255)
go

/*==============================================================*/
/* Domain: BEZWAARBESLUIT                                       */
/*==============================================================*/
create type BEZWAARBESLUIT
   from varchar(30)
go

/*==============================================================*/
/* Domain: BEZWAARREDEN                                         */
/*==============================================================*/
create type BEZWAARREDEN
   from varchar(4000)
go

/*==============================================================*/
/* Domain: COORDINAAT                                           */
/*==============================================================*/
create type COORDINAAT
   from float
go

/*==============================================================*/
/* Domain: DATUMAANVRAAG                                        */
/*==============================================================*/
create type DATUMAANVRAAG
   from datetime
go

execute sp_bindrule R_DATUMAANVRAAG, DATUMAANVRAAG
go

/*==============================================================*/
/* Domain: DATUMINFORMATIETOEGEVOEGD                            */
/*==============================================================*/
create type DATUMINFORMATIETOEGEVOEGD
   from datetime
go

execute sp_bindrule R_DATUMINFORMATIETOEGEVOEGD, DATUMINFORMATIETOEGEVOEGD
go

/*==============================================================*/
/* Domain: DATUMUITGAVE                                         */
/*==============================================================*/
create type DATUMUITGAVE
   from datetime
go

execute sp_bindrule R_DATUMUITGAVE, DATUMUITGAVE
go

/*==============================================================*/
/* Domain: DATUMVERLOOP                                         */
/*==============================================================*/
create type DATUMVERLOOP
   from datetime
go

execute sp_bindrule R_DATUMVERLOOP, DATUMVERLOOP
go

/*==============================================================*/
/* Domain: GEBOORTEDATUM                                        */
/*==============================================================*/
create type GEBOORTEDATUM
   from datetime
go

execute sp_bindrule R_GEBOORTEDATUM, GEBOORTEDATUM
go

/*==============================================================*/
/* Domain: GEBRUIKERSNAAM                                       */
/*==============================================================*/
create type GEBRUIKERSNAAM
   from varchar(255)
go

execute sp_bindrule R_GEBRUIKERSNAAM, GEBRUIKERSNAAM
go

/*==============================================================*/
/* Domain: GESLACHT                                             */
/*==============================================================*/
create type GESLACHT
   from char(1)
go

execute sp_bindrule R_GESLACHT, GESLACHT
go

/*==============================================================*/
/* Domain: HUISNUMMER                                           */
/*==============================================================*/
create type HUISNUMMER
   from numeric(5,0)
go

/*==============================================================*/
/* Domain: KVKNUMMER                                            */
/*==============================================================*/
create type KVKNUMMER
   from numeric(8,0)
go

/*==============================================================*/
/* Domain: MAILADRES                                            */
/*==============================================================*/
create type MAILADRES
   from varchar(255)
go

/*==============================================================*/
/* Domain: OMSCHRIJVING                                         */
/*==============================================================*/
create type OMSCHRIJVING
   from varchar(4000)
go

/*==============================================================*/
/* Domain: POSTCODE                                             */
/*==============================================================*/
create type POSTCODE
   from varchar(6)
go

/*==============================================================*/
/* Domain: PROJECTID                                            */
/*==============================================================*/
create type PROJECTID
   from int
go

/*==============================================================*/
/* Domain: PROJECTTITEL                                         */
/*==============================================================*/
create type PROJECTTITEL
   from varchar(255)
go

/*==============================================================*/
/* Domain: ROL                                                  */
/*==============================================================*/
create type ROL
   from varchar(55)
go

/*==============================================================*/
/* Domain: ROLTYPE                                              */
/*==============================================================*/
create type ROLTYPE
   from varchar(55)
go

/*==============================================================*/
/* Domain: STATUS                                               */
/*==============================================================*/
create type STATUS
   from varchar(255)
go

/*==============================================================*/
/* Domain: TELEFOONNUMMER                                       */
/*==============================================================*/
create type TELEFOONNUMMER
   from varchar(20)
go

execute sp_bindrule R_TELEFOONNUMMER, TELEFOONNUMMER
go

/*==============================================================*/
/* Domain: TOEVOEGING                                           */
/*==============================================================*/
create type TOEVOEGING
   from varchar(5)
go

/*==============================================================*/
/* Domain: TUSSENVOEGSEL                                        */
/*==============================================================*/
create type TUSSENVOEGSEL
   from varchar(25)
go

/*==============================================================*/
/* Domain: TYPE                                                 */
/*==============================================================*/
create type TYPE
   from varchar(255)
go

/*==============================================================*/
/* Domain: UITLEG                                               */
/*==============================================================*/
create type UITLEG
   from varchar(4000)
go

/*==============================================================*/
/* Domain: VERGUNNINGSID                                        */
/*==============================================================*/
create type VERGUNNINGSID
   from int
go

/*==============================================================*/
/* Domain: VERGUNNINGSNAAM                                      */
/*==============================================================*/
create type VERGUNNINGSNAAM
   from varchar(255)
go

/*==============================================================*/
/* Domain: VOLGNUMMER                                           */
/*==============================================================*/
create type VOLGNUMMER
   from int
go

/*==============================================================*/
/* Domain: VOORNAAM                                             */
/*==============================================================*/
create type VOORNAAM
   from varchar(100)
go

/*==============================================================*/
/* Domain: WACHTWOORD                                           */
/*==============================================================*/
create type WACHTWOORD
   from varchar(255)
go

/*==============================================================*/
/* Domain: WERKZAAMHEID                                         */
/*==============================================================*/
create type WERKZAAMHEID
   from varchar(4000)
go

/*==============================================================*/
/* Table: ADRES                                                 */
/*==============================================================*/
create table ADRES (
   ADRESID              ADRESID              not null,
   POSTCODE             POSTCODE             not null,
   HUISNUMMER           HUISNUMMER           not null 
      constraint CKC_HUISNUMMER_ADRES check (HUISNUMMER between 00000001 and 99999999),
   TOEVOEGING           TOEVOEGING           null,
   XCOORDINAAT          COORDINAAT           not null,
   YCOORDINAAT          COORDINAAT           not null,
   constraint PK_ADRES primary key (ADRESID),
   constraint AK_IDENTIFIER_2_ADRES unique (POSTCODE, HUISNUMMER, TOEVOEGING)
)
go

/*==============================================================*/
/* Table: ADRES_VAN_GEBRUIKER                                   */
/*==============================================================*/
create table ADRES_VAN_GEBRUIKER (
   ADRESID              ADRESID              not null,
   GEBRUIKERSNAAM       GEBRUIKERSNAAM       not null,
   constraint PK_ADRES_VAN_GEBRUIKER primary key (ADRESID, GEBRUIKERSNAAM)
)
go

/*==============================================================*/
/* Index: ADRES_VAN_GEBRUIKER_FK                                */
/*==============================================================*/




create nonclustered index ADRES_VAN_GEBRUIKER_FK on ADRES_VAN_GEBRUIKER (ADRESID ASC)
go

/*==============================================================*/
/* Index: ADRES_VAN_GEBRUIKER2_FK                               */
/*==============================================================*/




create nonclustered index ADRES_VAN_GEBRUIKER2_FK on ADRES_VAN_GEBRUIKER (GEBRUIKERSNAAM ASC)
go

/*==============================================================*/
/* Table: BEDRIJF                                               */
/*==============================================================*/
create table BEDRIJF (
   GEBRUIKERSNAAM       GEBRUIKERSNAAM       not null,
   KVKNUMMER            KVKNUMMER            not null,
   BEDRIJFSNAAM         BEDRIJFSNAAM         not null,
   constraint PK_BEDRIJF primary key (GEBRUIKERSNAAM)
)
go

/*==============================================================*/
/* Table: BEZWAAR                                               */
/*==============================================================*/
create table BEZWAAR (
   PROJECTID            PROJECTID            not null,
   BEZWAARREDEN         BEZWAARREDEN         not null,
   BESLUIT              BEZWAARBESLUIT       null,
   BESLUITREDEN         BESLUITREDEN         null
)
go

/*==============================================================*/
/* Index: BEZWAAR_VAN_PROJECT_FK                                */
/*==============================================================*/




create nonclustered index BEZWAAR_VAN_PROJECT_FK on BEZWAAR (PROJECTID ASC)
go

/*==============================================================*/
/* Table: GEBRUIKER                                             */
/*==============================================================*/
create table GEBRUIKER (
   GEBRUIKERSNAAM       GEBRUIKERSNAAM       not null,
   WACHTWOORD           WACHTWOORD           not null,
   MAILADRES            MAILADRES            not null,
   constraint PK_GEBRUIKER primary key (GEBRUIKERSNAAM)
)
go

/*==============================================================*/
/* Table: GEMEENTE_GEBRUIKER                                    */
/*==============================================================*/
create table GEMEENTE_GEBRUIKER (
   GEBRUIKERSNAAM       GEBRUIKERSNAAM       not null,
   RECHTNAAM            varchar(255)         not null,
   constraint PK_GEMEENTE_GEBRUIKER primary key (GEBRUIKERSNAAM)
)
go

/*==============================================================*/
/* Table: PARTICULIER                                           */
/*==============================================================*/
create table PARTICULIER (
   GEBRUIKERSNAAM       GEBRUIKERSNAAM       not null,
   VOORNAAM             VOORNAAM             not null,
   TUSSENVOEGSEL        TUSSENVOEGSEL        null,
   ACHTERNAAM           ACHTERNAAM           not null,
   GEBOORTEDATUM        GEBOORTEDATUM        not null 
      constraint CKC_GEBOORTEDATUM_PARTICUL check (GEBOORTEDATUM between '01-01-1900' and 'add_months(sysdate, - (18*12)'),
   GESLACHT             GESLACHT             not null,
   constraint PK_PARTICULIER primary key (GEBRUIKERSNAAM)
)
go

/*==============================================================*/
/* Table: PROJECT                                               */
/*==============================================================*/
create table PROJECT (
   PROJECTID            PROJECTID            not null,
   PROJECTTITEL         PROJECTTITEL         not null,
   AANGEMAAKTOP         AANGEMAAKTOP         not null,
   WERKZAAMHEID         WERKZAAMHEID         not null,
   XCOORDINAAT          COORDINAAT           not null,
   YCOORDINAAT          COORDINAAT           not null,
   constraint PK_PROJECT primary key (PROJECTID)
)
go

/*==============================================================*/
/* Table: PROJECTROL_VAN_GEBRUIKER                              */
/*==============================================================*/
create table PROJECTROL_VAN_GEBRUIKER (
   GEBRUIKERSNAAM       GEBRUIKERSNAAM       not null,
   PROJECTID            PROJECTID            not null,
   ROLNAAM              varchar(255)         not null,
   DATUMAANVRAAG        date                 not null,
   DATUMUITGAVE         date                 null,
   AUTOMATISCHTOEGEVOEGD boolean              not null,
   constraint PK_PROJECTROL_VAN_GEBRUIKER primary key (GEBRUIKERSNAAM, PROJECTID)
)
go

/*==============================================================*/
/* Index: GEBRUIKER_ROL_VAN_PROJECT_FK                          */
/*==============================================================*/




create nonclustered index GEBRUIKER_ROL_VAN_PROJECT_FK on PROJECTROL_VAN_GEBRUIKER (GEBRUIKERSNAAM ASC)
go

/*==============================================================*/
/* Index: GEBRUIKER_ROL_VAN_PROJECT2_FK                         */
/*==============================================================*/




create nonclustered index GEBRUIKER_ROL_VAN_PROJECT2_FK on PROJECTROL_VAN_GEBRUIKER (PROJECTID ASC)
go

/*==============================================================*/
/* Table: RECHT                                                 */
/*==============================================================*/
create table RECHT (
   RECHTNAAM            varchar(255)         not null,
   RECHTBESCHRIJVING    varchar(4000)        null,
   constraint PK_RECHT primary key (RECHTNAAM)
)
go

/*==============================================================*/
/* Table: ROL                                                   */
/*==============================================================*/
create table ROL (
   ROLNAAM              varchar(255)         not null,
   ROLBESCHRIJVING      varchar(4000)        null,
   constraint PK_ROL primary key (ROLNAAM)
)
go

/*==============================================================*/
/* Table: TELEFOON                                              */
/*==============================================================*/
create table TELEFOON (
   TELEFOONNUMMER       TELEFOONNUMMER       not null,
   constraint PK_TELEFOON primary key (TELEFOONNUMMER)
)
go

/*==============================================================*/
/* Table: TELEFOON_VAN_GEBRUIKER                                */
/*==============================================================*/
create table TELEFOON_VAN_GEBRUIKER (
   TELEFOONNUMMER       TELEFOONNUMMER       not null,
   GEBRUIKERSNAAM       GEBRUIKERSNAAM       not null,
   constraint PK_TELEFOON_VAN_GEBRUIKER primary key (TELEFOONNUMMER, GEBRUIKERSNAAM)
)
go

/*==============================================================*/
/* Index: TELEFOON_VAN_GEBRUIKER_FK                             */
/*==============================================================*/




create nonclustered index TELEFOON_VAN_GEBRUIKER_FK on TELEFOON_VAN_GEBRUIKER (TELEFOONNUMMER ASC)
go

/*==============================================================*/
/* Index: TELEFOON_VAN_GEBRUIKER2_FK                            */
/*==============================================================*/




create nonclustered index TELEFOON_VAN_GEBRUIKER2_FK on TELEFOON_VAN_GEBRUIKER (GEBRUIKERSNAAM ASC)
go

/*==============================================================*/
/* Table: VERGUNNING                                            */
/*==============================================================*/
create table VERGUNNING (
   VERGUNNINGSID        VERGUNNINGSID        not null,
   VERGUNNINGSNAAM      VERGUNNINGSNAAM      not null,
   STATUS               STATUS               not null 
      constraint CKC_STATUS_VERGUNNI2 check (STATUS in ('Aangevraagd','Afwewezen','Uitgegeven','Verlopen','Bezwaar')),
   PROJECTID            PROJECTID            not null,
   OMSCHRIJVING         OMSCHRIJVING         not null,
   DATUMAANVRAAG        DATUMAANVRAAG        not null,
   DATUMUITGAVE         DATUMUITGAVE         null,
   DATUMVERLOOP         DATUMVERLOOP         null,
   constraint PK_VERGUNNING primary key (VERGUNNINGSID)
)
go

/*==============================================================*/
/* Index: VERGUNNINGSTYPE_VAN_VERGUNNING_FK                     */
/*==============================================================*/




create nonclustered index VERGUNNINGSTYPE_VAN_VERGUNNING_FK on VERGUNNING (VERGUNNINGSNAAM ASC)
go

/*==============================================================*/
/* Index: VERGUNNINGSTATUS_VAN_VERGUNNING_FK                    */
/*==============================================================*/




create nonclustered index VERGUNNINGSTATUS_VAN_VERGUNNING_FK on VERGUNNING (STATUS ASC)
go

/*==============================================================*/
/* Index: VERGUNNING_VAN_PROJECT_FK                             */
/*==============================================================*/




create nonclustered index VERGUNNING_VAN_PROJECT_FK on VERGUNNING (PROJECTID ASC)
go

/*==============================================================*/
/* Table: VERGUNNINGSINFORMATIE                                 */
/*==============================================================*/
create table VERGUNNINGSINFORMATIE (
   PROJECTID            PROJECTID            not null,
   VOLGNUMMER           VOLGNUMMER           not null,
   GEBRUIKERSNAAM       GEBRUIKERSNAAM       not null,
   UITLEG               UITLEG               not null,
   DATUM                DATUMINFORMATIETOEGEVOEGD not null,
   LOCATIE              BESTANDSLOCATIE      null,
   constraint PK_VERGUNNINGSINFORMATIE primary key (PROJECTID, VOLGNUMMER)
)
go

/*==============================================================*/
/* Index: VERGUNNINGSINFORMATIE_VAN_PROJECT_FK                  */
/*==============================================================*/




create nonclustered index VERGUNNINGSINFORMATIE_VAN_PROJECT_FK on VERGUNNINGSINFORMATIE (PROJECTID ASC)
go

/*==============================================================*/
/* Index: GEBRUIKER_VAN_VERGUNNINGSINFORMATIE_FK                */
/*==============================================================*/




create nonclustered index GEBRUIKER_VAN_VERGUNNINGSINFORMATIE_FK on VERGUNNINGSINFORMATIE (GEBRUIKERSNAAM ASC)
go

/*==============================================================*/
/* Table: VERGUNNINGSTATUS                                      */
/*==============================================================*/
create table VERGUNNINGSTATUS (
   STATUS               STATUS               not null 
      constraint CKC_STATUS_VERGUNNI check (STATUS in ('Aangevraagd','Afwewezen','Uitgegeven','Verlopen','Bezwaar')),
   constraint PK_VERGUNNINGSTATUS primary key (STATUS)
)
go

/*==============================================================*/
/* Table: VERGUNNINGSTYPE                                       */
/*==============================================================*/
create table VERGUNNINGSTYPE (
   VERGUNNINGSNAAM      VERGUNNINGSNAAM      not null,
   constraint PK_VERGUNNINGSTYPE primary key (VERGUNNINGSNAAM)
)
go

/*==============================================================*/
/* Table: WERKNEMER                                             */
/*==============================================================*/
create table WERKNEMER (
   PAR_GEBRUIKERSNAAM   GEBRUIKERSNAAM       not null,
   BED_GEBRUIKERSNAAM   GEBRUIKERSNAAM       not null,
   constraint PK_WERKNEMER primary key (PAR_GEBRUIKERSNAAM, BED_GEBRUIKERSNAAM)
)
go

/*==============================================================*/
/* Index: WERKNEMER_FK                                          */
/*==============================================================*/




create nonclustered index WERKNEMER_FK on WERKNEMER (PAR_GEBRUIKERSNAAM ASC)
go

/*==============================================================*/
/* Index: WERKNEMER2_FK                                         */
/*==============================================================*/




create nonclustered index WERKNEMER2_FK on WERKNEMER (BED_GEBRUIKERSNAAM ASC)
go

alter table ADRES_VAN_GEBRUIKER
   add constraint FK_ADRES_VA_ADRES_VAN_ADRES foreign key (ADRESID)
      references ADRES (ADRESID)
go

alter table ADRES_VAN_GEBRUIKER
   add constraint FK_ADRES_VA_ADRES_VAN_GEBRUIKE foreign key (GEBRUIKERSNAAM)
      references GEBRUIKER (GEBRUIKERSNAAM)
go

alter table BEDRIJF
   add constraint FK_BEDRIJF_GEBRUIKER_GEBRUIKE foreign key (GEBRUIKERSNAAM)
      references GEBRUIKER (GEBRUIKERSNAAM)
go

alter table BEZWAAR
   add constraint FK_BEZWAAR_PROJECT_V_PROJECT foreign key (PROJECTID)
      references PROJECT (PROJECTID)
go

alter table GEMEENTE_GEBRUIKER
   add constraint FK_GEMEENTE_REFERENCE_GEBRUIKE foreign key (GEBRUIKERSNAAM)
      references GEBRUIKER (GEBRUIKERSNAAM)
go

alter table GEMEENTE_GEBRUIKER
   add constraint FK_GEMEENTE_REFERENCE_RECHT foreign key (RECHTNAAM)
      references RECHT (RECHTNAAM)
go

alter table PARTICULIER
   add constraint FK_PARTICUL_GEBRUIKER_GEBRUIKE foreign key (GEBRUIKERSNAAM)
      references GEBRUIKER (GEBRUIKERSNAAM)
go

alter table PROJECTROL_VAN_GEBRUIKER
   add constraint FK_PROJECTR_PROJECTRO_GEBRUIKE foreign key (GEBRUIKERSNAAM)
      references GEBRUIKER (GEBRUIKERSNAAM)
go

alter table PROJECTROL_VAN_GEBRUIKER
   add constraint FK_PROJECTR_PROJECTRO_PROJECT foreign key (PROJECTID)
      references PROJECT (PROJECTID)
go

alter table PROJECTROL_VAN_GEBRUIKER
   add constraint FK_PROJECTR_REFERENCE_ROL foreign key (ROLNAAM)
      references ROL (ROLNAAM)
go

alter table TELEFOON_VAN_GEBRUIKER
   add constraint FK_TELEFOON_TELEFOON__TELEFOON foreign key (TELEFOONNUMMER)
      references TELEFOON (TELEFOONNUMMER)
go

alter table TELEFOON_VAN_GEBRUIKER
   add constraint FK_TELEFOON_TELEFOON__GEBRUIKE foreign key (GEBRUIKERSNAAM)
      references GEBRUIKER (GEBRUIKERSNAAM)
go

alter table VERGUNNING
   add constraint FK_VERGUNNI_PROJECT_V_PROJECT2 foreign key (PROJECTID)
      references PROJECT (PROJECTID)
go

alter table VERGUNNING
   add constraint FK_VERGUNNI_VERGUNNIN_VERGUNNI foreign key (STATUS)
      references VERGUNNINGSTATUS (STATUS)
go

alter table VERGUNNING
   add constraint FK_VERGUNNI_VERGUNNIN_VERGUNNI2 foreign key (VERGUNNINGSNAAM)
      references VERGUNNINGSTYPE (VERGUNNINGSNAAM)
go

alter table VERGUNNINGSINFORMATIE
   add constraint FK_VERGUNNI_GEBRUIKER_GEBRUIKE foreign key (GEBRUIKERSNAAM)
      references GEBRUIKER (GEBRUIKERSNAAM)
go

alter table VERGUNNINGSINFORMATIE
   add constraint FK_VERGUNNI_PROJECT_V_PROJECT foreign key (PROJECTID)
      references PROJECT (PROJECTID)
go

alter table WERKNEMER
   add constraint FK_WERKNEME_WERKNEMER_PARTICUL foreign key (PAR_GEBRUIKERSNAAM)
      references PARTICULIER (GEBRUIKERSNAAM)
go

alter table WERKNEMER
   add constraint FK_WERKNEME_WERKNEMER_BEDRIJF foreign key (BED_GEBRUIKERSNAAM)
      references BEDRIJF (GEBRUIKERSNAAM)
go

