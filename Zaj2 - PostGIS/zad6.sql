\c postgis;
SET search_path TO postgis_schema, public;


CREATE EXTENSION IF NOT EXISTS postgis;

SELECT sum(ST_Length(geometry))
FROM postgis_schema.roads;


SELECT ST_AsText(geometry)    as wkt,
       ST_Area(geometry)      as pole,
       ST_Perimeter(geometry) as obwod
FROM buildings
WHERE name = 'BuildingA';

SELECT name, st_area(buildings.geometry) as pole
FROM buildings
ORDER BY name;

SELECT name, st_perimeter(geometry) as obwod
FROM (
    SELECT *, st_area(geometry) as pole
    FROM buildings
    ORDER BY pole DESC
    LIMIT 2
) AS buildings;


SELECT ROUND(CAST(ST_Distance(b.geometry, p.geometry) AS numeric), 5) AS najblizsze
FROM buildings b,
     poi p
WHERE b.name = 'BuildingC'
  AND p.name = 'K';


SELECT ST_Area(
               ST_Difference(
                       b1.geometry,
                       ST_Buffer(b2.geometry, 0.5)
               )
       ) as pole_powierzchni
FROM buildings b1,
     buildings b2
WHERE b1.name = 'BuildingC'
  AND b2.name = 'BuildingB';


SELECT b.name
FROM buildings b
WHERE ST_Y(ST_Centroid(b.geometry)) > (
  SELECT MAX(ST_Y(pt.geom))
  FROM (
    SELECT (ST_DumpPoints(r.geometry)).geom AS geom
    FROM roads r
    WHERE r.name = 'RoadX'
  ) AS pt
);


SELECT ST_Area(
    ST_SymDifference(
    b.geometry,
    ST_GeomFromText('POLYGON((4 7, 6 7, 6 8, 4 8, 4 7))'))) as pole_roznic
FROM buildings b
WHERE b.name = 'BuildingC';