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
, "lat" DOUBLE
, "lon" DOUBLE
) RETURNS BOOLEAN
LANGUAGE JAVA
--PARAMETER STYLE JAVA
--DETERMINISTIC
NO SQL
RETURNS NULL ON NULL INPUT
EXTERNAL NAME '"utilities".POLYGON:com.sqlstream.utilities.geo.Polygon.polygonContains';
