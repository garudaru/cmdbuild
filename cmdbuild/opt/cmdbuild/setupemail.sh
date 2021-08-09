#!/bin/sh

echo "#" >$CONFCMDBUILD/email.conf 
echo -e "# `date`\n" >>$CONFCMDBUILD/email.conf 

echo "email.queue.enabled=$EMAIL_QUEUE_ENABLED" >>$CONFCMDBUILD/email.conf 
echo "email.queue.time=$EMAIL_QUEUE_TIME" >>$CONFCMDBUILD/email.conf 
