#!/bin/sh

echo "#" >$CONFCMDBUILD/auth.conf 
echo -e "# `date`\n" >>$CONFCMDBUILD/auth.conf 
echo "auth.methods=$AUTH_METHOD" >>$CONFCMDBUILD/auth.conf 
echo "force.ws.password.digest=false" >>$CONFCMDBUILD/auth.conf 


$CATALINA_HOME/webapps/cmdbuild/cmdbuild.sh restws setconfig org.cmdbuild.auth.methods $AUTH_METHOD 

echo $AUTH_METHOD | grep LdapAuthenticator
RETVAL="$?"
if [ $RETVAL -eq 0 ] 
then
  if [ $AUTH_LDAP_USE_SSL = "true" ]
  then
    cd $CMDBUILD_START_DIR
    java SSLPoke $AUTH_LDAP_SERVER_ADDRESS $AUTH_LDAP_SERVER_PORT
    RETVAL="$?"
    echo  "SSL LDAP CONNECTION: $RETVAL"
    if [ $RETVAL -eq 1 ] 
    then
    echo  "IMPORT LDAP CERTIFICATE ..."
    cp $JAVA_HOME/jre/lib/security/cacerts ./jssecacerts
    javac InstallCert.java
    java  InstallCert $AUTH_LDAP_SERVER_ADDRESS:$AUTH_LDAP_SERVER_PORT -a
    cp ./jssecacerts $JAVA_HOME/jre/lib/security/cacerts 
    java SSLPoke $AUTH_LDAP_SERVER_ADDRESS $AUTH_LDAP_SERVER_PORT
    echo  "SSL LDAP CONNECTION AFTER IMPORT: $?"
    fi
    cd -
  fi

  $CATALINA_HOME/webapps/cmdbuild/cmdbuild.sh restws setconfig org.cmdbuild.auth.ldap.server.address $AUTH_LDAP_SERVER_ADDRESS
  $CATALINA_HOME/webapps/cmdbuild/cmdbuild.sh restws setconfig org.cmdbuild.auth.ldap.server.port $AUTH_LDAP_SERVER_PORT
  $CATALINA_HOME/webapps/cmdbuild/cmdbuild.sh restws setconfig org.cmdbuild.auth.ldap.use.tls $AUTH_LDAP_USE_SSL
  $CATALINA_HOME/webapps/cmdbuild/cmdbuild.sh restws setconfig org.cmdbuild.auth.ldap.basedn "$AUTH_LDAP_BASEDN"
  $CATALINA_HOME/webapps/cmdbuild/cmdbuild.sh restws setconfig org.cmdbuild.auth.ldap.bind.attribute $AUTH_LDAP_BIND_ATTRIBUTE
  $CATALINA_HOME/webapps/cmdbuild/cmdbuild.sh restws setconfig org.cmdbuild.auth.ldap.search.filter $AUTH_LDAP_SEARCH_FILTER

#  cat  >>$CONFCMDBUILD/auth.conf <<-EOF
#
	##
	## LDAP
	##

#	ldap.server.address=$AUTH_LDAP_SERVER_ADDRESS
#	ldap.server.port=$AUTH_LDAP_SERVER_PORT
#	ldap.use.ssl=$AUTH_LDAP_USE_SSL
#	ldap.basedn=$AUTH_LDAP_BASEDN
#	ldap.bind.attribute=$AUTH_LDAP_BIND_ATTRIBUTE
#	ldap.search.filter=$AUTH_LDAP_SEARCH_FILTER
#
#EOF
   if [ $AUTH_LDAP_SEARCH_AUTH_METHOD = "none" ]
   then
     $CATALINA_HOME/webapps/cmdbuild/cmdbuild.sh restws setconfig org.cmdbuild.auth.ldap.search.auth.method "none"
#     echo "ldap.search.auth.method=none" >>$CONFCMDBUILD/auth.conf
   else 
     $CATALINA_HOME/webapps/cmdbuild/cmdbuild.sh restws setconfig org.cmdbuild.auth.ldap.search.auth.method $AUTH_LDAP_SEARCH_AUTH_METHOD
     $CATALINA_HOME/webapps/cmdbuild/cmdbuild.sh restws setconfig org.cmdbuild.auth.ldap.search.auth.principal "$AUTH_LDAP_SEARCH_AUTH_PRINCIPAL"
     $CATALINA_HOME/webapps/cmdbuild/cmdbuild.sh restws setconfig org.cmdbuild.auth.ldap.search.auth.password $AUTH_LDAP_SEARCH_AUTH_PASSWORD
#     echo "ldap.search.auth.method=simple" >>$CONFCMDBUILD/auth.conf
#     cat  >>$CONFCMDBUILD/auth.conf <<-EOF2
#	ldap.search.auth.method=$AUTH_LDAP_SEARCH_AUTH_METHOD
#	ldap.search.auth.principal=$AUTH_LDAP_SEARCH_AUTH_PRINCIPAL
#	ldap.search.auth.password=$AUTH_LDAP_SEARCH_AUTH_PASSWORD
#EOF2
   fi
fi

echo $AUTH_METHOD | grep CasAuthenticator
RETVAL="$?"
if [ $RETVAL -eq 0 ] 
then
     $CATALINA_HOME/webapps/cmdbuild/cmdbuild.sh restws setconfig org.cmdbuild.auth.cas.server.url $AUTH_CAS_SERVER_URL         
     $CATALINA_HOME/webapps/cmdbuild/cmdbuild.sh restws setconfig org.cmdbuild.auth.cas.login.page $AUTH_CAS_LOGIN_PAGE         
     $CATALINA_HOME/webapps/cmdbuild/cmdbuild.sh restws setconfig org.cmdbuild.auth.cas.service.param $AUTH_CAS_SERVICE_PARAM   
     $CATALINA_HOME/webapps/cmdbuild/cmdbuild.sh restws setconfig org.cmdbuild.auth.cas.ticket.param $AUTH_CAS_TICKET_PARAM     

#     cat  >>$CONFCMDBUILD/auth.conf <<-EOFCAS
#	##
	## CAS
	##

#	cas.server.url=$AUTH_CAS_SERVER_URL
#	cas.login.page=$AUTH_CAS_LOGIN_PAGE
#	cas.service.param=$AUTH_CAS_SERVICE_PARAM
#	cas.ticket.param=$AUTH_CAS_TICKET_PARAM
#EOFCAS

fi

echo $AUTH_METHOD | grep HeaderAuthenticator
RETVAL="$?"
if [ $RETVAL -eq 0 ] 
then
   $CATALINA_HOME/webapps/cmdbuild/cmdbuild.sh restws setconfig org.cmdbuild.auth.header.attribute.name $AUTH_HEADER_ATTRIBUTE_NAME
#   echo "header.attribute.name=$AUTH_HEADER_ATTRIBUTE_NAME" >>$CONFCMDBUILD/auth.conf
fi

echo "END OF SETUP AUTH"

