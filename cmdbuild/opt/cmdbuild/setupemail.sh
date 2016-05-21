#!/bin/sh

echo "#" >$WEBAPPCMDBUILD/WEB-INF/conf/email.conf 
echo -e "# `date`\n" >>$WEBAPPCMDBUILD/WEB-INF/conf/email.conf 

echo "email.queue.enabled=$EMAIL_QUEUE_ENABLED" >>$WEBAPPCMDBUILD/WEB-INF/conf/email.conf 
echo "email.queue.time=$EMAIL_QUEUE_TIME" >>$WEBAPPCMDBUILD/WEB-INF/conf/email.conf 
