/*==============================================================*/
/* DBMS name:      Microsoft SQL Server 2012                    */
/* Created on:     2017-05-12 13:29:43                          */
/*==============================================================*/


if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('BEDRIJF') and o.name = 'FK_BEDRIJF_ADRES_VAN_ADRESGEG')
alter table BEDRIJF
   drop constraint FK_BEDRIJF_ADRES_VAN_ADRESGEG
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('PROJECT') and o.name = 'FK_PROJECT_AUTEUR_VA_GEBRUIKE')
alter table PROJECT
   drop constraint FK_PROJECT_AUTEUR_VA_GEBRUIKE
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('VERGUNNING') and o.name = 'FK_VERGUNNI_STATUS_VA_VERGUNNI')
alter table VERGUNNING
   drop constraint FK_VERGUNNI_STATUS_VA_VERGUNNI
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('VERGUNNING') and o.name = 'FK_VERGUNNI_VERGUNNIN_VERGUNNI')
alter table VERGUNNING
   drop constraint FK_VERGUNNI_VERGUNNIN_VERGUNNI
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('VERGUNNING') and o.name = 'FK_VERGUNNI_VERGUNNIN_PROJECT')
alter table VERGUNNING
   drop constraint FK_VERGUNNI_VERGUNNIN_PROJECT
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('VERGUNNINGSINFORMATIE') and o.name = 'FK_VERGUNNI_INFORMATI_PROJECT')
alter table VERGUNNINGSINFORMATIE
   drop constraint FK_VERGUNNI_INFORMATI_PROJECT
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('VERGUNNINGSINFORMATIE') and o.name = 'FK_VERGUNNI_TOEGEVOEG_GEBRUIKE')
alter table VERGUNNINGSINFORMATIE
   drop constraint FK_VERGUNNI_TOEGEVOEG_GEBRUIKE
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('WERKNEMER') and o.name = 'FK_WERKNEME_FUNCTIE_V_ROL')
alter table WERKNEMER
   drop constraint FK_WERKNEME_FUNCTIE_V_ROL
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('WERKNEMER') and o.name = 'FK_WERKNEME_WERKNEMER_GEBRUIKE')
alter table WERKNEMER
   drop constraint FK_WERKNEME_WERKNEMER_GEBRUIKE
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('WERKNEMER') and o.name = 'FK_WERKNEME_WERKNEMER_BEDRIJF')
alter table WERKNEMER
   drop constraint FK_WERKNEME_WERKNEMER_BEDRIJF
go

if exists (select 1
            from  sysobjects
           where  id = object_id('ADRESGEGEVENS')
            and   type = 'U')
   drop table ADRESGEGEVENS
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
            from  sysindexes
           where  id    = object_id('BEDRIJF')
            and   name  = 'ADRES_VAN_BEDRIJF_FK'
            and   indid > 0
            and   indid < 255)
   drop index BEDRIJF.ADRES_VAN_BEDRIJF_FK
go

if exists (select 1
            from  sysobjects
           where  id = object_id('BEDRIJF')
            and   type = 'U')
   drop table BEDRIJF
go

if exists (select 1
            from  sysobjects
           where  id = object_id('GEBRUIKER')
            and   type = 'U')
   drop table GEBRUIKER
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('GEBRUIKERTEL')
            and   name  = 'GEBRUIKERTEL2_FK'
            and   indid > 0
            and   indid < 255)
   drop index GEBRUIKERTEL.GEBRUIKERTEL2_FK
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('GEBRUIKERTEL')
            and   name  = 'GEBRUIKERTEL_FK'
            and   indid > 0
            and   indid < 255)
   drop index GEBRUIKERTEL.GEBRUIKERTEL_FK
go

if exists (select 1
            from  sysobjects
           where  id = object_id('GEBRUIKERTEL')
            and   type = 'U')
   drop table GEBRUIKERTEL
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('PROJECT')
            and   name  = 'PROJECT_GESTART_DOOR_FK'
            and   indid > 0
            and   indid < 255)
   drop index PROJECT.PROJECT_GESTART_DOOR_FK
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('PROJECT')
            and   name  = 'AUTEUR_VAN_PROJECT_FK'
            and   indid > 0
            and   indid < 255)
   drop index PROJECT.AUTEUR_VAN_PROJECT_FK
go

