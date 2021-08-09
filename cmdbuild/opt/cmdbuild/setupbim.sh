#!/bin/sh

echo "#" >$CONFCMDBUILD/bim.conf 
echo -e "# `date`\n" >>$CONFCMDBUILD/bim.conf 

  cat  >>$CONFCMDBUILD/bim.conf <<-EOF
	password=$BIM_USER_PASSWORD
	url=$BIM_URL
	enabled=$BIM_ENABLED
	username=$BIM_USER_NAME
EOF

