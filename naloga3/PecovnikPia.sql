-- ----------------------------------------------------------------------
-- Predmet: SQL Programiranje
-- Vsebina: Naloga 3
-- Manipulacija s podatki: vnos, brisanje.
-- Datum:   30.4.2026
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
    Starost INTEGER unsigned NOT NULL DEFAULT '0',
	PRIMARY KEY (`IdGasilca`),
	CONSTRAINT `StarostPozitivnoStevilo` CHECK ((`Starost` >= 0))
);

CREATE TABLE Intervencija (
    IdIntervencije INTEGER NOT NULL,
	IdGasilcaOperater INTEGER NOT NULL,
    OpisLokacije VARCHAR(80) NOT NULL,
    DatumKlica DATE NOT NULL,
    OcenjenUkrep ENUM('Požar','Poplava','Potres','Prometna nesreča','Tehnično reševanje','Iskanje pogrešanih','Razliv nevarnih snovi', 'Manjša nesreča') DEFAULT 'Požar' NOT NULL,
    PRIMARY KEY (`IdIntervencije`),
	UNIQUE KEY `uniqueIDIntervencije` (`IdIntervencije`)
);

CREATE TABLE Posredovanje (
    IdIntervencije INTEGER NOT NULL,
    IdGasilca INTEGER NOT NULL,
    DatumPosredovanja DATE NOT NULL,
    PRIMARY KEY (`IdIntervencije`,`IdGasilca`,`DatumPosredovanja`),
	KEY `TK_Gasilec` (`IdGasilca`),
	CONSTRAINT `TK_Gasilec` FOREIGN KEY (`IdGasilca`) REFERENCES `Gasilec` (`IdGasilca`) ON DELETE RESTRICT ON UPDATE CASCADE,
	CONSTRAINT `TK_Intervencija` FOREIGN KEY (`IdIntervencije`) REFERENCES `Intervencija` (`IdIntervencije`) ON DELETE RESTRICT ON UPDATE CASCADE
);

-- KORAK 0.1: Brisanje vsebine tabel
DELETE FROM Gasilec WHERE 1 = 1;
ALTER TABLE Gasilec AUTO_INCREMENT =1;
DELETE FROM Intervencija WHERE 1 = 1;
ALTER TABLE Intervencija AUTO_INCREMENT =1;
DELETE FROM Posredovanje WHERE 1 = 1;
ALTER TABLE Posredovanje AUTO_INCREMENT =1;

-- -------------------------------------------------------------------
-- KORAK 1:  S podatki napolnite prvo tabelo s pomočjo implicitnega vnašanja podatkov.

INSERT INTO Gasilec VALUES (1, 'Janez', 'Novak', 'PGD Velenje', 'gasilec', '2015-03-12', TRUE, 32);
INSERT INTO Gasilec VALUES (2, 'Marko', 'Kovač', 'PGD Šoštanj', 'vodja', '2010-07-01', TRUE, 45);
INSERT INTO Gasilec VALUES (3, 'Luka', 'Horvat', 'PGD Celje', 'gasilec', '2018-05-20', TRUE, 27);
INSERT INTO Gasilec VALUES (4, 'Miha', 'Zupan', 'PGD Ljubljana', 'poveljnik', '2008-11-11', TRUE, 50);
INSERT INTO Gasilec VALUES (5, 'Andrej', 'Kranjc', 'PGD Maribor', 'gasilec', '2017-09-03', FALSE, 29);
INSERT INTO Gasilec VALUES (6, 'Tomaž', 'Vidmar', 'PGD Koper', 'voznik', '2012-01-15', TRUE, 38);
INSERT INTO Gasilec VALUES (7, 'Peter', 'Kos', 'PGD Novo mesto', 'gasilec', '2019-06-22', TRUE, 24);
INSERT INTO Gasilec VALUES (8, 'Rok', 'Potočnik', 'PGD Ptuj', 'vodja', '2011-02-10', TRUE, 41);
INSERT INTO Gasilec VALUES (9, 'Jure', 'Turk', 'PGD Kranj', 'gasilec', '2016-08-18', TRUE, 30);
INSERT INTO Gasilec VALUES (10, 'Alen', 'Mlakar', 'PGD Jesenice', 'gasilec', '2020-03-05', TRUE, 22);
INSERT INTO Gasilec VALUES (11, 'Gregor', 'Bizjak', 'PGD Trbovlje', 'poveljnik', '2005-12-01', TRUE, 55);
INSERT INTO Gasilec VALUES (12, 'Blaž', 'Hribar', 'PGD Zagorje', 'gasilec', '2014-04-14', FALSE, 33);
INSERT INTO Gasilec VALUES (13, 'Matjaž', 'Knez', 'PGD Slovenj Gradec', 'voznik', '2013-07-27', TRUE, 36);
INSERT INTO Gasilec VALUES (14, 'Nejc', 'Rozman', 'PGD Domžale', 'gasilec', '2021-01-09', TRUE, 21);
INSERT INTO Gasilec VALUES (15, 'Žan', 'Petek', 'PGD Kamnik', 'gasilec', '2018-10-30', TRUE, 26);
INSERT INTO Gasilec VALUES (16, 'Urban', 'Cerar', 'PGD Grosuplje', 'vodja', '2009-06-17', TRUE, 44);
INSERT INTO Gasilec VALUES (17, 'Denis', 'Logar', 'PGD Brežice', 'gasilec', '2016-02-25', TRUE, 31);
INSERT INTO Gasilec VALUES (18, 'Simon', 'Korošec', 'PGD Murska Sobota', 'voznik', '2012-09-12', FALSE, 39);
INSERT INTO Gasilec VALUES (19, 'Aleš', 'Zorko', 'PGD Krško', 'gasilec', '2017-05-06', TRUE, 28);
INSERT INTO Gasilec VALUES (20, 'Dejan', 'Golob', 'PGD Nova Gorica', 'poveljnik', '2007-03-19', TRUE, 48);

