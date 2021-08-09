#!/bin/sh

echo "#" >$CONFCMDBUILD/workflow.conf 
echo -e "# `date`\n" >>$CONFCMDBUILD/workflow.conf 

cat  >>$CONFCMDBUILD/workflow.conf <<-EOF
	password=$SHARK_USER_PASWORD
	enabled=$SHARK_ENABLED
	disableSynchronizationOfMissingVariables=$SHARK_DISABLE_SYNCHRONIZATION
	enableAddAttachmentOnClosedActivities=$SHARK_ENABLED_ATTACHMENT
	endpoint=$SHARK_URL
EOF
