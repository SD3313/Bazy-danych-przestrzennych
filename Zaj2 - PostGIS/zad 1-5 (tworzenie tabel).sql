--DROP DATABASE IF EXISTS postgis;
--CREATE DATABASE postgis;
--conect to database


\connect postgis;
CREATE SCHEMA IF NOT EXISTS postgis_schema AUTHORIZATION postgres;
SET search_path TO postgis_schema, public;



--3. Dodaj funkcjonalności PostGIS’a do bazy poleceniem CREATE EXTENSION postgis;
CREATE  EXTENSION postgis;

--4. Na podstawie poniższej mapy utwórz trzy tabele: buildings (id, geometry, name), roads
--(id, geometry, name), poi (id, geometry, name).

DROP TABLE IF EXISTS buildings CASCADE;
DROP TABLE IF EXISTS roads CASCADE;
DROP TABLE IF EXISTS poi CASCADE;

CREATE TABLE buildings
(
    id       INTEGER,
    geometry GEOMETRY(POLYGON),
    name     VARCHAR(255)
);

CREATE TABLE roads
(
    id       INTEGER,
    geometry GEOMETRY(LINESTRING),
    name     VARCHAR(255)
);

CREATE TABLE poi
(
    id       INTEGER,
    geometry GEOMETRY(POINT),
    name     VARCHAR(255)
);

--5. Współrzędne obiektów oraz nazwy (np. BuildingA) należy odczytać z mapki umieszczonej
--poniżej. Układ współrzędnych ustaw jako niezdefiniowany.


INSERT INTO buildings (id, geometry, name) VALUES
    (1, ST_GeomFromText('POLYGON((1 1, 1 2, 2 2, 2 1, 1 1))', 0), 'BuildingF'),
    (2, ST_GeomFromText('POLYGON((8 4, 8 1.5, 10.5 1.5, 10.5 4, 8 4))', 0), 'BuildingA'),
    (3, ST_GeomFromText('POLYGON((4 5, 6 5, 6 7, 4 7 , 4 5))', 0), 'BuildingB'),
    (4, ST_GeomFromText('POLYGON((3 6, 5 6, 5 8, 3 8 , 3 6))', 0), 'BuildingC'),
    (5, ST_GeomFromText('POLYGON((9 8, 10 8, 10 9, 9 9 , 9 8))', 0), 'BuildingD');

INSERT INTO roads (id, geometry, name) VALUES
    (1, ST_GeomFromText('LINESTRING(0 4.5, 12 4.5)', 0), 'RoadX'),
    (2, ST_GeomFromText('LINESTRING(7.5 0, 7.5 10.5)', 0), 'RoadY');

INSERT INTO poi (id, geometry, name) VALUES
    (1, ST_GeomFromText('POINT(1 3.5)', 0), 'G'),
    (2, ST_GeomFromText('POINT(5.5 1.5)', 0), 'H'),
    (3, ST_GeomFromText('POINT(9.5 6)', 0), 'I'),
    (4, ST_GeomFromText('POINT(6.5 6)', 0), 'J'),
    (5, ST_GeomFromText('POINT(6 9.5)', 0), 'K');

select * from buildings;

SELECT
    id,
    name,
    ST_Length(geometry) AS length
FROM roads;