-- -------------------------------------------------------------------
-- KORAK 2: S podatki napolnite drugo tabelo s pomočno eksplicitnega vnašanja podatkov.

INSERT INTO Intervencija (IdIntervencije, IdGasilcaOperater, OpisLokacije, DatumKlica, OcenjenUkrep) VALUES (1, 1, 'Velenje center', '2023-01-12', 'Požar');
INSERT INTO Intervencija (IdIntervencije, IdGasilcaOperater, OpisLokacije, DatumKlica, OcenjenUkrep) VALUES (2, 5, 'Šoštanj industrijska cona', '2023-02-05', 'Razliv nevarnih snovi');
INSERT INTO Intervencija (IdIntervencije, IdGasilcaOperater, OpisLokacije, DatumKlica, OcenjenUkrep) VALUES (3, 3, 'Celje Lava', '2023-03-18', 'Prometna nesreča');
INSERT INTO Intervencija (IdIntervencije, IdGasilcaOperater, OpisLokacije, DatumKlica, OcenjenUkrep) VALUES (4, 13, 'Ljubljana Vič', '2023-04-09', 'Požar');
INSERT INTO Intervencija (IdIntervencije, IdGasilcaOperater, OpisLokacije, DatumKlica, OcenjenUkrep) VALUES (5, 15, 'Maribor center', '2023-05-21', 'Poplava');
INSERT INTO Intervencija (IdIntervencije, IdGasilcaOperater, OpisLokacije, DatumKlica, OcenjenUkrep) VALUES (6, 13, 'Koper pristanišče', '2023-06-11', 'Tehnično reševanje');
INSERT INTO Intervencija (IdIntervencije, IdGasilcaOperater, OpisLokacije, DatumKlica, OcenjenUkrep) VALUES (7, 1, 'Novo mesto Bršljin', '2023-07-02', 'Iskanje pogrešanih');
INSERT INTO Intervencija (IdIntervencije, IdGasilcaOperater, OpisLokacije, DatumKlica, OcenjenUkrep) VALUES (8, 1, 'Ptuj okolica', '2023-08-14', 'Požar');
INSERT INTO Intervencija (IdIntervencije, IdGasilcaOperater, OpisLokacije, DatumKlica, OcenjenUkrep) VALUES (9, 2, 'Kranj center', '2023-09-01', 'Manjša nesreča');
INSERT INTO Intervencija (IdIntervencije, IdGasilcaOperater, OpisLokacije, DatumKlica, OcenjenUkrep) VALUES (10, 2, 'Jesenice industrijska cona', '2023-10-10', 'Požar');
INSERT INTO Intervencija (IdIntervencije, IdGasilcaOperater, OpisLokacije, DatumKlica, OcenjenUkrep) VALUES (11, 10, 'Trbovlje rudnik', '2023-11-03', 'Tehnično reševanje');
INSERT INTO Intervencija (IdIntervencije, IdGasilcaOperater, OpisLokacije, DatumKlica, OcenjenUkrep) VALUES (12, 10, 'Zagorje ob Savi', '2023-12-15', 'Poplava');
INSERT INTO Intervencija (IdIntervencije, IdGasilcaOperater, OpisLokacije, DatumKlica, OcenjenUkrep) VALUES (13, 10, 'Slovenj Gradec center', '2024-01-20', 'Požar');
INSERT INTO Intervencija (IdIntervencije, IdGasilcaOperater, OpisLokacije, DatumKlica, OcenjenUkrep) VALUES (14, 4, 'Domžale okolica', '2024-02-11', 'Prometna nesreča');
INSERT INTO Intervencija (IdIntervencije, IdGasilcaOperater, OpisLokacije, DatumKlica, OcenjenUkrep) VALUES (15, 4, 'Kamnik center', '2024-03-05', 'Iskanje pogrešanih');
INSERT INTO Intervencija (IdIntervencije, IdGasilcaOperater, OpisLokacije, DatumKlica, OcenjenUkrep) VALUES (16, 6, 'Grosuplje', '2024-03-25', 'Požar');
INSERT INTO Intervencija (IdIntervencije, IdGasilcaOperater, OpisLokacije, DatumKlica, OcenjenUkrep) VALUES (17, 4, 'Brežice ob reki', '2024-04-08', 'Poplava');
INSERT INTO Intervencija (IdIntervencije, IdGasilcaOperater, OpisLokacije, DatumKlica, OcenjenUkrep) VALUES (18, 6, 'Murska Sobota center', '2024-04-19', 'Razliv nevarnih snovi');
INSERT INTO Intervencija (IdIntervencije, IdGasilcaOperater, OpisLokacije, DatumKlica, OcenjenUkrep) VALUES (19, 18, 'Krško elektrarna okolica', '2024-05-02', 'Tehnično reševanje');
INSERT INTO Intervencija (IdIntervencije, IdGasilcaOperater, OpisLokacije, DatumKlica, OcenjenUkrep) VALUES (20, 20, 'Nova Gorica center', '2024-05-18', 'Požar');

