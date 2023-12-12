-- TWORZENIE SCHEMATU
CREATE SCHEMA ksiegowosc;

-- TWORZENIE TABELI
CREATE TABLE ksiegowosc.pracownicy
(id_pracownika int PRIMARY KEY,
nazwisko varchar NOT NULL,
adres varchar,
telefon varchar);

CREATE TABLE ksiegowosc.godziny
(id_godziny int PRIMARY KEY,
data date NOT NULL,
liczba_godzin int NOT NULL,
id_pracownika int NOT NULL);

CREATE TABLE ksiegowosc.pensja
(id_pensji int PRIMARY KEY,
stanowisko varchar(30),
kwota int NOT NULL);

CREATE TABLE ksiegowosc.premia
(id_premii int PRIMARY KEY,
rodzaj varchar(80),
kwota int NOT NULL);

CREATE TABLE ksiegowosc.wynagrodzenie
(
    id_wynagrodzenia INT PRIMARY KEY,
    data date NOT NULL,
    id_pracownika INT NOT NULL,
    id_godziny INT NOT NULL,
    id_pensji INT,
    id_premii INT
);

-- KLUCZE OBCE
ALTER TABLE ksiegowosc.godziny
ADD FOREIGN KEY (id_pracownika) REFERENCES ksiegowosc.pracownicy(id_pracownika);

ALTER TABLE ksiegowosc.wynagrodzenie
ADD FOREIGN KEY (id_premii) REFERENCES ksiegowosc.premia(id_premii);

ALTER TABLE ksiegowosc.wynagrodzenie
ADD FOREIGN KEY (id_pensji) REFERENCES ksiegowosc.pensja(id_pensji);

ALTER TABLE ksiegowosc.wynagrodzenie
ADD FOREIGN KEY (id_godziny) REFERENCES ksiegowosc.godziny(id_godziny);

ALTER TABLE ksiegowosc.wynagrodzenie
ADD FOREIGN KEY (id_pracownika) REFERENCES ksiegowosc.pracownicy(id_pracownika);

-- KOMENTARZE
COMMENT ON TABLE ksiegowosc.pracownicy IS 'Informacje o pracownikach';
COMMENT ON TABLE ksiegowosc.godziny IS 'Godziny przepracowane przez pracownikow';
COMMENT ON TABLE ksiegowosc.pensja IS 'Pensje pracownikow';
COMMENT ON TABLE ksiegowosc.premia IS 'Premie dla pracownikow';
COMMENT ON TABLE ksiegowosc.wynagrodzenie IS 'Pelne wynagrodzenie pracownikow';

-- WYPELNIENIE REKORDAMI
INSERT INTO ksiegowosc.pracownicy
VALUES 
(1, 'Jan', 'Kowalski', 'Al. Slowackiego 1', '123456789'),
(2, 'Andrzej', 'Nowak', 'Al. Slowackiego 12', '123456709'),
(3, 'Anna', 'Wojcik', 'Al. Mickiewicza 1', '103456789'),
(4, 'Maria', 'Konopnicka', 'Dluga 3/12', '120456789'),
(5, 'Izabela', 'Kwiatkowska', 'Plac Nowy 4', '123056789'),
(6, 'Katarzyna', 'Kowalska', 'Reymonta 15/99', '123406789'),
(7, 'Aniela', 'Michalkowska', 'Basztowa 15', '123456789'),
(8, 'Aleksander', 'Borowiecki', 'Basztowa 9/8', '123450789'),
(9, 'Marek', 'Grechuta', 'Krolewska 5', '123456089'),
(10, 'Krzysztof', 'Krawczyk', 'Czarnowiejska 11/12', '123456780');

INSERT INTO ksiegowosc.godziny
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

INSERT INTO ksiegowosc.premia
VALUES 
(1, 'pierwsza', 100),
(2, 'druga', 200),
(3, 'trzecia', 300),
(4, 'czwarta', 400),
(5, 'piata', 500),
(6, 'szosta', 600),
(7, 'siodma', 700),
(8, 'osma', 800),
(9, 'dziewiata', 900),
(10, 'dziesiata', 1000);

INSERT INTO ksiegowosc.pensja
VALUES 
(1, 'ksiegowy', 5000),
(2, 'dyrektor', 15000),
(3, 'ksiegowy', 5000),
(4, 'dyrektor', 15000),
(5, 'ksiegowy', 5000),
(6, 'programista', 10000),
(7, 'tester', 6000),
(8, 'tester', 6000),
(9, 'ksiegowy', 5000),
(10, 'tester', 6000);

INSERT INTO ksiegowosc.wynagrodzenie
VALUES 
(1, '2023-10-08', 2, 3, 1, 1),
(2, '2023-10-08', 10, 7, 4, 5),
(3, '2023-10-11', 9, 8, 7, 6),
(4, '2023-10-08', 1, 2, 3, 4),
(5, '2023-10-12', 3, 2, 8, 10),
(6, '2023-10-07', 4, 1, 7, 8),
(7, '2023-10-08', 5, 10, 4, 7),
(8, '2023-10-10', 6, 8, 12, 6),
(9, '2023-10-08', 7, 4, 8, 8),
(10, '2023-10-08', 8, 6, 7, 5);

-- Wyswietl tylko id pracownika oraz jego nazwisko. 
SELECT id_pracownika, nazwisko 
FROM ksiegowosc.pracownicy