if exists (select 1
            from  sysobjects
           where  id = object_id('PROJECT')
            and   type = 'U')
   drop table PROJECT
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
           where  id    = object_id('TELEFOON_VAN_BEDRIJF')
            and   name  = 'TELEFOON_VAN_BEDRIJF2_FK'
            and   indid > 0
            and   indid < 255)
   drop index TELEFOON_VAN_BEDRIJF.TELEFOON_VAN_BEDRIJF2_FK
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('TELEFOON_VAN_BEDRIJF')
            and   name  = 'TELEFOON_VAN_BEDRIJF_FK'
            and   indid > 0
            and   indid < 255)
   drop index TELEFOON_VAN_BEDRIJF.TELEFOON_VAN_BEDRIJF_FK
go

if exists (select 1
            from  sysobjects
           where  id = object_id('TELEFOON_VAN_BEDRIJF')
            and   type = 'U')
   drop table TELEFOON_VAN_BEDRIJF
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
            and   name  = 'STATUS_VAN_VERGUNNING_FK'
            and   indid > 0
            and   indid < 255)
   drop index VERGUNNING.STATUS_VAN_VERGUNNING_FK
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('VERGUNNING')
            and   name  = 'VERGUNNINGSTYPE_FK'
            and   indid > 0
            and   indid < 255)
   drop index VERGUNNING.VERGUNNINGSTYPE_FK
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
            and   name  = 'TOEGEVOEGD_DOOR_FK'
            and   indid > 0
            and   indid < 255)
   drop index VERGUNNINGSINFORMATIE.TOEGEVOEGD_DOOR_FK
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

if exists(select 1 from systypes where name='ACHERNAAM')
   drop type ACHERNAAM
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

if exists(select 1 from systypes where name='BESTANDSLOCATIE')
   drop type BESTANDSLOCATIE
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

if exists (select 1
   from  sysobjects where type = 'D'
   and name = 'D_AANGEMAAKTOP'
   )
   drop default D_AANGEMAAKTOP
go

if exists (select 1
   from  sysobjects where type = 'D'
   and name = 'D_DATUMINFORMATIETOEGEVOEGD'
   )
   drop default D_DATUMINFORMATIETOEGEVOEGD
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
/* Default: D_AANGEMAAKTOP                                      */
/*==============================================================*/
create default D_AANGEMAAKTOP
    as 'sysdate'
go

/*==============================================================*/
/* Default: D_DATUMINFORMATIETOEGEVOEGD                         */
/*==============================================================*/
create default D_DATUMINFORMATIETOEGEVOEGD
    as 'sysdate'
go

/*==============================================================*/
/* Domain: AANGEMAAKTOP                                         */
/*==============================================================*/
create type AANGEMAAKTOP
   from datetime
go

execute sp_bindrule R_AANGEMAAKTOP, AANGEMAAKTOP
go

execute sp_bindefault D_AANGEMAAKTOP, 'AANGEMAAKTOP'
go

/*==============================================================*/
/* Domain: ACHERNAAM                                            */
/*==============================================================*/
create type ACHERNAAM
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
/* Domain: BESTANDSLOCATIE                                      */
/*==============================================================*/
create type BESTANDSLOCATIE
   from varchar(255)
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

execute sp_bindefault D_DATUMINFORMATIETOEGEVOEGD, 'DATUMINFORMATIETOEGEVOEGD'
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
   from date
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
/* Table: ADRESGEGEVENS                                         */
/*==============================================================*/
create table ADRESGEGEVENS (
   ADRESID              int                  identity,
   POSTCODE             varchar(6)           not null,
   HUISNUMMER           numeric(5,0)         not null 
      constraint CKC_HUISNUMMER_ADRESGEG check (HUISNUMMER between 00000001 and 99999999),
   TOEVOEGING           varchar(5)           null,
   constraint PK_ADRESGEGEVENS primary key (ADRESID),
   constraint AK_IDENTIFIER_2_ADRESGEG unique (POSTCODE, HUISNUMMER, TOEVOEGING)
)
go

