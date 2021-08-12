#!/bin/sh


if [ "$DMS_ENABLED" = "true" ] 
then
#$CATALINA_HOME/webapps/cmdbuild/cmdbuild.sh restws setconfig org.cmdbuild.dms.enabled true
$CATALINA_HOME/webapps/cmdbuild/cmdbuild.sh restws setconfig org.cmdbuild.dms.enabled $DMS_ENABLED
#$CATALINA_HOME/webapps/cmdbuild/cmdbuild.sh restws setconfig org.cmdbuild.dms.category.lookup AlfrescoCategory
$CATALINA_HOME/webapps/cmdbuild/cmdbuild.sh restws setconfig org.cmdbuild.dms.category.lookup $DMS_ALFRESCO_LOOKUP
#$CATALINA_HOME/webapps/cmdbuild/cmdbuild.sh restws setconfig org.cmdbuild.dms.service.cmis.user admin
$CATALINA_HOME/webapps/cmdbuild/cmdbuild.sh restws setconfig org.cmdbuild.dms.service.cmis.user $DMS_USER_NAME
#$CATALINA_HOME/webapps/cmdbuild/cmdbuild.sh restws setconfig org.cmdbuild.dms.service.cmis.password admin
$CATALINA_HOME/webapps/cmdbuild/cmdbuild.sh restws setconfig org.cmdbuild.dms.service.cmis.password $DMS_USER_PASSWORD
#$CATALINA_HOME/webapps/cmdbuild/cmdbuild.sh restws setconfig org.cmdbuild.dms.service.cmis.path /User Homes/cmdbuild
$CATALINA_HOME/webapps/cmdbuild/cmdbuild.sh restws setconfig org.cmdbuild.dms.service.cmis.path "$DMS_PATH"
$CATALINA_HOME/webapps/cmdbuild/cmdbuild.sh restws setconfig org.cmdbuild.dms.service.cmis.url $DMS_URL
$CATALINA_HOME/webapps/cmdbuild/cmdbuild.sh restws setconfig org.cmdbuild.dms.service.type cmis
$CATALINA_HOME/webapps/cmdbuild/cmdbuild.sh restws setconfig org.cmdbuild.dms.service.cmis.model $DMS_PRESETS
$CATALINA_HOME/webapps/cmdbuild/cmdbuild.sh restws setconfig org.cmdbuild.dms.delay $DMS_DELAY


#alfresco.custom.model.filename=cmdbuildCustomModel.xml
#metadata.autocompletion.filename=metadataAutocompletion.xml
#alfresco.custom.uri=org.cmdbuild.dms.alfresco
#alfresco.custom.prefix=cmdbuild
else
$CATALINA_HOME/webapps/cmdbuild/cmdbuild.sh restws setconfig org.cmdbuild.dms.enabled false
fi
