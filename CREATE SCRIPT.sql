/*==============================================================*/
/* DBMS name:      ORACLE Version 12c                           */
/* Created on:     7-5-2017 19:38:21                            */
/*==============================================================*/

alter table BEDRIJF
   drop constraint FK_BEDRIJF_ADRES_VAN_ADRESGEG;

alter table BEDRIJF
   drop constraint FK_BEDRIJF_TELEFOON__TELEFOON;

alter table BESTAND
   drop constraint FK_BESTAND_VERGUNNIN_VERGUNNI;

alter table GEBRUIKER
   drop constraint FK_GEBRUIKE_ADRES_VAN_ADRESGEG;

alter table PROJECT
   drop constraint FK_PROJECT_AUTEUR_VA_GEBRUIKE;

alter table PROJECT
   drop constraint FK_PROJECT_LOCATIE_V_ADRESGEG;

alter table TELEFOON
   drop constraint FK_TELEFOON_GEBRUIKER_GEBRUIKE;

alter table TELEFOON
   drop constraint FK_TELEFOON_TELEFOON__BEDRIJF;

alter table VERGUNNING
   drop constraint FK_VERGUNNI_STATUS_VA_VERGUNNI;

alter table VERGUNNING
   drop constraint FK_VERGUNNI_VERGUNNIN_VERGUNNI;

alter table VERGUNNING
   drop constraint FK_VERGUNNI_VERGUNNIN_PROJECT;

alter table VERGUNNINGSINFORMATIE
   drop constraint FK_VERGUNNI_INFORMATI_VERGUNNI;

alter table VERGUNNINGSINFORMATIE
   drop constraint FK_VERGUNNI_TOEGEVOEG_GEBRUIKE;

alter table VERGUNNINGSINFORMATIE
   drop constraint FK_VERGUNNI_VERGUNNIN_BESTAND;

alter table WERKNEMER
   drop constraint FK_WERKNEME_FUNCTIE_V_ROL;

alter table WERKNEMER
   drop constraint FK_WERKNEME_WERKNEMER_GEBRUIKE;

alter table WERKNEMER
   drop constraint FK_WERKNEME_WERKNEMER_BEDRIJF;

drop table ADRESGEGEVENS cascade constraints;

drop index TELEFOON_VAN_BEDRIJF2_FK;

drop index ADRES_VAN_BEDRIJF_FK;

drop table BEDRIJF cascade constraints;

drop index VERGUNNINGSBESTAND_FK;

drop table BESTAND cascade constraints;

drop index FUNCTIE_VAN_GEBRUIKER_FK;

drop index ADRES_VAN_GEBRUIKER_FK;

drop table GEBRUIKER cascade constraints;

drop index LOCATIE_VAN_PROJECT_FK;

drop index AUTEUR_VAN_PROJECT_FK;

drop table PROJECT cascade constraints;

drop table ROL cascade constraints;

drop index TELEFOON_VAN_BEDRIJF_FK;

drop index GEBRUIKERTEL_FK;

drop table TELEFOON cascade constraints;

drop index VERGUNNING_VAN_PROJECT_FK;

drop index STATUS_VAN_VERGUNNING_FK;

drop index VERGUNNINGSTYPE_FK;

drop table VERGUNNING cascade constraints;

drop index TOEGEVOEGD_DOOR_FK;

drop index VERGUNNINGSBESTAND2_FK;

drop table VERGUNNINGSINFORMATIE cascade constraints;

drop table VERGUNNINGSTATUS cascade constraints;

drop table VERGUNNINGSTYPE cascade constraints;

drop index WERKNEMER2_FK;

drop table WERKNEMER cascade constraints;

/*==============================================================*/
/* Table: ADRESGEGEVENS                                         */
/*==============================================================*/
create table ADRESGEGEVENS (
   ADRESID              INTEGER               not null,
   POSTCODE             VARCHAR2(6)           not null,
   HUISNUMMER           INTEGER               not null,
   TOEVOEGING           CHAR(1),
   constraint PK_ADRESGEGEVENS primary key (ADRESID)
);

