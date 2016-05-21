#!/bin/sh

simple ()
{
echo "#" >$WEBAPPCMDBUILD/WEB-INF/conf/dms.conf 
echo "# `date`" >>$WEBAPPCMDBUILD/WEB-INF/conf/dms.conf 

cat  >>$WEBAPPCMDBUILD/WEB-INF/conf/dms.conf <<-EOF
dms.service.cmis.model=alfrescometadata
dms.service.cmis.user=admin
dms.service.cmis.path=/User Homes
dms.service.type=cmis
dms.service.cmis.password=admin
dms.service.cmis.url=http\://alfresco\:8080/alfresco/api/-default-/public/cmis/versions/1.1/atom
#alfresco.custom.model.filename=cmdbuildCustomModel.xml
#metadata.autocompletion.filename=metadataAutocompletion.xml
#alfresco.custom.uri=org.cmdbuild.dms.alfresco
#alfresco.custom.prefix=cmdbuild
category.lookup=AlfrescoCategory
delay=1000
enabled=true
EOF
}

#change: filename paramname to
change ()
{
#  cat $1 | grep $2
  cat $1 | grep "[#\s]*\b$2\s*="
  retval=$?
  if [ $retval -eq 0 ]
  then
    sed -i "s>[#\s]*\b\($2\s*=\s*\).*>\1$3>" $1
#    sed -i "s>\(#*\s*\)\($2\s*=\s*\).*>\2$3>" $1
  else
    echo -e "$2=$3\n" >>$WEBAPPCMDBUILD/WEB-INF/conf/dms.conf 
  fi
}

change $WEBAPPCMDBUILD/WEB-INF/conf/dms.conf dms.service.cmis.model "$DMS_PRESETS"
change $WEBAPPCMDBUILD/WEB-INF/conf/dms.conf dms.service.cmis.user "$DMS_USER_NAME"
change $WEBAPPCMDBUILD/WEB-INF/conf/dms.conf dms.service.cmis.path "$DMS_PATH"
change $WEBAPPCMDBUILD/WEB-INF/conf/dms.conf dms.service.type cmis
change $WEBAPPCMDBUILD/WEB-INF/conf/dms.conf dms.service.cmis.password "$DMS_USER_PASSWORD"
change $WEBAPPCMDBUILD/WEB-INF/conf/dms.conf dms.service.cmis.url "$DMS_URL"
change $WEBAPPCMDBUILD/WEB-INF/conf/dms.conf category.lookup "$DMS_ALFRESCO_LOOKUP"
change $WEBAPPCMDBUILD/WEB-INF/conf/dms.conf delay "$DMS_DELAY"
change $WEBAPPCMDBUILD/WEB-INF/conf/dms.conf enabled "$DMS_ENABLED"

