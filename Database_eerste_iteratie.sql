/*==============================================================*/
/* DBMS name:      MySQL 5.0                                    */
/* Created on:     12-5-2017 12:26:07                           */
/*==============================================================*/


alter table BEDRIJF drop foreign key FK_ADRES_VAN_BEDRIJF;

alter table PROJECT drop foreign key FK_AUTEUR_VAN_PROJECT;

alter table VERGUNNING drop foreign key FK_STATUS_VAN_VERGUNNING;

alter table VERGUNNING drop foreign key FK_VERGUNNINGSTYPE;

alter table VERGUNNING drop foreign key FK_VERGUNNING_VAN_PROJECT;

alter table VERGUNNINGSINFORMATIE drop foreign key FK_INFORMATIEVERGUNNING;

alter table VERGUNNINGSINFORMATIE drop foreign key FK_TOEGEVOEGD_DOOR;

alter table WERKNEMER drop foreign key FK_FUNCTIE_VAN_GEBRUIKER;

alter table WERKNEMER drop foreign key FK_WERKNEMER;

alter table WERKNEMER drop foreign key FK_WERKNEMER2;

drop table if exists ADRESGEGEVENS;

drop table if exists ADRES_VAN_GEBRUIKER;

drop table if exists BEDRIJF;

drop table if exists GEBRUIKER;

drop table if exists GEBRUIKERTEL;

drop table if exists PROJECT;

drop table if exists ROL;

drop table if exists TELEFOON;

drop table if exists TELEFOON_VAN_BEDRIJF;

drop table if exists VERGUNNING;

drop table if exists VERGUNNINGSINFORMATIE;

drop table if exists VERGUNNINGSTATUS;

drop table if exists VERGUNNINGSTYPE;

drop table if exists WERKNEMER;

/*==============================================================*/
/* Table: ADRESGEGEVENS                                         */
/*==============================================================*/
create table ADRESGEGEVENS
(
   ADRESID              int not null auto_increment,
   POSTCODE             varchar(6) not null,
   HUISNUMMER           numeric(5,0) not null,
   TOEVOEGING           varchar(5),
   primary key (ADRESID),
   key AK_IDENTIFIER_2 (POSTCODE, HUISNUMMER, TOEVOEGING)
);

/*==============================================================*/
/* Table: ADRES_VAN_GEBRUIKER                                   */
/*==============================================================*/
create table ADRES_VAN_GEBRUIKER
(
   ADRESID              int not null,
   GEBRUIKERSNAAM       varchar(255) not null,
   primary key (ADRESID, GEBRUIKERSNAAM)
);

/*==============================================================*/
/* Table: BEDRIJF                                               */
/*==============================================================*/
create table BEDRIJF
(
   KVKNUMMER            numeric(8,0) not null,
   ADRESID              int not null,
   BEDRIJFSNAAM         varchar(255) not null,
   BEDRIJFSWACHTWOORD   varchar(255) not null,
   primary key (KVKNUMMER)
);

/*==============================================================*/
/* Table: GEBRUIKER                                             */
/*==============================================================*/
create table GEBRUIKER
(
   GEBRUIKERSNAAM       varchar(255) not null,
   WACHTWOORD           varchar(255) not null,
   VOORNAAM             varchar(100) not null,
   TUSSENVOEGSEL        varchar(25),
   ACHTERNAAM           varchar(255) not null,
   GEBOORTEDATUM        datetime not null,
   GESLACHT             char(1) not null,
   MAILADRES            varchar(255) not null,
   primary key (GEBRUIKERSNAAM)
);

/*==============================================================*/
/* Table: GEBRUIKERTEL                                          */
/*==============================================================*/
create table GEBRUIKERTEL
(
   TELEFOONNUMMER       varchar(20) not null,
   GEBRUIKERSNAAM       varchar(255) not null,
   primary key (TELEFOONNUMMER, GEBRUIKERSNAAM)
);

/*==============================================================*/
/* Table: PROJECT                                               */
/*==============================================================*/
create table PROJECT
(
   PROJECTID            int not null auto_increment,
   KVKNUMMER            numeric(8,0),
   GEBRUIKERSNAAM       varchar(255) not null,
   AANGEMAAKTOP         datetime not null,
   WERKZAAMHEID         varchar(4000) not null,
   XCOORDINAAT          float not null,
   YCOORDINAAT          float not null,
   primary key (PROJECTID)
);

