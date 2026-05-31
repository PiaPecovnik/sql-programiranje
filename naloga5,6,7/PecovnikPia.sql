-- -------------------------------------
-- Predmet: SQL Programiranje
-- Vsebina: Naloga 5,6,7
--          Uporaba funkcij različnih skupin.
-- Datum:   13.5.2026
-- Avtor:   Pia Pečovnik
-- -------------------------------------

-- KORAK 0: Priprava podatkovne baze in tabel
DROP DATABASE GasilskaZveza2026;
CREATE DATABASE GasilskaZveza2026;
USE GasilskaZveza2026;

-- ustvarjanje tabel
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
INSERT INTO Gasilec VALUES (21, 'Klemen', 'Šuštar', 'PGD Kamnik', 'operativec', '2019-11-14', TRUE, 25);
INSERT INTO Gasilec VALUES (22, 'Franc', 'Oblak', 'PGD Kamnik', 'vodja', '2006-04-22', TRUE, 52);
INSERT INTO Gasilec VALUES (23, 'Tilen', 'Srebrnič', 'PGD Kamnik', 'operativec', '2020-08-03', TRUE, 23);
INSERT INTO Gasilec VALUES (24, 'Boštjan', 'Erjavec', 'PGD Kamnik', 'voznik', '2014-12-18', FALSE, 35);
INSERT INTO Gasilec VALUES (25, 'Kristjan', 'Vesel', 'PGD Kamnik', 'poveljnik', '2003-05-30', TRUE, 58);
INSERT INTO Gasilec VALUES (26, 'Matej', 'Jamnik', 'PGE Kranj', 'operativec', '2018-03-07', TRUE, 26);
INSERT INTO Gasilec VALUES (27, 'David', 'Černe', 'PGE Kranj', 'vodja', '2011-10-25', TRUE, 41);
INSERT INTO Gasilec VALUES (28, 'Mitja', 'Pregelj', 'PGE Kranj', 'operativec', '2022-02-14', TRUE, 20);
INSERT INTO Gasilec VALUES (29, 'Igor', 'Štefanič', 'PGE Kranj', 'voznik', '2015-07-09', FALSE, 33);
INSERT INTO Gasilec VALUES (30, 'Primož', 'Bečan', 'PGE Kranj', null, '2023-01-20', TRUE, 19);


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
INSERT INTO Intervencija (IdIntervencije, IdGasilcaOperater, OpisLokacije, DatumKlica, OcenjenUkrep) VALUES (21, 19, 'Grosuplje osnovna šola', '2024-06-03', 'Požar');
INSERT INTO Intervencija (IdIntervencije, IdGasilcaOperater, OpisLokacije, DatumKlica, OcenjenUkrep) VALUES (22, 21, 'Kamnik Maistrova ulica', '2024-06-17', 'Prometna nesreča');
INSERT INTO Intervencija (IdIntervencije, IdGasilcaOperater, OpisLokacije, DatumKlica, OcenjenUkrep) VALUES (23, 22, 'Kamnik Mekinje', '2024-07-01', 'Poplava');
INSERT INTO Intervencija (IdIntervencije, IdGasilcaOperater, OpisLokacije, DatumKlica, OcenjenUkrep) VALUES (24, 25, 'Kamnik Tuhinjska dolina', '2024-07-14', 'Iskanje pogrešanih');
INSERT INTO Intervencija (IdIntervencije, IdGasilcaOperater, OpisLokacije, DatumKlica, OcenjenUkrep) VALUES (25, 23, 'Kamnik center', '2024-07-29', 'Manjša nesreča');
INSERT INTO Intervencija (IdIntervencije, IdGasilcaOperater, OpisLokacije, DatumKlica, OcenjenUkrep) VALUES (26, 24, 'Kamnik Duplica', '2024-08-10', 'Požar');
INSERT INTO Intervencija (IdIntervencije, IdGasilcaOperater, OpisLokacije, DatumKlica, OcenjenUkrep) VALUES (27, 27, 'Kranj Planina', '2024-08-22', 'Tehnično reševanje');
INSERT INTO Intervencija (IdIntervencije, IdGasilcaOperater, OpisLokacije, DatumKlica, OcenjenUkrep) VALUES (28, 26, 'Kranj Stara Sava', '2024-09-05', 'Poplava');
INSERT INTO Intervencija (IdIntervencije, IdGasilcaOperater, OpisLokacije, DatumKlica, OcenjenUkrep) VALUES (29, 29, 'Kranj Primskovo', '2024-09-20', 'Razliv nevarnih snovi');
INSERT INTO Intervencija (IdIntervencije, IdGasilcaOperater, OpisLokacije, DatumKlica, OcenjenUkrep) VALUES (30, 28, 'Kranj avtocestni priključek', '2024-10-07', 'Prometna nesreča');