/*==============================================================*/
/* Table: ADRES_VAN_GEBRUIKER                                   */
/*==============================================================*/
create table ADRES_VAN_GEBRUIKER (
   ADRESID              int                  not null,
   GEBRUIKERSNAAM       varchar(255)         not null 
      constraint CKC_GEBRUIKERSNAAM_ADRES_VA check (len(GEBRUIKERSNAAM) >= '4'),
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
   KVKNUMMER            numeric(8,0)         not null
      constraint CKC_KVKNUMMER_BEDRIJF check (len(KVKNUMMER) = 8),
   ADRESID              int                  not null,
   BEDRIJFSNAAM         varchar(255)         not null,
   BEDRIJFSWACHTWOORD   varchar(255)         not null,
   constraint PK_BEDRIJF primary key (KVKNUMMER)
)
go

/*==============================================================*/
/* Index: ADRES_VAN_BEDRIJF_FK                                  */
/*==============================================================*/




create nonclustered index ADRES_VAN_BEDRIJF_FK on BEDRIJF (ADRESID ASC)
go

/*==============================================================*/
/* Table: GEBRUIKER                                             */
/*==============================================================*/
create table GEBRUIKER (
   GEBRUIKERSNAAM       varchar(255)         not null 
      constraint CKC_GEBRUIKERSNAAM_GEBRUIKE2 check (len(GEBRUIKERSNAAM) >= '4'),
   WACHTWOORD           varchar(255)         not null,
   VOORNAAM             varchar(100)         not null,
   TUSSENVOEGSEL        varchar(25)          null,
   ACHTERNAAM           varchar(255)         not null,
   GEBOORTEDATUM        date	             not null 
      constraint CKC_GEBOORTEDATUM_GEBRUIKE check (GEBOORTEDATUM between '01-01-1900' and dateadd(year, -18, getdate())),
   GESLACHT             char(1)              not null 
      constraint CKC_GESLACHT_GEBRUIKE check (GESLACHT in ('M','V','O')),
   MAILADRES            varchar(255)         not null,
   constraint PK_GEBRUIKER primary key (GEBRUIKERSNAAM)
)
go

/*==============================================================*/
/* Table: GEBRUIKERTEL                                          */
/*==============================================================*/
create table GEBRUIKERTEL (
   TELEFOONNUMMER       varchar(20)          not null 
      constraint CKC_TELEFOONNUMMER_GEBRUIKE check (len(TELEFOONNUMMER) >= '8'),
   GEBRUIKERSNAAM       varchar(255)         not null 
      constraint CKC_GEBRUIKERSNAAM_GEBRUIKE check (len(GEBRUIKERSNAAM) >= '4'),
   constraint PK_GEBRUIKERTEL primary key (TELEFOONNUMMER, GEBRUIKERSNAAM)
)
go

/*==============================================================*/
/* Index: GEBRUIKERTEL_FK                                       */
/*==============================================================*/




create nonclustered index GEBRUIKERTEL_FK on GEBRUIKERTEL (TELEFOONNUMMER ASC)
go

/*==============================================================*/
/* Index: GEBRUIKERTEL2_FK                                      */
/*==============================================================*/




create nonclustered index GEBRUIKERTEL2_FK on GEBRUIKERTEL (GEBRUIKERSNAAM ASC)
go

/*==============================================================*/
/* Table: PROJECT                                               */
/*==============================================================*/
create table PROJECT (
   PROJECTID            int                  identity,
   KVKNUMMER            numeric(8,0)         null default 8
      constraint CKC_KVKNUMMER_PROJECT check (KVKNUMMER is null or (len(KVKNUMMER) = 8)),
   GEBRUIKERSNAAM       varchar(255)         not null 
      constraint CKC_GEBRUIKERSNAAM_PROJECT check (len(GEBRUIKERSNAAM) >= '4'),
   AANGEMAAKTOP         datetime             not null 
      constraint CKC_AANGEMAAKTOP_PROJECT check (AANGEMAAKTOP >= '01-01-1900'),
   WERKZAAMHEID         varchar(4000)        not null,
   XCOORDINAAT          float                not null,
   YCOORDINAAT          float                not null,
   constraint PK_PROJECT primary key (PROJECTID)
)
go

execute sp_bindefault D_AANGEMAAKTOP, 'PROJECT.AANGEMAAKTOP'
go

/*==============================================================*/
/* Index: AUTEUR_VAN_PROJECT_FK                                 */
/*==============================================================*/




create nonclustered index AUTEUR_VAN_PROJECT_FK on PROJECT (GEBRUIKERSNAAM ASC)
go

