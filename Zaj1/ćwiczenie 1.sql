SET search_path to ksiegowosc;

--a)
SELECT p.id_pracownika, p.imie
FROM ksiegowosc.pracownicy p;

--b)
SELECT p.id_pracownika
FROM pracownicy p
         JOIN wynagrodzenie w on w.id_pracownika = p.id_pracownika
         JOIN pensja pe on w.id_pensji = pe.id_pensji
WHERE pe.kwota > 1000;
--c)
SELECT p.id_pracownika
FROM ksiegowosc.pracownicy p
         JOIN ksiegowosc.wynagrodzenie w on p.id_pracownika = w.id_pracownika
         JOIN ksiegowosc.premia pr ON w.id_premii = pr.id_premii
         JOIN pensja pe on w.id_pensji = pe.id_pensji
WHERE pr.kwota = 0 AND pe.kwota > 2000;

--d)
SELECT p.id_pracownika
FROM pracownicy p
WHERE p.imie LIKE 'J%';

--e)
SELECT p.id_pracownika
FROM pracownicy p
WHERE imie LIKE '%a' and p.nazwisko LIKE '%n%';

--f)
SELECT p.imie, p.nazwisko, SUM(g.liczba_godzin) - 160 as nadgodziny
FROM pracownicy p
         JOIN godziny g ON p.id_pracownika = g.id_pracownika
WHERE g.liczba_godzin > 160
GROUP BY p.id_pracownika, p.imie, p.nazwisko
ORDER BY nadgodziny DESC;

--g)
SELECT p.imie, p.nazwisko, pe.kwota as pensja
FROM pracownicy p
         JOIN wynagrodzenie w ON p.id_pracownika = w.id_pracownika
         JOIN pensja pe ON w.id_pensji = pe.id_pensji
WHERE pe.kwota BETWEEN 1500 AND 5000
ORDER BY pe.kwota;

--h)
SELECT p.imie, p.nazwisko
FROM pracownicy p
WHERE p.id_pracownika IN (
    SELECT g.id_pracownika
    FROM godziny g
    GROUP BY g.id_pracownika
    HAVING SUM(g.liczba_godzin) > 160
)
  AND p.id_pracownika IN (
    SELECT w.id_pracownika
    FROM wynagrodzenie w
             JOIN premia pr ON w.id_premii = pr.id_premii
    WHERE pr.kwota = 0
);

--i)
SELECT p.imie, p.nazwisko, pe.kwota as pensja
FROM pracownicy p
         JOIN wynagrodzenie w ON p.id_pracownika = w.id_pracownika
         JOIN pensja pe ON w.id_pensji = pe.id_pensji
ORDER BY pe.kwota DESC;

--j)
SELECT p.imie, p.nazwisko, pe.kwota as pensja, pr.kwota as kwota_premi
FROM pracownicy p
         JOIN wynagrodzenie w ON p.id_pracownika = w.id_pracownika
         JOIN pensja pe ON w.id_pensji = pe.id_pensji
         JOIN premia pr ON w.id_premii = pr.id_premii
ORDER BY pe.kwota DESC, pr.kwota DESC;

--k)
SELECT p.imie, p.nazwisko, pe.stanowisko
FROM pracownicy p
         JOIN wynagrodzenie w ON p.id_pracownika = w.id_pracownika
         JOIN pensja pe ON w.id_pensji = pe.id_pensji
GROUP BY p.imie, p.nazwisko, pe.stanowisko;

--l)
SELECT pe.stanowisko, AVG(pe.kwota) as srednia_placa, MIN(pe.kwota) as minimalna_placa, MAX(pe.kwota) as maksymalna_placa
FROM pensja pe
WHERE pe.stanowisko = 'Manager'
GROUP BY pe.stanowisko;

--m)
SELECT SUM(pe.kwota + pr.kwota) as suma_wszystkich_wynagrodzen
FROM wynagrodzenie w
         JOIN pensja pe ON w.id_pensji = pe.id_pensji
         JOIN premia pr ON w.id_premii = pr.id_premii;

--n)
SELECT pe.stanowisko, SUM(pe.kwota + pr.kwota) as suma_wynagrodzen, COUNT(*) as liczba_pracownikow
FROM wynagrodzenie w
         JOIN pensja pe ON w.id_pensji = pe.id_pensji
         JOIN premia pr ON w.id_premii = pr.id_premii
GROUP BY pe.stanowisko
ORDER BY suma_wynagrodzen DESC;

--o)
SELECT pe.stanowisko, COUNT(pr.id_premii) as liczba_premii, COUNT(CASE WHEN pr.kwota > 0 THEN 1 END) as liczba_premii_niezerowych
FROM wynagrodzenie w
         JOIN pensja pe ON w.id_pensji = pe.id_pensji
         JOIN premia pr ON w.id_premii = pr.id_premii
GROUP BY pe.stanowisko
ORDER BY liczba_premii_niezerowych DESC;

--p)
DELETE FROM pracownicy
WHERE id_pracownika IN (
    SELECT DISTINCT p.id_pracownika
    FROM pracownicy p
             JOIN wynagrodzenie w ON p.id_pracownika = w.id_pracownika
             JOIN pensja pe ON w.id_pensji = pe.id_pensji
    WHERE pe.kwota < 1200
);