-- polnjenje tabele Posredovanje
INSERT INTO Posredovanje VALUES (1, 1, '2023-01-12');
INSERT INTO Posredovanje VALUES (1, 2, '2023-01-12');
INSERT INTO Posredovanje VALUES (1, 3, '2023-01-12');
INSERT INTO Posredovanje VALUES (1, 4, '2023-01-12');
INSERT INTO Posredovanje VALUES (2, 1, '2023-02-05');
INSERT INTO Posredovanje VALUES (2, 3, '2023-02-05');
INSERT INTO Posredovanje VALUES (2, 5, '2023-02-05');
INSERT INTO Posredovanje VALUES (3, 2, '2023-03-18');
INSERT INTO Posredovanje VALUES (3, 3, '2023-03-18');
INSERT INTO Posredovanje VALUES (3, 5, '2023-03-18');
INSERT INTO Posredovanje VALUES (4, 1, '2023-04-09');
INSERT INTO Posredovanje VALUES (4, 2, '2023-04-09');
INSERT INTO Posredovanje VALUES (4, 4, '2023-04-09');
INSERT INTO Posredovanje VALUES (5, 3, '2023-05-21');
INSERT INTO Posredovanje VALUES (5, 4, '2023-05-21');
INSERT INTO Posredovanje VALUES (5, 5, '2023-05-21');
INSERT INTO Posredovanje VALUES (6, 6, '2023-06-11');
INSERT INTO Posredovanje VALUES (6, 8, '2023-06-11');
INSERT INTO Posredovanje VALUES (6, 13, '2023-06-11');
INSERT INTO Posredovanje VALUES (7, 6, '2023-07-02');
INSERT INTO Posredovanje VALUES (7, 7, '2023-07-02');
INSERT INTO Posredovanje VALUES (7, 8, '2023-07-02');
INSERT INTO Posredovanje VALUES (8, 6, '2023-08-14');
INSERT INTO Posredovanje VALUES (8, 7, '2023-08-14');
INSERT INTO Posredovanje VALUES (8, 9, '2023-08-14');
INSERT INTO Posredovanje VALUES (9, 7, '2023-09-01');
INSERT INTO Posredovanje VALUES (9, 9, '2023-09-01');
INSERT INTO Posredovanje VALUES (9, 10, '2023-09-01');
INSERT INTO Posredovanje VALUES (10, 6, '2023-10-10');
INSERT INTO Posredovanje VALUES (10, 8, '2023-10-10');
INSERT INTO Posredovanje VALUES (10, 10, '2023-10-10');
INSERT INTO Posredovanje VALUES (13, 11, '2024-01-20');
INSERT INTO Posredovanje VALUES (13, 13, '2024-01-20');
INSERT INTO Posredovanje VALUES (13, 15, '2024-01-20');
INSERT INTO Posredovanje VALUES (14, 11, '2024-02-11');
INSERT INTO Posredovanje VALUES (14, 14, '2024-02-11');
INSERT INTO Posredovanje VALUES (15, 11, '2024-03-05');
INSERT INTO Posredovanje VALUES (15, 13, '2024-03-05');
INSERT INTO Posredovanje VALUES (17, 16, '2024-04-08');
INSERT INTO Posredovanje VALUES (17, 17, '2024-04-08');


