#!/bin/sh

echo "#" >$WEBAPPCMDBUILD/WEB-INF/conf/cmdbf.conf 
echo -e "# `date`\n" >>$WEBAPPCMDBUILD/WEB-INF/conf/cmdbf.conf 

  cat  >>$WEBAPPCMDBUILD/WEB-INF/conf/cmdbf.conf <<-EOF
	mdrid=$CMDBF_MDRID
	schemalocation=$CMDBF_SCHEMALOCATION
EOF

