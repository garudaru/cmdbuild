#!/bin/sh

echo "#" >$WEBAPPCMDBUILD/WEB-INF/conf/auth.conf 
echo -e "# `date`\n" >>$WEBAPPCMDBUILD/WEB-INF/conf/auth.conf 
echo "auth.methods=$AUTH_METHOD" >>$WEBAPPCMDBUILD/WEB-INF/conf/auth.conf 
echo "force.ws.password.digest=false" >>$WEBAPPCMDBUILD/WEB-INF/conf/auth.conf 

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
  cat  >>$WEBAPPCMDBUILD/WEB-INF/conf/auth.conf <<-EOF

	##
	## LDAP
	##

	ldap.server.address=$AUTH_LDAP_SERVER_ADDRESS
	ldap.server.port=$AUTH_LDAP_SERVER_PORT
	ldap.use.ssl=$AUTH_LDAP_USE_SSL
	ldap.basedn=$AUTH_LDAP_BASEDN
	ldap.bind.attribute=$AUTH_LDAP_BIND_ATTRIBUTE
	ldap.search.filter=$AUTH_LDAP_SEARCH_FILTER

EOF
   if [ $AUTH_LDAP_SEARCH_AUTH_METHOD = "none" ]
   then
     echo "ldap.search.auth.method=none" >>$WEBAPPCMDBUILD/WEB-INF/conf/auth.conf
   else 
#     echo "ldap.search.auth.method=simple" >>$WEBAPPCMDBUILD/WEB-INF/conf/auth.conf
     cat  >>$WEBAPPCMDBUILD/WEB-INF/conf/auth.conf <<-EOF2
	ldap.search.auth.method=$AUTH_LDAP_SEARCH_AUTH_METHOD
	ldap.search.auth.principal=$AUTH_LDAP_SEARCH_AUTH_PRINCIPAL
	ldap.search.auth.password=$AUTH_LDAP_SEARCH_AUTH_PASSWORD
EOF2
   fi
fi

echo $AUTH_METHOD | grep CasAuthenticator
RETVAL="$?"
if [ $RETVAL -eq 0 ] 
then
     cat  >>$WEBAPPCMDBUILD/WEB-INF/conf/auth.conf <<-EOFCAS
	##
	## CAS
	##

	cas.server.url=$AUTH_CAS_SERVER_URL
	cas.login.page=$AUTH_CAS_LOGIN_PAGE
	cas.service.param=$AUTH_CAS_SERVICE_PARAM
	cas.ticket.param=$AUTH_CAS_TICKET_PARAM
EOFCAS

fi

echo $AUTH_METHOD | grep HeaderAuthenticator
RETVAL="$?"
if [ $RETVAL -eq 0 ] 
then
   echo "header.attribute.name=$AUTH_HEADER_ATTRIBUTE_NAME" >>$WEBAPPCMDBUILD/WEB-INF/conf/auth.conf
fi

echo "END OF SETUP AUTH"