/*==============================================================*/
/* Table: BEDRIJF                                               */
/*==============================================================*/
create table BEDRIJF (
   KVKNUMMER            INTEGER               not null,
   ADRESID              INTEGER               not null,
   TELEFOONNUMMER       INTEGER               not null,
   BEDRIJFSNAAM         VARCHAR2(255)         not null,
   BEDRIJFSWACHTWOORD   VARCHAR2(255)         not null,
   constraint PK_BEDRIJF primary key (KVKNUMMER)
);

/*==============================================================*/
/* Index: ADRES_VAN_BEDRIJF_FK                                  */
/*==============================================================*/
create index ADRES_VAN_BEDRIJF_FK on BEDRIJF (
   ADRESID ASC
);

/*==============================================================*/
/* Index: TELEFOON_VAN_BEDRIJF2_FK                              */
/*==============================================================*/
create index TELEFOON_VAN_BEDRIJF2_FK on BEDRIJF (
   TELEFOONNUMMER ASC
);

/*==============================================================*/
/* Table: BESTAND                                               */
/*==============================================================*/
create table BESTAND (
   LOCATIE              VARCHAR2(255)         not null,
   VERGUNNINGSID        INTEGER               not null,
   VOLGNUMMER           INTEGER               not null,
   constraint PK_BESTAND primary key (LOCATIE, VERGUNNINGSID, VOLGNUMMER)
);

/*==============================================================*/
/* Index: VERGUNNINGSBESTAND_FK                                 */
/*==============================================================*/
create index VERGUNNINGSBESTAND_FK on BESTAND (
   VERGUNNINGSID ASC,
   VOLGNUMMER ASC
);

/*==============================================================*/
/* Table: GEBRUIKER                                             */
/*==============================================================*/
create table GEBRUIKER (
   GEBRUIKERSNAAM       VARCHAR2(255)         not null,
   ADRESID              INTEGER               not null,
   VOORNAAM             VARCHAR2(255)         not null,
   TUSSENVOEGSEL        VARCHAR2(15)          not null,
   ACHTERNAAM           VARCHAR2(255)         not null,
   GEBOORTEDATUM        DATE                  not null,
   GESLACHT             CHAR(1)               not null,
   MAILADRES            VARCHAR2(255)         not null,
   constraint PK_GEBRUIKER primary key (GEBRUIKERSNAAM)
);

/*==============================================================*/
/* Index: ADRES_VAN_GEBRUIKER_FK                                */
/*==============================================================*/
create index ADRES_VAN_GEBRUIKER_FK on GEBRUIKER (
   ADRESID ASC
);

/*==============================================================*/
/* Index: FUNCTIE_VAN_GEBRUIKER_FK                              */
/*==============================================================*/
create index FUNCTIE_VAN_GEBRUIKER_FK on GEBRUIKER (
   TYPE ASC
);

/*==============================================================*/
/* Table: PROJECT                                               */
/*==============================================================*/
create table PROJECT (
   PROJECTID            INTEGER               not null,
   ADRESID              INTEGER               not null,
   GEBRUIKERSNAAM       VARCHAR2(255)         not null,
   AANGEMAAKTOP         DATE,
   WERKZAAMHEID         VARCHAR2(255),
   constraint PK_PROJECT primary key (PROJECTID)
);

/*==============================================================*/
/* Index: AUTEUR_VAN_PROJECT_FK                                 */
/*==============================================================*/
create index AUTEUR_VAN_PROJECT_FK on PROJECT (
   GEBRUIKERSNAAM ASC
);

/*==============================================================*/
/* Index: LOCATIE_VAN_PROJECT_FK                                */
/*==============================================================*/
create index LOCATIE_VAN_PROJECT_FK on PROJECT (
   ADRESID ASC
);

/*==============================================================*/
/* Table: ROL                                                   */
/*==============================================================*/
create table ROL (
   TYPE                 VARCHAR2(255)         not null,
   constraint PK_ROL primary key (TYPE)
);

/*==============================================================*/
/* Table: TELEFOON                                              */
/*==============================================================*/
create table TELEFOON (
   TELEFOONNUMMER       INTEGER               not null,
   GEBRUIKERSNAAM       VARCHAR2(255),
   KVKNUMMER            INTEGER,
   constraint PK_TELEFOON primary key (TELEFOONNUMMER)
);

