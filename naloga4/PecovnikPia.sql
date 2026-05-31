-- -------------------------------------
-- Predmet: SQL Programiranje
-- Vsebina: Naloga 4
--          Preprosta SQL povpraševanja.
-- Datum:   11.5.2026
-- Avtor:   Pia Pečovnik
-- -------------------------------------

-- KORAK 0: Priprava podatkovne baze in tabel
DROP DATABASE GasilskaZveza2026;
CREATE DATABASE GasilskaZveza2026;
USE GasilskaZveza2026;

-- ustvarjanje tabel?
CREATE TABLE Gasilec (
    IdGasilca INTEGER NOT NULL,
    Ime VARCHAR(60) NOT NULL,
    Priimek VARCHAR(60) NOT NULL,
    NazivMaticnegaDrustva VARCHAR(100) NOT NULL,
    Vloga VARCHAR(30) ,
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

-- Brisanje vsebine tabel
DELETE FROM Gasilec WHERE 1 = 1;
ALTER TABLE Gasilec AUTO_INCREMENT =1;
DELETE FROM Intervencija WHERE 1 = 1;
ALTER TABLE Intervencija AUTO_INCREMENT =1;
DELETE FROM Posredovanje WHERE 1 = 1;
ALTER TABLE Posredovanje AUTO_INCREMENT =1;

-- polnjenje tabele Gasilec
INSERT INTO Gasilec VALUES (1, 'Janez', 'Novak', 'PGE Velenje', 'operativec', '2015-03-12', TRUE, 32);
INSERT INTO Gasilec VALUES (2, 'Marko', 'Kovač', 'PGE Velenje', 'vodja', '2010-07-01', TRUE, 45);
INSERT INTO Gasilec VALUES (3, 'Luka', 'Horvat', 'PGE Velenje', 'operativec', '2018-05-20', TRUE, 27);
INSERT INTO Gasilec VALUES (4, 'Miha', 'Zupan', 'PGE Velenje', 'poveljnik', '2008-11-11', TRUE, 50);
INSERT INTO Gasilec VALUES (5, 'Andrej', 'Kranjc', 'PGE Velenje', 'operativec', '2017-09-03', FALSE, 29);
INSERT INTO Gasilec VALUES (6, 'Tomaž', 'Vidmar', 'PGE Celje', 'voznik', '2012-01-15', TRUE, 38);
INSERT INTO Gasilec VALUES (7, 'Peter', 'Kos', 'PGE Celje', 'operativec', '2019-06-22', TRUE, 24);
INSERT INTO Gasilec VALUES (8, 'Rok', 'Potočnik', 'PGE Celje', 'vodja', '2011-02-10', TRUE, 40);
INSERT INTO Gasilec VALUES (9, 'Jure', 'Turk', 'PGE Celje', 'operativec', '2016-08-18', TRUE, 30);
INSERT INTO Gasilec VALUES (10, 'Alen', 'Mlakar', 'PGE Celje', null , '2020-03-05', TRUE, 22);  -- null vloga
INSERT INTO Gasilec VALUES (11, 'Gregor', 'Bizjak', 'PGD Trbovlje', 'poveljnik', '2005-12-01', TRUE, 55);
INSERT INTO Gasilec VALUES (12, 'Blaž', 'Hribar', 'PGD Trbovlje', 'operativec', '2014-04-14', FALSE, 32);
INSERT INTO Gasilec VALUES (13, 'Matjaž', 'Knez', 'PGD Trbovlje', 'voznik', '2013-07-27', TRUE, 36);
INSERT INTO Gasilec VALUES (14, 'Nejc', 'Rozman', 'PGD Trbovlje', 'operativec', '2021-01-09', TRUE, 21);
INSERT INTO Gasilec VALUES (15, 'Žan', 'Petek', 'PGD Trbovlje', 'operativec', '2018-10-30', TRUE, 26);
INSERT INTO Gasilec VALUES (16, 'Urban', 'Cerar', 'PGD Grosuplje', 'vodja', '2009-06-17', TRUE, 44);
INSERT INTO Gasilec VALUES (17, 'Denis', 'Logar', 'PGD Grosuplje', 'operativec', '2016-02-25', TRUE, 32);
INSERT INTO Gasilec VALUES (18, 'Simon', 'Korošec', 'PGD Grosuplje', 'voznik', '2012-09-12', FALSE, 40);
INSERT INTO Gasilec VALUES (19, 'Aleš', 'Zorko', 'PGD Grosuplje', 'operativec', '2017-05-06', TRUE, 28);
INSERT INTO Gasilec VALUES (20, 'Dejan', 'Golob', 'PGD Grosuplje', 'poveljnik', '2007-03-19', TRUE, 48);

-- polnjenje tabele Intervencije
INSERT INTO Intervencija (IdIntervencije, IdGasilcaOperater, OpisLokacije, DatumKlica, OcenjenUkrep) VALUES (1, 1, 'Velenje center', '2023-01-12', 'Požar'); 
INSERT INTO Intervencija (IdIntervencije, IdGasilcaOperater, OpisLokacije, DatumKlica, OcenjenUkrep) VALUES (2, 5, 'Velenje osnovna šola', '2023-02-05', 'Tehnično reševanje'); 
INSERT INTO Intervencija (IdIntervencije, IdGasilcaOperater, OpisLokacije, DatumKlica, OcenjenUkrep) VALUES (3, 3, 'Velenje Velenjska plaža', '2023-03-18', 'Tehnično reševanje'); 
INSERT INTO Intervencija (IdIntervencije, IdGasilcaOperater, OpisLokacije, DatumKlica, OcenjenUkrep) VALUES (4, 2, 'Velenje avtobusna postaja', '2023-04-09', 'Manjša nesreča'); 
INSERT INTO Intervencija (IdIntervencije, IdGasilcaOperater, OpisLokacije, DatumKlica, OcenjenUkrep) VALUES (5, 4, 'Velenje Škalsko jezero', '2023-05-21', 'Iskanje pogrešanih'); 
INSERT INTO Intervencija (IdIntervencije, IdGasilcaOperater, OpisLokacije, DatumKlica, OcenjenUkrep) VALUES (6, 8, 'Celje center', '2023-06-11', 'Tehnično reševanje'); 
INSERT INTO Intervencija (IdIntervencije, IdGasilcaOperater, OpisLokacije, DatumKlica, OcenjenUkrep) VALUES (7, 9, 'Celje Lava', '2023-07-02', 'Razliv nevarnih snovi'); 
INSERT INTO Intervencija (IdIntervencije, IdGasilcaOperater, OpisLokacije, DatumKlica, OcenjenUkrep) VALUES (8, 6, 'Celje Hudinja', '2023-08-14', 'Požar'); 
INSERT INTO Intervencija (IdIntervencije, IdGasilcaOperater, OpisLokacije, DatumKlica, OcenjenUkrep) VALUES (9, 7, 'Celje mestni park', '2023-09-01', 'Manjša nesreča'); 
INSERT INTO Intervencija (IdIntervencije, IdGasilcaOperater, OpisLokacije, DatumKlica, OcenjenUkrep) VALUES (10, 10, 'Celje Bukovžlak', '2023-10-10', 'Požar'); 
INSERT INTO Intervencija (IdIntervencije, IdGasilcaOperater, OpisLokacije, DatumKlica, OcenjenUkrep) VALUES (11, 10, 'Celje Teharska cesta', '2023-11-03', 'Manjša nesreča');
INSERT INTO Intervencija (IdIntervencije, IdGasilcaOperater, OpisLokacije, DatumKlica, OcenjenUkrep) VALUES (12, 10, 'Celje grad', '2023-12-15', 'Manjša nesreča');
INSERT INTO Intervencija (IdIntervencije, IdGasilcaOperater, OpisLokacije, DatumKlica, OcenjenUkrep) VALUES (13, 11, 'Trbovlje Industrijska cona', '2024-01-20', 'Požar'); 
INSERT INTO Intervencija (IdIntervencije, IdGasilcaOperater, OpisLokacije, DatumKlica, OcenjenUkrep) VALUES (14, 14, 'Trbovlje Žabjek', '2024-02-11', 'Prometna nesreča'); 
INSERT INTO Intervencija (IdIntervencije, IdGasilcaOperater, OpisLokacije, DatumKlica, OcenjenUkrep) VALUES (15, 15, 'Trbovlje Industrijska cona', '2024-03-05', 'Razliv nevarnih snovi'); --
INSERT INTO Intervencija (IdIntervencije, IdGasilcaOperater, OpisLokacije, DatumKlica, OcenjenUkrep) VALUES (16, 13, 'Trbovlje letno kopališče', '2024-03-25', 'Manjša nesreča');
INSERT INTO Intervencija (IdIntervencije, IdGasilcaOperater, OpisLokacije, DatumKlica, OcenjenUkrep) VALUES (17, 16, 'Grosuplje Eurospin', '2024-04-08', 'Manjša nesreča');
INSERT INTO Intervencija (IdIntervencije, IdGasilcaOperater, OpisLokacije, DatumKlica, OcenjenUkrep) VALUES (18, 17, 'Grosuplje pokopališče', '2024-04-19', 'Manjša nesreča');
INSERT INTO Intervencija (IdIntervencije, IdGasilcaOperater, OpisLokacije, DatumKlica, OcenjenUkrep) VALUES (19, 18, 'Grosuplje Kresnikova cesta', '2024-05-02', 'Potres'); 
INSERT INTO Intervencija (IdIntervencije, IdGasilcaOperater, OpisLokacije, DatumKlica, OcenjenUkrep) VALUES (20, 20, 'Grosuplje industrijska cona', '2024-05-18', 'Požar'); 

-- polnjenje tabele Posredovanje
INSERT INTO Posredovanje VALUES (1, 1, '2023-01-12');
INSERT INTO Posredovanje VALUES (1, 2, '2023-01-12');
INSERT INTO Posredovanje VALUES (1, 3, '2023-01-12');
INSERT INTO Posredovanje VALUES (1, 4, '2023-01-12'); -- 1.intervencija
INSERT INTO Posredovanje VALUES (2, 1, '2023-02-05');
INSERT INTO Posredovanje VALUES (2, 3, '2023-02-05');
INSERT INTO Posredovanje VALUES (2, 5, '2023-02-05'); -- 2.intervencija
INSERT INTO Posredovanje VALUES (3, 2, '2023-03-18');
INSERT INTO Posredovanje VALUES (3, 3, '2023-03-18');
INSERT INTO Posredovanje VALUES (3, 5, '2023-03-18'); -- 3.intervencija
INSERT INTO Posredovanje VALUES (6, 6, '2023-06-11');
INSERT INTO Posredovanje VALUES (6, 8, '2023-06-11');
INSERT INTO Posredovanje VALUES (6, 13, '2023-06-11'); -- 6. intervencija
INSERT INTO Posredovanje VALUES (7, 1, '2023-07-02');
INSERT INTO Posredovanje VALUES (7, 6, '2023-07-02');
INSERT INTO Posredovanje VALUES (7, 7, '2023-07-02');
INSERT INTO Posredovanje VALUES (7, 8, '2023-07-02'); -- 7.intervencija
INSERT INTO Posredovanje VALUES (10, 2, '2023-10-10');
INSERT INTO Posredovanje VALUES (10, 6, '2023-10-10');
INSERT INTO Posredovanje VALUES (10, 8, '2023-10-10');
INSERT INTO Posredovanje VALUES (10, 10, '2023-10-10'); -- 10.intervencija
INSERT INTO Posredovanje VALUES (13, 11, '2024-01-20');
INSERT INTO Posredovanje VALUES (13, 13, '2024-01-20');
INSERT INTO Posredovanje VALUES (13, 15, '2024-01-20'); -- 13.intervencija
INSERT INTO Posredovanje VALUES (15, 4, '2024-03-05');
INSERT INTO Posredovanje VALUES (15, 11, '2024-03-05');
INSERT INTO Posredovanje VALUES (15, 13, '2024-03-05'); -- 15.intervencija

-- KORAK 1: V poljubni tabeli izbrišite poljubno vrstico, ki jo izberete z uporabo enostavnega pogoja.
DELETE FROM Posredovanje
WHERE IdIntervencije = 1 AND IdGasilca = 3;

-- KORAK 2: Za poljubno tabelo izvedite povpraševanje po vseh podatkih tabele.
SELECT * FROM Gasilec;

-- KORAK 3: Za poljubno tabelo izvedite povpraševanje po treh stolpcih pri čemer uporabite en pogoj, 
-- 			ki vsebuje osnovne primerjalne predikate in stolpec/ca/ce ob poizvedovanju smiselno preimenujte.
SELECT IdGasilcaOperater AS Kdo_je_reseval, OpisLokacije AS Kraj_nesrece, DatumKlica AS Kdaj_se_je_zgodilo FROM Intervencija
WHERE OcenjenUkrep = 'Požar';

-- KORAK 4: Za poljubno tabelo izvedite povpraševanje po različnih vrednostih (izpisati ne želimo vseh vrednosti, 
-- 			ampak samo različne vrednosti) po dveh stolpcih v tabeli.
SELECT DISTINCT NazivMaticnegaDrustva FROM Gasilec;
SELECT DISTINCT Vloga FROM Gasilec;

-- KORAK 5: Za poljubno tabelo izvedite povpraševanje glede na tri pogoje, ki vsebujejo osnovne primerjalne predikate
-- 			in pri čemer morajo rezultati ustrezati vsem trem pogojem.
SELECT OpisLokacije, DatumKlica, OcenjenUkrep FROM  Intervencija
WHERE IdIntervencije > 4 AND IdGasilcaOperater < 15 AND OcenjenUkrep = 'Požar';

-- KORAK 6: Za poljubno tabelo izvedite povpraševanje glede na tri pogoje, ki vsebujejo osnovne primerjalne predikate in 
-- 			pri čemer morajo rezultati ustrezati vsaj enemu izmed treh pogojev.
SELECT OpisLokacije, DatumKlica, OcenjenUkrep FROM  Intervencija
WHERE IdIntervencije > 4 OR IdGasilcaOperater < 15 OR OcenjenUkrep = 'Požar';

-- KORAK 7: Za poljubno tabelo izvedite povpraševanje z uporabo predikata "med (dvema vrednostnima)" in pri tem pazite na smiselnost uporabe.
SELECT Ime, Priimek, Starost FROM Gasilec
WHERE IdGasilca BETWEEN 8 AND 19;

-- KORAK 8: Za poljubno tabelo izvedite povpraševanje z uporabo predikata, ki preverja delno ujemanje vzorca znakovnih nizov. 
-- 			Pri tem uporabite ključni znak, ki predstavlja nadomeščanje natanko enega znaka in ključni znak, ki nadomešča več poljubnih znakov. 
-- 			Izpišite samo različne vrednosti v kolikor se vrednosti ponavljajo (npr. trije delavci z imenom Matej)).
SELECT Ime, Priimek, Starost FROM Gasilec
WHERE Ime LIKE 'M%' AND Priimek Like 'K_e_';