/*==============================================================*/
/* Index: PROJECT_GESTART_DOOR_FK                               */
/*==============================================================*/




create nonclustered index PROJECT_GESTART_DOOR_FK on PROJECT (KVKNUMMER ASC)
go

/*==============================================================*/
/* Table: ROL                                                   */
/*==============================================================*/
create table ROL (
   TYPE                 varchar(255)         not null,
   constraint PK_ROL primary key (TYPE)
)
go

/*==============================================================*/
/* Table: TELEFOON                                              */
/*==============================================================*/
create table TELEFOON (
   TELEFOONNUMMER       varchar(20)          not null 
      constraint CKC_TELEFOONNUMMER_TELEFOON2 check (len(TELEFOONNUMMER) >= '8'),
   constraint PK_TELEFOON primary key (TELEFOONNUMMER)
)
go

/*==============================================================*/
/* Table: TELEFOON_VAN_BEDRIJF                                  */
/*==============================================================*/
create table TELEFOON_VAN_BEDRIJF (
   TELEFOONNUMMER       varchar(20)          not null 
      constraint CKC_TELEFOONNUMMER_TELEFOON check (len(TELEFOONNUMMER) >= '8'),
   KVKNUMMER            numeric(8,0)         not null
      constraint CKC_KVKNUMMER_TELEFOON check (len(KVKNUMMER) = 8),
   constraint PK_TELEFOON_VAN_BEDRIJF primary key (TELEFOONNUMMER, KVKNUMMER)
)
go

/*==============================================================*/
/* Index: TELEFOON_VAN_BEDRIJF_FK                               */
/*==============================================================*/




create nonclustered index TELEFOON_VAN_BEDRIJF_FK on TELEFOON_VAN_BEDRIJF (TELEFOONNUMMER ASC)
go

/*==============================================================*/
/* Index: TELEFOON_VAN_BEDRIJF2_FK                              */
/*==============================================================*/




create nonclustered index TELEFOON_VAN_BEDRIJF2_FK on TELEFOON_VAN_BEDRIJF (KVKNUMMER ASC)
go

/*==============================================================*/
/* Table: VERGUNNING                                            */
/*==============================================================*/
create table VERGUNNING (
   VERGUNNINGSID        int                  identity,
   VERGUNNINGSNAAM      varchar(255)         not null,
   STATUS               varchar(255)         not null 
      constraint CKC_STATUS_VERGUNNI2 check (STATUS in ('Aangevraagd','Afwewezen','Uitgegeven','Verlopen','Bezwaar')),
   PROJECTID            int                  not null,
   OMSCHRIJVING         varchar(4000)        not null,
   DATUMAANVRAAG        datetime             not null 
      constraint CKC_DATUMAANVRAAG_VERGUNNI check (DATUMAANVRAAG >= '01-01-1900'),
   DATUMUITGAVE         datetime             null 
      constraint CKC_DATUMUITGAVE_VERGUNNI check (DATUMUITGAVE is null or (DATUMUITGAVE >= '01-01-1900')),
   DATUMVERLOOP         datetime             null 
      constraint CKC_DATUMVERLOOP_VERGUNNI check (DATUMVERLOOP is null or (DATUMVERLOOP >= '01-01-1990')),
   constraint PK_VERGUNNING primary key (VERGUNNINGSID)
)
go

/*==============================================================*/
/* Index: VERGUNNINGSTYPE_FK                                    */
/*==============================================================*/




create nonclustered index VERGUNNINGSTYPE_FK on VERGUNNING (VERGUNNINGSNAAM ASC)
go

/*==============================================================*/
/* Index: STATUS_VAN_VERGUNNING_FK                              */
/*==============================================================*/




create nonclustered index STATUS_VAN_VERGUNNING_FK on VERGUNNING (STATUS ASC)
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
   PROJECTID            int                  not null,
   VOLGNUMMER           int                  not null,
   GEBRUIKERSNAAM       varchar(255)         not null 
      constraint CKC_GEBRUIKERSNAAM_VERGUNNI check (len(GEBRUIKERSNAAM) >= '4'),
   UITLEG               varchar(4000)        not null,
   DATUM                datetime             not null 
      constraint CKC_DATUM_VERGUNNI check (DATUM >= '01-01-1900'),
   LOCATIE              varchar(255)         null,
   constraint PK_VERGUNNINGSINFORMATIE primary key (PROJECTID, VOLGNUMMER)
)
go

