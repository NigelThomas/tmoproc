-- create the SQL function that determines if a lat/lon is within a polygon

!set force on
drop schema "utilities" cascade;
!set force off

create or replace schema "utilities";

set schema '"utilities"';
set path '"utilities"';

create or replace jar "POLYGON"
    LIBRARY 'file:/home/sqlstream/tmoproc/Polygon.jar'
    OPTIONS(0);
    

-- create a function for the contains UDF

CREATE OR REPLACE FUNCTION "polygonContains"
( "polygon" VARCHAR(1024)
, "lon" DOUBLE
, "lat" DOUBLE
) RETURNS BOOLEAN
LANGUAGE JAVA
--PARAMETER STYLE JAVA
--DETERMINISTIC
NO SQL
RETURNS NULL ON NULL INPUT
EXTERNAL NAME '"utilities".POLYGON:com.sqlstream.utilities.geo.Polygon.polygonContains';

CREATE FUNCTION "violation"
( "lon" DOUBLE
, "lat" DOUBLE
) RETURNS VARCHAR(5)
CONTAINS SQL
RETURN CASE "utilities"."polygonContains"('[[-122.168526,47.577074],[-122.168548,47.576584],[-122.167759,47.576121],[-122.16648,47.576989],[-122.164285,47.577159],[-122.16425,47.578726],[-122.164791,47.578893],[-122.168526,47.577074]]',"lon","lat") WHEN true THEN 'true' ELSE 'false' END;



