DROP DATABASE IF EXISTS Kolokvij2;
CREATE DATABASE Kolokvij2;
USE Kolokvij2;

CREATE TABLE Studenti  (
ID_STU INTEGER NOT NULL,
Vpisna_stevilka VARCHAR(10),
EMSO VARCHAR(13),
Davcna_st VARCHAR(8),
Ime VARCHAR(20),
Priimek VARCHAR(30)
);

CREATE TABLE Predmeti (
ID_PRE INTEGER NOT NULL,
Naziv VARCHAR(30),
ECTS INTEGER
);

CREATE TABLE Ocene  (
ID_OCE INTEGER NOT NULL,
ID_STU_TK INTEGER,
ID_PRE_TK INTEGER,
Datum DATE,
Vrednost INTEGER,
Opravil VARCHAR(2)
);

ALTER TABLE Studenti
ADD CONSTRAINT PK_Studenti PRIMARY KEY (ID_STU);

ALTER TABLE Predmeti
ADD CONSTRAINT PK_Predmeti PRIMARY KEY (ID_PRE);

ALTER TABLE Ocene
ADD CONSTRAINT PK_Ocene PRIMARY KEY (ID_OCE),
ADD CONSTRAINT TK_OceneStudenti FOREIGN KEY (ID_STU_TK) REFERENCES Studenti (ID_STU),
ADD CONSTRAINT TK_OcenePredmeti FOREIGN KEY (ID_PRE_TK) REFERENCES Predmeti (ID_PRE);


-- =========================
-- Studenti (20 rows)
-- =========================
INSERT INTO Studenti VALUES (1, '20230001', '0101000500001', '10000001', 'Ana', 'Novak');
INSERT INTO Studenti VALUES (2, '20230002', '0202000500002', '10000002', 'Marko', 'Kovac');
INSERT INTO Studenti VALUES (3, '20230003', '0303000500003', '10000003', 'Eva', 'Horvat');
INSERT INTO Studenti VALUES (4, '20230004', '0404000500004', '10000004', 'Luka', 'Zupan');
INSERT INTO Studenti VALUES (5, '20230005', '0505000500005', '10000005', 'Maja', 'Kralj');
INSERT INTO Studenti VALUES (6, '20230006', '0606000500006', '10000006', 'Nina', 'Kos');
INSERT INTO Studenti VALUES (7, '20230007', '0707000500007', '10000007', 'Tine', 'Vidmar');
INSERT INTO Studenti VALUES (8, '20230008', '0808000500008', '10000008', 'Sara', 'Mlakar');
INSERT INTO Studenti VALUES (9, '20230009', '0909000500009', '10000009', 'Jan', 'Koren');
INSERT INTO Studenti VALUES (10, '20230010', '1010000500010', '10000010', 'Petra', 'Golob');
INSERT INTO Studenti VALUES (11, '20230011', '1111000500011', '10000011', 'Miha', 'Turk');
INSERT INTO Studenti VALUES (12, '20230012', '1212000500012', '10000012', 'Klara', 'Pirc');
INSERT INTO Studenti VALUES (13, '20230013', '1313000500013', '10000013', 'Rok', 'Knez');
INSERT INTO Studenti VALUES (14, '20230014', '1414000500014', '10000014', 'Tanja', 'Bizjak');
INSERT INTO Studenti VALUES (15, '20230015', '1515000500015', '10000015', 'Alen', 'Bozic');
INSERT INTO Studenti VALUES (16, '20230016', '1616000500016', '10000016', 'Simona', 'Jereb');
INSERT INTO Studenti VALUES (17, '20230017', '1717000500017', '10000017', 'David', 'Zorc');
INSERT INTO Studenti VALUES (18, '20230018', '1818000500018', '10000018', 'Ursa', 'Kovac');
INSERT INTO Studenti VALUES (19, '20230019', '1919000500019', '10000019', 'Zan', 'Kastelic');
INSERT INTO Studenti VALUES (20, '20230020', '2020000500020', '10000020', 'Lara', 'Pavlic');

-- =========================
-- Predmeti (20 rows)
-- =========================
INSERT INTO Predmeti VALUES (1, 'Matematika 1', 6.00);
INSERT INTO Predmeti VALUES (2, 'Matematika 2', 6.00);
INSERT INTO Predmeti VALUES (3, 'Programiranje 1', 8.00);
INSERT INTO Predmeti VALUES (4, 'Programiranje 2', 8.00);
INSERT INTO Predmeti VALUES (5, 'Baze podatkov', 5.00);
INSERT INTO Predmeti VALUES (6, 'Operacijski sistemi', 6.00);
INSERT INTO Predmeti VALUES (7, 'Racunalniske mreze', 5.00);
INSERT INTO Predmeti VALUES (8, 'Algoritmi', 7.00);
INSERT INTO Predmeti VALUES (9, 'Diskretna matematika', 6.00);
INSERT INTO Predmeti VALUES (10, 'Statistika', 5.00);
INSERT INTO Predmeti VALUES (11, 'Fizika', 4.00);
INSERT INTO Predmeti VALUES (12, 'Ekonomija', 3.00);
INSERT INTO Predmeti VALUES (13, 'Angleščina', 2.00);
INSERT INTO Predmeti VALUES (14, 'Umetna inteligenca', 7.00);
INSERT INTO Predmeti VALUES (15, 'Strojno ucenje', 8.00);
INSERT INTO Predmeti VALUES (16, 'Programski jeziki', 6.00);
INSERT INTO Predmeti VALUES (17, 'Mobilne aplikacije', 5.00);
INSERT INTO Predmeti VALUES (18, 'Spletni razvoj', 5.00);
INSERT INTO Predmeti VALUES (19, 'Kibernetska varnost', 6.00);
INSERT INTO Predmeti VALUES (20, 'Podatkovna analiza', 6.00);

