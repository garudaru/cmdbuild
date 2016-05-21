#!/bin/sh

echo "#" >$WEBAPPCMDBUILD/WEB-INF/conf/workflow.conf 
echo -e "# `date`\n" >>$WEBAPPCMDBUILD/WEB-INF/conf/workflow.conf 

cat  >>$WEBAPPCMDBUILD/WEB-INF/conf/workflow.conf <<-EOF
	password=$SHARK_USER_PASWORD
	enabled=$SHARK_ENABLED
	disableSynchronizationOfMissingVariables=$SHARK_DISABLE_SYNCHRONIZATION
	enableAddAttachmentOnClosedActivities=$SHARK_ENABLED_ATTACHMENT
	endpoint=$SHARK_URL
EOF
