-- tworzenie schematu
CREATE SCHEMA rozliczenia;

-- tworzenie tabeli w schemacie
CREATE TABLE rozliczenia.pracownicy
(id_pracownika int NOT NULL,
imie varchar NOT NULL,
nazwisko varchar NOT NULL,
adres varchar,
telefon int);

CREATE TABLE rozliczenia.godziny
(id_godziny int NOT NULL,
data date NOT NULL,
liczba_godzin int NOT NULL,
id_pracownika int);

CREATE TABLE rozliczenia.pensje
(id_pensji int NOT NULL,
stanowisko varchar(30),
kwota int NOT NULL,
id_premii int);

CREATE TABLE rozliczenia.premie
(id_premii int NOT NULL,
rodzaj varchar(80),
kwota int NOT NULL);

-- klucze główne i obce
ALTER TABLE rozliczenia.pracownicy
ADD PRIMARY KEY (id_pracownika);

ALTER TABLE rozliczenia.godziny
ADD PRIMARY KEY (id_godziny);

ALTER TABLE rozliczenia.pensje
ADD PRIMARY KEY (id_pensji);

ALTER TABLE rozliczenia.premie
ADD PRIMARY KEY (id_premii);

ALTER TABLE rozliczenia.godziny
ADD FOREIGN KEY (id_pracownika) REFERENCES rozliczenia.pracownicy(id_pracownika);

ALTER TABLE rozliczenia.pensje
ADD FOREIGN KEY (id_premii) REFERENCES rozliczenia.premie(id_premii);

-- dodanie rekordów
INSERT INTO rozliczenia.pracownicy
VALUES 
(1, 'Jan', 'Kowalski', 'Al. Słowackiego 1', 123456789),
(2, 'Andrzej', 'Nowak', 'Al. Słowackiego 12', 123456709),
(3, 'Anna', 'Wójcik', 'Al. Mickiewicza 1', 103456789),
(4, 'Maria', 'Konopnicka', 'Długa 3/12', 120456789),
(5, 'Izabela', 'Kwiatkowska', 'Plac Nowy 4', 123056789),
(6, 'Katarzyna', 'Kowalska', 'Reymonta 15/99', 123406789),
(7, 'Aniela', 'Michałkowska', 'Basztowa 15', 123456789),
(8, 'Aleksander', 'Borowiecki', 'Basztowa 9/8', 123450789),
(9, 'Marek', 'Grechuta', 'Królewska 5', 123456089),
(10, 'Krzysztof', 'Krawczyk', 'Czarnowiejska 11/12', 123456780);

INSERT INTO rozliczenia.godziny
VALUES 
(1, '2023-10-08', 10, 2),
(2, '2023-10-08', 10, 3),
(3, '2023-10-11', 9, 2),
(4, '2023-10-08', 10, 1),
(5, '2023-10-12', 8, 10),
(6, '2023-10-07', 7, 8),
(7, '2023-10-08', 10, 4),
(8, '2023-10-10', 12, 6),
(9, '2023-10-08', 8, 8),
(10, '2023-10-08', 8, 7);

INSERT INTO rozliczenia.premie
VALUES 
(1, 'pierwsza', 100),
(2, 'druga', 200),
(3, 'trzecia', 300),
(4, 'czwarta', 400),
(5, 'piąta', 500),
(6, 'szósta', 600),
(7, 'siódma', 700),
(8, 'ósma', 800),
(9, 'dziewiąta', 900),
(10, 'dziesiąta', 1000);

INSERT INTO rozliczenia.pensje
VALUES 
(1, 'księgowy', 5000, 2),
(2, 'dyrektor', 15000, 3),
(5, 'księgowy', 5000, 4),
(7, 'programista', 10000, 5),
(8, 'tester', 6000, 6),
(10, 'tester', 6000, 10);
INSERT INTO rozliczenia.pensje
VALUES 
(3, 'programista', 10000),
(4, 'tester', 6000),
(6, 'dyrektor', 15000),
(9, 'programista', 10000);

-- wyswietlenie nazwisk i adresow pracownikow
SELECT nazwisko, adres FROM rozliczenia.pracownicy

-- konwersja daty w tabeli godziny tak, aby wyświetlana była 
-- informacja jaki to dzień tygodnia i jaki miesiąc (funkcja DATEPART x2).
SELECT 
DATE_PART('month', data) AS dzien_miesiaca,
DATE_PART('dow', data) AS dzien_tygodnia
FROM rozliczenia.godziny;

-- wyliczenie kwoty netto
ALTER TABLE rozliczenia.pensje
RENAME COLUMN kwota TO kwota_brutto;

ALTER TABLE rozliczenia.pensje
ADD kwota_netto int;

UPDATE rozliczenia.pensje
SET kwota_netto = kwota_brutto/1.23;