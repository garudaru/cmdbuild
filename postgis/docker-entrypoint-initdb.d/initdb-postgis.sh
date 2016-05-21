#!/bin/sh

echo on
#exit

export PGUSER=postgres
POSTGRES="gosu postgres"
POSTGIS_DIR="/usr/share/postgresql/contrib/postgis-2.2"
#POSTGIS_DIR="/usr/share/postgresql/$PG_MAJOR/contrib/postgis-2.2"
#DBASE_NAME="cmdbuild"
export DBASE_NAME="$POSTGRES_DB"
#$POSTGRES createdb $DBASE_NAME

echo "STEP NEXT ..."

if [ 1 = 2 ]
then

$POSTGRES psql -d $DBASE_NAME <<EOSQL
CREATE SCHEMA gis;
SET SEARCH_PATH TO gis, public; 
\i ${POSTGIS_DIR}/postgis.sql; 
\i ${POSTGIS_DIR}/spatial_ref_sys.sql;
\i ${POSTGIS_DIR}/legacy.sql;
ALTER DATABASE ${DBASE_NAME} SET search_path="\$user", public, gis; 
DROP TABLE gis.geometry_columns; 
DROP TABLE gis.spatial_ref_sys;
EOSQL

echo "OLD METHOD NEXT ..."

else



$POSTGRES psql <<EOSQL1
-- $ psql template1
\c template1
CREATE DATABASE template_postgis WITH template = template1;
 
-- set the 'datistemplate' record in the 'pg_database' table for
-- 'template_postgis' to TRUE indicating its a template
UPDATE pg_database SET datistemplate = TRUE WHERE datname = 'template_postgis';
\c template_postgis

create schema gis;
SET SEARCH_PATH TO gis; 
grant all on schema gis to public;

CREATE EXTENSION postgis with schema gis;
CREATE EXTENSION postgis_topology with schema gis;
\i ${POSTGIS_DIR}/legacy.sql;
 
-- in a production environment you may want to 
-- give role based permissions, but granting all for now
GRANT ALL ON geometry_columns TO PUBLIC;
GRANT ALL ON geography_columns TO PUBLIC;
GRANT ALL ON raster_columns TO PUBLIC;
GRANT ALL ON raster_overviews TO PUBLIC;
GRANT ALL ON spatial_ref_sys TO PUBLIC; 

alter database template_postgis set search_path="\$usr", public,gis, topology;

-- vacuum freeze: it will guarantee that all rows in the database are
-- "frozen" and will not be subject to transaction ID wraparound
-- problems.
VACUUM FREEZE;

-- UPDATE pg_database SET datallowconn = FALSE WHERE datname = 'template_postgis';

-- Now non-superuser’s can create postgis db’s using template_postgis:
-- $ createdb -h host-name my_gisdb -W -T template_postgis
EOSQL1


#$POSTGRES psql -d $DBASE_NAME <<EOSQL1
#create schema gis;
#SET SEARCH_PATH TO gis; 
#grant all on schema gis to public;
#create extension postgis with schema gis;
#CREATE EXTENSION postgis_topology with schema gis;
#\i /usr/share/postgresql/9.3/contrib/postgis-2.2/legacy.sql;
#alter database $DBASE_NAME set search_path="\$usr", public,gis, topology;
#EOSQL1

echo "NEW METHOD NEXT ..."

fi