/*==============================================================*/
/* Index: GEBRUIKERTEL_FK                                       */
/*==============================================================*/
create index GEBRUIKERTEL_FK on TELEFOON (
   GEBRUIKERSNAAM ASC
);

/*==============================================================*/
/* Index: TELEFOON_VAN_BEDRIJF_FK                               */
/*==============================================================*/
create index TELEFOON_VAN_BEDRIJF_FK on TELEFOON (
   KVKNUMMER ASC
);

/*==============================================================*/
/* Table: VERGUNNING                                            */
/*==============================================================*/
create table VERGUNNING (
   VERGUNNINGSID        INTEGER               not null,
   VERGUNNINGSNAAM      VARCHAR2(255)         not null,
   STATUS               VARCHAR2(255)         not null,
   PROJECTID            INTEGER               not null,
   OMSCHRIJVING         VARCHAR2(255)         not null,
   DATUMAANVRAAG        DATE                  not null,
   DATUMUITGAVE         DATE,
   DATUMVERLOOP         DATE,
   constraint PK_VERGUNNING primary key (VERGUNNINGSID)
);

/*==============================================================*/
/* Index: VERGUNNINGSTYPE_FK                                    */
/*==============================================================*/
create index VERGUNNINGSTYPE_FK on VERGUNNING (
   VERGUNNINGSNAAM ASC
);

/*==============================================================*/
/* Index: STATUS_VAN_VERGUNNING_FK                              */
/*==============================================================*/
create index STATUS_VAN_VERGUNNING_FK on VERGUNNING (
   STATUS ASC
);

/*==============================================================*/
/* Index: VERGUNNING_VAN_PROJECT_FK                             */
/*==============================================================*/
create index VERGUNNING_VAN_PROJECT_FK on VERGUNNING (
   PROJECTID ASC
);

/*==============================================================*/
/* Table: VERGUNNINGSINFORMATIE                                 */
/*==============================================================*/
create table VERGUNNINGSINFORMATIE (
   VERGUNNINGSID        INTEGER               not null,
   VOLGNUMMER           INTEGER               not null,
   GEBRUIKERSNAAM       VARCHAR2(255)         not null,
   LOCATIE              VARCHAR2(255),
   BES_VERGUNNINGSID    INTEGER,
   UITLEG               VARCHAR2(255)         not null,
   DATUM                DATE                  not null,
   constraint PK_VERGUNNINGSINFORMATIE primary key (VERGUNNINGSID, VOLGNUMMER)
);

/*==============================================================*/
/* Index: VERGUNNINGSBESTAND2_FK                                */
/*==============================================================*/
create index VERGUNNINGSBESTAND2_FK on VERGUNNINGSINFORMATIE (
   LOCATIE ASC,
   BES_VERGUNNINGSID ASC,
   VOLGNUMMER ASC
);

/*==============================================================*/
/* Index: TOEGEVOEGD_DOOR_FK                                    */
/*==============================================================*/
create index TOEGEVOEGD_DOOR_FK on VERGUNNINGSINFORMATIE (
   GEBRUIKERSNAAM ASC
);

/*==============================================================*/
/* Table: VERGUNNINGSTATUS                                      */
/*==============================================================*/
create table VERGUNNINGSTATUS (
   STATUS               VARCHAR2(255)         not null,
   constraint PK_VERGUNNINGSTATUS primary key (STATUS)
);

/*==============================================================*/
/* Table: VERGUNNINGSTYPE                                       */
/*==============================================================*/
create table VERGUNNINGSTYPE (
   VERGUNNINGSNAAM      VARCHAR2(255)         not null,
   constraint PK_VERGUNNINGSTYPE primary key (VERGUNNINGSNAAM)
);

/*==============================================================*/
/* Table: WERKNEMER                                             */
/*==============================================================*/
create table WERKNEMER (
   GEBRUIKERSNAAM       VARCHAR2(255)         not null,
   KVKNUMMER            INTEGER               not null,
   TYPE                 VARCHAR2(255),
   constraint PK_WERKNEMER primary key (GEBRUIKERSNAAM, KVKNUMMER)
);

