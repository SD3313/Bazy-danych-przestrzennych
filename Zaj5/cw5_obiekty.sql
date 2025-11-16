CREATE SCHEMA cw5_bdp;

CREATE EXTENSION postgis;

SET search_path TO cw5_bdp;

DROP TABLE IF EXISTS obiekty;

-- 1)

CREATE TABLE obiekty
(
    name varchar(255),
    geom geometry
);


TRUNCATE TABLE obiekty;

INSERT INTO obiekty(name, geom)
VALUES ('obiekt1',
        ST_CurveToLine(
                ST_GeomFromText(
                        'COMPOUNDCURVE(
                            LINESTRING(0 1, 1 1),
                            CIRCULARSTRING(1 1, 2 0, 3 1),
                            CIRCULARSTRING(3 1, 4 2, 5 1),
                            LINESTRING(5 1, 6 1)
                        )', 0))),

       ('obiekt2', ST_GeomFromText(
               'GEOMETRYCOLLECTION(
               LINESTRING(10 6, 14 6),
               CIRCULARSTRING(14 6, 16 4,14 2),
               CIRCULARSTRING(14 2, 12 0, 12 2),
               LINESTRING(10 2, 10 6),
               CIRCULARSTRING(11 2, 12 3, 12 2),
               CIRCULARSTRING(13 2, 12 1, 11 2))',
               0)),

       ('obiekt3', ST_GeomFromText(
               'LINESTRING(10 17,12 13, 7 15, 10 17)',
               0)),
       ('obiekt4', ST_GeomFromText(
               'LINESTRING(20 20, 25 25, 27 24, 25 22, 26 21, 22 19, 20.5 19.5)', 0)),

       ('obiekt5', ST_GeomFromText('MULTIPOINT Z(38 32 234, 30 30 59)', 0)),

       ('obiekt6', ST_GeomFromText(
               'GEOMETRYCOLLECTION(
               LINESTRING(1 1,3 2),
               POINT(4 2))',
               0));

-- 2)

SELECT ST_Area(ST_Buffer(ST_ShortestLine(
                         (Select geom from obiekty where name = 'obiekt3'),
                         (Select geom from obiekty where name = 'obiekt4')
                         ), 5.0)) as pole_powerzchni;

-- 3)

SELECT ST_MakePolygon( ST_AddPoint(geome.geom, ST_StartPoint(geome.geom)))
    FROM
    (SELECT geom from obiekty where name = 'obiekt4') AS geome;
       --Create a Polygon from an open LineString, using ST_StartPoint and ST_AddPoint to close it.

-- 4)

INSERT INTO obiekty(name, geom)
SELECT 'obiekt7', ST_Collect(obiekt3.geom,obiekt4.geom)
FROM obiekty as obiekt3, obiekty as obiekt4
WHERE obiekt3.name='obiekt3' AND obiekt4.name='obiekt4';

-- 5)

SELECT BezLukow.name ,ST_Area(ST_Buffer(BezLukow.geom, 5.0)) as powierzchnia_bufora
FROM (
    SELECT *
    FROM obiekty
    WHERE ST_HasArc(obiekty.geom) = false
     ) as BezLukow
GROUP BY BezLukow.name, BezLukow.geom
ORDER BY BezLukow.name;


--
SELECT *
FROM obiekty
WHERE ST_HasArc(obiekty.geom) = false