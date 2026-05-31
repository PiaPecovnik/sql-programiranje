-- -------------------------------------
-- Predmet: SQL Programiranje
-- Vsebina: Naloga 8
--          Sprožilci, Procedure, Dogodki
-- Datum:   27.5.2026
-- Avtor:   Pia Pečovnik
-- -------------------------------------

-- KORAK 0: Priprava podatkovne baze in tabel
DROP DATABASE GasilskaZveza2026;
CREATE DATABASE GasilskaZveza2026;
USE GasilskaZveza2026;

-- ustvarjanje tabel
CREATE TABLE Gasilec (
    IdGasilca INTEGER NOT NULL AUTO_INCREMENT,
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
INSERT INTO Gasilec VALUES (10, 'Alen', 'Mlakar', 'PGE Celje', 'operativec' , '2020-03-05', TRUE, 22);  -- null vloga
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

-- ------------------------------------------------------------------------
-- KORAK 1: Oblikovanje LOG tabele in sprožilca AFTER UPDATE.
-- tabela Gasilec, stolpec Vloga
-- ------------------------------------------------------------------------
CREATE TABLE GasilecLog (
    IdLog INTEGER NOT NULL AUTO_INCREMENT PRIMARY KEY,
    IdGasilca INTEGER NOT NULL,
    StaraVrednostVloga VARCHAR(30),
	NovaVrednostVloga VARCHAR(30),
	DatumVpisa TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Sprožilec trGasilecVlogaUpdate
DROP TRIGGER IF EXISTS trGasilecVlogaUpdate;

DELIMITER $$

-- Vrednosti NEW in OLD (INSERT, UPDATE, DELETE):
-- NEW: Da, Da, Ne
-- OLD: Ne, Da, Da


CREATE TRIGGER trGasilecVlogaUpdate
AFTER UPDATE ON Gasilec
FOR EACH ROW
BEGIN
	IF (NEW.Vloga <> OLD.Vloga) THEN 
		INSERT INTO GasilecLog (IdGasilca, StaraVrednostVloga, NovaVrednostVloga)
		VALUES (OLD.IdGasilca, OLD.Vloga, NEW.Vloga);
	END IF;
END $$ 

DELIMITER ;

-- Testiranje:
SELECT * FROM Gasilec WHERE IdGasilca = 1;

UPDATE Gasilec
SET Vloga = 'voznik'
WHERE IdGasilca = 1;

SELECT * FROM GasilecLog;

-- -------------------------------------------------------
-- KORAK 2: Oblikovanje LOG tabele in sprožilca AFTER INSERT in AFTER UPDATE
-- -------------------------------------------------------
DROP TABLE IF EXISTS IntervencijaLog;

CREATE TABLE IntervencijaLog (
    IdLog INTEGER NOT NULL AUTO_INCREMENT PRIMARY KEY,
    IdIntervencije INTEGER NOT NULL,
    Informacija VARCHAR(80) NOT NULL,
	DatumVpisa TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Sprožilca.
DROP TRIGGER IF EXISTS trIntervencijaZapisVnosa;
DROP TRIGGER IF EXISTS trIntervencijaZapisSpremembe;

DELIMITER $$
-- Pomen: po vnosu novega zapisa v tabelo Intervencija, vnese tudi zapis v LOG.
CREATE TRIGGER trIntervencijaZapisVnosa
AFTER INSERT ON Intervencija
FOR EACH ROW
BEGIN
	INSERT INTO IntervencijaLog (IdIntervencije, Informacija)
		VALUES (NEW.IdIntervencije, 'Nov vnos');
END$$

CREATE TRIGGER trIntervencijaZapisSpremembe
AFTER UPDATE ON Intervencija 
FOR EACH ROW
BEGIN
	INSERT INTO IntervencijaLog (IdIntervencije, Informacija)
		VALUES (OLD.IdIntervencije, 'Sprememba');
END$$	

DELIMITER ;

SELECT * FROM IntervencijaLog;
SELECT * FROM Intervencija;

-- Testiranje
SELECT * FROM IntervencijaLog;
SHOW TRIGGERS;

-- Vnos: nova intervencija
INSERT INTO Intervencija (IdIntervencije, IdGasilcaOperater, OpisLokacije, DatumKlica, OcenjenUkrep)
VALUES (21, 1, 'Velenje center', '2024-06-01', 'Požar');

-- Sprememba: OcenjenUkrep
UPDATE Intervencija
SET OcenjenUkrep = 'Poplava'
WHERE IdIntervencije = 21;

SELECT * FROM IntervencijaLog;

-- -------------------------------------------------------
-- KORAK 3: Uporaba razporejevalnika dogodkov (EVENT SCHEDULER).
-- -------------------------------------------------------
SET GLOBAL event_scheduler = ON;

DROP TABLE IF EXISTS IntervencijaLog;
DROP EVENT IF EXISTS IntervencijaLog;

CREATE TABLE IntervencijaLog (
    IdLog INTEGER NOT NULL AUTO_INCREMENT PRIMARY KEY,
    OcenjenUkrep VARCHAR(40) NOT NULL,
    SteviloIntervencij INTEGER NOT NULL,
	DatumVpisa TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Prvi primer (dnevni interval):
CREATE EVENT IntervencijaLog
ON SCHEDULE EVERY 1 DAY
DO
INSERT INTO IntervrncijaLog (OcenjenUkrep, SteviloIntervencij)
SELECT OcenjenUkrep, COUNT(IdIntervencije) AS SteviloIntervencij FROM Intervencija
GROUP BY OcenjenUkrep;

SELECT * FROM IntervencijaLog;

SHOW EVENTS FROM GasilskaZveza2026;
SHOW PROCESSLIST;

-- Drugi primer (uporaba COALESCE in minutni interval):
DROP EVENT IF EXISTS IntervencijaLog;

CREATE EVENT IntervencijaLog
ON SCHEDULE AT CURRENT_TIMESTAMP + INTERVAL 1 MINUTE
DO
INSERT INTO IntervencijaLog (OcenjenUkrep, SteviloIntervencij)
SELECT OcenjenUkrep, COALESCE(COUNT(IdIntervencije), 0) AS SteviloIntervencij FROM Intervencija
GROUP BY OcenjenUkrep;

SELECT * FROM IntervencijaLog;


-- Tretji primer (zgolj pet izvajanj):
DROP EVENT IF EXISTS IntervencijaLog;

CREATE EVENT IntervencijaLog
ON SCHEDULE EVERY 1 MINUTE
STARTS CURRENT_TIMESTAMP + INTERVAL 1 MINUTE
ENDS CURRENT_TIMESTAMP + INTERVAL 5 MINUTE
DO
INSERT INTO IntervencijaLog (OcenjenUkrep, SteviloIntervencij)
SELECT OcenjenUkrep, COALESCE(COUNT(IdIntervencije), 0) AS SteviloIntervencij FROM Intervencija
GROUP BY OcenjenUkrep;

SELECT * FROM IntervencijaLog;

-- -------------------------------------------------------
-- KORAK 4: Brisanje vsebine LOG tabele z uporabo razporejevalnika
-- -------------------------------------------------------
DROP EVENT IF EXISTS BrisanjeIntervencijaLog;

SET GLOBAL event_scheduler = ON;

CREATE EVENT BrisanjeIntervencijaLog
ON SCHEDULE EVERY 1 MINUTE
DO
DELETE FROM IntervencijaLog WHERE DatumVpisa < NOW() - INTERVAL 1 MINUTE;

SELECT * FROM IntervencijaLog;

SHOW EVENTS FROM GasilskaZveza2026;

-- -------------------------------------------------------
-- KORAK 5: Uporaba shranjene procedure (STORED PROCEDURE).
-- -------------------------------------------------------
-- Prvi primer
DROP PROCEDURE IF EXISTS GasilskaZveza2026.GasilecInsert;

DELIMITER $$
CREATE PROCEDURE GasilskaZveza2026.GasilecInsert(
	IN Ime VARCHAR(60),
    IN Priimek VARCHAR(60),
    IN NazivMaticnegaDrustva VARCHAR(100),
    IN Vloga VARCHAR(30),
    IN ClanOd DATE,
    IN Aktiven BOOL,
    IN Starost INTEGER
)
BEGIN
    INSERT INTO Gasilec (Ime, Priimek, NazivMaticnegaDrustva, Vloga, ClanOd, Aktiven, Starost)
    VALUES (Ime, Priimek, NazivMaticnegaDrustva, Vloga, ClanOd, Aktiven, Starost);
END$$
DELIMITER ;

-- Testiranje
CALL GasilskaZveza2026.GasilecInsert('Ana', 'Novak', 'PGE Velenje', 'operativec', '2024-01-01', TRUE, 25);

-- Drugi primer:
DROP PROCEDURE IF EXISTS GasilecInsert;

DELIMITER $$
-- p = procedure
CREATE PROCEDURE GasilecInsert(
    IN pIme VARCHAR(60) CHARACTER SET utf8mb4,
    IN pPriimek VARCHAR(60) CHARACTER SET utf8mb4,
    IN pNazivMaticnegaDrustva VARCHAR(100) CHARACTER SET utf8mb4,
    IN pVloga VARCHAR(30) CHARACTER SET utf8mb4,
    IN pClanOd DATE,
    IN pAktiven BOOL,
    IN pStarost INTEGER
)
BEGIN
    DECLARE vVloga VARCHAR(30);
    DECLARE vSporocilo VARCHAR(255);
    SET vVloga = TRIM(pVloga);
    
    IF vVloga NOT IN ('operativec', 'vodja', 'poveljnik', 'voznik') THEN
        SET vSporocilo = CONCAT(
            'Napaka: Vloga "',
            vVloga,
            '" ni veljavna. Dovoljene vrednosti: operativec, vodja, poveljnik, voznik.'
        );

        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = vSporocilo;
    ELSE
       INSERT INTO Gasilec (Ime, Priimek, NazivMaticnegaDrustva, Vloga, ClanOd, Aktiven, Starost)
	   VALUES (pIme, pPriimek, pNazivMaticnegaDrustva, vVloga, pClanOd, pAktiven, pStarost);
    END IF;
END$$

DELIMITER ;

-- Testiranje
CALL GasilecInsert('Ana', 'Novak', 'PGE Velenje', 'operativec', '2024-01-01', TRUE, 25);
-- Napaka: neveljavna vloga
CALL GasilecInsert('Maja', 'Kovač', 'PGD Trbovlje', 'kuhar', '2024-02-01', TRUE, 30);

SELECT * FROM Gasilec;

-- -------------------------------------------------------
-- KORAK 6: Uporaba shranjene procedure (STORED PROCEDURE).
-- -------------------------------------------------------
DROP PROCEDURE IF EXISTS GasilskaZveza2026.GasilecDelete;

DELIMITER $$

CREATE PROCEDURE  GasilskaZveza2026.GasilecDelete(
    IN IdGasilcaDelete  INT,
    OUT OutputInfo VARCHAR(255)
)
BEGIN
    DECLARE vStevilo INT DEFAULT 0;

    -- Preštejemo, ali obstaja zapis z danim ID-jem
    SELECT COUNT(*) INTO vStevilo
    FROM GasilskaZveza2026.Gasilec
    WHERE IdGasilca = IdGasilcaDelete;
	
    IF vStevilo > 0 THEN
        -- Brisanje izvedemo
        DELETE FROM GasilskaZveza2026.Gasilec WHERE IdGasilca = IdGasilcaDelete;
        SET OutputInfo = CONCAT('Brisanje gasilca z ID = ', IdGasilcaDelete, ' JE uspešno!');
    ELSE
        SET OutputInfo = CONCAT('Brisanje gasilca z ID = ', IdGasilcaDelete, ' NI uspešno – ne obstaja!');
    END IF;
END$$

DELIMITER ;

-- Testiranje:
SELECT * FROM GasilskaZveza2026.Gasilec;

-- 1. TEST: Gasilec NE OBSTAJA (ID = 999)
SET @IdGasilca := 999;
SET @Izhod := '';
CALL GasilskaZveza2026.GasilecDelete(@IdGasilca, @Izhod);
SELECT @Izhod AS IzhodnoSporocilo;

-- 2. TEST: Uspešno brisanje (ID = 16, nima posredovanj)
SET @IdGasilca := 16;
SET @Izhod := '';
CALL GasilskaZveza2026.GasilecDelete(@IdGasilca, @Izhod);
SELECT @Izhod AS IzhodnoSporocilo;

-- 3. TEST: Testni gasilec – vstavi in zbriši
INSERT INTO GasilskaZveza2026.Gasilec VALUES (200, 'TEST', 'Brisanje', 'PGE Velenje', 'operativec', '2024-01-01', TRUE, 25);
SET @IdGasilca := 200;
SET @Izhod := '';
CALL GasilskaZveza2026.GasilecDelete(@IdGasilca, @Izhod);
SELECT @Izhod AS IzhodnoSporocilo;

-- Pogled po brisanju
SELECT * FROM GasilskaZveza2026.Gasilec;

-- -------------------------------------------------------
-- KORAK 7: Uporaba shranjene procedure (STORED PROCEDURE).
--          Uporaba vhodnih parametrov v filtru poizvedbe.
-- -------------------------------------------------------
-- Vrni število intervencij na katerih je bil gasilec po filtru (Ime, Priimek).
SET @Ime := 'Anka';
SET @Priimek := 'Supej';

SELECT IdGasilcaOperater, COUNT(IdIntervencije) AS SteviloIntervencije
FROM Intervencija
WHERE IdGasilcaOperater IN (SELECT IdGasilca FROM Gasilec WHERE Ime = @Ime AND Priimek = @Priimek)
GROUP BY IdGasilcaOperater;

-- 1. Rešitev z uporabo operatorja IN in vgnezdenega stavka.
-- Procedura SteviloIntervencijGasilca (IdGasilcaOperater, SteviloIntervencije)

DELIMITER $$

CREATE PROCEDURE GasilskaZveza2026.SteviloIntervencijGasilca(IN InIme VARCHAR(40), IN InPriimek VARCHAR(40))
BEGIN
	SELECT IdGasilcaOperater, COUNT(IdIntervencije) AS SteviloIntervencije
	FROM Intervencija
	WHERE IdGasilcaOperater IN (SELECT IdGasilca FROM Gasilec WHERE Ime = @Ime AND Priimek = @Priimek)
	GROUP BY IdGasilcaOperater;
END;


-- Vrni vsoto in število vseh intervencij izbranega gasilca po filtru (Ime, Priimek).
SET @Ime := 'Anka';
SET @Priimek := 'Supej';

CALL GasilskaZveza2026.SteviloIntervencijGasilca(@Ime, @Priimek);


-- ------------------------------------
-- KONEC DATOTEKE 
-- ------------------------------------
SHOW CREATE TABLE Gasilec;
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
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

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



