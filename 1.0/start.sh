#!/bin/bash

# MAINTAINER Hugo C. Lima <yugolemom@gmail.com>

echo "RUN"

echo "CONFIG OK!"

cat <<- EOF > /opt/tmpfile
AS_ADMIN_PASSWORD=
AS_ADMIN_NEWPASSWORD=$ADMIN_PASSWORD
EOF

cat <<- EOF > /opt/pwdfile
AS_ADMIN_PASSWORD=$ADMIN_PASSWORD
EOF


asadmin start-domain 
asadmin --user $ADMIN_USER --passwordfile=/opt/tmpfile change-admin-password
asadmin --user $ADMIN_USER --passwordfile=/opt/pwdfile enable-secure-admin 
asadmin restart-domain

rm /opt/tmpfile
rm /opt/pwdfile
rm /opt/$PKG_FILE_NAME