-- KORAK 9: Za poljubno tabelo izvedite povpraševanje pri čemer uporabite en pogoj, ki vsebuje osnovne primerjalne predikate 
-- 			in pogoj ki bo preveril obstoj praznih/neznanih vrednosti.
SELECT Ime, Priimek, Vloga FROM Gasilec
WHERE IdGasilca > 6 AND Vloga IS NULL;

-- KORAK 10:  Za poljubno tabelo izvedite povpraševanje z uporabo predikata, ki preverja obstoj/pripadanje definirani množici. 
-- 			  Primer oblikujete na način, da uporabite zanikanje omenjenega predikata (NOT).
SELECT OpisLokacije, DatumKlica, OcenjenUkrep FROM Intervencija
WHERE OcenjenUkrep NOT IN ('Požar');

-- KORAK 11:  Izvedite povpraševanje, v katerem izpišete vrednosti enega stolpca, pri tem pa rezultate razvrstite naraščajoče.
SELECT Starost FROM Gasilec
ORDER BY Starost ASC;

-- KORAK 12:  Izvedite povpraševanje, v katerem izpišete vrednosti dveh stolpcev glede na poljuben/na pogoj(a), 
-- 			  pri tem pa rezultate razvrstite po enem stolpcu naraščajoče ter po drugem padajoče. Izpišite samo prvih 5 vrstic.
SELECT ClanOd, Starost FROM Gasilec
ORDER BY ClanOd ASC, Starost DESC
LIMIT 5;