-- Wyswietl id pracownikow, ktorych placa jest wieksza niz 1000
SELECT id_pracownika
FROM ksiegowosc.wynagrodzenie as w
LEFT JOIN ksiegowosc.pensja as p
USING(id_pensji)
WHERE p.kwota > 1000

-- Wyswietl id pracownikow nieposiadajacych premii, ktorych placa jest wieksza niz 2000
SELECT id_pracownika
FROM ksiegowosc.wynagrodzenie as w
LEFT JOIN ksiegowosc.pensja as p
USING(id_pensji)
WHERE p.kwota > 2000 AND w.id_premii IS NOT NULL;

-- Wyswietl pracownikow, ktorych pierwsza litera imienia zaczyna sie na litere 'J'
SELECT id_pracownika
FROM ksiegowosc.pracownicy
WHERE nazwisko LIKE 'J%'

-- Wyswietl pracownikow, ktorych nazwisko zawiera litere 'n' oraz imie konczy sie na litere 'a'
SELECT id_pracownika
FROM ksiegowosc.pracownicy
WHERE nazwisko LIKE 'N%' AND telefon LIKE '%9'

-- Wyswietl imie i nazwisko pracownikow oraz liczbe ich nadgodzin, przyjmujac, standardowy czas pracy to 160 h miesiecznie
SELECT pr.nazwisko AS imie, (gdz.liczba_godzin-8) AS nadgodziny
FROM ksiegowosc.pracownicy AS pr
LEFT JOIN ksiegowosc.godziny AS gdz
USING(id_pracownika)
WHERE gdz.liczba_godzin > 8

-- Wyswietl imie i nazwisko pracownikow, ktorych pensja zawiera sie w przedziale 1500-3000 PLN
SELECT pr.nazwisko, pen.kwota
FROM ksiegowosc.pracownicy AS pr
LEFT JOIN ksiegowosc.wynagrodzenie AS wyn
USING(id_pracownika)
LEFT JOIN ksiegowosc.pensja AS pen
USING(id_pensji)
WHERE pen.kwota BETWEEN 5000 AND 6000

-- Wyswietl imie i nazwisko pracownikow, ktorzy pracowali w nadgodzinach i nie  otrzymali premii
SELECT pr.nazwisko 
FROM ksiegowosc.pracownicy AS pr
LEFT JOIN ksiegowosc.godziny AS gdz
USING(id_pracownika)
JOIN ksiegowosc.wynagrodzenie AS wyn
USING(id_pracownika)
WHERE gdz.liczba_godzin > 8 AND wyn.id_premii IS NULL

-- Uszereguj pracownikow wedlug pensji
SELECT id_pracownika
FROM ksiegowosc.wynagrodzenie as wyn
JOIN ksiegowosc.pensja as pen
USING(id_pensji)
ORDER BY pen.kwota;

-- Uszereguj pracownikow wedlug pensji i premii malejaco
SELECT id_pracownika
FROM ksiegowosc.wynagrodzenie as wyn
JOIN ksiegowosc.pensja as pen
USING(id_pensji)
JOIN ksiegowosc.premia as pre
USING(id_premii)
ORDER BY pen.kwota desc, pre.kwota desc;

-- Zlicz i pogrupuj pracownikow wedlug pola 'stanowisko'
SELECT stanowisko, count(id_pracownika)
FROM ksiegowosc.pracownicy as pra
JOIN ksiegowosc.wynagrodzenie as wyn
USING(id_pracownika)
JOIN ksiegowosc.pensja as pen
USING(id_pensji)
GROUP BY stanowisko

-- Policz srednia, minimalna i maksymalna place dla stanowiska 'kierownik' (jezeli takiego nie masz, to przyjmij dowolne inne)
SELECT SUM(kwota) AS suma, MAX(kwota) AS max, MIN(kwota) AS min
FROM ksiegowosc.pensja
WHERE stanowisko = 'ksiegowy'

-- Policz sume wszystkich wynagrodzen
SELECT SUM(pen.kwota + pre.kwota) AS suma_wynagrodzen
FROM ksiegowosc.pensja AS pen
JOIN ksiegowosc.wynagrodzenie AS wyn
USING(id_pensji)
JOIN ksiegowosc.premia AS pre
USING(id_premii)

-- Policz sume wynagrodzen w ramach danego stanowiska
SELECT SUM(pen.kwota + pre.kwota) AS suma_wynagrodzen_ksiegowych
FROM ksiegowosc.pensja AS pen
JOIN ksiegowosc.wynagrodzenie AS wyn
USING(id_pensji)
JOIN ksiegowosc.premia AS pre
USING(id_premii)
WHERE stanowisko = 'ksiegowy'

-- Wyznacz liczbe premii przyznanych dla pracownikow danego stanowiska
SELECT COUNT(id_premii) AS n_premii_ksiegowych
FROM ksiegowosc.wynagrodzenie AS wyn
JOIN ksiegowosc.premia AS pre
USING(id_premii)
JOIN ksiegowosc.pensja AS pen
USING(id_pensji)
WHERE stanowisko = 'ksiegowy'

-- Usun wszystkich pracownikow majacych pensje mniejsza niz 1200 zl
DELETE FROM ksiegowosc.wynagrodzenie
WHERE id_pracownika IN(
SELECT id_pracownika
FROM ksiegowosc.pracownicy AS pra
JOIN ksiegowosc.wynagrodzenie AS wyn
USING(id_pracownika)
JOIN ksiegowosc.pensja AS pen
USING(id_pensji)
WHERE pen.kwota < 6000)
