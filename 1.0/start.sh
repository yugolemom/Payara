#!/bin/bash

# MAINTAINER Hugo C. Lima <yugolemom@gmail.com>

echo "RUN"

echo "CONFIG OK!"

cat <<- EOF > /tmp/tmpfile
AS_ADMIN_PASSWORD=
AS_ADMIN_NEWPASSWORD=$ADMIN_PASSWORD
EOF

cat <<- EOF > /tmp/pwdfile
AS_ADMIN_PASSWORD=$ADMIN_PASSWORD
EOF

asadmin --user=admin --passwordfile=/tmp/tmpfile change-admin-password --domain_name domain1
asadmin --user=admin start-domain 
asadmin --user=admin --passwordfile=/tmp/pwdfile enable-secure-admin 
asadmin --user=admin stop-domain

rm /tmp/tmpfile
rm /tmp/pwdfile

exec "$@"