-- -------------------------------------------------------------------
-- KORAK 3: Iz prve tabele izbrišite vse podatke in pri tem ohranite strukturo tabele. 

SELECT COUNT(*) AS SteviloZapisov FROM Gasilec;
DELETE FROM Gasilec WHERE 1=1;
ALTER TABLE Gasilec AUTO_INCREMENT = 1;

-- -------------------------------------------------------------------
-- KORAK 4: V prvo tabelo ponovne vnesite podatke iz koraka 3. 

INSERT INTO Gasilec VALUES (1, 'Janez', 'Novak', 'PGD Velenje', 'gasilec', '2015-03-12', TRUE, 32);
INSERT INTO Gasilec VALUES (2, 'Marko', 'Kovač', 'PGD Šoštanj', 'vodja', '2010-07-01', TRUE, 45);
INSERT INTO Gasilec VALUES (3, 'Luka', 'Horvat', 'PGD Celje', 'gasilec', '2018-05-20', TRUE, 27);
INSERT INTO Gasilec VALUES (4, 'Miha', 'Zupan', 'PGD Ljubljana', 'poveljnik', '2008-11-11', TRUE, 50);
INSERT INTO Gasilec VALUES (5, 'Andrej', 'Kranjc', 'PGD Maribor', 'gasilec', '2017-09-03', FALSE, 29);
INSERT INTO Gasilec VALUES (6, 'Tomaž', 'Vidmar', 'PGD Koper', 'voznik', '2012-01-15', TRUE, 38);
INSERT INTO Gasilec VALUES (7, 'Peter', 'Kos', 'PGD Novo mesto', 'gasilec', '2019-06-22', TRUE, 24);
INSERT INTO Gasilec VALUES (8, 'Rok', 'Potočnik', 'PGD Ptuj', 'vodja', '2011-02-10', TRUE, 41);
INSERT INTO Gasilec VALUES (9, 'Jure', 'Turk', 'PGD Kranj', 'gasilec', '2016-08-18', TRUE, 30);
INSERT INTO Gasilec VALUES (10, 'Alen', 'Mlakar', 'PGD Jesenice', 'gasilec', '2020-03-05', TRUE, 22);
INSERT INTO Gasilec VALUES (11, 'Gregor', 'Bizjak', 'PGD Trbovlje', 'poveljnik', '2005-12-01', TRUE, 55);
INSERT INTO Gasilec VALUES (12, 'Blaž', 'Hribar', 'PGD Zagorje', 'gasilec', '2014-04-14', FALSE, 33);
INSERT INTO Gasilec VALUES (13, 'Matjaž', 'Knez', 'PGD Slovenj Gradec', 'voznik', '2013-07-27', TRUE, 36);
INSERT INTO Gasilec VALUES (14, 'Nejc', 'Rozman', 'PGD Domžale', 'gasilec', '2021-01-09', TRUE, 21);
INSERT INTO Gasilec VALUES (15, 'Žan', 'Petek', 'PGD Kamnik', 'gasilec', '2018-10-30', TRUE, 26);
INSERT INTO Gasilec VALUES (16, 'Urban', 'Cerar', 'PGD Grosuplje', 'vodja', '2009-06-17', TRUE, 44);
INSERT INTO Gasilec VALUES (17, 'Denis', 'Logar', 'PGD Brežice', 'gasilec', '2016-02-25', TRUE, 31);
INSERT INTO Gasilec VALUES (18, 'Simon', 'Korošec', 'PGD Murska Sobota', 'voznik', '2012-09-12', FALSE, 39);
INSERT INTO Gasilec VALUES (19, 'Aleš', 'Zorko', 'PGD Krško', 'gasilec', '2017-05-06', TRUE, 28);
INSERT INTO Gasilec VALUES (20, 'Dejan', 'Golob', 'PGD Nova Gorica', 'poveljnik', '2007-03-19', TRUE, 48);

