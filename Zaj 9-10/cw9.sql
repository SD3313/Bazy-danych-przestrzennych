CREATE EXTENSION postgis;
CREATE EXTENSION postgis_raster;

SELECT * FROM exports;

CREATE TABLE unia AS
SELECT ST_UNION(unia)
FROM exports;