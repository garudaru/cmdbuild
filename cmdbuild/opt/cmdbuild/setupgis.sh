#!/bin/sh

old_gis()
{
export APP_CONF=$CONFCMDBUILD/gis.conf

change ()
{
  cat $1 | grep "[#\s]*\b$2\s*="
  retval=$?
  if [ $retval -eq 0 ]
  then
    sed -i "s>[#\s]*\b\($2\s*=\s*\).*>\1$3>" $1
  else
    echo -e "\n$2=$3" >>$APP_CONF
  fi
}

change $APP_CONF enabled "$GIS_ENABLED"
change $APP_CONF geoserver_url "$GIS_URL"
change $APP_CONF center.lon "$GIS_LONGITUDE"
change $APP_CONF center.lat "$GIS_LATITUDE"
change $APP_CONF geoserver "$GIS_GEOSERVER_ONOFF"
change $APP_CONF geoserver_admin_user "$GIS_USER_NAME"
change $APP_CONF geoserver_admin_password "$GIS_USER_PASSWORD"
change $APP_CONF geoserver_workspace "$GIS_GEOSERVER_WORKSPACE"
change $APP_CONF initialZoomLevel "$GIS_INITIALZOOMLEVEL"
change $APP_CONF geoserver_minzoom "$GIS_GEOSERVER_MINZOOM"
change $APP_CONF geoserver_maxzoom "$GIS_GEOSERVER_MAXZOOM"

}

echo "#" >$CONFCMDBUILD/gis.conf 
echo -e "# `date`\n" >>$CONFCMDBUILD/gis.conf 

cat  >>$CONFCMDBUILD/gis.conf <<-EOF
enabled=$GIS_ENABLED
geoserver_url=$GIS_URL                      
center.lon= $GIS_LONGITUDE                   
center.lat=$GIS_LATITUDE                    
geoserver=$GIS_GEOSERVER_ONOFF              
geoserver_admin_user=$GIS_USER_NAME         
geoserver_admin_password=$GIS_USER_PASSWORD 
geoserver_workspace=$GIS_GEOSERVER_WORKSPACE
initialZoomLevel=$GIS_INITIALZOOMLEVEL      
geoserver_minzoom=$GIS_GEOSERVER_MINZOOM    
geoserver_maxzoom=$GIS_GEOSERVER_MAXZOOM    
EOF