-- KORAK 4.1: Shranjevanje podatkov v zbirko tipa .csv.
SELECT * FROM Gasilec
INTO OUTFILE '"C:\Users\HP\OneDrive - Univerza v Mariboru\Namizje\FAKS\1_letnik\2. semester\SQL programiranje\vaje\sql-programiranje\naloga3\csv\GasilskaZveza2026.csv"'
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n';

-- KORAK 4.2: Brisanje.
DELETE FROM Gasilec WHERE 1 = 1;
SELECT * FROM Gasilec;

-- KORAK 4.3: Vnos iz .csv.
LOAD DATA INFILE '"C:\Users\HP\OneDrive - Univerza v Mariboru\Namizje\FAKS\1_letnik\2. semester\SQL programiranje\vaje\sql-programiranje\naloga3\csv\GasilskaZveza2026.csv"'
INTO TABLE Gasilec
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 0 ROWS;

-- -------------------------------------------------------------------
-- KORAK 5: S podatki napolnite tretjo tabelo. Uporabite lahko implicitno ali eksplicitno vnašanje podatkov.  

INSERT INTO Posredovanje (IdIntervencije, IdGasilca, DatumPosredovanja) VALUES (1, 1, '2023-01-12');
INSERT INTO Posredovanje (IdIntervencije, IdGasilca, DatumPosredovanja) VALUES (1, 5, '2023-01-12');
INSERT INTO Posredovanje (IdIntervencije, IdGasilca, DatumPosredovanja) VALUES (2, 3, '2023-02-05');
INSERT INTO Posredovanje (IdIntervencije, IdGasilca, DatumPosredovanja) VALUES (2, 13, '2023-02-05');
INSERT INTO Posredovanje (IdIntervencije, IdGasilca, DatumPosredovanja) VALUES (3, 15, '2023-03-18');
INSERT INTO Posredovanje (IdIntervencije, IdGasilca, DatumPosredovanja) VALUES (3, 13, '2023-03-18');
INSERT INTO Posredovanje (IdIntervencije, IdGasilca, DatumPosredovanja) VALUES (4, 1, '2023-04-09');
INSERT INTO Posredovanje (IdIntervencije, IdGasilca, DatumPosredovanja) VALUES (4, 1, '2023-04-09');
INSERT INTO Posredovanje (IdIntervencije, IdGasilca, DatumPosredovanja) VALUES (5, 2, '2023-05-21');
INSERT INTO Posredovanje (IdIntervencije, IdGasilca, DatumPosredovanja) VALUES (5, 2, '2023-05-21');
INSERT INTO Posredovanje (IdIntervencije, IdGasilca, DatumPosredovanja) VALUES (6, 10, '2023-06-11');
INSERT INTO Posredovanje (IdIntervencije, IdGasilca, DatumPosredovanja) VALUES (6, 10, '2023-06-11');
INSERT INTO Posredovanje (IdIntervencije, IdGasilca, DatumPosredovanja) VALUES (7, 10, '2023-07-02');
INSERT INTO Posredovanje (IdIntervencije, IdGasilca, DatumPosredovanja) VALUES (7, 4, '2023-07-02');
INSERT INTO Posredovanje (IdIntervencije, IdGasilca, DatumPosredovanja) VALUES (8, 4, '2023-08-14');
INSERT INTO Posredovanje (IdIntervencije, IdGasilca, DatumPosredovanja) VALUES (8, 6, '2023-08-14');
INSERT INTO Posredovanje (IdIntervencije, IdGasilca, DatumPosredovanja) VALUES (9, 4, '2023-09-01');
INSERT INTO Posredovanje (IdIntervencije, IdGasilca, DatumPosredovanja) VALUES (9, 6, '2023-09-01');
INSERT INTO Posredovanje (IdIntervencije, IdGasilca, DatumPosredovanja) VALUES (10, 18, '2023-10-10');
INSERT INTO Posredovanje (IdIntervencije, IdGasilca, DatumPosredovanja) VALUES (10, 20, '2023-10-10');

