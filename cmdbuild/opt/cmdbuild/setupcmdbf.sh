#!/bin/sh

echo "#" >$CONFCMDBUILD/cmdbf.conf 
echo -e "# `date`\n" >>$CONFCMDBUILD/cmdbf.conf 

  cat  >>$CONFCMDBUILD/cmdbf.conf <<-EOF
	mdrid=$CMDBF_MDRID
	schemalocation=$CMDBF_SCHEMALOCATION
EOF

