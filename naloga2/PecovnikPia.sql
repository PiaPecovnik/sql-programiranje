-- ----------------------------------------------------------------------
-- Predmet: SQL Programiranje
-- Vsebina: Naloga 2
--          Uporaba atributov in omejitev za zagotovitev domenske logike.
-- Datum:   27.4.2026
-- Avtor:   Pia Pečovnik
-- ----------------------------------------------------------------------

-- KORAK 0: Priprava podatkovne baze in tabel
DROP DATABASE GasilskaZveza2026;
CREATE DATABASE GasilskaZveza2026;
USE GasilskaZveza2026;

CREATE TABLE Gasilec (
    IdGasilca INTEGER NOT NULL,
    Ime VARCHAR(60) NOT NULL,
    Priimek VARCHAR(60) NOT NULL,
    NazivMaticnegaDrustva VARCHAR(100) NOT NULL,
    Vloga VARCHAR(30) NOT NULL,
    ClanOd DATE NOT NULL,
    Aktiven BOOL NOT NULL,
    Starost INTEGER NOT NULL -- ustvarjen stolpec za korak 1
);

CREATE TABLE Intervencija (
    IdIntervencije INTEGER NOT NULL,
	IdGasilcaOperater INTEGER NOT NULL,
    OpisLokacije VARCHAR(80) NOT NULL,
    DatumKlica DATE NOT NULL,
    OcenjenUkrep ENUM('Požar','Poplava','Potres','Prometna nesreča','Tehnično reševanje','Iskanje pogrešanih','Razliv nevarnih snovi', 'Manjša nesreča') DEFAULT 'Požar' NOT NULL
);

CREATE TABLE Posredovanje (
    IdIntervencije INTEGER NOT NULL,
    IdGasilca INTEGER NOT NULL,
    DatumPosredovanja DATE NOT NULL
);

-- KORAK 1: Poljubnemu števičnemu stolpcu (ki ni ID) določimo atribut,
-- ki definira/dopušča shranjevanje samo pozitivnih vrednosti.
ALTER TABLE Gasilec
MODIFY Starost INTEGER UNSIGNED NOT NULL DEFAULT 0;

ALTER TABLE Gasilec
ADD CONSTRAINT StarostPozitivnoStevilo check ( Starost >= 0);

-- -------------------------------------------------------------------
-- KORAK 2: Poljubnemu polju definiramo privzeto vrednost 
-- IN omejitev, ki preprečuje obstoj praznih oziroma neznanih vrednosti.
ALTER TABLE Gasilec
MODIFY ClanOd DATE NOT NULL DEFAULT (CURRENT_DATE);

-- -------------------------------------------------------------------
-- KORAK 3: Odstranimo omejitev privzetih vrednosti.
ALTER TABLE Gasilec ALTER COLUMN ClanOd DROP DEFAULT;

-- -------------------------------------------------------------------
-- KORAK 4: Poljubnemu stolpcu dodamo omejitev unikatnosti (UNIQUE).
ALTER TABLE Intervencija
ADD CONSTRAINT uniqueIDIntervencije UNIQUE (IdIntervencije);

-- -------------------------------------------------------------------
-- KORAK 5: Vsaki tabeli dodamo omejitev primarnega ključa, ki se samostojno povečuje za 1 korak.
ALTER TABLE Gasilec MODIFY IdGasilca INTEGER AUTO_INCREMENT PRIMARY KEY;
ALTER TABLE Intervencija MODIFY IdIntervencije INTEGER AUTO_INCREMENT PRIMARY KEY;
ALTER TABLE Posredovanje ADD PRIMARY KEY (IdIntervencije, IdGasilca, DatumPosredovanja);

-- -------------------------------------------------------------------
-- KORAK 6: V tretjo tabelo dodamo omejitve tujih ključev.
ALTER TABLE Posredovanje
ADD CONSTRAINT TK_Intervencija
FOREIGN KEY (IdIntervencije) REFERENCES Intervencija(IdIntervencije);

