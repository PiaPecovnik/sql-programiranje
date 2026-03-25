-- -----------------------------------
-- Predmet: SQL Programiranje
-- Vsebina: Naloga 1
-- Avtor:   Pia pečovnik
-- Datum:   22.03.2026
-- -----------------------------------

-- KORAK 0: Priprava podatkovne baze
DROP DATABASE GasilskaZveza2026;
CREATE DATABASE GasilskaZveza2026;
USE GasilskaZveza2026;

-- Korak 1: Izdelajte prvi dve tabeli, vendar pri obeh tabelah izpustite zadnji stolpec.
CREATE TABLE Gasilec (
    IdGasilca INTEGER NOT NULL,
    Ime VARCHAR(60) NOT NULL,
    Priimek VARCHAR(60) NOT NULL,
    NazivMaticnegaDrustva INTEGER NOT NULL,
    Vloga VARCHAR(30) NOT NULL,
    ClanOd DATE NOT NULL
);
CREATE TABLE Lokacija (
    IdLokacije INTEGER NOT NULL,
    OpisLokacije VARCHAR(80) NOT NULL,
    DatumKlica VARCHAR(50) NOT NULL,
    OcenjenUkrep DATE NOT NULL
);

-- Korak 2: Strukturo ustvarjene druge tabele prikažite z uporabo ustreznega SQL ukaza.
DESCRIBE Lokacija;

-- KORAK 3: Poljubno preimenujte drugo tabelo.
RENAME TABLE Lokacija TO Intervencija;

-- KORAK 4: V prvo tabelo dodajte manjkajoč stolpec.
ALTER TABLE Gasilec
    ADD COLUMN Aktiven BOOL NOT NULL;
    
-- KORAK 5: V drugo tabelo dodajte manjkajoč stolpec na tretje mesto.
ALTER TABLE Intervencija
    ADD COLUMN IdGasilcaOperater INTEGER AFTER OpisLokacije;

-- KORAK 6: Spremenite ime poljubnega stolpca v drugi tabeli.
ALTER TABLE Intervencija CHANGE OpisLokacije Lokacija VARCHAR(80) NOT NULL;

-- Korak 7: Spremenite podatkovni tip poljubnega stolpca v drugi tabeli.
ALTER TABLE Intervencija
MODIFY COLUMN DatumKlica DATE NOT NULL,
MODIFY COLUMN OcenjenUkrep VARCHAR(50) NOT NULL;

-- Korak 8: Izbrišite stolpec iz koraka 7.
DESCRIBE Intervencija;
ALTER TABLE Intervencija
DROP COLUMN DatumKlica;
DESCRIBE Intervencija;

-- Korak 9: Poljubnemu stolpcu druge tabele smiselno spremenite tip v ENUM.
ALTER TABLE Intervencija
    MODIFY COLUMN OcenjenUkrep ENUM('Požar','Poplava','Potres','Prometna nesreča','Tehnično reševanje','Iskanje pogrešanih','Razliv nevarnih snovi', 'Manjša nesreča') DEFAULT 'Požar';
DESCRIBE Intervencija;

-- Korak 10: Izbrišite drugo tabelo.
DROP TABLE Intervencija;

-- Korak 11: Ponovno ustvarite drugo tabelo, tokrat z vsemi stolpci.
CREATE TABLE Intervencija (
    IdLokacije INTEGER NOT NULL,
    Lokacija VARCHAR(80) NOT NULL,
    DatumKlica DATE NOT NULL,
    OcenjenUkrep VARCHAR(50) NOT NULL,
    IdGasilcaOperater INTEGER NOT NULL
);
DESCRIBE Intervencija;

-- Korak 12: Ustvarite tretjo tabelo brez zadnjega stolpca.
CREATE TABLE Posredovanje (
    IdLokacije INTEGER NOT NULL,
    IdGasilca INTEGER NOT NULL
);
DESCRIBE Posredovanje;

-- Korak 13: Posodobite tretjo tabelo tako, da bo vsebovala vse stolpce.
ALTER TABLE Posredovanje
    ADD COLUMN DatumPosredovanja DATE NOT NULL;
DESCRIBE Posredovanje;

-- --------------------------------------------------------------------------------
-- --------------------------------------------------------------------------------
-- Končne verzije tabel vključno s PK in TK.
-- Gasilec (IdGasilca, Ime, Priimek, NazivMaticnegaDrustva, Vloga, ClanOd, Aktiven)
-- Lokacija (IdLokacije, OpisLokacije, DatumKlica, OcenjenUkrep, IdGasilcaOperater) 
-- Posredovanje (IdLokacije, IdGasilca, DatumPosredovanja)
DROP DATABASE GasilskaZveza2026;
CREATE DATABASE GasilskaZveza2026;
USE GasilskaZveza2026;

-- DROP TABLE Gasilec;
CREATE TABLE Gasilec (
IdGasilca INTEGER PRIMARY KEY,
Ime VARCHAR(60) NOT NULL,
Priimek VARCHAR(60) NOT NULL,
NazivMaticnegaDrustva INTEGER NOT NULL,
Vloga VARCHAR(30) NOT NULL,
ClanOd DATE NOT NULL,
Aktiven BOOL NOT NULL
);

-- DROP TABLE Lokacija;
CREATE TABLE Lokacija (
IdLokacije INTEGER PRIMARY KEY,
OpisLokacije VARCHAR(80) NOT NULL,
DatumKlica VARCHAR(50) NOT NULL,
OcenjenUkrep DATE NOT NULL,
IdGasilcaOperater INTEGER NOT NULL
);

-- DROP TABLE Posredovanje;
CREATE TABLE Posredovanje (
    IdLokacije INTEGER PRIMARY KEY,
    IdGasilca INTEGER NOT NULL,
    DatumPosredovanja DATE NOT NULL,
    CONSTRAINT IdLokacijeTK FOREIGN KEY (IdLokacije) REFERENCES Lokacija(IdLokacije),
	CONSTRAINT IdGasilcaTK FOREIGN KEY (IdGasilca) REFERENCES Gasilec(IdGasilca)
);