-- KORAK 5.1: Izpiše število aktivnih gasilcev in stolpec/rezultat poimenuje SteviloAktivnihGasilcev, prav tako pa vrne povprečno starost vseh gasilcev,
-- 			  jo zaokroži na 0 decimalk - celo število in stolpec/rezultat poimenuje PovprecnaStarost.
SELECT COUNT(IdGasilca) AS SteviloAktivnihGasilcev, ROUND(AVG(Starost),0) AS PovprecnaStarost FROM Gasilec 
WHERE IdGasilca IN (SELECT IdGasilca FROM Gasilec WHERE Aktiven = true); 

-- KORAK 5.7: Izpiše samo leto iz Datumov ko so se zgodile intervencije ter jih razvrsti od najbolj nedavnega do najstarejšega
SELECT SUBSTRING(DatumKlica FROM 1 FOR 4) AS LetaZIntervencijami FROM Intervencija
ORDER BY LetaZIntervencijami DESC;

-- KORAK 5.8: Izpišejo se samo meseci v katerih se je zgodil razliv nevarnih snovi.
SELECT MONTHNAME(DatumKlica) AS Mesec_ko_je_bila_opravljena_intervencija FROM Intervencija
WHERE OcenjenUkrep = 'Razliv nevarnih snovi';

-- KORAK 6.2: Izpišejo se osnovni podatki o gasilcih, iz katerega okoliša so in kake intervencije so imeli. 
SELECT g.IdGasilca, g.Ime, g.Priimek, g.NazivMaticnegaDrustva,
g.Vloga, i.IdIntervencije, i.OpisLokacije, i.OcenjenUkrep
FROM Gasilec g LEFT OUTER JOIN Intervencija i ON g.IdGasilca = i.IdGasilcaOperater;

-- KORAK 6.5: Izpiše vse intervencije, kje so se zgodile, ter vse ki so bili vpleteni ter kdaj.
SELECT g.Ime, g.Priimek, g.NazivMaticnegaDrustva, i.OpisLokacije, i.OcenjenUkrep, i.DatumKlica, p.DatumPosredovanja FROM Gasilec g
INNER JOIN Posredovanje p ON g.IdGasilca = p.IdGasilca
INNER JOIN Intervencija i ON p.IdIntervencije = i.IdIntervencije;

-- KORAK 6.6:  Izpiše vse intervencije, kje so se zgodile, ter vse ki so bili vpleteni ter kdaj. ime in priimek gasilcev shrani v isti stolpec
SELECT g.IdGasilca, CONCAT(g.Priimek, ', ', g.Ime) AS Gasilec, g.NazivMaticnegaDrustva, g.Vloga, i.IdIntervencije, i.OpisLokacije, i.DatumKlica, i.OcenjenUkrep, p.DatumPosredovanja
FROM Gasilec AS g, Intervencija AS i, Posredovanje AS p
WHERE g.IdGasilca = p.IdGasilca 
AND i.IdIntervencije = p.IdIntervencije;

-- KORAK 6.7: Izpiši gasilce iz PGE Celje in PGD Grosuplje (nisem join-ala 2 tabel ker je bila vsaka kombinacija nelogična)
SELECT IdGasilca, Ime, Priimek, NazivMaticnegaDrustva
FROM Gasilec
WHERE NazivMaticnegaDrustva = 'PGE Celje'
UNION
SELECT IdGasilca, Ime, Priimek, NazivMaticnegaDrustva
FROM Gasilec
WHERE NazivMaticnegaDrustva = 'PGD Grosuplje';