-- KONEC DOKUMENTA

-- --------------------------------------------------------------------------------
-- --------------------------------------------------------------------------------
-- Končne verzije tabel: Naloga 4.
DROP DATABASE GasilskaZveza2026;
CREATE DATABASE GasilskaZveza2026;
USE GasilskaZveza2026;

CREATE TABLE `Gasilec` (
  `IdGasilca` int NOT NULL,
  `Ime` varchar(60) NOT NULL,
  `Priimek` varchar(60) NOT NULL,
  `NazivMaticnegaDrustva` varchar(100) NOT NULL,
  `Vloga` varchar(30) DEFAULT NULL,
  `ClanOd` date NOT NULL,
  `Aktiven` tinyint(1) NOT NULL,
  `Starost` int unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`IdGasilca`),
  CONSTRAINT `StarostPozitivnoStevilo` CHECK ((`Starost` >= 0))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `Intervencija` (
  `IdIntervencije` int NOT NULL,
  `IdGasilcaOperater` int NOT NULL,
  `OpisLokacije` varchar(80) NOT NULL,
  `DatumKlica` date NOT NULL,
  `OcenjenUkrep` enum('Požar','Poplava','Potres','Prometna nesreča','Tehnično reševanje','Iskanje pogrešanih','Razliv nevarnih snovi','Manjša nesreča') NOT NULL DEFAULT 'Požar',
  PRIMARY KEY (`IdIntervencije`),
  UNIQUE KEY `uniqueIDIntervencije` (`IdIntervencije`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

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