/*==============================================================*/
/* Table: ROL                                                   */
/*==============================================================*/
create table ROL
(
   TYPE                 varchar(255) not null,
   primary key (TYPE)
);

/*==============================================================*/
/* Table: TELEFOON                                              */
/*==============================================================*/
create table TELEFOON
(
   TELEFOONNUMMER       varchar(20) not null,
   primary key (TELEFOONNUMMER)
);

/*==============================================================*/
/* Table: TELEFOON_VAN_BEDRIJF                                  */
/*==============================================================*/
create table TELEFOON_VAN_BEDRIJF
(
   TELEFOONNUMMER       varchar(20) not null,
   KVKNUMMER            numeric(8,0) not null,
   primary key (TELEFOONNUMMER, KVKNUMMER)
);

/*==============================================================*/
/* Table: VERGUNNING                                            */
/*==============================================================*/
create table VERGUNNING
(
   VERGUNNINGSID        int not null auto_increment,
   VERGUNNINGSNAAM      varchar(255) not null,
   STATUS               varchar(255) not null,
   PROJECTID            int not null,
   OMSCHRIJVING         varchar(4000) not null,
   DATUMAANVRAAG        datetime not null,
   DATUMUITGAVE         datetime,
   DATUMVERLOOP         datetime,
   primary key (VERGUNNINGSID)
);

/*==============================================================*/
/* Table: VERGUNNINGSINFORMATIE                                 */
/*==============================================================*/
create table VERGUNNINGSINFORMATIE
(
   PROJECTID            int not null,
   VOLGNUMMER           int not null,
   GEBRUIKERSNAAM       varchar(255) not null,
   UITLEG               varchar(4000) not null,
   DATUM                datetime not null,
   LOCATIE              varchar(255),
   primary key (PROJECTID, VOLGNUMMER)
);

/*==============================================================*/
/* Table: VERGUNNINGSTATUS                                      */
/*==============================================================*/
create table VERGUNNINGSTATUS
(
   STATUS               varchar(255) not null,
   primary key (STATUS)
);

/*==============================================================*/
/* Table: VERGUNNINGSTYPE                                       */
/*==============================================================*/
create table VERGUNNINGSTYPE
(
   VERGUNNINGSNAAM      varchar(255) not null,
   primary key (VERGUNNINGSNAAM)
);

/*==============================================================*/
/* Table: WERKNEMER                                             */
/*==============================================================*/
create table WERKNEMER
(
   GEBRUIKERSNAAM       varchar(255) not null,
   KVKNUMMER            numeric(8,0) not null,
   TYPE                 varchar(255),
   primary key (GEBRUIKERSNAAM, KVKNUMMER)
);

alter table BEDRIJF add constraint FK_ADRES_VAN_BEDRIJF foreign key (ADRESID)
      references ADRESGEGEVENS (ADRESID);

alter table PROJECT add constraint FK_AUTEUR_VAN_PROJECT foreign key (GEBRUIKERSNAAM)
      references GEBRUIKER (GEBRUIKERSNAAM);

alter table VERGUNNING add constraint FK_STATUS_VAN_VERGUNNING foreign key (STATUS)
      references VERGUNNINGSTATUS (STATUS);

alter table VERGUNNING add constraint FK_VERGUNNINGSTYPE foreign key (VERGUNNINGSNAAM)
      references VERGUNNINGSTYPE (VERGUNNINGSNAAM);

alter table VERGUNNING add constraint FK_VERGUNNING_VAN_PROJECT foreign key (PROJECTID)
      references PROJECT (PROJECTID);

alter table VERGUNNINGSINFORMATIE add constraint FK_INFORMATIEVERGUNNING foreign key (PROJECTID)
      references PROJECT (PROJECTID);

alter table VERGUNNINGSINFORMATIE add constraint FK_TOEGEVOEGD_DOOR foreign key (GEBRUIKERSNAAM)
      references GEBRUIKER (GEBRUIKERSNAAM);

alter table WERKNEMER add constraint FK_FUNCTIE_VAN_GEBRUIKER foreign key (TYPE)
      references ROL (TYPE) on delete restrict on update restrict;

alter table WERKNEMER add constraint FK_WERKNEMER foreign key (GEBRUIKERSNAAM)
      references GEBRUIKER (GEBRUIKERSNAAM);

alter table WERKNEMER add constraint FK_WERKNEMER2 foreign key (KVKNUMMER)
      references BEDRIJF (KVKNUMMER);