ALTER TABLE Posredovanje
ADD CONSTRAINT TK_Gasilec 
FOREIGN KEY (IdGasilca) REFERENCES Gasilec(IdGasilca);

-- -------------------------------------------------------------------
-- KORAK 7 in 8: Tujim ključem definiramo omejitve spremembe in brisanja: ON UPDATE, ON DELETE.
ALTER TABLE Posredovanje DROP FOREIGN KEY TK_Gasilec;

ALTER TABLE Posredovanje
ADD CONSTRAINT TK_Gasilec
FOREIGN KEY (IdGasilca) REFERENCES Gasilec(IdGasilca)
ON UPDATE CASCADE ON DELETE RESTRICT;

ALTER TABLE Posredovanje DROP FOREIGN KEY TK_Intervencija;

ALTER TABLE Posredovanje
ADD CONSTRAINT TK_Intervencija
FOREIGN KEY (IdIntervencije) REFERENCES Intervencija(IdIntervencije)
ON UPDATE CASCADE ON DELETE RESTRICT;

-- KONEC NALOG

-- --------------------------------------------------------------------------------
-- --------------------------------------------------------------------------------
-- Končne verzije tabel vključno s PK in TK.
-- Gasilec (IdGasilca, Ime, Priimek, NazivMaticnegaDrustva, Vloga, ClanOd, Aktiven, Starost)
-- Intervencija (IdIntervencije, IdGasilcaOperater, OpisLokacije, DatumKlica, OcenjenUkrep) 
-- Posredovanje (IdIntervencije, IdGasilca, DatumPosredovanja)

DROP DATABASE GasilskaZveza2026;
CREATE DATABASE GasilskaZveza2026;
USE GasilskaZveza2026;

DROP TABLE Gasilec;
CREATE TABLE `Gasilec` (
  `IdGasilca` int NOT NULL AUTO_INCREMENT,
  `Ime` varchar(60) NOT NULL,
  `Priimek` varchar(60) NOT NULL,
  `NazivMaticnegaDrustva` varchar(100) NOT NULL,
  `Vloga` varchar(30) NOT NULL,
  `ClanOd` date NOT NULL,
  `Aktiven` tinyint(1) NOT NULL,
  `Starost` int unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`IdGasilca`),
  CONSTRAINT `StarostPozitivnoStevilo` CHECK ((`Starost` >= 0))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

DROP TABLE Intervencija;
CREATE TABLE `Intervencija` (
  `IdIntervencije` int NOT NULL AUTO_INCREMENT,
  `IdGasilcaOperater` int NOT NULL,
  `OpisLokacije` varchar(80) NOT NULL,
  `DatumKlica` date NOT NULL,
  `OcenjenUkrep` enum('Požar','Poplava','Potres','Prometna nesreča','Tehnično reševanje','Iskanje pogrešanih','Razliv nevarnih snovi','Manjša nesreča') NOT NULL DEFAULT 'Požar',
  PRIMARY KEY (`IdIntervencije`),
  UNIQUE KEY `uniqueIDIntervencije` (`IdIntervencije`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

DROP TABLE Posredovanje;
CREATE TABLE `Posredovanje` (
  `IdIntervencije` int NOT NULL,
  `IdGasilca` int NOT NULL,
  `DatumPosredovanja` date NOT NULL,
  PRIMARY KEY (`IdIntervencije`,`IdGasilca`,`DatumPosredovanja`),
  KEY `TK_Gasilec` (`IdGasilca`), -- Index na stolpec, naredilo samo enega, ker je drugi \(IdIntervencije) prvi v vrsti pri ustvarjanju primarnega ključa
  CONSTRAINT `TK_Gasilec` FOREIGN KEY (`IdGasilca`) REFERENCES `Gasilec` (`IdGasilca`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `TK_Intervencija` FOREIGN KEY (`IdIntervencije`) REFERENCES `Intervencija` (`IdIntervencije`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- KONEC DOKUMENTA
-- --------------------------------------------------------------------------------
-- --------------------------------------------------------------------------------