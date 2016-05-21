#!/bin/sh

echo "#" >$WEBAPPCMDBUILD/WEB-INF/conf/bim.conf 
echo -e "# `date`\n" >>$WEBAPPCMDBUILD/WEB-INF/conf/bim.conf 

  cat  >>$WEBAPPCMDBUILD/WEB-INF/conf/bim.conf <<-EOF
	password=$BIM_USER_PASSWORD
	url=$BIM_URL
	enabled=$BIM_ENABLED
	username=$BIM_USER_NAME
EOF

