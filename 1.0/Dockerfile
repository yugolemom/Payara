FROM openshift/base-centos7

MAINTAINER Hugo C. Lima <yugolemom@gmail.com>

ENV MAVEN_VERSION 3.3.9

ENV ADMIN_USER admin
ENV ADMIN_PASSWORD admin 
ENV PAYARA_PKG https://s3-eu-west-1.amazonaws.com/payara.fish/Payara+Downloads/Payara+4.1.1.171.0.1/payara-web-4.1.1.171.0.1.zip
ENV PAYARA_VERSION 171
ENV PKG_FILE_NAME payara-web-$PAYARA_VERSION.zip
ENV PAYARA_PATH /opt/payara41

LABEL io.k8s.description="Payara Server Full" \
      io.k8s.display-name="Payara" \
      io.openshift.expose-services="8080:http,8888:ping" \
      io.openshift.tags="builder,payara" \
      io.openshift.s2i.destination="/tmp"

# Install Maven

RUN yum install -y --enablerepo=centosplus \
    tar unzip bc which lsof wget java-1.8.0-openjdk java-1.8.0-openjdk-devel && \
    yum clean all -y && \
    (curl -0 https://archive.apache.org/dist/maven/maven-3/$MAVEN_VERSION/binaries/apache-maven-$MAVEN_VERSION-bin.tar.gz | \
    tar -zx -C /usr/local) && \
    ln -sf /usr/local/apache-maven-$MAVEN_VERSION/bin/mvn /usr/local/bin/mvn

# Install Payara

RUN wget --quiet -O /opt/$PKG_FILE_NAME $PAYARA_PKG
RUN unzip -qq /opt/$PKG_FILE_NAME -d /opt

RUN mkdir -p $PAYARA_PATH/deployments
RUN useradd -b /opt -m -s /bin/bash -d $PAYARA_PATH payara && echo payara:payara | chpasswd
RUN chown -R payara:payara /opt


COPY .s2i/bin/ $STI_SCRIPTS_PATH

ENV JAVA_OPTIONS -Xmx512m

USER payara
WORKDIR $PAYARA_PATH

# CRENCIAIS DOS USUARIOS 

RUN echo 'AS_ADMIN_PASSWORD=\n\
AS_ADMIN_NEWPASSWORD='$ADMIN_PASSWORD'\n\
EOF\n'\
>> /opt/tmpfile

RUN echo 'AS_ADMIN_PASSWORD='$ADMIN_PASSWORD'\n\
EOF\n'\
>> /opt/pwdfile

RUN \
 $PAYARA_PATH/bin/asadmin start-domain && \
 $PAYARA_PATH/bin/asadmin --user $ADMIN_USER --passwordfile=/opt/tmpfile change-admin-password && \
 $PAYARA_PATH/bin/asadmin --user $ADMIN_USER --passwordfile=/opt/pwdfile enable-secure-admin && \
$PAYARA_PATH/bin/asadmin restart-domain && \
$PAYARA_PATH/bin/asadmin stop-domain

# LIMPAR

RUN rm /opt/tmpfile
RUN rm /opt/$PKG_FILE_NAME