/*==============================================================*/
/* Index: WERKNEMER2_FK                                         */
/*==============================================================*/
create index WERKNEMER2_FK on WERKNEMER (
   KVKNUMMER ASC
);

alter table BEDRIJF
   add constraint FK_BEDRIJF_ADRES_VAN_ADRESGEG foreign key (ADRESID)
      references ADRESGEGEVENS (ADRESID);

alter table BEDRIJF
   add constraint FK_BEDRIJF_TELEFOON__TELEFOON foreign key (TELEFOONNUMMER)
      references TELEFOON (TELEFOONNUMMER);

alter table BESTAND
   add constraint FK_BESTAND_VERGUNNIN_VERGUNNI foreign key (VERGUNNINGSID, VOLGNUMMER)
      references VERGUNNINGSINFORMATIE (VERGUNNINGSID, VOLGNUMMER);

alter table GEBRUIKER
   add constraint FK_GEBRUIKE_ADRES_VAN_ADRESGEG foreign key (ADRESID)
      references ADRESGEGEVENS (ADRESID);

alter table PROJECT
   add constraint FK_PROJECT_AUTEUR_VA_GEBRUIKE foreign key (GEBRUIKERSNAAM)
      references GEBRUIKER (GEBRUIKERSNAAM);

alter table PROJECT
   add constraint FK_PROJECT_LOCATIE_V_ADRESGEG foreign key (ADRESID)
      references ADRESGEGEVENS (ADRESID);

alter table TELEFOON
   add constraint FK_TELEFOON_GEBRUIKER_GEBRUIKE foreign key (GEBRUIKERSNAAM)
      references GEBRUIKER (GEBRUIKERSNAAM);

alter table TELEFOON
   add constraint FK_TELEFOON_TELEFOON__BEDRIJF foreign key (KVKNUMMER)
      references BEDRIJF (KVKNUMMER);

alter table VERGUNNING
   add constraint FK_VERGUNNI_STATUS_VA_VERGUNNI foreign key (STATUS)
      references VERGUNNINGSTATUS (STATUS);

alter table VERGUNNING
   add constraint FK_VERGUNNI_VERGUNNIN_VERGUNNI foreign key (VERGUNNINGSNAAM)
      references VERGUNNINGSTYPE (VERGUNNINGSNAAM);

alter table VERGUNNING
   add constraint FK_VERGUNNI_VERGUNNIN_PROJECT foreign key (PROJECTID)
      references PROJECT (PROJECTID);

alter table VERGUNNINGSINFORMATIE
   add constraint FK_VERGUNNI_INFORMATI_VERGUNNI foreign key (VERGUNNINGSID)
      references VERGUNNING (VERGUNNINGSID);

alter table VERGUNNINGSINFORMATIE
   add constraint FK_VERGUNNI_TOEGEVOEG_GEBRUIKE foreign key (GEBRUIKERSNAAM)
      references GEBRUIKER (GEBRUIKERSNAAM);

alter table VERGUNNINGSINFORMATIE
   add constraint FK_VERGUNNI_VERGUNNIN_BESTAND foreign key (LOCATIE, BES_VERGUNNINGSID, VOLGNUMMER)
      references BESTAND (LOCATIE, VERGUNNINGSID, VOLGNUMMER);

alter table WERKNEMER
   add constraint FK_WERKNEME_FUNCTIE_V_ROL foreign key (TYPE)
      references ROL (TYPE);

alter table WERKNEMER
   add constraint FK_WERKNEME_WERKNEMER_GEBRUIKE foreign key (GEBRUIKERSNAAM)
      references GEBRUIKER (GEBRUIKERSNAAM);

alter table WERKNEMER
   add constraint FK_WERKNEME_WERKNEMER_BEDRIJF foreign key (KVKNUMMER)
      references BEDRIJF (KVKNUMMER);

SELECT * FROM Adresgegevens
SELECT * FROM Bedrijf
SELECT * FROM Bestand
SELECT * FROM Gebruiker
SELECT * FROM Project
SELECT * FROM Rol
SELECT * FROM Telefoon
SELECT * FROM Vergunningsinformatie
SELECT * FROM VergunningStatus
SELECT * FROM Vergunningstype
SELECT * FROM Werknemer
