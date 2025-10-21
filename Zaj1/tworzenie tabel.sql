CREATE SCHEMA IF NOT EXISTS ksiegowosc AUTHORIZATION postgres;
SET search_path TO ksiegowosc;

DROP TABLE IF EXISTS wynagrodzenie CASCADE;
DROP TABLE IF EXISTS godziny CASCADE;
DROP TABLE IF EXISTS premia CASCADE;
DROP TABLE IF EXISTS pensja CASCADE;
DROP TABLE IF EXISTS pracownicy CASCADE;

CREATE TABLE pracownicy
(
    id_pracownika INTEGER GENERATED ALWAYS AS IDENTITY
        CONSTRAINT pracownicy_pk PRIMARY KEY,
    imie          VARCHAR(100),
    nazwisko      VARCHAR(100),
    adres         VARCHAR(255),
    telefon       VARCHAR(20)
);

ALTER TABLE pracownicy OWNER TO postgres;

CREATE TABLE godziny
(
    id_godziny    INTEGER GENERATED ALWAYS AS IDENTITY
        CONSTRAINT godziny_pk PRIMARY KEY,
    id_pracownika INTEGER
        CONSTRAINT id_pracownika REFERENCES pracownicy,
    liczba_godzin INTEGER,
    data          DATE
);

ALTER TABLE godziny OWNER TO postgres;

CREATE TABLE pensja
(
    id_pensji  INTEGER GENERATED ALWAYS AS IDENTITY
        CONSTRAINT id_pensji PRIMARY KEY,
    stanowisko VARCHAR,
    kwota      DOUBLE PRECISION
);

ALTER TABLE pensja OWNER TO postgres;

CREATE TABLE premia
(
    id_premii INTEGER GENERATED ALWAYS AS IDENTITY
        CONSTRAINT premia_pk PRIMARY KEY,
    rodzaj    VARCHAR,
    kwota     DOUBLE PRECISION
);

ALTER TABLE premia OWNER TO postgres;

CREATE TABLE wynagrodzenie
(
    id_wynagrodzenia INTEGER GENERATED ALWAYS AS IDENTITY
        CONSTRAINT wynagrodzenie_pk PRIMARY KEY,
    data             DATE,
    id_pracownika    INTEGER
        CONSTRAINT id_pracownika_wyn REFERENCES pracownicy,
    id_godziny       INTEGER
        CONSTRAINT id_godziny_wyn REFERENCES godziny,
    id_pensji        INTEGER
        CONSTRAINT id_pensji_wyn REFERENCES pensja,
    id_premii        INTEGER
        CONSTRAINT id_premii_wyn REFERENCES premia
);

ALTER TABLE wynagrodzenie OWNER TO postgres;
