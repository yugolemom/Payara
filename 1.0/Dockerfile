FROM openshift/base-centos7

MAINTAINER Hugo C. Lima <yugolemom@gmail.com>

ENV ADMIN_USER admin
ENV ADMIN_PASSWORD admin 
ENV PAYARA_PKG https://s3-eu-west-1.amazonaws.com/payara.fish/Payara+Downloads/Payara+4.1.1.171.0.1/payara-web-4.1.1.171.0.1.zip
ENV PAYARA_VERSION 171
ENV PKG_FILE_NAME payara-web-$PAYARA_VERSION.zip
ENV PAYARA_PATH /usr/local/payara41

LABEL io.k8s.description="Payara Server Full" \
      io.k8s.display-name="Payara" \
      io.openshift.expose-services="4848:http,8080:http,8181:http,8888:ping" \
      io.openshift.tags="builder,payara" \
      io.openshift.s2i.destination="/tmp"

# INSTALL JAVA

RUN yum install -y --enablerepo=centosplus unzip wget java-1.8.0-openjdk \ 		java-1.8.0-openjdk-devel
 
# INSTALL PAYARA V 171

RUN mkdir -p $PAYARA_PATH && \
	wget --quiet -O /usr/local/$PKG_FILE_NAME $PAYARA_PKG && \
	unzip -qq /usr/local/$PKG_FILE_NAME -d $PAYARA_PATH && \
	mkdir -p $PAYARA_PATH/deployments && \
	ln -sf $PAYARA_PATH/bin/asadmin /usr/local/bin/asadmin

COPY .s2i/bin/ $STI_SCRIPTS_PATH

USER default
EXPOSE 4848 8009 8080 8181