execute sp_bindefault D_DATUMINFORMATIETOEGEVOEGD, 'VERGUNNINGSINFORMATIE.DATUM'
go

/*==============================================================*/
/* Index: TOEGEVOEGD_DOOR_FK                                    */
/*==============================================================*/




create nonclustered index TOEGEVOEGD_DOOR_FK on VERGUNNINGSINFORMATIE (GEBRUIKERSNAAM ASC)
go

/*==============================================================*/
/* Table: VERGUNNINGSTATUS                                      */
/*==============================================================*/
create table VERGUNNINGSTATUS (
   STATUS               varchar(255)         not null 
      constraint CKC_STATUS_VERGUNNI check (STATUS in ('Aangevraagd','Afwewezen','Uitgegeven','Verlopen','Bezwaar')),
   constraint PK_VERGUNNINGSTATUS primary key (STATUS)
)
go

/*==============================================================*/
/* Table: VERGUNNINGSTYPE                                       */
/*==============================================================*/
create table VERGUNNINGSTYPE (
   VERGUNNINGSNAAM      varchar(255)         not null,
   constraint PK_VERGUNNINGSTYPE primary key (VERGUNNINGSNAAM)
)
go

/*==============================================================*/
/* Table: WERKNEMER                                             */
/*==============================================================*/
create table WERKNEMER (
   GEBRUIKERSNAAM       varchar(255)         not null 
      constraint CKC_GEBRUIKERSNAAM_WERKNEME check (len(GEBRUIKERSNAAM) >= '4'),
   KVKNUMMER            numeric(8,0)         not null
      constraint CKC_KVKNUMMER_WERKNEME check (len(KVKNUMMER) = 8),
   TYPE                 varchar(255)         null,
   constraint PK_WERKNEMER primary key (GEBRUIKERSNAAM, KVKNUMMER)
)
go

/*==============================================================*/
/* Index: WERKNEMER2_FK                                         */
/*==============================================================*/




create nonclustered index WERKNEMER2_FK on WERKNEMER (KVKNUMMER ASC)
go

alter table BEDRIJF
   add constraint FK_BEDRIJF_ADRES_VAN_ADRESGEG foreign key (ADRESID)
      references ADRESGEGEVENS (ADRESID)
go

alter table PROJECT
   add constraint FK_PROJECT_AUTEUR_VA_GEBRUIKE foreign key (GEBRUIKERSNAAM)
      references GEBRUIKER (GEBRUIKERSNAAM)
go

alter table VERGUNNING
   add constraint FK_VERGUNNI_STATUS_VA_VERGUNNI foreign key (STATUS)
      references VERGUNNINGSTATUS (STATUS)
go

alter table VERGUNNING
   add constraint FK_VERGUNNI_VERGUNNIN_VERGUNNI foreign key (VERGUNNINGSNAAM)
      references VERGUNNINGSTYPE (VERGUNNINGSNAAM)
go

alter table VERGUNNING
   add constraint FK_VERGUNNI_VERGUNNIN_PROJECT foreign key (PROJECTID)
      references PROJECT (PROJECTID)
go

alter table VERGUNNINGSINFORMATIE
   add constraint FK_VERGUNNI_INFORMATI_PROJECT foreign key (PROJECTID)
      references PROJECT (PROJECTID)
go

alter table VERGUNNINGSINFORMATIE
   add constraint FK_VERGUNNI_TOEGEVOEG_GEBRUIKE foreign key (GEBRUIKERSNAAM)
      references GEBRUIKER (GEBRUIKERSNAAM)
go

alter table WERKNEMER
   add constraint FK_WERKNEME_FUNCTIE_V_ROL foreign key (TYPE)
      references ROL (TYPE)
go

alter table WERKNEMER
   add constraint FK_WERKNEME_WERKNEMER_GEBRUIKE foreign key (GEBRUIKERSNAAM)
      references GEBRUIKER (GEBRUIKERSNAAM)
go

alter table WERKNEMER
   add constraint FK_WERKNEME_WERKNEMER_BEDRIJF foreign key (KVKNUMMER)
      references BEDRIJF (KVKNUMMER)
go