-- -------------------------------------------------------------------
-- KORAK 6:  Poljubnemu stolpcu v drugi tabeli posodobite vrednosti za vse vrstice podatkov (npr. ime vseh študentov spremenite v Janko).

UPDATE Intervencija
SET OcenjenUkrep = 'Požar';

-- -------------------------------------------------------------------
-- KORAK 7: Z uporabo enega SQL ukaza v prvi tabeli za tri izbrane stolpce posodobite vrednosti za vse vrstice podatkov.

UPDATE Gasilec
SET Ime = 'Anže', Priimek = 'Kovač', Starost = 30;

-- -------------------------------------------------------------------
-- KORAK 8: V poljubni tabeli poljubnemu stolpcu posodobite vrednost zgolj ene vrstice, ki jo izberete z uporabo enostavnega pogoja.

UPDATE Gasilec
SET Priimek = 'Novak'
WHERE IdGasilca = 3;

-- KONEC DOKUMENTA

-- --------------------------------------------------------------------------------
-- --------------------------------------------------------------------------------
-- Končne verzije tabel: Naloga 3.

SHOW CREATE TABLE Gasilec;
CREATE TABLE `Gasilec` (
  `IdGasilca` int NOT NULL,
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

SHOW CREATE TABLE Intervencija;
CREATE TABLE `Intervencija` (
  `IdIntervencije` int NOT NULL,
  `IdGasilcaOperater` int NOT NULL,
  `OpisLokacije` varchar(80) NOT NULL,
  `DatumKlica` date NOT NULL,
  `OcenjenUkrep` enum('Požar','Poplava','Potres','Prometna nesreča','Tehnično reševanje','Iskanje pogrešanih','Razliv nevarnih snovi','Manjša nesreča') NOT NULL DEFAULT 'Požar',
  PRIMARY KEY (`IdIntervencije`),
  UNIQUE KEY `uniqueIDIntervencije` (`IdIntervencije`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

SHOW CREATE TABLE Posredovanje;
CREATE TABLE `Posredovanje` (
  `IdIntervencije` int NOT NULL,
  `IdGasilca` int NOT NULL,
  `DatumPosredovanja` date NOT NULL,
  PRIMARY KEY (`IdIntervencije`,`IdGasilca`,`DatumPosredovanja`),
  KEY `TK_Gasilec` (`IdGasilca`),
  CONSTRAINT `TK_Gasilec` FOREIGN KEY (`IdGasilca`) REFERENCES `Gasilec` (`IdGasilca`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `TK_Intervencija` FOREIGN KEY (`IdIntervencije`) REFERENCES `Intervencija` (`IdIntervencije`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- KONEC DOKUMENTA