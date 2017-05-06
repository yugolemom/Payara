FROM centos:7

MAINTAINER Hugo C. Lima <yugolemom@gmail.com>

# INSTALL PAYARA V 171

ENV ADMIN_USER admin \
	ADMIN_PASSWORD admin 

ENV PAYARA_PKG=payara-web-4.1.1.171.0.1.zip \
    PAYARA_URL=https://s3-eu-west-1.amazonaws.com/payara.fish/Payara+Downloads/Payara+4.1.1.171.0.1/payara-web-4.1.1.171.0.1.zip \
    PAYARA_HOME=/opt/payara41 \
    PATH=$PATH:/opt/payara41/bin \
    JAVA_HOME=/usr/lib/jvm/java-openjdk

RUN yum -y install wget unzip java-1.8.0-openjdk-devel && \
    wget --quiet $PAYARA_URL && \
    unzip -o $PAYARA_PKG && \
    rm -f $PAYARA_PKG && \
    yum -y remove wget unzip && rm -rf /var/cache/yum/* && \
    mkdir -p $PAYARA_HOME/scripts && \
    mkdir -p $PAYARA_HOME/deployments

COPY start.sh $PAYARA_HOME/scripts

EXPOSE 4848 8080 8181

RUN $PAYARA_HOME/scripts/start.sh