-- =========================
-- Ocene (20 rows)
-- =========================
INSERT INTO Ocene VALUES (1, 1, 1, DATE '2024-01-10', 8, 'DA');
INSERT INTO Ocene VALUES (2, 2, 2, DATE '2024-01-11', 7, 'NE');
INSERT INTO Ocene VALUES (3, 3, 3, DATE '2024-01-12', 9, 'DA');
INSERT INTO Ocene VALUES (4, 4, 4, DATE '2024-01-13', 6, 'DA');
INSERT INTO Ocene VALUES (5, 5, 5, DATE '2024-01-14', 10, 'DA');
INSERT INTO Ocene VALUES (6, 6, 6, DATE '2024-01-15', 5, 'NE');
INSERT INTO Ocene VALUES (7, 7, 7, DATE '2024-01-16', 8, 'DA');
INSERT INTO Ocene VALUES (8, 8, 8, DATE '2024-01-17', 7, 'DA');
INSERT INTO Ocene VALUES (9, 9, 9, DATE '2024-01-18', 6, 'NE');
INSERT INTO Ocene VALUES (10, 10, 10, DATE '2024-01-19', 9, 'DA');
INSERT INTO Ocene VALUES (11, 11, 11, DATE '2024-01-20', 8, 'DA');
INSERT INTO Ocene VALUES (12, 12, 12, DATE '2024-01-21', 7, 'NE');
INSERT INTO Ocene VALUES (13, 13, 13, DATE '2024-01-22', 10, 'DA');
INSERT INTO Ocene VALUES (14, 14, 14, DATE '2024-01-23', 6, 'DA');
INSERT INTO Ocene VALUES (15, 15, 15, DATE '2024-01-24', 5, 'NE');
INSERT INTO Ocene VALUES (16, 16, 16, DATE '2024-01-25', 9, 'DA');
INSERT INTO Ocene VALUES (17, 17, 17, DATE '2024-01-26', 8, 'DA');
INSERT INTO Ocene VALUES (18, 18, 18, DATE '2024-01-27', 7, 'NE');
INSERT INTO Ocene VALUES (19, 19, 19, DATE '2024-01-28', 6, 'DA');
INSERT INTO Ocene VALUES (20, 20, 20, DATE '2024-01-29', 10, 'DA');

-- -----------------------------------------------------------------------------------
/*
-- 2. Naloga
SELECT DISTINCT Ime FROM Studenti;

-- 3. Naloga
SELECT Ime, Priimek FROM Studenti 
WHERE Priimek = 'Kos';

-- 4. Naloga
SELECT Vrednost FROM Ocene
WHERE Datum BETWEEN '2024-01-19' AND '2024-01-25'; 

-- 8. Naloga
SELECT Ime, Priimek FROM Studenti
WHERE NOT EXISTS (
SELECT Opravil FROM Ocene 
WHERE Opravil = 'DA' AND Studenti.ID_STU = ID_STU_TK
);

-- 9. Naloga
SELECT Ime, Priimek FROM Studenti
WHERE ID_STU = ANY (
SELECT ID_STU_TK FROM Ocene
WHERE Opravil = 'DA'
);

-- 10. Naloga
SELECT Ime, Priimek FROM Studenti
WHERE ID_STU = ALL (
SELECT ID_STU_TK FROM Ocene 
WHERE Opravil = 'NE'
);

-- 11. Naloga
SELECT AVG(Vrednost) FROM Ocene
WHERE Opravil = 'NE';

-- 12. Naloga
SELECT COUNT(Opravil) FROM Ocene
WHERE Opravil = 'DA' AND ID_STU_TK = 1;

-- 13. Naloga
SELECT MAX(Vrednost) FROM Ocene
WHERE ID_STU_TK = 4;

-- 14. Naloga
SELECT AVG(Vrednost) FROM Ocene
WHERE Opravil = 'DA' AND ID_PRE_TK = 2;

-- 15. Naloga
SELECT EXTRACT(MONTH FROM Datum) FROM Ocene
WHERE ID_STU_TK = 1;

-- 16. Naloga
SELECT UPPER(Priimek) FROM Studenti;

-- 17. Naloga
SELECT CURRENT_DATE, Datum FROM Ocene;
*/