-- KORAK 6.10: Izpiši ime, priimek in starost gasilcev ki niso operativci
SELECT Ime, Priimek, Starost FROM Gasilec
WHERE Vloga NOT IN (SELECT Vloga FROM Gasilec 
WHERE Vloga = 'operativec');

-- KORAK 7.2: Izpiši koliko gasilcev ima vsako društvo za določeno nalogo
SELECT NazivMaticnegaDrustva, Vloga, COUNT(*) AS SteviloGasilcev FROM Gasilec
GROUP BY NazivMaticnegaDrustva, Vloga
ORDER BY NazivMaticnegaDrustva, SteviloGasilcev DESC;

-- KORAK 7.3: Združi tabeli gasilec in posredovanje z idGasilec, seštej intervencije posameznega gasilca ter izpiši tiste ki so imeli več kot 1 intervencijo 
SELECT Gasilec.Ime, Gasilec.Priimek, COUNT(Posredovanje.IdIntervencije) AS St_Intervencij FROM Gasilec
INNER JOIN Posredovanje ON Gasilec.IdGasilca = Posredovanje.IdGasilca
GROUP BY Gasilec.IdGasilca, Gasilec.Ime, Gasilec.Priimek
HAVING COUNT(Posredovanje.IdIntervencije) > 1
ORDER BY St_Intervencij DESC;

-- KORAK 7.5: Aktivne gasilce razporedi v tri kategorije, glede na sterost
SELECT Ime, Priimek, Starost, Vloga,
CASE
      WHEN Starost < 26 THEN 'Mlad gasilec'
      WHEN Starost BETWEEN 26 AND 40 THEN 'Izkušen gasilec'
      WHEN Starost > 40 THEN 'Starejši gasilec'
      ELSE 'Neznano'
END AS IzkusenostGasilca
FROM Gasilec
WHERE Aktiven = TRUE
ORDER BY IzkusenostGasilca, Starost;

-- KORAK 7.6:
-- OBVEZNA
--          1. Vse intervencije, kje so se zgodile, ter vsi ki so bili vpleteni in kdaj.
-- 		    2. Izpiši koliko gasilcev ima vsako društvo za določeno nalogo
--          3. Izpiši ime, priimek in starost gasilcev ki niso operativci

-- 1. Vse intervencije, kje so se zgodile, ter vsi ki so bili vpleteni in kdaj.
CREATE VIEW viewPodatkiIntervencije AS
SELECT g.Ime, g.Priimek, g.NazivMaticnegaDrustva, i.OpisLokacije, i.OcenjenUkrep, i.DatumKlica, p.DatumPosredovanja FROM Gasilec g
INNER JOIN Posredovanje p ON g.IdGasilca = p.IdGasilca
INNER JOIN Intervencija i ON p.IdIntervencije = i.IdIntervencije;

SELECT * FROM viewPodatkiIntervencije;

-- 2. Izpiši koliko gasilcev ima vsako društvo za določeno nalogo
CREATE VIEW viewGasilciPoNalogahVDrustvih AS
SELECT NazivMaticnegaDrustva, Vloga, COUNT(*) AS SteviloGasilcev FROM Gasilec
GROUP BY NazivMaticnegaDrustva, Vloga
ORDER BY NazivMaticnegaDrustva, SteviloGasilcev DESC;

SELECT * FROM viewGasilciPoNalogahVDrustvih;

-- 3. Izpiši ime, priimek in starost gasilcev ki niso operativci
CREATE VIEW viewPodatkiNeOperativnihGasilcov AS
SELECT Ime, Priimek, Starost FROM Gasilec
WHERE Vloga NOT IN (SELECT Vloga FROM Gasilec 
WHERE Vloga = 'operativec');

SELECT * FROM viewPodatkiNeOperativnihGasilcov;

-- KONEC DOKUMENTA
-- -------------------------------------------------------------------

SHOW CREATE TABLE Gasilec;
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