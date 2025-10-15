SET search_path to ksiegowosc;

INSERT INTO pracownicy (imie, nazwisko, adres, telefon) VALUES
                                                            ('Jan', 'Kowalski', 'Warszawa, ul. Polna 10', '501123456'),
                                                            ('Anna', 'Nowak', 'Kraków, ul. Lipowa 3', '502987654'),
                                                            ('Piotr', 'Wiśniewski', 'Gdańsk, ul. Morska 5', '503111222'),
                                                            ('Ewa', 'Wójcik', 'Poznań, ul. Słoneczna 12', '504333444'),
                                                            ('Marek', 'Kaczmarek', 'Łódź, ul. Zielona 7', '505555666'),
                                                            ('Agnieszka', 'Mazur', 'Wrocław, ul. Ogrodowa 2', '506777888'),
                                                            ('Tomasz', 'Krawczyk', 'Katowice, ul. Wiosny Ludów 9', '507999000'),
                                                            ('Katarzyna', 'Zielińska', 'Szczecin, ul. Jasna 1', '508222333'),
                                                            ('Paweł', 'Szymański', 'Bydgoszcz, ul. Dworcowa 6', '509444555'),
                                                            ('Magdalena', 'Woźniak', 'Lublin, ul. Krótka 8', '510666777');

DROP TABLE godziny;

INSERT INTO godziny (id_pracownika, liczba_godzin, data) VALUES
                                                             (1, 108,  '2025-10-01'),
                                                             (2, 170,  '2025-10-01'),
                                                             (3, 160,  '2025-10-02'),
                                                             (4, 18,  '2025-10-02'),
                                                             (5, 105,  '2025-10-03'),
                                                             (6, 180,  '2025-10-03'),
                                                             (7, 107,  '2025-10-04'),
                                                             (8, 108,  '2025-10-04'),
                                                             (9, 160,  '2025-10-05'),
                                                             (10, 158, '2025-10-05');


INSERT INTO pensja (stanowisko, kwota) VALUES
                                           ('Księgowy', 5500.00),
                                           ('Asystent', 4000.00),
                                           ('Manager', 8000.00),
                                           ('Specjalista IT', 9000.00),
                                           ('Magazynier', 4500.00),
                                           ('Kierowca', 4800.00),
                                           ('HR', 6000.00),
                                           ('Kadrowy', 5200.00),
                                           ('Sprzedawca', 4200.00),
                                           ('Sekretarka', 3900.00);


INSERT INTO premia (rodzaj, kwota) VALUES
                                       ('Brak', 0.00),
                                       ('Frekwencja', 300.00),
                                       ('Wydajność', 500.00),
                                       ('Projekt specjalny', 1000.00),
                                       ('Staż pracy', 200.00),
                                       ('Świąteczna', 800.00),
                                       ('Uznaniowa', 700.00),
                                       ('Motywacyjna', 600.00),
                                       ('Zespołowa', 400.00),
                                       ('Bez premii', 0.00);

INSERT INTO wynagrodzenie (data, id_pracownika, id_godziny, id_pensji, id_premii) VALUES
                                                                                      ('2025-10-10', 1, 1, 1, 2),
                                                                                      ('2025-10-10', 2, 2, 2, 1),
                                                                                      ('2025-10-10', 3, 3, 3, 3),
                                                                                      ('2025-10-10', 4, 4, 4, 4),
                                                                                      ('2025-10-10', 5, 5, 5, 5),
                                                                                      ('2025-10-10', 6, 6, 6, 1),
                                                                                      ('2025-10-10', 7, 7, 7, 7),
                                                                                      ('2025-10-10', 8, 8, 8, 8),
                                                                                      ('2025-10-10', 9, 9, 9, 9),
                                                                                      ('2025-10-10', 10, 10, 10, 10);